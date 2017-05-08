#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:13(2015-12-01 10:09:54), PR版次:0013(2017-02-13 09:35:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: aglq510
#+ Description: 總帳與子系統自動鉤稽
#+ Creator....: 02599(2015-10-29 15:07:19)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq510.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160302-00006#1   2016/03/02 By 07675   原本单身为可查询作业，增加二次筛选功能    
#160318-00025#7   2016/04/20 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160728-00003#1   2016/07/28 By 02599   AR/AP时,子系统金额取自月结档xrea_t,取金额是需判断若来源类型是2*，则金额*-1
#161021-00014#1   2016/10/21 By 02599   从三诺回收aglq510到产中
#161124-00078#1   2016/11/25 By 01727   TY-P31-20161123001此單據於aapt310已付款沖帳,不知為何底稿與總帳差異會有此筆,且差異金額=0
#161125-00026#1   2016/11/30 By 02599   固资模组交易币别依账套本币呈现，抓取总账余额档金额时，不用考虑原币，直接汇总本币金额，原币金额=本币金额
#161208-00011#1   2016/12/12 By 02114   销退/仓退暂估单用负数呈现
#161209-00052#1   2016/12/14 By 01531   期末在製的檢核，改成依　料、工、費　明細取值（ｘｃｃｄ）去對應總帳的科目（ａｇｌｉ１６１）
#161216-00027#1   2016/12/21 By 01531   1.固资财产科目子系统固定资产编号金额被双倍了。导致有差异。  
#                                       2.查询累折科目固定资产编号aglq510中金额与afaq150中10月累计折旧金融不一致。
#161217-00001#1   2016/12/21 By 01531   成本裏只會存本幣, 不會存原始交易幣,故XC总账抓glar时不考虑币别
#161222-00037#1   2016/12/23 By 02114   抓取底稿资料时,排除已作废的底稿单据
#170208-00010#1   2017/02/28 By 02114   固資AFA的检核, 排除掉 1.列管(faaj048)的資料
#170208-00041#1   2017/02/10 By 02114   成本勾稽的方式没有将委外工单排除掉，导致生成成本的子系统金额有误
#170210-00059#1   2017/02/13 By 02599   固资AFA系统：当累折科目=资产科目时，累折科目对应金额faan018 * -1
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
PRIVATE TYPE type_g_glar_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   sys LIKE type_t.chr500, 
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar009 LIKE glar_t.glar009, 
   soamt LIKE type_t.num20_6, 
   doamt LIKE type_t.num20_6, 
   zoamt LIKE type_t.num20_6, 
   samt LIKE type_t.num20_6, 
   damt LIKE type_t.num20_6, 
   zamt LIKE type_t.num20_6, 
   diff LIKE type_t.chr500, 
   result LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glar_d
DEFINE g_master_t                   type_g_glar_d
DEFINE g_glar_d          DYNAMIC ARRAY OF type_g_glar_d
DEFINE g_glar_d_t        type_g_glar_d
 
      
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
 TYPE type_g_glar2_d RECORD
       sys2 LIKE type_t.chr500, 
   xrea009 LIKE xrea_t.xrea009, 
   xrea009_desc LIKE type_t.chr500, 
   xrea019 LIKE xrea_t.xrea019, 
   xrea019_desc LIKE type_t.chr500, 
   xrea100 LIKE xrea_t.xrea100, 
   samt1 LIKE xrea_t.xrea103, 
   damt1 LIKE xrea_t.xrea103, 
   diff1 LIKE xrea_t.xrea103, 
   samt2 LIKE xrea_t.xrea103, 
   damt2 LIKE xrea_t.xrea103, 
   diff2 LIKE xrea_t.xrea103
       END RECORD
 
 TYPE type_g_glar3_d RECORD
       sys3 LIKE type_t.chr500, 
   glgadocno LIKE glga_t.glgadocno, 
   glgadocdt LIKE glga_t.glgadocdt, 
   glgastus LIKE glga_t.glgastus, 
   glapdocno LIKE glap_t.glapdocno, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glapstus LIKE glap_t.glapstus, 
   glgb002 LIKE glgb_t.glgb002, 
   glgb002_desc LIKE type_t.chr500, 
   glgb005 LIKE glgb_t.glgb005, 
   damt3 LIKE glgb_t.glgb003, 
   zamt3 LIKE glgb_t.glgb003, 
   diff3 LIKE glgb_t.glgb003, 
   damt4 LIKE glgb_t.glgb003, 
   zamt4 LIKE glgb_t.glgb003, 
   diff4 LIKE glgb_t.glgb003
       END RECORD
 
 TYPE type_g_glar4_d RECORD
       sys4 LIKE type_t.chr500, 
   xrea005 LIKE xrea_t.xrea005, 
   xrea008 LIKE xrea_t.xrea008, 
   xrea009 LIKE xrea_t.xrea009, 
   xrea009_4_desc LIKE type_t.chr500, 
   xrea019 LIKE xrea_t.xrea019, 
   xrea019_4_desc LIKE type_t.chr500, 
   xrea100 LIKE xrea_t.xrea100, 
   xrea103 LIKE xrea_t.xrea103, 
   xrea113 LIKE xrea_t.xrea113
       END RECORD
       
DEFINE g_glar2_d   DYNAMIC ARRAY OF type_g_glar2_d
DEFINE g_glar2_d_t type_g_glar2_d
 
DEFINE g_glar3_d   DYNAMIC ARRAY OF type_g_glar3_d
DEFINE g_glar3_d_t type_g_glar3_d
 
DEFINE g_glar4_d   DYNAMIC ARRAY OF type_g_glar4_d
DEFINE g_glar4_d_t type_g_glar4_d
DEFINE g_detail_idx3        LIKE type_t.num10
DEFINE g_detail_idx4        LIKE type_t.num10
DEFINE tm            RECORD 
       glaald        LIKE glaa_t.glaald,
       glaald_desc   LIKE glaal_t.glaal003,
       glaacomp      LIKE glaa_t.glaacomp,
       glaacomp_desc LIKE ooefl_t.ooefl003,
       glar002       LIKE glar_t.glar002,
       glar003       LIKE glar_t.glar003,
       chk_ar        LIKE type_t.chr1,
       chk_ap        LIKE type_t.chr1,
       chk_fa        LIKE type_t.chr1,
       chk_nm        LIKE type_t.chr1,
       chk_xc        LIKE type_t.chr1,
       chk_fm        LIKE type_t.chr1
       END RECORD
DEFINE g_glaa003     LIKE glaa_t.glaa003
DEFINE g_glaa004     LIKE glaa_t.glaa004
DEFINE g_glaa121     LIKE glaa_t.glaa121
DEFINE g_wc3         STRING

#end add-point
 
{</section>}
 
{<section id="aglq510.main" >}
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
   DECLARE aglq510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq510_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq510_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq510 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq510_init()   
 
      #進入選單 Menu (="N")
      CALL aglq510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq510
      
   END IF 
   
   CLOSE aglq510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq510_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq510_init()
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
   CALL cl_set_combo_scc_part('glgastus','13','N,Y,X,S')
   CALL cl_set_combo_scc_part('glapstus','13','N,Y,S,A,D,R,W,X')
   CALL aglq510_create_temp_table()
   #end add-point
 
   CALL aglq510_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq510.default_search" >}
PRIVATE FUNCTION aglq510_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glarld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glar001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glar002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glar003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " glar004 = '", g_argv[05], "' AND "
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
 
{<section id="aglq510.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq510_ui_dialog()
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
      CALL aglq510_b_fill()
   ELSE
      CALL aglq510_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glar_d.clear()
 
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
 
         CALL aglq510_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq510_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq510_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_glar2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_glar2_d.getLength() TO FORMONLY.h_count
               #add-point:input段before row

               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
            #add-point:page2自定義行為

            #end add-point
         END DISPLAY
 
         DISPLAY ARRAY g_glar3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.h_index
               DISPLAY g_glar3_d.getLength() TO FORMONLY.h_count
               #add-point:input段before row

               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
            #add-point:page3自定義行為

            #end add-point
         END DISPLAY
 
         DISPLAY ARRAY g_glar4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 4
            
            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx4
               DISPLAY g_detail_idx4 TO FORMONLY.h_index
               DISPLAY g_glar4_d.getLength() TO FORMONLY.h_count
               #add-point:input段before row

               #end add-point 
 
            #自訂ACTION(detail_show,page_4)
            
            #add-point:page4自定義行為

            #end add-point
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq510_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq510_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq510_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL aglq510_b_fill()#160118-00005#1  07675 ADD
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
            CALL aglq510_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glar_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_glar2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_glar3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_glar4_d)
               LET g_export_id[4]   = "s_detail4"
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
            CALL aglq510_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq510_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq510_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq510_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "N"
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
 
