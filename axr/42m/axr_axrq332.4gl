#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq332.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:11(2015-12-04 10:48:15), PR版次:0011(2016-12-23 09:08:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000195
#+ Filename...: axrq332
#+ Description: 發票應收查詢作業
#+ Creator....: 02114(2014-04-15 14:06:29)
#+ Modifier...: 02599 -SD/PR- 01531
 
{</section>}
 
{<section id="axrq332.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151130-00015#1    2015/12/04   By 02599      QBE增加状态码栏位，单身中，因本来用电子发票，后来改用发票历程档，故将异动状态栏位隐藏
#151231-00010#7    2016/02/24   By yangtt     增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite
#160731-00372#1    2016/08/16   By 07900      客户开窗不要开供应商
#160913-00017#9    2016/09/22   By 07900      AXR模组调整交易客商开窗
#161021-00050#4    2016/10/24   By 08729      處理組織開窗
#161111-00049#8    2016/11/28   By 01727      控制组权限修改
#161221-00017#1    2016/12/23   By 01531      雜項發票的應收查詢,發票資料有金額,對應的應收單號資料,金額皆為0

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
PRIVATE TYPE type_g_isaf_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   isaf002 LIKE isaf_t.isaf002, 
   isaf002_desc LIKE type_t.chr500, 
   isaf008 LIKE isaf_t.isaf008, 
   isaf008_desc LIKE type_t.chr500, 
   isaf010 LIKE isaf_t.isaf010, 
   isaf011 LIKE isaf_t.isaf011, 
   isaf014 LIKE isaf_t.isaf014, 
   isaf016 LIKE isaf_t.isaf016, 
   isaf016_desc LIKE type_t.chr500, 
   isaf018 LIKE isaf_t.isaf018, 
   isaf103 LIKE isaf_t.isaf103, 
   isaf104 LIKE isaf_t.isaf104, 
   isaf105 LIKE isaf_t.isaf105, 
   isaf036 LIKE isaf_t.isaf036, 
   isafdocno LIKE isaf_t.isafdocno, 
   isafcomp LIKE isaf_t.isafcomp, 
   isaf001 LIKE isaf_t.isaf001 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef019           LIKE ooef_t.ooef019
DEFINE l_cnt               LIKE type_t.num5 

 TYPE type_g_xrca_d RECORD
   xrcald    LIKE xrca_t.xrcald,
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocdt LIKE xrca_t.xrcadocdt, 
   xrca004   LIKE xrca_t.xrca004, 
   xrca004_desc LIKE type_t.chr500, 
   xrca100   LIKE xrca_t.xrca100, 
   xrca030   LIKE xrca_t.xrca030, 
   xrca031   LIKE xrca_t.xrca031, 
   xrca032   LIKE xrca_t.xrca032, 
   isag103   LIKE isag_t.isag103, 
   xrcb117   LIKE xrcb_t.xrcb117, 
   xrcb118   LIKE xrcb_t.xrcb118  
       END RECORD
       
DEFINE g_xrca_d          DYNAMIC ARRAY OF type_g_xrca_d
DEFINE g_xrca_d_t        type_g_xrca_d
DEFINE g_sql_ctrl       STRING                #151231-00010#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isaf_d
DEFINE g_master_t                   type_g_isaf_d
DEFINE g_isaf_d          DYNAMIC ARRAY OF type_g_isaf_d
DEFINE g_isaf_d_t        type_g_isaf_d
 
      
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
 
{<section id="axrq332.main" >}
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
   DECLARE axrq332_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq332_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq332_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq332 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq332_init()   
 
      #進入選單 Menu (="N")
      CALL axrq332_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq332
      
   END IF 
   
   CLOSE axrq332_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq332.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq332_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_isaf001','9715') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('isaf001','9715') 
   CALL cl_set_combo_scc('b_isaf036','9716')
   CALL cl_set_combo_scc_part('isafstus','13','N,Y,S,A,D,R,W') #151130-00015#1 add
   #end add-point
 
   CALL axrq332_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq332.default_search" >}
PRIVATE FUNCTION axrq332_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isafcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isafdocno = '", g_argv[02], "' AND "
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
 
{<section id="axrq332.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq332_ui_dialog()
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
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_slip         LIKE xrca_t.xrcadocno
   DEFINE l_oobx004      LIKE oobx_t.oobx004  
   DEFINE l_str          STRING  
   DEFINE l_num1         LIKE type_t.num5
   DEFINE l_num2         LIKE type_t.num5
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
      CALL axrq332_b_fill()
   ELSE
      CALL axrq332_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isaf_d.clear()
 
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
 
         CALL axrq332_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq332_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq332_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL axrq332_xrca_fill()
               
            ON ACTION modify_detail
               LET la_param.prog = "aist310"
               LET la_param.param[1] = g_isaf_d[l_ac].isafcomp
               LET la_param.param[2] = g_isaf_d[l_ac].isafdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xrca_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_cnt = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xrca_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_cnt

            ON ACTION modify_detail
               IF NOT cl_null(g_xrca_d[l_cnt].xrcadocno) THEN 
                  CALL s_aooi200_fin_get_slip(g_xrca_d[l_cnt].xrcadocno)
                  RETURNING l_success,l_slip
                  SELECT oobx004 INTO l_oobx004 FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip
                  IF l_oobx004 = 'MULTI' THEN 
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
                     LET g_qryparam.arg1 = l_slip
                     CALL q_oobl002()                                
                     LET l_oobx004 = g_qryparam.return1           
                  END IF
                  #LET l_str = "'",l_oobx004,"'"," ","'"||g_xrca_d[l_cnt].xrcald||"'"," ","'"||g_xrca_d[l_cnt].xrcadocno||"'"
                  #LET l_num1 = l_str.getLength()    
                  #LET l_str = l_str.substring(2,l_num1) 
                  #LET l_num2 = l_str.getIndexOf("'",1)
                  #LET l_str = l_str.substring(1,l_num2-1),l_str.substring(l_num2+1,l_num1-1)
                  #CALL cl_cmdrun(l_str)
                  
                  LET la_param.prog = l_oobx004
                  LET la_param.param[1] = g_xrca_d[l_cnt].xrcald
                  LET la_param.param[2] = g_xrca_d[l_cnt].xrcadocno
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq332_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrq332_insert()
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
               CALL axrq332_query()
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
            CALL axrq332_filter()
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
            CALL axrq332_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isaf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_xrca_d)
               LET g_export_id[2]   = "s_detail2"
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
            CALL axrq332_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq332_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq332_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq332_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_isaf_d.getLength()
               LET g_isaf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_isaf_d.getLength()
               LET g_isaf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_isaf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_isaf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_isaf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_isaf_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
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
 
{<section id="axrq332.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq332_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL axrq332_query1()
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isaf_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isaf002,isaf008,isaf010,isaf011,isaf014,isaf016,isaf018,isaf103,isaf104, 
          isaf105,isaf036,isafdocno,isafcomp,isaf001
           FROM s_detail1[1].b_isaf002,s_detail1[1].b_isaf008,s_detail1[1].b_isaf010,s_detail1[1].b_isaf011, 
               s_detail1[1].b_isaf014,s_detail1[1].b_isaf016,s_detail1[1].b_isaf018,s_detail1[1].b_isaf103, 
               s_detail1[1].b_isaf104,s_detail1[1].b_isaf105,s_detail1[1].b_isaf036,s_detail1[1].b_isafdocno, 
               s_detail1[1].b_isafcomp,s_detail1[1].b_isaf001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_isaf002>>----
         #Ctrlp:construct.c.page1.b_isaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf002
            #add-point:ON ACTION controlp INFIELD b_isaf002 name="construct.c.page1.b_isaf002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           # CALL q_pmaa001()   #160913-00017#9  mark                  #呼叫開窗
            #160913-00017#9--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#9--ADD(E)--                 
            DISPLAY g_qryparam.return1 TO b_isaf002  #顯示到畫面上
            NEXT FIELD b_isaf002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf002
            #add-point:BEFORE FIELD b_isaf002 name="construct.b.page1.b_isaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf002
            
            #add-point:AFTER FIELD b_isaf002 name="construct.a.page1.b_isaf002"
            
            #END add-point
            
 
 
         #----<<b_isaf002_desc>>----
         #----<<b_isaf008>>----
         #Ctrlp:construct.c.page1.b_isaf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf008
            #add-point:ON ACTION controlp INFIELD b_isaf008 name="construct.c.page1.b_isaf008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf008  #顯示到畫面上
            NEXT FIELD b_isaf008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf008
            #add-point:BEFORE FIELD b_isaf008 name="construct.b.page1.b_isaf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf008
            
            #add-point:AFTER FIELD b_isaf008 name="construct.a.page1.b_isaf008"
            
            #END add-point
            
 
 
         #----<<b_isaf008_desc>>----
         #----<<b_isaf010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf010
            #add-point:BEFORE FIELD b_isaf010 name="construct.b.page1.b_isaf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf010
            
            #add-point:AFTER FIELD b_isaf010 name="construct.a.page1.b_isaf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf010
            #add-point:ON ACTION controlp INFIELD b_isaf010 name="construct.c.page1.b_isaf010"
            
            #END add-point
 
 
         #----<<b_isaf011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf011
            #add-point:BEFORE FIELD b_isaf011 name="construct.b.page1.b_isaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf011
            
            #add-point:AFTER FIELD b_isaf011 name="construct.a.page1.b_isaf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf011
            #add-point:ON ACTION controlp INFIELD b_isaf011 name="construct.c.page1.b_isaf011"
            
            #END add-point
 
 
         #----<<b_isaf014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf014
            #add-point:BEFORE FIELD b_isaf014 name="construct.b.page1.b_isaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf014
            
            #add-point:AFTER FIELD b_isaf014 name="construct.a.page1.b_isaf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf014
            #add-point:ON ACTION controlp INFIELD b_isaf014 name="construct.c.page1.b_isaf014"
            
            #END add-point
 
 
         #----<<b_isaf016>>----
         #Ctrlp:construct.c.page1.b_isaf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf016
            #add-point:ON ACTION controlp INFIELD b_isaf016 name="construct.c.page1.b_isaf016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf016  #顯示到畫面上
            NEXT FIELD b_isaf016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf016
            #add-point:BEFORE FIELD b_isaf016 name="construct.b.page1.b_isaf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf016
            
            #add-point:AFTER FIELD b_isaf016 name="construct.a.page1.b_isaf016"
            
            #END add-point
            
 
 
         #----<<b_isaf016_desc>>----
         #----<<b_isaf018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf018
            #add-point:BEFORE FIELD b_isaf018 name="construct.b.page1.b_isaf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf018
            
            #add-point:AFTER FIELD b_isaf018 name="construct.a.page1.b_isaf018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf018
            #add-point:ON ACTION controlp INFIELD b_isaf018 name="construct.c.page1.b_isaf018"
            
            #END add-point
 
 
         #----<<b_isaf103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf103
            #add-point:BEFORE FIELD b_isaf103 name="construct.b.page1.b_isaf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf103
            
            #add-point:AFTER FIELD b_isaf103 name="construct.a.page1.b_isaf103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf103
            #add-point:ON ACTION controlp INFIELD b_isaf103 name="construct.c.page1.b_isaf103"
            
            #END add-point
 
 
         #----<<b_isaf104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf104
            #add-point:BEFORE FIELD b_isaf104 name="construct.b.page1.b_isaf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf104
            
            #add-point:AFTER FIELD b_isaf104 name="construct.a.page1.b_isaf104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf104
            #add-point:ON ACTION controlp INFIELD b_isaf104 name="construct.c.page1.b_isaf104"
            
            #END add-point
 
 
         #----<<b_isaf105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf105
            #add-point:BEFORE FIELD b_isaf105 name="construct.b.page1.b_isaf105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf105
            
            #add-point:AFTER FIELD b_isaf105 name="construct.a.page1.b_isaf105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf105
            #add-point:ON ACTION controlp INFIELD b_isaf105 name="construct.c.page1.b_isaf105"
            
            #END add-point
 
 
         #----<<b_isaf036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf036
            #add-point:BEFORE FIELD b_isaf036 name="construct.b.page1.b_isaf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf036
            
            #add-point:AFTER FIELD b_isaf036 name="construct.a.page1.b_isaf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf036
            #add-point:ON ACTION controlp INFIELD b_isaf036 name="construct.c.page1.b_isaf036"
            
            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.page1.b_isafdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isafdocno  #顯示到畫面上
            NEXT FIELD b_isafdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafdocno
            #add-point:BEFORE FIELD b_isafdocno name="construct.b.page1.b_isafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafdocno
            
            #add-point:AFTER FIELD b_isafdocno name="construct.a.page1.b_isafdocno"
            
            #END add-point
            
 
 
         #----<<b_isafcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafcomp
            #add-point:BEFORE FIELD b_isafcomp name="construct.b.page1.b_isafcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafcomp
            
            #add-point:AFTER FIELD b_isafcomp name="construct.a.page1.b_isafcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isafcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafcomp
            #add-point:ON ACTION controlp INFIELD b_isafcomp name="construct.c.page1.b_isafcomp"
            
            #END add-point
 
 
         #----<<b_isaf001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf001
            #add-point:BEFORE FIELD b_isaf001 name="construct.b.page1.b_isaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf001
            
            #add-point:AFTER FIELD b_isaf001 name="construct.a.page1.b_isaf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf001
            #add-point:ON ACTION controlp INFIELD b_isaf001 name="construct.c.page1.b_isaf001"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
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
   
   #end add-point
        
   LET g_error_show = 1
   CALL axrq332_b_fill()
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
 
{<section id="axrq332.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq332_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#151130-00015#1--mark--str--
#   IF cl_null(g_wc) THEN
#      LET g_wc = " AND isafstus = 'Y'"
#   ELSE
#      LET g_wc = g_wc," AND isafstus = 'Y'"
#   END IF
#151130-00015#1--mark--end
   #151231-00010#7--(S)
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc = g_wc," AND isaf002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',isaf002,'',isaf008,'',isaf010,isaf011,isaf014,isaf016,'',isaf018, 
       isaf103,isaf104,isaf105,isaf036,isafdocno,isafcomp,isaf001  ,DENSE_RANK() OVER( ORDER BY isaf_t.isafcomp, 
       isaf_t.isafdocno) AS RANK FROM isaf_t",
 
 
                     "",
                     " WHERE isafent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isaf_t"),
                     " ORDER BY isaf_t.isafcomp,isaf_t.isafdocno"
 
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
 
   LET g_sql = "SELECT '',isaf002,'',isaf008,'',isaf010,isaf011,isaf014,isaf016,'',isaf018,isaf103,isaf104, 
       isaf105,isaf036,isafdocno,isafcomp,isaf001",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq332_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq332_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isaf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isaf_d[l_ac].sel,g_isaf_d[l_ac].isaf002,g_isaf_d[l_ac].isaf002_desc,g_isaf_d[l_ac].isaf008, 
       g_isaf_d[l_ac].isaf008_desc,g_isaf_d[l_ac].isaf010,g_isaf_d[l_ac].isaf011,g_isaf_d[l_ac].isaf014, 
       g_isaf_d[l_ac].isaf016,g_isaf_d[l_ac].isaf016_desc,g_isaf_d[l_ac].isaf018,g_isaf_d[l_ac].isaf103, 
       g_isaf_d[l_ac].isaf104,g_isaf_d[l_ac].isaf105,g_isaf_d[l_ac].isaf036,g_isaf_d[l_ac].isafdocno, 
       g_isaf_d[l_ac].isafcomp,g_isaf_d[l_ac].isaf001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isaf_d[l_ac].statepic = cl_get_actipic(g_isaf_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axrq332_detail_show("'1'")      
 
      CALL axrq332_isaf_t_mask()
 
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
   
 
   
   CALL g_isaf_d.deleteElement(g_isaf_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isaf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq332_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq332_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq332_detail_action_trans()
 
   IF g_isaf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq332_fetch()
   END IF
   
      CALL axrq332_filter_show('isaf002','b_isaf002')
   CALL axrq332_filter_show('isaf008','b_isaf008')
   CALL axrq332_filter_show('isaf010','b_isaf010')
   CALL axrq332_filter_show('isaf011','b_isaf011')
   CALL axrq332_filter_show('isaf014','b_isaf014')
   CALL axrq332_filter_show('isaf016','b_isaf016')
   CALL axrq332_filter_show('isaf018','b_isaf018')
   CALL axrq332_filter_show('isaf103','b_isaf103')
   CALL axrq332_filter_show('isaf104','b_isaf104')
   CALL axrq332_filter_show('isaf105','b_isaf105')
   CALL axrq332_filter_show('isaf036','b_isaf036')
   CALL axrq332_filter_show('isafdocno','b_isafdocno')
   CALL axrq332_filter_show('isafcomp','b_isafcomp')
   CALL axrq332_filter_show('isaf001','b_isaf001')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq332_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrq332.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq332_detail_show(ps_page)
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
   LET g_ref_fields[1] = g_isaf_d[l_ac].isaf002
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isaf_d[l_ac].isaf002_desc = '', g_rtn_fields[1] , ''
   LET g_isaf_d[l_ac].isaf002_desc = g_isaf_d[l_ac].isaf002,g_isaf_d[l_ac].isaf002_desc
   
   DISPLAY g_isaf_d[l_ac].isaf002_desc TO s_detail1[l_ac].isaf002_desc
   
   SELECT ooef019 INTO g_ooef019 FROM ooef_t where ooefent = g_enterprise AND ooef001 = g_isaf_d[l_ac].isafcomp
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = g_isaf_d[l_ac].isaf008
   CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002 = ? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isaf_d[l_ac].isaf008_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_isaf_d[l_ac].isaf008_desc TO  s_detail1[l_ac].isaf008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooef019
   LET g_ref_fields[2] = g_isaf_d[l_ac].isaf016
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_isaf_d[l_ac].isaf016_desc = '', g_rtn_fields[1] , ''
   LET g_isaf_d[l_ac].isaf016_desc = g_isaf_d[l_ac].isaf016,g_isaf_d[l_ac].isaf016_desc
   DISPLAY g_isaf_d[l_ac].isaf016_desc TO isaf016_desc 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq332_filter()
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
      CONSTRUCT g_wc_filter ON isaf002,isaf008,isaf010,isaf011,isaf014,isaf016,isaf018,isaf103,isaf104, 
          isaf105,isaf036,isafdocno,isafcomp,isaf001
                          FROM s_detail1[1].b_isaf002,s_detail1[1].b_isaf008,s_detail1[1].b_isaf010, 
                              s_detail1[1].b_isaf011,s_detail1[1].b_isaf014,s_detail1[1].b_isaf016,s_detail1[1].b_isaf018, 
                              s_detail1[1].b_isaf103,s_detail1[1].b_isaf104,s_detail1[1].b_isaf105,s_detail1[1].b_isaf036, 
                              s_detail1[1].b_isafdocno,s_detail1[1].b_isafcomp,s_detail1[1].b_isaf001 
 
 
         BEFORE CONSTRUCT
                     DISPLAY axrq332_filter_parser('isaf002') TO s_detail1[1].b_isaf002
            DISPLAY axrq332_filter_parser('isaf008') TO s_detail1[1].b_isaf008
            DISPLAY axrq332_filter_parser('isaf010') TO s_detail1[1].b_isaf010
            DISPLAY axrq332_filter_parser('isaf011') TO s_detail1[1].b_isaf011
            DISPLAY axrq332_filter_parser('isaf014') TO s_detail1[1].b_isaf014
            DISPLAY axrq332_filter_parser('isaf016') TO s_detail1[1].b_isaf016
            DISPLAY axrq332_filter_parser('isaf018') TO s_detail1[1].b_isaf018
            DISPLAY axrq332_filter_parser('isaf103') TO s_detail1[1].b_isaf103
            DISPLAY axrq332_filter_parser('isaf104') TO s_detail1[1].b_isaf104
            DISPLAY axrq332_filter_parser('isaf105') TO s_detail1[1].b_isaf105
            DISPLAY axrq332_filter_parser('isaf036') TO s_detail1[1].b_isaf036
            DISPLAY axrq332_filter_parser('isafdocno') TO s_detail1[1].b_isafdocno
            DISPLAY axrq332_filter_parser('isafcomp') TO s_detail1[1].b_isafcomp
            DISPLAY axrq332_filter_parser('isaf001') TO s_detail1[1].b_isaf001
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_isaf002>>----
         #Ctrlp:construct.c.page1.b_isaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf002
            #add-point:ON ACTION controlp INFIELD b_isaf002 name="construct.c.filter.page1.b_isaf002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
           # CALL q_pmaa001()   #160913-00017#9  mark                  #呼叫開窗
            #160913-00017#9--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#9--ADD(E)--  
            DISPLAY g_qryparam.return1 TO b_isaf002  #顯示到畫面上
            NEXT FIELD b_isaf002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isaf002_desc>>----
         #----<<b_isaf008>>----
         #Ctrlp:construct.c.page1.b_isaf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf008
            #add-point:ON ACTION controlp INFIELD b_isaf008 name="construct.c.filter.page1.b_isaf008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf008  #顯示到畫面上
            NEXT FIELD b_isaf008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isaf008_desc>>----
         #----<<b_isaf010>>----
         #Ctrlp:construct.c.filter.page1.b_isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf010
            #add-point:ON ACTION controlp INFIELD b_isaf010 name="construct.c.filter.page1.b_isaf010"
            
            #END add-point
 
 
         #----<<b_isaf011>>----
         #Ctrlp:construct.c.filter.page1.b_isaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf011
            #add-point:ON ACTION controlp INFIELD b_isaf011 name="construct.c.filter.page1.b_isaf011"
            
            #END add-point
 
 
         #----<<b_isaf014>>----
         #Ctrlp:construct.c.filter.page1.b_isaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf014
            #add-point:ON ACTION controlp INFIELD b_isaf014 name="construct.c.filter.page1.b_isaf014"
            
            #END add-point
 
 
         #----<<b_isaf016>>----
         #Ctrlp:construct.c.page1.b_isaf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf016
            #add-point:ON ACTION controlp INFIELD b_isaf016 name="construct.c.filter.page1.b_isaf016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf016  #顯示到畫面上
            NEXT FIELD b_isaf016                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isaf016_desc>>----
         #----<<b_isaf018>>----
         #Ctrlp:construct.c.filter.page1.b_isaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf018
            #add-point:ON ACTION controlp INFIELD b_isaf018 name="construct.c.filter.page1.b_isaf018"
            
            #END add-point
 
 
         #----<<b_isaf103>>----
         #Ctrlp:construct.c.filter.page1.b_isaf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf103
            #add-point:ON ACTION controlp INFIELD b_isaf103 name="construct.c.filter.page1.b_isaf103"
            
            #END add-point
 
 
         #----<<b_isaf104>>----
         #Ctrlp:construct.c.filter.page1.b_isaf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf104
            #add-point:ON ACTION controlp INFIELD b_isaf104 name="construct.c.filter.page1.b_isaf104"
            
            #END add-point
 
 
         #----<<b_isaf105>>----
         #Ctrlp:construct.c.filter.page1.b_isaf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf105
            #add-point:ON ACTION controlp INFIELD b_isaf105 name="construct.c.filter.page1.b_isaf105"
            
            #END add-point
 
 
         #----<<b_isaf036>>----
         #Ctrlp:construct.c.filter.page1.b_isaf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf036
            #add-point:ON ACTION controlp INFIELD b_isaf036 name="construct.c.filter.page1.b_isaf036"
            
            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.filter.page1.b_isafdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isafdocno  #顯示到畫面上
            NEXT FIELD b_isafdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isafcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isafcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafcomp
            #add-point:ON ACTION controlp INFIELD b_isafcomp name="construct.c.filter.page1.b_isafcomp"
            
            #END add-point
 
 
         #----<<b_isaf001>>----
         #Ctrlp:construct.c.filter.page1.b_isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf001
            #add-point:ON ACTION controlp INFIELD b_isaf001 name="construct.c.filter.page1.b_isaf001"
            
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL axrq332_filter_show('isaf002','b_isaf002')
   CALL axrq332_filter_show('isaf008','b_isaf008')
   CALL axrq332_filter_show('isaf010','b_isaf010')
   CALL axrq332_filter_show('isaf011','b_isaf011')
   CALL axrq332_filter_show('isaf014','b_isaf014')
   CALL axrq332_filter_show('isaf016','b_isaf016')
   CALL axrq332_filter_show('isaf018','b_isaf018')
   CALL axrq332_filter_show('isaf103','b_isaf103')
   CALL axrq332_filter_show('isaf104','b_isaf104')
   CALL axrq332_filter_show('isaf105','b_isaf105')
   CALL axrq332_filter_show('isaf036','b_isaf036')
   CALL axrq332_filter_show('isafdocno','b_isafdocno')
   CALL axrq332_filter_show('isafcomp','b_isafcomp')
   CALL axrq332_filter_show('isaf001','b_isaf001')
 
    
   CALL axrq332_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq332_filter_parser(ps_field)
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
 
{<section id="axrq332.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq332_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq332_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.insert" >}
#+ insert
PRIVATE FUNCTION axrq332_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq332.modify" >}
#+ modify
PRIVATE FUNCTION axrq332_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq332_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.delete" >}
#+ delete
PRIVATE FUNCTION axrq332_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq332.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq332_detail_action_trans()
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
 
{<section id="axrq332.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq332_detail_index_setting()
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
            IF g_isaf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isaf_d.getLength() AND g_isaf_d.getLength() > 0
            LET g_detail_idx = g_isaf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isaf_d.getLength() THEN
               LET g_detail_idx = g_isaf_d.getLength()
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
 
{<section id="axrq332.mask_functions" >}
 &include "erp/axr/axrq332_mask.4gl"
 
{</section>}
 
{<section id="axrq332.other_function" readonly="Y" >}
# QBE資料查詢
PRIVATE FUNCTION axrq332_query1()
   DEFINE ls_wc      LIKE type_t.chr500
   
   LET INT_FLAG = 0
   CLEAR FORM
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)

   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單身根據table分拆construct
      CONSTRUCT BY NAME g_wc ON isaf004,isaf005,isafdocno,isaf001,isaf002,isaf014,isaf008,isaf010,isaf011
                               ,isafstus  #151130-00015#1 add
         BEFORE CONSTRUCT
            
         ON ACTION controlp INFIELD isaf004
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                      #呼叫開窗    #161021-00050#4 mark
            CALL q_ooeg001_4()                                 #161021-00050#4 add
            DISPLAY g_qryparam.return1 TO isaf004  #顯示到畫面上

            NEXT FIELD isaf004                     #返回原欄位
            
         ON ACTION controlp INFIELD isaf005
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf005  #顯示到畫面上

            NEXT FIELD isaf005                     #返回原欄位
            
         ON ACTION controlp INFIELD isafdocno
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #151231-00010#7--(S)
            LET g_qryparam.where = " isaf002 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND isaf002 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isafdocno  #顯示到畫面上

            NEXT FIELD isafdocno                     #返回原欄位
            
         ON ACTION controlp INFIELD isaf002
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #151231-00010#7--(S)
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) AND (pmaa002='2' OR pmaa002='3')" #160731-00372#1   2016/08/16  By 07900 add AND (pmaa002='2' OR pmaa002='3') 
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#7--(E)
           # CALL q_pmaa001()   #160913-00017#9  mark                  #呼叫開窗
            #160913-00017#9--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#9--ADD(E)--  
            DISPLAY g_qryparam.return1 TO isaf002  #顯示到畫面上

            NEXT FIELD isaf002                     #返回原欄位

         ON ACTION controlp INFIELD isaf008
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf008  #顯示到畫面上

            NEXT FIELD isaf008                     #返回原欄位
      END CONSTRUCT
      
      BEFORE DIALOG
        #預設

      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
         
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   #CALL aglq780_set_page()
   #CALL aglq780_fetch1('F')
   #DISPLAY g_current_idx TO FORMONLY.h_index
   #DISPLAY g_glaz_s.getLength() TO FORMONLY.h_count
   #DISPLAY g_detail_idx TO FORMONLY.idx
   
   LET g_error_show = 1
   CALL axrq332_b_fill()
   LET l_ac = g_master_idx
   CALL axrq332_fetch()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
# 單身二填充
PRIVATE FUNCTION axrq332_xrca_fill()
   DEFINE l_glaald        LIKE glaa_t.glaald
   
   CALL g_xrca_d.clear()
   SELECT glaald INTO l_glaald  FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_isaf_d[l_ac].isafcomp AND glaa014 = 'Y'
#161221-00017#1 mark s---   
#   IF g_isaf_d[l_ac].isaf001 = '2' THEN 
#      LET g_sql = "SELECT xrcald,xrcadocno,xrcadocdt,xrca004,'',xrca100,xrca030,xrca031,xrca032,'',SUM(xrcb117),SUM(xrcb118-xrcb117)",
#                  "  FROM isaf_t,xrca_t,xrcb_t ",
#                  " WHERE isafdocno = '",g_isaf_d[l_ac].isafdocno,"'",
#                  "   AND xrcald = '",l_glaald,"'",
#                  "   AND isafent = xrcaent ",
#                  "   AND isaf035 = xrcadocno ",
#                  "   AND xrcaent = xrcbent ",
#                  "   AND xrcald = xrcbld ",
#                  "   AND xrcadocno = xrcbdocno ",
#                  " GROUP BY xrcald,xrcadocno,xrcadocdt,xrca004,xrca100,xrca030,xrca031,xrca032"
#   ELSE
#161221-00017#1 mark e---   
      LET g_sql = "SELECT xrcald,xrcadocno,xrcadocdt,xrca004,'',xrca100,xrca030,xrca031,xrca032,SUM(isag103),SUM(xrcb117),SUM(xrcb118-xrcb117)",
                  #"  FROM isag_t,xrca_t,xrcb_t ",           #151203-00002#1 mark lujh
                  "  FROM isaf_t,isag_t,xrca_t,xrcb_t ",     #151203-00002#1 add lujh
                  " WHERE isagdocno = '",g_isaf_d[l_ac].isafdocno,"'",
                  "   AND xrcald = '",l_glaald,"'",
                  "   AND isagent = xrcaent ",
                  #"   AND isag009 = xrcadocno ",   #151203-00002#1 mark lujh
                  #151203-00002#1--add--str--lujh
                  "   AND isafent = isagent ",
                  "   AND isafcomp = isagcomp ",
                  "   AND isafdocno = isagdocno ",
                  "   AND isaf035 = xrcadocno ",
                  #151203-00002#1--add--end--lujh
                  "   AND xrcaent = xrcbent ",
                  "   AND xrcald = xrcbld ",
                  "   AND xrcadocno = xrcbdocno ",
                  " GROUP BY xrcald,xrcadocno,xrcadocdt,xrca004,xrca100,xrca030,xrca031,xrca032"
   #END IF #161221-00017#1 mark

   PREPARE xrca_pre FROM g_sql
   DECLARE xrca_cur CURSOR FOR xrca_pre
   LET l_cnt = 1
   FOREACH xrca_cur INTO g_xrca_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF cl_null(g_xrca_d[l_cnt].xrca030) THEN 
         LET g_xrca_d[l_cnt].xrca030 = 0
      END IF
      
      IF cl_null(g_xrca_d[l_cnt].xrca031) THEN 
         LET g_xrca_d[l_cnt].xrca031 = 0
      END IF
      
      IF cl_null(g_xrca_d[l_cnt].xrca032) THEN 
         LET g_xrca_d[l_cnt].xrca032 = 0
      END IF
      
      IF cl_null(g_xrca_d[l_cnt].isag103) THEN 
         LET g_xrca_d[l_cnt].isag103 = 0
      END IF
      
      IF cl_null(g_xrca_d[l_cnt].xrcb117) THEN 
         LET g_xrca_d[l_cnt].xrcb117 = 0
      END IF
      
      IF cl_null(g_xrca_d[l_cnt].xrcb118) THEN 
         LET g_xrca_d[l_cnt].xrcb118 = 0
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrca_d[l_cnt].xrca004
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrca_d[l_cnt].xrca004_desc = '', g_rtn_fields[1] , ''
      LET g_xrca_d[l_cnt].xrca004_desc = g_xrca_d[l_cnt].xrca004,g_xrca_d[l_cnt].xrca004_desc

      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_xrca_d.deleteElement(l_cnt)
    
   FREE xrca_pre
END FUNCTION

 
{</section>}
 
