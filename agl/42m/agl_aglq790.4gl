#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq790.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2017-01-03 17:21:53), PR版次:0009(2017-01-17 09:45:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000214
#+ Filename...: aglq790
#+ Description: 傳票細項立帳明細查詢作業
#+ Creator....: 02599(2014-03-27 16:34:40)
#+ Modifier...: 02599 -SD/PR- 07900
 
{</section>}
 
{<section id="aglq790.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160302-00006#1  2016/03/02 By 07675  原本单身为不可查询作业，取消单身二次筛选功能
#160913-00017#4  2016/09/21 By 07900  AGL模组调整交易客商开窗
#161021-00037#2  2016/10/24 By 06821   組織類型與職能開窗調整
#170103-00048#1  2017/01/03 By 02599  修改画面上下笔按钮，使查询资料可以根据单头资料上下翻页
#170113-00041#1  2017/01/17 By 07900  5区，QBE中科目编号开窗，应加条件 细项立冲科目（ glad003=Y）
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
PRIVATE TYPE type_g_glay_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glaydocdt LIKE glay_t.glaydocdt, 
   glaydocno LIKE glay_t.glaydocno, 
   glayseq LIKE glay_t.glayseq, 
   glay010 LIKE glay_t.glay010, 
   glay003 LIKE glay_t.glay003, 
   glay052 LIKE glay_t.glay052, 
   glay054 LIKE glay_t.glay054, 
   glay008 LIKE glay_t.glay008, 
   glapcrtid LIKE glap_t.glapcrtid, 
   glapcrtid_desc LIKE type_t.chr500, 
   glapstus LIKE glap_t.glapstus, 
   glay001 LIKE glay_t.glay001 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
DEFINE g_max_period    LIKE glav_t.glav006
#查询条件定义
DEFINE tm              RECORD
       curr_o          LIKE type_t.chr1,  #顯示外幣
       show_num        LIKE type_t.chr1,  #顯示數量
       ctype           LIKE type_t.chr1  #多本位幣
       END RECORD
DEFINE g_glaxdocno     LIKE glax_t.glaxdocno
DEFINE g_glaxseq       LIKE glax_t.glaxseq
DEFINE g_glax_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glaxdocno       LIKE glax_t.glaxdocno,
       glaxseq         LIKE glax_t.glaxseq
      END RECORD 
DEFINE g_current_row   LIKE type_t.num5 
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glay_d
DEFINE g_master_t                   type_g_glay_d
DEFINE g_glay_d          DYNAMIC ARRAY OF type_g_glay_d
DEFINE g_glay_d_t        type_g_glay_d
 
      
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
 
{<section id="aglq790.main" >}
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
   CALL cl_ap_init("agl","")
 
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
   DECLARE aglq790_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq790_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq790_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq790 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq790_init()   
 
      #進入選單 Menu (="N")
      CALL aglq790_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq790
      
   END IF 
   
   CLOSE aglq790_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq790.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq790_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('b_glapstus','13','N,Y,S,A,D,R,W,X')
 
   
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_detail_idx  = 1
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF      
   CALL aglq790_glaald_desc(g_glaald)
   CALL cl_set_combo_scc('glax061','6013')
   #end add-point
 
   CALL aglq790_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq790.default_search" >}
PRIVATE FUNCTION aglq790_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glayld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glaydocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glayseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glayseq1 = '", g_argv[04], "' AND "
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
 
{<section id="aglq790.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq790_ui_dialog()
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
      CALL aglq790_b_fill()
   ELSE
      CALL aglq790_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glay_d.clear()
 
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
 
         CALL aglq790_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glay_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq790_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq790_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
#170103-00048#1--mod--str--
#               DISPLAY g_current_idx TO FORMONLY.h_index
#               DISPLAY g_glax_s.getLength() TO FORMONLY.h_count
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               DISPLAY g_glay_d.getLength() TO FORMONLY.cnt
               CALL aglq790_idx_chk()
#170103-00048#1--mod--end
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq790_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("filter",FALSE)    #160302-00006#1  2016/03/02 By 07675 
            IF g_header_cnt=1 OR g_header_cnt=0 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE) 
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE) 
                  CALL cl_set_act_visible("jump,next,last", TRUE) 
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE) 
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE) 
                     CALL cl_set_act_visible("next,last", FALSE) 
                  END IF
               END IF
            END IF
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
               CALL aglq790_query()
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exchange_ld
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN
               
               #add-point:ON ACTION exchange_ld name="menu.exchange_ld"
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glax_s.clear()
                  CALL g_glay_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq790_glaald_desc(g_glaald)
               DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
                       tm.curr_o,tm.show_num,tm.ctype
                    TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
                       curr_o,show_num,ctype
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq790_filter()
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
            CALL aglq790_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glay_d)
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
            CALL aglq790_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq790_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq790_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq790_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glay_d.getLength()
               LET g_glay_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
 
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glay_d.getLength()
               LET g_glay_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glay_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glay_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glay_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glay_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION qbeclear
            CLEAR FORM 
            CALL aglq790_glaald_desc(g_glaald)
            CALL aglq790_query1()
            EXIT DIALOG
         
         #170103-00048#1--add--str--
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglq790_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq790_idx_chk()
            EXIT DIALOG
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglq790_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq790_idx_chk()
            EXIT DIALOG
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglq790_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq790_idx_chk()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglq790_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq790_idx_chk()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglq790_fetch1('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq790_idx_chk()
            EXIT DIALOG
         #170103-00048#1--add--end
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
 
{<section id="aglq790.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq790_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL aglq790_query1()
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glay_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glaydocdt,glaydocno,glayseq,glay010,glay003,glay052,glay054,glay008,glapcrtid, 
          glapstus,glay001
           FROM s_detail1[1].b_glaydocdt,s_detail1[1].b_glaydocno,s_detail1[1].b_glayseq,s_detail1[1].b_glay010, 
               s_detail1[1].b_glay003,s_detail1[1].b_glay052,s_detail1[1].b_glay054,s_detail1[1].b_glay008, 
               s_detail1[1].b_glapcrtid,s_detail1[1].b_glapstus,s_detail1[1].b_glay001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glaydocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaydocdt
            #add-point:BEFORE FIELD b_glaydocdt name="construct.b.page1.b_glaydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaydocdt
            
            #add-point:AFTER FIELD b_glaydocdt name="construct.a.page1.b_glaydocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaydocdt
            #add-point:ON ACTION controlp INFIELD b_glaydocdt name="construct.c.page1.b_glaydocdt"
            
            #END add-point
 
 
         #----<<b_glaydocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaydocno
            #add-point:BEFORE FIELD b_glaydocno name="construct.b.page1.b_glaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaydocno
            
            #add-point:AFTER FIELD b_glaydocno name="construct.a.page1.b_glaydocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaydocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaydocno
            #add-point:ON ACTION controlp INFIELD b_glaydocno name="construct.c.page1.b_glaydocno"
            
            #END add-point
 
 
         #----<<b_glayseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glayseq
            #add-point:BEFORE FIELD b_glayseq name="construct.b.page1.b_glayseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glayseq
            
            #add-point:AFTER FIELD b_glayseq name="construct.a.page1.b_glayseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glayseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glayseq
            #add-point:ON ACTION controlp INFIELD b_glayseq name="construct.c.page1.b_glayseq"
            
            #END add-point
 
 
         #----<<b_glay010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glay010
            #add-point:BEFORE FIELD b_glay010 name="construct.b.page1.b_glay010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glay010
            
            #add-point:AFTER FIELD b_glay010 name="construct.a.page1.b_glay010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay010
            #add-point:ON ACTION controlp INFIELD b_glay010 name="construct.c.page1.b_glay010"
            
            #END add-point
 
 
         #----<<b_glay003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glay003
            #add-point:BEFORE FIELD b_glay003 name="construct.b.page1.b_glay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glay003
            
            #add-point:AFTER FIELD b_glay003 name="construct.a.page1.b_glay003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay003
            #add-point:ON ACTION controlp INFIELD b_glay003 name="construct.c.page1.b_glay003"
            
            #END add-point
 
 
         #----<<b_glay052>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glay052
            #add-point:BEFORE FIELD b_glay052 name="construct.b.page1.b_glay052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glay052
            
            #add-point:AFTER FIELD b_glay052 name="construct.a.page1.b_glay052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glay052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay052
            #add-point:ON ACTION controlp INFIELD b_glay052 name="construct.c.page1.b_glay052"
            
            #END add-point
 
 
         #----<<b_glay054>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glay054
            #add-point:BEFORE FIELD b_glay054 name="construct.b.page1.b_glay054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glay054
            
            #add-point:AFTER FIELD b_glay054 name="construct.a.page1.b_glay054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glay054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay054
            #add-point:ON ACTION controlp INFIELD b_glay054 name="construct.c.page1.b_glay054"
            
            #END add-point
 
 
         #----<<b_glay008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glay008
            #add-point:BEFORE FIELD b_glay008 name="construct.b.page1.b_glay008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glay008
            
            #add-point:AFTER FIELD b_glay008 name="construct.a.page1.b_glay008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay008
            #add-point:ON ACTION controlp INFIELD b_glay008 name="construct.c.page1.b_glay008"
            
            #END add-point
 
 
         #----<<b_glapcrtid>>----
         #Ctrlp:construct.c.page1.b_glapcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapcrtid
            #add-point:ON ACTION controlp INFIELD b_glapcrtid name="construct.c.page1.b_glapcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapcrtid  #顯示到畫面上
            NEXT FIELD b_glapcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapcrtid
            #add-point:BEFORE FIELD b_glapcrtid name="construct.b.page1.b_glapcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapcrtid
            
            #add-point:AFTER FIELD b_glapcrtid name="construct.a.page1.b_glapcrtid"
            
            #END add-point
            
 
 
         #----<<b_glapcrtid_desc>>----
         #----<<b_glapstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapstus
            #add-point:BEFORE FIELD b_glapstus name="construct.b.page1.b_glapstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapstus
            
            #add-point:AFTER FIELD b_glapstus name="construct.a.page1.b_glapstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glapstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapstus
            #add-point:ON ACTION controlp INFIELD b_glapstus name="construct.c.page1.b_glapstus"
            
            #END add-point
 
 
         #----<<b_glay001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glay001
            #add-point:BEFORE FIELD b_glay001 name="construct.b.page1.b_glay001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glay001
            
            #add-point:AFTER FIELD b_glay001 name="construct.a.page1.b_glay001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glay001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay001
            #add-point:ON ACTION controlp INFIELD b_glay001 name="construct.c.page1.b_glay001"
            
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
   CALL aglq790_b_fill()
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
 
{<section id="aglq790.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq790_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glaydocdt,glaydocno,glayseq,glay010,glay003,glay052,glay054, 
       glay008,'','','',glay001  ,DENSE_RANK() OVER( ORDER BY glay_t.glayld,glay_t.glaydocno,glay_t.glayseq, 
       glay_t.glayseq1) AS RANK FROM glay_t",
 
 
                     "",
                     " WHERE glayent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glay_t"),
                     " ORDER BY glay_t.glayld,glay_t.glaydocno,glay_t.glayseq,glay_t.glayseq1"
 
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
 
   LET g_sql = "SELECT '',glaydocdt,glaydocno,glayseq,glay010,glay003,glay052,glay054,glay008,'','', 
       '',glay001",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq790_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq790_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glay_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glay_d[l_ac].sel,g_glay_d[l_ac].glaydocdt,g_glay_d[l_ac].glaydocno,g_glay_d[l_ac].glayseq, 
       g_glay_d[l_ac].glay010,g_glay_d[l_ac].glay003,g_glay_d[l_ac].glay052,g_glay_d[l_ac].glay054,g_glay_d[l_ac].glay008, 
       g_glay_d[l_ac].glapcrtid,g_glay_d[l_ac].glapcrtid_desc,g_glay_d[l_ac].glapstus,g_glay_d[l_ac].glay001 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glay_d[l_ac].statepic = cl_get_actipic(g_glay_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq790_detail_show("'1'")      
 
      CALL aglq790_glay_t_mask()
 
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
   
 
   
   CALL g_glay_d.deleteElement(g_glay_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glay_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq790_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq790_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq790_detail_action_trans()
 
   IF g_glay_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq790_fetch()
   END IF
   
      CALL aglq790_filter_show('glaydocdt','b_glaydocdt')
   CALL aglq790_filter_show('glaydocno','b_glaydocno')
   CALL aglq790_filter_show('glayseq','b_glayseq')
   CALL aglq790_filter_show('glay010','b_glay010')
   CALL aglq790_filter_show('glay003','b_glay003')
   CALL aglq790_filter_show('glay052','b_glay052')
   CALL aglq790_filter_show('glay054','b_glay054')
   CALL aglq790_filter_show('glay008','b_glay008')
   CALL aglq790_filter_show('glapcrtid','b_glapcrtid')
   CALL aglq790_filter_show('glapstus','b_glapstus')
   CALL aglq790_filter_show('glay001','b_glay001')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq790_fetch()
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
 
{<section id="aglq790.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq790_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_glay_d[l_ac].glapcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_glay_d[l_ac].glapcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glay_d[l_ac].glapcrtid_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq790_filter()
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
      CONSTRUCT g_wc_filter ON glaydocdt,glaydocno,glayseq,glay010,glay003,glay052,glay054,glay008,glapcrtid, 
          glapstus,glay001
                          FROM s_detail1[1].b_glaydocdt,s_detail1[1].b_glaydocno,s_detail1[1].b_glayseq, 
                              s_detail1[1].b_glay010,s_detail1[1].b_glay003,s_detail1[1].b_glay052,s_detail1[1].b_glay054, 
                              s_detail1[1].b_glay008,s_detail1[1].b_glapcrtid,s_detail1[1].b_glapstus, 
                              s_detail1[1].b_glay001
 
         BEFORE CONSTRUCT
                     DISPLAY aglq790_filter_parser('glaydocdt') TO s_detail1[1].b_glaydocdt
            DISPLAY aglq790_filter_parser('glaydocno') TO s_detail1[1].b_glaydocno
            DISPLAY aglq790_filter_parser('glayseq') TO s_detail1[1].b_glayseq
            DISPLAY aglq790_filter_parser('glay010') TO s_detail1[1].b_glay010
            DISPLAY aglq790_filter_parser('glay003') TO s_detail1[1].b_glay003
            DISPLAY aglq790_filter_parser('glay052') TO s_detail1[1].b_glay052
            DISPLAY aglq790_filter_parser('glay054') TO s_detail1[1].b_glay054
            DISPLAY aglq790_filter_parser('glay008') TO s_detail1[1].b_glay008
            DISPLAY aglq790_filter_parser('glapcrtid') TO s_detail1[1].b_glapcrtid
            DISPLAY aglq790_filter_parser('glapstus') TO s_detail1[1].b_glapstus
            DISPLAY aglq790_filter_parser('glay001') TO s_detail1[1].b_glay001
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glaydocdt>>----
         #Ctrlp:construct.c.filter.page1.b_glaydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaydocdt
            #add-point:ON ACTION controlp INFIELD b_glaydocdt name="construct.c.filter.page1.b_glaydocdt"
            
            #END add-point
 
 
         #----<<b_glaydocno>>----
         #Ctrlp:construct.c.filter.page1.b_glaydocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaydocno
            #add-point:ON ACTION controlp INFIELD b_glaydocno name="construct.c.filter.page1.b_glaydocno"
            
            #END add-point
 
 
         #----<<b_glayseq>>----
         #Ctrlp:construct.c.filter.page1.b_glayseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glayseq
            #add-point:ON ACTION controlp INFIELD b_glayseq name="construct.c.filter.page1.b_glayseq"
            
            #END add-point
 
 
         #----<<b_glay010>>----
         #Ctrlp:construct.c.filter.page1.b_glay010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay010
            #add-point:ON ACTION controlp INFIELD b_glay010 name="construct.c.filter.page1.b_glay010"
            
            #END add-point
 
 
         #----<<b_glay003>>----
         #Ctrlp:construct.c.filter.page1.b_glay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay003
            #add-point:ON ACTION controlp INFIELD b_glay003 name="construct.c.filter.page1.b_glay003"
            
            #END add-point
 
 
         #----<<b_glay052>>----
         #Ctrlp:construct.c.filter.page1.b_glay052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay052
            #add-point:ON ACTION controlp INFIELD b_glay052 name="construct.c.filter.page1.b_glay052"
            
            #END add-point
 
 
         #----<<b_glay054>>----
         #Ctrlp:construct.c.filter.page1.b_glay054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay054
            #add-point:ON ACTION controlp INFIELD b_glay054 name="construct.c.filter.page1.b_glay054"
            
            #END add-point
 
 
         #----<<b_glay008>>----
         #Ctrlp:construct.c.filter.page1.b_glay008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay008
            #add-point:ON ACTION controlp INFIELD b_glay008 name="construct.c.filter.page1.b_glay008"
            
            #END add-point
 
 
         #----<<b_glapcrtid>>----
         #Ctrlp:construct.c.page1.b_glapcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapcrtid
            #add-point:ON ACTION controlp INFIELD b_glapcrtid name="construct.c.filter.page1.b_glapcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapcrtid  #顯示到畫面上
            NEXT FIELD b_glapcrtid                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glapcrtid_desc>>----
         #----<<b_glapstus>>----
         #Ctrlp:construct.c.filter.page1.b_glapstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapstus
            #add-point:ON ACTION controlp INFIELD b_glapstus name="construct.c.filter.page1.b_glapstus"
            
            #END add-point
 
 
         #----<<b_glay001>>----
         #Ctrlp:construct.c.filter.page1.b_glay001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glay001
            #add-point:ON ACTION controlp INFIELD b_glay001 name="construct.c.filter.page1.b_glay001"
            
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
   
      CALL aglq790_filter_show('glaydocdt','b_glaydocdt')
   CALL aglq790_filter_show('glaydocno','b_glaydocno')
   CALL aglq790_filter_show('glayseq','b_glayseq')
   CALL aglq790_filter_show('glay010','b_glay010')
   CALL aglq790_filter_show('glay003','b_glay003')
   CALL aglq790_filter_show('glay052','b_glay052')
   CALL aglq790_filter_show('glay054','b_glay054')
   CALL aglq790_filter_show('glay008','b_glay008')
   CALL aglq790_filter_show('glapcrtid','b_glapcrtid')
   CALL aglq790_filter_show('glapstus','b_glapstus')
   CALL aglq790_filter_show('glay001','b_glay001')
 
    
   CALL aglq790_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq790_filter_parser(ps_field)
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
 
{<section id="aglq790.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq790_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq790_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.insert" >}
#+ insert
PRIVATE FUNCTION aglq790_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq790.modify" >}
#+ modify
PRIVATE FUNCTION aglq790_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq790_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.delete" >}
#+ delete
PRIVATE FUNCTION aglq790_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq790.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq790_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   #170103-00048#1--add--str--
   DISPLAY g_current_idx TO FORMONLY.h_index
   DISPLAY g_header_cnt TO FORMONLY.h_count
   RETURN
   #170103-00048#1--add--end
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
 
{<section id="aglq790.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq790_detail_index_setting()
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
            IF g_glay_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glay_d.getLength() AND g_glay_d.getLength() > 0
            LET g_detail_idx = g_glay_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glay_d.getLength() THEN
               LET g_detail_idx = g_glay_d.getLength()
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
 
{<section id="aglq790.mask_functions" >}
 &include "erp/agl/aglq790_mask.4gl"
 
{</section>}
 
{<section id="aglq790.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq790_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/04/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
   
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF   
   #多本位幣
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
#         LET tm.ctype=''
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
#         LET tm.ctype='1'
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
#         LET tm.ctype='2'  
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
#         LET tm.ctype='3'
   END CASE
   LET tm.ctype='0'
   CALL aglq790_set_curr_show() #顯示本位幣二、本位幣三
   LET tm.curr_o='N'
   CALL cl_set_comp_visible('glax005,b_glay010',FALSE)
   CALL cl_set_comp_visible('lbl_ocurr,glax010,glax045,glax046,amt',FALSE)
   CALL cl_set_comp_visible('lbl_amt01,lbl_amt02,lbl_amt03,lbl_amt04',TRUE)
   LET tm.show_num='N'
   CALL cl_set_comp_visible('glax007,b_glay008',FALSE)
   CALL cl_set_comp_visible('lbl_num,glax008,glax043,glax044,num',FALSE)
END FUNCTION

################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq790_set_curr_show()
# Date & Author..: 2014/04/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      CALL cl_set_comp_visible("b_glay052",TRUE)
      CALL cl_set_comp_visible("lbl_curr2,glax052,glax053,glax054,amt2",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glay052",FALSE)
      CALL cl_set_comp_visible("lbl_curr2,glax052,glax053,glax054,amt2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      CALL cl_set_comp_visible("b_glay054",TRUE)
      CALL cl_set_comp_visible("lbl_curr3,glax056,glax057,glax058,amt3",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glay054",FALSE)
      CALL cl_set_comp_visible("lbl_curr3,glax056,glax057,glax058,amt3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible("b_glay052,b_glay054",TRUE)
      CALL cl_set_comp_visible("lbl_curr2,glax052,glax053,glax054,amt2",TRUE)
      CALL cl_set_comp_visible("lbl_curr3,glax056,glax057,glax058,amt3",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL aglq790_query1()
# Date & Author..: 2014/04/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_query1()
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
      CONSTRUCT BY NAME g_wc ON glax002,glaxdocno,glaxseq,glaxdocdt,glax017,glax018,glax019,glax020,
                                glax021,glax022,glax023,glax024,glax025,glax027,glax028,
                                glax061,glax062,glax063,glax001

         BEFORE CONSTRUCT
            
         ON ACTION controlp INFIELD glax002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'"
            LET g_qryparam.where = g_qryparam.where," AND EXISTS(SELECT 1 FROM glad_t WHERE gladent = glacent AND glad001 = glac002 AND gladld ='",g_glaald,"' AND glad003 ='Y')" #170113-00041#1 add xul
            CALL aglt310_04()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax002  #顯示到畫面上
            NEXT FIELD glax002                     #返回原欄位
            
         ON ACTION controlp INFIELD glaxdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glaxld = '",g_glaald,"'"
            CALL q_glaxdocno()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaxdocno  #顯示到畫面上
            NEXT FIELD glaxdocno                     #返回原欄位

         ON ACTION controlp INFIELD glax017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#2 add
            CALL q_ooef001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax017  #顯示到畫面上
            NEXT FIELD glax017                     #返回原欄位

         ON ACTION controlp INFIELD glax018
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax018  #顯示到畫面上
            NEXT FIELD glax018                     #返回原欄位


         ON ACTION controlp INFIELD glax019
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax019  #顯示到畫面上
            NEXT FIELD glax019                     #返回原欄位

         ON ACTION controlp INFIELD glax020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax020  #顯示到畫面上
            NEXT FIELD glax020                     #返回原欄位

         ON ACTION controlp INFIELD glax021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO glax021  #顯示到畫面上
            NEXT FIELD glax021                     #返回原欄位

         ON ACTION controlp INFIELD glax022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO glax022  #顯示到畫面上
            NEXT FIELD glax022                     #返回原欄位

         ON ACTION controlp INFIELD glax023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax023  #顯示到畫面上
            NEXT FIELD glax023                     #返回原欄位

         ON ACTION controlp INFIELD glax024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax024  #顯示到畫面上
            NEXT FIELD glax024                     #返回原欄位

         ON ACTION controlp INFIELD glax025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax025  #顯示到畫面上
            NEXT FIELD glax025                     #返回原欄位

#         ON ACTION controlp INFIELD glax026
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_bgaa001()                       #呼叫開窗
#            DISPLAY g_qryparam.return1 TO glax026  #顯示到畫面上
#            NEXT FIELD glax026                     #返回原欄位
         #渠道
         ON ACTION controlp INFIELD glax062
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax062  #顯示到畫面上
            NEXT FIELD glax062                     #返回原欄位
            
         #品牌
         ON ACTION controlp INFIELD glax063
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='2002'
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glax063  #顯示到畫面上
            NEXT FIELD glax063                     #返回原欄位
      END CONSTRUCT

      INPUT BY NAME tm.curr_o,tm.show_num,tm.ctype
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         ON CHANGE curr_o 
            IF tm.curr_o MATCHES '[yYnN]' THEN
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('glax005,b_glay010',TRUE)
                  CALL cl_set_comp_visible('lbl_ocurr,glax010,glax045,glax046,amt',TRUE)
               ELSE
                  CALL cl_set_comp_visible('glax005,b_glay010',FALSE)
                  CALL cl_set_comp_visible('lbl_ocurr,glax010,glax045,glax046,amt',FALSE)
                  CALL cl_set_comp_visible('lbl_amt01,lbl_amt02,lbl_amt03,lbl_amt04',TRUE)
               END IF                  
            ELSE
               NEXT FIELD curr_o
            END IF
         
         ON CHANGE show_num 
            IF tm.show_num MATCHES '[yYnN]' THEN
               IF tm.show_num='Y' THEN
                  CALL cl_set_comp_visible('glax007,b_glay008',TRUE)
                  CALL cl_set_comp_visible('lbl_num,glax008,glax043,glax044,num',TRUE)
               ELSE
                  CALL cl_set_comp_visible('glax007,b_glay008',FALSE)
                  CALL cl_set_comp_visible('lbl_num,glax008,glax043,glax044,num',FALSE)
               END IF                  
            ELSE
               NEXT FIELD show_num
            END IF
            
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq790_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
      END INPUT
      
      BEFORE DIALOG
        #預設
        DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
                tm.curr_o,tm.show_num,tm.ctype
             TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
                curr_o,show_num,ctype
      
      ON ACTION qbeclear
         CLEAR FORM 
         CALL aglq790_glaald_desc(g_glaald)
         DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
                tm.curr_o,tm.show_num,tm.ctype
             TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
                curr_o,show_num,ctype
                
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
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   CALL aglq790_set_page()
   CALL aglq790_fetch1('F')
#170103-00048#1--mark--str--
#   DISPLAY g_current_idx TO FORMONLY.h_index
#   DISPLAY g_glax_s.getLength() TO FORMONLY.h_count
#   DISPLAY g_detail_idx TO FORMONLY.idx
#   DISPLAY g_glay_d.getLength() TO FORMONLY.cnt
#170103-00048#1--mark--end
END FUNCTION

################################################################################
# Descriptions...: 顯示單頭資料
# Memo...........:
# Usage..........: CALL aglq790_show()
# Date & Author..: 2013/04/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_show()
   DEFINE l_desc          STRING
   #161128-00061#1----modify------begin-----------
   #DEFINE l_glax          RECORD LIKE glax_t.*
   DEFINE l_glax RECORD  #傳票項次立帳異動檔
       glaxent LIKE glax_t.glaxent, #企業編號
       glaxownid LIKE glax_t.glaxownid, #資料所有者
       glaxowndp LIKE glax_t.glaxowndp, #資料所屬部門
       glaxcrtid LIKE glax_t.glaxcrtid, #資料建立者
       glaxcrtdp LIKE glax_t.glaxcrtdp, #資料建立部門
       glaxcrtdt LIKE glax_t.glaxcrtdt, #資料創建日
       glaxmodid LIKE glax_t.glaxmodid, #資料修改者
       glaxmoddt LIKE glax_t.glaxmoddt, #最近修改日
       glaxcnfid LIKE glax_t.glaxcnfid, #資料確認者
       glaxcnfdt LIKE glax_t.glaxcnfdt, #資料確認日
       glaxstus LIKE glax_t.glaxstus, #狀態碼
       glaxld LIKE glax_t.glaxld, #帳套
       glaxcomp LIKE glax_t.glaxcomp, #法人
       glaxdocno LIKE glax_t.glaxdocno, #單號
       glaxseq LIKE glax_t.glaxseq, #項次
       glaxdocdt LIKE glax_t.glaxdocdt, #單據日期
       glax001 LIKE glax_t.glax001, #摘要
       glax002 LIKE glax_t.glax002, #科目編號
       glax003 LIKE glax_t.glax003, #本幣立帳金額
       glax005 LIKE glax_t.glax005, #交易幣別
       glax006 LIKE glax_t.glax006, #匯率
       glax007 LIKE glax_t.glax007, #計價單位
       glax008 LIKE glax_t.glax008, #立帳數量
       glax009 LIKE glax_t.glax009, #單價
       glax010 LIKE glax_t.glax010, #原幣立帳金額
       glax011 LIKE glax_t.glax011, #票據號碼
       glax012 LIKE glax_t.glax012, #票據日期
       glax013 LIKE glax_t.glax013, #申請人
       glax014 LIKE glax_t.glax014, #銀行帳號
       glax015 LIKE glax_t.glax015, #結算方式
       glax016 LIKE glax_t.glax016, #收支專案
       glax017 LIKE glax_t.glax017, #營運據點
       glax018 LIKE glax_t.glax018, #部門
       glax019 LIKE glax_t.glax019, #利潤/成本中心
       glax020 LIKE glax_t.glax020, #區域
       glax021 LIKE glax_t.glax021, #收付款客商
       glax022 LIKE glax_t.glax022, #帳款客商
       glax023 LIKE glax_t.glax023, #客群
       glax024 LIKE glax_t.glax024, #產品類別
       glax025 LIKE glax_t.glax025, #人員
       glax026 LIKE glax_t.glax026, #no use
       glax027 LIKE glax_t.glax027, #專案編號
       glax028 LIKE glax_t.glax028, #WBS
       glax029 LIKE glax_t.glax029, #自由核算項一
       glax030 LIKE glax_t.glax030, #自由核算項二
       glax031 LIKE glax_t.glax031, #自由核算項三
       glax032 LIKE glax_t.glax032, #自由核算項四
       glax033 LIKE glax_t.glax033, #自由核算項五
       glax034 LIKE glax_t.glax034, #自由核算項六
       glax035 LIKE glax_t.glax035, #自由核算項七
       glax036 LIKE glax_t.glax036, #自由核算項八
       glax037 LIKE glax_t.glax037, #自由核算項九
       glax038 LIKE glax_t.glax038, #自由核算項十
       glax041 LIKE glax_t.glax041, #本幣預沖金額
       glax042 LIKE glax_t.glax042, #本幣已沖金額
       glax043 LIKE glax_t.glax043, #預沖數量
       glax044 LIKE glax_t.glax044, #已沖數量
       glax045 LIKE glax_t.glax045, #原幣預沖金額
       glax046 LIKE glax_t.glax046, #原幣已沖金額
       glax047 LIKE glax_t.glax047, #資料來源
       glax048 LIKE glax_t.glax048, #原始憑證號碼
       glax049 LIKE glax_t.glax049, #會計年度
       glax050 LIKE glax_t.glax050, #會計期別
       glax051 LIKE glax_t.glax051, #匯率(本位幣二)
       glax052 LIKE glax_t.glax052, #立帳金額(本位幣二)
       glax053 LIKE glax_t.glax053, #預沖金額(本位幣二)
       glax054 LIKE glax_t.glax054, #已沖金額(本位幣二)
       glax055 LIKE glax_t.glax055, #匯率(本位幣三)
       glax056 LIKE glax_t.glax056, #立帳金額(本位幣三)
       glax057 LIKE glax_t.glax057, #預沖金額(本位幣三)
       glax058 LIKE glax_t.glax058, #已沖金額(本位幣三)
       glax061 LIKE glax_t.glax061, #經營方式
       glax062 LIKE glax_t.glax062, #渠道
       glax063 LIKE glax_t.glax063  #品牌
       END RECORD
   #161128-00061#1----modify------end-----------
   DEFINE l_amt           LIKE glax_t.glax010
   DEFINE l_amt1          LIKE glax_t.glax003
   DEFINE l_amt2          LIKE glax_t.glax052
   DEFINE l_amt3          LIKE glax_t.glax056
   DEFINE l_num           LIKE glax_t.glax008
   DEFINE l_ooag011       LIKE ooag_t.ooag011
   #161128-00061#1----modify------begin-----------   
   #SELECT glax_t.* INTO l_glax.* 
   SELECT glaxent,glaxownid,glaxowndp,glaxcrtid,glaxcrtdp,glaxcrtdt,glaxmodid,glaxmoddt,glaxcnfid,
          glaxcnfdt,glaxstus,glaxld,glaxcomp,glaxdocno,glaxseq,glaxdocdt,glax001,glax002,glax003,
          glax005,glax006,glax007,glax008,glax009,glax010,glax011,glax012,glax013,glax014,glax015,
          glax016,glax017,glax018,glax019,glax020,glax021,glax022,glax023,glax024,glax025,glax026,
          glax027,glax028,glax029,glax030,glax031,glax032,glax033,glax034,glax035,glax036,glax037,
          glax038,glax041,glax042,glax043,glax044,glax045,glax046,glax047,glax048,glax049,glax050,
          glax051,glax052,glax053,glax054,glax055,glax056,glax057,glax058,glax061,glax062,glax063 INTO l_glax.* 
   #161128-00061#1----modify------end-----------
     FROM glax_t
    WHERE glaxent=g_enterprise AND glaxld=g_glaald
      AND glaxdocno=g_glaxdocno AND glaxseq=g_glaxseq
   #顯示外幣  
   IF tm.curr_o='Y' THEN
      DISPLAY l_glax.glax005 TO glax005
   END IF
   #顯示數量   
   IF tm.show_num='Y' THEN
      DISPLAY l_glax.glax007 TO glax007
   END IF    
   
   DISPLAY l_glax.glax002,g_glaxdocno,g_glaxseq,l_glax.glaxdocdt,l_glax.glax001,
           l_glax.glax017,l_glax.glax018,l_glax.glax019,l_glax.glax020,l_glax.glax021,l_glax.glax022,
           l_glax.glax023,l_glax.glax024,l_glax.glax025,l_glax.glax027,l_glax.glax028,
           l_glax.glax061,l_glax.glax062,l_glax.glax063,l_glax.glax001
        TO glax002,glaxdocno,glaxseq,glaxdocdt,glax001,
           glax017,glax018,glax019,glax020,glax021,glax022,
           glax023,glax024,glax025,glax027,glax028,
           glax061,glax062,glax063,glax001
   
   #科目編號
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glax.glax002
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glacl004
   
   #營運據點
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =l_glax.glax017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax017_desc
   #部門
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =l_glax.glax018
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax018_desc
   #成本中心
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =l_glax.glax019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax019_desc
   #區域
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '287'
   LET g_ref_fields[2] = l_glax.glax020
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax020_desc
   #交易客戶
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glax.glax021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax021_desc
   #帳款客戶
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glax.glax022
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax022_desc
   #客群
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '281'
   LET g_ref_fields[2] = l_glax.glax023
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax023_desc
   #產品類別
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glax.glax024
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax024_desc
   #人員編號
   SELECT ooag011 INTO l_ooag011 FROM ooag_t 
    WHERE ooagent = g_enterprise AND ooag001 = l_glax.glax025
   DISPLAY l_ooag011 TO glax025_desc
#   #預算編號
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = l_glax.glax026
#   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET l_desc=g_rtn_fields[1]
#   DISPLAY l_desc TO glax026_desc
   #渠道
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glax.glax062
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax062_desc
   #品牌
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = '2002'
   LET g_ref_fields[2] = l_glax.glax063
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc=g_rtn_fields[1]
   DISPLAY l_desc TO glax063_desc
   #立沖餘額
   LET l_amt =l_glax.glax010-l_glax.glax046-l_glax.glax045
   LET l_amt1=l_glax.glax003-l_glax.glax042-l_glax.glax041
   LET l_amt2=l_glax.glax052-l_glax.glax054-l_glax.glax053
   LET l_amt3=l_glax.glax056-l_glax.glax057-l_glax.glax058
   LET l_num =l_glax.glax008-l_glax.glax044-l_glax.glax043
   DISPLAY l_glax.glax010,l_glax.glax046,l_glax.glax045,
           l_glax.glax003,l_glax.glax042,l_glax.glax041,
           l_glax.glax052,l_glax.glax054,l_glax.glax053,
           l_glax.glax056,l_glax.glax057,l_glax.glax058,
           l_glax.glax008,l_glax.glax044,l_glax.glax043,
           l_amt,l_amt1,l_amt2,l_amt3,l_num
        TO glax010,glax046,glax045,
           glax003,glax042,glax041,
           glax052,glax054,glax053,
           glax056,glax057,glax058,
           glax008,glax044,glax043,
           amt,amt1,amt2,amt3,num
END FUNCTION

################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL aglq790_set_page()
# Date & Author..: 2014/04/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glax_s.clear()
   
   LET l_sql="SELECT DISTINCT glaxdocno,glaxseq FROM glax_t",
             " WHERE glaxent=",g_enterprise," AND glaxld='",g_glaald,"'",
             "   AND ",g_wc,
             " ORDER BY glaxdocno,glaxseq  "
   PREPARE aglq790_sel_s_pr FROM l_sql
   DECLARE aglq790_sel_s_cs CURSOR FOR aglq790_sel_s_pr
   LET l_idx=1
   FOREACH aglq790_sel_s_cs INTO g_glax_s[l_idx].glaxdocno,g_glax_s[l_idx].glaxseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH aglq790_sel_s_cs'
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_idx=l_idx+1
      IF l_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET l_idx = l_idx - 1
   CALL g_glax_s.deleteElement(g_glax_s.getLength())
   LET g_header_cnt = l_idx
   LET g_rec_b = l_idx
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 抓取下一筆資料
# Memo...........:
# Usage..........: CALL aglq790_fetch1(p_flag)
# Input parameter: p_flag            
# Date & Author..: 2014/4/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_fetch1(p_flag)
   DEFINE p_flag   LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE l_cnt    LIKE type_t.num5
   
   IF g_header_cnt = 0 THEN
      CALL g_glay_d.clear()
      LET g_current_idx = 0
      LET g_detail_idx = 0
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_glax_s.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_glax_s.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_glax_s.getLength() THEN
      LET g_current_idx = g_glax_s.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_glaxdocno = g_glax_s[g_current_idx].glaxdocno 
   LET g_glaxseq = g_glax_s[g_current_idx].glaxseq
   CALL aglq790_b_fill1()
   CALL aglq790_show()
END FUNCTION

################################################################################
# Descriptions...: 填充单身资料
# Memo...........:
# Usage..........: CALL aglq790_b_fill1()
# Date & Author..: 2014/04/01 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_b_fill1()
   LET g_sql=" SELECT glaydocdt,glaydocno,glayseq,glay010,glay003,",
             "        glay052,glay054,glay008,'','','',glay001 ",
             "   FROM glay_t ",
             "  WHERE glayent=",g_enterprise,"  AND glayld='",g_glaald,"'",
             "    AND glay041='",g_glaxdocno,"' AND glay042=",g_glaxseq,
             "  ORDER BY glaydocdt,glaydocno,glayseq "
   PREPARE aglq790_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq790_pb1
  
   CALL g_glay_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs1 INTO g_glay_d[l_ac].glaydocdt,g_glay_d[l_ac].glaydocno,g_glay_d[l_ac].glayseq, 
       g_glay_d[l_ac].glay010,g_glay_d[l_ac].glay003,g_glay_d[l_ac].glay052,g_glay_d[l_ac].glay054,g_glay_d[l_ac].glay008, 
       g_glay_d[l_ac].glapcrtid,g_glay_d[l_ac].glapcrtid_desc,g_glay_d[l_ac].glapstus,g_glay_d[l_ac].glay001 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      SELECT glapcrtid,glapstus INTO g_glay_d[l_ac].glapcrtid,g_glay_d[l_ac].glapstus
        FROM glap_t
       WHERE glapent=g_enterprise AND glapld=g_glaald
         AND glapdocno=g_glay_d[l_ac].glaydocno
      #人員編號
      SELECT ooag011 INTO g_glay_d[l_ac].glapcrtid_desc FROM ooag_t 
      WHERE ooagent = g_enterprise AND ooag001 = g_glay_d[l_ac].glapcrtid
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   LET l_ac=l_ac-1
   CALL g_glay_d.deleteElement(g_glay_d.getLength())   
 
   LET g_detail_cnt = l_ac 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
      
   LET l_ac = 1
END FUNCTION

################################################################################
# Descriptions...: 显示光标所在位置
# Memo...........: #170103-00048#1 add
# Usage..........: CALL aglq790_idx_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 2017/01/03 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq790_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_glay_d.getLength() THEN
         LET g_detail_idx = g_glay_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glay_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glay_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION

 
{</section>}
 