{<section id="aglq510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq510_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_max_period     LIKE glar_t.glar003
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL g_glar2_d.clear()
 
   CALL g_glar3_d.clear()
 
   CALL g_glar4_d.clear()
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glar_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glar001,glar009
           FROM s_detail1[1].b_glar001,s_detail1[1].b_glar009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<sys>>----
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001 name="construct.c.page1.b_glar001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
            NEXT FIELD b_glar001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar001
            #add-point:BEFORE FIELD b_glar001 name="construct.b.page1.b_glar001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar001
            
            #add-point:AFTER FIELD b_glar001 name="construct.a.page1.b_glar001"
            
            #END add-point
            
 
 
         #----<<b_glar001_desc>>----
         #----<<b_glar009>>----
         #Ctrlp:construct.c.page1.b_glar009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar009
            #add-point:ON ACTION controlp INFIELD b_glar009 name="construct.c.page1.b_glar009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
            NEXT FIELD b_glar009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar009
            #add-point:BEFORE FIELD b_glar009 name="construct.b.page1.b_glar009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar009
            
            #add-point:AFTER FIELD b_glar009 name="construct.a.page1.b_glar009"
            
            #END add-point
            
 
 
         #----<<soamt>>----
         #----<<doamt>>----
         #----<<zoamt>>----
         #----<<samt>>----
         #----<<damt>>----
         #----<<zamt>>----
         #----<<diff>>----
         #----<<result>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME tm.glaald,tm.glaacomp,tm.glar002,tm.glar003,tm.chk_ar,tm.chk_ap,
                    tm.chk_fa,tm.chk_nm,tm.chk_xc,tm.chk_fm
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            #获取账别
            IF cl_null(tm.glaald) THEN
               CALL s_ld_bookno()  RETURNING l_success,tm.glaald
               IF l_success = FALSE THEN
                  LET tm.glaald = ''
               END IF 
               CALL s_ld_chk_authorization(g_user,tm.glaald) RETURNING l_success
               IF l_success = FALSE THEN
                  LET tm.glaald = ''
               END IF
            END IF
            CALL aglq510_glaald_desc(tm.glaald)
            #会计年度期别
            IF cl_null(tm.glar002) OR cl_null(tm.glar003) OR tm.glar002=0 OR tm.glar003=0 THEN 
               SELECT glav002,glav006 INTO tm.glar002,tm.glar003 FROM glav_t
                WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav004=g_today
            END IF
            
            IF cl_null(tm.chk_ar) THEN LET tm.chk_ar = 'Y' END IF
            IF cl_null(tm.chk_ap) THEN LET tm.chk_ap = 'Y' END IF
            IF cl_null(tm.chk_fa) THEN LET tm.chk_fa = 'Y' END IF
            IF cl_null(tm.chk_nm) THEN LET tm.chk_nm = 'Y' END IF
            IF cl_null(tm.chk_xc) THEN LET tm.chk_xc = 'Y' END IF
            IF cl_null(tm.chk_fm) THEN LET tm.chk_fm = 'Y' END IF
            DISPLAY BY NAME tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,tm.glar002,tm.glar003,
                            tm.chk_ar,tm.chk_ap,tm.chk_fa,tm.chk_nm,tm.chk_xc,tm.chk_fm
            
         AFTER FIELD glaald
            IF NOT cl_null(tm.glaald) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.glaald
               #160318-00025#7--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#7--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET tm.glaald=''
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_ld_chk_authorization(g_user,tm.glaald) RETURNING l_success
               IF l_success = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = tm.glaald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  NEXT FIELD glaald
               END IF
               CALL aglq510_glaald_desc(tm.glaald)
               DISPLAY BY NAME tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc
            END IF
            
         AFTER FIELD glar002
            IF NOT cl_null(tm.glar002) THEN               
               #獲取現行會計週期最大期別
               SELECT MAX(glav006) INTO l_max_period FROM glav_t 
               WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.glar002
            END IF
            
         AFTER FIELD glar003
            IF NOT cl_null(tm.glar003) THEN
               IF cl_null(l_max_period) OR l_max_period = 0 THEN
                  #獲取現行會計週期最大期別
                  SELECT MAX(glav006) INTO l_max_period FROM glav_t 
                  WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.glar002
               END IF
               IF cl_null(l_max_period) OR l_max_period = 0 THEN
                  LET l_max_period = 12
               END IF
               IF NOT cl_ap_chk_Range(tm.glar003,"0","1",l_max_period,"1","azz-00087",1) THEN
                  NEXT FIELD glar003
               END IF
            END IF
            
         AFTER FIELD chk_ar
            IF tm.chk_ar NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk_ar
            END IF
            
         AFTER FIELD chk_ap
            IF tm.chk_ap NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk_ap
            END IF
         
         AFTER FIELD chk_fa
            IF tm.chk_fa NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk_fa
            END IF
            
         AFTER FIELD chk_nm
            IF tm.chk_nm NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk_nm
            END IF
            
         AFTER FIELD chk_xc
            IF tm.chk_xc NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk_xc
            END IF
            
         AFTER FIELD chk_fm
            IF tm.chk_fm NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk_fm
            END IF
         
         ON ACTION controlp INFIELD glaald
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           #給予arg
           LET g_qryparam.arg1 = g_user
           LET g_qryparam.arg2 = g_dept
           CALL q_authorised_ld()                                #呼叫開窗
           LET tm.glaald = g_qryparam.return1
           DISPLAY tm.glaald TO glaald 
           NEXT FIELD glaald
      END INPUT
      
      BEFORE DIALOG
       
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
   CALL aglq510_b_fill()
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
 
{<section id="aglq510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq510_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CASE
      WHEN tm.chk_ar = 'Y' AND tm.chk_ap = 'Y' 
         LET g_wc3 = "xrea003 IN ('AR','AP')"
      WHEN tm.chk_ar = 'Y' AND tm.chk_ap <> 'Y' 
         LET g_wc3 = "xrea003='AR'"
      WHEN tm.chk_ar <> 'Y' AND tm.chk_ap = 'Y' 
         LET g_wc3 = "xrea003='AP'"
   END CASE
   CALL aglq510_get_data()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','',glar001,'',glar009,'','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glar_t.glarld, 
       glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004) AS RANK FROM glar_t",
 
 
                     "",
                     " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glar_t"),
                     " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
  LET ls_sql_rank = "SELECT  UNIQUE '',sys,glar001,glar001_desc,glar009,soamt,doamt,zoamt,samt,damt,zamt,diff,result,DENSE_RANK() OVER( ORDER BY sys,glar001,glar009) AS RANK FROM aglq510_tmp",
                     " WHERE glarent= ? ", 
                     " ORDER BY glar001,glar009"
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
 
   LET g_sql = "SELECT '','',glar001,'',glar009,'','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT '',sys,glar001,glar001_desc,glar009,soamt,doamt,zoamt,samt,damt,zamt,diff,result",
               "  FROM (",ls_sql_rank,")",
               " WHERE ",g_wc_filter,#160302-00006#1     ADD BY07675
               "   AND RANK >= ",g_pagestart, #160302-00006#1  modify (“WHERE” TO “AND”)
               "   AND RANK < ",g_pagestart + g_num_in_page,
               " ORDER BY sys,glar001,glar009" 
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq510_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq510_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glar_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glar_d[l_ac].sel,g_glar_d[l_ac].sys,g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc, 
       g_glar_d[l_ac].glar009,g_glar_d[l_ac].soamt,g_glar_d[l_ac].doamt,g_glar_d[l_ac].zoamt,g_glar_d[l_ac].samt, 
       g_glar_d[l_ac].damt,g_glar_d[l_ac].zamt,g_glar_d[l_ac].diff,g_glar_d[l_ac].result
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glar_d[l_ac].statepic = cl_get_actipic(g_glar_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq510_detail_show("'1'")      
 
      CALL aglq510_glar_t_mask()
 
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
   
 
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   IF g_glaa121 = 'Y' THEN
      CALL aglq510_b_fill2()
      CALL aglq510_b_fill3()
   END IF
   CALL aglq510_b_fill4()
   
   #end add-point
 
   LET g_detail_cnt = g_glar_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq510_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq510_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq510_detail_action_trans()
 
   IF g_glar_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq510_fetch()
   END IF
   
      CALL aglq510_filter_show('glar001','b_glar001')
   CALL aglq510_filter_show('glar009','b_glar009')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq510_fetch()
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
 
{<section id="aglq510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq510_detail_show(ps_page)
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
 
{<section id="aglq510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq510_filter()
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
      CONSTRUCT g_wc_filter ON glar001,glar009
                          FROM s_detail1[1].b_glar001,s_detail1[1].b_glar009
 
         BEFORE CONSTRUCT
                     DISPLAY aglq510_filter_parser('glar001') TO s_detail1[1].b_glar001
            DISPLAY aglq510_filter_parser('glar009') TO s_detail1[1].b_glar009
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<sys>>----
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001 name="construct.c.filter.page1.b_glar001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
            NEXT FIELD b_glar001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glar001_desc>>----
         #----<<b_glar009>>----
         #Ctrlp:construct.c.page1.b_glar009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar009
            #add-point:ON ACTION controlp INFIELD b_glar009 name="construct.c.filter.page1.b_glar009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
            NEXT FIELD b_glar009                     #返回原欄位
    


            #END add-point
 
 
         #----<<soamt>>----
         #----<<doamt>>----
         #----<<zoamt>>----
         #----<<samt>>----
         #----<<damt>>----
         #----<<zamt>>----
         #----<<diff>>----
         #----<<result>>----
   
 
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
   
      CALL aglq510_filter_show('glar001','b_glar001')
   CALL aglq510_filter_show('glar009','b_glar009')
 
    
   CALL aglq510_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq510_filter_parser(ps_field)
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
 
{<section id="aglq510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq510_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq510.insert" >}
#+ insert
PRIVATE FUNCTION aglq510_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq510.modify" >}
#+ modify
PRIVATE FUNCTION aglq510_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq510.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq510_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq510.delete" >}
#+ delete
PRIVATE FUNCTION aglq510_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq510.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq510_detail_action_trans()
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
 
{<section id="aglq510.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq510_detail_index_setting()
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
            IF g_glar_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glar_d.getLength() AND g_glar_d.getLength() > 0
            LET g_detail_idx = g_glar_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glar_d.getLength() THEN
               LET g_detail_idx = g_glar_d.getLength()
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
 
{<section id="aglq510.mask_functions" >}
 &include "erp/agl/aglq510_mask.4gl"
 
{</section>}
 
{<section id="aglq510.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取账套相关资讯
# Memo...........:
# Usage..........: CALL aglq510_glaald_desc(p_glaald)
# Input parameter: p_glaald       账套编号
# Return code....: 
# Date & Author..: 2015/12/1 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq510_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaald 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glaald_desc=g_rtn_fields[1]
   
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa003,glaa004,glaa121
     INTO tm.glaacomp,g_glaa003,g_glaa004,g_glaa121
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glaacomp_desc= g_rtn_fields[1]
   #当启用分录底稿，用分录底稿分别子系统、总账比较，否则只比较子系统与总账
   IF g_glaa121 = 'Y' THEN
      CALL cl_set_comp_visible("doamt,damt",TRUE)
      CALL cl_set_comp_visible("page_1,page_2",TRUE)
   ELSE
      CALL cl_set_comp_visible("doamt,damt",FALSE)
      CALL cl_set_comp_visible("page_1,page_2",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL aglq510_create_temp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq510_create_temp_table()
   DROP TABLE aglq510_tmp
   CREATE TEMP TABLE aglq510_tmp(
      glarent  SMALLINT,
      sys  VARCHAR(500),
      glar001  VARCHAR(24),
      glar001_desc  VARCHAR(500),
      glar009  VARCHAR(10),
      soamt  DECIMAL(20,6),
      doamt  DECIMAL(20,6),
      zoamt  DECIMAL(20,6),
      samt  DECIMAL(20,6),
      damt  DECIMAL(20,6),
      zamt  DECIMAL(20,6),
      diff  VARCHAR(500),
      result  VARCHAR(500))
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq510_get_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq510_get_data()
   DEFINE l_sql               STRING
   DEFINE l_sql1              STRING
   DEFINE l_wc                STRING
   DEFINE l_wc1               STRING
   DEFINE l_wc2               STRING
   DEFINE l_wc3               STRING
   DEFINE l_success           LIKE type_t.num5
   DEFINE l_sys               LIKE type_t.chr10     #系统别
   DEFINE l_glar001           LIKE glar_t.glar001   #科目
   DEFINE l_glar001_desc      LIKE glacl_t.glacl004 #科目说明
   DEFINE l_glar009           LIKE glar_t.glar009   #币别
   DEFINE l_xrea003           LIKE xrea_t.xrea003   #系统别
   DEFINE l_xrea103           LIKE xrea_t.xrea103   #子系统原币余额
   DEFINE l_xrea113           LIKE xrea_t.xrea113   #子系统本币余额
   DEFINE l_glat103           LIKE glat_t.glat103   #底稿原币余额
   DEFINE l_glat113           LIKE glat_t.glat113   #底稿本币余额
   DEFINE l_glar010           LIKE glar_t.glar010   #总账原币余额
   DEFINE l_glar005           LIKE glar_t.glar005   #总账本币余额
   DEFINE l_diff              LIKE type_t.chr10     #差异原因
   DEFINE l_result            LIKE type_t.chr10     #核对结果
   DEFINE l_glcc001           LIKE glcc_t.glcc001
   DEFINE l_glcc011           LIKE glcc_t.glcc011
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_amt               LIKE xrea_t.xrea113
   DEFINE l_glac008           LIKE glac_t.glac008
   #160728-00003#1--add--str--
   DEFINE l_xrea103_o         LIKE xrea_t.xrea103   #子系统原币余额
   DEFINE l_xrea113_o         LIKE xrea_t.xrea113   #子系统本币余额
   DEFINE l_glat103_o         LIKE glat_t.glat103   #底稿原币余额
   DEFINE l_glat113_o         LIKE glat_t.glat113   #底稿本币余额
   DEFINE l_glar010_o         LIKE glar_t.glar010   #总账原币余额
   DEFINE l_glar005_o         LIKE glar_t.glar005   #总账本币余额
   #160728-00003#1--add--end
   #161209-00052#1 add s---
   DEFINE l_amt2              LIKE xrea_t.xrea113
   DEFINE l_amt3              LIKE xrea_t.xrea113
   DEFINE l_amt4              LIKE xrea_t.xrea113
   DEFINE l_amt5              LIKE xrea_t.xrea113
   DEFINE l_amt6              LIKE xrea_t.xrea113
   DEFINE l_amt7              LIKE xrea_t.xrea113
   DEFINE l_amt8              LIKE xrea_t.xrea113
   DEFINE l_glar001_2           LIKE glar_t.glar001
   DEFINE l_glar001_3           LIKE glar_t.glar001
   DEFINE l_glar001_4           LIKE glar_t.glar001
   DEFINE l_glar001_5           LIKE glar_t.glar001
   DEFINE l_glar001_6           LIKE glar_t.glar001
   DEFINE l_glar001_7           LIKE glar_t.glar001
   DEFINE l_glar001_8           LIKE glar_t.glar001
   #161209-00052#1 add e---
   
   DELETE FROM aglq510_tmp
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #抓取底稿余额
   LET l_sql="SELECT SUM(glat103-glat104),SUM(glat113-glat114) ",
             "  FROM glat_t ",
             " WHERE glatent=",g_enterprise," AND glatld='",tm.glaald,"'",
             "   AND glat001=",tm.glar002," AND glat002<=",tm.glar003,
             "   AND glat003=? AND glat007=? AND glat100=? "
   PREPARE aglq510_sel_glat_pr1 FROM l_sql
   
   #抓取总账余额
   LET l_sql="SELECT SUM(glar010-glar011),SUM(glar005-glar006) ",
             "  FROM glar_t ",
             " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
             "   AND glar002=",tm.glar002," AND glar003<=",tm.glar003,
             "   AND glar001=? AND glar009=? "
   PREPARE aglq510_sel_glar_pr1 FROM l_sql
   
   #161217-00001#1 add s---
   #XC捉取總帳科余時，"不"能用原幣區隔捉科余, 統一取科余本幣
   #抓取总账余额
   LET l_sql="SELECT SUM(glar005-glar006),SUM(glar005-glar006) ",
             "  FROM glar_t ",
             " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
             "   AND glar002=",tm.glar002," AND glar003<=",tm.glar003,
             "   AND glar001=? "
   PREPARE aglq510_sel_glar_pr2 FROM l_sql   
   #161217-00001#1 add e---
   
   #检查应收&应付系统
   IF tm.chk_ar='Y' OR tm.chk_ap='Y' THEN
      LET l_wc = cl_replace_str(g_wc,'glar001','xrea019')
      LET l_wc = cl_replace_str(l_wc,'glar009','xrea100')
      #160728-00003#1--mod--str--
#      LET l_sql="SELECT DISTINCT xrea003,xrea019,xrea100,SUM(xrea103),SUM(xrea113) ",
      LET l_sql="SELECT DISTINCT xrea003,xrea019,xrea100,",
                "       SUM(CASE WHEN xrea004 LIKE '2%' OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' THEN xrea103*-1 ELSE xrea103 END),",  #161208-00011#1 add OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' lujh 
                "       SUM(CASE WHEN xrea004 LIKE '2%' OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' THEN xrea113*-1 ELSE xrea113 END) ",  #161208-00011#1 add OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' lujh 
      #160728-00003#1--mod--end
                "  FROM xrea_t ",
                " WHERE xreaent=",g_enterprise," AND xreald='",tm.glaald,"'",
#                "   AND xrea001=",tm.glar002," AND xrea002<=",tm.glar003, #160728-00003#1 mark
                "   AND xrea001=",tm.glar002," AND xrea002 =",tm.glar003,  #160728-00003#1 add
                "   AND ",g_wc3,
                "   AND ",l_wc,
                " GROUP BY xrea003,xrea019,xrea100 ",
                " ORDER BY xrea003,xrea019,xrea100 "
      PREPARE aglq510_sel_xrea_pr1 FROM l_sql
      DECLARE aglq510_sel_xrea_cs1 CURSOR FOR aglq510_sel_xrea_pr1
      FOREACH aglq510_sel_xrea_cs1 INTO l_xrea003,l_glar001,l_glar009,l_xrea103,l_xrea113
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_xrea_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #科目说明
         LET l_glar001_desc = ''
         CALL s_desc_get_account_desc(tm.glaald,l_glar001) RETURNING l_glar001_desc
         IF cl_null(l_xrea103) THEN LET l_xrea103 = 0 END IF
         IF cl_null(l_xrea113) THEN LET l_xrea113 = 0 END IF
         
         #当该账套启用分录底稿时，计算分录底稿余额，分别与子系统、总账进行比较
         IF g_glaa121 = 'Y' THEN
            EXECUTE aglq510_sel_glat_pr1 USING l_xrea003,l_glar001,l_glar009
                                         INTO l_glat103,l_glat113
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'EXE aglq510_sel_glat_pr1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_glat103) THEN LET l_glat103 = 0 END IF
            IF cl_null(l_glat113) THEN LET l_glat113 = 0 END IF
         END IF
         
         #抓取总账余额
         EXECUTE aglq510_sel_glar_pr1 USING l_glar001,l_glar009
                                      INTO l_glar010,l_glar005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'EXE aglq510_sel_glar_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glar010) THEN LET l_glar010 = 0 END IF
         IF cl_null(l_glar005) THEN LET l_glar005 = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         SELECT glac008 INTO l_glac008 FROM glac_t 
          WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
         IF l_glac008 = '2' THEN
            LET l_glat103 = l_glat103 * -1
            LET l_glat113 = l_glat113 * -1
            LET l_glar010 = l_glar010 * -1
            LET l_glar005 = l_glar005 * -1
         END IF
         
         #160728-00003#1--add--str--
         #AR/AP子系统金额采用金额的绝对值与分录底稿、总账金额的绝对值比较
         #子系统金额
         IF l_xrea103 < 0 THEN
            LET l_xrea103_o = l_xrea103 * -1
         ELSE
            LET l_xrea103_o = l_xrea103
         END IF
         IF l_xrea113 < 0 THEN
            LET l_xrea113_o = l_xrea113 * -1
         ELSE
            LET l_xrea113_o = l_xrea113
         END IF
         #分录底稿金额
         IF l_glat103 < 0 THEN
            LET l_glat103_o = l_glat103 * -1
         ELSE
#            LET l_glat113_o = l_glat113 #161021-00014#1 mark
            LET l_glat103_o = l_glat103  #161021-00014#1 add
         END IF
         #161021-00014#1--add--str--
         IF l_glat113 < 0 THEN
            LET l_glat113_o = l_glat113 * -1
         ELSE
            LET l_glat113_o = l_glat113
         END IF
         #161021-00014#1--add--end
         #总账金额
         IF l_glar010 < 0 THEN
            LET l_glar010_o = l_glar010 * -1
         ELSE
            LET l_glar010_o = l_glar010
         END IF
#         IF l_glar010 < 0 THEN  #161021-00014#1 mark
         IF l_glar005 < 0 THEN   #161021-00014#1 add
            LET l_glar005_o = l_glar005 * -1
         ELSE
            LET l_glar005_o = l_glar005
         END IF
         
         #进行金额比较
         #当启用分录底稿
         IF g_glaa121 = 'Y' THEN
            IF l_xrea103_o = l_glat103_o AND l_xrea103_o = l_glar010_o AND
               l_xrea113_o = l_glat113_o AND l_xrea113_o = l_glar005_o THEN
               LET l_diff = '0'  #0.子系统、底稿、总账均无差异
            END IF
            
            IF (l_xrea103_o <> l_glat103_o OR l_xrea113_o <> l_glat113_o) AND
               (l_xrea103_o = l_glar010_o AND l_xrea113_o = l_glar005_o) THEN
               LET l_diff = '1'  #1.子系统与底稿有差异与总账无差异
            END IF
            
            IF (l_xrea103_o = l_glat103_o AND l_xrea113_o = l_glat113_o) AND
               (l_xrea103_o <> l_glar010_o OR l_xrea113_o <> l_glar005_o) THEN
               LET l_diff = '2'  #2.子系统与底稿无差异与总账有差异
            END IF
            
            IF (l_xrea103_o <> l_glat103_o OR l_xrea113_o <> l_glat113_o) AND
               (l_xrea103_o <> l_glar010_o OR l_xrea113_o <> l_glar005_o) AND 
               (l_glat103 = l_glar010 AND l_glat113 = l_glar005)THEN
               LET l_diff = '3'  #3.子系统与底稿有差异与总账有差异，底稿与总账无差异
            END IF
            
            IF (l_xrea103_o <> l_glat103_o OR l_xrea113_o <> l_glat113_o) AND
               (l_xrea103_o <> l_glar010_o OR l_xrea113_o <> l_glar005_o) AND 
               (l_glat103 <> l_glar010 OR l_glat113 <> l_glar005)THEN
               LET l_diff = '4'  #4.子系统、底稿、总账均有差异
            END IF
         ELSE
         #未启用分录底稿时，只需比较子系统与总账余额差异
            IF l_xrea103_o <> l_glar010_o OR l_xrea113_o <> l_glar005_o THEN
               LET l_diff = '6'  #6.子系统与总账有差异
            ELSE
               LET l_diff = '5'  #5.子系统与总账无差异
            END IF            
         END IF
         #160728-00003#1--add--end
         
#160728-00003#1--mark--str--         
#         #进行金额比较
#         #当启用分录底稿
#         IF g_glaa121 = 'Y' THEN
#            IF l_xrea103 = l_glat103 AND l_xrea103 = l_glar010 AND
#               l_xrea113 = l_glat113 AND l_xrea113 = l_glar005 THEN
#               LET l_diff = '0'  #0.子系统、底稿、总账均无差异
#            END IF
#            
#            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
#               (l_xrea103 = l_glar010 AND l_xrea113 = l_glar005) THEN
#               LET l_diff = '1'  #1.子系统与底稿有差异与总账无差异
#            END IF
#            
#            IF (l_xrea103 = l_glat103 AND l_xrea113 = l_glat113) AND
#               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) THEN
#               LET l_diff = '2'  #2.子系统与底稿无差异与总账有差异
#            END IF
#            
#            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
#               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
#               (l_glat103 = l_glar010 AND l_glat113 = l_glar005)THEN
#               LET l_diff = '3'  #3.子系统与底稿有差异与总账有差异，底稿与总账无差异
#            END IF
#            
#            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
#               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
#               (l_glat103 <> l_glar010 OR l_glat113 <> l_glar005)THEN
#               LET l_diff = '4'  #4.子系统、底稿、总账均有差异
#            END IF
#         ELSE
#         #未启用分录底稿时，只需比较子系统与总账余额差异
#            IF l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005 THEN
#               LET l_diff = '6'  #6.子系统与总账有差异
#            ELSE
#               LET l_diff = '5'  #5.子系统与总账无差异
#            END IF            
#         END IF
#160728-00003#1--mark--end

         #核对结果
         IF l_diff = '0' OR l_diff = '5' THEN
            LET l_result = '0' #0.核对OK
         ELSE
            LET l_result = '1' #1.核对有误
         END IF
         
         #系统别
         IF l_xrea003 = 'AR' THEN LET l_sys = '1' END IF
         IF l_xrea003 = 'AP' THEN LET l_sys = '2' END IF
         #插入临时表
         INSERT INTO aglq510_tmp(glarent,sys,glar001,glar001_desc,glar009,
                                 soamt,doamt,zoamt,samt,damt,zamt,diff,result)
         VALUES(g_enterprise,l_sys,l_glar001,l_glar001_desc,l_glar009,
                l_xrea103,l_glat103,l_glar010,l_xrea113,l_glat113,l_glar005,l_diff,l_result)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         
      END FOREACH
   END IF
   
   #检查固资系统
   IF tm.chk_fa='Y' THEN
      LET l_wc = cl_replace_str(g_wc,'glar001','faaj023')
      LET l_wc = cl_replace_str(l_wc,'glar009','faan010')
      
      LET l_wc1 = cl_replace_str(g_wc,'glar001','faaj024')
      LET l_wc1 = cl_replace_str(l_wc1,'glar009','faan010')
      
      LET l_sql="SELECT acc,faan010,SUM(amt) ",
                "  FROM (",
                #                财产科目    /币别   /本币余额
                "        (SELECT faaj023 acc,faan010,SUM(faan014) amt ",
                "           FROM faan_t,faaj_t ",
                "          WHERE faanent=faajent AND faanld=faajld ",
                "            AND faan003=faaj037 AND faan004=faaj001 AND faan005=faaj002",
                "            AND faanent=",g_enterprise," AND faanld='",tm.glaald,"'",
                #"            AND faan001=",tm.glar002," AND faan002<=",tm.glar003, #161216-00027#1 mark
                "            AND faan001=",tm.glar002," AND faan002 =",tm.glar003,  #161216-00027#1 add
                "            AND faaj048 <> '1' ",   #170208-00010#1 add lujh
                "            AND ",l_wc,
                "          GROUP BY faaj023,faan010 )",
                "          UNION ",
                #                累折科目    /币别   /本币余额
#                "        (SELECT faaj024 acc,faan010,SUM(faan018) amt ", #170210-00059#1 mark
                "        (SELECT faaj024 acc,faan010,SUM(CASE WHEN faaj023=faaj024 THEN faan018 *-1 ELSE faan018 END) amt ", #170210-00059#1 add
                "           FROM faan_t,faaj_t ",
                "          WHERE faanent=faajent AND faanld=faajld ",
                "            AND faan003=faaj037 AND faan004=faaj001 AND faan005=faaj002",
                "            AND faanent=",g_enterprise," AND faanld='",tm.glaald,"'",
                #"            AND faan001=",tm.glar002," AND faan002<=",tm.glar003,    #161216-00027#1 mark
                "            AND faan001=",tm.glar002," AND faan002 =",tm.glar003,     #161216-00027#1 add
                "            AND faaj048 <> '1' ",   #170208-00010#1 add lujh
                "            AND ",l_wc1,
                "          GROUP BY faaj024,faan010 )",
                "       )",
                " GROUP BY acc,faan010 ",
                " ORDER BY acc,faan010 "
      PREPARE aglq510_sel_faan_pr1 FROM l_sql
      DECLARE aglq510_sel_faan_cs1 CURSOR FOR aglq510_sel_faan_pr1
      
      #161125-00026#1--add--str--
      #抓取总账余额
      LET l_sql="SELECT SUM(glar005-glar006) ",
                "  FROM glar_t ",
                " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                "   AND glar002=",tm.glar002," AND glar003<=",tm.glar003,
                "   AND glar001=? "
      PREPARE aglq510_sel_glar_fa_pr1 FROM l_sql
      #161125-00026#1--add--end
   
      FOREACH aglq510_sel_faan_cs1 INTO l_glar001,l_glar009,l_xrea113
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_faan_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #科目说明
         LET l_glar001_desc = ''
         CALL s_desc_get_account_desc(tm.glaald,l_glar001) RETURNING l_glar001_desc
         IF cl_null(l_xrea113) THEN LET l_xrea113 = 0 END IF
         #固资中原币金额 = 本币金额
         LET l_xrea103 = l_xrea113
         
         #当该账套启用分录底稿时，计算分录底稿余额，分别与子系统、总账进行比较
         IF g_glaa121 = 'Y' THEN
            #固资中分录底稿金额 = 子系统金额
            LET l_glat103 = l_xrea103
            LET l_glat113 = l_xrea113
         END IF
         
         #抓取总账余额
         #161125-00026#1--mod--str--
#         EXECUTE aglq510_sel_glar_pr1 USING l_glar001,l_glar009
#                                      INTO l_glar010,l_glar005
         EXECUTE aglq510_sel_glar_fa_pr1 USING l_glar001
                                         INTO l_glar005
         #161125-00026#1--mod--end
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'EXE aglq510_sel_glar_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
#         IF cl_null(l_glar010) THEN LET l_glar010 = 0 END IF #161125-00026#1 mark
         IF cl_null(l_glar005) THEN LET l_glar005 = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         SELECT glac008 INTO l_glac008 FROM glac_t 
          WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
         IF l_glac008 = '2' THEN
#            LET l_glar010 = l_glar010 * -1 #161125-00026#1 mark
            LET l_glar005 = l_glar005 * -1
         END IF
         LET l_glar010 = l_glar005 #161125-00026#1 add
         
         #进行金额比较
         #当启用分录底稿
         IF g_glaa121 = 'Y' THEN
            IF l_xrea103 = l_glat103 AND l_xrea103 = l_glar010 AND
               l_xrea113 = l_glat113 AND l_xrea113 = l_glar005 THEN
               LET l_diff = '0'  #0.子系统、底稿、总账均无差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 = l_glar010 AND l_xrea113 = l_glar005) THEN
               LET l_diff = '1'  #1.子系统与底稿有差异与总账无差异
            END IF
            
            IF (l_xrea103 = l_glat103 AND l_xrea113 = l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) THEN
               LET l_diff = '2'  #2.子系统与底稿无差异与总账有差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
               (l_glat103 = l_glar010 AND l_glat113 = l_glar005)THEN
               LET l_diff = '3'  #3.子系统与底稿有差异与总账有差异，底稿与总账无差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
               (l_glat103 <> l_glar010 OR l_glat113 <> l_glar005)THEN
               LET l_diff = '4'  #4.子系统、底稿、总账均有差异
            END IF
         ELSE
         #未启用分录底稿时，只需比较子系统与总账余额差异
            IF l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005 THEN
               LET l_diff = '6'  #6.子系统与总账有差异
            ELSE
               LET l_diff = '5'  #5.子系统与总账无差异
            END IF            
         END IF
         
         #核对结果
         IF l_diff = '0' OR l_diff = '5' THEN
            LET l_result = '0' #0.核对OK
         ELSE
            LET l_result = '1' #1.核对有误
         END IF
     
         #系统别:3.固资
         LET l_sys = '3' 
         
         #插入临时表
         INSERT INTO aglq510_tmp(glarent,sys,glar001,glar001_desc,glar009,
                                 soamt,doamt,zoamt,samt,damt,zamt,diff,result)
         VALUES(g_enterprise,l_sys,l_glar001,l_glar001_desc,l_glar009,
                l_xrea103,l_glat103,l_glar010,l_xrea113,l_glat113,l_glar005,l_diff,l_result)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         
      END FOREACH
   END IF
   
   #检查资金系统
   IF tm.chk_nm='Y' THEN
      #nmbx_t(资金帐户期统计档)
      LET l_wc = cl_replace_str(g_wc,'glar001','glab005')
      LET l_wc = cl_replace_str(l_wc,'glar009','nmbx100')
      #nmcy(票据期统计档)，还没有写，故暂时不处理,暂时按照固资的写法预留抓取nmcy_t
      LET l_sql="SELECT acc,curr,SUM(amt1),SUM(amt2) ",
                "  FROM (",
                #              账户对应科目   /币别        /原币余额                 /本币余额
                "        (SELECT glab005 acc,nmbx100 curr,SUM(nmbx103-nmbx104) amt1,SUM(nmbx113-nmbx114) amt2 ",
                "           FROM nmbx_t,glab_t ",
                "          WHERE nmbxent=glabent AND nmbx003=glab003 ",
                "            AND glab001='40' AND glab002='40' AND glabld='",tm.glaald,"'",
                "            AND nmbxent=",g_enterprise," AND nmbxcomp='",tm.glaacomp,"'",
                "            AND nmbx001=",tm.glar002," AND nmbx002<=",tm.glar003, 
                "            AND ",l_wc,
                "          GROUP BY glab005,nmbx100 )",
                "       )",
                " GROUP BY acc,curr ",
                " ORDER BY acc,curr "
      PREPARE aglq510_sel_nmbx_pr1 FROM l_sql
      DECLARE aglq510_sel_nmbx_cs1 CURSOR FOR aglq510_sel_nmbx_pr1
      FOREACH aglq510_sel_nmbx_cs1 INTO l_glar001,l_glar009,l_xrea103,l_xrea113
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_nmbx_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #科目说明
         LET l_glar001_desc = ''
         CALL s_desc_get_account_desc(tm.glaald,l_glar001) RETURNING l_glar001_desc
         IF cl_null(l_xrea103) THEN LET l_xrea103 = 0 END IF
         IF cl_null(l_xrea113) THEN LET l_xrea113 = 0 END IF
         
         #当该账套启用分录底稿时，计算分录底稿余额，分别与子系统、总账进行比较
         IF g_glaa121 = 'Y' THEN
            #固资中分录底稿金额 = 子系统金额
            LET l_glat103 = l_xrea103
            LET l_glat113 = l_xrea113
         END IF
         
         #抓取总账余额
         EXECUTE aglq510_sel_glar_pr1 USING l_glar001,l_glar009
                                      INTO l_glar010,l_glar005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'EXE aglq510_sel_glar_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glar010) THEN LET l_glar010 = 0 END IF
         IF cl_null(l_glar005) THEN LET l_glar005 = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         SELECT glac008 INTO l_glac008 FROM glac_t 
          WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
         IF l_glac008 = '2' THEN
            LET l_glar010 = l_glar010 * -1
            LET l_glar005 = l_glar005 * -1
         END IF
         
         #进行金额比较
         #当启用分录底稿
         IF g_glaa121 = 'Y' THEN
            IF l_xrea103 = l_glat103 AND l_xrea103 = l_glar010 AND
               l_xrea113 = l_glat113 AND l_xrea113 = l_glar005 THEN
               LET l_diff = '0'  #0.子系统、底稿、总账均无差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 = l_glar010 AND l_xrea113 = l_glar005) THEN
               LET l_diff = '1'  #1.子系统与底稿有差异与总账无差异
            END IF
            
            IF (l_xrea103 = l_glat103 AND l_xrea113 = l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) THEN
               LET l_diff = '2'  #2.子系统与底稿无差异与总账有差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
               (l_glat103 = l_glar010 AND l_glat113 = l_glar005)THEN
               LET l_diff = '3'  #3.子系统与底稿有差异与总账有差异，底稿与总账无差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
               (l_glat103 <> l_glar010 OR l_glat113 <> l_glar005)THEN
               LET l_diff = '4'  #4.子系统、底稿、总账均有差异
            END IF
         ELSE
         #未启用分录底稿时，只需比较子系统与总账余额差异
            IF l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005 THEN
               LET l_diff = '6'  #6.子系统与总账有差异
            ELSE
               LET l_diff = '5'  #5.子系统与总账无差异
            END IF            
         END IF
         
         #核对结果
         IF l_diff = '0' OR l_diff = '5' THEN
            LET l_result = '0' #0.核对OK
         ELSE
            LET l_result = '1' #1.核对有误
         END IF
     
         #系统别:4.资金
         LET l_sys = '4' 
         
         #插入临时表
         INSERT INTO aglq510_tmp(glarent,sys,glar001,glar001_desc,glar009,
                                 soamt,doamt,zoamt,samt,damt,zamt,diff,result)
         VALUES(g_enterprise,l_sys,l_glar001,l_glar001_desc,l_glar009,
                l_xrea103,l_glat103,l_glar010,l_xrea113,l_glat113,l_glar005,l_diff,l_result)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         
      END FOREACH
   END IF
   
   #检查成本系统
   IF tm.chk_xc='Y' THEN
      #对查询单身录入的条件进行转换
      LET l_wc = " 1=1"   #科目条件
      LET l_wc1= " 1=1"   #币别条件xccc_t
      LET l_wc2= " 1=1"   #币别条件xccd_t
      LET l_wc3= " 1=1"   #币别条件xcch_t
      
      IF g_wc <> " 1=1" THEN
         #找到币别条件的位置，科目与币别条件拆开
         LET l_i = 0
         LET l_i = g_wc.getIndexOf("glar009",1) 
         IF l_i = 0 THEN
            LET l_wc = cl_replace_str(g_wc,'glar001','glcc002')
         ELSE
            #科目条件
            LET l_wc = g_wc.substring(1,l_i)
            IF NOT cl_null(l_wc) THEN
               LET l_wc = cl_replace_str(l_wc,'glar001','glcc002')
            END IF
            #币别条件
            LET l_wc1 = g_wc.substring(l_i,g_wc.getLength())
            LET l_wc1 = cl_replace_str(l_wc1,'glar009','xccc010')
            LET l_wc2 = cl_replace_str(l_wc1,'xccc010','xccd010')
            LET l_wc3 = cl_replace_str(l_wc1,'xccc010','xcch010')
         END IF
      END IF
#161209-00052#1 mark s---       
#      #1）抓出该账套下所有成本分群码 + 库存科目或在制科目
#      LET l_sql="SELECT DISTINCT glcc001,glcc011,glcc002 FROM glcc_t ",  
#                " WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
#                "   AND glcc001 IN ('1','3')  AND ",l_wc
#      PREPARE aglq510_sel_glcc_pr FROM l_sql
#      DECLARE aglq510_sel_glcc_cs CURSOR FOR aglq510_sel_glcc_pr
#      FOREACH aglq510_sel_glcc_cs INTO l_glcc001,l_glcc011,l_glar001
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = 'FOREACH aglq510_sel_glcc_cs'
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            LET l_success = FALSE
#            EXIT FOREACH
#         END IF
#         #2）抓取成本分群码下料号的金额，按照币别汇总金额，并将抓取到资料插入临时表中
#         #注：此时插入的资料只是过渡资料，并不是要显示到单身的资料，此时glarent=NULL ,
#         #    diff字段存储成本分群，用于后续抓取子系统金额
#         #    为了第三部按照科目+币别汇出金额，与总账金额进行比较
#         #成本分群（agli161中维护）：
#         #         当成本分群码不等于‘*’时，抓取axci120中维护的，该成本分群码下所有的料件编号；
#         #         当成本分群码等于‘*’时，抓取axci120中没有维护分群码的料号，或者是维护的分群码不存在与agli161中的料号
#         IF l_glcc001='1' THEN #存货科目
#            LET l_sql="SELECT xccc010,SUM(xccc902) ",
#                      "  FROM xccc_t,xcbb_t ",
#                      " WHERE xcccent=xcbbent AND xccc004=xcbb001 AND xccc005=xcbb002 AND xccc006=xcbb003 ",
#                      "   AND xcccent=",g_enterprise," AND xcccld='",tm.glaald,"' ",
#                      "   AND xccc001='1' AND xccc004=",tm.glar002," AND xccc005=",tm.glar003,
#                      "   AND xcbbcomp='",tm.glaacomp,"' ",
#                      "   AND ",l_wc1
#            IF l_glcc011 <> '* ' THEN
#               LET l_sql=l_sql," AND xcbb010='",l_glcc011,"'"
#            ELSE
#               LET l_sql=l_sql," AND (xcbb010 IS NULL OR ",
#                               "      xcbb010 NOT IN (SELECT DISTINCT glcc011 FROM glcc_t ",
#                               "                      WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
#                               "                        AND glcc001='1' AND glcc011 <> '*' )",
#                               "      )"
#            END IF
#            LET l_sql=l_sql," GROUP BY xccc010",
#                            " ORDER BY xccc010"
#         ELSE #在制科目
#            #成本分群条件
#            IF l_glcc011 <> '* ' THEN
#               LET l_sql1=" xcbb010='",l_glcc011,"'"
#            ELSE
#               LET l_sql1=" (xcbb010 IS NULL OR ",
#                          "  xcbb010 NOT IN (SELECT DISTINCT glcc011 FROM glcc_t ",
#                          "                  WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
#                          "                    AND glcc001='3' AND glcc011 <> '*' )",
#                          "  )"
#            END IF
#            LET l_sql="SELECT curr,SUM(amt) ",
#                      "  FROM (",
#                      "         (SELECT xccd011 curr,SUM(xccd902) amt",
#                      "            FROM xccd_t,xcbb_t ",
#                      "           WHERE xccdent=xcbbent AND xccd004=xcbb001 AND xccd005=xcbb002 AND xccd007=xcbb003 ",
#                      "             AND xccdent=",g_enterprise," AND xccdld='",tm.glaald,"' ",
#                      "             AND xccd001='1' AND xccd004=",tm.glar002," AND xccd005=",tm.glar003,
#                      "             AND xcbbcomp='",tm.glaacomp,"' ",
#                      "             AND ",l_wc2,
#                      "             AND ",l_sql1,
#                      "           GROUP BY xccd011 ",
#                      "         )",
#                      "         UNION ",
#                      "         (SELECT xcch011 curr,SUM(xcch902) amt",
#                      "            FROM xcch_t,xcbb_t ",
#                      "           WHERE xcchent=xcbbent AND xcch004=xcbb001 AND xcch005=xcbb002 AND xcch007=xcbb003 ",
#                      "             AND xcchent=",g_enterprise," AND xcchld='",tm.glaald,"' ",
#                      "             AND xcch001='1' AND xcch004=",tm.glar002," AND xcch005=",tm.glar003,
#                      "             AND xcbbcomp='",tm.glaacomp,"' ",
#                      "             AND ",l_wc3,
#                      "             AND ",l_sql1,
#                      "           GROUP BY xcch011 ",
#                      "         )",
#                      "       ) ",
#                      " GROUP BY curr ",
#                      " ORDER BY curr "
#         END IF
#         PREPARE aglq510_sel_xccc_pr FROM l_sql
#         DECLARE aglq510_sel_xccc_cs CURSOR FOR aglq510_sel_xccc_pr
#         FOREACH aglq510_sel_xccc_cs INTO l_glar009,l_amt
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'FOREACH aglq510_sel_xccc_cs'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET l_success = FALSE
#               EXIT FOREACH
#            END IF
#            IF cl_null(l_amt) THEN LET l_amt = 0 END IF
#            #系统别:5.成本
#            LET l_sys = '5' 
#            
#            #插入临时表
#            #暂用diff字段存储成本分群，用于后续抓取子系统金额
#            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
#            VALUES(l_sys,l_glar001,l_glar009,l_amt,l_glcc011)
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'insert'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET l_success = FALSE
#            END IF
#         END FOREACH
#      END FOREACH
#161209-00052#1 mark e---      
#161209-00052#1 add s--- 
      #1）抓出该账套下所有成本分群码 + 库存科目 
      LET l_sql="SELECT DISTINCT glcc001,glcc011,glcc002 FROM glcc_t ",  
                " WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
                "   AND glcc001 IN ('1')  AND ",l_wc
      PREPARE aglq510_sel_glcc_pr1 FROM l_sql
      DECLARE aglq510_sel_glcc_cs1 CURSOR FOR aglq510_sel_glcc_pr1
      FOREACH aglq510_sel_glcc_cs1 INTO l_glcc001,l_glcc011,l_glar001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_glcc_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #2）抓取成本分群码下料号的金额，按照币别汇总金额，并将抓取到资料插入临时表中
         #注：此时插入的资料只是过渡资料，并不是要显示到单身的资料，此时glarent=NULL ,
         #    diff字段存储成本分群，用于后续抓取子系统金额
         #    为了第三部按照科目+币别汇出金额，与总账金额进行比较
         #成本分群（agli161中维护）：
         #         当成本分群码不等于‘*’时，抓取axci120中维护的，该成本分群码下所有的料件编号；
         #         当成本分群码等于‘*’时，抓取axci120中没有维护分群码的料号，或者是维护的分群码不存在与agli161中的料号
         IF l_glcc001='1' THEN #存货科目
            LET l_sql="SELECT xccc010,SUM(xccc902) ",
                      "  FROM xccc_t,xcbb_t ",
                      " WHERE xcccent=xcbbent AND xccc004=xcbb001 AND xccc005=xcbb002 AND xccc006=xcbb003 ",
                      "   AND xcccent=",g_enterprise," AND xcccld='",tm.glaald,"' ",
                      "   AND xccc001='1' AND xccc004=",tm.glar002," AND xccc005=",tm.glar003,
                      "   AND xcbbcomp='",tm.glaacomp,"' ",
                      "   AND ",l_wc1
            IF l_glcc011 <> '* ' THEN
               LET l_sql=l_sql," AND xcbb010='",l_glcc011,"'"
            ELSE
               LET l_sql=l_sql," AND (xcbb010 IS NULL OR ",
                               "      xcbb010 NOT IN (SELECT DISTINCT glcc011 FROM glcc_t ",
                               "                      WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
                               "                        AND glcc001='1' AND glcc011 <> '*' )",
                               "      )"
            END IF
            LET l_sql=l_sql," GROUP BY xccc010",
                            " ORDER BY xccc010"
         END IF
         PREPARE aglq510_sel_xccc_pr1 FROM l_sql
         DECLARE aglq510_sel_xccc_cs1 CURSOR FOR aglq510_sel_xccc_pr1
         FOREACH aglq510_sel_xccc_cs1 INTO l_glar009,l_amt
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq510_sel_xccc_cs1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            IF cl_null(l_amt) THEN LET l_amt = 0 END IF
            #系统别:5.成本
            LET l_sys = '5' 
            
            #插入临时表
            #暂用diff字段存储成本分群，用于后续抓取子系统金额
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001,l_glar009,l_amt,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
         END FOREACH
      END FOREACH
      
      #1）抓出该账套下所有成本分群码 + 在制科目 
      LET l_sql="SELECT DISTINCT glcc001,glcc011,glcc002,glcc003,glcc004,glcc005,glcc006,glcc017,glcc018,glcc019 FROM glcc_t ",  
                " WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
                "   AND glcc001 IN ('3')  AND ",l_wc
      PREPARE aglq510_sel_glcc_pr2 FROM l_sql
      DECLARE aglq510_sel_glcc_cs2 CURSOR FOR aglq510_sel_glcc_pr2
      FOREACH aglq510_sel_glcc_cs2 INTO l_glcc001,l_glcc011,l_glar001,l_glar001_2,l_glar001_3,l_glar001_4,l_glar001_5,
      l_glar001_6,l_glar001_7,l_glar001_8
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_glcc_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #2）抓取成本分群码下料号的金额，按照币别汇总金额，并将抓取到资料插入临时表中
         #注：此时插入的资料只是过渡资料，并不是要显示到单身的资料，此时glarent=NULL ,
         #    diff字段存储成本分群，用于后续抓取子系统金额
         #    为了第三部按照科目+币别汇出金额，与总账金额进行比较
         #成本分群（agli161中维护）：
         #         当成本分群码不等于‘*’时，抓取axci120中维护的，该成本分群码下所有的料件编号；
         #         当成本分群码等于‘*’时，抓取axci120中没有维护分群码的料号，或者是维护的分群码不存在与agli161中的料号
 
            #成本分群条件
            IF l_glcc011 <> '* ' THEN
               LET l_sql1=" xcbb010='",l_glcc011,"'"
            ELSE
               LET l_sql1=" (xcbb010 IS NULL OR ",
                          "  xcbb010 NOT IN (SELECT DISTINCT glcc011 FROM glcc_t ",
                          "                  WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
                          "                    AND glcc001='3' AND glcc011 <> '*' )",
                          "  )"
            END IF
            LET l_sql="SELECT curr,SUM(amt),SUM(amt2),SUM(amt3),SUM(amt4),SUM(amt5),SUM(amt6),SUM(amt7),SUM(amt8) ",
                      "  FROM (",
                      "         (SELECT xccd011 curr,SUM(xccd902a) amt,SUM(xccd902b) amt2,SUM(xccd902c) amt3,SUM(xccd902d) amt4,SUM(xccd902e) amt5,SUM(xccd902f) amt6,SUM(xccd902g) amt7,SUM(xccd902h) amt8",
                      "            FROM xccd_t,xcbb_t ",
                      "           WHERE xccdent=xcbbent AND xccd004=xcbb001 AND xccd005=xcbb002 AND xccd007=xcbb003 ",
                      "             AND xccdent=",g_enterprise," AND xccdld='",tm.glaald,"' ",
                      "             AND xccd001='1' AND xccd004=",tm.glar002," AND xccd005=",tm.glar003,
                      "             AND xcbbcomp='",tm.glaacomp,"' ",
                      "             AND ",l_wc2,
                      "             AND ",l_sql1,
                      #170208-00041#1--add--str--lujh
                      "             AND xccd006 IN (SELECT sfaadocno FROM sfaa_t WHERE sfaaent = ",g_enterprise,
                      "                                 AND sfaa057 <> '2') ",
                      #170208-00041#1--add--end--lujh
                      "           GROUP BY xccd011 ",
                      "         )",
                      "         UNION ",
                      "         (SELECT xcch011 curr,SUM(xcch902a) amt,SUM(xcch902b) amt2,SUM(xcch902c) amt3,SUM(xcch902d) amt4,SUM(xcch902e) amt5,SUM(xcch902f) amt6,SUM(xcch902g) amt7,SUM(xcch902h) amt8",
                      "            FROM xcch_t,xcbb_t ",
                      "           WHERE xcchent=xcbbent AND xcch004=xcbb001 AND xcch005=xcbb002 AND xcch007=xcbb003 ",
                      "             AND xcchent=",g_enterprise," AND xcchld='",tm.glaald,"' ",
                      "             AND xcch001='1' AND xcch004=",tm.glar002," AND xcch005=",tm.glar003,
                      "             AND xcbbcomp='",tm.glaacomp,"' ",
                      "             AND ",l_wc3,
                      "             AND ",l_sql1,
                      "           GROUP BY xcch011 ",
                      "         )",
                      "       ) ",
                      " GROUP BY curr ",
                      " ORDER BY curr "
       
         PREPARE aglq510_sel_xccc_pr2 FROM l_sql
         DECLARE aglq510_sel_xccc_cs2 CURSOR FOR aglq510_sel_xccc_pr2
         FOREACH aglq510_sel_xccc_cs2 INTO l_glar009,l_amt,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7,l_amt8
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq510_sel_xccc_cs2'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            IF cl_null(l_amt) THEN LET l_amt = 0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
            IF cl_null(l_amt7) THEN LET l_amt7 = 0 END IF
            IF cl_null(l_amt8) THEN LET l_amt8 = 0 END IF
            #系统别:5.成本
            LET l_sys = '5' 
            
            #插入临时表
            #暂用diff字段存储成本分群，用于后续抓取子系统金额
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001,l_glar009,l_amt,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF            
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_2,l_glar009,l_amt2,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert2'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_3,l_glar009,l_amt3,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert3'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF          
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_4,l_glar009,l_amt4,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert4'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF            
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_5,l_glar009,l_amt5,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert5'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_6,l_glar009,l_amt6,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert6'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF            
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_7,l_glar009,l_amt7,l_glcc011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert7'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF   
            
            INSERT INTO aglq510_tmp(sys,glar001,glar009,samt,diff)
            VALUES(l_sys,l_glar001_8,l_glar009,l_amt8,l_glcc011) 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert8'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF     
         END FOREACH
      END FOREACH      
#161209-00052#1 add e---      
      #3)汇总临时表中第二步存入的成本金额，按照科目+币别汇总金额，同时抓取总账金额，进行比较差异
      #  将比较结果及金额，插入到临时表，此时glarent=g_enterprise用于显示在单身，固资系统勾稽的最终数据
      LET l_sql="SELECT glar001,glar009,SUM(samt) ",
                "  FROM aglq510_tmp ",
                " WHERE glarent IS NULL AND sys='5'",
                " GROUP BY glar001,glar009 ",
                " ORDER BY glar001,glar009 "
      PREPARE aglq510_sel_tmp_pr1 FROM l_sql
      DECLARE aglq510_sel_tmp_cs1 CURSOR FOR aglq510_sel_tmp_pr1
      FOREACH aglq510_sel_tmp_cs1 INTO l_glar001,l_glar009,l_xrea113
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_tmp_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #科目说明
         LET l_glar001_desc = ''
         CALL s_desc_get_account_desc(tm.glaald,l_glar001) RETURNING l_glar001_desc
         IF cl_null(l_xrea113) THEN LET l_xrea113 = 0 END IF
         #原币金额 = 本币金额
         LET l_xrea103 = l_xrea113
         
         #当该账套启用分录底稿时，计算分录底稿余额，分别与子系统、总账进行比较
         IF g_glaa121 = 'Y' THEN
            #固资中分录底稿金额 = 子系统金额
            LET l_glat103 = l_xrea103
            LET l_glat113 = l_xrea113
         END IF
         
         #161217-00001#1 mod s---
         #抓取总账余额
         #EXECUTE aglq510_sel_glar_pr1 USING l_glar001,l_glar009
         #                             INTO l_glar010,l_glar005
         EXECUTE aglq510_sel_glar_pr2 USING l_glar001
                                      INTO l_glar010,l_glar005                                      
         #161217-00001#1 mod e---                              
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'EXE aglq510_sel_glar_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_glar010) THEN LET l_glar010 = 0 END IF
         IF cl_null(l_glar005) THEN LET l_glar005 = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         SELECT glac008 INTO l_glac008 FROM glac_t 
          WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
         IF l_glac008 = '2' THEN
            LET l_glar010 = l_glar010 * -1
            LET l_glar005 = l_glar005 * -1
         END IF
         
         #进行金额比较
         #当启用分录底稿
         IF g_glaa121 = 'Y' THEN
            IF l_xrea103 = l_glat103 AND l_xrea103 = l_glar010 AND
               l_xrea113 = l_glat113 AND l_xrea113 = l_glar005 THEN
               LET l_diff = '0'  #0.子系统、底稿、总账均无差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 = l_glar010 AND l_xrea113 = l_glar005) THEN
               LET l_diff = '1'  #1.子系统与底稿有差异与总账无差异
            END IF
            
            IF (l_xrea103 = l_glat103 AND l_xrea113 = l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) THEN
               LET l_diff = '2'  #2.子系统与底稿无差异与总账有差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
               (l_glat103 = l_glar010 AND l_glat113 = l_glar005)THEN
               LET l_diff = '3'  #3.子系统与底稿有差异与总账有差异，底稿与总账无差异
            END IF
            
            IF (l_xrea103 <> l_glat103 OR l_xrea113 <> l_glat113) AND
               (l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005) AND 
               (l_glat103 <> l_glar010 OR l_glat113 <> l_glar005)THEN
               LET l_diff = '4'  #4.子系统、底稿、总账均有差异
            END IF
         ELSE
         #未启用分录底稿时，只需比较子系统与总账余额差异
            IF l_xrea103 <> l_glar010 OR l_xrea113 <> l_glar005 THEN
               LET l_diff = '6'  #6.子系统与总账有差异
            ELSE
               LET l_diff = '5'  #5.子系统与总账无差异
            END IF            
         END IF
         
         #核对结果
         IF l_diff = '0' OR l_diff = '5' THEN
            LET l_result = '0' #0.核对OK
         ELSE
            LET l_result = '1' #1.核对有误
         END IF
     
         #系统别:5.成本
         LET l_sys = '5' 
         
         #插入临时表
         INSERT INTO aglq510_tmp(glarent,sys,glar001,glar001_desc,glar009,
                                 soamt,doamt,zoamt,samt,damt,zamt,diff,result)
         VALUES(g_enterprise,l_sys,l_glar001,l_glar001_desc,l_glar009,
                l_xrea103,l_glat103,l_glar010,l_xrea113,l_glat113,l_glar005,l_diff,l_result)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END FOREACH
   END IF
   
   #检查投融资系统
   IF tm.chk_fm='Y' THEN
   END IF
   CALL cl_err_collect_show()
END FUNCTION

################################################################################
# Descriptions...: 子系统与分录底稿差异
# Memo...........:
# Usage..........: CALL aglq510_b_fill2()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq510_b_fill2()
   DEFINE l_sql               STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_xrea009           LIKE xrea_t.xrea009   #账款客户
   DEFINE l_xrea003           LIKE xrea_t.xrea003   #系统别
   DEFINE l_xrea019           LIKE xrea_t.xrea019   #科目
   DEFINE l_xrea100           LIKE xrea_t.xrea100   #币别
   DEFINE l_xrea103           LIKE xrea_t.xrea103   #子系统原币余额
   DEFINE l_xrea113           LIKE xrea_t.xrea113   #子系统本币余额
   DEFINE l_sys               LIKE type_t.chr10     #系统别
   DEFINE l_glat103           LIKE glat_t.glat103   #底稿原币余额
   DEFINE l_glat113           LIKE glat_t.glat113   #底稿本币余额
   DEFINE l_diff1             LIKE glat_t.glat103   #原币差异金额
   DEFINE l_diff2             LIKE glat_t.glat103   #本币差异金额
   DEFINE l_glac008           LIKE glac_t.glac008
   
   CALL g_glar2_d.clear()
   LET l_i=0
   #抓取底稿余额
   LET l_sql="SELECT SUM(glat103-glat104),SUM(glat113-glat114) ",
             "  FROM glat_t ",
             " WHERE glatent=",g_enterprise," AND glatld='",tm.glaald,"'",
             "   AND glat001=",tm.glar002," AND glat002<=",tm.glar003,
             "   AND glat003=? AND glat005=? AND glat007=? AND glat100=? "
   PREPARE aglq510_b_fill2_glat_pr1 FROM l_sql
   
   #检查应收&应付系统
   IF tm.chk_ar = 'Y' OR tm.chk_ap = 'Y' THEN
      #160728-00003#1--mod--str--
#      LET l_sql="SELECT sys,xrea003,xrea009,xrea019,xrea100,SUM(xrea103),SUM(xrea113)",
      LET l_sql="SELECT sys,xrea003,xrea009,xrea019,xrea100,",
                "       SUM(CASE WHEN xrea004 LIKE '2%' THEN xrea103*-1 ELSE xrea103 END),",
                "       SUM(CASE WHEN xrea004 LIKE '2%' THEN xrea113*-1 ELSE xrea113 END) ",
      #160728-00003#1--mod--end
                "  FROM xrea_t,aglq510_tmp ",
                " WHERE xreaent=glarent AND xrea019=glar001 AND xrea100=glar009 ",
                "   AND xreaent=",g_enterprise," AND xreald='",tm.glaald,"'",
#                "   AND xrea001=",tm.glar002," AND xrea002<=",tm.glar003, #160728-00003#1 mark
                "   AND xrea001=",tm.glar002," AND xrea002 =",tm.glar003, #160728-00003#1 add
                "   AND ",g_wc3,
                "   AND sys IN ('1','2')",
                "   AND diff IN ('1','3','4')",
                " GROUP BY sys,xrea003,xrea009,xrea019,xrea100 ",
                " ORDER BY sys,xrea003,xrea009,xrea019,xrea100 "
      PREPARE aglq510_b_fill2_xrea_pr1 FROM l_sql
      DECLARE aglq510_b_fill2_xrea_cs1 CURSOR FOR aglq510_b_fill2_xrea_pr1
      FOREACH aglq510_b_fill2_xrea_cs1 INTO l_sys,l_xrea003,l_xrea009,l_xrea019,l_xrea100,l_xrea103,l_xrea113
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_b_fill2_xrea_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         IF cl_null(l_xrea103) THEN LET l_xrea103 = 0 END IF
         IF cl_null(l_xrea113) THEN LET l_xrea113 = 0 END IF
         
         #当该账套启用分录底稿时，计算分录底稿余额，分别与子系统、总账进行比较
         EXECUTE aglq510_b_fill2_glat_pr1 USING l_xrea003,l_xrea009,l_xrea019,l_xrea100
                                          INTO l_glat103,l_glat113
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'EXE aglq510_sel_glat_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         IF cl_null(l_glat103) THEN LET l_glat103 = 0 END IF
         IF cl_null(l_glat113) THEN LET l_glat113 = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         SELECT glac008 INTO l_glac008 FROM glac_t 
          WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_xrea019
         IF l_glac008 = '2' THEN
            LET l_glat103 = l_glat103 * -1
            LET l_glat113 = l_glat113 * -1
         END IF
         
         #进行金额比较，当子系统金额与分录底稿金额不等时，写入单身二b_fill2
         LET l_diff1 = l_xrea103 - l_glat103
         LET l_diff2 = l_xrea113 - l_glat113
         IF l_diff1 <> 0 OR l_diff2 <> 0 THEN
            LET l_i = l_i + 1
            
            LET g_glar2_d[l_i].sys2 = l_sys  #系统别
            LET g_glar2_d[l_i].xrea009 = l_xrea009
            #账款对象说明
            CALL s_desc_get_trading_partner_abbr_desc(g_glar2_d[l_i].xrea009) RETURNING g_glar2_d[l_i].xrea009_desc
            LET g_glar2_d[l_i].xrea019 = l_xrea019
            #科目说明
            CALL s_desc_get_account_desc(tm.glaald,g_glar2_d[l_i].xrea019 ) RETURNING g_glar2_d[l_i].xrea019_desc
            LET g_glar2_d[l_i].xrea100 = l_xrea100
            LET g_glar2_d[l_i].samt1 = l_xrea103
            LET g_glar2_d[l_i].damt1 = l_glat103
            LET g_glar2_d[l_i].diff1 = l_diff1
            LET g_glar2_d[l_i].samt2 = l_xrea113
            LET g_glar2_d[l_i].damt2 = l_glat113
            LET g_glar2_d[l_i].diff2 = l_diff2
         END IF
      END FOREACH
   END IF
   
   #固资系统，资金系统，成本系统，投融资系统
   #因规格中分录底稿金额 = 子系统金额，故不存在差异
END FUNCTION

################################################################################
# Descriptions...: 分录底稿与总账差异
# Memo...........:
# Usage..........: CALL aglq510_b_fill3()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq510_b_fill3()
   DEFINE l_sql               STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_sys               LIKE type_t.chr10     #系统别
   DEFINE l_glar001           LIKE glar_t.glar001   #科目
   DEFINE l_glar001_desc      LIKE glacl_t.glacl004 #科目说明
   DEFINE l_glar009           LIKE glar_t.glar009   #币别
   DEFINE l_glga100           LIKE glga_t.glga100   #系统别
   DEFINE l_glgadocno         LIKE glga_t.glgadocno #业务单号
   DEFINE l_glgadocdt         LIKE glga_t.glgadocdt #业务单日期
   DEFINE l_glgastus          LIKE glga_t.glgastus  #分录底稿状态
   DEFINE l_glga007           LIKE glga_t.glga007   #分录底稿凭证号
   DEFINE l_doamt             LIKE glgb_t.glgb003   #分录底稿原币余额
   DEFINE l_damt              LIKE glgb_t.glgb003   #分录底稿本币余额
   DEFINE l_glapdocno         LIKE glap_t.glapdocno #总账凭证号
   DEFINE l_glapdocdt         LIKE glap_t.glapdocdt #凭证日期
   DEFINE l_glapstus          LIKE glap_t.glapstus  #凭证状态
   DEFINE l_zoamt             LIKE glaq_t.glaq003   #总账原币余额
   DEFINE l_zamt              LIKE glaq_t.glaq003   #总账本币余额
   DEFINE l_diff3             LIKE glaq_t.glaq003   #原币差额
   DEFINE l_diff4             LIKE glaq_t.glaq003   #本币差额
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_sdate             LIKE glga_t.glgadocdt
   DEFINE l_edate             LIKE glga_t.glgadocdt
   DEFINE l_glac008           LIKE glac_t.glac008
   
   CALL g_glar3_d.clear()
   LET l_i=0
   
   #该年第一天
   SELECT MIN(glav004) INTO l_sdate FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.glar002
   #该期最会一天
   SELECT MAX(glav004) INTO l_edate 
     FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 
      AND glav002=tm.glar002 AND glav006=tm.glar003
      
   #1）遍历临时表中科目+币别
   LET l_sql="SELECT DISTINCT sys,glar001,glar009 ",
             "  FROM aglq510_tmp ",
             " WHERE diff IN ('1','2','4')",
             " ORDER BY sys,glar001,glar009"
   PREPARE aglq510_sel_tmp_pr FROM l_sql
   DECLARE aglq510_sel_tmp_cs CURSOR FOR aglq510_sel_tmp_pr
   
   #2）抓取分录底稿资料：此业务分录底稿没有抛转产生总账凭证;
   LET l_sql="SELECT glgadocno,glgadocdt,glgastus,",
             "       SUM(CASE WHEN glgb003=0 THEN glgb010*-1 ELSE glgb010 END),",
             "       SUM(glgb003-glgb004) ",
             "  FROM glga_t,glgb_t ",
             " WHERE glgaent=glgbent AND glgald=glgbld AND glgadocno=glgbdocno ",
             "   AND glgaent=",g_enterprise," AND glgald='",tm.glaald,"'",
             "   AND glgadocdt BETWEEN '",l_sdate,"' AND '",l_edate,"'",
             "   AND glga007 IS NULL ",
             "   AND glgastus <> 'X' ",  #161222-00037#1 add lujh
             "   AND glga100=? AND glgb002=? AND glgb005=? ",
             " GROUP BY glgadocno,glgadocdt,glgastus ",
             " ORDER BY glgadocno,glgadocdt,glgastus"
   PREPARE aglq510_sel_glga_pr FROM l_sql
   DECLARE aglq510_sel_glga_cs CURSOR FOR aglq510_sel_glga_pr
   
   #3）抓取分录底稿资料：此业务分录底稿抛转产生总账凭证;
   LET l_sql="SELECT glga007,",
             "       SUM(CASE WHEN glgb003=0 THEN glgb010*-1 ELSE glgb010 END),",
             "       SUM(glgb003-glgb004) ",
             "  FROM glga_t,glgb_t ",
             " WHERE glgaent=glgbent AND glgald=glgbld AND glgadocno=glgbdocno ",
             "   AND glgaent=",g_enterprise," AND glgald='",tm.glaald,"'",
             "   AND glgadocdt BETWEEN '",l_sdate,"' AND '",l_edate,"'",
             "   AND glga007 IS NOT NULL ",
             "   AND glgastus <> 'X' ",  #161222-00037#1 add lujh
             "   AND glga100=? AND glgb002=? AND glgb005=? ",
             " GROUP BY glga007 ",
             " ORDER BY glga007"
   PREPARE aglq510_sel_glga_pr1 FROM l_sql
   DECLARE aglq510_sel_glga_cs1 CURSOR FOR aglq510_sel_glga_pr1
   
   #4）无分录底稿资料，抓取凭证资料
   LET l_sql="SELECT glapdocno,glapdocdt,glapstus,",
             "       SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),",
             "       SUM(glaq003-glaq004) ",
             "  FROM glap_t,glaq_t ",
             " WHERE glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno ",
             "   AND glapent=",g_enterprise," AND glapld='",tm.glaald,"'",
             "   AND glap002=",tm.glar002," AND glap004<=",tm.glar003,
             "   AND glapdocno NOT IN (SELECT DISTINCT glga007 FROM glga_t ",
             "                          WHERE glgaent=",g_enterprise," AND glgald='",tm.glaald,"'",
             "                            AND glgadocdt BETWEEN '",l_sdate,"' AND '",l_edate,"'",
             "                         )",
             "   AND glap007=? AND glaq002=? AND glaq005=? ",
             " GROUP BY glapdocno,glapdocdt,glapstus ",
             " ORDER BY glapdocno,glapdocdt,glapstus"
   PREPARE aglq510_sel_glap_pr FROM l_sql
   DECLARE aglq510_sel_glap_cs CURSOR FOR aglq510_sel_glap_pr
   
   #1）遍历临时表中科目+币别
   FOREACH aglq510_sel_tmp_cs INTO l_sys,l_glar001,l_glar009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH aglq510_sel_tmp_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      CASE l_sys
         WHEN '1' LET l_glga100 = 'AR' 
         WHEN '2' LET l_glga100 = 'AP' 
         WHEN '3' LET l_glga100 = 'FA' 
         WHEN '4' LET l_glga100 = 'NM' 
         WHEN '5' LET l_glga100 = 'XC' 
         WHEN '6' LET l_glga100 = 'FM' 
      END CASE
      
      #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
      SELECT glac008 INTO l_glac008 FROM glac_t 
       WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
      
      #2）抓取分录底稿资料：业务分录底稿没有抛转产生总账凭证;
      FOREACH aglq510_sel_glga_cs USING l_glga100,l_glar001,l_glar009
                                  INTO l_glgadocno,l_glgadocdt,l_glgastus,l_doamt,l_damt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_glga_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         IF cl_null(l_doamt) THEN LET l_doamt = 0 END IF
         IF cl_null(l_damt) THEN LET l_damt = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         IF l_glac008 = '2' THEN
            LET l_doamt = l_doamt * -1
            LET l_damt = l_damt * -1
         END IF
         
         #3)分析差异原因
         #a.底稿凭证号码为空的且底稿未审核的金额
         #b.底稿凭证号码为空的且底稿审核的金额
         LET l_i = l_i + 1
         LET g_glar3_d[l_i].sys3 = l_sys
         LET g_glar3_d[l_i].glgadocno = l_glgadocno
         LET g_glar3_d[l_i].glgadocdt = l_glgadocdt
         LET g_glar3_d[l_i].glgastus = l_glgastus
         LET g_glar3_d[l_i].glapdocno = ''
         LET g_glar3_d[l_i].glapdocdt = NULL
         LET g_glar3_d[l_i].glapstus = NULL
         LET g_glar3_d[l_i].glgb002 = l_glar001
         LET g_glar3_d[l_i].glgb002_desc = s_desc_get_account_desc(tm.glaald,g_glar3_d[l_i].glgb002 )
         LET g_glar3_d[l_i].glgb005 = l_glar009
         LET g_glar3_d[l_i].damt3 = l_doamt
         LET g_glar3_d[l_i].zamt3 = 0
         LET g_glar3_d[l_i].diff3 = g_glar3_d[l_i].damt3 - g_glar3_d[l_i].zamt3
         LET g_glar3_d[l_i].damt4 = l_damt
         LET g_glar3_d[l_i].zamt4 = 0
         LET g_glar3_d[l_i].diff4 = g_glar3_d[l_i].damt4 - g_glar3_d[l_i].zamt4
      END FOREACH
      
      #3）抓取分录底稿资料：此业务分录底稿抛转产生总账凭证;
      FOREACH aglq510_sel_glga_cs1 USING l_glga100,l_glar001,l_glar009
                                  INTO l_glga007,l_doamt,l_damt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_glga_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         IF cl_null(l_doamt) THEN LET l_doamt = 0 END IF
         IF cl_null(l_damt) THEN LET l_damt = 0 END IF
         
         #3)分析差异原因
         #c)底稿凭证号码不为空的但该凭证号在总账未审核的金额
         #d)底稿凭证号码不为空的但该凭证号在总账已审核未国过账的金额
         #e)底稿凭证号码不为空的且该凭证号在总账已过账的但科目金额不一致的
         
         #通过底稿凭证号码抓取对应的总账凭证资料
         #凭证日期，凭证状态
         LET l_glapdocdt = ''
         LET l_glapstus = ''
         SELECT glapdocdt,glapstus INTO l_glapdocdt,l_glapstus
           FROM glap_t
          WHERE glapent=g_enterprise AND glapld=tm.glaald AND glapdocno=l_glga007
         #凭证原币余额，凭证本币余额 
         LET l_zoamt = 0
         LET l_zamt = 0
         SELECT SUM(CASE WHEN glaq003=0 THEN glaq010*-1 ELSE glaq010 END),SUM(glaq003-glaq004)
           INTO l_zoamt,l_zamt
           FROM glaq_t
          WHERE glaqent=g_enterprise AND glaqld=tm.glaald AND glaqdocno=l_glga007
            AND glaq002=l_glar001 AND glaq005=l_glar009 
         IF cl_null(l_zoamt) THEN LET l_zoamt = 0 END IF
         IF cl_null(l_zamt) THEN LET l_zamt = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         IF l_glac008 = '2' THEN
            LET l_doamt = l_doamt * -1
            LET l_damt = l_damt * -1
            LET l_zoamt = l_zoamt * -1
            LET l_zamt = l_zamt * -1
         END IF
         
         #差额 = 分录底稿余额 - 总账余额
         LET l_diff3 = l_doamt - l_zoamt
         LET l_diff4 = l_damt - l_zamt
         #底稿与总账无差异时不写入单身
        #IF l_glgastus = 'Y' AND l_glapstus = 'S' AND l_diff3 = 0 AND l_diff4 = 0 THEN   #161124-00078#1 Mark
         IF l_glapstus = 'S' AND l_diff3 = 0 AND l_diff4 = 0 THEN   #161124-00078#1 Add
            CONTINUE FOREACH
         ELSE
            #判断总账凭着编号对应几张业务底稿编号，如果对应一张，查询出业务底稿单据编号+单据日期+单据状态，如果对应多张，单据编号=MULTI
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM glga_t
             WHERE glgaent=g_enterprise AND glgald=tm.glaald AND glga007=l_glga007
            IF l_cnt = 1 THEN
               #抓取业务分录底稿编号+单据日期+单据状态
               SELECT glgadocno,glgadocdt,glgastus INTO l_glgadocno,l_glgadocdt,l_glgastus
                 FROM glga_t
                WHERE glgaent=g_enterprise AND glgald=tm.glaald AND glga007=l_glga007
            ELSE
               LET l_glgadocno = 'MULTI'
               LET l_glgadocdt = NULL
               LET l_glgastus  = NULL
            END IF
            LET l_i = l_i + 1
            LET g_glar3_d[l_i].sys3 = l_sys
            LET g_glar3_d[l_i].glgadocno = l_glgadocno
            LET g_glar3_d[l_i].glgadocdt = l_glgadocdt
            LET g_glar3_d[l_i].glgastus = l_glgastus
            LET g_glar3_d[l_i].glapdocno = l_glga007
            LET g_glar3_d[l_i].glapdocdt = l_glapdocdt
            LET g_glar3_d[l_i].glapstus = l_glapstus
            LET g_glar3_d[l_i].glgb002 = l_glar001
            LET g_glar3_d[l_i].glgb002_desc = s_desc_get_account_desc(tm.glaald,g_glar3_d[l_i].glgb002 )
            LET g_glar3_d[l_i].glgb005 = l_glar009
            LET g_glar3_d[l_i].damt3 = l_doamt
            LET g_glar3_d[l_i].zamt3 = l_zoamt
            LET g_glar3_d[l_i].diff3 = l_diff3
            LET g_glar3_d[l_i].damt4 = l_damt
            LET g_glar3_d[l_i].zamt4 = l_zamt
            LET g_glar3_d[l_i].diff4 = l_diff4
         END IF
      END FOREACH
      
      #4)分析差异原因
      #f.没有底稿但有总账凭证的
      FOREACH aglq510_sel_glap_cs USING l_glga100,l_glar001,l_glar009
                                   INTO l_glapdocno,l_glapdocdt,l_glapstus,l_zoamt,l_zamt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_sel_glap_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         IF cl_null(l_zoamt) THEN LET l_zoamt = 0 END IF
         IF cl_null(l_zamt) THEN LET l_zamt = 0 END IF
         
         #当科目余额方向为借方，余额=借-贷，当科目余额方向为贷方，余额=贷-借
         IF l_glac008 = '2' THEN
            LET l_zoamt = l_zoamt * -1
            LET l_zamt = l_zamt * -1
         END IF
         
         LET l_i = l_i + 1
         LET g_glar3_d[l_i].sys3 = l_sys
         LET g_glar3_d[l_i].glgadocno = ''
         LET g_glar3_d[l_i].glgadocdt = ''
         LET g_glar3_d[l_i].glgastus = ''
         LET g_glar3_d[l_i].glapdocno = l_glapdocno
         LET g_glar3_d[l_i].glapdocdt = l_glapdocdt
         LET g_glar3_d[l_i].glapstus = l_glapstus
         LET g_glar3_d[l_i].glgb002 = l_glar001
         LET g_glar3_d[l_i].glgb002_desc = s_desc_get_account_desc(tm.glaald,g_glar3_d[l_i].glgb002 )
         LET g_glar3_d[l_i].glgb005 = l_glar009
         LET g_glar3_d[l_i].damt3 = 0
         LET g_glar3_d[l_i].zamt3 = l_zoamt
         LET g_glar3_d[l_i].diff3 = g_glar3_d[l_i].damt3 - g_glar3_d[l_i].zamt3
         LET g_glar3_d[l_i].damt4 = 0
         LET g_glar3_d[l_i].zamt4 = l_zamt
         LET g_glar3_d[l_i].diff4 = g_glar3_d[l_i].damt4 - g_glar3_d[l_i].zamt4
      END FOREACH
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 子系统与总账差异
# Memo...........:
# Usage..........: CALL aglq510_b_fill4()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/31 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq510_b_fill4()
   DEFINE l_sql               STRING
   DEFINE l_sql1              STRING
   DEFINE l_wc                STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_glar001           LIKE glar_t.glar001
   DEFINE l_glar009           LIKE glar_t.glar009
   DEFINE l_glcc011           LIKE glcc_t.glcc011
   DEFINE l_seq               LIKE type_t.num5
   
   CALL g_glar4_d.clear()
   LET l_i=1
   
   #应收应付系统
   IF tm.chk_ar = 'Y' OR tm.chk_ap = 'Y' THEN
      #160728-00003#1--mod--str--
#      LET l_sql="SELECT sys,xrea005,xrea008,xrea009,xrea019,xrea100,SUM(xrea103),SUM(xrea113) ",
      LET l_sql="SELECT sys,xrea005,xrea008,xrea009,xrea019,xrea100,",
                "       SUM(CASE WHEN xrea004 LIKE '2%' OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' THEN xrea103*-1 ELSE xrea103 END),",   #161208-00011#1 add OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' lujh 
                "       SUM(CASE WHEN xrea004 LIKE '2%' OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' THEN xrea113*-1 ELSE xrea113 END) ",   #161208-00011#1 add OR xrea004 = '02' OR xrea004 = '04' OR xrea004 = '06' lujh 
      #160728-00003#1--mod--end
                "  FROM xrea_t,aglq510_tmp ",
                " WHERE xreaent=glarent AND xrea019=glar001 AND xrea100=glar009 ",
                "   AND xreaent=",g_enterprise," AND xreald='",tm.glaald,"'",
#                "   AND xrea001=",tm.glar002," AND xrea002<=",tm.glar003, #160728-00003#1 mark
                "   AND xrea001=",tm.glar002," AND xrea002 =",tm.glar003,  #160728-00003#1 add
                "   AND ",g_wc3,
                "   AND sys IN ('1','2')",
                "   AND diff IN ('2','3','4','6')",
                " GROUP BY sys,xrea005,xrea008,xrea009,xrea019,xrea100 ",
                " ORDER BY sys,xrea005,xrea008,xrea009,xrea019,xrea100 "
      PREPARE aglq510_b_fill4_xrea_pr FROM l_sql
      DECLARE aglq510_b_fill4_xrea_cs CURSOR FOR aglq510_b_fill4_xrea_pr
      FOREACH aglq510_b_fill4_xrea_cs INTO g_glar4_d[l_i].sys4,g_glar4_d[l_i].xrea005,g_glar4_d[l_i].xrea008,
                                           g_glar4_d[l_i].xrea009,g_glar4_d[l_i].xrea019,g_glar4_d[l_i].xrea100,
                                           g_glar4_d[l_i].xrea103,g_glar4_d[l_i].xrea113 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_b_fill4_xrea_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         IF cl_null(g_glar4_d[l_i].xrea103) THEN LET g_glar4_d[l_i].xrea103 = 0 END IF
         IF cl_null(g_glar4_d[l_i].xrea113) THEN LET g_glar4_d[l_i].xrea113 = 0 END IF
         #账款对象说明
         CALL s_desc_get_trading_partner_abbr_desc(g_glar4_d[l_i].xrea009) RETURNING g_glar4_d[l_i].xrea009_4_desc
         #科目说明
         CALL s_desc_get_account_desc(tm.glaald,g_glar4_d[l_i].xrea019) RETURNING g_glar4_d[l_i].xrea019_4_desc
         LET  l_i = l_i + 1
      END FOREACH
   END IF
   
   #检查固资系统
   IF tm.chk_fa='Y' THEN
      LET l_sql="SELECT faan004,acc,faan010,SUM(amt) ",
                "  FROM (",
                #               财产编号/资产科目    /币别    /本币余额
                "        (SELECT faan004,faaj023 acc,faan010,SUM(faan014) amt ",
                "           FROM faan_t,faaj_t,aglq510_tmp ",
                "          WHERE faanent=faajent AND faanld=faajld ",
                "            AND faan003=faaj037 AND faan004=faaj001 AND faan005=faaj002",
                "            AND faanent=glarent AND faaj023=glar001 AND faan010=glar009",
                "            AND faanent=",g_enterprise," AND faanld='",tm.glaald,"'",
                "            AND faan001=",tm.glar002," AND faan002<=",tm.glar003, 
                "            AND sys ='3'",
                "            AND diff IN ('2','3','4','6')",
                "          GROUP BY faan004,faaj023,faan010 )",
                "          UNION ",
                #                财产编号/累折科目    /币别   /本币余额
#                "        (SELECT faan004,faaj024 acc,faan010,SUM(faan018) amt ", #170210-00059#1 mark
                "        (SELECT faan004,faaj024 acc,faan010,SUM(CASE WHEN faaj023=faaj024 THEN faan018 *-1 ELSE faan018 END) amt ", #170210-00059#1 add
                "           FROM faan_t,faaj_t,aglq510_tmp ",
                "          WHERE faanent=faajent AND faanld=faajld ",
                "            AND faan003=faaj037 AND faan004=faaj001 AND faan005=faaj002",
                "            AND faanent=glarent AND faaj024=glar001 AND faan010=glar009",
                "            AND faanent=",g_enterprise," AND faanld='",tm.glaald,"'",
                "            AND faan001=",tm.glar002," AND faan002<=",tm.glar003, 
                "            AND sys ='3'",
                "            AND diff IN ('2','3','4','6')",
                "          GROUP BY faan004,faaj024,faan010 )",
                "       )",
                " GROUP BY faan004,acc,faan010 ",
                " ORDER BY faan004,acc,faan010 "
     
      PREPARE aglq510_b_fill4_faan_pr FROM l_sql
      DECLARE aglq510_b_fill4_faan_cs CURSOR FOR aglq510_b_fill4_faan_pr
      FOREACH aglq510_b_fill4_faan_cs INTO g_glar4_d[l_i].xrea005,g_glar4_d[l_i].xrea019,g_glar4_d[l_i].xrea100,
                                           g_glar4_d[l_i].xrea113 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_b_fill4_faan_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET g_glar4_d[l_i].sys4 = '3'
         IF cl_null(g_glar4_d[l_i].xrea113) THEN LET g_glar4_d[l_i].xrea113 = 0 END IF
         LET g_glar4_d[l_i].xrea103 = g_glar4_d[l_i].xrea113
         #科目说明
         CALL s_desc_get_account_desc(tm.glaald,g_glar4_d[l_i].xrea019) RETURNING g_glar4_d[l_i].xrea019_4_desc
         LET  l_i = l_i + 1
      END FOREACH
   END IF
   
   #检查资金系统
   IF tm.chk_nm='Y' THEN
      LET l_sql="SELECT nmbx003,acc,curr,SUM(amt1),SUM(amt2) ",
                "  FROM (",
                #                交易账户/科目       /币别         /原币余额                 /本币余额
                "        (SELECT nmbx003,glab005 acc,nmbx100 curr,SUM(nmbx103-nmbx104) amt1,SUM(nmbx113-nmbx114) amt2 ",
                "           FROM nmbx_t,glab_t,aglq510_tmp ",
                "          WHERE nmbxent=glabent AND nmbx003=glab003 ",
                "            AND glab001='40' AND glab002='40' AND glabld='",tm.glaald,"'",
                "            AND nmbxent=glarent AND glab005=glar001 AND nmbx100=glar009",
                "            AND nmbxent=",g_enterprise," AND nmbxcomp='",tm.glaacomp,"'",
                "            AND nmbx001=",tm.glar002," AND nmbx002<=",tm.glar003, 
                "            AND sys ='4'",
                "            AND diff IN ('2','3','4','6')",
                "          GROUP BY nmbx003,glab005,nmbx100 )",
                "       )",
                " GROUP BY nmbx003,acc,curr ",
                " ORDER BY nmbx003,acc,curr "
     
      PREPARE aglq510_b_fill4_nmbx_pr FROM l_sql
      DECLARE aglq510_b_fill4_nmbx_cs CURSOR FOR aglq510_b_fill4_nmbx_pr
      FOREACH aglq510_b_fill4_nmbx_cs INTO g_glar4_d[l_i].xrea005,g_glar4_d[l_i].xrea019,g_glar4_d[l_i].xrea100,
                                           g_glar4_d[l_i].xrea103,g_glar4_d[l_i].xrea113 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_b_fill4_nmbx_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET g_glar4_d[l_i].sys4 = '4'
         IF cl_null(g_glar4_d[l_i].xrea103) THEN LET g_glar4_d[l_i].xrea103 = 0 END IF
         IF cl_null(g_glar4_d[l_i].xrea113) THEN LET g_glar4_d[l_i].xrea113 = 0 END IF
         #科目说明
         CALL s_desc_get_account_desc(tm.glaald,g_glar4_d[l_i].xrea019) RETURNING g_glar4_d[l_i].xrea019_4_desc
         LET  l_i = l_i + 1
      END FOREACH
   END IF
   
   #检查成本系统
   IF tm.chk_xc='Y' THEN
      #抓取有差异的科目和币别
      LET l_sql="SELECT DISTINCT glar001,glar009,glcc011 ",
                "  FROM aglq510_tmp,glcc_t ",
                " WHERE glarent=glccent AND glar001=glcc002 ",
                "   AND glarent=",g_enterprise," AND glccld='",tm.glaald,"'",
                "   AND glcc001 IN ('1','3')",
                "   AND sys = '5' ",
                "   AND diff IN ('2','3','4','6')",
                " ORDER BY glar001,glar009,glcc011 "
      PREPARE aglq510_b_fill4_tmp_pr FROM l_sql
      DECLARE aglq510_b_fill4_tmp_cs CURSOR FOR aglq510_b_fill4_tmp_pr
      FOREACH aglq510_b_fill4_tmp_cs INTO l_glar001,l_glar009,l_glcc011
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq510_b_fill4_nmbx_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         #1)存货科目对应料件
         LET l_sql="SELECT 1 seq,xccc006 item,SUM(xccc902) amount ",
                   "  FROM xccc_t,xcbb_t ",
                   " WHERE xcccent=xcbbent AND xccc004=xcbb001 AND xccc005=xcbb002 AND xccc006=xcbb003 ",
                   "   AND xcccent=",g_enterprise," AND xcccld='",tm.glaald,"' ",
                   "   AND xccc001='1' AND xccc004=",tm.glar002," AND xccc005=",tm.glar003,
                   "   AND xcbbcomp='",tm.glaacomp,"' ",
                   "   AND xccc010='",l_glar009,"'"
         IF l_glcc011 <> '* ' THEN
            LET l_sql=l_sql," AND xcbb010='",l_glcc011,"'"
         ELSE
            LET l_sql=l_sql," AND (xcbb010 IS NULL OR ",
                            "      xcbb010 NOT IN (SELECT DISTINCT glcc011 FROM glcc_t ",
                            "                      WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
                            "                        AND glcc001='1' AND glcc011 <> '*' )",
                            "      )"
         END IF
         LET l_sql=l_sql," GROUP BY xccc006"
        
         #2)在制科目对应工单
         #成本分群条件
         IF l_glcc011 <> '* ' THEN
            LET l_wc=" xcbb010='",l_glcc011,"'"
         ELSE
            LET l_wc=" (xcbb010 IS NULL OR ",
                     "  xcbb010 NOT IN (SELECT DISTINCT glcc011 FROM glcc_t ",
                     "                  WHERE glccent=",g_enterprise," AND glccld='",tm.glaald,"'",
                     "                    AND glcc001='3' AND glcc011 <> '*' )",
                     " )"
         END IF
         LET l_sql1="SELECT 2 seq,xccd006 item,SUM(amt) amount ",
                    "  FROM (",
                    "         (SELECT xccd006,SUM(xccd902) amt",
                    "            FROM xccd_t,xcbb_t ",
                    "           WHERE xccdent=xcbbent AND xccd004=xcbb001 AND xccd005=xcbb002 AND xccd007=xcbb003 ",
                    "             AND xccdent=",g_enterprise," AND xccdld='",tm.glaald,"' ",
                    "             AND xccd001='1' AND xccd004=",tm.glar002," AND xccd005=",tm.glar003,
                    "             AND xcbbcomp='",tm.glaacomp,"' ",
                    "             AND xccd011='",l_glar009,"'",
                    "             AND ",l_wc,
                    "           GROUP BY xccd006 ",
                    "         )",
                    "         UNION ",
                    "         (SELECT xcch006 xccd006,SUM(xcch902) amt",
                    "            FROM xcch_t,xcbb_t ",
                    "           WHERE xcchent=xcbbent AND xcch004=xcbb001 AND xcch005=xcbb002 AND xcch007=xcbb003 ",
                    "             AND xcchent=",g_enterprise," AND xcchld='",tm.glaald,"' ",
                    "             AND xcch001='1' AND xcch004=",tm.glar002," AND xcch005=",tm.glar003,
                    "             AND xcbbcomp='",tm.glaacomp,"' ",
                    "             AND xcch011 = '",l_glar009,"'",
                    "             AND ",l_wc,
                    "           GROUP BY xcch006 ",
                    "         )",
                    "       ) ",
                    " GROUP BY xccd006 "
         LET l_sql="SELECT seq,item,amount ",
                   "  FROM ( (",l_sql,") UNION (",l_sql1,") )",
                   " ORDER BY seq,item"
         PREPARE aglq510_b_fill4_xccc_pr FROM l_sql
         DECLARE aglq510_b_fill4_xccc_cs CURSOR FOR aglq510_b_fill4_xccc_pr
         
         FOREACH aglq510_b_fill4_xccc_cs INTO l_seq,g_glar4_d[l_i].xrea005,g_glar4_d[l_i].xrea113 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq510_b_fill4_xccc_cs'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET g_glar4_d[l_i].sys4 = '5'
            IF cl_null(g_glar4_d[l_i].xrea113) THEN LET g_glar4_d[l_i].xrea113 = 0 END IF
            LET g_glar4_d[l_i].xrea103 = g_glar4_d[l_i].xrea113
            LET g_glar4_d[l_i].xrea019 = l_glar001
            LET g_glar4_d[l_i].xrea100 = l_glar009
            #科目说明
            CALL s_desc_get_account_desc(tm.glaald,g_glar4_d[l_i].xrea019) RETURNING g_glar4_d[l_i].xrea019_4_desc
            LET  l_i = l_i + 1
         END FOREACH
      END FOREACH
   END IF
   
   #检查投融资系统
   IF tm.chk_fm='Y' THEN
   END IF
   
   
   LET l_i = l_i - 1
   CALL g_glar4_d.deleteElement(g_glar4_d.getLength())
END FUNCTION

 
{</section>}
 
