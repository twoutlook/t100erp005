#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-06-13 09:47:15), PR版次:0007(2016-12-21 13:18:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: aapq510
#+ Description: 信用狀歷程查詢
#+ Creator....: 03080(2016-05-18 16:48:25)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="aapq510.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#7  2016/08/01 By 08734     临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01,aapq510_x01_tmp2 ——> aapq510_tmp02
#161014-00053#5  2016/10/21 By 06137     AAP_帳套/法人/來源組織權限控管,交易對象參考控制組調整
#161108-00017#2  2016/11/09 By Reanna    程式中INSERT INTO 有星號作整批調整
#161115-00044#2  2016/11/18 By 08732     開窗範圍處理(4單號)
#161209-00012#2  2016/12/09 By 08729     處理CURSOR名字重複問題
#161221-00012#1  2016/12/21 By 08171     設計器現已改調規範，會將「列印(output)」段add-pointn內容複製至quickprint段對應內容， 故之前這2隻的調整，請原來的程式碼放至新增的共同列印處理function中，在output段改成call function名aapq510,axrq470
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
PRIVATE TYPE type_g_apga_d RECORD
       #statepic       LIKE type_t.chr1,
       
       apgacomp LIKE apga_t.apgacomp, 
   apgadocno LIKE apga_t.apgadocno, 
   apga002 LIKE apga_t.apga002, 
   apgadocdt LIKE apga_t.apgadocdt, 
   apga004 LIKE apga_t.apga004, 
   apga004_desc LIKE type_t.chr500, 
   apga001 LIKE apga_t.apga001, 
   apga006 LIKE apga_t.apga006, 
   apga007 LIKE apga_t.apga007, 
   apga007_desc LIKE type_t.chr500, 
   apga003 LIKE apga_t.apga003, 
   apga010 LIKE apga_t.apga010, 
   apga100 LIKE apga_t.apga100, 
   apga109 LIKE apga_t.apga109, 
   l_apga109103 LIKE type_t.num20_6, 
   apga103 LIKE apga_t.apga103, 
   apga102 LIKE apga_t.apga102, 
   apga105 LIKE apga_t.apga105, 
   apga104 LIKE apga_t.apga104, 
   l_paysum LIKE type_t.num20_6, 
   l_unpay LIKE type_t.num20_6, 
   l_payback LIKE type_t.num20_6, 
   l_unpayback LIKE type_t.num20_6, 
   l_apgb001 LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input              RECORD
   l_apgacomp      LIKE apga_t.apgacomp,
   l_apgacomp_desc LIKE type_t.chr100,
   l_final         LIKE type_t.chr1,
   l_orderby       LIKE type_t.chr1
                            END RECORD
                            
TYPE type_g_tmp_d RECORD                            
                  prog     LIKE type_t.chr20,
                  docdt    LIKE type_t.dat,
                  docno    LIKE type_t.chr30,
                  ver      LIKE type_t.num5,
                  act      LIKE type_t.chr20,
                  l_103    LIKE type_t.num20_6,
                  l_113    LIKE type_t.num20_6,
                  accdoc   LIKE type_t.chr30,
                  apca038  LIKE apca_t.apca038,
                  afmt140  LIKE apca_t.apcadocno,
                  afmt170  LIKE apca_t.apcadocno,
                  aapt430  LIKE apca_t.apcadocno   
         END RECORD

DEFINE g_tmp_d          DYNAMIC ARRAY OF type_g_tmp_d
DEFINE g_wc_cs_comp         STRING      #161014-00053#5 Add By Ken 161021
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_apga_d
DEFINE g_master_t                   type_g_apga_d
DEFINE g_apga_d          DYNAMIC ARRAY OF type_g_apga_d
DEFINE g_apga_d_t        type_g_apga_d
 
      
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
 
{<section id="aapq510.main" >}
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
   CALL aapq510_preparedeclare()
   CALL aapq510_create_tmp()
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
   DECLARE aapq510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq510_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq510_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq510 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq510_init()   
 
      #進入選單 Menu (="N")
      CALL aapq510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq510
      
   END IF 
   
   CLOSE aapq510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapq510_init()
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
   
      CALL cl_set_combo_scc('b_apga006','8517') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   #161014-00053#5 Add By ken 161021(S)
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp 
   #161014-00053#5 Add By ken 161021(E)
   #end add-point
 
   CALL aapq510_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aapq510.default_search" >}
PRIVATE FUNCTION aapq510_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apgacomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apgadocno = '", g_argv[02], "' AND "
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
 
