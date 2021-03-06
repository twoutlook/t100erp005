#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:11(2014-07-21 15:03:11), PR版次:0011(2016-11-28 14:34:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000087
#+ Filename...: axrq340
#+ Description: 帳款沖銷明細查詢作業
#+ Creator....: 02599(2014-07-18 14:52:59)
#+ Modifier...: 02599 -SD/PR- 01727
 
{</section>}
 
{<section id="axrq340.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#7    2016/02/24   By yangtt     增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite
#141219-00032#1    2016/03/21   by 07673      修改BUG
#160318-00005#52   2016/03/29   By 07959      將重複內容的錯誤訊息置換為公用錯誤訊息
#160125-00005#9    2016/08/02   By 01727      查詢時加上帳套人員權限條件過濾
#160811-00009#2    2016/08/17   By 01531      账务中心/法人/账套权限控管
#161021-00050#5    2016/10/26   By 08729      處理組織開窗
#161111-00049#8    2016/11/28 By 01727     控制组权限修改

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
PRIVATE TYPE type_g_xrcb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   xrca057 LIKE xrca_t.xrca057, 
   xrca057_desc LIKE type_t.chr500, 
   xrcborga LIKE xrcb_t.xrcborga, 
   xrcborga_desc LIKE type_t.chr500, 
   xrca001 LIKE xrca_t.xrca001, 
   xrcb002 LIKE xrcb_t.xrcb002, 
   xrcb100 LIKE type_t.chr10, 
   xrcc003 LIKE xrcc_t.xrcc003, 
   xrcc108 LIKE type_t.num20_6, 
   xrcc118 LIKE type_t.num20_6, 
   xrca007 LIKE xrca_t.xrca007, 
   xrca007_desc LIKE type_t.chr500, 
   xrcb008 LIKE xrcb_t.xrcb008, 
   xrca014 LIKE xrca_t.xrca014, 
   xrca014_desc LIKE type_t.chr500, 
   xrcb010 LIKE xrcb_t.xrcb010, 
   xrcb010_desc LIKE type_t.chr500, 
   xrcadocno LIKE xrca_t.xrcadocno 
       END RECORD
PRIVATE TYPE type_g_xrcb2_d RECORD
       flag LIKE type_t.chr500, 
   xrdadocdt LIKE type_t.chr500, 
   xrdadocno LIKE type_t.chr20, 
   xrce002 LIKE type_t.chr10, 
   xrce100 LIKE type_t.chr10, 
   xrce109 LIKE type_t.num20_6, 
   xrce119 LIKE type_t.num20_6, 
   xrda005 LIKE type_t.chr10, 
   xrda005_desc LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_xrcb3_d RECORD
       nmbadocdt LIKE type_t.dat, 
   xrce006 LIKE type_t.chr20, 
   nmbb004 LIKE type_t.chr10, 
   nmbb006 LIKE type_t.num20_6, 
   nmbb030 LIKE type_t.chr20, 
   nmbb031 LIKE type_t.dat, 
   nmbb040 LIKE type_t.chr1, 
   nmbb042 LIKE type_t.chr1, 
   nmbb003 LIKE type_t.chr500, 
   nmbb053 LIKE type_t.chr500, 
   nmbb026 LIKE type_t.chr500, 
   xrce003 LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xrcald             LIKE xrca_t.xrcald
DEFINE g_wc_qbe             STRING
DEFINE l_ac2                LIKE type_t.num5 
DEFINE l_ac3                LIKE type_t.num5 
DEFINE g_sql_ctrl           STRING                #151231-00010#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xrcb_d
DEFINE g_master_t                   type_g_xrcb_d
DEFINE g_xrcb_d          DYNAMIC ARRAY OF type_g_xrcb_d
DEFINE g_xrcb_d_t        type_g_xrcb_d
DEFINE g_xrcb2_d   DYNAMIC ARRAY OF type_g_xrcb2_d
DEFINE g_xrcb2_d_t type_g_xrcb2_d
 
DEFINE g_xrcb3_d   DYNAMIC ARRAY OF type_g_xrcb3_d
DEFINE g_xrcb3_d_t type_g_xrcb3_d
 
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq340.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#8 Add
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
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#8 Mark
  #161111-00049#8 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#8 Add  ---(E)---
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
   DECLARE axrq340_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq340_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq340_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq340 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq340_init()   
 
      #進入選單 Menu (="N")
      CALL axrq340_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq340
      
   END IF 
   
   CLOSE axrq340_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq340.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq340_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_pass       LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_xrca001','8302') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('flag','8333')
   CALL cl_set_combo_scc('xrce002','8306')
   CALL cl_set_combo_scc('xrce006','8310')
   CALL axrq340_default()
   CALL axrq340_set_xrcb001_scc()
   CALL cl_set_comp_visible("xrcborga_desc,xrca007_desc,xrca014_desc,xrcb010_desc",FALSE)
   #end add-point
 
   CALL axrq340_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq340.default_search" >}
PRIVATE FUNCTION axrq340_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrcbseq = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq340_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
 
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq340_b_fill()
   ELSE
      CALL axrq340_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrcb_d.clear()
         CALL g_xrcb2_d.clear()
 
         CALL g_xrcb3_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq340_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrcb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq340_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq340_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL axrq340_b_fill2()
               CALL axrq340_b_fill3()
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_xrcb2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_xrcb2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xrcb3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_xrcb3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               LET l_ac3=g_detail_idx2
               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq340_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
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
               CALL axrq340_query()
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq340_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axrq340_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrcb_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xrcb2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_xrcb3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq340_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq340_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq340_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq340_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrcb_d.getLength()
               LET g_xrcb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrcb_d.getLength()
               LET g_xrcb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrcb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrcb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrcb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrcb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  INITIALIZE la_param.* TO NULL
                  CASE 
                     WHEN g_xrcb_d[g_detail_idx].xrca001='12'
                        LET la_param.prog = 'axrt300'
                     WHEN g_xrcb_d[g_detail_idx].xrca001='11'
                        LET la_param.prog = 'axrt310' 
                     WHEN g_xrcb_d[g_detail_idx].xrca001='01' OR g_xrcb_d[g_detail_idx].xrca001='02'
                        LET la_param.prog = 'axrt320'
                     WHEN g_xrcb_d[g_detail_idx].xrca001='19' 
                        LET la_param.prog = 'axrt330'   
                     WHEN g_xrcb_d[g_detail_idx].xrca001='22' OR g_xrcb_d[g_detail_idx].xrca001='29'
                        OR g_xrcb_d[g_detail_idx].xrca001='21'
                        LET la_param.prog = 'axrt340'                        
                  END CASE
                  LET la_param.param[1] = g_xrcald
                  LET la_param.param[2] = g_xrcb_d[g_detail_idx].xrcadocno         
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)                    
               END IF
               EXIT DIALOG
            END IF
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq340_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glaastus    LIKE glaa_t.glaastus
   DEFINE l_ld_str      STRING                #160125-00005#9 Add
   DEFINE l_glaa008     LIKE glaa_t.glaa008   #160811-00009#2 
   DEFINE l_glaa014     LIKE glaa_t.glaa014   #160811-00009#2 
   DEFINE l_ooef017     LIKE ooef_t.ooef017   #161111-00049#8 Add
   
   
   CALL cl_set_comp_visible("xrcborga_desc,xrca007_desc,xrca014_desc,xrcb010_desc",FALSE)
   CALL cl_set_comp_visible("b_xrcborga,b_xrca007,b_xrca014,b_xrcb010",TRUE)
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrcb_d.clear()
   CALL g_xrcb2_d.clear()
 
   CALL g_xrcb3_d.clear()
 
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xrca057,xrcborga,xrca001,xrcb002,xrcc003,xrca007,xrcb008,xrca014,xrcb010, 
          xrcadocno
           FROM s_detail1[1].b_xrca057,s_detail1[1].b_xrcborga,s_detail1[1].b_xrca001,s_detail1[1].b_xrcb002, 
               s_detail1[1].b_xrcc003,s_detail1[1].b_xrca007,s_detail1[1].b_xrcb008,s_detail1[1].b_xrca014, 
               s_detail1[1].b_xrcb010,s_detail1[1].b_xrcadocno
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_xrca057>>----
         #Ctrlp:construct.c.page1.b_xrca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca057
            #add-point:ON ACTION controlp INFIELD b_xrca057 name="construct.c.page1.b_xrca057"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca057 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca057 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xrca057()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca057  #顯示到畫面上
            NEXT FIELD b_xrca057                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca057
            #add-point:BEFORE FIELD b_xrca057 name="construct.b.page1.b_xrca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca057
            
            #add-point:AFTER FIELD b_xrca057 name="construct.a.page1.b_xrca057"
            
            #END add-point
            
 
 
         #----<<xrca057_desc>>----
         #----<<b_xrcborga>>----
         #Ctrlp:construct.c.page1.b_xrcborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcborga
            #add-point:ON ACTION controlp INFIELD b_xrcborga name="construct.c.page1.b_xrcborga"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' " #161021-00050#5 add
            CALL q_ooef001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcborga  #顯示到畫面上
            NEXT FIELD b_xrcborga                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcborga
            #add-point:BEFORE FIELD b_xrcborga name="construct.b.page1.b_xrcborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcborga
            
            #add-point:AFTER FIELD b_xrcborga name="construct.a.page1.b_xrcborga"
            
            #END add-point
            
 
 
         #----<<xrcborga_desc>>----
         #----<<b_xrca001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca001
            #add-point:BEFORE FIELD b_xrca001 name="construct.b.page1.b_xrca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca001
            
            #add-point:AFTER FIELD b_xrca001 name="construct.a.page1.b_xrca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca001
            #add-point:ON ACTION controlp INFIELD b_xrca001 name="construct.c.page1.b_xrca001"
            
            #END add-point
 
 
         #----<<b_xrcb002>>----
         #Ctrlp:construct.c.page1.b_xrcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb002
            #add-point:ON ACTION controlp INFIELD b_xrcb002 name="construct.c.page1.b_xrcb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xrcb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcb002  #顯示到畫面上
            NEXT FIELD b_xrcb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcb002
            #add-point:BEFORE FIELD b_xrcb002 name="construct.b.page1.b_xrcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcb002
            
            #add-point:AFTER FIELD b_xrcb002 name="construct.a.page1.b_xrcb002"
            
            #END add-point
            
 
 
         #----<<b_xrcb100>>----
         #----<<b_xrcc003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcc003
            #add-point:BEFORE FIELD b_xrcc003 name="construct.b.page1.b_xrcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcc003
            
            #add-point:AFTER FIELD b_xrcc003 name="construct.a.page1.b_xrcc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcc003
            #add-point:ON ACTION controlp INFIELD b_xrcc003 name="construct.c.page1.b_xrcc003"
            
            #END add-point
 
 
         #----<<xrcc108>>----
         #----<<xrcc118>>----
         #----<<b_xrca007>>----
         #Ctrlp:construct.c.page1.b_xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca007
            #add-point:ON ACTION controlp INFIELD b_xrca007 name="construct.c.page1.b_xrca007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca007  #顯示到畫面上
            NEXT FIELD b_xrca007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca007
            #add-point:BEFORE FIELD b_xrca007 name="construct.b.page1.b_xrca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca007
            
            #add-point:AFTER FIELD b_xrca007 name="construct.a.page1.b_xrca007"
            
            #END add-point
            
 
 
         #----<<xrca007_desc>>----
         #----<<b_xrcb008>>----
         #Ctrlp:construct.c.page1.b_xrcb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb008
            #add-point:ON ACTION controlp INFIELD b_xrcb008 name="construct.c.page1.b_xrcb008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrcb008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcb008  #顯示到畫面上
            NEXT FIELD b_xrcb008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcb008
            #add-point:BEFORE FIELD b_xrcb008 name="construct.b.page1.b_xrcb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcb008
            
            #add-point:AFTER FIELD b_xrcb008 name="construct.a.page1.b_xrcb008"
            
            #END add-point
            
 
 
         #----<<b_xrca014>>----
         #Ctrlp:construct.c.page1.b_xrca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca014
            #add-point:ON ACTION controlp INFIELD b_xrca014 name="construct.c.page1.b_xrca014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca014  #顯示到畫面上
            NEXT FIELD b_xrca014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrca014
            #add-point:BEFORE FIELD b_xrca014 name="construct.b.page1.b_xrca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrca014
            
            #add-point:AFTER FIELD b_xrca014 name="construct.a.page1.b_xrca014"
            
            #END add-point
            
 
 
         #----<<xrca014_desc>>----
         #----<<b_xrcb010>>----
         #Ctrlp:construct.c.page1.b_xrcb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb010
            #add-point:ON ACTION controlp INFIELD b_xrcb010 name="construct.c.page1.b_xrcb010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗  #161021-00050#5 mark
            CALL q_ooeg001_4()                                    #161021-00050#5 add
            DISPLAY g_qryparam.return1 TO b_xrcb010  #顯示到畫面上
            NEXT FIELD b_xrcb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcb010
            #add-point:BEFORE FIELD b_xrcb010 name="construct.b.page1.b_xrcb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcb010
            
            #add-point:AFTER FIELD b_xrcb010 name="construct.a.page1.b_xrcb010"
            
            #END add-point
            
 
 
         #----<<xrcb010_desc>>----
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.page1.b_xrcadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            LET g_qryparam.where = g_qryparam.where ," AND xrcald = '",g_xrcald,"'"   #161111-00049#8 Add
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            NEXT FIELD b_xrcadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrcadocno
            #add-point:BEFORE FIELD b_xrcadocno name="construct.b.page1.b_xrcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrcadocno
            
            #add-point:AFTER FIELD b_xrcadocno name="construct.a.page1.b_xrcadocno"
            
            #END add-point
            
 
 
         #----<<flag>>----
         #----<<xrdadocdt>>----
         #----<<xrdadocno>>----
         #----<<xrce002>>----
         #----<<xrce100>>----
         #----<<xrce109>>----
         #----<<xrce119>>----
         #----<<xrda005>>----
         #----<<xrda005_desc>>----
         #----<<nmbadocdt>>----
         #----<<xrce006>>----
         #----<<nmbb004>>----
         #----<<nmbb006>>----
         #----<<nmbb030>>----
         #----<<nmbb031>>----
         #----<<nmbb040>>----
         #----<<nmbb042>>----
         #----<<nmbb003>>----
         #----<<nmbb053>>----
         #----<<nmbb026>>----
         #----<<xrce003>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_xrcald FROM xrcald
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL axrq340_xrcald_desc()
            
      AFTER FIELD xrcald
         IF NOT cl_null(g_xrcald) THEN
            LET g_errno = ''
            #SELECT glaastus INTO l_glaastus FROM glaa_t                                     #160811-00009#2  mark
            SELECT glaastus,glaa008,glaa014 INTO l_glaastus,l_glaa008,l_glaa014 FROM glaa_t  #160811-00009#2 add
             WHERE glaaent = g_enterprise AND glaald = g_xrcald
            CASE
               WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
