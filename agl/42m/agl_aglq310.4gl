#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-02-25 14:48:34), PR版次:0005(2016-10-24 09:47:35)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: aglq310
#+ Description: 傳票明細清單查詢(日記帳)
#+ Creator....: 01251(2015-02-05 10:36:46)
#+ Modifier...: 01251 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq310.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151201-00002#15    2016/02/23   By 02599   增加凭证串查，双击单身串到aglt310
#160727-00019#3     2016/08/01   By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                              Mod   aglq310_print_tmp -->aglq310_tmp01
#160913-00017#3     2016/09/21   By 07900    AGL模组调整交易客商开窗
#161021-00037#1     2016/10/24   By 06821    組織類型與職能開窗調整
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
PRIVATE TYPE type_g_glaq_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glapdocno LIKE glap_t.glapdocno, 
   glaqseq LIKE glaq_t.glaqseq, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq002 LIKE glaq_t.glaq002, 
   glaq002_desc LIKE type_t.chr500, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq005_desc LIKE type_t.chr500, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq040 LIKE glaq_t.glaq040, 
   glaq041 LIKE glaq_t.glaq041, 
   glaq042 LIKE glaq_t.glaq042, 
   glaq043 LIKE glaq_t.glaq043, 
   glaq044 LIKE glaq_t.glaq044, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq017_desc LIKE type_t.chr500, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq018_desc LIKE type_t.chr500, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq019_desc LIKE type_t.chr500, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq020_desc LIKE type_t.chr500, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq021_desc LIKE type_t.chr500, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq022_desc LIKE type_t.chr500, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq023_desc LIKE type_t.chr500, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq024_desc LIKE type_t.chr500, 
   glbc004 LIKE type_t.chr500, 
   glbc004_desc LIKE type_t.chr500, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq052_desc LIKE type_t.chr500, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq053_desc LIKE type_t.chr500, 
   glaq025 LIKE glaq_t.glaq025, 
   glaq025_desc LIKE type_t.chr500, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq027_desc LIKE type_t.chr500, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq028_desc LIKE type_t.chr500, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq029_desc LIKE type_t.chr500, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq030_desc LIKE type_t.chr500, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq031_desc LIKE type_t.chr500, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq032_desc LIKE type_t.chr500, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq033_desc LIKE type_t.chr500, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq034_desc LIKE type_t.chr500, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq035_desc LIKE type_t.chr500, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq036_desc LIKE type_t.chr500, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq037_desc LIKE type_t.chr500, 
   glaq038 LIKE glaq_t.glaq038, 
   glaq038_desc LIKE type_t.chr500, 
   glapownid LIKE glap_t.glapownid, 
   glapownid_desc LIKE type_t.chr500, 
   glapcnfid LIKE glap_t.glapcnfid, 
   glapcnfid_desc LIKE type_t.chr500, 
   glappstid LIKE glap_t.glappstid, 
   glappstid_desc LIKE type_t.chr500, 
   glap013 LIKE glap_t.glap013, 
   glap009 LIKE glap_t.glap009 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa005       LIKE glaa_t.glaa005
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       sdate           LIKE glap_t.glapdocdt,  #起始日期
       syear           LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       edate           LIKE glap_t.glapdocdt,  #截止日期
       eyear           LIKE glap_t.glap002,    #截止年度
       eperiod         LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       stus            LIKE type_t.chr1
       END RECORD

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glaq_d
DEFINE g_master_t                   type_g_glaq_d
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t        type_g_glaq_d
 
      
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
 
{<section id="aglq310.main" >}
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
   DECLARE aglq310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq310_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq310_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq310 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq310_init()   
 
      #進入選單 Menu (="N")
      CALL aglq310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq310
      
   END IF 
   
   CLOSE aglq310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq310.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq310_init()
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
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('b_glaq051','6013')
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
   CALL aglq310_glaald_desc(g_glaald)
   CALL aglq310_set_default_value()   
   #end add-point
 
   CALL aglq310_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq310.default_search" >}
PRIVATE FUNCTION aglq310_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glaqseq = '", g_argv[01], "' AND "
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
 