{<section id="aapq510.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aapq510_ui_dialog()
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
   #161221-00012#2 --s mark
   #DEFINE l_i        LIKE type_t.num10
   #DEFINE l_i2       LIKE type_t.num10
   #DEFINE l_desc1    LIKE type_t.chr100
   #DEFINE l_desc2    LIKE type_t.chr1000
   #DEFINE l_sql      STRING
   #DEFINE l_prog     LIKE type_t.chr100
   #161221-00012#2 --e mark
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
      CALL aapq510_b_fill()
   ELSE
      CALL aapq510_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apga_d.clear()
 
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
 
         CALL aapq510_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_apga_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq510_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aapq510_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL aapq510_b_fill2(l_ac)
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            ON ACTION cmdrun_b1
               IF NOT cl_null(l_ac) AND l_ac > 0 THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aapt510'
                  LET la_param.param[2] = g_apga_d[l_ac].apgadocno                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_tmp_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
            BEFORE DISPLAY
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
            ON ACTION cmdrun_b2
               IF NOT cl_null(l_ac) AND l_ac > 0 THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aapt560'
                  LET la_param.param[3] = g_tmp_d[l_ac].accdoc
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
         END DISPLAY 
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq510_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #161221-00012#1 --s mark
               #DELETE FROM aapq510_tmp01       #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
               #DELETE FROM aapq510_tmp02       #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp2 ——> aapq510_tmp02
               #FOR l_i = 1 TO g_apga_d.getLength()
               #   LET l_desc1 =  s_desc_gzcbl004_desc('8517',g_apga_d[l_i].apga006)
               #   #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
               #   INSERT INTO aapq510_tmp01 VALUES(
               #      g_input.l_apgacomp,g_input.l_final,g_input.l_orderby,
               #      g_apga_d[l_i].apgacomp,    g_apga_d[l_i].apgadocno,  g_apga_d[l_i].apga002,
               #      g_apga_d[l_i].apgadocdt,   g_apga_d[l_i].apga004,    g_apga_d[l_i].apga004_desc,
               #      g_apga_d[l_i].apga001,     l_desc1,                  g_apga_d[l_i].apga007,
               #      g_apga_d[l_i].apga007_desc,g_apga_d[l_i].apga003,    g_apga_d[l_i].apga010,
               #      g_apga_d[l_i].apga100,     g_apga_d[l_i].apga109,    g_apga_d[l_i].l_apga109103,
               #      g_apga_d[l_i].apga103,     g_apga_d[l_i].apga102,    g_apga_d[l_i].apga105,
               #      g_apga_d[l_i].apga104,     g_apga_d[l_i].l_paysum,   g_apga_d[l_i].l_unpay,
               #      g_apga_d[l_i].l_payback,   g_apga_d[l_i].l_unpayback,g_apga_d[l_i].l_apgb001
               #   )
               #   CALL aapq510_b_fill2(l_i)
               #   FOR l_i2 = 1 TO g_tmp_d.getLength()
               #      IF NOT cl_null(g_tmp_d[l_i2].prog)THEN
               #         IF cl_null(g_tmp_d[l_i2].l_103)THEN LET g_tmp_d[l_i2].l_103 = 0 END IF
               #         IF cl_null(g_tmp_d[l_i2].l_113)THEN LET g_tmp_d[l_i2].l_113 = 0 END IF
               #         LET l_sql = "SELECT gzzd005 FROM gzzd_t",
               #                     " WHERE gzzd001 = ? AND gzzd002 = '",g_lang,"'",
               #                     "   AND gzzd003 = ? AND gzzdstus = 'Y'"
               #         PREPARE get_title_pre FROM l_sql
               #         CASE
               #            WHEN g_tmp_d[l_i2].prog = '520'
               #               LET l_prog = 'cbo_l_prog.1'
               #            WHEN g_tmp_d[l_i2].prog = '530'
               #               LET l_prog = 'cbo_l_prog.2'
               #            WHEN g_tmp_d[l_i2].prog = '540'
               #               LET l_prog = 'cbo_l_prog.3'
               #            WHEN g_tmp_d[l_i2].prog = '550'
               #               LET l_prog = 'cbo_l_prog.4'
               #            WHEN g_tmp_d[l_i2].prog = '590'                           
               #               LET l_prog=  'cbo_l_prog.5'
               #            OTHERWISE 
               #               LET l_prog = ''
               #         END CASE
               #         EXECUTE get_title_pre USING g_prog,l_prog INTO g_tmp_d[l_i2].prog
               #         
               #         CASE
               #            WHEN g_tmp_d[l_i2].act = '1'
               #               LET l_prog = 'cbo_l_act.1'
               #            WHEN g_tmp_d[l_i2].act = '2'
               #               LET l_prog = 'cbo_l_act.2'
               #            WHEN g_tmp_d[l_i2].act = '3'
               #               LET l_prog = 'cbo_l_act.3'
               #            WHEN g_tmp_d[l_i2].act = '4'
               #               LET l_prog = 'cbo_l_act.4'
               #            WHEN g_tmp_d[l_i2].act = '5'                           
               #               LET l_prog=  'cbo_l_act.5'
               #            WHEN g_tmp_d[l_i2].act = '6'                           
               #               LET l_prog=  'cbo_l_act.6'
               #            WHEN g_tmp_d[l_i2].act = '7'                           
               #               LET l_prog=  'cbo_l_act.7'                              
               #            OTHERWISE 
               #               LET l_prog = ''
               #         END CASE                        
               #         EXECUTE get_title_pre USING g_prog,l_prog INTO g_tmp_d[l_i2].act
               #         #161108-00017#2 mark ------
               #         #INSERT INTO aapq510_tmp02 VALUES(g_apga_d[l_i].apgacomp,g_apga_d[l_i].apgadocno,   #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp2 ——> aapq510_tmp02
               #         #                                 g_tmp_d[l_i2].*)
               #         #161108-00017#2 mark end---
               #         #161108-00017#2 add ------
               #         INSERT INTO aapq510_tmp02 (apgacomp,apgadocno,prog,docdt,docno,
               #                                    ver,act,l_103,l_113,accdoc,
               #                                    apca038,afmt140,afmt170,aapt430
               #                                   )
               #         VALUES (g_apga_d[l_i].apgacomp,g_apga_d[l_i].apgadocno,g_tmp_d[l_i2].prog,g_tmp_d[l_i2].docdt,g_tmp_d[l_i2].docno,
               #                 g_tmp_d[l_i2].ver,g_tmp_d[l_i2].act,g_tmp_d[l_i2].l_103,g_tmp_d[l_i2].l_113,g_tmp_d[l_i2].accdoc,
               #                 g_tmp_d[l_i2].apca038,g_tmp_d[l_i2].afmt140,g_tmp_d[l_i2].afmt170,g_tmp_d[l_i2].aapt430
               #                )
               #         #161108-00017#2 add end---
               #      END IF
               #   END FOR
               #END FOR    
               #CALL aapq510_x01(g_wc,'aapq510_tmp01','aapq510_tmp02')     #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01，aapq510_x01_tmp2 ——> aapq510_tmp02           
               #161221-00012#1 --e mark
               CALL aapq510_output() #161221-00012#1 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #161221-00012#1 --s mark
               #DELETE FROM aapq510_tmp01       #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
               #DELETE FROM aapq510_tmp02       #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp2 ——> aapq510_tmp02
               #FOR l_i = 1 TO g_apga_d.getLength()
               #   LET l_desc1 =  s_desc_gzcbl004_desc('8517',g_apga_d[l_i].apga006)
               #   #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
               #   INSERT INTO aapq510_tmp01 VALUES(
               #      g_input.l_apgacomp,g_input.l_final,g_input.l_orderby,
               #      g_apga_d[l_i].apgacomp,    g_apga_d[l_i].apgadocno,  g_apga_d[l_i].apga002,
               #      g_apga_d[l_i].apgadocdt,   g_apga_d[l_i].apga004,    g_apga_d[l_i].apga004_desc,
               #      g_apga_d[l_i].apga001,     l_desc1,                  g_apga_d[l_i].apga007,
               #      g_apga_d[l_i].apga007_desc,g_apga_d[l_i].apga003,    g_apga_d[l_i].apga010,
               #      g_apga_d[l_i].apga100,     g_apga_d[l_i].apga109,    g_apga_d[l_i].l_apga109103,
               #      g_apga_d[l_i].apga103,     g_apga_d[l_i].apga102,    g_apga_d[l_i].apga105,
               #      g_apga_d[l_i].apga104,     g_apga_d[l_i].l_paysum,   g_apga_d[l_i].l_unpay,
               #      g_apga_d[l_i].l_payback,   g_apga_d[l_i].l_unpayback,g_apga_d[l_i].l_apgb001
               #   )
               #   CALL aapq510_b_fill2(l_i)
               #   FOR l_i2 = 1 TO g_tmp_d.getLength()
               #      IF NOT cl_null(g_tmp_d[l_i2].prog)THEN
               #         IF cl_null(g_tmp_d[l_i2].l_103)THEN LET g_tmp_d[l_i2].l_103 = 0 END IF
               #         IF cl_null(g_tmp_d[l_i2].l_113)THEN LET g_tmp_d[l_i2].l_113 = 0 END IF
               #         LET l_sql = "SELECT gzzd005 FROM gzzd_t",
               #                     " WHERE gzzd001 = ? AND gzzd002 = '",g_lang,"'",
               #                     "   AND gzzd003 = ? AND gzzdstus = 'Y'"
               #         #PREPARE get_title_pre FROM l_sql   #161209-00012#2 mark
               #         PREPARE get_title_pre1 FROM l_sql   #161209-00012#2 add
               #         CASE
               #            WHEN g_tmp_d[l_i2].prog = '520'
               #               LET l_prog = 'cbo_l_prog.1'
               #            WHEN g_tmp_d[l_i2].prog = '530'
               #               LET l_prog = 'cbo_l_prog.2'
               #            WHEN g_tmp_d[l_i2].prog = '540'
               #               LET l_prog = 'cbo_l_prog.3'
               #            WHEN g_tmp_d[l_i2].prog = '550'
               #               LET l_prog = 'cbo_l_prog.4'
               #            WHEN g_tmp_d[l_i2].prog = '590'                           
               #               LET l_prog=  'cbo_l_prog.5'
               #            OTHERWISE 
               #               LET l_prog = ''
               #         END CASE
               #         #EXECUTE get_title_pre USING g_prog,l_prog INTO g_tmp_d[l_i2].prog #161209-00012#2 mark
               #         EXECUTE get_title_pre1 USING g_prog,l_prog INTO g_tmp_d[l_i2].prog #161209-00012#2 add
               #         CASE
               #            WHEN g_tmp_d[l_i2].act = '1'
               #               LET l_prog = 'cbo_l_act.1'
               #            WHEN g_tmp_d[l_i2].act = '2'
               #               LET l_prog = 'cbo_l_act.2'
               #            WHEN g_tmp_d[l_i2].act = '3'
               #               LET l_prog = 'cbo_l_act.3'
               #            WHEN g_tmp_d[l_i2].act = '4'
               #               LET l_prog = 'cbo_l_act.4'
               #            WHEN g_tmp_d[l_i2].act = '5'                           
               #               LET l_prog=  'cbo_l_act.5'
               #            WHEN g_tmp_d[l_i2].act = '6'                           
               #               LET l_prog=  'cbo_l_act.6'
               #            WHEN g_tmp_d[l_i2].act = '7'                           
               #               LET l_prog=  'cbo_l_act.7'                              
               #            OTHERWISE 
               #               LET l_prog = ''
               #         END CASE                        
               #         #EXECUTE get_title_pre USING g_prog,l_prog INTO g_tmp_d[l_i2].act #161209-00012#2 mark
               #         EXECUTE get_title_pre1 USING g_prog,l_prog INTO g_tmp_d[l_i2].act #161209-00012#2 add
               #         #161108-00017#2 mark ------
               #         #INSERT INTO aapq510_tmp02 VALUES(g_apga_d[l_i].apgacomp,g_apga_d[l_i].apgadocno,   #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp2 ——> aapq510_tmp02
               #         #                                 g_tmp_d[l_i2].*)
               #         #161108-00017#2 mark end---
               #         #161108-00017#2 add ------
               #         INSERT INTO aapq510_tmp02 (apgacomp,apgadocno,prog,docdt,docno,
               #                                    ver,act,l_103,l_113,accdoc,
               #                                    apca038,afmt140,afmt170,aapt430
               #                                   )
               #         VALUES (g_apga_d[l_i].apgacomp,g_apga_d[l_i].apgadocno,g_tmp_d[l_i2].prog,g_tmp_d[l_i2].docdt,g_tmp_d[l_i2].docno,
               #                 g_tmp_d[l_i2].ver,g_tmp_d[l_i2].act,g_tmp_d[l_i2].l_103,g_tmp_d[l_i2].l_113,g_tmp_d[l_i2].accdoc,
               #                 g_tmp_d[l_i2].apca038,g_tmp_d[l_i2].afmt140,g_tmp_d[l_i2].afmt170,g_tmp_d[l_i2].aapt430
               #                )
               #         #161108-00017#2 add end---
               #      END IF
               #   END FOR
               #END FOR    
               #CALL aapq510_x01(g_wc,'aapq510_tmp01','aapq510_tmp02')     #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01，aapq510_x01_tmp2 ——> aapq510_tmp02           
               #161221-00012#1 --e mark
               CALL aapq510_output() #161221-00012#1 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq510_query()
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
            CALL aapq510_filter()
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
            CALL aapq510_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_apga_d)
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
            CALL aapq510_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq510_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq510_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq510_b_fill()
 
         
         
 
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
 