#               WHEN l_glaastus = 'N'      LET g_errno = 'agl-00051' #160318-00005#52  mark
               WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#52  add
               WHEN l_glaa008 = 'N' AND l_glaa014 = 'N' LET g_errno = 'axr-00021'  #160811-00009#2  add
              
            END CASE
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_xrcald
               #160318-00005#52 --s add
               CASE g_errno
                  WHEN 'sub-01302'
                     LET g_errparam.replace[1] = 'agli010'
                     LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                     LET g_errparam.exeprog = 'agli010'
               END CASE
               #160318-00005#52 --e add
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET g_xrcald = ''
               DISPLAY '','' TO xrcald_desc,xrcacomp
               NEXT FIELD xrcald
            END IF

            #160125-00005#9 Add  ---(S)---
            LET g_errno = ''
            CALL s_fin_account_center_with_ld_chk('',g_xrcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_xrcald = ''
               DISPLAY '','' TO xrcald_desc,xrcacomp
               NEXT FIELD xrcald
            END IF
            #160125-00005#9 Add  ---(E)---

            CALL axrq340_xrcald_desc()
            #161111-00049#8 Add  ---(S)---
            SELECT glaacomp INTO l_ooef017 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_xrcald
            CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017)
               RETURNING g_sub_success,g_sql_ctrl 
            #161111-00049#8 Add  ---(E)---
         END IF
      
      ON ACTION controlp INFIELD xrcald
            CALL s_axrt300_get_site(g_user,"",'2') RETURNING l_ld_str   #160125-00005#9 Add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcald             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
			   #LET g_qryparam.where = l_ld_str CLIPPED        #160125-00005#9 Add              #160811-00009#2 mark
			   LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"  #160811-00009#2 add
            CALL q_authorised_ld()                         #呼叫開窗

            LET g_xrcald = g_qryparam.return1              
            DISPLAY g_xrcald TO xrcald
            CALL axrq340_xrcald_desc()
            NEXT FIELD xrcald                          #返回原欄位
            
      END INPUT
      
      CONSTRUCT g_wc_qbe ON xrca057,xrca007,xrcb001,xrcadocno,xrcb002,xrcb008,xrca014,xrcb010,xrca063
           FROM xrca057,xrca007,xrcb001,xrcadocno,xrcb002,xrcb008,xrca014,xrcb010,xrca063
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD xrca057
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca057 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca057 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xrca057()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca057  #顯示到畫面上
            NEXT FIELD xrca057                   #返回原欄位
            
         ON ACTION controlp INFIELD xrca007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3111"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca007  #顯示到畫面上
            NEXT FIELD xrca007                  #返回原欄位
            
         ON ACTION controlp INFIELD xrcadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrcald = '",g_xrcald,"'"   #161111-00049#8 Add
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上
            NEXT FIELD xrcadocno                   #返回原欄位
            
         ON ACTION controlp INFIELD xrcb002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xrcb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcb002  #顯示到畫面上
            NEXT FIELD xrcb002                  #返回原欄位
            
         ON ACTION controlp INFIELD xrcb008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrcb008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcb008  #顯示到畫面上
            NEXT FIELD xrcb008                   #返回原欄位
            
         ON ACTION controlp INFIELD xrca014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca014  #顯示到畫面上
            NEXT FIELD xrca014                   #返回原欄位
            
         ON ACTION controlp INFIELD xrcb010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗  #161021-00050#5 mark
            CALL q_ooeg001_4()                                    #161021-00050#5 add
            DISPLAY g_qryparam.return1 TO xrcb010  #顯示到畫面上
            NEXT FIELD xrcb010                  #返回原欄位
            
         ON ACTION controlp INFIELD xrca063
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xrca063()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrca063  #顯示到畫面上
            NEXT FIELD xrca063                   #返回原欄位
         
         END CONSTRUCT
         
      BEFORE DIALOG
         CALL cl_qbe_init()
        
         LET g_xrcb_d[1].sel=""
         DISPLAY ARRAY g_xrcb_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY

      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      CALL axrq340_default()
      CALL axrq340_xrcald_desc()
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc=' 1=1'
   END IF
   IF cl_null(g_wc_qbe) THEN
      LET g_wc_qbe=' 1=1'
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL axrq340_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="axrq340.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq340_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axrq340_b_fill1()
   CALL axrq340_b_fill2()
   CALL axrq340_b_fill3()
   RETURN
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','',xrcborga,'','',xrcb002,'','','','','','',xrcb008,'','', 
       xrcb010,'','','','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xrcb_t.xrcbseq) AS RANK FROM xrcb_t", 
 
 
 
                     "",
                     " WHERE xrcbent=? AND xrcbld=? AND xrcbdocno=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrcb_t"),
                     " ORDER BY xrcb_t.xrcbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
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
 
   LET g_sql = "SELECT '','','',xrcborga,'','',xrcb002,'','','','','','',xrcb008,'','',xrcb010,'','', 
       '','','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq340_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq340_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrcb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xrcb_d[l_ac].sel,g_xrcb_d[l_ac].xrca057,g_xrcb_d[l_ac].xrca057_desc,g_xrcb_d[l_ac].xrcborga, 
       g_xrcb_d[l_ac].xrcborga_desc,g_xrcb_d[l_ac].xrca001,g_xrcb_d[l_ac].xrcb002,g_xrcb_d[l_ac].xrcb100, 
       g_xrcb_d[l_ac].xrcc003,g_xrcb_d[l_ac].xrcc108,g_xrcb_d[l_ac].xrcc118,g_xrcb_d[l_ac].xrca007,g_xrcb_d[l_ac].xrca007_desc, 
       g_xrcb_d[l_ac].xrcb008,g_xrcb_d[l_ac].xrca014,g_xrcb_d[l_ac].xrca014_desc,g_xrcb_d[l_ac].xrcb010, 
       g_xrcb_d[l_ac].xrcb010_desc,g_xrcb_d[l_ac].xrcadocno,g_xrcb2_d[l_ac].flag,g_xrcb2_d[l_ac].xrdadocdt, 
       g_xrcb2_d[l_ac].xrdadocno,g_xrcb2_d[l_ac].xrce002,g_xrcb2_d[l_ac].xrce100,g_xrcb2_d[l_ac].xrce109, 
       g_xrcb2_d[l_ac].xrce119,g_xrcb2_d[l_ac].xrda005,g_xrcb2_d[l_ac].xrda005_desc,g_xrcb3_d[l_ac].nmbadocdt, 
       g_xrcb3_d[l_ac].xrce006,g_xrcb3_d[l_ac].nmbb004,g_xrcb3_d[l_ac].nmbb006,g_xrcb3_d[l_ac].nmbb030, 
       g_xrcb3_d[l_ac].nmbb031,g_xrcb3_d[l_ac].nmbb040,g_xrcb3_d[l_ac].nmbb042,g_xrcb3_d[l_ac].nmbb003, 
       g_xrcb3_d[l_ac].nmbb053,g_xrcb3_d[l_ac].nmbb026,g_xrcb3_d[l_ac].xrce003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xrcb_d[l_ac].statepic = cl_get_actipic(g_xrcb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axrq340_detail_show("'1'")      
 
      CALL axrq340_xrcb_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xrcb_d.deleteElement(g_xrcb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xrcb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq340_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq340_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq340_detail_action_trans()
 
   IF g_xrcb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq340_fetch()
   END IF
   
      CALL axrq340_filter_show('xrca057','b_xrca057')
   CALL axrq340_filter_show('xrcborga','b_xrcborga')
   CALL axrq340_filter_show('xrca001','b_xrca001')
   CALL axrq340_filter_show('xrcb002','b_xrcb002')
   CALL axrq340_filter_show('xrcc003','b_xrcc003')
   CALL axrq340_filter_show('xrca007','b_xrca007')
   CALL axrq340_filter_show('xrcb008','b_xrcb008')
   CALL axrq340_filter_show('xrca014','b_xrca014')
   CALL axrq340_filter_show('xrcb010','b_xrcb010')
   CALL axrq340_filter_show('xrcadocno','b_xrcadocno')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq340_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_xrcb2_d.clear()
 
   CALL g_xrcb3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   CALL g_xrcb2_d.deleteElement(g_xrcb2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_xrcb2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL g_xrcb3_d.deleteElement(g_xrcb3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_xrcb3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrq340.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq340_detail_show(ps_page)
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
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq340_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrca057,xrcborga,xrca001,xrcb002,xrcc003,xrca007,xrcb008,xrca014,xrcb010, 
          xrcadocno
                          FROM s_detail1[1].b_xrca057,s_detail1[1].b_xrcborga,s_detail1[1].b_xrca001, 
                              s_detail1[1].b_xrcb002,s_detail1[1].b_xrcc003,s_detail1[1].b_xrca007,s_detail1[1].b_xrcb008, 
                              s_detail1[1].b_xrca014,s_detail1[1].b_xrcb010,s_detail1[1].b_xrcadocno 
 
 
         BEFORE CONSTRUCT
                     DISPLAY axrq340_filter_parser('xrca057') TO s_detail1[1].b_xrca057
            DISPLAY axrq340_filter_parser('xrcborga') TO s_detail1[1].b_xrcborga
            DISPLAY axrq340_filter_parser('xrca001') TO s_detail1[1].b_xrca001
            DISPLAY axrq340_filter_parser('xrcb002') TO s_detail1[1].b_xrcb002
            DISPLAY axrq340_filter_parser('xrcc003') TO s_detail1[1].b_xrcc003
            DISPLAY axrq340_filter_parser('xrca007') TO s_detail1[1].b_xrca007
            DISPLAY axrq340_filter_parser('xrcb008') TO s_detail1[1].b_xrcb008
            DISPLAY axrq340_filter_parser('xrca014') TO s_detail1[1].b_xrca014
            DISPLAY axrq340_filter_parser('xrcb010') TO s_detail1[1].b_xrcb010
            DISPLAY axrq340_filter_parser('xrcadocno') TO s_detail1[1].b_xrcadocno
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrca057>>----
         #Ctrlp:construct.c.page1.b_xrca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca057
            #add-point:ON ACTION controlp INFIELD b_xrca057 name="construct.c.filter.page1.b_xrca057"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca057 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca057 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xrca057()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca057  #顯示到畫面上
            NEXT FIELD b_xrca057                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrca057_desc>>----
         #----<<b_xrcborga>>----
         #Ctrlp:construct.c.page1.b_xrcborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcborga
            #add-point:ON ACTION controlp INFIELD b_xrcborga name="construct.c.filter.page1.b_xrcborga"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' " #161021-00050#5 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcborga  #顯示到畫面上
            NEXT FIELD b_xrcborga                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrcborga_desc>>----
         #----<<b_xrca001>>----
         #Ctrlp:construct.c.filter.page1.b_xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca001
            #add-point:ON ACTION controlp INFIELD b_xrca001 name="construct.c.filter.page1.b_xrca001"
            
            #END add-point
 
 
         #----<<b_xrcb002>>----
         #Ctrlp:construct.c.page1.b_xrcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb002
            #add-point:ON ACTION controlp INFIELD b_xrcb002 name="construct.c.filter.page1.b_xrcb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_xrcb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcb002  #顯示到畫面上
            NEXT FIELD b_xrcb002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrcb100>>----
         #----<<b_xrcc003>>----
         #Ctrlp:construct.c.filter.page1.b_xrcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcc003
            #add-point:ON ACTION controlp INFIELD b_xrcc003 name="construct.c.filter.page1.b_xrcc003"
            
            #END add-point
 
 
         #----<<xrcc108>>----
         #----<<xrcc118>>----
         #----<<b_xrca007>>----
         #Ctrlp:construct.c.page1.b_xrca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca007
            #add-point:ON ACTION controlp INFIELD b_xrca007 name="construct.c.filter.page1.b_xrca007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca007  #顯示到畫面上
            NEXT FIELD b_xrca007                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrca007_desc>>----
         #----<<b_xrcb008>>----
         #Ctrlp:construct.c.page1.b_xrcb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb008
            #add-point:ON ACTION controlp INFIELD b_xrcb008 name="construct.c.filter.page1.b_xrcb008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcb008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcb008  #顯示到畫面上
            NEXT FIELD b_xrcb008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xrca014>>----
         #Ctrlp:construct.c.page1.b_xrca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca014
            #add-point:ON ACTION controlp INFIELD b_xrca014 name="construct.c.filter.page1.b_xrca014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrca014  #顯示到畫面上
            NEXT FIELD b_xrca014                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrca014_desc>>----
         #----<<b_xrcb010>>----
         #Ctrlp:construct.c.page1.b_xrcb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb010
            #add-point:ON ACTION controlp INFIELD b_xrcb010 name="construct.c.filter.page1.b_xrcb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗  #161021-00050#5 mark
            CALL q_ooeg001_4()                                    #161021-00050#5 add
            DISPLAY g_qryparam.return1 TO b_xrcb010  #顯示到畫面上
            NEXT FIELD b_xrcb010                     #返回原欄位
    


            #END add-point
 
 
         #----<<xrcb010_desc>>----
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.filter.page1.b_xrcadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#7--(S)
            LET g_qryparam.where = " xrca004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            LET g_qryparam.where = g_qryparam.where ," AND xrcald = '",g_xrcald,"'"   #161111-00049#8 Add
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            NEXT FIELD b_xrcadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<flag>>----
         #----<<xrdadocdt>>----
         #----<<xrdadocno>>----
         #----<<xrce002>>----
         #----<<xrce100>>----
         #----<<xrce109>>----
         #----<<xrce119>>----
         #----<<xrda005>>----
         #----<<xrda005_desc>>----
         #----<<nmbadocdt>>----
         #----<<xrce006>>----
         #----<<nmbb004>>----
         #----<<nmbb006>>----
         #----<<nmbb030>>----
         #----<<nmbb031>>----
         #----<<nmbb040>>----
         #----<<nmbb042>>----
         #----<<nmbb003>>----
         #----<<nmbb053>>----
         #----<<nmbb026>>----
         #----<<xrce003>>----
   
 
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL axrq340_filter_show('xrca057','b_xrca057')
   CALL axrq340_filter_show('xrcborga','b_xrcborga')
   CALL axrq340_filter_show('xrca001','b_xrca001')
   CALL axrq340_filter_show('xrcb002','b_xrcb002')
   CALL axrq340_filter_show('xrcc003','b_xrcc003')
   CALL axrq340_filter_show('xrca007','b_xrca007')
   CALL axrq340_filter_show('xrcb008','b_xrcb008')
   CALL axrq340_filter_show('xrca014','b_xrca014')
   CALL axrq340_filter_show('xrcb010','b_xrcb010')
   CALL axrq340_filter_show('xrcadocno','b_xrcadocno')
 
    
   CALL axrq340_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq340_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="axrq340.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq340_filter_show(ps_field,ps_object)
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
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrq340_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.insert" >}
#+ insert
PRIVATE FUNCTION axrq340_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq340.modify" >}
#+ modify
PRIVATE FUNCTION axrq340_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq340_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.delete" >}
#+ delete
PRIVATE FUNCTION axrq340_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq340.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq340_detail_action_trans()
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
 
{<section id="axrq340.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq340_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
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
            IF g_xrcb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrcb_d.getLength() AND g_xrcb_d.getLength() > 0
            LET g_detail_idx = g_xrcb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrcb_d.getLength() THEN
               LET g_detail_idx = g_xrcb_d.getLength()
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
 
{<section id="axrq340.mask_functions" >}
 &include "erp/axr/axrq340_mask.4gl"
 
{</section>}
 
{<section id="axrq340.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳套說明及法人
# Memo...........:
# Usage..........: CALL axrq340_xrcald_desc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_xrcald_desc()
   DEFINE l_glaal002     LIKE glaal_t.glaal002
   DEFINE l_ooefl003     LIKE ooefl_t.ooefl003
   DEFINE l_glaacomp     LIKE glaa_t.glaacomp
   DEFINE l_str          STRING
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrcald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_glaal002=g_rtn_fields[1]
   DISPLAY l_glaal002 TO xrcald_desc
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
   WHERE glaaent=g_enterprise AND glaald=g_xrcald
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_ooefl003= g_rtn_fields[1]
   LET l_str=l_glaacomp
   IF NOT cl_null(l_ooefl003) THEN
      LET l_str=l_str,"(",l_ooefl003,")"
   END IF
   DISPLAY l_str TO xrcacomp
END FUNCTION

################################################################################
# Descriptions...: 設置來源類型下來框
# Memo...........:
# Usage..........: CALL axrq340_set_xrcb001_scc()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_set_xrcb001_scc()
   DEFINE l_sql        STRING
   DEFINE l_str        STRING
   DEFINE l_gzcb002    LIKE gzcb_t.gzcb002
 
#   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '24' AND gzcb005 LIKE '%axr%' ",   #141219-00032#1 mark
    LET l_sql = " SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8340' AND  gzcb004 LIKE '%axrt3%' OR gzcb005 LIKE '%axrt3%' " , #141219-00032#1 add
                " ORDER BY gzcb002 "
   PREPARE axrq340_xrcb001_prep FROM l_sql
   DECLARE axrq340_xrcb001_curs CURSOR FOR axrq340_xrcb001_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrq340_xrcb001_curs INTO l_gzcb002
      IF cl_null(l_str) THEN
         LET l_str = l_gzcb002
         CONTINUE FOREACH
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
#   CALL cl_set_combo_scc_part('xrcb001','24',l_str)#141219-00032#1 mark
    CALL cl_set_combo_scc_part('xrcb001','8340',l_str)  #141219-00032#1 add
END FUNCTION

################################################################################
# Descriptions...: 重写单身填充
# Memo...........:
# Usage..........: CALL axrq340_b_fill1()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_b_fill1()
   DEFINE l_flag     LIKE type_t.num5
   DEFINE l_ld_str   STRING    #160125-00005#9 Add
   
   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc = g_wc,"AND xrca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
  #160125-00005#9 Add  ---(S)---
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrcald")
   LET g_wc = g_wc," AND ",l_ld_str
  #160125-00005#9 Add  ---(E)---
   #單身一
   LET g_sql = " SELECT UNIQUE 'N',xrca057,xrcborga,xrca001,xrcb002,xrca100,xrcc003,SUM(xrcc108-xrcc109),",
               "        SUM(xrcc118-xrcc119),xrca007,xrcb008,xrca014,xrcb010,xrcadocno", 
               "   FROM xrca_t,xrcb_t,xrcc_t",
               "   WHERE xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno ",
               "     AND xrcbent=xrccent AND xrcbld=xrccld AND xrcbdocno=xrccdocno AND xrcbseq=xrccseq ",
               "     AND xrcaent=",g_enterprise," AND xrcald='",g_xrcald,"'",
               "     AND ",g_wc," AND ",g_wc_qbe,
               "   GROUP BY xrca057,xrcborga,xrca001,xrcb002,xrca100,xrcc003,xrca007,xrcb008,xrca014,xrcb010,xrcadocno",
               "   ORDER BY xrca057,xrcborga,xrca001,xrcb002,xrca100,xrcc003,xrca007,xrcb008,xrca014,xrcb010,xrcadocno"               

   PREPARE axrq340_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR axrq340_pb1 
   CALL g_xrcb_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_xrcb_d[l_ac].sel,g_xrcb_d[l_ac].xrca057,g_xrcb_d[l_ac].xrcborga, 
       g_xrcb_d[l_ac].xrca001,g_xrcb_d[l_ac].xrcb002,g_xrcb_d[l_ac].xrcb100,g_xrcb_d[l_ac].xrcc003,g_xrcb_d[l_ac].xrcc108, 
       g_xrcb_d[l_ac].xrcc118,g_xrcb_d[l_ac].xrca007,g_xrcb_d[l_ac].xrcb008,g_xrcb_d[l_ac].xrca014,g_xrcb_d[l_ac].xrcb010, 
       g_xrcb_d[l_ac].xrcadocno,g_xrcb2_d[l_ac].flag,g_xrcb2_d[l_ac].xrdadocdt,g_xrcb2_d[l_ac].xrdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #帳款沖銷對象名稱
      CALL axrq340_xrca057_desc(g_xrcb_d[l_ac].xrcadocno,g_xrcb_d[l_ac].xrca057) RETURNING g_xrcb_d[l_ac].xrca057_desc
      LET g_xrcb_d[l_ac].xrca057_desc=g_xrcb_d[l_ac].xrca057,g_xrcb_d[l_ac].xrca057_desc
      #來源組織名稱
      CALL axrq340_xrcb010_desc(g_xrcb_d[l_ac].xrcborga) RETURNING g_xrcb_d[l_ac].xrcborga_desc
      LET g_xrcb_d[l_ac].xrcborga_desc=g_xrcb_d[l_ac].xrcborga,g_xrcb_d[l_ac].xrcborga_desc
      #帳款類別說明
      CALL axrq340_xrca007_desc(g_xrcb_d[l_ac].xrca007) RETURNING g_xrcb_d[l_ac].xrca007_desc
      LET g_xrcb_d[l_ac].xrca007_desc=g_xrcb_d[l_ac].xrca007,g_xrcb_d[l_ac].xrca007_desc
      #業務人員名稱
      CALL axrq340_xrca014_desc(g_xrcb_d[l_ac].xrca014) RETURNING g_xrcb_d[l_ac].xrca014_desc
      LET g_xrcb_d[l_ac].xrca014_desc=g_xrcb_d[l_ac].xrca014,g_xrcb_d[l_ac].xrca014_desc
      #業務部門名稱
      CALL axrq340_xrcb010_desc(g_xrcb_d[l_ac].xrcb010) RETURNING g_xrcb_d[l_ac].xrcb010_desc
      LET g_xrcb_d[l_ac].xrcb010_desc=g_xrcb_d[l_ac].xrcb010,g_xrcb_d[l_ac].xrcb010_desc
      #金額正負值判斷
      CALL axrq340_get_flag(g_xrcb_d[l_ac].xrca001,g_xrcb_d[l_ac].xrcb002,g_xrcb_d[l_ac].xrcadocno) RETURNING l_flag
      LET g_xrcb_d[l_ac].xrcc108=g_xrcb_d[l_ac].xrcc108*l_flag
      LET g_xrcb_d[l_ac].xrcc118=g_xrcb_d[l_ac].xrcc118*l_flag
      
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
   LET g_error_show = 0
   CALL g_xrcb_d.deleteElement(g_xrcb_d.getLength())   
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   
   LET l_ac = 1
   CALL cl_set_comp_visible("xrcborga_desc,xrca007_desc,xrca014_desc,xrcb010_desc",TRUE)
   CALL cl_set_comp_visible("b_xrcborga,b_xrca007,b_xrca014,b_xrcb010",FALSE)
   
   CALL axrq340_filter_show('xrca057','b_xrca057')
   CALL axrq340_filter_show('xrcborga','b_xrcborga')
   CALL axrq340_filter_show('xrca001','b_xrca001')
   CALL axrq340_filter_show('xrcb002','b_xrcb002')
   CALL axrq340_filter_show('xrcb100','b_xrcb100')
   CALL axrq340_filter_show('xrcc003','b_xrcc003')
   CALL axrq340_filter_show('xrca007','b_xrca007')
   CALL axrq340_filter_show('xrcb008','b_xrcb008')
   CALL axrq340_filter_show('xrca014','b_xrca014')
   CALL axrq340_filter_show('xrcb010','b_xrcb010')
   CALL axrq340_filter_show('xrcadocno','b_xrcadocno')
END FUNCTION

################################################################################
# Descriptions...: 抓取單身二資料
# Memo...........:
# Usage..........: CALL axrq340_b_fill2()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_b_fill2()
   LET g_sql=" SELECT '4' flag,xrdadocdt,xrdadocno,xrce002,xrce100,SUM(xrce109),SUM(xrce119),xrda005 ",
             "   FROM xrda_t,xrce_t ",
             "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
             "    AND xrdaent=",g_enterprise," AND xrdald='",g_xrcald,"' ",
             "    AND xrce003='",g_xrcb_d[l_ac].xrcadocno,"' AND xrdastus='Y' ",
             "    AND xrce024='",g_xrcb_d[l_ac].xrcb002,"' ",
             "  GROUP BY xrdadocdt,xrdadocno,xrce002,xrce100,xrda005 ",
             " UNION ",
             " SELECT '3' flag,xrdadocdt,xrdadocno,xrce002,xrce100,SUM(xrce109),SUM(xrce119),xrca004 ",
             "   FROM xrda_t,xrce_t,xrca_t ",
             "  WHERE xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
             "    AND xrdaent=xrcaent AND xrdald=xrcald AND xrcedocno=xrcadocno ",
             "    AND xrdaent=",g_enterprise," AND xrdald='",g_xrcald,"' ",
             "    AND xrce003='",g_xrcb_d[l_ac].xrcadocno,"' AND xrcastus='Y' ",
             "    AND xrce024='",g_xrcb_d[l_ac].xrcb002,"' ",
             "  GROUP BY xrdadocdt,xrdadocno,xrce002,xrce100,xrca004 ",
             " UNION ",
             " SELECT '2' flag,xrcadocdt,xrcfdocno,'01',xrca100,SUM(xrcf105),SUM(xrcf115),xrca004 ",
             "   FROM xrca_t,xrcb_t,xrcf_t ",
             "  WHERE xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno ",
             "    AND xrcbent=xrcfent AND xrcbld=xrcfld AND xrcbdocno=xrcfdocno AND xrcbseq=xrcfseq ",
             "    AND xrcaent=",g_enterprise," AND xrcald='",g_xrcald,"' ",
             "    AND xrcf008='",g_xrcb_d[l_ac].xrcadocno,"' AND xrcastus='Y' ",
             "  GROUP BY xrcadocdt,xrcfdocno,xrca100,xrca004 "
             
   PREPARE axrq340_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axrq340_pb2
   
   LET g_sql=" SELECT '9' flag,xreb001*100+xreb002,xreb001*100+xreb002,' ',xreb100,0,SUM(xreb116),xrca004 ",
             "   FROM xrca_t,xrcb_t,xreb_t ",
             "  WHERE xrcaent=xrcbent AND xrcald=xrcbld AND xrcadocno=xrcbdocno ",
             "    AND xrebent=xrcaent AND xrebld=xrcald AND xreb005=xrcbdocno AND xreb116<>0 ",
             "    AND xrcaent=",g_enterprise," AND xrcald='",g_xrcald,"' ",
             "    AND xreb005='",g_xrcb_d[l_ac].xrcadocno,"' ",
             "  GROUP BY xreb001*100+xreb002,xreb100,xrca004 "
   PREPARE axrq340_pb2_1 FROM g_sql
   DECLARE b_fill_curs2_1 CURSOR FOR axrq340_pb2_1
   CALL g_xrcb2_d.clear()
 
   LET l_ac2 = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs2 INTO g_xrcb2_d[l_ac].flag,g_xrcb2_d[l_ac].xrdadocdt,
       g_xrcb2_d[l_ac2].xrdadocno,g_xrcb2_d[l_ac2].xrce002,g_xrcb2_d[l_ac2].xrce100,g_xrcb2_d[l_ac2].xrce109, 
       g_xrcb2_d[l_ac2].xrce119,g_xrcb2_d[l_ac2].xrda005
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      CALL axrq340_get_pmaal004(g_xrcb2_d[l_ac2].xrda005) RETURNING g_xrcb2_d[l_ac2].xrda005_desc 
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
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
   LET g_error_show = 0
   
   FOREACH b_fill_curs2_1 INTO g_xrcb2_d[l_ac].flag,g_xrcb2_d[l_ac].xrdadocdt,
       g_xrcb2_d[l_ac2].xrdadocno,g_xrcb2_d[l_ac2].xrce002,g_xrcb2_d[l_ac2].xrce100,g_xrcb2_d[l_ac2].xrce109, 
       g_xrcb2_d[l_ac2].xrce119,g_xrcb2_d[l_ac2].xrda005
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      CALL axrq340_get_pmaal004(g_xrcb2_d[l_ac2].xrda005) RETURNING g_xrcb2_d[l_ac2].xrda005_desc 
 
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
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
   LET g_error_show = 0
   LET l_ac2 = 1 
   CALL g_xrcb2_d.deleteElement(g_xrcb2_d.getLength())   
END FUNCTION

################################################################################
# Descriptions...: 抓取單身三資料
# Memo...........:
# Usage..........: CALL axrq340_b_fill3()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_b_fill3()

   LET g_sql=" SELECT nmbadocdt,xrce006,nmbb004,nmbb006,nmbb030,nmbb031,nmbb040,nmbb042,",
             "        nmbb003,nmbb053,nmbb026,xrce003 ",
             "   FROM nmba_t,nmbb_t,xrda_t,xrce_t ",
             "  WHERE nmbaent=nmbbent AND nmbacomp=nmbbcomp AND nmbadocno=nmbbdocno ",
             "    AND xrdaent=xrceent AND xrdald=xrceld AND xrdadocno=xrcedocno ",
             "    AND nmbaent=xrceent AND xrce003=nmbbdocno AND xrce004=nmbbseq ",
             "    AND xrdastus='Y' AND xrce002='10' ",
             "    AND xrcedocno IN ( SELECT xrcedocno FROM xrce_t ",
             "                        WHERE xrceent=",g_enterprise," AND xrceld='",g_xrcald,"'",
             "                          AND xrce003='",g_xrcb_d[l_ac].xrcadocno,"' )",
             "    AND xrceent=",g_enterprise," AND xrceld='",g_xrcald,"' "

   PREPARE axrq340_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR axrq340_pb3
   
   CALL g_xrcb3_d.clear()
   LET l_ac3 = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs3 INTO g_xrcb3_d[l_ac3].nmbadocdt, 
       g_xrcb3_d[l_ac3].xrce006,g_xrcb3_d[l_ac3].nmbb004,g_xrcb3_d[l_ac3].nmbb006,g_xrcb3_d[l_ac3].nmbb030, 
       g_xrcb3_d[l_ac3].nmbb031,g_xrcb3_d[l_ac3].nmbb040,g_xrcb3_d[l_ac3].nmbb042,g_xrcb3_d[l_ac3].nmbb003, 
       g_xrcb3_d[l_ac3].nmbb053,g_xrcb3_d[l_ac3].nmbb026,g_xrcb3_d[l_ac3].xrce003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #交易帳戶名稱
      #繳款人員
      #繳款對象      
 
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
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
   LET g_error_show = 0
   LET l_ac3 = 1
   CALL g_xrcb3_d.deleteElement(g_xrcb3_d.getLength())   
           
END FUNCTION

################################################################################
# Descriptions...: 帳款沖銷對象說明
# Memo...........:
# Usage..........: CALL axrq340_xrca057_desc(p_xrcadocno,p_xrca057)
#                  RETURNING l_pmaal004
# Input parameter: p_xrcadocno 帳款單號
#                : p_xrca057   交易對象識別碼
# Return code....: l_pmaal004  說明
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_xrca057_desc(p_xrcadocno,p_xrca057)
   DEFINE p_xrcadocno        LIKE xrca_t.xrcadocno
   DEFINE p_xrca057          LIKE xrca_t.xrca057
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004
   DEFINE l_pmaal004         LIKE pmaal_t.pmaal004
   
   LET l_pmaal004=' '
   SELECT pmaa004 INTO l_pmaa004 FROM pmaa_t,xrca_t
    WHERE pmaaent=xrcaent AND pmaa001=xrca004 AND xrcaent=g_enterprise
      AND xrcald=g_xrcald AND xrcadocno=p_xrcadocno
   IF l_pmaa004='1' OR l_pmaa004='3' THEN #一般對象
      SELECT pmaal004 INTO l_pmaal004 FROM pmaal_t
       WHERE pmaalent=g_enterprise AND pmaal001=p_xrca057 AND pmaal002=g_lang
   END IF
   IF l_pmaa004='2' THEN #一次性交易對象
      SELECT pmak003 INTO l_pmaal004 FROM pmak_t
       WHERE pmakent=g_enterprise AND pmak001=p_xrca057
   END IF
   IF l_pmaa004='4' THEN #員工
      SELECT ooag010 INTO l_pmaal004 FROM ooag_t
       WHERE ooagent=g_enterprise AND ooag010=p_xrca057
   END IF
   RETURN l_pmaal004
END FUNCTION

################################################################################
# Descriptions...: 帳款類別說明
# Memo...........:
# Usage..........: CALL axrq340_xrca007_desc(p_xrca007)
#                  RETURNING l_oocql004
# Input parameter: p_xrca007   帳款類別
# Return code....: l_oocql004  說明
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_xrca007_desc(p_xrca007)
   DEFINE p_xrca007            LIKE xrca_t.xrca007
   DEFINE l_oocql004           LIKE oocql_t.oocql004
   
   LET l_oocql004=''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xrca007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3111' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   IF NOT cl_null(g_rtn_fields[1]) THEN
      LET l_oocql004="(",g_rtn_fields[1],")"
   END IF
   RETURN l_oocql004
END FUNCTION

################################################################################
# Descriptions...: 人員名稱
# Memo...........:
# Usage..........: CALL axrq340_xrca014_desc(p_xrca014)
#                  RETURNING r_ooag010
# Input parameter: p_xrca014      人員編號
# Return code....: r_ooag010      名稱
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_xrca014_desc(p_xrca014)
   DEFINE p_xrca014         LIKE xrca_t.xrca014
   DEFINE r_ooag010         LIKE ooag_t.ooag010
   
   LET r_ooag010=''
   SELECT ooag010 INTO r_ooag010 FROM ooag_t
    WHERE ooagent=g_enterprise AND ooag001=p_xrca014
   IF NOT cl_null(r_ooag010) THEN
      LET r_ooag010="(",r_ooag010,")"
   END IF
   RETURN r_ooag010
END FUNCTION

################################################################################
# Descriptions...: 名稱
# Memo...........:
# Usage..........: CALL axrq340_xrcb010_desc(p_xrcb010)
#                  RETURNING r_ooefl003
# Input parameter: p_xrcb010      編號
# Return code....: r_ooefl003     說明
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_xrcb010_desc(p_xrcb010)
   DEFINE p_xrcb010      LIKE xrcb_t.xrcb010
   DEFINE r_ooefl003     LIKE ooefl_t.ooefl003
   
   LET r_ooefl003=''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xrcb010
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   IF NOT cl_null(g_rtn_fields[1]) THEN
      LET r_ooefl003="(",g_rtn_fields[1],")"
   END IF
   RETURN r_ooefl003
END FUNCTION

################################################################################
# Descriptions...: 判斷金額顯示正負數
# Memo...........:
# Usage..........: CALL axrq340_get_flag(p_xrca001,p_xrcb002,p_xrcbdocno)
#                  RETURNING r_flag
# Input parameter: p_xrca001      帳款單性質
#                : p_xrcb002      來源單號
#                : p_xrcbdocno    帳款單號
# Return code....: r_flag         金額正負
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_get_flag(p_xrca001,p_xrcb002,p_xrcbdocno)
   DEFINE p_xrca001            LIKE xrca_t.xrca001
   DEFINE p_xrcb002            LIKE xrcb_t.xrcb002
   DEFINE p_xrcbdocno          LIKE xrcb_t.xrcbdocno
   DEFINE r_flag               LIKE type_t.num5
   DEFINE l_gzcb005            LIKE gzcb_t.gzcb005
   DEFINE l_xrcb001            LIKE xrcb_t.xrcb001
   
   LET r_flag=1
   SELECT xrcb001 INTO l_xrcb001 FROM xrcb_t
   WHERE xrcbent=g_enterprise AND xrcbld=g_xrcald AND xrcbdocno=p_xrcbdocno AND xrcb002=p_xrcb002
   
   IF p_xrca001='11' OR p_xrca001='31' OR p_xrca001='15' OR p_xrca001='19' THEN
      LET r_flag=1
   END IF
   IF p_xrca001='12' OR p_xrca001='29' THEN   
      LET r_flag=1
   END IF
   IF l_xrcb001='axmt540' OR l_xrcb001='artt600' OR l_xrcb001[1,4]='asrt' THEN
      IF p_xrca001='13' OR p_xrca001='14' OR p_xrca001='16' OR p_xrca001='22' OR p_xrca001='01' THEN
         LET r_flag=1
      END IF
   END IF
   IF l_xrcb001='axmt600' THEN
      IF p_xrca001='13' OR p_xrca001='14' OR p_xrca001='16' OR p_xrca001='22' OR p_xrca001='01' OR p_xrca001='02' THEN
         LET r_flag=-1
      END IF
   END IF
   IF p_xrca001='01' AND cl_null(l_xrcb001) THEN
      LET r_flag=1
   END IF
   IF p_xrca001='02' AND cl_null(l_xrcb001) THEN
      LET r_flag=-1
   END IF
   RETURN r_flag
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrq340_get_pmaal004(p_pmaal001)
#                  RETURNING r_pmaal004
# Input parameter: p_pmaal001     編號
# Return code....: r_pmaal004     說明
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq340_get_pmaal004(p_pmaal001)
   DEFINE p_pmaal001       LIKE pmaal_t.pmaal001
   DEFINE r_pmaal004       LIKE pmaal_t.pmaal004
   
   LET r_pmaal004=''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaal001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   IF NOT cl_null(g_rtn_fields[1]) THEN
      LET r_pmaal004="(",g_rtn_fields[1],")"
   END IF
   RETURN r_pmaal004
END FUNCTION
# 赋默认值
PRIVATE FUNCTION axrq340_default()
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_pass       LIKE type_t.num5
   DEFINE l_ooef017    LIKE ooef_t.ooef017   #161111-00049#8 Add
   
   CALL s_ld_bookno()  RETURNING l_success,g_xrcald
   IF l_success = FALSE THEN
      LET g_xrcald=""
   END IF 
   CALL s_ld_chk_authorization(g_user,g_xrcald) RETURNING l_pass
   IF l_pass = FALSE THEN
      LET g_xrcald=""
   END IF
   #161111-00049#8 Add  ---(S)---
   IF NOT cl_null(g_xrcald) THEN
      SELECT glaacomp INTO l_ooef017
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_xrcald
      CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017)
         RETURNING g_sub_success,g_sql_ctrl 
   END IF
   #161111-00049#8 Add  ---(E)---
END FUNCTION

 
{</section>}
 