{<section id="aglq310.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq310_ui_dialog()
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
      CALL aglq310_b_fill()
   ELSE
      CALL aglq310_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glaq_d.clear()
 
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
 
         CALL aglq310_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq310_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq310_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY 1 TO FORMONLY.h_index
               DISPLAY 1 TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_glaq_d.getLength() TO FORMONLY.cnt
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
            CALL aglq310_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel",TRUE)
            CALL gfrm_curr.setFieldHidden("b_glaq005", TRUE)
            CALL gfrm_curr.setFieldHidden("b_glapownid", TRUE)
            CALL gfrm_curr.setFieldHidden("b_glapcnfid", TRUE)
            CALL gfrm_curr.setFieldHidden("b_glappstid", TRUE)            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq310_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel",TRUE)
               CALL gfrm_curr.setFieldHidden("b_glaq005", TRUE)
               CALL gfrm_curr.setFieldHidden("b_glapownid", TRUE)
               CALL gfrm_curr.setFieldHidden("b_glapcnfid", TRUE)
               CALL gfrm_curr.setFieldHidden("b_glappstid", TRUE)                 
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
                  CALL g_glaq_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq310_glaald_desc(g_glaald)
               CALL aglq310_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
                LET g_wc2 = ' 1=1'
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq310_filter()
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
            CALL aglq310_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
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
            CALL aglq310_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq310_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq310_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq310_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               CALL aglq310_x01('1=1','aglq310_tmp01',tm.ctype,tm.stus)    #160727-00019#3  Mod  aglq310_print_tmp -->aglq310_tmp01 
                       
               #END add-point
               
               
            END IF
            
         #151201-00002#15--add--str--
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  IF NOT cl_null(g_glaq_d[g_detail_idx].glapdocno) THEN
                     CALL aglq310_cmdrun() #串查aglt310傳票資料    
                  END IF
               END IF
            END IF  
         #151201-00002#15--add--end
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
 
{<section id="aglq310.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq310_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_cnt            LIKE type_t.num5
   
   
   LET l_flag=TRUE
   
   
   
   
   CALL gfrm_curr.setFieldHidden("b_glaq005", FALSE)
   CALL gfrm_curr.setFieldHidden("b_glapownid", FALSE)
   CALL gfrm_curr.setFieldHidden("b_glapcnfid", FALSE)
   CALL gfrm_curr.setFieldHidden("b_glappstid", FALSE)  
   CALL gfrm_curr.setFieldHidden("b_glaq005_desc", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glapownid_desc", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glapcnfid_desc", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glappstid_desc", TRUE)     
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glaq_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glapdocdt,glap002,glap004,glapdocno,glaqseq,glaq001,glaq002,glaq005,glaq010, 
          glaq006,glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq017,glaq018,glaq019, 
          glaq020,glaq021,glaq022,glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,glaq029, 
          glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glapownid,glapcnfid, 
          glappstid,glap013,glap009
           FROM s_detail1[1].b_glapdocdt,s_detail1[1].b_glap002,s_detail1[1].b_glap004,s_detail1[1].b_glapdocno, 
               s_detail1[1].b_glaqseq,s_detail1[1].b_glaq001,s_detail1[1].b_glaq002,s_detail1[1].b_glaq005, 
               s_detail1[1].b_glaq010,s_detail1[1].b_glaq006,s_detail1[1].b_glaq003,s_detail1[1].b_glaq004, 
               s_detail1[1].b_glaq039,s_detail1[1].b_glaq040,s_detail1[1].b_glaq041,s_detail1[1].b_glaq042, 
               s_detail1[1].b_glaq043,s_detail1[1].b_glaq044,s_detail1[1].b_glaq017,s_detail1[1].b_glaq018, 
               s_detail1[1].b_glaq019,s_detail1[1].b_glaq020,s_detail1[1].b_glaq021,s_detail1[1].b_glaq022, 
               s_detail1[1].b_glaq023,s_detail1[1].b_glaq024,s_detail1[1].b_glaq051,s_detail1[1].b_glaq052, 
               s_detail1[1].b_glaq053,s_detail1[1].b_glaq025,s_detail1[1].b_glaq027,s_detail1[1].b_glaq028, 
               s_detail1[1].b_glaq029,s_detail1[1].b_glaq030,s_detail1[1].b_glaq031,s_detail1[1].b_glaq032, 
               s_detail1[1].b_glaq033,s_detail1[1].b_glaq034,s_detail1[1].b_glaq035,s_detail1[1].b_glaq036, 
               s_detail1[1].b_glaq037,s_detail1[1].b_glaq038,s_detail1[1].b_glapownid,s_detail1[1].b_glapcnfid, 
               s_detail1[1].b_glappstid,s_detail1[1].b_glap013,s_detail1[1].b_glap009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glapdocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapdocdt
            #add-point:BEFORE FIELD b_glapdocdt name="construct.b.page1.b_glapdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapdocdt
            
            #add-point:AFTER FIELD b_glapdocdt name="construct.a.page1.b_glapdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapdocdt
            #add-point:ON ACTION controlp INFIELD b_glapdocdt name="construct.c.page1.b_glapdocdt"
            
            #END add-point
 
 
         #----<<b_glap002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glap002
            #add-point:BEFORE FIELD b_glap002 name="construct.b.page1.b_glap002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glap002
            
            #add-point:AFTER FIELD b_glap002 name="construct.a.page1.b_glap002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap002
            #add-point:ON ACTION controlp INFIELD b_glap002 name="construct.c.page1.b_glap002"
            
            #END add-point
 
 
         #----<<b_glap004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glap004
            #add-point:BEFORE FIELD b_glap004 name="construct.b.page1.b_glap004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glap004
            
            #add-point:AFTER FIELD b_glap004 name="construct.a.page1.b_glap004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glap004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap004
            #add-point:ON ACTION controlp INFIELD b_glap004 name="construct.c.page1.b_glap004"
            
            #END add-point
 
 
         #----<<b_glapdocno>>----
         #Ctrlp:construct.c.page1.b_glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapdocno
            #add-point:ON ACTION controlp INFIELD b_glapdocno name="construct.c.page1.b_glapdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glapld = '",g_glaald,"'"
            CALL q_glapdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapdocno  #顯示到畫面上
            NEXT FIELD b_glapdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapdocno
            #add-point:BEFORE FIELD b_glapdocno name="construct.b.page1.b_glapdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapdocno
            
            #add-point:AFTER FIELD b_glapdocno name="construct.a.page1.b_glapdocno"
            
            #END add-point
            
 
 
         #----<<b_glaqseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaqseq
            #add-point:BEFORE FIELD b_glaqseq name="construct.b.page1.b_glaqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaqseq
            
            #add-point:AFTER FIELD b_glaqseq name="construct.a.page1.b_glaqseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaqseq
            #add-point:ON ACTION controlp INFIELD b_glaqseq name="construct.c.page1.b_glaqseq"
            
            #END add-point
 
 
         #----<<b_glaq001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq001
            #add-point:BEFORE FIELD b_glaq001 name="construct.b.page1.b_glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq001
            
            #add-point:AFTER FIELD b_glaq001 name="construct.a.page1.b_glaq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq001
            #add-point:ON ACTION controlp INFIELD b_glaq001 name="construct.c.page1.b_glaq001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq001  #顯示到畫面上
            NEXT FIELD b_glaq001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq002>>----
         #Ctrlp:construct.c.page1.b_glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq002
            #add-point:ON ACTION controlp INFIELD b_glaq002 name="construct.c.page1.b_glaq002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq002
            #add-point:BEFORE FIELD b_glaq002 name="construct.b.page1.b_glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq002
            
            #add-point:AFTER FIELD b_glaq002 name="construct.a.page1.b_glaq002"
            
            #END add-point
            
 
 
         #----<<b_glaq002_desc>>----
         #----<<b_glaq005>>----
         #Ctrlp:construct.c.page1.b_glaq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq005
            #add-point:ON ACTION controlp INFIELD b_glaq005 name="construct.c.page1.b_glaq005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq005  #顯示到畫面上
            NEXT FIELD b_glaq005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq005
            #add-point:BEFORE FIELD b_glaq005 name="construct.b.page1.b_glaq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq005
            
            #add-point:AFTER FIELD b_glaq005 name="construct.a.page1.b_glaq005"
            
            #END add-point
            
 
 
         #----<<b_glaq005_desc>>----
         #----<<b_glaq010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq010
            #add-point:BEFORE FIELD b_glaq010 name="construct.b.page1.b_glaq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq010
            
            #add-point:AFTER FIELD b_glaq010 name="construct.a.page1.b_glaq010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq010
            #add-point:ON ACTION controlp INFIELD b_glaq010 name="construct.c.page1.b_glaq010"
            
            #END add-point
 
 
         #----<<b_glaq006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq006
            #add-point:BEFORE FIELD b_glaq006 name="construct.b.page1.b_glaq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq006
            
            #add-point:AFTER FIELD b_glaq006 name="construct.a.page1.b_glaq006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq006
            #add-point:ON ACTION controlp INFIELD b_glaq006 name="construct.c.page1.b_glaq006"
            
            #END add-point
 
 
         #----<<b_glaq003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq003
            #add-point:BEFORE FIELD b_glaq003 name="construct.b.page1.b_glaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq003
            
            #add-point:AFTER FIELD b_glaq003 name="construct.a.page1.b_glaq003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq003
            #add-point:ON ACTION controlp INFIELD b_glaq003 name="construct.c.page1.b_glaq003"
            
            #END add-point
 
 
         #----<<b_glaq004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq004
            #add-point:BEFORE FIELD b_glaq004 name="construct.b.page1.b_glaq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq004
            
            #add-point:AFTER FIELD b_glaq004 name="construct.a.page1.b_glaq004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq004
            #add-point:ON ACTION controlp INFIELD b_glaq004 name="construct.c.page1.b_glaq004"
            
            #END add-point
 
 
         #----<<b_glaq039>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq039
            #add-point:BEFORE FIELD b_glaq039 name="construct.b.page1.b_glaq039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq039
            
            #add-point:AFTER FIELD b_glaq039 name="construct.a.page1.b_glaq039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq039
            #add-point:ON ACTION controlp INFIELD b_glaq039 name="construct.c.page1.b_glaq039"
            
            #END add-point
 
 
         #----<<b_glaq040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq040
            #add-point:BEFORE FIELD b_glaq040 name="construct.b.page1.b_glaq040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq040
            
            #add-point:AFTER FIELD b_glaq040 name="construct.a.page1.b_glaq040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq040
            #add-point:ON ACTION controlp INFIELD b_glaq040 name="construct.c.page1.b_glaq040"
            
            #END add-point
 
 
         #----<<b_glaq041>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq041
            #add-point:BEFORE FIELD b_glaq041 name="construct.b.page1.b_glaq041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq041
            
            #add-point:AFTER FIELD b_glaq041 name="construct.a.page1.b_glaq041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq041
            #add-point:ON ACTION controlp INFIELD b_glaq041 name="construct.c.page1.b_glaq041"
            
            #END add-point
 
 
         #----<<b_glaq042>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq042
            #add-point:BEFORE FIELD b_glaq042 name="construct.b.page1.b_glaq042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq042
            
            #add-point:AFTER FIELD b_glaq042 name="construct.a.page1.b_glaq042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq042
            #add-point:ON ACTION controlp INFIELD b_glaq042 name="construct.c.page1.b_glaq042"
            
            #END add-point
 
 
         #----<<b_glaq043>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq043
            #add-point:BEFORE FIELD b_glaq043 name="construct.b.page1.b_glaq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq043
            
            #add-point:AFTER FIELD b_glaq043 name="construct.a.page1.b_glaq043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq043
            #add-point:ON ACTION controlp INFIELD b_glaq043 name="construct.c.page1.b_glaq043"
            
            #END add-point
 
 
         #----<<b_glaq044>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq044
            #add-point:BEFORE FIELD b_glaq044 name="construct.b.page1.b_glaq044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq044
            
            #add-point:AFTER FIELD b_glaq044 name="construct.a.page1.b_glaq044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq044
            #add-point:ON ACTION controlp INFIELD b_glaq044 name="construct.c.page1.b_glaq044"
            
            #END add-point
 
 
         #----<<b_glaq017>>----
         #Ctrlp:construct.c.page1.b_glaq017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq017
            #add-point:ON ACTION controlp INFIELD b_glaq017 name="construct.c.page1.b_glaq017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#1 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq017  #顯示到畫面上
            NEXT FIELD b_glaq017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq017
            #add-point:BEFORE FIELD b_glaq017 name="construct.b.page1.b_glaq017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq017
            
            #add-point:AFTER FIELD b_glaq017 name="construct.a.page1.b_glaq017"
            
            #END add-point
            
 
 
         #----<<b_glaq017_desc>>----
         #----<<b_glaq018>>----
         #Ctrlp:construct.c.page1.b_glaq018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq018
            #add-point:ON ACTION controlp INFIELD b_glaq018 name="construct.c.page1.b_glaq018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq018  #顯示到畫面上
            NEXT FIELD b_glaq018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq018
            #add-point:BEFORE FIELD b_glaq018 name="construct.b.page1.b_glaq018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq018
            
            #add-point:AFTER FIELD b_glaq018 name="construct.a.page1.b_glaq018"
            
            #END add-point
            
 
 
         #----<<b_glaq018_desc>>----
         #----<<b_glaq019>>----
         #Ctrlp:construct.c.page1.b_glaq019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq019
            #add-point:ON ACTION controlp INFIELD b_glaq019 name="construct.c.page1.b_glaq019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq019  #顯示到畫面上
            NEXT FIELD b_glaq019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq019
            #add-point:BEFORE FIELD b_glaq019 name="construct.b.page1.b_glaq019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq019
            
            #add-point:AFTER FIELD b_glaq019 name="construct.a.page1.b_glaq019"
            
            #END add-point
            
 
 
         #----<<b_glaq019_desc>>----
         #----<<b_glaq020>>----
         #Ctrlp:construct.c.page1.b_glaq020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq020
            #add-point:ON ACTION controlp INFIELD b_glaq020 name="construct.c.page1.b_glaq020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq020  #顯示到畫面上
            NEXT FIELD b_glaq020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq020
            #add-point:BEFORE FIELD b_glaq020 name="construct.b.page1.b_glaq020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq020
            
            #add-point:AFTER FIELD b_glaq020 name="construct.a.page1.b_glaq020"
            
            #END add-point
            
 
 
         #----<<b_glaq020_desc>>----
         #----<<b_glaq021>>----
         #Ctrlp:construct.c.page1.b_glaq021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq021
            #add-point:ON ACTION controlp INFIELD b_glaq021 name="construct.c.page1.b_glaq021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
             CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq021  #顯示到畫面上
            NEXT FIELD b_glaq021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq021
            #add-point:BEFORE FIELD b_glaq021 name="construct.b.page1.b_glaq021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq021
            
            #add-point:AFTER FIELD b_glaq021 name="construct.a.page1.b_glaq021"
            
            #END add-point
            
 
 
         #----<<b_glaq021_desc>>----
         #----<<b_glaq022>>----
         #Ctrlp:construct.c.page1.b_glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq022
            #add-point:ON ACTION controlp INFIELD b_glaq022 name="construct.c.page1.b_glaq022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
             CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq022  #顯示到畫面上
            NEXT FIELD b_glaq022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq022
            #add-point:BEFORE FIELD b_glaq022 name="construct.b.page1.b_glaq022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq022
            
            #add-point:AFTER FIELD b_glaq022 name="construct.a.page1.b_glaq022"
            
            #END add-point
            
 
 
         #----<<b_glaq022_desc>>----
         #----<<b_glaq023>>----
         #Ctrlp:construct.c.page1.b_glaq023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq023
            #add-point:ON ACTION controlp INFIELD b_glaq023 name="construct.c.page1.b_glaq023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq023  #顯示到畫面上
            NEXT FIELD b_glaq023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq023
            #add-point:BEFORE FIELD b_glaq023 name="construct.b.page1.b_glaq023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq023
            
            #add-point:AFTER FIELD b_glaq023 name="construct.a.page1.b_glaq023"
            
            #END add-point
            
 
 
         #----<<b_glaq023_desc>>----
         #----<<b_glaq024>>----
         #Ctrlp:construct.c.page1.b_glaq024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq024
            #add-point:ON ACTION controlp INFIELD b_glaq024 name="construct.c.page1.b_glaq024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq024  #顯示到畫面上
            NEXT FIELD b_glaq024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq024
            #add-point:BEFORE FIELD b_glaq024 name="construct.b.page1.b_glaq024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq024
            
            #add-point:AFTER FIELD b_glaq024 name="construct.a.page1.b_glaq024"
            
            #END add-point
            
 
 
         #----<<b_glaq024_desc>>----
         #----<<b_glbc004>>----
         #----<<b_glbc004_desc>>----
         #----<<b_glaq051>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq051
            #add-point:BEFORE FIELD b_glaq051 name="construct.b.page1.b_glaq051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq051
            
            #add-point:AFTER FIELD b_glaq051 name="construct.a.page1.b_glaq051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glaq051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq051
            #add-point:ON ACTION controlp INFIELD b_glaq051 name="construct.c.page1.b_glaq051"
            
            #END add-point
 
 
         #----<<b_glaq052>>----
         #Ctrlp:construct.c.page1.b_glaq052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq052
            #add-point:ON ACTION controlp INFIELD b_glaq052 name="construct.c.page1.b_glaq052"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq052  #顯示到畫面上
            NEXT FIELD b_glaq052                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq052
            #add-point:BEFORE FIELD b_glaq052 name="construct.b.page1.b_glaq052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq052
            
            #add-point:AFTER FIELD b_glaq052 name="construct.a.page1.b_glaq052"
            
            #END add-point
            
 
 
         #----<<b_glaq052_desc>>----
         #----<<b_glaq053>>----
         #Ctrlp:construct.c.page1.b_glaq053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq053
            #add-point:ON ACTION controlp INFIELD b_glaq053 name="construct.c.page1.b_glaq053"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq053  #顯示到畫面上
            NEXT FIELD b_glaq053                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq053
            #add-point:BEFORE FIELD b_glaq053 name="construct.b.page1.b_glaq053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq053
            
            #add-point:AFTER FIELD b_glaq053 name="construct.a.page1.b_glaq053"
            
            #END add-point
            
 
 
         #----<<b_glaq053_desc>>----
         #----<<b_glaq025>>----
         #Ctrlp:construct.c.page1.b_glaq025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq025
            #add-point:ON ACTION controlp INFIELD b_glaq025 name="construct.c.page1.b_glaq025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq025  #顯示到畫面上
            NEXT FIELD b_glaq025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq025
            #add-point:BEFORE FIELD b_glaq025 name="construct.b.page1.b_glaq025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq025
            
            #add-point:AFTER FIELD b_glaq025 name="construct.a.page1.b_glaq025"
            
            #END add-point
            
 
 
         #----<<b_glaq025_desc>>----
         #----<<b_glaq027>>----
         #Ctrlp:construct.c.page1.b_glaq027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq027
            #add-point:ON ACTION controlp INFIELD b_glaq027 name="construct.c.page1.b_glaq027"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq027  #顯示到畫面上
            NEXT FIELD b_glaq027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq027
            #add-point:BEFORE FIELD b_glaq027 name="construct.b.page1.b_glaq027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq027
            
            #add-point:AFTER FIELD b_glaq027 name="construct.a.page1.b_glaq027"
            
            #END add-point
            
 
 
         #----<<b_glaq027_desc>>----
         #----<<b_glaq028>>----
         #Ctrlp:construct.c.page1.b_glaq028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq028
            #add-point:ON ACTION controlp INFIELD b_glaq028 name="construct.c.page1.b_glaq028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq028  #顯示到畫面上
            NEXT FIELD b_glaq028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq028
            #add-point:BEFORE FIELD b_glaq028 name="construct.b.page1.b_glaq028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq028
            
            #add-point:AFTER FIELD b_glaq028 name="construct.a.page1.b_glaq028"
            
            #END add-point
            
 
 
         #----<<b_glaq028_desc>>----
         #----<<b_glaq029>>----
         #Ctrlp:construct.c.page1.b_glaq029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq029
            #add-point:ON ACTION controlp INFIELD b_glaq029 name="construct.c.page1.b_glaq029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq029  #顯示到畫面上
            NEXT FIELD b_glaq029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq029
            #add-point:BEFORE FIELD b_glaq029 name="construct.b.page1.b_glaq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq029
            
            #add-point:AFTER FIELD b_glaq029 name="construct.a.page1.b_glaq029"
            
            #END add-point
            
 
 
         #----<<b_glaq029_desc>>----
         #----<<b_glaq030>>----
         #Ctrlp:construct.c.page1.b_glaq030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq030
            #add-point:ON ACTION controlp INFIELD b_glaq030 name="construct.c.page1.b_glaq030"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq030  #顯示到畫面上
            NEXT FIELD b_glaq030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq030
            #add-point:BEFORE FIELD b_glaq030 name="construct.b.page1.b_glaq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq030
            
            #add-point:AFTER FIELD b_glaq030 name="construct.a.page1.b_glaq030"
            
            #END add-point
            
 
 
         #----<<b_glaq030_desc>>----
         #----<<b_glaq031>>----
         #Ctrlp:construct.c.page1.b_glaq031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq031
            #add-point:ON ACTION controlp INFIELD b_glaq031 name="construct.c.page1.b_glaq031"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq031  #顯示到畫面上
            NEXT FIELD b_glaq031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq031
            #add-point:BEFORE FIELD b_glaq031 name="construct.b.page1.b_glaq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq031
            
            #add-point:AFTER FIELD b_glaq031 name="construct.a.page1.b_glaq031"
            
            #END add-point
            
 
 
         #----<<b_glaq031_desc>>----
         #----<<b_glaq032>>----
         #Ctrlp:construct.c.page1.b_glaq032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq032
            #add-point:ON ACTION controlp INFIELD b_glaq032 name="construct.c.page1.b_glaq032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq032  #顯示到畫面上
            NEXT FIELD b_glaq032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq032
            #add-point:BEFORE FIELD b_glaq032 name="construct.b.page1.b_glaq032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq032
            
            #add-point:AFTER FIELD b_glaq032 name="construct.a.page1.b_glaq032"
            
            #END add-point
            
 
 
         #----<<b_glaq032_desc>>----
         #----<<b_glaq033>>----
         #Ctrlp:construct.c.page1.b_glaq033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq033
            #add-point:ON ACTION controlp INFIELD b_glaq033 name="construct.c.page1.b_glaq033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq033  #顯示到畫面上
            NEXT FIELD b_glaq033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq033
            #add-point:BEFORE FIELD b_glaq033 name="construct.b.page1.b_glaq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq033
            
            #add-point:AFTER FIELD b_glaq033 name="construct.a.page1.b_glaq033"
            
            #END add-point
            
 
 
         #----<<b_glaq033_desc>>----
         #----<<b_glaq034>>----
         #Ctrlp:construct.c.page1.b_glaq034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq034
            #add-point:ON ACTION controlp INFIELD b_glaq034 name="construct.c.page1.b_glaq034"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq034  #顯示到畫面上
            NEXT FIELD b_glaq034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq034
            #add-point:BEFORE FIELD b_glaq034 name="construct.b.page1.b_glaq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq034
            
            #add-point:AFTER FIELD b_glaq034 name="construct.a.page1.b_glaq034"
            
            #END add-point
            
 
 
         #----<<b_glaq034_desc>>----
         #----<<b_glaq035>>----
         #Ctrlp:construct.c.page1.b_glaq035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq035
            #add-point:ON ACTION controlp INFIELD b_glaq035 name="construct.c.page1.b_glaq035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq035  #顯示到畫面上
            NEXT FIELD b_glaq035                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq035
            #add-point:BEFORE FIELD b_glaq035 name="construct.b.page1.b_glaq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq035
            
            #add-point:AFTER FIELD b_glaq035 name="construct.a.page1.b_glaq035"
            
            #END add-point
            
 
 
         #----<<b_glaq035_desc>>----
         #----<<b_glaq036>>----
         #Ctrlp:construct.c.page1.b_glaq036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq036
            #add-point:ON ACTION controlp INFIELD b_glaq036 name="construct.c.page1.b_glaq036"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq036  #顯示到畫面上
            NEXT FIELD b_glaq036                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq036
            #add-point:BEFORE FIELD b_glaq036 name="construct.b.page1.b_glaq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq036
            
            #add-point:AFTER FIELD b_glaq036 name="construct.a.page1.b_glaq036"
            
            #END add-point
            
 
 
         #----<<b_glaq036_desc>>----
         #----<<b_glaq037>>----
         #Ctrlp:construct.c.page1.b_glaq037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq037
            #add-point:ON ACTION controlp INFIELD b_glaq037 name="construct.c.page1.b_glaq037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq037  #顯示到畫面上
            NEXT FIELD b_glaq037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq037
            #add-point:BEFORE FIELD b_glaq037 name="construct.b.page1.b_glaq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq037
            
            #add-point:AFTER FIELD b_glaq037 name="construct.a.page1.b_glaq037"
            
            #END add-point
            
 
 
         #----<<b_glaq037_desc>>----
         #----<<b_glaq038>>----
         #Ctrlp:construct.c.page1.b_glaq038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq038
            #add-point:ON ACTION controlp INFIELD b_glaq038 name="construct.c.page1.b_glaq038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq038  #顯示到畫面上
            NEXT FIELD b_glaq038                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glaq038
            #add-point:BEFORE FIELD b_glaq038 name="construct.b.page1.b_glaq038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glaq038
            
            #add-point:AFTER FIELD b_glaq038 name="construct.a.page1.b_glaq038"
            
            #END add-point
            
 
 
         #----<<b_glaq038_desc>>----
         #----<<b_glapownid>>----
         #Ctrlp:construct.c.page1.b_glapownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapownid
            #add-point:ON ACTION controlp INFIELD b_glapownid name="construct.c.page1.b_glapownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapownid  #顯示到畫面上
            NEXT FIELD b_glapownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapownid
            #add-point:BEFORE FIELD b_glapownid name="construct.b.page1.b_glapownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapownid
            
            #add-point:AFTER FIELD b_glapownid name="construct.a.page1.b_glapownid"
            
            #END add-point
            
 
 
         #----<<b_glapownid_desc>>----
         #----<<b_glapcnfid>>----
         #Ctrlp:construct.c.page1.b_glapcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapcnfid
            #add-point:ON ACTION controlp INFIELD b_glapcnfid name="construct.c.page1.b_glapcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapcnfid  #顯示到畫面上
            NEXT FIELD b_glapcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glapcnfid
            #add-point:BEFORE FIELD b_glapcnfid name="construct.b.page1.b_glapcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glapcnfid
            
            #add-point:AFTER FIELD b_glapcnfid name="construct.a.page1.b_glapcnfid"
            
            #END add-point
            
 
 
         #----<<b_glapcnfid_desc>>----
         #----<<b_glappstid>>----
         #Ctrlp:construct.c.page1.b_glappstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glappstid
            #add-point:ON ACTION controlp INFIELD b_glappstid name="construct.c.page1.b_glappstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glappstid  #顯示到畫面上
            NEXT FIELD b_glappstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glappstid
            #add-point:BEFORE FIELD b_glappstid name="construct.b.page1.b_glappstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glappstid
            
            #add-point:AFTER FIELD b_glappstid name="construct.a.page1.b_glappstid"
            
            #END add-point
            
 
 
         #----<<b_glappstid_desc>>----
         #----<<b_glap013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glap013
            #add-point:BEFORE FIELD b_glap013 name="construct.b.page1.b_glap013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glap013
            
            #add-point:AFTER FIELD b_glap013 name="construct.a.page1.b_glap013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glap013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap013
            #add-point:ON ACTION controlp INFIELD b_glap013 name="construct.c.page1.b_glap013"
            
            #END add-point
 
 
         #----<<b_glap009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glap009
            #add-point:BEFORE FIELD b_glap009 name="construct.b.page1.b_glap009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glap009
            
            #add-point:AFTER FIELD b_glap009 name="construct.a.page1.b_glap009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glap009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap009
            #add-point:ON ACTION controlp INFIELD b_glap009 name="construct.c.page1.b_glap009"


         #現金變動碼
         ON ACTION controlp INFIELD b_glbc004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where="nmai001='",g_glaa005,"'"
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glbc004  #顯示到畫面上
            NEXT FIELD b_glbc004                     #返回原欄位

            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME tm.sdate,tm.edate,tm.ctype,tm.stus
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD sdate
            IF NOT cl_null(tm.sdate) THEN
               CALL s_get_accdate(g_glaa003,tm.sdate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD sdate
               END IF
               IF NOT cl_null(tm.edate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD sdate
                  END IF
               END IF
               LET tm.syear=l_glav002
               LET tm.speriod=l_glav006
               DISPLAY tm.syear,tm.speriod TO syear,speriod 
            END IF
            
         AFTER FIELD edate
            IF NOT cl_null(tm.edate) THEN
               CALL s_get_accdate(g_glaa003,tm.edate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD edate
               END IF
               IF NOT cl_null(tm.sdate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD edate
                  END IF
               END IF
               LET tm.eyear=l_glav002
               LET tm.eperiod=l_glav006
               DISPLAY tm.eyear,tm.eperiod TO eyear,eperiod 
            END IF
         
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq310_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
                   
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
            
         
      END INPUT
      
      BEFORE DIALOG
        #預設
        CALL aglq310_show()
        CALL gfrm_curr.setFieldHidden("glaq005", FALSE)
        CALL gfrm_curr.setFieldHidden("glapownid", FALSE)
        CALL gfrm_curr.setFieldHidden("glapcnfid", FALSE)
        CALL gfrm_curr.setFieldHidden("glappstid", FALSE)
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
   CALL gfrm_curr.setFieldHidden("formonly.sel",TRUE)
   CALL gfrm_curr.setFieldHidden("b_glaq005", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glapownid", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glapcnfid", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glappstid", TRUE)
   CALL gfrm_curr.setFieldHidden("b_glaq005_desc", FALSE)
   CALL gfrm_curr.setFieldHidden("b_glapownid_desc", FALSE)
   CALL gfrm_curr.setFieldHidden("b_glapcnfid_desc", FALSE)
   CALL gfrm_curr.setFieldHidden("b_glappstid_desc", FALSE)   
   #end add-point
        
   LET g_error_show = 1
   CALL aglq310_b_fill()
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
 
{<section id="aglq310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq310_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
DEFINE l_glad0171        LIKE glad_t.glad0171
DEFINE l_glad0181        LIKE glad_t.glad0181
DEFINE l_glad0191        LIKE glad_t.glad0191
DEFINE l_glad0201        LIKE glad_t.glad0201
DEFINE l_glad0211        LIKE glad_t.glad0211
DEFINE l_glad0221        LIKE glad_t.glad0221
DEFINE l_glad0231        LIKE glad_t.glad0231
DEFINE l_glad0241        LIKE glad_t.glad0241
DEFINE l_glad0251        LIKE glad_t.glad0251
DEFINE l_glad0261        LIKE glad_t.glad0261

   DEFINE l_glaald_desc LIKE type_t.chr500,
          l_glaacomp_desc LIKE type_t.chr500,
          l_curr_desc LIKE type_t.chr500,
          l_sdate LIKE type_t.chr50,      #起始日期
          l_edate LIKE type_t.chr50,      #截止日期
          l_ctype LIKE type_t.chr20,       #多本位幣
          l_stus_desc LIKE type_t.chr20
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq310_create_tmp()
   DELETE FROM aglq310_tmp01              #160727-00019#3  Mod  aglq310_print_tmp -->aglq310_tmp01 
   LET l_glaald_desc = g_glaald,"    ",g_glaald_desc
   LET l_glaacomp_desc = g_glaacomp,"     ",g_glaacomp_desc
   LET l_curr_desc = g_glaa001,"     ",g_glaa016,"     ",g_glaa020
   LET l_sdate = tm.sdate,"     ",tm.syear,"    ",tm.speriod
   LET l_edate =tm.edate,"     ",tm.eyear,"     ",tm.eperiod
   LET l_ctype = tm.ctype,":",s_desc_gzcbl004_desc('9921',tm.ctype)
   LET l_stus_desc = tm.stus,":",s_desc_gzcbl004_desc('9922',tm.stus)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','',glaqseq,glaq001,glaq002,'',glaq005,'',glaq010,glaq006, 
       glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq017,'',glaq018,'',glaq019, 
       '',glaq020,'',glaq021,'',glaq022,'',glaq023,'',glaq024,'','','',glaq051,glaq052,'',glaq053,'', 
       glaq025,'',glaq027,'',glaq028,'',glaq029,'',glaq030,'',glaq031,'',glaq032,'',glaq033,'',glaq034, 
       '',glaq035,'',glaq036,'',glaq037,'',glaq038,'','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glaq_t.glaqseq) AS RANK FROM glaq_t", 
 
 
 
                     "",
                     " WHERE glaqent=? AND glaqld=? AND glaqdocno=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glaq_t"),
                     " ORDER BY glaq_t.glaqseq"
 
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
 
   LET g_sql = "SELECT '','','','','',glaqseq,glaq001,glaq002,'',glaq005,'',glaq010,glaq006,glaq003, 
       glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq017,'',glaq018,'',glaq019,'',glaq020, 
       '',glaq021,'',glaq022,'',glaq023,'',glaq024,'','','',glaq051,glaq052,'',glaq053,'',glaq025,'', 
       glaq027,'',glaq028,'',glaq029,'',glaq030,'',glaq031,'',glaq032,'',glaq033,'',glaq034,'',glaq035, 
       '',glaq036,'',glaq037,'',glaq038,'','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE 'N',glapdocdt,glap002,glap004,glapdocno,glaqseq,glaq001,glaq002,'',glaq005,'',glaq010,glaq006, 
       glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq017,'',glaq018,'',glaq019, 
       '',glaq020,'',glaq021,'',glaq022,'',glaq023,'',glaq024,'','','',glaq051,glaq052,'',glaq053,'', 
       glaq025,'',glaq027,'',glaq028,'',glaq029,'',glaq030,'',glaq031,'',glaq032,'',glaq033,'',glaq034, 
       '',glaq035,'',glaq036,'',glaq037,'',glaq038,'',glapownid,'',glapcnfid,'',glappstid,'',glap013,glap009",       
               "  FROM glaq_t,glap_t",
               " WHERE glaqent=glapent",
               "   AND glaqld=glapld",
               "   AND glaqdocno=glapdocno",
               "   AND glaqent=? ",
               "   AND glaqld='",g_glaald,"'",
               "   AND ", ls_wc,
               "   AND glapdocdt>='",tm.sdate,"'",
               "   AND glapdocdt<='",tm.edate,"'"
   CASE
      WHEN tm.stus='1'
         LET g_sql=g_sql," AND glapstus='S' "
      WHEN tm.stus='2'
         LET g_sql=g_sql," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET g_sql=g_sql," AND glapstus IN ('S','Y','N') "
   END CASE
   
   LET g_sql = g_sql," ORDER BY glapdocdt,glapdocno,glaqseq"                     
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq310_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq310_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glaq_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glaq_d[l_ac].sel,g_glaq_d[l_ac].glapdocdt,g_glaq_d[l_ac].glap002,g_glaq_d[l_ac].glap004, 
       g_glaq_d[l_ac].glapdocno,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002, 
       g_glaq_d[l_ac].glaq002_desc,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq005_desc,g_glaq_d[l_ac].glaq010, 
       g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040, 
       g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glaq017, 
       g_glaq_d[l_ac].glaq017_desc,g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq018_desc,g_glaq_d[l_ac].glaq019, 
       g_glaq_d[l_ac].glaq019_desc,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq020_desc,g_glaq_d[l_ac].glaq021, 
       g_glaq_d[l_ac].glaq021_desc,g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq022_desc,g_glaq_d[l_ac].glaq023, 
       g_glaq_d[l_ac].glaq023_desc,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq024_desc,g_glaq_d[l_ac].glbc004, 
       g_glaq_d[l_ac].glbc004_desc,g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052,g_glaq_d[l_ac].glaq052_desc, 
       g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq053_desc,g_glaq_d[l_ac].glaq025,g_glaq_d[l_ac].glaq025_desc, 
       g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq027_desc,g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq028_desc, 
       g_glaq_d[l_ac].glaq029,g_glaq_d[l_ac].glaq029_desc,g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq030_desc, 
       g_glaq_d[l_ac].glaq031,g_glaq_d[l_ac].glaq031_desc,g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq032_desc, 
       g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq033_desc,g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq034_desc, 
       g_glaq_d[l_ac].glaq035,g_glaq_d[l_ac].glaq035_desc,g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq036_desc, 
       g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq037_desc,g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq038_desc, 
       g_glaq_d[l_ac].glapownid,g_glaq_d[l_ac].glapownid_desc,g_glaq_d[l_ac].glapcnfid,g_glaq_d[l_ac].glapcnfid_desc, 
       g_glaq_d[l_ac].glappstid,g_glaq_d[l_ac].glappstid_desc,g_glaq_d[l_ac].glap013,g_glaq_d[l_ac].glap009 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glaq_d[l_ac].statepic = cl_get_actipic(g_glaq_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #科目名稱
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_d[l_ac].glaq002
      CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq002_desc = g_rtn_fields[1]
      #幣別說明
      LET g_glaq_d[l_ac].glaq005_desc=''
      SELECT ooail003 INTO g_glaq_d[l_ac].glaq005_desc
        FROM ooail_t
       WHERE ooailent=g_enterprise
         AND ooail001=g_glaq_d[l_ac].glaq005
         AND ooail002=g_dlang
      #制單者
      LET g_glaq_d[l_ac].glapownid_desc=''
      SELECT ooag011 INTO g_glaq_d[l_ac].glapownid_desc
        FROM ooag_t
       WHERE ooag001=g_glaq_d[l_ac].glapownid
         AND ooagent=g_enterprise
      #審核
      LET g_glaq_d[l_ac].glapcnfid_desc=''
      SELECT ooag011 INTO g_glaq_d[l_ac].glapcnfid_desc
        FROM ooag_t
       WHERE ooag001=g_glaq_d[l_ac].glapcnfid
         AND ooagent=g_enterprise
      #過帳
      LET g_glaq_d[l_ac].glappstid_desc=''
      SELECT ooag011 INTO g_glaq_d[l_ac].glappstid_desc
        FROM ooag_t
       WHERE ooag001=g_glaq_d[l_ac].glappstid
         AND ooagent=g_enterprise
   
      #核算項抓取說明   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glaq_d[l_ac].glaq017
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq017_desc=g_rtn_fields[1]
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glaq_d[l_ac].glaq018
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq018_desc=g_rtn_fields[1]
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glaq_d[l_ac].glaq019
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq019_desc=g_rtn_fields[1]  
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '287'
      LET g_ref_fields[2] = g_glaq_d[l_ac].glaq020
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq020_desc=g_rtn_fields[1] 
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_d[l_ac].glaq021
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq021_desc=g_rtn_fields[1]     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_d[l_ac].glaq022
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq022_desc=g_rtn_fields[1]        
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '281'
      LET g_ref_fields[2] = g_glaq_d[l_ac].glaq023
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq023_desc=g_rtn_fields[1] 
      INITIALIZE g_ref_fields TO NULL
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_d[l_ac].glaq024
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq024_desc=g_rtn_fields[1] 
      
      SELECT ooag011 INTO g_glaq_d[l_ac].glaq025_desc 
        FROM ooag_t
       WHERE ooagent = g_enterprise 
         AND ooag001 = g_glaq_d[l_ac].glaq025  
       
      CALL s_desc_get_project_desc(g_glaq_d[l_ac].glaq027) RETURNING g_glaq_d[l_ac].glaq027_desc  
      CALL s_desc_get_wbs_desc(g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq028) RETURNING g_glaq_d[l_ac].glaq028_desc
      
      #現金變動碼
      SELECT glbc004 INTO g_glaq_d[l_ac].glbc004 
        FROM glbc_t
       WHERE glbcent = g_enterprise 
         AND glbcld = g_glaald
         AND glbcdocno = g_glaq_d[l_ac].glapdocno
         AND glbcseq = g_glaq_d[l_ac].glaqseq
         AND glbc001 = g_glaq_d[l_ac].glap002 
         AND glbc002 = g_glaq_d[l_ac].glap004
      IF NOT cl_null(g_glaq_d[l_ac].glbc004) THEN
         CALL s_desc_get_nmail004_desc(g_glaa005,g_glaq_d[l_ac].glbc004)  RETURNING g_glaq_d[l_ac].glbc004_desc
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_d[l_ac].glaq052
      CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq052_desc=g_rtn_fields[1] 
      LET g_ref_fields[1] = '2002'
      LET g_ref_fields[2] = g_glaq_d[l_ac].glaq053
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_d[l_ac].glaq053_desc=g_rtn_fields[1] 


      LET l_glad0171=''
      LET l_glad0181=''
      LET l_glad0191=''
      LET l_glad0201=''
      LET l_glad0211=''
      LET l_glad0221=''
      LET l_glad0231=''
      LET l_glad0241=''
      LET l_glad0251=''
      LET l_glad0261=''
      SELECT glad0171,glad0181,glad0191,glad0201,glad0211,
             glad0221,glad0231,glad0241,glad0251,glad0261
        INTO l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,
             l_glad0221,l_glad0231,l_glad0241,l_glad0251,l_glad0261
        FROM glad_t
       WHERE gladent=g_enterprise 
         AND gladld=g_glaald 
         AND glad001=g_glaq_d[l_ac].glaq002
      #自由核算項說明
      CALL s_voucher_free_account_desc(l_glad0171,g_glaq_d[l_ac].glaq029) RETURNING g_glaq_d[l_ac].glaq029_desc   
      CALL s_voucher_free_account_desc(l_glad0181,g_glaq_d[l_ac].glaq030) RETURNING g_glaq_d[l_ac].glaq030_desc   
      CALL s_voucher_free_account_desc(l_glad0191,g_glaq_d[l_ac].glaq031) RETURNING g_glaq_d[l_ac].glaq031_desc
      CALL s_voucher_free_account_desc(l_glad0201,g_glaq_d[l_ac].glaq032) RETURNING g_glaq_d[l_ac].glaq032_desc
      CALL s_voucher_free_account_desc(l_glad0211,g_glaq_d[l_ac].glaq033) RETURNING g_glaq_d[l_ac].glaq033_desc
      CALL s_voucher_free_account_desc(l_glad0221,g_glaq_d[l_ac].glaq034) RETURNING g_glaq_d[l_ac].glaq034_desc
      CALL s_voucher_free_account_desc(l_glad0231,g_glaq_d[l_ac].glaq035) RETURNING g_glaq_d[l_ac].glaq035_desc
      CALL s_voucher_free_account_desc(l_glad0241,g_glaq_d[l_ac].glaq036) RETURNING g_glaq_d[l_ac].glaq036_desc
      CALL s_voucher_free_account_desc(l_glad0251,g_glaq_d[l_ac].glaq037) RETURNING g_glaq_d[l_ac].glaq037_desc
      CALL s_voucher_free_account_desc(l_glad0261,g_glaq_d[l_ac].glaq038) RETURNING g_glaq_d[l_ac].glaq038_desc
      
      
      #yangtt---XG--
      INSERT INTO aglq310_tmp01 VALUES(l_glaald_desc,l_glaacomp_desc,l_curr_desc,l_sdate,l_edate,l_ctype,l_stus_desc,    #160727-00019#3  Mod  aglq310_print_tmp -->aglq310_tmp01 
       g_glaq_d[l_ac].glapdocdt,g_glaq_d[l_ac].glap002,g_glaq_d[l_ac].glap004, 
       g_glaq_d[l_ac].glapdocno,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002, 
       g_glaq_d[l_ac].glaq002_desc,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq005_desc,g_glaq_d[l_ac].glaq010, 
       g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040, 
       g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glaq017, 
       g_glaq_d[l_ac].glaq017_desc,g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq018_desc,g_glaq_d[l_ac].glaq019, 
       g_glaq_d[l_ac].glaq019_desc,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq020_desc,g_glaq_d[l_ac].glaq021, 
       g_glaq_d[l_ac].glaq021_desc,g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq022_desc,g_glaq_d[l_ac].glaq023, 
       g_glaq_d[l_ac].glaq023_desc,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq024_desc,g_glaq_d[l_ac].glbc004, 
       g_glaq_d[l_ac].glbc004_desc,g_glaq_d[l_ac].glaq051,g_glaq_d[l_ac].glaq052,g_glaq_d[l_ac].glaq052_desc, 
       g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq053_desc,g_glaq_d[l_ac].glaq025,g_glaq_d[l_ac].glaq025_desc, 
       g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq027_desc,g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq028_desc, 
       g_glaq_d[l_ac].glaq029,g_glaq_d[l_ac].glaq029_desc,g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq030_desc, 
       g_glaq_d[l_ac].glaq031,g_glaq_d[l_ac].glaq031_desc,g_glaq_d[l_ac].glaq032,g_glaq_d[l_ac].glaq032_desc, 
       g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq033_desc,g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq034_desc, 
       g_glaq_d[l_ac].glaq035,g_glaq_d[l_ac].glaq035_desc,g_glaq_d[l_ac].glaq036,g_glaq_d[l_ac].glaq036_desc, 
       g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq037_desc,g_glaq_d[l_ac].glaq038,g_glaq_d[l_ac].glaq038_desc, 
       g_glaq_d[l_ac].glapownid_desc,g_glaq_d[l_ac].glapcnfid_desc, 
       g_glaq_d[l_ac].glappstid_desc,g_glaq_d[l_ac].glap013,g_glaq_d[l_ac].glap009)
      #yangtt---XG--
   
      #end add-point
 
      CALL aglq310_detail_show("'1'")      
 
      CALL aglq310_glaq_t_mask()
 
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
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF g_glaq_d.getLength()>=1 THEN
      LET g_sql = "SELECT  SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044),SUM(glap013)",
                  "  FROM glaq_t,glap_t",
                  " WHERE glaqent=glapent",
                  "   AND glaqld=glapld",
                  "   AND glaqdocno=glapdocno",
                  "   AND glaqent='",g_enterprise,"'",
                  "   AND glaqld='",g_glaald,"'",
                  "   AND ", ls_wc,
                  "   AND glapdocdt>='",tm.sdate,"'",
                  "   AND glapdocdt<='",tm.edate,"'"
      CASE
         WHEN tm.stus='1'
            LET g_sql=g_sql," AND glapstus='S' "
         WHEN tm.stus='2'
            LET g_sql=g_sql," AND glapstus IN ('S','Y') "
         WHEN tm.stus='3'
            LET g_sql=g_sql," AND glapstus IN ('S','Y','N') "
      END CASE
                         
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE aglq310_pb_sum FROM g_sql
      
      EXECUTE aglq310_pb_sum INTO g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,
                                  g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].glap013
      #合計說明                            
      LET g_glaq_d[l_ac].glaq001 = cl_getmsg('axc-00383',g_lang)
   END IF
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glaq_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq310_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq310_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq310_detail_action_trans()
 
   IF g_glaq_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq310_fetch()
   END IF
   
      CALL aglq310_filter_show('glapdocdt','b_glapdocdt')
   CALL aglq310_filter_show('glap002','b_glap002')
   CALL aglq310_filter_show('glap004','b_glap004')
   CALL aglq310_filter_show('glapdocno','b_glapdocno')
   CALL aglq310_filter_show('glaqseq','b_glaqseq')
   CALL aglq310_filter_show('glaq001','b_glaq001')
   CALL aglq310_filter_show('glaq002','b_glaq002')
   CALL aglq310_filter_show('glaq005','b_glaq005')
   CALL aglq310_filter_show('glaq010','b_glaq010')
   CALL aglq310_filter_show('glaq006','b_glaq006')
   CALL aglq310_filter_show('glaq003','b_glaq003')
   CALL aglq310_filter_show('glaq004','b_glaq004')
   CALL aglq310_filter_show('glaq039','b_glaq039')
   CALL aglq310_filter_show('glaq040','b_glaq040')
   CALL aglq310_filter_show('glaq041','b_glaq041')
   CALL aglq310_filter_show('glaq042','b_glaq042')
   CALL aglq310_filter_show('glaq043','b_glaq043')
   CALL aglq310_filter_show('glaq044','b_glaq044')
   CALL aglq310_filter_show('glaq017','b_glaq017')
   CALL aglq310_filter_show('glaq018','b_glaq018')
   CALL aglq310_filter_show('glaq019','b_glaq019')
   CALL aglq310_filter_show('glaq020','b_glaq020')
   CALL aglq310_filter_show('glaq021','b_glaq021')
   CALL aglq310_filter_show('glaq022','b_glaq022')
   CALL aglq310_filter_show('glaq023','b_glaq023')
   CALL aglq310_filter_show('glaq024','b_glaq024')
   CALL aglq310_filter_show('glaq051','b_glaq051')
   CALL aglq310_filter_show('glaq052','b_glaq052')
   CALL aglq310_filter_show('glaq053','b_glaq053')
   CALL aglq310_filter_show('glaq025','b_glaq025')
   CALL aglq310_filter_show('glaq027','b_glaq027')
   CALL aglq310_filter_show('glaq028','b_glaq028')
   CALL aglq310_filter_show('glaq029','b_glaq029')
   CALL aglq310_filter_show('glaq030','b_glaq030')
   CALL aglq310_filter_show('glaq031','b_glaq031')
   CALL aglq310_filter_show('glaq032','b_glaq032')
   CALL aglq310_filter_show('glaq033','b_glaq033')
   CALL aglq310_filter_show('glaq034','b_glaq034')
   CALL aglq310_filter_show('glaq035','b_glaq035')
   CALL aglq310_filter_show('glaq036','b_glaq036')
   CALL aglq310_filter_show('glaq037','b_glaq037')
   CALL aglq310_filter_show('glaq038','b_glaq038')
   CALL aglq310_filter_show('glapownid','b_glapownid')
   CALL aglq310_filter_show('glapcnfid','b_glapcnfid')
   CALL aglq310_filter_show('glappstid','b_glappstid')
   CALL aglq310_filter_show('glap013','b_glap013')
   CALL aglq310_filter_show('glap009','b_glap009')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq310.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq310_fetch()
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
 
{<section id="aglq310.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq310_detail_show(ps_page)
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
 
{<section id="aglq310.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq310_filter()
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
      CONSTRUCT g_wc_filter ON glapdocdt,glap002,glap004,glapdocno,glaqseq,glaq001,glaq002,glaq005,glaq010, 
          glaq006,glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,glaq017,glaq018,glaq019, 
          glaq020,glaq021,glaq022,glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,glaq029, 
          glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,glapownid,glapcnfid, 
          glappstid,glap013,glap009
                          FROM s_detail1[1].b_glapdocdt,s_detail1[1].b_glap002,s_detail1[1].b_glap004, 
                              s_detail1[1].b_glapdocno,s_detail1[1].b_glaqseq,s_detail1[1].b_glaq001, 
                              s_detail1[1].b_glaq002,s_detail1[1].b_glaq005,s_detail1[1].b_glaq010,s_detail1[1].b_glaq006, 
                              s_detail1[1].b_glaq003,s_detail1[1].b_glaq004,s_detail1[1].b_glaq039,s_detail1[1].b_glaq040, 
                              s_detail1[1].b_glaq041,s_detail1[1].b_glaq042,s_detail1[1].b_glaq043,s_detail1[1].b_glaq044, 
                              s_detail1[1].b_glaq017,s_detail1[1].b_glaq018,s_detail1[1].b_glaq019,s_detail1[1].b_glaq020, 
                              s_detail1[1].b_glaq021,s_detail1[1].b_glaq022,s_detail1[1].b_glaq023,s_detail1[1].b_glaq024, 
                              s_detail1[1].b_glaq051,s_detail1[1].b_glaq052,s_detail1[1].b_glaq053,s_detail1[1].b_glaq025, 
                              s_detail1[1].b_glaq027,s_detail1[1].b_glaq028,s_detail1[1].b_glaq029,s_detail1[1].b_glaq030, 
                              s_detail1[1].b_glaq031,s_detail1[1].b_glaq032,s_detail1[1].b_glaq033,s_detail1[1].b_glaq034, 
                              s_detail1[1].b_glaq035,s_detail1[1].b_glaq036,s_detail1[1].b_glaq037,s_detail1[1].b_glaq038, 
                              s_detail1[1].b_glapownid,s_detail1[1].b_glapcnfid,s_detail1[1].b_glappstid, 
                              s_detail1[1].b_glap013,s_detail1[1].b_glap009
 
         BEFORE CONSTRUCT
                     DISPLAY aglq310_filter_parser('glapdocdt') TO s_detail1[1].b_glapdocdt
            DISPLAY aglq310_filter_parser('glap002') TO s_detail1[1].b_glap002
            DISPLAY aglq310_filter_parser('glap004') TO s_detail1[1].b_glap004
            DISPLAY aglq310_filter_parser('glapdocno') TO s_detail1[1].b_glapdocno
            DISPLAY aglq310_filter_parser('glaqseq') TO s_detail1[1].b_glaqseq
            DISPLAY aglq310_filter_parser('glaq001') TO s_detail1[1].b_glaq001
            DISPLAY aglq310_filter_parser('glaq002') TO s_detail1[1].b_glaq002
            DISPLAY aglq310_filter_parser('glaq005') TO s_detail1[1].b_glaq005
            DISPLAY aglq310_filter_parser('glaq010') TO s_detail1[1].b_glaq010
            DISPLAY aglq310_filter_parser('glaq006') TO s_detail1[1].b_glaq006
            DISPLAY aglq310_filter_parser('glaq003') TO s_detail1[1].b_glaq003
            DISPLAY aglq310_filter_parser('glaq004') TO s_detail1[1].b_glaq004
            DISPLAY aglq310_filter_parser('glaq039') TO s_detail1[1].b_glaq039
            DISPLAY aglq310_filter_parser('glaq040') TO s_detail1[1].b_glaq040
            DISPLAY aglq310_filter_parser('glaq041') TO s_detail1[1].b_glaq041
            DISPLAY aglq310_filter_parser('glaq042') TO s_detail1[1].b_glaq042
            DISPLAY aglq310_filter_parser('glaq043') TO s_detail1[1].b_glaq043
            DISPLAY aglq310_filter_parser('glaq044') TO s_detail1[1].b_glaq044
            DISPLAY aglq310_filter_parser('glaq017') TO s_detail1[1].b_glaq017
            DISPLAY aglq310_filter_parser('glaq018') TO s_detail1[1].b_glaq018
            DISPLAY aglq310_filter_parser('glaq019') TO s_detail1[1].b_glaq019
            DISPLAY aglq310_filter_parser('glaq020') TO s_detail1[1].b_glaq020
            DISPLAY aglq310_filter_parser('glaq021') TO s_detail1[1].b_glaq021
            DISPLAY aglq310_filter_parser('glaq022') TO s_detail1[1].b_glaq022
            DISPLAY aglq310_filter_parser('glaq023') TO s_detail1[1].b_glaq023
            DISPLAY aglq310_filter_parser('glaq024') TO s_detail1[1].b_glaq024
            DISPLAY aglq310_filter_parser('glaq051') TO s_detail1[1].b_glaq051
            DISPLAY aglq310_filter_parser('glaq052') TO s_detail1[1].b_glaq052
            DISPLAY aglq310_filter_parser('glaq053') TO s_detail1[1].b_glaq053
            DISPLAY aglq310_filter_parser('glaq025') TO s_detail1[1].b_glaq025
            DISPLAY aglq310_filter_parser('glaq027') TO s_detail1[1].b_glaq027
            DISPLAY aglq310_filter_parser('glaq028') TO s_detail1[1].b_glaq028
            DISPLAY aglq310_filter_parser('glaq029') TO s_detail1[1].b_glaq029
            DISPLAY aglq310_filter_parser('glaq030') TO s_detail1[1].b_glaq030
            DISPLAY aglq310_filter_parser('glaq031') TO s_detail1[1].b_glaq031
            DISPLAY aglq310_filter_parser('glaq032') TO s_detail1[1].b_glaq032
            DISPLAY aglq310_filter_parser('glaq033') TO s_detail1[1].b_glaq033
            DISPLAY aglq310_filter_parser('glaq034') TO s_detail1[1].b_glaq034
            DISPLAY aglq310_filter_parser('glaq035') TO s_detail1[1].b_glaq035
            DISPLAY aglq310_filter_parser('glaq036') TO s_detail1[1].b_glaq036
            DISPLAY aglq310_filter_parser('glaq037') TO s_detail1[1].b_glaq037
            DISPLAY aglq310_filter_parser('glaq038') TO s_detail1[1].b_glaq038
            DISPLAY aglq310_filter_parser('glapownid') TO s_detail1[1].b_glapownid
            DISPLAY aglq310_filter_parser('glapcnfid') TO s_detail1[1].b_glapcnfid
            DISPLAY aglq310_filter_parser('glappstid') TO s_detail1[1].b_glappstid
            DISPLAY aglq310_filter_parser('glap013') TO s_detail1[1].b_glap013
            DISPLAY aglq310_filter_parser('glap009') TO s_detail1[1].b_glap009
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glapdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapdocdt
            #add-point:ON ACTION controlp INFIELD b_glapdocdt name="construct.c.filter.page1.b_glapdocdt"
            
            #END add-point
 
 
         #----<<b_glap002>>----
         #Ctrlp:construct.c.filter.page1.b_glap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap002
            #add-point:ON ACTION controlp INFIELD b_glap002 name="construct.c.filter.page1.b_glap002"
            
            #END add-point
 
 
         #----<<b_glap004>>----
         #Ctrlp:construct.c.filter.page1.b_glap004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap004
            #add-point:ON ACTION controlp INFIELD b_glap004 name="construct.c.filter.page1.b_glap004"
            
            #END add-point
 
 
         #----<<b_glapdocno>>----
         #Ctrlp:construct.c.page1.b_glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapdocno
            #add-point:ON ACTION controlp INFIELD b_glapdocno name="construct.c.filter.page1.b_glapdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapdocno  #顯示到畫面上
            NEXT FIELD b_glapdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaqseq>>----
         #Ctrlp:construct.c.filter.page1.b_glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaqseq
            #add-point:ON ACTION controlp INFIELD b_glaqseq name="construct.c.filter.page1.b_glaqseq"
            
            #END add-point
 
 
         #----<<b_glaq001>>----
         #Ctrlp:construct.c.filter.page1.b_glaq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq001
            #add-point:ON ACTION controlp INFIELD b_glaq001 name="construct.c.filter.page1.b_glaq001"
            
            #END add-point
 
 
         #----<<b_glaq002>>----
         #Ctrlp:construct.c.page1.b_glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq002
            #add-point:ON ACTION controlp INFIELD b_glaq002 name="construct.c.filter.page1.b_glaq002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq002_desc>>----
         #----<<b_glaq005>>----
         #Ctrlp:construct.c.page1.b_glaq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq005
            #add-point:ON ACTION controlp INFIELD b_glaq005 name="construct.c.filter.page1.b_glaq005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq005  #顯示到畫面上
            NEXT FIELD b_glaq005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq005_desc>>----
         #----<<b_glaq010>>----
         #Ctrlp:construct.c.filter.page1.b_glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq010
            #add-point:ON ACTION controlp INFIELD b_glaq010 name="construct.c.filter.page1.b_glaq010"
            
            #END add-point
 
 
         #----<<b_glaq006>>----
         #Ctrlp:construct.c.filter.page1.b_glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq006
            #add-point:ON ACTION controlp INFIELD b_glaq006 name="construct.c.filter.page1.b_glaq006"
            
            #END add-point
 
 
         #----<<b_glaq003>>----
         #Ctrlp:construct.c.filter.page1.b_glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq003
            #add-point:ON ACTION controlp INFIELD b_glaq003 name="construct.c.filter.page1.b_glaq003"
            
            #END add-point
 
 
         #----<<b_glaq004>>----
         #Ctrlp:construct.c.filter.page1.b_glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq004
            #add-point:ON ACTION controlp INFIELD b_glaq004 name="construct.c.filter.page1.b_glaq004"
            
            #END add-point
 
 
         #----<<b_glaq039>>----
         #Ctrlp:construct.c.filter.page1.b_glaq039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq039
            #add-point:ON ACTION controlp INFIELD b_glaq039 name="construct.c.filter.page1.b_glaq039"
            
            #END add-point
 
 
         #----<<b_glaq040>>----
         #Ctrlp:construct.c.filter.page1.b_glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq040
            #add-point:ON ACTION controlp INFIELD b_glaq040 name="construct.c.filter.page1.b_glaq040"
            
            #END add-point
 
 
         #----<<b_glaq041>>----
         #Ctrlp:construct.c.filter.page1.b_glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq041
            #add-point:ON ACTION controlp INFIELD b_glaq041 name="construct.c.filter.page1.b_glaq041"
            
            #END add-point
 
 
         #----<<b_glaq042>>----
         #Ctrlp:construct.c.filter.page1.b_glaq042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq042
            #add-point:ON ACTION controlp INFIELD b_glaq042 name="construct.c.filter.page1.b_glaq042"
            
            #END add-point
 
 
         #----<<b_glaq043>>----
         #Ctrlp:construct.c.filter.page1.b_glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq043
            #add-point:ON ACTION controlp INFIELD b_glaq043 name="construct.c.filter.page1.b_glaq043"
            
            #END add-point
 
 
         #----<<b_glaq044>>----
         #Ctrlp:construct.c.filter.page1.b_glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq044
            #add-point:ON ACTION controlp INFIELD b_glaq044 name="construct.c.filter.page1.b_glaq044"
            
            #END add-point
 
 
         #----<<b_glaq017>>----
         #Ctrlp:construct.c.page1.b_glaq017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq017
            #add-point:ON ACTION controlp INFIELD b_glaq017 name="construct.c.filter.page1.b_glaq017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#1 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq017  #顯示到畫面上
            NEXT FIELD b_glaq017                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq017_desc>>----
         #----<<b_glaq018>>----
         #Ctrlp:construct.c.page1.b_glaq018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq018
            #add-point:ON ACTION controlp INFIELD b_glaq018 name="construct.c.filter.page1.b_glaq018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq018  #顯示到畫面上
            NEXT FIELD b_glaq018                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq018_desc>>----
         #----<<b_glaq019>>----
         #Ctrlp:construct.c.page1.b_glaq019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq019
            #add-point:ON ACTION controlp INFIELD b_glaq019 name="construct.c.filter.page1.b_glaq019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq019  #顯示到畫面上
            NEXT FIELD b_glaq019                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq019_desc>>----
         #----<<b_glaq020>>----
         #Ctrlp:construct.c.page1.b_glaq020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq020
            #add-point:ON ACTION controlp INFIELD b_glaq020 name="construct.c.filter.page1.b_glaq020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq020  #顯示到畫面上
            NEXT FIELD b_glaq020                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq020_desc>>----
         #----<<b_glaq021>>----
         #Ctrlp:construct.c.page1.b_glaq021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq021
            #add-point:ON ACTION controlp INFIELD b_glaq021 name="construct.c.filter.page1.b_glaq021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
             CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq021  #顯示到畫面上
            NEXT FIELD b_glaq021                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq021_desc>>----
         #----<<b_glaq022>>----
         #Ctrlp:construct.c.page1.b_glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq022
            #add-point:ON ACTION controlp INFIELD b_glaq022 name="construct.c.filter.page1.b_glaq022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq022  #顯示到畫面上
            NEXT FIELD b_glaq022                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq022_desc>>----
         #----<<b_glaq023>>----
         #Ctrlp:construct.c.page1.b_glaq023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq023
            #add-point:ON ACTION controlp INFIELD b_glaq023 name="construct.c.filter.page1.b_glaq023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq023  #顯示到畫面上
            NEXT FIELD b_glaq023                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq023_desc>>----
         #----<<b_glaq024>>----
         #Ctrlp:construct.c.page1.b_glaq024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq024
            #add-point:ON ACTION controlp INFIELD b_glaq024 name="construct.c.filter.page1.b_glaq024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq024  #顯示到畫面上
            NEXT FIELD b_glaq024                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq024_desc>>----
         #----<<b_glbc004>>----
         #----<<b_glbc004_desc>>----
         #----<<b_glaq051>>----
         #Ctrlp:construct.c.filter.page1.b_glaq051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq051
            #add-point:ON ACTION controlp INFIELD b_glaq051 name="construct.c.filter.page1.b_glaq051"
            
            #END add-point
 
 
         #----<<b_glaq052>>----
         #Ctrlp:construct.c.page1.b_glaq052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq052
            #add-point:ON ACTION controlp INFIELD b_glaq052 name="construct.c.filter.page1.b_glaq052"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq052  #顯示到畫面上
            NEXT FIELD b_glaq052                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq052_desc>>----
         #----<<b_glaq053>>----
         #Ctrlp:construct.c.page1.b_glaq053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq053
            #add-point:ON ACTION controlp INFIELD b_glaq053 name="construct.c.filter.page1.b_glaq053"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq053  #顯示到畫面上
            NEXT FIELD b_glaq053                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq053_desc>>----
         #----<<b_glaq025>>----
         #Ctrlp:construct.c.page1.b_glaq025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq025
            #add-point:ON ACTION controlp INFIELD b_glaq025 name="construct.c.filter.page1.b_glaq025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq025  #顯示到畫面上
            NEXT FIELD b_glaq025                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq025_desc>>----
         #----<<b_glaq027>>----
         #Ctrlp:construct.c.page1.b_glaq027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq027
            #add-point:ON ACTION controlp INFIELD b_glaq027 name="construct.c.filter.page1.b_glaq027"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq027  #顯示到畫面上
            NEXT FIELD b_glaq027                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq027_desc>>----
         #----<<b_glaq028>>----
         #Ctrlp:construct.c.page1.b_glaq028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq028
            #add-point:ON ACTION controlp INFIELD b_glaq028 name="construct.c.filter.page1.b_glaq028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq028  #顯示到畫面上
            NEXT FIELD b_glaq028                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq028_desc>>----
         #----<<b_glaq029>>----
         #Ctrlp:construct.c.page1.b_glaq029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq029
            #add-point:ON ACTION controlp INFIELD b_glaq029 name="construct.c.filter.page1.b_glaq029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq029  #顯示到畫面上
            NEXT FIELD b_glaq029                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq029_desc>>----
         #----<<b_glaq030>>----
         #Ctrlp:construct.c.page1.b_glaq030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq030
            #add-point:ON ACTION controlp INFIELD b_glaq030 name="construct.c.filter.page1.b_glaq030"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq030  #顯示到畫面上
            NEXT FIELD b_glaq030                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq030_desc>>----
         #----<<b_glaq031>>----
         #Ctrlp:construct.c.page1.b_glaq031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq031
            #add-point:ON ACTION controlp INFIELD b_glaq031 name="construct.c.filter.page1.b_glaq031"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq031  #顯示到畫面上
            NEXT FIELD b_glaq031                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq031_desc>>----
         #----<<b_glaq032>>----
         #Ctrlp:construct.c.page1.b_glaq032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq032
            #add-point:ON ACTION controlp INFIELD b_glaq032 name="construct.c.filter.page1.b_glaq032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq032  #顯示到畫面上
            NEXT FIELD b_glaq032                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq032_desc>>----
         #----<<b_glaq033>>----
         #Ctrlp:construct.c.page1.b_glaq033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq033
            #add-point:ON ACTION controlp INFIELD b_glaq033 name="construct.c.filter.page1.b_glaq033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq033  #顯示到畫面上
            NEXT FIELD b_glaq033                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq033_desc>>----
         #----<<b_glaq034>>----
         #Ctrlp:construct.c.page1.b_glaq034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq034
            #add-point:ON ACTION controlp INFIELD b_glaq034 name="construct.c.filter.page1.b_glaq034"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq034  #顯示到畫面上
            NEXT FIELD b_glaq034                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq034_desc>>----
         #----<<b_glaq035>>----
         #Ctrlp:construct.c.page1.b_glaq035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq035
            #add-point:ON ACTION controlp INFIELD b_glaq035 name="construct.c.filter.page1.b_glaq035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq035  #顯示到畫面上
            NEXT FIELD b_glaq035                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq035_desc>>----
         #----<<b_glaq036>>----
         #Ctrlp:construct.c.page1.b_glaq036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq036
            #add-point:ON ACTION controlp INFIELD b_glaq036 name="construct.c.filter.page1.b_glaq036"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq036  #顯示到畫面上
            NEXT FIELD b_glaq036                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq036_desc>>----
         #----<<b_glaq037>>----
         #Ctrlp:construct.c.page1.b_glaq037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq037
            #add-point:ON ACTION controlp INFIELD b_glaq037 name="construct.c.filter.page1.b_glaq037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq037  #顯示到畫面上
            NEXT FIELD b_glaq037                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq037_desc>>----
         #----<<b_glaq038>>----
         #Ctrlp:construct.c.page1.b_glaq038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glaq038
            #add-point:ON ACTION controlp INFIELD b_glaq038 name="construct.c.filter.page1.b_glaq038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq038  #顯示到畫面上
            NEXT FIELD b_glaq038                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glaq038_desc>>----
         #----<<b_glapownid>>----
         #Ctrlp:construct.c.page1.b_glapownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapownid
            #add-point:ON ACTION controlp INFIELD b_glapownid name="construct.c.filter.page1.b_glapownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapownid  #顯示到畫面上
            NEXT FIELD b_glapownid                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glapownid_desc>>----
         #----<<b_glapcnfid>>----
         #Ctrlp:construct.c.page1.b_glapcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glapcnfid
            #add-point:ON ACTION controlp INFIELD b_glapcnfid name="construct.c.filter.page1.b_glapcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glapcnfid  #顯示到畫面上
            NEXT FIELD b_glapcnfid                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glapcnfid_desc>>----
         #----<<b_glappstid>>----
         #Ctrlp:construct.c.page1.b_glappstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glappstid
            #add-point:ON ACTION controlp INFIELD b_glappstid name="construct.c.filter.page1.b_glappstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glappstid  #顯示到畫面上
            NEXT FIELD b_glappstid                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glappstid_desc>>----
         #----<<b_glap013>>----
         #Ctrlp:construct.c.filter.page1.b_glap013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap013
            #add-point:ON ACTION controlp INFIELD b_glap013 name="construct.c.filter.page1.b_glap013"
            
            #END add-point
 
 
         #----<<b_glap009>>----
         #Ctrlp:construct.c.filter.page1.b_glap009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glap009
            #add-point:ON ACTION controlp INFIELD b_glap009 name="construct.c.filter.page1.b_glap009"
            
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
   
      CALL aglq310_filter_show('glapdocdt','b_glapdocdt')
   CALL aglq310_filter_show('glap002','b_glap002')
   CALL aglq310_filter_show('glap004','b_glap004')
   CALL aglq310_filter_show('glapdocno','b_glapdocno')
   CALL aglq310_filter_show('glaqseq','b_glaqseq')
   CALL aglq310_filter_show('glaq001','b_glaq001')
   CALL aglq310_filter_show('glaq002','b_glaq002')
   CALL aglq310_filter_show('glaq005','b_glaq005')
   CALL aglq310_filter_show('glaq010','b_glaq010')
   CALL aglq310_filter_show('glaq006','b_glaq006')
   CALL aglq310_filter_show('glaq003','b_glaq003')
   CALL aglq310_filter_show('glaq004','b_glaq004')
   CALL aglq310_filter_show('glaq039','b_glaq039')
   CALL aglq310_filter_show('glaq040','b_glaq040')
   CALL aglq310_filter_show('glaq041','b_glaq041')
   CALL aglq310_filter_show('glaq042','b_glaq042')
   CALL aglq310_filter_show('glaq043','b_glaq043')
   CALL aglq310_filter_show('glaq044','b_glaq044')
   CALL aglq310_filter_show('glaq017','b_glaq017')
   CALL aglq310_filter_show('glaq018','b_glaq018')
   CALL aglq310_filter_show('glaq019','b_glaq019')
   CALL aglq310_filter_show('glaq020','b_glaq020')
   CALL aglq310_filter_show('glaq021','b_glaq021')
   CALL aglq310_filter_show('glaq022','b_glaq022')
   CALL aglq310_filter_show('glaq023','b_glaq023')
   CALL aglq310_filter_show('glaq024','b_glaq024')
   CALL aglq310_filter_show('glaq051','b_glaq051')
   CALL aglq310_filter_show('glaq052','b_glaq052')
   CALL aglq310_filter_show('glaq053','b_glaq053')
   CALL aglq310_filter_show('glaq025','b_glaq025')
   CALL aglq310_filter_show('glaq027','b_glaq027')
   CALL aglq310_filter_show('glaq028','b_glaq028')
   CALL aglq310_filter_show('glaq029','b_glaq029')
   CALL aglq310_filter_show('glaq030','b_glaq030')
   CALL aglq310_filter_show('glaq031','b_glaq031')
   CALL aglq310_filter_show('glaq032','b_glaq032')
   CALL aglq310_filter_show('glaq033','b_glaq033')
   CALL aglq310_filter_show('glaq034','b_glaq034')
   CALL aglq310_filter_show('glaq035','b_glaq035')
   CALL aglq310_filter_show('glaq036','b_glaq036')
   CALL aglq310_filter_show('glaq037','b_glaq037')
   CALL aglq310_filter_show('glaq038','b_glaq038')
   CALL aglq310_filter_show('glapownid','b_glapownid')
   CALL aglq310_filter_show('glapcnfid','b_glapcnfid')
   CALL aglq310_filter_show('glappstid','b_glappstid')
   CALL aglq310_filter_show('glap013','b_glap013')
   CALL aglq310_filter_show('glap009','b_glap009')
 
    
   CALL aglq310_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq310.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq310_filter_parser(ps_field)
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
 
{<section id="aglq310.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq310_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq310.insert" >}
#+ insert
PRIVATE FUNCTION aglq310_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq310.modify" >}
#+ modify
PRIVATE FUNCTION aglq310_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq310.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq310_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq310.delete" >}
#+ delete
PRIVATE FUNCTION aglq310_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq310.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq310_detail_action_trans()
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
 
{<section id="aglq310.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq310_detail_index_setting()
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
            IF g_glaq_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glaq_d.getLength() AND g_glaq_d.getLength() > 0
            LET g_detail_idx = g_glaq_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glaq_d.getLength() THEN
               LET g_detail_idx = g_glaq_d.getLength()
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
 
{<section id="aglq310.mask_functions" >}
 &include "erp/agl/aglq310_mask.4gl"
 
{</section>}
 
{<section id="aglq310.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq310_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2015/02/05 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq310_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022 
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa005,g_glaa013,
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
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
   END CASE
   LET tm.ctype='0'
   
   CALL aglq310_set_curr_show() #顯示本位幣二、本位幣三
END FUNCTION

################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq310_set_curr_show()
# Date & Author..: 2015/02/05 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq310_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      CALL cl_set_comp_visible("b_glaq039,b_glaq040,b_glaq041",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq039,b_glaq040,b_glaq041",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      CALL cl_set_comp_visible("b_glaq042,b_glaq043,b_glaq044",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq042,b_glaq043,b_glaq044",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible("b_glaq039,b_glaq040,b_glaq041",TRUE)
      CALL cl_set_comp_visible("b_glaq042,b_glaq043,b_glaq044",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq310_show()
# Date & Author..:  2015/02/05 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq310_show()
   DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.ctype,tm.stus
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           sdate,syear,speriod,edate,eyear,eperiod,ctype,stus
END FUNCTION

################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq310_set_default_value()
# Date & Author..: 2015/02/05 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq310_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET tm.sdate=l_pdate_s  #起始日期
   LET tm.syear=l_glav002
   LET tm.speriod=l_glav006
   LET tm.edate=l_pdate_e  #截止日期
   LET tm.eyear=l_glav002
   LET tm.eperiod=l_glav006
  
   #單據狀態
   LET tm.stus='1'
   
END FUNCTION

################################################################################
# Descriptions...: 新建臨時表
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq310_create_tmp()
   DROP TABLE aglq310_tmp01;                #160727-00019#3  Mod  aglq310_print_tmp -->aglq310_tmp01
      CREATE TEMP TABLE aglq310_tmp01(      #160727-00019#3  Mod  aglq310_print_tmp -->aglq310_tmp01
   glaald_desc  VARCHAR(500),
   glaacomp_desc  VARCHAR(500),
   curr_desc  VARCHAR(500),
   sdate  VARCHAR(50),           #起始日期
   edate  VARCHAR(50),           #截止日期
   ctype  VARCHAR(20),            #多本位幣
   stus_desc  VARCHAR(20),
   glapdocdt  DATE, 
   glap002  SMALLINT, 
   glap004  SMALLINT, 
   glapdocno  VARCHAR(20), 
   glaqseq  INTEGER, 
   glaq001  VARCHAR(255), 
   glaq002  VARCHAR(24), 
   glaq002_desc  VARCHAR(500), 
   glaq005  VARCHAR(10), 
   glaq005_desc  VARCHAR(500), 
   glaq010  DECIMAL(20,6), 
   glaq006  DECIMAL(20,10), 
   glaq003  DECIMAL(20,6), 
   glaq004  DECIMAL(20,6), 
   glaq039  DECIMAL(20,10), 
   glaq040  DECIMAL(20,6), 
   glaq041  DECIMAL(20,6), 
   glaq042  DECIMAL(20,10), 
   glaq043  DECIMAL(20,6), 
   glaq044  DECIMAL(20,6), 
   glaq017  VARCHAR(10), 
   glaq017_desc  VARCHAR(500), 
   glaq018  VARCHAR(10), 
   glaq018_desc  VARCHAR(500), 
   glaq019  VARCHAR(10), 
   glaq019_desc  VARCHAR(500), 
   glaq020  VARCHAR(10), 
   glaq020_desc  VARCHAR(500), 
   glaq021  VARCHAR(10), 
   glaq021_desc  VARCHAR(500), 
   glaq022  VARCHAR(10), 
   glaq022_desc  VARCHAR(500), 
   glaq023  VARCHAR(10), 
   glaq023_desc  VARCHAR(500), 
   glaq024  VARCHAR(10), 
   glaq024_desc  VARCHAR(500), 
   glbc004  VARCHAR(500), 
   glbc004_desc  VARCHAR(500), 
   glaq051  VARCHAR(10), 
   glaq052  VARCHAR(10), 
   glaq052_desc  VARCHAR(500), 
   glaq053  VARCHAR(10), 
   glaq053_desc  VARCHAR(500), 
   glaq025  VARCHAR(20), 
   glaq025_desc  VARCHAR(500), 
   glaq027  VARCHAR(20), 
   glaq027_desc  VARCHAR(500), 
   glaq028  VARCHAR(30), 
   glaq028_desc  VARCHAR(500), 
   glaq029  VARCHAR(30), 
   glaq029_desc  VARCHAR(500), 
   glaq030  VARCHAR(30), 
   glaq030_desc  VARCHAR(500), 
   glaq031  VARCHAR(30), 
   glaq031_desc  VARCHAR(500), 
   glaq032  VARCHAR(30), 
   glaq032_desc  VARCHAR(500), 
   glaq033  VARCHAR(30), 
   glaq033_desc  VARCHAR(500), 
   glaq034  VARCHAR(30), 
   glaq034_desc  VARCHAR(500), 
   glaq035  VARCHAR(30), 
   glaq035_desc  VARCHAR(500), 
   glaq036  VARCHAR(30), 
   glaq036_desc  VARCHAR(500), 
   glaq037  VARCHAR(30), 
   glaq037_desc  VARCHAR(500), 
   glaq038  VARCHAR(30), 
   glaq038_desc  VARCHAR(500), 
   glapownid_desc  VARCHAR(500), 
   glapcnfid_desc  VARCHAR(500), 
   glappstid_desc  VARCHAR(500), 
   glap013  SMALLINT, 
   glap009  INTEGER
       )
END FUNCTION

################################################################################
# Descriptions...: 串查aglt310傳票資料
# Memo...........: #151201-00002#15
# Usage..........: CALL aglq310_cmdrun()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/02/23 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq310_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   DEFINE l_glap001    LIKE glap_t.glap001
   
   SELECT glap001 INTO l_glap001 FROM glap_t 
    WHERE glapent=g_enterprise AND glapld=g_glaald AND glapdocno=g_glaq_d[g_detail_idx].glapdocno
    
   INITIALIZE la_param.* TO NULL
   #傳票性質
   CASE l_glap001
      WHEN '1'
         LET la_param.prog = 'aglt310'
      WHEN '2'
         LET la_param.prog = 'aglt320'
      WHEN '3'
         LET la_param.prog = 'aglt330'
      WHEN '4'
         LET la_param.prog = 'aglt340'
      WHEN '5'
         LET la_param.prog = 'aglt350'
      WHEN '6'
         LET la_param.prog = 'aglt410'
   END CASE
   LET la_param.param[1] = g_glaald    #帳別
   LET la_param.param[2] = g_glaq_d[g_detail_idx].glapdocno     #傳票單號 
   LET ls_js = util.JSON.stringify( la_param )
   CALL cl_cmdrun(ls_js)
END FUNCTION

 
{</section>}
 