{<section id="aapq510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq510_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL g_tmp_d.clear()
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_apga_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON apgacomp,apgadocno,apgadocdt,apga004,apga006,apga007,apga003,apga010,apga100, 
          apga109,apga103,apga102,apga105,apga104
           FROM s_detail1[1].b_apgacomp,s_detail1[1].b_apgadocno,s_detail1[1].b_apgadocdt,s_detail1[1].b_apga004, 
               s_detail1[1].b_apga006,s_detail1[1].b_apga007,s_detail1[1].b_apga003,s_detail1[1].b_apga010, 
               s_detail1[1].b_apga100,s_detail1[1].b_apga109,s_detail1[1].b_apga103,s_detail1[1].b_apga102, 
               s_detail1[1].b_apga105,s_detail1[1].b_apga104
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_apgacomp>>----
         #Ctrlp:construct.c.page1.b_apgacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgacomp
            #add-point:ON ACTION controlp INFIELD b_apgacomp name="construct.c.page1.b_apgacomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE            
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgacomp  #顯示到畫面上
            NEXT FIELD b_apgacomp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgacomp
            #add-point:BEFORE FIELD b_apgacomp name="construct.b.page1.b_apgacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgacomp
            
            #add-point:AFTER FIELD b_apgacomp name="construct.a.page1.b_apgacomp"
            
            #END add-point
            
 
 
         #----<<b_apgadocno>>----
         #Ctrlp:construct.c.page1.b_apgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgadocno
            #add-point:ON ACTION controlp INFIELD b_apgadocno name="construct.c.page1.b_apgadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apgacomp = '",g_input.l_apgacomp,"' "   #161115-00044#2   add
            CALL q_apgadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgadocno  #顯示到畫面上
            NEXT FIELD b_apgadocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgadocno
            #add-point:BEFORE FIELD b_apgadocno name="construct.b.page1.b_apgadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgadocno
            
            #add-point:AFTER FIELD b_apgadocno name="construct.a.page1.b_apgadocno"
            
            #END add-point
            
 
 
         #----<<b_apga002>>----
         #----<<b_apgadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apgadocdt
            #add-point:BEFORE FIELD b_apgadocdt name="construct.b.page1.b_apgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apgadocdt
            
            #add-point:AFTER FIELD b_apgadocdt name="construct.a.page1.b_apgadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgadocdt
            #add-point:ON ACTION controlp INFIELD b_apgadocdt name="construct.c.page1.b_apgadocdt"
            
            #END add-point
 
 
         #----<<b_apga004>>----
         #Ctrlp:construct.c.page1.b_apga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga004
            #add-point:ON ACTION controlp INFIELD b_apga004 name="construct.c.page1.b_apga004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apga004  #顯示到畫面上
            NEXT FIELD b_apga004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga004
            #add-point:BEFORE FIELD b_apga004 name="construct.b.page1.b_apga004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga004
            
            #add-point:AFTER FIELD b_apga004 name="construct.a.page1.b_apga004"
            
            #END add-point
            
 
 
         #----<<b_apga004_desc>>----
         #----<<b_apga001>>----
         #----<<b_apga006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga006
            #add-point:BEFORE FIELD b_apga006 name="construct.b.page1.b_apga006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga006
            
            #add-point:AFTER FIELD b_apga006 name="construct.a.page1.b_apga006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga006
            #add-point:ON ACTION controlp INFIELD b_apga006 name="construct.c.page1.b_apga006"
            
            #END add-point
 
 
         #----<<b_apga007>>----
         #Ctrlp:construct.c.page1.b_apga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga007
            #add-point:ON ACTION controlp INFIELD b_apga007 name="construct.c.page1.b_apga007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apga007  #顯示到畫面上
            NEXT FIELD b_apga007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga007
            #add-point:BEFORE FIELD b_apga007 name="construct.b.page1.b_apga007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga007
            
            #add-point:AFTER FIELD b_apga007 name="construct.a.page1.b_apga007"
            
            #END add-point
            
 
 
         #----<<b_apga007_desc>>----
         #----<<b_apga003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga003
            #add-point:BEFORE FIELD b_apga003 name="construct.b.page1.b_apga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga003
            
            #add-point:AFTER FIELD b_apga003 name="construct.a.page1.b_apga003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga003
            #add-point:ON ACTION controlp INFIELD b_apga003 name="construct.c.page1.b_apga003"
            
            #END add-point
 
 
         #----<<b_apga010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga010
            #add-point:BEFORE FIELD b_apga010 name="construct.b.page1.b_apga010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga010
            
            #add-point:AFTER FIELD b_apga010 name="construct.a.page1.b_apga010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga010
            #add-point:ON ACTION controlp INFIELD b_apga010 name="construct.c.page1.b_apga010"
            
            #END add-point
 
 
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
            
 
 
         #----<<b_apga109>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga109
            #add-point:BEFORE FIELD b_apga109 name="construct.b.page1.b_apga109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga109
            
            #add-point:AFTER FIELD b_apga109 name="construct.a.page1.b_apga109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga109
            #add-point:ON ACTION controlp INFIELD b_apga109 name="construct.c.page1.b_apga109"
            
            #END add-point
 
 
         #----<<l_apga109103>>----
         #----<<b_apga103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga103
            #add-point:BEFORE FIELD b_apga103 name="construct.b.page1.b_apga103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga103
            
            #add-point:AFTER FIELD b_apga103 name="construct.a.page1.b_apga103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga103
            #add-point:ON ACTION controlp INFIELD b_apga103 name="construct.c.page1.b_apga103"
            
            #END add-point
 
 
         #----<<b_apga102>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga102
            #add-point:BEFORE FIELD b_apga102 name="construct.b.page1.b_apga102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga102
            
            #add-point:AFTER FIELD b_apga102 name="construct.a.page1.b_apga102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga102
            #add-point:ON ACTION controlp INFIELD b_apga102 name="construct.c.page1.b_apga102"
            
            #END add-point
 
 
         #----<<b_apga105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga105
            #add-point:BEFORE FIELD b_apga105 name="construct.b.page1.b_apga105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga105
            
            #add-point:AFTER FIELD b_apga105 name="construct.a.page1.b_apga105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga105
            #add-point:ON ACTION controlp INFIELD b_apga105 name="construct.c.page1.b_apga105"
            
            #END add-point
 
 
         #----<<b_apga104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_apga104
            #add-point:BEFORE FIELD b_apga104 name="construct.b.page1.b_apga104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_apga104
            
            #add-point:AFTER FIELD b_apga104 name="construct.a.page1.b_apga104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_apga104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga104
            #add-point:ON ACTION controlp INFIELD b_apga104 name="construct.c.page1.b_apga104"
            
            #END add-point
 
 
         #----<<l_paysum>>----
         #----<<l_unpay>>----
         #----<<l_payback>>----
         #----<<l_unpayback>>----
         #----<<l_apgb001>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
           
      INPUT BY NAME g_input.l_apgacomp,g_input.l_final,g_input.l_orderby
                  ATTRIBUTE(WITHOUT DEFAULTS)
                  
         AFTER INPUT
         
         AFTER FIELD l_apgacomp
            IF NOT cl_null(g_input.l_apgacomp)THEN
               CALL aapq510_comp_chk(g_input.l_apgacomp)RETURNING g_sub_success,g_errno
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
         CALL aapq510_qbeclear()
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
         CALL aapq510_qbeclear()
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
   CALL aapq510_b_fill()
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
 
{<section id="aapq510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq510_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_str    STRING
   DEFINE l_sql    STRING
   DEFINE l_orderby STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_sql = "SELECT SUM(apgk103) FROM apgk_t ",
               " WHERE apgkent = ? AND apgkcomp = ? AND apgk005 = ? "
   PREPARE sel_apgkp1 FROM l_sql
   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE apgacomp,apgadocno,apga002,apgadocdt,apga004,'',apga001,apga006, 
       apga007,'',apga003,apga010,apga100,apga109,'',apga103,apga102,apga105,apga104,'','','','',''  , 
       DENSE_RANK() OVER( ORDER BY apga_t.apgacomp,apga_t.apgadocno) AS RANK FROM apga_t",
 
 
                     "",
                     " WHERE apgaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apga_t"),
                     " ORDER BY apga_t.apgacomp,apga_t.apgadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   CASE
      WHEN g_input.l_final = '0'
         LET ls_wc = ls_wc ," AND apga029 = 'N'"
      WHEN g_input.l_final = '1'
         LET ls_wc = ls_wc ," AND apga029 = 'Y'"
      WHEN g_input.l_final = '2'
         
   END CASE
   LET ls_wc = ls_wc ," AND apgacomp = '",g_input.l_apgacomp,"' AND apgastus = 'Y' "
   
   #(效能) 所以此處僅抓出符合筆數的邏輯
   LET ls_sql_rank = "SELECT apgacomp,apgadocno FROM apga_t ",
                     " WHERE apgaent = ? AND ",ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apga_t"),
                     " ORDER BY apga_t.apgacomp,apga_t.apgadocno"                     
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   CASE
      WHEN g_input.l_orderby = '1'
         LET l_orderby = " ORDER BY apga_t.apgacomp,apga_t.apgadocno"
      WHEN g_input.l_orderby = '2'
         LET l_orderby = " ORDER BY apga_t.apga007"
      WHEN g_input.l_orderby = '3'
         LET l_orderby = " ORDER BY apga_t.apga004"         
      OTHERWISE
         LET l_orderby = " ORDER BY apga_t.apgacomp,apga_t.apgadocno"
   END CASE
   

   
   #(效能)組上說明subquery並且給予別名方便外層查詢
   LET ls_sql_rank = "SELECT UNIQUE apgacomp,apgadocno,apga002,apgadocdt,apga004,",
                             "(SELECT pmaal003 FROM pmaal_t WHERE pmaalent = apgaent AND pmaal001 = apga004 AND pmaal002 = '",g_dlang,"') apga004_desc,",
                             "apga001,apga006, ",
                             "apga007,",
                             "(SELECT nmabl003 FROM nmabl_t WHERE nmablent = apgaent AND nmabl001 = apga007 AND nmabl002 = '",g_dlang,"') apga007_desc,",
                             "apga003,apga010,apga100,apga109,",
                             "0,",
                             "apga103,apga102,apga105,apga104,",
                             "(SELECT SUM(apgk103) FROM apgk_t WHERE apgkent = apgaent AND apgkcomp = apgacomp AND apgk005 = apgadocno) l_paysum,",
                             "0,",
                             "0,",
                             "0,",
                             "''  , ",
                             "DENSE_RANK() OVER( ",l_orderby,") AS RANK FROM apga_t",
                     " WHERE apgaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apga_t"),
                     l_orderby CLIPPED
                     #" ORDER BY apga_t.apgacomp,apga_t.apgadocno"
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
 
   LET g_sql = "SELECT apgacomp,apgadocno,apga002,apgadocdt,apga004,'',apga001,apga006,apga007,'',apga003, 
       apga010,apga100,apga109,'',apga103,apga102,apga105,apga104,'','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT apgacomp,apgadocno,apga002,apgadocdt,apga004,apga004_desc,apga001,apga006,apga007,apga007_desc,apga003, 
       apga010,apga100,apga109,0,apga103,apga102,apga105,apga104,l_paysum,0,0,0,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq510_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq510_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_apga_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_tmp_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_apga_d[l_ac].apgacomp,g_apga_d[l_ac].apgadocno,g_apga_d[l_ac].apga002, 
       g_apga_d[l_ac].apgadocdt,g_apga_d[l_ac].apga004,g_apga_d[l_ac].apga004_desc,g_apga_d[l_ac].apga001, 
       g_apga_d[l_ac].apga006,g_apga_d[l_ac].apga007,g_apga_d[l_ac].apga007_desc,g_apga_d[l_ac].apga003, 
       g_apga_d[l_ac].apga010,g_apga_d[l_ac].apga100,g_apga_d[l_ac].apga109,g_apga_d[l_ac].l_apga109103, 
       g_apga_d[l_ac].apga103,g_apga_d[l_ac].apga102,g_apga_d[l_ac].apga105,g_apga_d[l_ac].apga104,g_apga_d[l_ac].l_paysum, 
       g_apga_d[l_ac].l_unpay,g_apga_d[l_ac].l_payback,g_apga_d[l_ac].l_unpayback,g_apga_d[l_ac].l_apgb001 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_apga_d[l_ac].statepic = cl_get_actipic(g_apga_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      EXECUTE sel_apgkp1 USING g_enterprise,g_apga_d[l_ac].apgacomp,g_apga_d[l_ac].apgadocno 
         INTO g_apga_d[l_ac].l_paysum
      
      IF cl_null(g_apga_d[l_ac].apga109     )THEN   LET g_apga_d[l_ac].apga109       = 0 END IF
      IF cl_null(g_apga_d[l_ac].l_apga109103)THEN   LET g_apga_d[l_ac].l_apga109103  = 0 END IF
      IF cl_null(g_apga_d[l_ac].apga103     )THEN   LET g_apga_d[l_ac].apga103       = 0 END IF
      IF cl_null(g_apga_d[l_ac].apga102     )THEN   LET g_apga_d[l_ac].apga102       = 0 END IF
      IF cl_null(g_apga_d[l_ac].apga105     )THEN   LET g_apga_d[l_ac].apga105       = 0 END IF
      IF cl_null(g_apga_d[l_ac].apga104     )THEN   LET g_apga_d[l_ac].apga104       = 0 END IF
      IF cl_null(g_apga_d[l_ac].l_paysum    )THEN   LET g_apga_d[l_ac].l_paysum      = 0 END IF
      IF cl_null(g_apga_d[l_ac].l_unpay     )THEN   LET g_apga_d[l_ac].l_unpay       = 0 END IF
      IF cl_null(g_apga_d[l_ac].l_payback   )THEN   LET g_apga_d[l_ac].l_payback     = 0 END IF
      IF cl_null(g_apga_d[l_ac].l_unpayback )THEN   LET g_apga_d[l_ac].l_unpayback   = 0 END IF
      

      #未到單金額      
      LET g_apga_d[l_ac].l_unpay = g_apga_d[l_ac].apga109 - g_apga_d[l_ac].l_paysum
      
      #還款金額
      #
      
      #未還款金額
      LET g_apga_d[l_ac].l_unpayback = g_apga_d[l_ac].apga105 - g_apga_d[l_ac].l_payback
           
      CALL aapq510_get_apgb001_str(g_apga_d[l_ac].apgacomp,g_apga_d[l_ac].apgadocno)RETURNING l_str
      LET g_apga_d[l_ac].l_apgb001  = l_str CLIPPED
      #end add-point
 
      CALL aapq510_detail_show("'1'")      
 
      CALL aapq510_apga_t_mask()
 
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
   
 
   
   CALL g_apga_d.deleteElement(g_apga_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
  
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL aapq510_b_fill2(1)
   #end add-point
 
   LET g_detail_cnt = g_apga_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapq510_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq510_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq510_detail_action_trans()
 
   IF g_apga_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aapq510_fetch()
   END IF
   
      CALL aapq510_filter_show('apgacomp','b_apgacomp')
   CALL aapq510_filter_show('apgadocno','b_apgadocno')
   CALL aapq510_filter_show('apgadocdt','b_apgadocdt')
   CALL aapq510_filter_show('apga004','b_apga004')
   CALL aapq510_filter_show('apga006','b_apga006')
   CALL aapq510_filter_show('apga007','b_apga007')
   CALL aapq510_filter_show('apga003','b_apga003')
   CALL aapq510_filter_show('apga010','b_apga010')
   CALL aapq510_filter_show('apga100','b_apga100')
   CALL aapq510_filter_show('apga109','b_apga109')
   CALL aapq510_filter_show('apga103','b_apga103')
   CALL aapq510_filter_show('apga102','b_apga102')
   CALL aapq510_filter_show('apga105','b_apga105')
   CALL aapq510_filter_show('apga104','b_apga104')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq510_fetch()
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
 
{<section id="aapq510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq510_detail_show(ps_page)
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
            #LET g_ref_fields[1] = g_apga_d[l_ac].apga004
            #LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_apga_d[l_ac].apga004_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_apga_d[l_ac].apga004_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_apga_d[l_ac].apga007
            #LET ls_sql = "SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_apga_d[l_ac].apga007_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_apga_d[l_ac].apga007_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapq510_filter()
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
      CONSTRUCT g_wc_filter ON apgacomp,apgadocno,apgadocdt,apga004,apga006,apga007,apga003,apga010, 
          apga100,apga109,apga103,apga102,apga105,apga104
                          FROM s_detail1[1].b_apgacomp,s_detail1[1].b_apgadocno,s_detail1[1].b_apgadocdt, 
                              s_detail1[1].b_apga004,s_detail1[1].b_apga006,s_detail1[1].b_apga007,s_detail1[1].b_apga003, 
                              s_detail1[1].b_apga010,s_detail1[1].b_apga100,s_detail1[1].b_apga109,s_detail1[1].b_apga103, 
                              s_detail1[1].b_apga102,s_detail1[1].b_apga105,s_detail1[1].b_apga104
 
         BEFORE CONSTRUCT
                     DISPLAY aapq510_filter_parser('apgacomp') TO s_detail1[1].b_apgacomp
            DISPLAY aapq510_filter_parser('apgadocno') TO s_detail1[1].b_apgadocno
            DISPLAY aapq510_filter_parser('apgadocdt') TO s_detail1[1].b_apgadocdt
            DISPLAY aapq510_filter_parser('apga004') TO s_detail1[1].b_apga004
            DISPLAY aapq510_filter_parser('apga006') TO s_detail1[1].b_apga006
            DISPLAY aapq510_filter_parser('apga007') TO s_detail1[1].b_apga007
            DISPLAY aapq510_filter_parser('apga003') TO s_detail1[1].b_apga003
            DISPLAY aapq510_filter_parser('apga010') TO s_detail1[1].b_apga010
            DISPLAY aapq510_filter_parser('apga100') TO s_detail1[1].b_apga100
            DISPLAY aapq510_filter_parser('apga109') TO s_detail1[1].b_apga109
            DISPLAY aapq510_filter_parser('apga103') TO s_detail1[1].b_apga103
            DISPLAY aapq510_filter_parser('apga102') TO s_detail1[1].b_apga102
            DISPLAY aapq510_filter_parser('apga105') TO s_detail1[1].b_apga105
            DISPLAY aapq510_filter_parser('apga104') TO s_detail1[1].b_apga104
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_apgacomp>>----
         #Ctrlp:construct.c.page1.b_apgacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgacomp
            #add-point:ON ACTION controlp INFIELD b_apgacomp name="construct.c.filter.page1.b_apgacomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgacomp  #顯示到畫面上
            NEXT FIELD b_apgacomp                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_apgadocno>>----
         #Ctrlp:construct.c.page1.b_apgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgadocno
            #add-point:ON ACTION controlp INFIELD b_apgadocno name="construct.c.filter.page1.b_apgadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apgacomp = '",g_input.l_apgacomp,"' "   #161115-00044#2   add
            CALL q_apgadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apgadocno  #顯示到畫面上
            NEXT FIELD b_apgadocno                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_apga002>>----
         #----<<b_apgadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_apgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apgadocdt
            #add-point:ON ACTION controlp INFIELD b_apgadocdt name="construct.c.filter.page1.b_apgadocdt"
            
            #END add-point
 
 
         #----<<b_apga004>>----
         #Ctrlp:construct.c.page1.b_apga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga004
            #add-point:ON ACTION controlp INFIELD b_apga004 name="construct.c.filter.page1.b_apga004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apga004  #顯示到畫面上
            NEXT FIELD b_apga004                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_apga004_desc>>----
         #----<<b_apga001>>----
         #----<<b_apga006>>----
         #Ctrlp:construct.c.filter.page1.b_apga006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga006
            #add-point:ON ACTION controlp INFIELD b_apga006 name="construct.c.filter.page1.b_apga006"
            
            #END add-point
 
 
         #----<<b_apga007>>----
         #Ctrlp:construct.c.page1.b_apga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga007
            #add-point:ON ACTION controlp INFIELD b_apga007 name="construct.c.filter.page1.b_apga007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apga007  #顯示到畫面上
            NEXT FIELD b_apga007                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_apga007_desc>>----
         #----<<b_apga003>>----
         #Ctrlp:construct.c.filter.page1.b_apga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga003
            #add-point:ON ACTION controlp INFIELD b_apga003 name="construct.c.filter.page1.b_apga003"
            
            #END add-point
 
 
         #----<<b_apga010>>----
         #Ctrlp:construct.c.filter.page1.b_apga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga010
            #add-point:ON ACTION controlp INFIELD b_apga010 name="construct.c.filter.page1.b_apga010"
            
            #END add-point
 
 
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
            NEXT FIELD b_apga100                     #返回原欄位
            #END add-point
 
 
         #----<<b_apga109>>----
         #Ctrlp:construct.c.filter.page1.b_apga109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga109
            #add-point:ON ACTION controlp INFIELD b_apga109 name="construct.c.filter.page1.b_apga109"
            
            #END add-point
 
 
         #----<<l_apga109103>>----
         #----<<b_apga103>>----
         #Ctrlp:construct.c.filter.page1.b_apga103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga103
            #add-point:ON ACTION controlp INFIELD b_apga103 name="construct.c.filter.page1.b_apga103"
            
            #END add-point
 
 
         #----<<b_apga102>>----
         #Ctrlp:construct.c.filter.page1.b_apga102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga102
            #add-point:ON ACTION controlp INFIELD b_apga102 name="construct.c.filter.page1.b_apga102"
            
            #END add-point
 
 
         #----<<b_apga105>>----
         #Ctrlp:construct.c.filter.page1.b_apga105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga105
            #add-point:ON ACTION controlp INFIELD b_apga105 name="construct.c.filter.page1.b_apga105"
            
            #END add-point
 
 
         #----<<b_apga104>>----
         #Ctrlp:construct.c.filter.page1.b_apga104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apga104
            #add-point:ON ACTION controlp INFIELD b_apga104 name="construct.c.filter.page1.b_apga104"
            
            #END add-point
 
 
         #----<<l_paysum>>----
         #----<<l_unpay>>----
         #----<<l_payback>>----
         #----<<l_unpayback>>----
         #----<<l_apgb001>>----
   
 
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
   
      CALL aapq510_filter_show('apgacomp','b_apgacomp')
   CALL aapq510_filter_show('apgadocno','b_apgadocno')
   CALL aapq510_filter_show('apgadocdt','b_apgadocdt')
   CALL aapq510_filter_show('apga004','b_apga004')
   CALL aapq510_filter_show('apga006','b_apga006')
   CALL aapq510_filter_show('apga007','b_apga007')
   CALL aapq510_filter_show('apga003','b_apga003')
   CALL aapq510_filter_show('apga010','b_apga010')
   CALL aapq510_filter_show('apga100','b_apga100')
   CALL aapq510_filter_show('apga109','b_apga109')
   CALL aapq510_filter_show('apga103','b_apga103')
   CALL aapq510_filter_show('apga102','b_apga102')
   CALL aapq510_filter_show('apga105','b_apga105')
   CALL aapq510_filter_show('apga104','b_apga104')
 
    
   CALL aapq510_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapq510_filter_parser(ps_field)
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
 
{<section id="aapq510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq510_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.insert" >}
#+ insert
PRIVATE FUNCTION aapq510_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapq510.modify" >}
#+ modify
PRIVATE FUNCTION aapq510_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aapq510_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.delete" >}
#+ delete
PRIVATE FUNCTION aapq510_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aapq510.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq510_detail_action_trans()
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
 
{<section id="aapq510.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq510_detail_index_setting()
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
            IF g_apga_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apga_d.getLength() AND g_apga_d.getLength() > 0
            LET g_detail_idx = g_apga_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apga_d.getLength() THEN
               LET g_detail_idx = g_apga_d.getLength()
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
 
{<section id="aapq510.mask_functions" >}
 &include "erp/aap/aapq510_mask.4gl"
 
{</section>}
 
{<section id="aapq510.other_function" readonly="Y" >}

PRIVATE FUNCTION aapq510_preparedeclare()
   DEFINE l_sql    STRING
   
   LET l_sql = "SELECT DISTINCT apgb001 FROM apgb_t ",
               " WHERE apgbent = ? AND apgbcomp = ? AND apgbdocno = ? "
   PREPARE sel_apgbp1 FROM l_sql
   DECLARE sel_apgbc1 CURSOR FOR sel_apgbp1
   

   
   
END FUNCTION

PRIVATE FUNCTION aapq510_qbeclear()
   DEFINE l_ld   LIKE glaa_t.glaald

   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_input.l_apgacomp,l_ld
   LET g_input.l_apgacomp_desc = s_desc_get_department_desc(g_input.l_apgacomp)
   LET g_input.l_final = '0'
   LET g_input.l_orderby = '1'
   DISPLAY BY NAME g_input.l_apgacomp,g_input.l_apgacomp_desc,g_input.l_final,g_input.l_orderby
END FUNCTION

PRIVATE FUNCTION aapq510_get_apgb001_str(p_apgacomp,p_apgadocno)
   DEFINE p_apgacomp   LIKE apga_t.apgacomp
   DEFINE p_apgadocno  LIKE apga_t.apgadocno
   DEFINE r_str        STRING
   DEFINE l_apgb001    LIKE apgb_t.apgb001
   LET r_str = NULL
   
   FOREACH sel_apgbc1 USING g_enterprise,p_apgacomp,p_apgadocno INTO l_apgb001
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF 
      IF cl_null(r_str)THEN
         LET r_str = l_apgb001
      ELSE
         LET r_str = r_str,'/',l_apgb001
      END IF
   END FOREACH
   RETURN r_str
END FUNCTION

PRIVATE FUNCTION aapq510_create_tmp()
   CREATE TEMP TABLE aapq510_tmp1(
      prog      VARCHAR(20),
      docdt     DATE,
      docno     VARCHAR(30),
      ver       SMALLINT,
      act       VARCHAR(10),
      l_103     DECIMAL(20,6),
      l_113     DECIMAL(20,6),
      accdoc    VARCHAR(30),
      apca038   VARCHAR(20),
      afmt140   VARCHAR(20),
      afmt170   VARCHAR(20),
      aapt430   VARCHAR(20)
   )

   CREATE TEMP TABLE aapq510_tmp01(   #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
      l_apgacomp  VARCHAR(10),
      l_final     VARCHAR(100),
      l_orderby   VARCHAR(100),
      apgacomp  VARCHAR(10), 
      apgadocno  VARCHAR(20), 
      apga002  INTEGER, 
      apgadocdt  DATE, 
      apga004  VARCHAR(10), 
      apga004_desc  VARCHAR(500), 
      apga001  VARCHAR(20), 
      apga006  VARCHAR(100), 
      apga007  VARCHAR(15), 
      apga007_desc  VARCHAR(500), 
      apga003  DATE, 
      apga010  DATE, 
      apga100  VARCHAR(10), 
      apga109  DECIMAL(20,6), 
      l_apga109103  DECIMAL(20,6), 
      apga103  DECIMAL(20,6), 
      apga102  DECIMAL(20,6), 
      apga105  DECIMAL(20,6), 
      apga104  DECIMAL(20,6), 
      l_paysum  DECIMAL(20,6), 
      l_unpay  DECIMAL(20,6), 
      l_payback  DECIMAL(20,6), 
      l_unpayback  DECIMAL(20,6), 
      l_apgb001  VARCHAR(500)
      )
   #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp2 ——> aapq510_tmp02   
   CREATE TEMP TABLE aapq510_tmp02(   
      apgacomp  VARCHAR(10), 
      apgadocno  VARCHAR(20), 
      prog      VARCHAR(1000),
      docdt     DATE,
      docno     VARCHAR(30),
      ver       SMALLINT,
      act       VARCHAR(1000),
      l_103     DECIMAL(20,6),
      l_113     DECIMAL(20,6),
      accdoc    VARCHAR(30),
      apca038   VARCHAR(20),
      afmt140   VARCHAR(20),
      afmt170   VARCHAR(20),
      aapt430   VARCHAR(20)
      )
END FUNCTION

PRIVATE FUNCTION aapq510_b_fill2(p_ac)
   DEFINE p_ac    LIKE type_t.num10
   DEFINE l_sql   STRING
   DEFINE l_tmp   RECORD
                  prog     LIKE type_t.chr20,
                  docdt    LIKE type_t.dat,
                  docno    LIKE type_t.chr30,
                  ver      LIKE type_t.num5,
                  act      LIKE type_t.chr10,
                  l_103    LIKE type_t.num20_6,
                  l_113    LIKE type_t.num20_6,
                  accdoc   LIKE type_t.chr30,
                  apca038  LIKE apca_t.apca038,
                  afmt140  LIKE apca_t.apcadocno,
                  afmt170  LIKE apca_t.apcadocno,
                  aapt430  LIKE apca_t.apcadocno   
                  END RECORD
   DEFINE l_idx   LIKE type_t.num10
   
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   DELETE FROM aapq510_tmp1
   #變更單#1開狀金額
   LET l_sql = "SELECT '520',apgddocdt,apgddocno,apgd002,'1',apgd103,",
               "       (SELECT SUM(apgc113) FROM apgc_t WHERE apgcent = apgdent AND apgccomp = apgdcomp AND apgcdocno = apgddocno AND apgc900 = apgd900),",
               "       apgd028,",
               "       (SELECT apca038 FROM apca_t WHERE apcaent = apgdent AND apcadocno = apgddocno ),",
               "       '','','' ",
               "  FROM apgd_t ",
               " WHERE apgdent = ",g_enterprise," ",
               "   AND apgdcomp = ? ",
               "   AND apgddocno = ? "
   PREPARE sel_apgdp1 FROM l_sql
   DECLARE sel_apgdc1 CURSOR FOR sel_apgdp1
   
   FOREACH sel_apgdc1 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
   END FOREACH
   #變更單#2自備款金額
   LET l_sql = "SELECT '520',apgddocdt,apgddocno,apgd002,'2',apgd104,",
               "       0,",
               "       '',",
               "       '',",
               "       '','','' ",
               "  FROM apgd_t ",
               " WHERE apgdent = ",g_enterprise," ",
               "   AND apgdcomp = ? ",
               "   AND apgddocno = ? "
   PREPARE sel_apgdp2 FROM l_sql
   DECLARE sel_apgdc2 CURSOR FOR sel_apgdp2
   
   FOREACH sel_apgdc2 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
      
   END FOREACH
   
   
   #裝運單#3裝運金額
   LET l_sql = "SELECT '530',apgidocdt,apgidocno,'','3',(SELECT SUM(apgj103) FROM apgj_t WHERE apgjent = apgient AND apgjcomp = apgicomp AND apgjdocno = apgidocno),",
               "       (SELECT SUM(apgc113) FROM apgc_t WHERE apgcent = apgient AND apgccomp = apgicomp AND apgcdocno = apgidocno AND apgc900 = 0),",
               "       '',",
               "       '',",
               "       '','','' ",
               "  FROM apgi_t ",
               " WHERE apgient = ",g_enterprise," ",
               "   AND apgicomp = ? ",
               "   AND apgi002 = ? "
   PREPARE sel_apgip1 FROM l_sql
   DECLARE sel_apgic1 CURSOR FOR sel_apgip1
   
   FOREACH sel_apgic1 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
      
   END FOREACH 


   #到貨#4到貨金額
   LET l_sql = "SELECT '550',apgldocdt,apgldocno,'','4',apgl103,",
               "       (SELECT SUM(apgc113) FROM apgc_t WHERE apgcent = apglent AND apgccomp = apglcomp AND apgcdocno = apgldocno AND apgc900 = 0),",
               "       '',",
               "       '',",
               "       '','','' ",
               "  FROM apgl_t ",
               " WHERE apglent = ",g_enterprise," ",
               "   AND apglcomp = ? ",
               "   AND apgl004 = ? "
   PREPARE sel_apglp1 FROM l_sql
   DECLARE sel_apglc1 CURSOR FOR sel_apglp1
   
   FOREACH sel_apglc1 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
      
   END FOREACH
   
   #到單#5押匯金額
   LET l_sql = "SELECT '540',apgkdocdt,apgkdocno,'','5',apgk103,",
               "       (SELECT SUM(apgc113) FROM apgc_t WHERE apgcent = apgkent AND apgccomp = apgkcomp AND apgcdocno = apgkdocno AND apgc900 = 0),",
               "       '',",
               "       '',",
               "       apgk009,'','' ",
               "  FROM apgk_t ",
               " WHERE apgkent = ",g_enterprise," ",
               "   AND apgkcomp = ? ",
               "   AND apgk005 = ? "
   PREPARE sel_apgkp2 FROM l_sql
   DECLARE sel_apgkc2 CURSOR FOR sel_apgkp2
   
   FOREACH sel_apgkc2 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
      
   END FOREACH 
   
   #結案#6退還自備款
   LET l_sql = "SELECT '590',apgndocdt,apgndocno,'','1',apgn108,",
               "       (SELECT SUM(apgc113) FROM apgc_t WHERE apgcent = apgnent AND apgccomp = apgncomp AND apgcdocno = apgndocno AND apgn900 = 0),",
               "       '',",
               "       '',",
               "       '','','' ",
               "  FROM apgn_t ",
               " WHERE apgnent = ",g_enterprise," ",
               "   AND apgncomp = ? ",
               "   AND apgndocno = ? "
   PREPARE sel_apgnp1 FROM l_sql
   DECLARE sel_apgnc1 CURSOR FOR sel_apgnp1
   
   FOREACH sel_apgnc1 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
      
   END FOREACH
   
   #結案#7退還保證金
   LET l_sql = "SELECT '590',apgndocdt,apgndocno,'','1',apgn109,",
               "       0,",
               "       '',",
               "       '',",
               "       '','','' ",
               "  FROM apgn_t ",
               " WHERE apgnent = ",g_enterprise," ",
               "   AND apgncomp = ? ",
               "   AND apgndocno = ? "
   PREPARE sel_apgnp2 FROM l_sql
   DECLARE sel_apgnc2 CURSOR FOR sel_apgnp2
   
   FOREACH sel_apgnc2 USING g_apga_d[p_ac].apgacomp,g_apga_d[p_ac].apgadocno
      INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #INSERT INTO aapq510_tmp1 VALUES(l_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq510_tmp1 (prog,docdt,docno,ver,act,
                                l_103,l_113,accdoc,apca038,afmt140,
                                afmt170,aapt430
                               )
      VALUES (l_tmp.prog,l_tmp.docdt,l_tmp.docno,l_tmp.ver,l_tmp.act,
              l_tmp.l_103,l_tmp.l_113,l_tmp.accdoc,l_tmp.apca038,l_tmp.afmt140,
              l_tmp.afmt170,l_tmp.aapt430
             )
      #161108-00017#2 add end---
      
   END FOREACH
   
   LET l_idx = 1
   LET l_sql = "SELECT prog,docdt,docno,ver,act,l_103,l_113,accdoc,apca038,afmt140,afmt170",
               "  FROM aapq510_tmp1 ",
               " ORDER BY docdt,docno,ver,act"
   PREPARE sel_tmpp1 FROM l_sql
   DECLARE sel_tmpc1 CURSOR FOR sel_tmpp1
   CALL g_tmp_d.clear()
   FOREACH sel_tmpc1 INTO g_tmp_d[l_idx].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      LET l_idx = l_idx + 1
      
   END FOREACH 
END FUNCTION

PRIVATE FUNCTION aapq510_comp_chk(p_apgacomp)
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

################################################################################
# Descriptions...: 設計器現已改調規範，
#                  會將「列印(output)」段add-pointn內容複製至quickprint段對應內容， 
#                  故原來的程式碼放至新增的共同列印處理function中，
#                  在output段改成call function名
# Memo...........: #161221-00012#1
# Usage..........: CALL aapq510_output()
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 201612/21 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq510_output()
DEFINE l_i        LIKE type_t.num10
DEFINE l_i2       LIKE type_t.num10
DEFINE l_desc1    LIKE type_t.chr100
DEFINE l_sql      STRING
DEFINE l_prog     LIKE type_t.chr100

DELETE FROM aapq510_tmp01       #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
DELETE FROM aapq510_tmp02       #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp2 ——> aapq510_tmp02
   
   FOR l_i = 1 TO g_apga_d.getLength()
      LET l_desc1 =  s_desc_gzcbl004_desc('8517',g_apga_d[l_i].apga006)
      #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01
      INSERT INTO aapq510_tmp01 VALUES(
         g_input.l_apgacomp,g_input.l_final,g_input.l_orderby,
         g_apga_d[l_i].apgacomp,    g_apga_d[l_i].apgadocno,  g_apga_d[l_i].apga002,
         g_apga_d[l_i].apgadocdt,   g_apga_d[l_i].apga004,    g_apga_d[l_i].apga004_desc,
         g_apga_d[l_i].apga001,     l_desc1,                  g_apga_d[l_i].apga007,
         g_apga_d[l_i].apga007_desc,g_apga_d[l_i].apga003,    g_apga_d[l_i].apga010,
         g_apga_d[l_i].apga100,     g_apga_d[l_i].apga109,    g_apga_d[l_i].l_apga109103,
         g_apga_d[l_i].apga103,     g_apga_d[l_i].apga102,    g_apga_d[l_i].apga105,
         g_apga_d[l_i].apga104,     g_apga_d[l_i].l_paysum,   g_apga_d[l_i].l_unpay,
         g_apga_d[l_i].l_payback,   g_apga_d[l_i].l_unpayback,g_apga_d[l_i].l_apgb001
      )
      CALL aapq510_b_fill2(l_i)
      FOR l_i2 = 1 TO g_tmp_d.getLength()
         IF NOT cl_null(g_tmp_d[l_i2].prog)THEN
            IF cl_null(g_tmp_d[l_i2].l_103)THEN LET g_tmp_d[l_i2].l_103 = 0 END IF
            IF cl_null(g_tmp_d[l_i2].l_113)THEN LET g_tmp_d[l_i2].l_113 = 0 END IF
            LET l_sql = "SELECT gzzd005 FROM gzzd_t",
                        " WHERE gzzd001 = ? AND gzzd002 = '",g_lang,"'",
                        "   AND gzzd003 = ? AND gzzdstus = 'Y'"
            PREPARE get_title_pre FROM l_sql
            CASE
               WHEN g_tmp_d[l_i2].prog = '520'
                  LET l_prog = 'cbo_l_prog.1'
               WHEN g_tmp_d[l_i2].prog = '530'
                  LET l_prog = 'cbo_l_prog.2'
               WHEN g_tmp_d[l_i2].prog = '540'
                  LET l_prog = 'cbo_l_prog.3'
               WHEN g_tmp_d[l_i2].prog = '550'
                  LET l_prog = 'cbo_l_prog.4'
               WHEN g_tmp_d[l_i2].prog = '590'                           
                  LET l_prog=  'cbo_l_prog.5'
               OTHERWISE 
                  LET l_prog = ''
            END CASE
            EXECUTE get_title_pre USING g_prog,l_prog INTO g_tmp_d[l_i2].prog
            
            CASE
               WHEN g_tmp_d[l_i2].act = '1'
                  LET l_prog = 'cbo_l_act.1'
               WHEN g_tmp_d[l_i2].act = '2'
                  LET l_prog = 'cbo_l_act.2'
               WHEN g_tmp_d[l_i2].act = '3'
                  LET l_prog = 'cbo_l_act.3'
               WHEN g_tmp_d[l_i2].act = '4'
                  LET l_prog = 'cbo_l_act.4'
               WHEN g_tmp_d[l_i2].act = '5'                           
                  LET l_prog=  'cbo_l_act.5'
               WHEN g_tmp_d[l_i2].act = '6'                           
                  LET l_prog=  'cbo_l_act.6'
               WHEN g_tmp_d[l_i2].act = '7'                           
                  LET l_prog=  'cbo_l_act.7'                              
               OTHERWISE 
                  LET l_prog = ''
            END CASE                        
            EXECUTE get_title_pre USING g_prog,l_prog INTO g_tmp_d[l_i2].act 
   
            INSERT INTO aapq510_tmp02 (apgacomp,apgadocno,prog,docdt,docno,
                                       ver,act,l_103,l_113,accdoc,
                                       apca038,afmt140,afmt170,aapt430
                                      )
            VALUES (g_apga_d[l_i].apgacomp,g_apga_d[l_i].apgadocno,g_tmp_d[l_i2].prog,g_tmp_d[l_i2].docdt,g_tmp_d[l_i2].docno,
                    g_tmp_d[l_i2].ver,g_tmp_d[l_i2].act,g_tmp_d[l_i2].l_103,g_tmp_d[l_i2].l_113,g_tmp_d[l_i2].accdoc,
                    g_tmp_d[l_i2].apca038,g_tmp_d[l_i2].afmt140,g_tmp_d[l_i2].afmt170,g_tmp_d[l_i2].aapt430
                   )
         END IF
      END FOR
   END FOR    
   CALL aapq510_x01(g_wc,'aapq510_tmp01','aapq510_tmp02')     #临时表长度超过15码的减少到15码以下 aapq510_x01_tmp1 ——> aapq510_tmp01，aapq510_x01_tmp2 ——> aapq510_tmp02
END FUNCTION

 
{</section>}
 
