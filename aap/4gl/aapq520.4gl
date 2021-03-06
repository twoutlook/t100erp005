#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-06-07 14:57:56), PR版次:0004(2016-11-22 11:04:47)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aapq520
#+ Description: 預購到貨記錄查詢
#+ Creator....: 03080(2016-05-31 10:00:27)
#+ Modifier...: 03080 -SD/PR- 08732
 
{</section>}
 
{<section id="aapq520.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#7   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01,aapq520_x01_tmp2 ——> aapq520_tmp02
#161014-00053#5   16/10/21 By 06137 AAP_帳套/法人/來源組織權限控管,交易對象參考控制組調整
#161115-00044#2   16/11/18 By 08732 開窗範圍處理(3料號)
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
PRIVATE TYPE type_g_apgb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       apgbdocno LIKE apgb_t.apgbdocno, 
   apgbseq LIKE apgb_t.apgbseq, 
   apgbcomp LIKE apgb_t.apgbcomp, 
   apgb001 LIKE apgb_t.apgb001, 
   apgb002 LIKE apgb_t.apgb002, 
   apgb003 LIKE apgb_t.apgb003, 
   apgb004 LIKE apgb_t.apgb004, 
   apgb005 LIKE apgb_t.apgb005, 
   apga100 LIKE apga_t.apga100, 
   apga101 LIKE apga_t.apga101, 
   apgb009 LIKE apgb_t.apgb009, 
   apgb008 LIKE apgb_t.apgb008, 
   apgb010 LIKE apgb_t.apgb010, 
   apgb011 LIKE apgb_t.apgb011, 
   l_apgb008010 LIKE type_t.num20_6, 
   apgb105 LIKE apgb_t.apgb105, 
   l_apgb009010 LIKE type_t.num20_6, 
   l_apgb1051 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input           RECORD
                         l_apgacomp    LIKE apga_t.apgacomp,
                         l_apgacomp_desc LIKE type_t.chr100,
                         l_fintype     LIKE type_t.chr1
                         END RECORD
TYPE type_g_apgm_d RECORD
       seq         LIKE apgm_t.apgmseq,
       apgldocdt   LIKE apgl_t.apgldocdt,
       apgmdocno   LIKE apgm_t.apgmdocno,
       apgmseq     LIKE apgm_t.apgmseq,
       apgl029     LIKE apgl_t.apgl029,
       apgl029seq  LIKE apgm_t.apgmseq,
       apgm004     LIKE apgm_t.apgm004,
       apgm105     LIKE apgm_t.apgm105,
       apcadocno   LIKE apca_t.apcadocno,
       apca038     LIKE apca_t.apca038
       END RECORD
       
DEFINE g_apgm_d                     DYNAMIC ARRAY OF type_g_apgm_d
DEFINE g_wc_cs_comp         STRING      #161014-00053#5 Add By Ken 161021
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apgb_d
DEFINE g_master_t                   type_g_apgb_d
DEFINE g_apgb_d          DYNAMIC ARRAY OF type_g_apgb_d
DEFINE g_apgb_d_t        type_g_apgb_d
 
      
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
 
{<section id="aapq520.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   CALL aapq520_create_tmp()
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
   DECLARE aapq520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq520_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq520_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq520 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq520_init()   
 
      #進入選單 Menu (="N")
      CALL aapq520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq520
      
   END IF 
   
   CLOSE aapq520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq520.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq520_init()
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
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL aapq520_create_tmp()
   #161014-00053#5 Add By ken 161021(S)
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp 
   #161014-00053#5 Add By ken 161021(E)   
   #end add-point
 
   CALL aapq520_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq520.default_search" >}
PRIVATE FUNCTION aapq520_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apgbcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apgbdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " apgbseq = '", g_argv[03], "' AND "
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
 
{<section id="aapq520.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq520_ui_dialog()
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
   DEFINE l_i        LIKE type_t.num10
   DEFINE l_i2       LIKE type_t.num10
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
      CALL aapq520_b_fill()
   ELSE
      CALL aapq520_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apgb_d.clear()
 
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
 
         CALL aapq520_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apgb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq520_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq520_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL aapq520_b_fill2(l_ac)
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            ON ACTION cmdrun
               IF NOT cl_null(l_ac) AND l_ac > 0 THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aapt510'
                  LET la_param.param[2] = g_apgb_d[l_ac].apgbdocno                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_apgm_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
            BEFORE DISPLAY
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
            ON ACTION cmdrun_b2
               IF NOT cl_null(l_ac) AND l_ac > 0 THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aapt560'
                  LET la_param.param[3] = g_apgm_d[l_ac].apcadocno
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq520_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               DELETE FROM aapq520_tmp01    #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01
               DELETE FROM aapq520_tmp02    #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp2 ——> aapq520_tmp02
               FOR l_i = 1 TO g_apgb_d.getLength()
                  #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01
                  INSERT INTO aapq520_tmp01 VALUES(     
                        g_apgb_d[l_i].apgbcomp        ,g_input.l_apgacomp_desc       ,g_input.l_fintype             ,g_apgb_d[l_i].apgbseq         ,
                        g_apgb_d[l_i].apgbdocno       ,g_apgb_d[l_i].apgb001         ,g_apgb_d[l_i].apgb002         ,g_apgb_d[l_i].apgb003         ,
                        g_apgb_d[l_i].apgb004         ,g_apgb_d[l_i].apgb005         ,g_apgb_d[l_i].apga100         ,g_apgb_d[l_i].apga101         ,
                        g_apgb_d[l_i].apgb009         ,g_apgb_d[l_i].apgb008         ,g_apgb_d[l_i].apgb010         ,g_apgb_d[l_i].apgb011         ,
                        g_apgb_d[l_i].l_apgb008010    ,g_apgb_d[l_i].apgb105         ,g_apgb_d[l_i].l_apgb009010    ,g_apgb_d[l_i].l_apgb1051)
                  CALL aapq520_b_fill2(l_i)
                  FOR l_i2 = 1 TO g_apgm_d.getLength()
                     IF NOT cl_null(g_apgm_d[l_i2].seq)THEN
                        #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp2 ——> aapq520_tmp02
                        INSERT INTO aapq520_tmp02 VALUES(g_apgb_d[l_i].apgbcomp,g_apgb_d[l_i].apgbdocno,g_apgb_d[l_i].apgbseq,
                                                            g_apgm_d[l_i2].*)
                     END IF
                  END FOR
               END FOR
               CALL aapq520_x01(g_wc,'aapq520_tmp01','aapq520_tmp02')   #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01,aapq520_x01_tmp2 ——> aapq520_tmp02
               CALL aapq520_b_fill2(l_ac)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               DELETE FROM aapq520_tmp01    #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01
               DELETE FROM aapq520_tmp02    #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp2 ——> aapq520_tmp02
               FOR l_i = 1 TO g_apgb_d.getLength()
                  #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01
                  INSERT INTO aapq520_tmp01 VALUES(     
                        g_apgb_d[l_i].apgbcomp        ,g_input.l_apgacomp_desc       ,g_input.l_fintype             ,g_apgb_d[l_i].apgbseq         ,
                        g_apgb_d[l_i].apgbdocno       ,g_apgb_d[l_i].apgb001         ,g_apgb_d[l_i].apgb002         ,g_apgb_d[l_i].apgb003         ,
                        g_apgb_d[l_i].apgb004         ,g_apgb_d[l_i].apgb005         ,g_apgb_d[l_i].apga100         ,g_apgb_d[l_i].apga101         ,
                        g_apgb_d[l_i].apgb009         ,g_apgb_d[l_i].apgb008         ,g_apgb_d[l_i].apgb010         ,g_apgb_d[l_i].apgb011         ,
                        g_apgb_d[l_i].l_apgb008010    ,g_apgb_d[l_i].apgb105         ,g_apgb_d[l_i].l_apgb009010    ,g_apgb_d[l_i].l_apgb1051)
                  CALL aapq520_b_fill2(l_i)
                  FOR l_i2 = 1 TO g_apgm_d.getLength()
                     IF NOT cl_null(g_apgm_d[l_i2].seq)THEN
                        #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp2 ——> aapq520_tmp02
                        INSERT INTO aapq520_tmp02 VALUES(g_apgb_d[l_i].apgbcomp,g_apgb_d[l_i].apgbdocno,g_apgb_d[l_i].apgbseq,
                                                            g_apgm_d[l_i2].*)
                     END IF
                  END FOR
               END FOR
               CALL aapq520_x01(g_wc,'aapq520_tmp01','aapq520_tmp02')   #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01,aapq520_x01_tmp2 ——> aapq520_tmp02
               CALL aapq520_b_fill2(l_ac)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq520_query()
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
            CALL aapq520_filter()
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
            CALL aapq520_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apgb_d)
               LET g_export_id[1]   = "s_detail1"
 
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
            CALL aapq520_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq520_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq520_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq520_b_fill()
 
         
         
 
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
 
{<section id="aapq520.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq520_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL g_apgm_d.clear()
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apgb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apgbdocno,apgbcomp,apgb001,apgb002,apgb003,apga100
           FROM s_detail1[1].b_apgbdocno,s_detail1[1].b_apgbcomp,s_detail1[1].b_apgb001,s_detail1[1].b_apgb002, 
               s_detail1[1].b_apgb003,s_detail1[1].b_apga100
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_apgbdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgbdocno
            #add-point:BEFORE FIELD b_apgbdocno name="construct.b.page1.b_apgbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgbdocno
            
            #add-point:AFTER FIELD b_apgbdocno name="construct.a.page1.b_apgbdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apgbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgbdocno
            #add-point:ON ACTION controlp INFIELD b_apgbdocno name="construct.c.page1.b_apgbdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apgastus = 'Y' AND apgacomp = '",g_input.l_apgacomp,"' "
            CALL q_apgadocno()
            DISPLAY g_qryparam.return1 TO b_apgbdocno
            NEXT FIELD b_apgbdocno
            #END add-point
 
 
         #----<<b_apgbseq>>----
         #----<<b_apgbcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgbcomp
            #add-point:BEFORE FIELD b_apgbcomp name="construct.b.page1.b_apgbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgbcomp
            
            #add-point:AFTER FIELD b_apgbcomp name="construct.a.page1.b_apgbcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apgbcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgbcomp
            #add-point:ON ACTION controlp INFIELD b_apgbcomp name="construct.c.page1.b_apgbcomp"
 
            #END add-point
 
 
         #----<<b_apgb001>>----
         #Ctrlp:construct.c.page1.b_apgb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgb001
            #add-point:ON ACTION controlp INFIELD b_apgb001 name="construct.c.page1.b_apgb001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "EXISTS (SELECT 1 FROM apgb_t,apga_t ",
                                           " WHERE apgbent = pmdlent AND apgb001 = pmdldocno ",
                                           "   AND apgbent = apgaent ",
                                           "   AND apgbdocno = apgadocno ",
                                           "   AND apgbcomp  = apgacomp ",
                                           "   AND apgacomp = '",g_input.l_apgacomp,"' ",
                                           "   AND apgastus = 'Y') "
            CALL q_pmdldocno_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgb001  #顯示到畫面上
            NEXT FIELD b_apgb001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgb001
            #add-point:BEFORE FIELD b_apgb001 name="construct.b.page1.b_apgb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgb001
            
            #add-point:AFTER FIELD b_apgb001 name="construct.a.page1.b_apgb001"
            
            #END add-point
            
 
 
         #----<<b_apgb002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgb002
            #add-point:BEFORE FIELD b_apgb002 name="construct.b.page1.b_apgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgb002
            
            #add-point:AFTER FIELD b_apgb002 name="construct.a.page1.b_apgb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgb002
            #add-point:ON ACTION controlp INFIELD b_apgb002 name="construct.c.page1.b_apgb002"
            
            #END add-point
 
 
         #----<<b_apgb003>>----
         #Ctrlp:construct.c.page1.b_apgb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgb003
            #add-point:ON ACTION controlp INFIELD b_apgb003 name="construct.c.page1.b_apgb003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161115-00044#2   add---s
            LET g_qryparam.arg1 = g_input.l_apgacomp
            CALL q_imaf001_21()   
            #161115-00044#2   add---e
            #CALL q_imaf001_15()   #161115-00044#2   mark        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgb003  #顯示到畫面上
            NEXT FIELD b_apgb003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgb003
            #add-point:BEFORE FIELD b_apgb003 name="construct.b.page1.b_apgb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgb003
            
            #add-point:AFTER FIELD b_apgb003 name="construct.a.page1.b_apgb003"
            
            #END add-point
            
 
 
         #----<<b_apgb004>>----
         #----<<b_apgb005>>----
         #----<<b_apga100>>----
         #Ctrlp:construct.c.page1.b_apga100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga100
            #add-point:ON ACTION controlp INFIELD b_apga100 name="construct.c.page1.b_apga100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_input.l_apgacomp
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apga100  #顯示到畫面上
            NEXT FIELD b_apga100                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga100
            #add-point:BEFORE FIELD b_apga100 name="construct.b.page1.b_apga100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga100
            
            #add-point:AFTER FIELD b_apga100 name="construct.a.page1.b_apga100"
            
            #END add-point
            
 
 
         #----<<b_apga101>>----
         #----<<b_apgb009>>----
         #----<<b_apgb008>>----
         #----<<b_apgb010>>----
         #----<<b_apgb011>>----
         #----<<l_apgb008010>>----
         #----<<b_apgb105>>----
         #----<<l_apgb009010>>----
         #----<<l_apgb1051>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.l_apgacomp,g_input.l_fintype 
                  ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER INPUT
         
         AFTER FIELD l_apgacomp
            IF NOT cl_null(g_input.l_apgacomp)THEN
               CALL aapq520_comp_chk(g_input.l_apgacomp)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_apgacomp = ''
                  LET g_input.l_apgacomp_desc = ''
                  DISPLAY BY NAME g_input.l_apgacomp,g_input.l_apgacomp_desc
                  NEXT FIELD l_apgacomp
               END IF
               CALL s_desc_get_department_desc(g_input.l_apgacomp) RETURNING g_input.l_apgacomp_desc
               DISPLAY BY NAME g_input.l_apgacomp,g_input.l_apgacomp_desc
            END IF
         
         ON ACTION controlp INFIELD l_apgacomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.l_apgacomp
            LET g_qryparam.where = " ooef003 = 'Y' "
            #161014-00053#5 Add By ken 161021(S)
            IF NOT cl_null(g_wc_cs_comp)THEN
               LET g_qryparam.where = g_qryparam.where , "AND ooef001 IN ",g_wc_cs_comp  
            END IF            
            #161014-00053#5 Add By ken 161021(E)             
            CALL q_ooef001()
            LET g_input.l_apgacomp = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.l_apgacomp) RETURNING g_input.l_apgacomp_desc
            DISPLAY BY NAME g_input.l_apgacomp,g_input.l_apgacomp_desc
            NEXT FIELD l_apgacomp
            
      END INPUT
      
      BEFORE DIALOG
         CALL aapq520_qbeclear()
         LET g_apgb_d[1].apgbseq = ''
         DISPLAY ARRAY g_apgb_d TO s_detail1.* ATTRIBUTE(COUNT=1)
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
         CALL aapq520_qbeclear()
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
   CALL aapq520_b_fill()
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
 
{<section id="aapq520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq520_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_wc2 = ' 1=1'
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
 
   LET ls_sql_rank = "SELECT  UNIQUE apgbdocno,apgbseq,apgbcomp,apgb001,apgb002,apgb003,apgb004,apgb005, 
       '','',apgb009,apgb008,apgb010,apgb011,'',apgb105,'',''  ,DENSE_RANK() OVER( ORDER BY apgb_t.apgbcomp, 
       apgb_t.apgbdocno,apgb_t.apgbseq) AS RANK FROM apgb_t",
 
 
                     "",
                     " WHERE apgbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apgb_t"),
                     " ORDER BY apgb_t.apgbcomp,apgb_t.apgbdocno,apgb_t.apgbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   IF cl_null(ls_wc)THEN
      LET ls_wc = " apgacomp = '",g_input.l_apgacomp,"' AND apgastus = 'Y' "
      CASE
         WHEN g_input.l_fintype = '0'
            LET ls_wc = ls_wc CLIPPED," AND apga029 = 'N' "
         WHEN g_input.l_fintype = '1'
            LET ls_wc = ls_wc CLIPPED," AND apga029 = 'Y' "
         WHEN g_input.l_fintype = '2'
      END CASE
   ELSE
      LET ls_wc = ls_wc CLIPPED," AND apgacomp = '",g_input.l_apgacomp,"' AND apgastus = 'Y' "
      CASE
         WHEN g_input.l_fintype = '0'
            LET ls_wc = ls_wc CLIPPED," AND apga029 = 'N' "
         WHEN g_input.l_fintype = '1'
            LET ls_wc = ls_wc CLIPPED," AND apga029 = 'Y' "
         WHEN g_input.l_fintype = '2'
      END CASE
   END IF

   LET ls_sql_rank = "SELECT  UNIQUE apgbdocno,apgbseq,apgbcomp,apgb001,apgb002,apgb003,apgb004,apgb005, ",
                                 "   '','',apgb009,apgb008,apgb010,apgb011,'',apgb105,'',''  ",
                       "FROM apgb_t,apga_t ",
                     " WHERE apgbent= ? AND 1=1 AND apgbent = apgaent AND apgbcomp = apgacomp AND apgadocno = apgbdocno ",
                     "   AND ",ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apgb_t"),
                     " ORDER BY apgb_t.apgbcomp,apgb_t.apgbdocno,apgb_t.apgbseq"
   
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   LET ls_sql_rank = "SELECT  UNIQUE apgbdocno,apgbseq,apgbcomp,apgb001,apgb002,apgb003,apgb004,apgb005, 
       apga100,apga101,apgb009,apgb008,apgb010,apgb011,'',apgb105,'',''  ,DENSE_RANK() OVER( ORDER BY apgb_t.apgb001,apgb_t.apgb002) AS RANK FROM apgb_t,apga_t ",
                     "",
                     " WHERE apgbent= ? AND 1=1 AND apgaent = apgbent AND apgadocno = apgbdocno AND apgbcomp = apgacomp AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apgb_t"),
                     " ORDER BY apgb_t.apgb001,apgb_t.apgb002 "
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
 
   LET g_sql = "SELECT apgbdocno,apgbseq,apgbcomp,apgb001,apgb002,apgb003,apgb004,apgb005,'','',apgb009, 
       apgb008,apgb010,apgb011,'',apgb105,'',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT apgbdocno,apgbseq,apgbcomp,apgb001,apgb002,apgb003,apgb004,apgb005,apga100,apga101,apgb009, 
       apgb008,apgb010,apgb011,0,apgb105,0,0 ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq520_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq520_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apgb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_apgm_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apgb_d[l_ac].apgbdocno,g_apgb_d[l_ac].apgbseq,g_apgb_d[l_ac].apgbcomp, 
       g_apgb_d[l_ac].apgb001,g_apgb_d[l_ac].apgb002,g_apgb_d[l_ac].apgb003,g_apgb_d[l_ac].apgb004,g_apgb_d[l_ac].apgb005, 
       g_apgb_d[l_ac].apga100,g_apgb_d[l_ac].apga101,g_apgb_d[l_ac].apgb009,g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb010, 
       g_apgb_d[l_ac].apgb011,g_apgb_d[l_ac].l_apgb008010,g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].l_apgb009010, 
       g_apgb_d[l_ac].l_apgb1051
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apgb_d[l_ac].statepic = cl_get_actipic(g_apgb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_apgb_d[l_ac].apgb009)THEN LET g_apgb_d[l_ac].apgb009 = 0 END IF
      IF cl_null(g_apgb_d[l_ac].apgb008)THEN LET g_apgb_d[l_ac].apgb008 = 0 END IF
      IF cl_null(g_apgb_d[l_ac].apgb010)THEN LET g_apgb_d[l_ac].apgb010 = 0 END IF
      IF cl_null(g_apgb_d[l_ac].apgb011)THEN LET g_apgb_d[l_ac].apgb011 = 0 END IF 
      IF cl_null(g_apgb_d[l_ac].apgb105)THEN LET g_apgb_d[l_ac].apgb105 = 0 END IF      
      LET g_apgb_d[l_ac].l_apgb008010 = g_apgb_d[l_ac].apgb008 - g_apgb_d[l_ac].apgb010
      LET g_apgb_d[l_ac].l_apgb009010 = g_apgb_d[l_ac].apgb009 * g_apgb_d[l_ac].apgb010
      LET g_apgb_d[l_ac].l_apgb1051 = g_apgb_d[l_ac].apgb105 - g_apgb_d[l_ac].l_apgb009010
      IF cl_null(g_apgb_d[l_ac].l_apgb008010)THEN LET g_apgb_d[l_ac].l_apgb008010 = 0 END IF 
      IF cl_null(g_apgb_d[l_ac].l_apgb1051)THEN LET g_apgb_d[l_ac].l_apgb1051 = 0 END IF
      IF cl_null(g_apgb_d[l_ac].l_apgb009010)THEN LET g_apgb_d[l_ac].l_apgb009010 = 0 END IF
      #end add-point
 
      CALL aapq520_detail_show("'1'")      
 
      CALL aapq520_apgb_t_mask()
 
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
   
 
   
   CALL g_apgb_d.deleteElement(g_apgb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL aapq520_b_fill2(1)
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_apgb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq520_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq520_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq520_detail_action_trans()
 
   IF g_apgb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq520_fetch()
   END IF
   
      CALL aapq520_filter_show('apgbdocno','b_apgbdocno')
   CALL aapq520_filter_show('apgbcomp','b_apgbcomp')
   CALL aapq520_filter_show('apgb001','b_apgb001')
   CALL aapq520_filter_show('apgb002','b_apgb002')
   CALL aapq520_filter_show('apgb003','b_apgb003')
   CALL aapq520_filter_show('apga100','b_apga100')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq520.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq520_fetch()
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
 
{<section id="aapq520.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq520_detail_show(ps_page)
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
 
{<section id="aapq520.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq520_filter()
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
      CONSTRUCT g_wc_filter ON apgbdocno,apgbcomp,apgb001,apgb002,apgb003,apga100
                          FROM s_detail1[1].b_apgbdocno,s_detail1[1].b_apgbcomp,s_detail1[1].b_apgb001, 
                              s_detail1[1].b_apgb002,s_detail1[1].b_apgb003,s_detail1[1].b_apga100
 
         BEFORE CONSTRUCT
                     DISPLAY aapq520_filter_parser('apgbdocno') TO s_detail1[1].b_apgbdocno
            DISPLAY aapq520_filter_parser('apgbcomp') TO s_detail1[1].b_apgbcomp
            DISPLAY aapq520_filter_parser('apgb001') TO s_detail1[1].b_apgb001
            DISPLAY aapq520_filter_parser('apgb002') TO s_detail1[1].b_apgb002
            DISPLAY aapq520_filter_parser('apgb003') TO s_detail1[1].b_apgb003
            DISPLAY aapq520_filter_parser('apga100') TO s_detail1[1].b_apga100
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_apgbdocno>>----
         #Ctrlp:construct.c.filter.page1.b_apgbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgbdocno
            #add-point:ON ACTION controlp INFIELD b_apgbdocno name="construct.c.filter.page1.b_apgbdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apgastus = 'Y' AND apgacomp = '",g_input.l_apgacomp,"' "
            CALL q_apgadocno()
            DISPLAY g_qryparam.return1 TO b_apgbdocno
            NEXT FIELD b_apgbdocno
            #END add-point
 
 
         #----<<b_apgbseq>>----
         #----<<b_apgbcomp>>----
         #Ctrlp:construct.c.filter.page1.b_apgbcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgbcomp
            #add-point:ON ACTION controlp INFIELD b_apgbcomp name="construct.c.filter.page1.b_apgbcomp"
            
            #END add-point
 
 
         #----<<b_apgb001>>----
         #Ctrlp:construct.c.page1.b_apgb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgb001
            #add-point:ON ACTION controlp INFIELD b_apgb001 name="construct.c.filter.page1.b_apgb001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "EXISTS (SELECT 1 FROM apgb_t,apga_t ",
                                           " WHERE apgbent = pmdlent AND apgb001 = pmdldocno ",
                                           "   AND apgbent = apgaent ",
                                           "   AND apgbdocno = apgadocno ",
                                           "   AND apgbcomp  = apgacomp ",
                                           "   AND apgacomp = '",g_input.l_apgacomp,"' ",
                                           "   AND apgastus = 'Y') "
            CALL q_pmdldocno_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgb001  #顯示到畫面上
            NEXT FIELD b_apgb001                     #返回原欄位
            #END add-point
 
 
         #----<<b_apgb002>>----
         #Ctrlp:construct.c.filter.page1.b_apgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgb002
            #add-point:ON ACTION controlp INFIELD b_apgb002 name="construct.c.filter.page1.b_apgb002"
            
            #END add-point
 
 
         #----<<b_apgb003>>----
         #Ctrlp:construct.c.page1.b_apgb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgb003
            #add-point:ON ACTION controlp INFIELD b_apgb003 name="construct.c.filter.page1.b_apgb003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161115-00044#2   add---s
            LET g_qryparam.arg1 = g_input.l_apgacomp
            CALL q_imaf001_21()   
            #161115-00044#2   add---e
            #CALL q_imaf001_15()   #161115-00044#2   mark         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgb003  #顯示到畫面上
            NEXT FIELD b_apgb003                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_apgb004>>----
         #----<<b_apgb005>>----
         #----<<b_apga100>>----
         #Ctrlp:construct.c.page1.b_apga100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga100
            #add-point:ON ACTION controlp INFIELD b_apga100 name="construct.c.filter.page1.b_apga100"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_input.l_apgacomp
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apga100  #顯示到畫面上
            NEXT FIELD b_apga100                   #返回原欄位
            #END add-point
 
 
         #----<<b_apga101>>----
         #----<<b_apgb009>>----
         #----<<b_apgb008>>----
         #----<<b_apgb010>>----
         #----<<b_apgb011>>----
         #----<<l_apgb008010>>----
         #----<<b_apgb105>>----
         #----<<l_apgb009010>>----
         #----<<l_apgb1051>>----
   
 
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
   
      CALL aapq520_filter_show('apgbdocno','b_apgbdocno')
   CALL aapq520_filter_show('apgbcomp','b_apgbcomp')
   CALL aapq520_filter_show('apgb001','b_apgb001')
   CALL aapq520_filter_show('apgb002','b_apgb002')
   CALL aapq520_filter_show('apgb003','b_apgb003')
   CALL aapq520_filter_show('apga100','b_apga100')
 
    
   CALL aapq520_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq520.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq520_filter_parser(ps_field)
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
 
{<section id="aapq520.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq520_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq520.insert" >}
#+ insert
PRIVATE FUNCTION aapq520_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq520.modify" >}
#+ modify
PRIVATE FUNCTION aapq520_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq520.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq520_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq520.delete" >}
#+ delete
PRIVATE FUNCTION aapq520_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq520.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq520_detail_action_trans()
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
 
{<section id="aapq520.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq520_detail_index_setting()
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
            IF g_apgb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apgb_d.getLength() AND g_apgb_d.getLength() > 0
            LET g_detail_idx = g_apgb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apgb_d.getLength() THEN
               LET g_detail_idx = g_apgb_d.getLength()
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
 
{<section id="aapq520.mask_functions" >}
 &include "erp/aap/aapq520_mask.4gl"
 
{</section>}
 
{<section id="aapq520.other_function" readonly="Y" >}

PRIVATE FUNCTION aapq520_qbeclear()
   DEFINE l_ld   LIKE glaa_t.glaald
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_input.l_apgacomp,l_ld
   LET g_input.l_apgacomp_desc = s_desc_get_department_desc(g_input.l_apgacomp)
   LET g_input.l_fintype = '2'
   DISPLAY BY NAME g_input.l_apgacomp,g_input.l_apgacomp_desc,g_input.l_fintype
END FUNCTION

PRIVATE FUNCTION aapq520_b_fill2(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   DEFINE l_sql  STRING
   DEFINE l_idx  LIKE type_t.num10
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   
   LET l_sql = "SELECT 0,apgldocdt,apgmdocno,apgmseq,apgl029,",
               "       apgmseq,apgm004,apgm105,'','' ",
               "  FROM apgm_t,apgl_t ",
               " WHERE apgment = apglent ",
               "   AND apgmcomp = apglcomp ",
               "   AND apgmdocno = apgldocno ",
               "   AND apgment = ",g_enterprise," ",
               "   AND apgmcomp = ? ",
               "   AND apgl004 = ? ",
               "   AND apgmseq2 = ? ",
               "   AND apglstus = 'Y' "
   PREPARE sel_apgmp1 FROM l_sql
   DECLARE sel_apgmc1 CURSOR FOR sel_apgmp1
   
   LET l_sql = "SELECT DISTICT apcadocno,apca038 FROM apca_t,apcb_t ",
               " WHERE apcaent = ",g_enterprise," ",
               "   AND apcb002 = ? ",
               "   AND apcb003 = ? ",
               "   AND apcb001 = '11'",
               "   AND apcastus <> 'X' ",
               "   AND apcadocno = apcbdocno ",
               "   AND apcald = apcbld ",
               "   AND apcbent = apcaent "
   PREPARE sel_apcap1 FROM l_sql
   DECLARE sel_apcac1 CURSOR FOR sel_apcap1
   CALL g_apgm_d.clear()
   LET l_idx = 1
   FOREACH sel_apgmc1 
      USING g_apgb_d[p_ac].apgbcomp,g_apgb_d[p_ac].apgbdocno   ,g_apgb_d[p_ac].apgbseq 
      INTO g_apgm_d[l_idx].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF NOT cl_null(g_apgm_d[l_idx].apgmdocno)THEN 
         LET g_apgm_d[l_idx].seq = l_idx
      END IF
      IF cl_null(g_apgm_d[l_idx].apgl029)THEN 
         LET g_apgm_d[l_idx].apgl029 = NULL
      ELSE
         FOREACH sel_apcap1 USING g_apgm_d[l_idx].apgl029,g_apgm_d[l_idx].apgl029seq
            INTO g_apgm_d[l_idx].apcadocno,g_apgm_d[l_idx].apca038
            EXIT FOREACH
         END FOREACH
      END IF
      
      LET l_idx = l_idx + 1      
   END FOREACH
   LET g_detail_cnt2 = l_idx
               
END FUNCTION

PRIVATE FUNCTION aapq520_create_tmp()
   CREATE TEMP TABLE aapq520_tmp01(     #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp1 ——> aapq520_tmp01
      apgbcomp        LIKE apgb_t.apgbcomp,
      l_apgbcomp_desc LIKE type_t.chr100,
      l_fintype       LIKE type_t.chr100,
      apgbseq         LIKE apgb_t.apgbseq,
      apgbdocno       LIKE apgb_t.apgbdocno,
      apgb001         LIKE apgb_t.apgb001,
      apgb002         LIKE apgb_t.apgb002,
      apgb003         LIKE apgb_t.apgb003,
      apgb004         LIKE apgb_t.apgb004,
      apgb005         LIKE apgb_t.apgb005,
      apgb100         LIKE apgb_t.apgb100,
      apgb101         LIKE apgb_t.apgb101,
      apgb009         LIKE apgb_t.apgb009,
      apgb008         LIKE apgb_t.apgb008,
      apgb010         LIKE apgb_t.apgb010,
      apgb011         LIKE apgb_t.apgb011,
      l_apgb008010    LIKE type_t.num15_3,
      apgb105         LIKE apgb_t.apgb105,
      l_apgb009010    LIKE type_t.num20_6,
      l_apgb1051      LIKE type_t.num20_6
      )
   CREATE TEMP TABLE aapq520_tmp02(   #临时表长度超过15码的减少到15码以下 aapq520_x01_tmp2 ——> aapq520_tmp02
      l_apgbcomp        LIKE apgb_t.apgbcomp,
      l_apgbdocno       LIKE apgb_t.apgbdocno,
      l_apgbseq         LIKE apgb_t.apgbseq,
      seq             LIKE apgm_t.apgmseq,
      apgldocdt       LIKE apgl_t.apgldocdt,
      apgmdocno       LIKE apgm_t.apgmdocno,
      apgmseq         LIKE apgm_t.apgmseq,
      apgl029         LIKE apgl_t.apgl029,
      apgl029seq      LIKE apgm_t.apgmseq,
      apgm004         LIKE apgm_t.apgm004,
      apgm105         LIKE apgm_t.apgm105,
      apcadocno       LIKE apca_t.apcadocno,
      apca038         LIKE apca_t.apca038      
      )
END FUNCTION

PRIVATE FUNCTION aapq520_comp_chk(p_apgacomp)
   DEFINE p_apgacomp   LIKE apga_t.apgacomp
   DEFINE r_success    LIKE type_t.num10
   DEFINE r_errno      LIKE gzze_t.gzze001
   DEFINE l_ooefstus   LIKE ooef_t.ooefstus
   DEFINE l_ooef003    LIKE ooef_t.ooef003
   LET r_success = TRUE   
   LET r_errno = ''
   LET l_ooefstus = ''   LET l_ooef003 = ''
   SELECT ooefstus , ooef003
     INTO l_ooefstus,l_ooef003
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_apgacomp
      
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno = 'wss-00231'
      WHEN l_ooefstus = 'N'
         LET r_success = FALSE
         LET r_errno = 'axc-00006'
      WHEN l_ooef003 <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'apm-00250'
   END CASE
   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
