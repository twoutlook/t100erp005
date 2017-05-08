#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq470.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-02-19 10:11:32), PR版次:0006(2016-12-21 13:18:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: axrq470
#+ Description: 遞延認列明細查詢作業
#+ Creator....: 03080(2016-01-28 10:43:17)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="axrq470.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151008-00009#9  2016/07/07 By 03538     增加21:銷退沖抵類型
#160731-00372#1  2016/08/16 By 07900     客户开窗不要开供应商
#160811-00009#2  2016/08/17 By 01531     账务中心/法人/账套权限控管
#161021-00050#5  2016/10/26 By 08729     處理組織開窗
#161123-00048#5  2016/11/25 By 08729     開窗增加過濾據點
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
PRIVATE TYPE type_g_xreq_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xreqld LIKE xreq_t.xreqld, 
   xreqdocno LIKE xreq_t.xreqdocno, 
   xreqseq LIKE xreq_t.xreqseq, 
   xreqorga LIKE xreq_t.xreqorga, 
   xreq016 LIKE xreq_t.xreq016, 
   xreq016_desc LIKE type_t.chr100, 
   xreq007 LIKE xreq_t.xreq007, 
   xreq003 LIKE xreq_t.xreq003, 
   xreq006 LIKE xreq_t.xreq006, 
   xreq004 LIKE xreq_t.xreq004, 
   xreq005 LIKE xreq_t.xreq005, 
   xreq010 LIKE xreq_t.xreq010, 
   l_imaal003 LIKE type_t.chr100, 
   l_imaal004 LIKE type_t.chr100, 
   xreq009 LIKE xreq_t.xreq009, 
   xreq009_desc LIKE type_t.chr100, 
   xreq008 LIKE xreq_t.xreq008, 
   l_xrca038 LIKE type_t.chr20, 
   xreq012 LIKE xreq_t.xreq012, 
   xreq012_desc LIKE type_t.chr100, 
   xreq100 LIKE xreq_t.xreq100, 
   xreq041 LIKE xreq_t.xreq041, 
   xreq103 LIKE xreq_t.xreq103, 
   l_xreq041103 LIKE type_t.num20_6, 
   xreq042 LIKE xreq_t.xreq042, 
   xreq113 LIKE xreq_t.xreq113, 
   l_xreq042113 LIKE type_t.num20_6, 
   xreq043 LIKE xreq_t.xreq043, 
   xreq123 LIKE xreq_t.xreq123, 
   l_xreq043123 LIKE type_t.num20_6, 
   xreq044 LIKE xreq_t.xreq044, 
   xreq133 LIKE xreq_t.xreq133, 
   l_xreq044133 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input   RECORD
                 l_xrepld      LIKE xrep_t.xrepld,
                 l_xrepld_desc LIKE type_t.chr100,
                 l_xrepsite    LIKE xrep_t.xrepsite,
                 l_xrepsite_desc LIKE type_t.chr100
                 END RECORD
                 
                 
DEFINE g_wc_l   STRING
DEFINE g_wc_l_t STRING
DEFINE g_ctl_where          STRING    #交易對象控制組WHERE CON

DEFINE g_xreq2_d DYNAMIC ARRAY OF RECORD
                 xreq008   LIKE xreq_t.xreq008,
                 xreq011   LIKE xreq_t.xreq011,
                 xreq103   LIKE xreq_t.xreq103,
                 xreq101   LIKE xreq_t.xreq101,
                 xreq113   LIKE xreq_t.xreq113,
                 xreq013   LIKE xreq_t.xreq013,
                 xreq013_desc LIKE type_t.chr100,
                 l_xrep004  LIKE xrep_t.xrep004
                 END RECORD
                 
#DEFINE g_detail_cnt2 LIKE type_t.num10
DEFINE g_wc_filter_l    STRING
DEFINE g_wc_filter_l_t  STRING

DEFINE g_wc_site        STRING
DEFINE g_wc_ld          STRING

GLOBALS
DEFINE g_xg_vis         STRING
END GLOBALS
DEFINE g_comp           LIKE glaa_t.glaacomp   #161123-00048#5-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xreq_d
DEFINE g_master_t                   type_g_xreq_d
DEFINE g_xreq_d          DYNAMIC ARRAY OF type_g_xreq_d
DEFINE g_xreq_d_t        type_g_xreq_d
 
      
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
 
{<section id="axrq470.main" >}
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
   CALL cl_ap_init("axr","")
 
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
   DECLARE axrq470_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq470_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq470_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq470 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq470_init()   
 
      #進入選單 Menu (="N")
      CALL axrq470_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq470
      
   END IF 
   
   CLOSE axrq470_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq470.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq470_init()
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
   
      CALL cl_set_combo_scc('b_xreq003','8348') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('b_xreq003','8348','1,3')   #上單身只看到1 3類
   LET g_wc_filter_l   = " 1=1"
   LET g_wc_filter_l_t = " 1=1"
   CALL s_fin_create_account_center_tmp()                 #展組織下階成員所需之暫存檔
   CALL axrq470_create_xg_tmp()
   #161123-00048#5-add(s)
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_ctl_where
   #161123-00048#5-add(e)
   #end add-point
 
   CALL axrq470_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq470.default_search" >}
PRIVATE FUNCTION axrq470_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xreqdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xreqld = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xreqseq = '", g_argv[03], "' AND "
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
 
{<section id="axrq470.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq470_ui_dialog()
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
   #DEFINE l_tmp      RECORD
   #   xreq016         LIKE xreq_t.xreq016,
   #   xreqorga        LIKE xreq_t.xreqorga,
   #   l_xreqorga_desc LIKE type_t.chr200,
   #   xreq007         LIKE xreq_t.xreq007,
   #   l_xreq003_desc  LIKE type_t.chr200,
   #   xreq006         LIKE xreq_t.xreq006,
   #   xreq004         LIKE xreq_t.xreq004,
   #   xreq005         LIKE xreq_t.xreq005,
   #   xreq010         LIKE xreq_t.xreq010,
   #   l_imaal003      LIKE type_t.chr200,
   #   l_imaal004      LIKE type_t.chr200,
   #   xreq009         LIKE xreq_t.xreq009,
   #   l_xreq009_desc  LIKE type_t.chr200,
   #   xreq008         LIKE xreq_t.xreq008,
   #   l_xrca038       LIKE type_t.chr200,
   #   xreq012         LIKE xreq_t.xreq012,
   #   l_xreq012_desc  LIKE type_t.chr200,
   #   xreq100         LIKE xreq_t.xreq100,
   #   xreq041         LIKE xreq_t.xreq041,
   #   xreq103         LIKE xreq_t.xreq103,
   #   l_xreq041103    LIKE type_t.num20_6,
   #   xreq042         LIKE xreq_t.xreq042,
   #   xreq113         LIKE xreq_t.xreq113,
   #   l_xreq042113    LIKE type_t.num20_6,
   #   xreq043         LIKE xreq_t.xreq043,
   #   xreq123         LIKE xreq_t.xreq123,
   #   l_xreq043123    LIKE type_t.num20_6,
   #   xreq044         LIKE xreq_t.xreq044,
   #   xreq133         LIKE xreq_t.xreq133,
   #   l_xreq044133    LIKE type_t.num20_6
   #                  END RECORD
   #DEFINE l_sql      STRING
   #DEFINE l_i        LIKE type_t.num10
   #
   #DEFINE l_glaa015  LIKE glaa_t.glaa015
   #DEFINE l_glaa019  LIKE glaa_t.glaa019
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
      CALL axrq470_b_fill()
   ELSE
      CALL axrq470_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xreq_d.clear()
 
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
 
         CALL axrq470_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xreq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq470_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq470_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL axrq470_b_fill2(l_ac)
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xreq2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
         END DISPLAY 
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq470_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrq470_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #161221-00012#2 --s mark
               #LET g_xg_vis = NULL
               #LET l_glaa015 = NULL LET l_glaa019 = NULL
               #SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
               #  FROM glaa_t
               # WHERE glaaent = g_enterprise
               #   AND glaald = g_input.l_xrepld
               #
               #IF l_glaa015 = 'N' THEN 
               #   LET g_xg_vis ="xreq043|xreq123|l_xreq043123"             
               #END IF
               #IF l_glaa019 = 'N' THEN 
               #   IF NOT cl_null(g_xg_vis)THEN
               #      LET g_xg_vis = g_xg_vis CLIPPED,"|"
               #   END IF
               #   LET g_xg_vis = g_xg_vis CLIPPED ,"xreq044|xreq133|l_xreq044133"
               #END IF
               #
               #DELETE FROM axrq470_x01_tmp
               #
               #FOR l_i = 1 TO g_xreq_d.getLength()
               #   IF cl_null(g_xreq_d[l_i].xreqorga)THEN CONTINUE FOR END IF 
               #   INITIALIZE l_tmp.* TO NULL
               #   LET l_tmp.xreq016         = g_xreq_d[l_i].xreq016         
               #   LET l_tmp.xreqorga        = g_xreq_d[l_i].xreqorga        
               #   LET l_tmp.l_xreqorga_desc = g_xreq_d[l_i].xreq016_desc
               #   LET l_tmp.xreq007         = g_xreq_d[l_i].xreq007         
               #   LET l_tmp.l_xreq003_desc  = g_xreq_d[l_i].xreq003,":",s_desc_gzcbl004_desc('8348',g_xreq_d[l_i].xreq003)    #下拉要組             
               #   LET l_tmp.xreq006         = g_xreq_d[l_i].xreq006         
               #   LET l_tmp.xreq004         = g_xreq_d[l_i].xreq004         
               #   LET l_tmp.xreq005         = g_xreq_d[l_i].xreq005         
               #   LET l_tmp.xreq010         = g_xreq_d[l_i].xreq010         
               #   LET l_tmp.l_imaal003      = g_xreq_d[l_i].l_imaal003      
               #   LET l_tmp.l_imaal004      = g_xreq_d[l_i].l_imaal004      
               #   LET l_tmp.xreq009         = g_xreq_d[l_i].xreq009         
               #   LET l_tmp.l_xreq009_desc  = g_xreq_d[l_i].xreq009_desc  
               #   LET l_tmp.xreq008         = g_xreq_d[l_i].xreq008         
               #   LET l_tmp.l_xrca038       = g_xreq_d[l_i].l_xrca038       
               #   LET l_tmp.xreq012         = g_xreq_d[l_i].xreq012         
               #   LET l_tmp.l_xreq012_desc  = g_xreq_d[l_i].xreq012_desc  
               #   LET l_tmp.xreq100         = g_xreq_d[l_i].xreq100         
               #   LET l_tmp.xreq041         = g_xreq_d[l_i].xreq041         
               #   LET l_tmp.xreq103         = g_xreq_d[l_i].xreq103         
               #   LET l_tmp.l_xreq041103    = g_xreq_d[l_i].l_xreq041103    
               #   LET l_tmp.xreq042         = g_xreq_d[l_i].xreq042         
               #   LET l_tmp.xreq113         = g_xreq_d[l_i].xreq113         
               #   LET l_tmp.l_xreq042113    = g_xreq_d[l_i].l_xreq042113    
               #   LET l_tmp.xreq043         = g_xreq_d[l_i].xreq043         
               #   LET l_tmp.xreq123         = g_xreq_d[l_i].xreq123         
               #   LET l_tmp.l_xreq043123    = g_xreq_d[l_i].l_xreq043123    
               #   LET l_tmp.xreq044         = g_xreq_d[l_i].xreq044         
               #   LET l_tmp.xreq133         = g_xreq_d[l_i].xreq133         
               #   LET l_tmp.l_xreq044133    = g_xreq_d[l_i].l_xreq044133                      
               #   INSERT INTO axrq470_x01_tmp VALUES(l_tmp.*)
               #   
               #   #albireo 160129-----s
               #   LET l_sql = "SELECT  '','','',xrepdocdt, ",
               #               "        xreq003,'','','','',",
               #               "        '','','','',xreq008,",
               #               "        xrep004,",
               #               "        xreq013,(SELECT DISTINCT t132.glacl004 FROM glacl_t t132,glaa_t t131 WHERE t132.glaclent = xreqent AND t132.glacl002 = xreq013 AND t132.glacl003 = '"||g_dlang||"' AND t131.glaald = xreqld AND t131.glaaent = t132.glaclent) xreq013_desc,",
               #               "        xreq100,0,xreq103,0,0, ",
               #               "        xreq113,0,0, ",
               #               "        xreq123,0,0, ",
               #               "        xreq133,0,0 ",
               #               "  FROM xrep_t,xreq_t ",
               #               " WHERE xrepent = xreqent  ",
               #               "   AND xrepld  = xreqld ",
               #               "   AND xrepdocno = xreqdocno ",
               #               "   AND xrepent = ",g_enterprise," ",
               #               "   AND xrepstus <> 'X' ",
               #              #"   AND xreq003 IN ('2','4') ",        #151008-00009#9 mark
               #               "   AND xreq003 IN ('2','4','21') ",   #151008-00009#9 
               #               "   AND xrepsite = '",g_input.l_xrepsite,"' ",
               #               "   AND xrepld   = '",g_input.l_xrepld,"' ",
               #               "   AND xreq006 = '",g_xreq_d[l_i].xreq006,"' ",
               #               "   AND xreq004 = '",g_xreq_d[l_i].xreq004,"' ",
               #               "   AND xreq005 = ",g_xreq_d[l_i].xreq005," "
               #   PREPARE sel_xreqxgp1 FROM l_sql
               #   DECLARE sel_xreqxgc1 CURSOR FOR sel_xreqxgp1
               #   
               #   FOREACH sel_xreqxgc1 INTO l_tmp.*
               #      LET l_tmp.l_xreq003_desc  = l_tmp.l_xreq003_desc,":",s_desc_gzcbl004_desc('8348',l_tmp.l_xreq003_desc)    #下拉要組             
               #      IF SQLCA.SQLCODE THEN
               #         INITIALIZE g_errparam.* TO NULL
               #         LET g_errparam.extend = 'FOREACH:sel_xreqxgc1'
               #         LET g_errparam.code = SQLCA.SQLCODE
               #         CALL cl_err()
               #         EXIT FOREACH
               #      END IF
               #      INSERT INTO axrq470_x01_tmp VALUES(l_tmp.*)
               #   END FOREACH
               #   #albireo 160129-----e
               #END FOR
               #
               #CALL axrq470_x01(" 1=1","axrq470_x01_tmp" ) 
               #161221-00012#2  --e mark           
               CALL axrq470_output() #161221-00012#2 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #161221-00012#2 --s mark
               #LET g_xg_vis = NULL
               #LET l_glaa015 = NULL LET l_glaa019 = NULL
               #SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
               #  FROM glaa_t
               # WHERE glaaent = g_enterprise
               #   AND glaald = g_input.l_xrepld
               #
               #IF l_glaa015 = 'N' THEN 
               #   LET g_xg_vis ="xreq043|xreq123|l_xreq043123"             
               #END IF
               #IF l_glaa019 = 'N' THEN 
               #   IF NOT cl_null(g_xg_vis)THEN
               #      LET g_xg_vis = g_xg_vis CLIPPED,"|"
               #   END IF
               #   LET g_xg_vis = g_xg_vis CLIPPED ,"xreq044|xreq133|l_xreq044133"
               #END IF
               #
               #DELETE FROM axrq470_x01_tmp
               #
               #FOR l_i = 1 TO g_xreq_d.getLength()
               #   IF cl_null(g_xreq_d[l_i].xreqorga)THEN CONTINUE FOR END IF 
               #   INITIALIZE l_tmp.* TO NULL
               #   LET l_tmp.xreq016         = g_xreq_d[l_i].xreq016         
               #   LET l_tmp.xreqorga        = g_xreq_d[l_i].xreqorga        
               #   LET l_tmp.l_xreqorga_desc = g_xreq_d[l_i].xreq016_desc
               #   LET l_tmp.xreq007         = g_xreq_d[l_i].xreq007         
               #   LET l_tmp.l_xreq003_desc  = g_xreq_d[l_i].xreq003,":",s_desc_gzcbl004_desc('8348',g_xreq_d[l_i].xreq003)    #下拉要組             
               #   LET l_tmp.xreq006         = g_xreq_d[l_i].xreq006         
               #   LET l_tmp.xreq004         = g_xreq_d[l_i].xreq004         
               #   LET l_tmp.xreq005         = g_xreq_d[l_i].xreq005         
               #   LET l_tmp.xreq010         = g_xreq_d[l_i].xreq010         
               #   LET l_tmp.l_imaal003      = g_xreq_d[l_i].l_imaal003      
               #   LET l_tmp.l_imaal004      = g_xreq_d[l_i].l_imaal004      
               #   LET l_tmp.xreq009         = g_xreq_d[l_i].xreq009         
               #   LET l_tmp.l_xreq009_desc  = g_xreq_d[l_i].xreq009_desc  
               #   LET l_tmp.xreq008         = g_xreq_d[l_i].xreq008         
               #   LET l_tmp.l_xrca038       = g_xreq_d[l_i].l_xrca038       
               #   LET l_tmp.xreq012         = g_xreq_d[l_i].xreq012         
               #   LET l_tmp.l_xreq012_desc  = g_xreq_d[l_i].xreq012_desc  
               #   LET l_tmp.xreq100         = g_xreq_d[l_i].xreq100         
               #   LET l_tmp.xreq041         = g_xreq_d[l_i].xreq041         
               #   LET l_tmp.xreq103         = g_xreq_d[l_i].xreq103         
               #   LET l_tmp.l_xreq041103    = g_xreq_d[l_i].l_xreq041103    
               #   LET l_tmp.xreq042         = g_xreq_d[l_i].xreq042         
               #   LET l_tmp.xreq113         = g_xreq_d[l_i].xreq113         
               #   LET l_tmp.l_xreq042113    = g_xreq_d[l_i].l_xreq042113    
               #   LET l_tmp.xreq043         = g_xreq_d[l_i].xreq043         
               #   LET l_tmp.xreq123         = g_xreq_d[l_i].xreq123         
               #   LET l_tmp.l_xreq043123    = g_xreq_d[l_i].l_xreq043123    
               #   LET l_tmp.xreq044         = g_xreq_d[l_i].xreq044         
               #   LET l_tmp.xreq133         = g_xreq_d[l_i].xreq133         
               #   LET l_tmp.l_xreq044133    = g_xreq_d[l_i].l_xreq044133                      
               #   INSERT INTO axrq470_x01_tmp VALUES(l_tmp.*)
               #   
               #   #albireo 160129-----s
               #   LET l_sql = "SELECT  '','','',xrepdocdt, ",
               #               "        xreq003,'','','','',",
               #               "        '','','','',xreq008,",
               #               "        xrep004,",
               #               "        xreq013,(SELECT DISTINCT t132.glacl004 FROM glacl_t t132,glaa_t t131 WHERE t132.glaclent = xreqent AND t132.glacl002 = xreq013 AND t132.glacl003 = '"||g_dlang||"' AND t131.glaald = xreqld AND t131.glaaent = t132.glaclent) xreq013_desc,",
               #               "        xreq100,0,xreq103,0,0, ",
               #               "        xreq113,0,0, ",
               #               "        xreq123,0,0, ",
               #               "        xreq133,0,0 ",
               #               "  FROM xrep_t,xreq_t ",
               #               " WHERE xrepent = xreqent  ",
               #               "   AND xrepld  = xreqld ",
               #               "   AND xrepdocno = xreqdocno ",
               #               "   AND xrepent = ",g_enterprise," ",
               #               "   AND xrepstus <> 'X' ",
               #              #"   AND xreq003 IN ('2','4') ",        #151008-00009#9 mark
               #               "   AND xreq003 IN ('2','4','21') ",   #151008-00009#9 
               #               "   AND xrepsite = '",g_input.l_xrepsite,"' ",
               #               "   AND xrepld   = '",g_input.l_xrepld,"' ",
               #               "   AND xreq006 = '",g_xreq_d[l_i].xreq006,"' ",
               #               "   AND xreq004 = '",g_xreq_d[l_i].xreq004,"' ",
               #               "   AND xreq005 = ",g_xreq_d[l_i].xreq005," "
               #   #PREPARE sel_xreqxgp1 FROM l_sql                   #161123-00048#5 mark
               #   #DECLARE sel_xreqxgc1 CURSOR FOR sel_xreqxgp1      #161123-00048#5 mark
               #   #
               #   #FOREACH sel_xreqxgc1 INTO l_tmp.*                 #161123-00048#5 mark
               #   PREPARE sel_xreqxgp2 FROM l_sql                    #161123-00048#5 add
               #   DECLARE sel_xreqxgc2 CURSOR FOR sel_xreqxgp2       #161123-00048#5 add
               #   FOREACH sel_xreqxgc2 INTO l_tmp.*                  #161123-00048#5 add
               #      LET l_tmp.l_xreq003_desc  = l_tmp.l_xreq003_desc,":",s_desc_gzcbl004_desc('8348',l_tmp.l_xreq003_desc)    #下拉要組             
               #      IF SQLCA.SQLCODE THEN
               #         INITIALIZE g_errparam.* TO NULL
               #         #LET g_errparam.extend = 'FOREACH:sel_xreqxgc1' #161123-00048#5 mark
               #         LET g_errparam.extend = 'FOREACH:sel_xreqxgc2' #161123-00048#5 add
               #         LET g_errparam.code = SQLCA.SQLCODE
               #         CALL cl_err()
               #         EXIT FOREACH
               #      END IF
               #      INSERT INTO axrq470_x01_tmp VALUES(l_tmp.*)
               #   END FOREACH
               #   #albireo 160129-----e
               #END FOR
               #
               #CALL axrq470_x01(" 1=1","axrq470_x01_tmp" )   
               CALL axrq470_output()     #161221-00012#2 add
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq470_query()
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
            CALL axrq470_filter()
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
            CALL axrq470_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xreq_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               CALL g_export_node.clear()
               LET g_export_node[2] = base.typeInfo.create(g_xreq2_d)
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
            CALL axrq470_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq470_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq470_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq470_b_fill()
 
         
         
 
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
 
{<section id="axrq470.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq470_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_wc_l     STRING
   DEFINE l_dats     LIKE type_t.dat
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_yy       LIKE type_t.num5
   DEFINE l_mm       LIKE type_t.num5
   DEFINE l_date     LIKE type_t.dat
   DEFINE l_comp     LIKE ooef_t.ooef001
   DEFINE l_glaa004   LIKE glaa_t.glaa004
   DEFINE ls_wc1     STRING  #160811-00009#2
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   LET g_wc_filter_l = " 1=1"
   CALL axrq470_ld_set_visible('')
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xreq_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON xreqld,xreqdocno,xreqseq,xreqorga,xreq016,xreq007,xreq003,xreq006,xreq004, 
          xreq005,xreq010,xreq009,xreq008,xreq012,xreq100
           FROM s_detail1[1].b_xreqld,s_detail1[1].b_xreqdocno,s_detail1[1].b_xreqseq,s_detail1[1].b_xreqorga, 
               s_detail1[1].b_xreq016,s_detail1[1].b_xreq007,s_detail1[1].b_xreq003,s_detail1[1].b_xreq006, 
               s_detail1[1].b_xreq004,s_detail1[1].b_xreq005,s_detail1[1].b_xreq010,s_detail1[1].b_xreq009, 
               s_detail1[1].b_xreq008,s_detail1[1].b_xreq012,s_detail1[1].b_xreq100
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xreqld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreqld
            #add-point:BEFORE FIELD b_xreqld name="construct.b.page1.b_xreqld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreqld
            
            #add-point:AFTER FIELD b_xreqld name="construct.a.page1.b_xreqld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreqld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqld
            #add-point:ON ACTION controlp INFIELD b_xreqld name="construct.c.page1.b_xreqld"
            
            #END add-point
 
 
         #----<<b_xreqdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreqdocno
            #add-point:BEFORE FIELD b_xreqdocno name="construct.b.page1.b_xreqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreqdocno
            
            #add-point:AFTER FIELD b_xreqdocno name="construct.a.page1.b_xreqdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqdocno
            #add-point:ON ACTION controlp INFIELD b_xreqdocno name="construct.c.page1.b_xreqdocno"
            
            #END add-point
 
 
         #----<<b_xreqseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreqseq
            #add-point:BEFORE FIELD b_xreqseq name="construct.b.page1.b_xreqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreqseq
            
            #add-point:AFTER FIELD b_xreqseq name="construct.a.page1.b_xreqseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqseq
            #add-point:ON ACTION controlp INFIELD b_xreqseq name="construct.c.page1.b_xreqseq"
            
            #END add-point
 
 
         #----<<b_xreqorga>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreqorga
            #add-point:BEFORE FIELD b_xreqorga name="construct.b.page1.b_xreqorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreqorga
            
            #add-point:AFTER FIELD b_xreqorga name="construct.a.page1.b_xreqorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreqorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqorga
            #add-point:ON ACTION controlp INFIELD b_xreqorga name="construct.c.page1.b_xreqorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where    = "ooef001 IN ",g_wc_site, " AND ooef017 IN (SELECT glaacomp FROM glaa_t WHERE glaald = '",g_input.l_xrepld,"' AND glaaent = ",g_enterprise,") "
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00050#5 add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_xreqorga
            NEXT FIELD b_xreqorga
            #END add-point
 
 
         #----<<b_xreq016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq016
            #add-point:BEFORE FIELD b_xreq016 name="construct.b.page1.b_xreq016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq016
            
            #add-point:AFTER FIELD b_xreq016 name="construct.a.page1.b_xreq016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq016
            #add-point:ON ACTION controlp INFIELD b_xreq016 name="construct.c.page1.b_xreq016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = g_ctl_where," AND EXISTS   (SELECT 1 FROM pmab_t ",
                                                     "          WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                     "        ) AND (pmaa002='2' OR pmaa002='3')" #160731-00372#1   2016/08/16  By 07900 add AND (pmaa002='2' OR pmaa002='3')
            CALL q_pmaa001()                         
            DISPLAY g_qryparam.return1 TO b_xreq016  
            NEXT FIELD b_xreq016            
            #END add-point
 
 
         #----<<xreq016_desc>>----
         #----<<b_xreq007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq007
            #add-point:BEFORE FIELD b_xreq007 name="construct.b.page1.b_xreq007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq007
            
            #add-point:AFTER FIELD b_xreq007 name="construct.a.page1.b_xreq007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq007
            #add-point:ON ACTION controlp INFIELD b_xreq007 name="construct.c.page1.b_xreq007"
            
            #END add-point
 
 
         #----<<b_xreq003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq003
            #add-point:BEFORE FIELD b_xreq003 name="construct.b.page1.b_xreq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq003
            
            #add-point:AFTER FIELD b_xreq003 name="construct.a.page1.b_xreq003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq003
            #add-point:ON ACTION controlp INFIELD b_xreq003 name="construct.c.page1.b_xreq003"
            
            #END add-point
 
 
         #----<<b_xreq006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq006
            #add-point:BEFORE FIELD b_xreq006 name="construct.b.page1.b_xreq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq006
            
            #add-point:AFTER FIELD b_xreq006 name="construct.a.page1.b_xreq006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq006
            #add-point:ON ACTION controlp INFIELD b_xreq006 name="construct.c.page1.b_xreq006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = " xreqorga IN ",g_wc_site," ",
                                   " AND xreq003 IN ('1','3') ",
                                   " AND xrepld = '",g_input.l_xrepld,"' ",
                                   " AND xrepsite = '",g_input.l_xrepsite,"' ",
                                   " AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = xreqent AND pmaa001 = xreq016  )"
            CALL q_xreq006_1()                         
            DISPLAY g_qryparam.return1 TO b_xreq006
            NEXT FIELD b_xreq006
            #END add-point
 
 
         #----<<b_xreq004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq004
            #add-point:BEFORE FIELD b_xreq004 name="construct.b.page1.b_xreq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq004
            
            #add-point:AFTER FIELD b_xreq004 name="construct.a.page1.b_xreq004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq004
            #add-point:ON ACTION controlp INFIELD b_xreq004 name="construct.c.page1.b_xreq004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = " xreqorga IN ",g_wc_site," ",
                                   " AND xreq003 IN ('1','3') ",
                                   " AND xrepld = '",g_input.l_xrepld,"' ",
                                   " AND xrepsite = '",g_input.l_xrepsite,"' ",
                                   " AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = xreqent AND pmaa001 = xreq016  )"
            CALL q_xreq004_1()                         
            DISPLAY g_qryparam.return1 TO b_xreq004
            NEXT FIELD b_xreq004
            #END add-point
 
 
         #----<<b_xreq005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq005
            #add-point:BEFORE FIELD b_xreq005 name="construct.b.page1.b_xreq005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq005
            
            #add-point:AFTER FIELD b_xreq005 name="construct.a.page1.b_xreq005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq005
            #add-point:ON ACTION controlp INFIELD b_xreq005 name="construct.c.page1.b_xreq005"
            
            #END add-point
 
 
         #----<<b_xreq010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq010
            #add-point:BEFORE FIELD b_xreq010 name="construct.b.page1.b_xreq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq010
            
            #add-point:AFTER FIELD b_xreq010 name="construct.a.page1.b_xreq010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq010
            #add-point:ON ACTION controlp INFIELD b_xreq010 name="construct.c.page1.b_xreq010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#5 mark(s)
            #LET g_qryparam.arg1 = g_wc_site
            #CALL q_imaf001_23() 
            #161123-00048#5 mark(e)           
            #161123-00048#5-add(s)  
            SELECT glaacomp INTO g_comp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.l_xrepld
            LET g_qryparam.arg1 = g_comp
            CALL q_imaf001_21()
            #161123-00048#5-add(e)              
            DISPLAY g_qryparam.return1 TO b_xreq010
            NEXT FIELD b_xreq010
            #END add-point
 
 
         #----<<l_imaal003>>----
         #----<<l_imaal004>>----
         #----<<b_xreq009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq009
            #add-point:BEFORE FIELD b_xreq009 name="construct.b.page1.b_xreq009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq009
            
            #add-point:AFTER FIELD b_xreq009 name="construct.a.page1.b_xreq009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq009
            #add-point:ON ACTION controlp INFIELD b_xreq009 name="construct.c.page1.b_xreq009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '3116'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xreq009  #顯示到畫面上
            NEXT FIELD b_xreq009
            #END add-point
 
 
         #----<<xreq009_desc>>----
         #----<<b_xreq008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq008
            #add-point:BEFORE FIELD b_xreq008 name="construct.b.page1.b_xreq008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq008
            
            #add-point:AFTER FIELD b_xreq008 name="construct.a.page1.b_xreq008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq008
            #add-point:ON ACTION controlp INFIELD b_xreq008 name="construct.c.page1.b_xreq008"
            
            #END add-point
 
 
         #----<<l_xrca038>>----
         #----<<b_xreq012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq012
            #add-point:BEFORE FIELD b_xreq012 name="construct.b.page1.b_xreq012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq012
            
            #add-point:AFTER FIELD b_xreq012 name="construct.a.page1.b_xreq012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq012
            #add-point:ON ACTION controlp INFIELD b_xreq012 name="construct.c.page1.b_xreq012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_glaa004 = NULL
            SELECT glaa004 INTO l_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld 
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac001(會計科目參照表)/glac003(科目類型)
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ", #161123-00048#5-add
                                   "AND gladld='",g_input.l_xrepld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_xreq012
            NEXT FIELD b_xreq012
            #END add-point
 
 
         #----<<xreq012_desc>>----
         #----<<b_xreq100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreq100
            #add-point:BEFORE FIELD b_xreq100 name="construct.b.page1.b_xreq100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreq100
            
            #add-point:AFTER FIELD b_xreq100 name="construct.a.page1.b_xreq100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreq100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq100
            #add-point:ON ACTION controlp INFIELD b_xreq100 name="construct.c.page1.b_xreq100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaald = g_input.l_xrepld
               AND glaaent = g_enterprise
            LET g_qryparam.arg1 = l_comp
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO b_xreq100
            NEXT FIELD b_xreq100
            #END add-point
 
 
         #----<<b_xreq041>>----
         #----<<b_xreq103>>----
         #----<<l_xreq041103>>----
         #----<<b_xreq042>>----
         #----<<b_xreq113>>----
         #----<<l_xreq042113>>----
         #----<<b_xreq043>>----
         #----<<b_xreq123>>----
         #----<<l_xreq043123>>----
         #----<<b_xreq044>>----
         #----<<b_xreq133>>----
         #----<<l_xreq044133>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.l_xrepsite,g_input.l_xrepld
          ATTRIBUTE(WITHOUT DEFAULTS)
          
         AFTER FIELD l_xrepsite
            LET g_input.l_xrepsite_desc = ''
            IF NOT cl_null(g_input.l_xrepsite) THEN
               CALL s_fin_account_center_with_ld_chk(g_input.l_xrepsite,g_input.l_xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_xrepsite = ''
                  LET g_input.l_xrepld   = ''
                  LET g_input.l_xrepsite_desc = ''
                  LET g_input.l_xrepld_desc = ''
                  DISPLAY BY NAME g_input.l_xrepsite_desc,g_input.l_xrepsite,g_input.l_xrepld,g_input.l_xrepld_desc
                  NEXT FIELD CURRENT
               END IF
            END IF    
            #重新取得帳套範圍
            CALL s_fin_account_center_sons_query('3',g_input.l_xrepsite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
            CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
            CALL s_fin_account_center_sons_str() RETURNING g_wc_site
            CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
            CALL s_desc_get_department_desc(g_input.l_xrepsite) RETURNING g_input.l_xrepsite_desc
            DISPLAY BY NAME g_input.l_xrepsite_desc    
            CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_ctl_where #161123-00048#5-add            
          
         ###
         AFTER FIELD l_xrepld
            LET g_input.l_xrepld_desc   = ''
            IF NOT cl_null(g_input.l_xrepld) THEN
               CALL s_fin_account_center_with_ld_chk(g_input.l_xrepsite,g_input.l_xrepld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_xrepld = ''
                  LET g_input.l_xrepld_desc = ''
                  NEXT FIELD CURRENT
               END IF
               LET g_input.l_xrepld_desc   = s_desc_get_ld_desc(g_input.l_xrepld)
               DISPLAY BY NAME g_input.l_xrepld_desc
            END IF
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            #CALL s_control_get_customer_sql('2',l_comp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where            #161123-00048#5 mark
            CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_comp) RETURNING g_sub_success,g_ctl_where #161123-00048#5-add
         ###
          
         ON ACTION controlp INFIELD l_xrepld
            #160811-00009#2 add e---
            CALL s_fin_account_center_sons_query('3',g_input.l_xrepsite,g_today,'1') 
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc1  
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc1) RETURNING ls_wc1
            #160811-00009#2 add e---            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_input.l_xrepld                     #給予default值         #160811-00009#2 mark 
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_ld                                           #160811-00009#2 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc1,""   #160811-00009#2 add
            CALL q_authorised_ld()                                       #呼叫開窗
            LET g_input.l_xrepld = g_qryparam.return1                      #將開窗取得的值回傳到變數
            CALL s_desc_get_ld_desc(g_input.l_xrepld)  RETURNING g_input.l_xrepld_desc
            DISPLAY BY NAME g_input.l_xrepld,g_input.l_xrepld_desc
            NEXT FIELD l_xrepld
             
         ON ACTION controlp INFIELD l_xrepsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.l_xrepsite       #給予default值
            #CALL q_ooef001()                                  #161021-00050#5 mark
            CALL q_ooef001_46()                                #161021-00050#5            
            LET g_input.l_xrepsite = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_input.l_xrepsite) RETURNING g_input.l_xrepsite_desc
            DISPLAY BY NAME g_input.l_xrepsite,g_input.l_xrepsite_desc
            NEXT FIELD l_xrepsite                              #返回原欄位             
      END INPUT
      
      CONSTRUCT g_wc_l ON l_xrca038,l_xreq041103,l_xreq042113,l_xreq043123,l_xreq044133
                     FROM s_detail1[1].l_xrca038,s_detail1[1].l_xreq041103,s_detail1[1].l_xreq042113,
                          s_detail1[1].l_xreq043123,s_detail1[1].l_xreq044133
                          
         ON ACTION controlp INFIELD l_xrca038
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = " xrcald = '",g_input.l_xrepld,"' ",
                                   " AND xrcasite = '",g_input.l_xrepsite,"' ",
                                   " AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = xrcaent AND pmaa001 = xrca004  )"
            CALL q_xrca038()                           
            DISPLAY g_qryparam.return1 TO l_xrca038  
            NEXT FIELD l_xrca038
      END CONSTRUCT
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         LET g_xreq_d[1].xreqld = ''
         DISPLAY ARRAY g_xreq_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         CALL axrq470_qbe_clear()
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
         CALL axrq470_qbe_clear()
         INITIALIZE g_xreq_d[1].* TO NULL
         DISPLAY ARRAY g_xreq_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
   IF g_wc = " 1=1"  AND g_wc_l = " 1=1" THEN
      #取會計年期
      CALL s_fin_date_get_period_value('',g_input.l_xrepld,g_today)RETURNING g_sub_success,l_yy,l_mm
      
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_input.l_xrepld
    
      CALL s_fin_date_get_period_range(l_glaa003,l_yy,l_mm)
         RETURNING l_dats,l_date
      
      LET g_wc = "xreq007 BETWEEN '",l_dats,"' AND '",g_today,"' "
      LET g_wc_l = "l_xreq041103 > 0 "
   END IF
   
   LET g_wc = g_wc ," AND xrepstus <> 'X' "
   LET g_wc = g_wc ," AND xrepld = '",g_input.l_xrepld,"' AND xrepsite = '",g_input.l_xrepsite,"' "
   LET g_wc = g_wc ," AND xreq003 IN ('1','3') "
   #交易對象控制組-----s
   LET l_comp = NULL
   SELECT glaacomp INTO l_comp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_input.l_xrepld
   #CALL s_control_get_customer_sql('2',l_comp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where            #161123-00048#5 mark
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_comp) RETURNING g_sub_success,g_ctl_where #161123-00048#5-add   
   
   LET g_wc = g_wc CLIPPED," AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                            " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                            "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                            "   AND pmabsite = '",l_comp,"' ",
                                            "   AND pmaaent = xreqent AND pmaa001 = xreq016  )"
   #交易對象控制組-----e
   #end add-point
        
   LET g_error_show = 1
   CALL axrq470_b_fill()
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
 
{<section id="axrq470.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq470_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF NOT INT_FLAG THEN
      LET g_wc_filter_l = g_wc_filter_l, " "
      LET g_wc_filter_l_t = g_wc_filter_l
   ELSE
      LET g_wc_filter_l = g_wc_filter_l_t
   END IF
   
   IF cl_null(g_wc_filter_l)THEN
      LET g_wc_filter_l = " 1=1"
   END IF
   
   IF cl_null(g_wc_l)THEN
      LET g_wc_l = " 1=1"
   END IF
   
   CALL axrq470_ld_set_visible(g_input.l_xrepld)
   CALL axrq470_ld_set_no_visible(g_input.l_xrepld)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xreqld,xreqdocno,xreqseq,xreqorga,xreq016,'',xreq007,xreq003,xreq006, 
       xreq004,xreq005,xreq010,'','',xreq009,'',xreq008,'',xreq012,'',xreq100,xreq041,xreq103,'',xreq042, 
       xreq113,'',xreq043,xreq123,'',xreq044,xreq133,''  ,DENSE_RANK() OVER( ORDER BY xreq_t.xreqdocno, 
       xreq_t.xreqld,xreq_t.xreqseq) AS RANK FROM xreq_t",
 
 
                     "",
                     " WHERE xreqent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xreq_t"),
                     " ORDER BY xreq_t.xreqdocno,xreq_t.xreqld,xreq_t.xreqseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #效能調教SQL處  把SUBQUERY都組好-----s
   #除了效能調整因為某些是查組合好的後果 用g_wc_l 配上另一層SUBQUERY去做
   #跟原資料有關的用g_wc組(ls_wc)
   #跟查詢後資料有關的用g_wc_l組
   LET ls_sql_rank = "SELECT * FROM ",
                     " (SELECT UNIQUE xreqld,xreqdocno,xreqseq,xreqorga,",
                     "              xreq016,(SELECT t16.pmaal003 FROM pmaal_t t16 WHERE t16.pmaalent = xreqent AND t16.pmaal001 = xreq016 AND t16.pmaal002 = '"||g_dlang||"' ) xreq016_desc,",
                     "              xreq007,xreq003,",
                     "              xreq006,xreq004,xreq005,xreq010,",
                     "              (SELECT t101.imaal003 FROM imaal_t t101 WHERE t101.imaalent = xreqent AND t101.imaal001 = xreq010 AND t101.imaal002 = '"||g_dlang||"') imaal003,",
                     "              (SELECT t102.imaal004 FROM imaal_t t102 WHERE t102.imaalent = xreqent AND t102.imaal001 = xreq010 AND t102.imaal002 = '"||g_dlang||"') imaal004,",
                     "              xreq009,(SELECT t9.oocql004 FROM oocql_t t9 WHERE t9.oocqlent = xreqent AND t9.oocql001 = '3116' AND t9.oocql002 = xreq009 AND t9.oocql003 = '"||g_dlang||"') xreq009_desc,",
                     "              xreq008,(SELECT t38.xrca038 FROM xrca_t t38 WHERE t38.xrcaent = xreqent AND t38.xrcald = xreqld AND t38.xrcadocno = xreq006) l_xrca038, ",
                    #"              xreq012,(SELECT DISTINCT t122.glacl004 FROM glacl_t t122,glaa_t t121 WHERE t122.glaclent = xreqent AND t122.glacl002 = xreq012 AND t122.glacl003 = '"||g_dlang||"' AND t121.glaald = xreqld AND t121.glaaent = t122.glaclent ) xreq012_desc,",   #151008-00009#9 mark
                     "              xreq012,(SELECT DISTINCT t122.glacl004 FROM glacl_t t122,glaa_t t121 WHERE t122.glaclent = xreqent AND t122.glacl002 = xreq012 AND t122.glacl003 = '"||g_dlang||"' AND t121.glaald = xreqld AND t121.glaaent = t122.glaclent AND ROWNUM=1) xreq012_desc,",   #151008-00009#9 
                     "              xreq100,",
                     "              xreq041,xreq103,(xreq041-xreq103) l_xreq041103,",
                     "              xreq042,xreq113,(xreq042-xreq113) l_xreq042113,",
                     "              xreq043,xreq123,(xreq043-xreq123) l_xreq043123,",
                     "              xreq044,xreq133,(xreq044-xreq133) l_xreq044133 ",
                     "             ,DENSE_RANK() OVER( ORDER BY xreq_t.xreqdocno,xreq_t.xreqld,xreq_t.xreqseq) AS RANK ",
                     "  FROM xreq_t,xrep_t ",
                     " WHERE xreqent = xrepent AND xreqld = xrepld AND xreqdocno = xrepdocno ",
                     "   AND xreqent = ? AND 1=1 AND ",ls_wc 
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xreq_t"),
                     " ORDER BY xreq_t.xreqdocno,xreq_t.xreqld,xreq_t.xreqseq) ",
                     " WHERE ",g_wc_l CLIPPED," AND ",g_wc_filter_l CLIPPED                    
   #效能調教SQL處  把SUBQUERY都組好-----e
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
 
   LET g_sql = "SELECT xreqld,xreqdocno,xreqseq,xreqorga,xreq016,'',xreq007,xreq003,xreq006,xreq004, 
       xreq005,xreq010,'','',xreq009,'',xreq008,'',xreq012,'',xreq100,xreq041,xreq103,'',xreq042,xreq113, 
       '',xreq043,xreq123,'',xreq044,xreq133,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql       = "SELECT UNIQUE xreqld,xreqdocno,xreqseq,xreqorga,",
                     "              xreq016,xreq016_desc,",
                     "              xreq007,xreq003,",
                     "              xreq006,xreq004,xreq005,xreq010,",
                     "              imaal003,",
                     "              imaal004,",
                     "              xreq009, xreq009_desc,",
                     "              xreq008, l_xrca038, ",
                     "              xreq012, xreq012_desc,",
                     "              xreq100,",
                     "              xreq041,xreq103,l_xreq041103,",
                     "              xreq042,xreq113,l_xreq042113,",
                     "              xreq043,xreq123,l_xreq043123,",
                     "              xreq044,xreq133,l_xreq044133 ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq470_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq470_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xreq_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_xreq2_d.clear()    #160218 albireo add
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xreq_d[l_ac].xreqld,g_xreq_d[l_ac].xreqdocno,g_xreq_d[l_ac].xreqseq,g_xreq_d[l_ac].xreqorga, 
       g_xreq_d[l_ac].xreq016,g_xreq_d[l_ac].xreq016_desc,g_xreq_d[l_ac].xreq007,g_xreq_d[l_ac].xreq003, 
       g_xreq_d[l_ac].xreq006,g_xreq_d[l_ac].xreq004,g_xreq_d[l_ac].xreq005,g_xreq_d[l_ac].xreq010,g_xreq_d[l_ac].l_imaal003, 
       g_xreq_d[l_ac].l_imaal004,g_xreq_d[l_ac].xreq009,g_xreq_d[l_ac].xreq009_desc,g_xreq_d[l_ac].xreq008, 
       g_xreq_d[l_ac].l_xrca038,g_xreq_d[l_ac].xreq012,g_xreq_d[l_ac].xreq012_desc,g_xreq_d[l_ac].xreq100, 
       g_xreq_d[l_ac].xreq041,g_xreq_d[l_ac].xreq103,g_xreq_d[l_ac].l_xreq041103,g_xreq_d[l_ac].xreq042, 
       g_xreq_d[l_ac].xreq113,g_xreq_d[l_ac].l_xreq042113,g_xreq_d[l_ac].xreq043,g_xreq_d[l_ac].xreq123, 
       g_xreq_d[l_ac].l_xreq043123,g_xreq_d[l_ac].xreq044,g_xreq_d[l_ac].xreq133,g_xreq_d[l_ac].l_xreq044133 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xreq_d[l_ac].statepic = cl_get_actipic(g_xreq_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axrq470_detail_show("'1'")      
 
      CALL axrq470_xreq_t_mask()
 
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
   
 
   
   CALL g_xreq_d.deleteElement(g_xreq_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL axrq470_b_fill2(1)
   #end add-point
 
   LET g_detail_cnt = g_xreq_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq470_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq470_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq470_detail_action_trans()
 
   IF g_xreq_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq470_fetch()
   END IF
   
      CALL axrq470_filter_show('xreqld','b_xreqld')
   CALL axrq470_filter_show('xreqdocno','b_xreqdocno')
   CALL axrq470_filter_show('xreqseq','b_xreqseq')
   CALL axrq470_filter_show('xreqorga','b_xreqorga')
   CALL axrq470_filter_show('xreq016','b_xreq016')
   CALL axrq470_filter_show('xreq007','b_xreq007')
   CALL axrq470_filter_show('xreq003','b_xreq003')
   CALL axrq470_filter_show('xreq006','b_xreq006')
   CALL axrq470_filter_show('xreq004','b_xreq004')
   CALL axrq470_filter_show('xreq005','b_xreq005')
   CALL axrq470_filter_show('xreq010','b_xreq010')
   CALL axrq470_filter_show('xreq009','b_xreq009')
   CALL axrq470_filter_show('xreq008','b_xreq008')
   CALL axrq470_filter_show('xreq012','b_xreq012')
   CALL axrq470_filter_show('xreq100','b_xreq100')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq470.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq470_fetch()
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
 
{<section id="axrq470.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq470_detail_show(ps_page)
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
 
{<section id="axrq470.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq470_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_comp   LIKE ooef_t.ooef001
   DEFINE l_glaa004   LIKE glaa_t.glaa004
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
      CONSTRUCT g_wc_filter ON xreqld,xreqdocno,xreqseq,xreqorga,xreq016,xreq007,xreq003,xreq006,xreq004, 
          xreq005,xreq010,xreq009,xreq008,xreq012,xreq100
                          FROM s_detail1[1].b_xreqld,s_detail1[1].b_xreqdocno,s_detail1[1].b_xreqseq, 
                              s_detail1[1].b_xreqorga,s_detail1[1].b_xreq016,s_detail1[1].b_xreq007, 
                              s_detail1[1].b_xreq003,s_detail1[1].b_xreq006,s_detail1[1].b_xreq004,s_detail1[1].b_xreq005, 
                              s_detail1[1].b_xreq010,s_detail1[1].b_xreq009,s_detail1[1].b_xreq008,s_detail1[1].b_xreq012, 
                              s_detail1[1].b_xreq100
 
         BEFORE CONSTRUCT
                     DISPLAY axrq470_filter_parser('xreqld') TO s_detail1[1].b_xreqld
            DISPLAY axrq470_filter_parser('xreqdocno') TO s_detail1[1].b_xreqdocno
            DISPLAY axrq470_filter_parser('xreqseq') TO s_detail1[1].b_xreqseq
            DISPLAY axrq470_filter_parser('xreqorga') TO s_detail1[1].b_xreqorga
            DISPLAY axrq470_filter_parser('xreq016') TO s_detail1[1].b_xreq016
            DISPLAY axrq470_filter_parser('xreq007') TO s_detail1[1].b_xreq007
            DISPLAY axrq470_filter_parser('xreq003') TO s_detail1[1].b_xreq003
            DISPLAY axrq470_filter_parser('xreq006') TO s_detail1[1].b_xreq006
            DISPLAY axrq470_filter_parser('xreq004') TO s_detail1[1].b_xreq004
            DISPLAY axrq470_filter_parser('xreq005') TO s_detail1[1].b_xreq005
            DISPLAY axrq470_filter_parser('xreq010') TO s_detail1[1].b_xreq010
            DISPLAY axrq470_filter_parser('xreq009') TO s_detail1[1].b_xreq009
            DISPLAY axrq470_filter_parser('xreq008') TO s_detail1[1].b_xreq008
            DISPLAY axrq470_filter_parser('xreq012') TO s_detail1[1].b_xreq012
            DISPLAY axrq470_filter_parser('xreq100') TO s_detail1[1].b_xreq100
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xreqld>>----
         #Ctrlp:construct.c.filter.page1.b_xreqld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqld
            #add-point:ON ACTION controlp INFIELD b_xreqld name="construct.c.filter.page1.b_xreqld"
            
            #END add-point
 
 
         #----<<b_xreqdocno>>----
         #Ctrlp:construct.c.filter.page1.b_xreqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqdocno
            #add-point:ON ACTION controlp INFIELD b_xreqdocno name="construct.c.filter.page1.b_xreqdocno"
            
            #END add-point
 
 
         #----<<b_xreqseq>>----
         #Ctrlp:construct.c.filter.page1.b_xreqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqseq
            #add-point:ON ACTION controlp INFIELD b_xreqseq name="construct.c.filter.page1.b_xreqseq"
            
            #END add-point
 
 
         #----<<b_xreqorga>>----
         #Ctrlp:construct.c.filter.page1.b_xreqorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreqorga
            #add-point:ON ACTION controlp INFIELD b_xreqorga name="construct.c.filter.page1.b_xreqorga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where    = "ooef001 IN ",g_wc_site, " AND ooef017 IN (SELECT glaacomp FROM glaa_t WHERE glaald = '",g_input.l_xrepld,"' AND glaaent = ",g_enterprise,") "
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00050#5 add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_xreqorga
            NEXT FIELD b_xreqorga
            #END add-point
 
 
         #----<<b_xreq016>>----
         #Ctrlp:construct.c.filter.page1.b_xreq016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq016
            #add-point:ON ACTION controlp INFIELD b_xreq016 name="construct.c.filter.page1.b_xreq016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = g_ctl_where," AND EXISTS   (SELECT 1 FROM pmab_t ",
                                                     "          WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                     "        ) AND (pmaa002='2' OR pmaa002='3') " #160731-00372#1   2016/08/16  By 07900 add AND (pmaa002='2' OR pmaa002='3')
            CALL q_pmaa001()                         
            DISPLAY g_qryparam.return1 TO b_xreq016  
            NEXT FIELD b_xreq016     
            #END add-point
 
 
         #----<<xreq016_desc>>----
         #----<<b_xreq007>>----
         #Ctrlp:construct.c.filter.page1.b_xreq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq007
            #add-point:ON ACTION controlp INFIELD b_xreq007 name="construct.c.filter.page1.b_xreq007"
            
            #END add-point
 
 
         #----<<b_xreq003>>----
         #Ctrlp:construct.c.filter.page1.b_xreq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq003
            #add-point:ON ACTION controlp INFIELD b_xreq003 name="construct.c.filter.page1.b_xreq003"
            
            #END add-point
 
 
         #----<<b_xreq006>>----
         #Ctrlp:construct.c.filter.page1.b_xreq006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq006
            #add-point:ON ACTION controlp INFIELD b_xreq006 name="construct.c.filter.page1.b_xreq006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = " xreqorga IN ",g_wc_site," ",
                                   " AND xreq003 IN ('1','3') ",
                                   " AND xrepld = '",g_input.l_xrepld,"' ",
                                   " AND xrepsite = '",g_input.l_xrepsite,"' ",
                                   " AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = xreqent AND pmaa001 = xreq016  )"
            CALL q_xreq006_1()                         
            DISPLAY g_qryparam.return1 TO b_xreq006
            NEXT FIELD b_xreq006
            #END add-point
 
 
         #----<<b_xreq004>>----
         #Ctrlp:construct.c.filter.page1.b_xreq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq004
            #add-point:ON ACTION controlp INFIELD b_xreq004 name="construct.c.filter.page1.b_xreq004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = " xreqorga IN ",g_wc_site," ",
                                   " AND xreq003 IN ('1','3') ",
                                   " AND xrepld = '",g_input.l_xrepld,"' ",
                                   " AND xrepsite = '",g_input.l_xrepsite,"' ",
                                   " AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = xreqent AND pmaa001 = xreq016  )"
            CALL q_xreq004_1()                         
            DISPLAY g_qryparam.return1 TO b_xreq004
            NEXT FIELD b_xreq004
            #END add-point
 
 
         #----<<b_xreq005>>----
         #Ctrlp:construct.c.filter.page1.b_xreq005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq005
            #add-point:ON ACTION controlp INFIELD b_xreq005 name="construct.c.filter.page1.b_xreq005"
            
            #END add-point
 
 
         #----<<b_xreq010>>----
         #Ctrlp:construct.c.filter.page1.b_xreq010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq010
            #add-point:ON ACTION controlp INFIELD b_xreq010 name="construct.c.filter.page1.b_xreq010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_wc_site   #161123-00048#5 mark
            #CALL q_imaf001_23()               #161123-00048#5 mark
            #161123-00048#5-add(s)  
            SELECT glaacomp INTO g_comp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.l_xrepld
            LET g_qryparam.arg1 = g_comp
            CALL q_imaf001_21()
            #161123-00048#5-add(e)            
            DISPLAY g_qryparam.return1 TO b_xreq010
            NEXT FIELD b_xreq010
            #END add-point
 
 
         #----<<l_imaal003>>----
         #----<<l_imaal004>>----
         #----<<b_xreq009>>----
         #Ctrlp:construct.c.filter.page1.b_xreq009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq009
            #add-point:ON ACTION controlp INFIELD b_xreq009 name="construct.c.filter.page1.b_xreq009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '3116'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xreq009  #顯示到畫面上
            NEXT FIELD b_xreq009
            #END add-point
 
 
         #----<<xreq009_desc>>----
         #----<<b_xreq008>>----
         #Ctrlp:construct.c.filter.page1.b_xreq008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq008
            #add-point:ON ACTION controlp INFIELD b_xreq008 name="construct.c.filter.page1.b_xreq008"
            
            #END add-point
 
 
         #----<<l_xrca038>>----
         #----<<b_xreq012>>----
         #Ctrlp:construct.c.filter.page1.b_xreq012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq012
            #add-point:ON ACTION controlp INFIELD b_xreq012 name="construct.c.filter.page1.b_xreq012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_glaa004 = NULL
            SELECT glaa004 INTO l_glaa004 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld 
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' " , #glac001(會計科目參照表)/glac003(科目類型)
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ", #161123-00048#5-add
                                   "AND gladld='",g_input.l_xrepld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_xreq012
            NEXT FIELD b_xreq012
            #END add-point
 
 
         #----<<xreq012_desc>>----
         #----<<b_xreq100>>----
         #Ctrlp:construct.c.filter.page1.b_xreq100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreq100
            #add-point:ON ACTION controlp INFIELD b_xreq100 name="construct.c.filter.page1.b_xreq100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaald = g_input.l_xrepld
               AND glaaent = g_enterprise
            LET g_qryparam.arg1 = l_comp
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO b_xreq100
            NEXT FIELD b_xreq100
            #END add-point
 
 
         #----<<b_xreq041>>----
         #----<<b_xreq103>>----
         #----<<l_xreq041103>>----
         #----<<b_xreq042>>----
         #----<<b_xreq113>>----
         #----<<l_xreq042113>>----
         #----<<b_xreq043>>----
         #----<<b_xreq123>>----
         #----<<l_xreq043123>>----
         #----<<b_xreq044>>----
         #----<<b_xreq133>>----
         #----<<l_xreq044133>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      CONSTRUCT g_wc_filter_l ON l_xrca038,l_xreq041103,l_xreq042113,l_xreq043123,l_xreq044133
                     FROM s_detail1[1].l_xrca038,s_detail1[1].l_xreq041103,s_detail1[1].l_xreq042113,
                          s_detail1[1].l_xreq043123,s_detail1[1].l_xreq044133
         ON ACTION controlp INFIELD l_xrca038
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_comp = NULL
            SELECT glaacomp INTO l_comp FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_xrepld
            LET g_qryparam.where = " xrcald = '",g_input.l_xrepld,"' ",
                                   " AND xrcasite = '",g_input.l_xrepsite,"' ",
                                   " AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = xrcaent AND pmaa001 = xrca004  )"
            CALL q_xrca038()                           
            DISPLAY g_qryparam.return1 TO l_xrca038
            NEXT FIELD l_xrca038            
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         CALL cl_qbe_init()
         #LET g_xreq_d[1].xreqld = ''
         INITIALIZE g_xreq_d[1].* TO NULL
         DISPLAY ARRAY g_xreq_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         LET g_wc_l_t = g_wc_l
         LET g_wc_filter_l_t = g_wc_filter_l
         LET g_wc_l = cl_replace_str(g_wc_l, g_wc_filter_l, '')
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
   
      CALL axrq470_filter_show('xreqld','b_xreqld')
   CALL axrq470_filter_show('xreqdocno','b_xreqdocno')
   CALL axrq470_filter_show('xreqseq','b_xreqseq')
   CALL axrq470_filter_show('xreqorga','b_xreqorga')
   CALL axrq470_filter_show('xreq016','b_xreq016')
   CALL axrq470_filter_show('xreq007','b_xreq007')
   CALL axrq470_filter_show('xreq003','b_xreq003')
   CALL axrq470_filter_show('xreq006','b_xreq006')
   CALL axrq470_filter_show('xreq004','b_xreq004')
   CALL axrq470_filter_show('xreq005','b_xreq005')
   CALL axrq470_filter_show('xreq010','b_xreq010')
   CALL axrq470_filter_show('xreq009','b_xreq009')
   CALL axrq470_filter_show('xreq008','b_xreq008')
   CALL axrq470_filter_show('xreq012','b_xreq012')
   CALL axrq470_filter_show('xreq100','b_xreq100')
 
    
   CALL axrq470_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq470.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq470_filter_parser(ps_field)
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
 
{<section id="axrq470.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq470_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq470_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq470.insert" >}
#+ insert
PRIVATE FUNCTION axrq470_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq470.modify" >}
#+ modify
PRIVATE FUNCTION axrq470_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq470.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq470_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq470.delete" >}
#+ delete
PRIVATE FUNCTION axrq470_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq470.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq470_detail_action_trans()
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
 
{<section id="axrq470.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq470_detail_index_setting()
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
            IF g_xreq_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xreq_d.getLength() AND g_xreq_d.getLength() > 0
            LET g_detail_idx = g_xreq_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xreq_d.getLength() THEN
               LET g_detail_idx = g_xreq_d.getLength()
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
 
{<section id="axrq470.mask_functions" >}
 &include "erp/axr/axrq470_mask.4gl"
 
{</section>}
 
{<section id="axrq470.other_function" readonly="Y" >}

PRIVATE FUNCTION axrq470_b_fill2(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   DEFINE l_sql  STRING
   DEFINE l_idx  LIKE type_t.num10

   IF cl_null(p_ac) OR p_ac <=0 THEN RETURN END IF
   CALL g_xreq2_d.clear()    #160218 albireo add
   LET l_sql = "SELECT xreq008,xreq011,xreq103,xreq101,xreq113,",
               "       xreq013,(SELECT DISTINCT t132.glacl004 FROM glacl_t t132,glaa_t t131 WHERE t132.glaclent = xreqent AND t132.glacl002 = xreq013 AND t132.glacl003 = '"||g_dlang||"' AND t131.glaald = xreqld AND t131.glaaent = t132.glaclent) xreq013_desc,",
               "       xrep004 ",
               "  FROM xrep_t,xreq_t ",
               " WHERE xrepent = xreqent  ",
               "   AND xrepld  = xreqld ",
               "   AND xrepdocno = xreqdocno ",
               "   AND xrepent = ",g_enterprise," ",
               "   AND xrepstus <> 'X' ",
              #"   AND xreq003 IN ('2','4') ",        #151008-00009#9 mark
               "   AND xreq003 IN ('2','4','21') ",   #151008-00009#9
              
               "   AND xrepsite = '",g_input.l_xrepsite,"' ",
               "   AND xrepld   = '",g_input.l_xrepld,"' ",
               #151008-00009#9 mod--s
               #"   AND xreq006 = '",g_xreq_d[p_ac].xreq006,"' ",               
               #"   AND xreq004 = '",g_xreq_d[p_ac].xreq004,"' ",
               #"   AND xreq005 = ",g_xreq_d[p_ac].xreq005," "
               "   AND ((xreq004 = '",g_xreq_d[p_ac].xreq004,"' AND xreq005 = ",g_xreq_d[p_ac].xreq005,") OR ",
               "        (xreq014 = '",g_xreq_d[p_ac].xreq004,"' AND xreq015 = ",g_xreq_d[p_ac].xreq005,"))"               
               #151008-00009#9 mod--e
   PREPARE sel_xreqp1 FROM l_sql
   DECLARE sel_xreqc1 CURSOR FOR sel_xreqp1

   LET l_idx = 1
   
   FOREACH sel_xreqc1 INTO g_xreq2_d[l_idx].*
      IF SQLCA.SQLCODE THEN 
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = 'FOREACH:sel_xreqc1'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_idx = l_idx + 1
   END FOREACH
  
   LET g_detail_cnt2 = l_idx - 1
END FUNCTION

PRIVATE FUNCTION axrq470_qbe_clear()
   DEFINE l_comp   LIKE ooef_t.ooef001
   INITIALIZE g_input.* TO NULL
   CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_input.l_xrepsite,g_input.l_xrepld,l_comp
   CALL s_desc_get_department_desc(g_input.l_xrepsite) RETURNING g_input.l_xrepsite_desc
   CALL s_desc_get_ld_desc(g_input.l_xrepld)  RETURNING g_input.l_xrepld_desc
   DISPLAY BY NAME g_input.l_xrepld,g_input.l_xrepld_desc,g_input.l_xrepsite,g_input.l_xrepsite_desc
   
   CALL s_fin_account_center_sons_query('3',g_input.l_xrepsite,g_today,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_site
   CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
   CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
   CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
   
   LET l_comp = NULL
   SELECT glaacomp INTO l_comp FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_input.l_xrepld
   #CALL s_control_get_customer_sql('2',l_comp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where            #161123-00048#5 mark
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_comp) RETURNING g_sub_success,g_ctl_where #161123-00048#5-add
END FUNCTION

PRIVATE FUNCTION axrq470_create_xg_tmp()
   DROP TABLE axrq470_x01_tmp;
   CREATE TEMP TABLE axrq470_x01_tmp(
      xreq016         LIKE xreq_t.xreq016,
      xreqorga        LIKE xreq_t.xreqorga,
      l_xreqorga_desc LIKE type_t.chr200,
      xreq007         LIKE xreq_t.xreq007,
      l_xreq003_desc  LIKE type_t.chr200,
      xreq006         LIKE xreq_t.xreq006,
      xreq004         LIKE xreq_t.xreq004,
      xreq005         LIKE xreq_t.xreq005,
      xreq010         LIKE xreq_t.xreq010,
      l_imaal003      LIKE type_t.chr200,
      l_imaal004      LIKE type_t.chr200,
      xreq009         LIKE xreq_t.xreq009,
      l_xreq009_desc  LIKE type_t.chr200,
      xreq008         LIKE xreq_t.xreq008,
      l_xrca038       LIKE type_t.chr200,
      xreq012         LIKE xreq_t.xreq012,
      l_xreq012_desc  LIKE type_t.chr200,
      xreq100         LIKE xreq_t.xreq100,
      xreq041         LIKE xreq_t.xreq041,
      xreq103         LIKE xreq_t.xreq103,
      l_xreq041103    LIKE type_t.num20_6,
      xreq042         LIKE xreq_t.xreq042,
      xreq113         LIKE xreq_t.xreq113,
      l_xreq042113    LIKE type_t.num20_6,
      xreq043         LIKE xreq_t.xreq043,
      xreq123         LIKE xreq_t.xreq123,
      l_xreq043123    LIKE type_t.num20_6,
      xreq044         LIKE xreq_t.xreq044,
      xreq133         LIKE xreq_t.xreq133,
      l_xreq044133    LIKE type_t.num20_6
      )   
END FUNCTION

PRIVATE FUNCTION axrq470_ld_set_no_visible(p_ld)
   DEFINE p_ld   LIKE glaa_t.glaald
   DEFINE l_glaa015 LIKE glaa_t.glaa015
   DEFINE l_glaa019 LIKE glaa_t.glaa019
   
   LET l_glaa015 = NULL LET l_glaa019 = NULL
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_ld
   
   IF l_glaa015 = 'N' THEN
      CALL cl_set_comp_visible('b_xreq043,b_xreq123,l_xreq043123',FALSE)
   END IF
   
   IF l_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('b_xreq044,b_xreq133,l_xreq044133',FALSE)
   END IF   
END FUNCTION

PRIVATE FUNCTION axrq470_ld_set_visible(p_ld)
   DEFINE p_ld   LIKE glaa_t.glaald
   CALL cl_set_comp_visible('b_xreq043,b_xreq123,l_xreq043123',TRUE)
   CALL cl_set_comp_visible('b_xreq044,b_xreq133,l_xreq044133',TRUE)
END FUNCTION

################################################################################
# Descriptions...: 設計器現已改調規範，
#                  會將「列印(output)」段add-pointn內容複製至quickprint段對應內容， 
#                  故原來的程式碼放至新增的共同列印處理function中，
#                  在output段改成call function名
# Memo...........: #161221-00012#2
# Usage..........: CALL axrq470_output()
#                  RETURNING 無
# Input parameter: 無
# Return code....: 無
# Date & Author..: 201612/21 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq470_output()
DEFINE l_tmp      RECORD
   xreq016         LIKE xreq_t.xreq016,
   xreqorga        LIKE xreq_t.xreqorga,
   l_xreqorga_desc LIKE type_t.chr200,
   xreq007         LIKE xreq_t.xreq007,
   l_xreq003_desc  LIKE type_t.chr200,
   xreq006         LIKE xreq_t.xreq006,
   xreq004         LIKE xreq_t.xreq004,
   xreq005         LIKE xreq_t.xreq005,
   xreq010         LIKE xreq_t.xreq010,
   l_imaal003      LIKE type_t.chr200,
   l_imaal004      LIKE type_t.chr200,
   xreq009         LIKE xreq_t.xreq009,
   l_xreq009_desc  LIKE type_t.chr200,
   xreq008         LIKE xreq_t.xreq008,
   l_xrca038       LIKE type_t.chr200,
   xreq012         LIKE xreq_t.xreq012,
   l_xreq012_desc  LIKE type_t.chr200,
   xreq100         LIKE xreq_t.xreq100,
   xreq041         LIKE xreq_t.xreq041,
   xreq103         LIKE xreq_t.xreq103,
   l_xreq041103    LIKE type_t.num20_6,
   xreq042         LIKE xreq_t.xreq042,
   xreq113         LIKE xreq_t.xreq113,
   l_xreq042113    LIKE type_t.num20_6,
   xreq043         LIKE xreq_t.xreq043,
   xreq123         LIKE xreq_t.xreq123,
   l_xreq043123    LIKE type_t.num20_6,
   xreq044         LIKE xreq_t.xreq044,
   xreq133         LIKE xreq_t.xreq133,
   l_xreq044133    LIKE type_t.num20_6
                  END RECORD
DEFINE l_sql      STRING
DEFINE l_i        LIKE type_t.num10

DEFINE l_glaa015  LIKE glaa_t.glaa015
DEFINE l_glaa019  LIKE glaa_t.glaa019

   LET g_xg_vis = NULL
   LET l_glaa015 = NULL LET l_glaa019 = NULL
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_input.l_xrepld
   
   IF l_glaa015 = 'N' THEN 
      LET g_xg_vis ="xreq043|xreq123|l_xreq043123"             
   END IF
   IF l_glaa019 = 'N' THEN 
      IF NOT cl_null(g_xg_vis)THEN
         LET g_xg_vis = g_xg_vis CLIPPED,"|"
      END IF
      LET g_xg_vis = g_xg_vis CLIPPED ,"xreq044|xreq133|l_xreq044133"
   END IF
    
   DELETE FROM axrq470_x01_tmp
    
   FOR l_i = 1 TO g_xreq_d.getLength()
      IF cl_null(g_xreq_d[l_i].xreqorga)THEN CONTINUE FOR END IF 
      INITIALIZE l_tmp.* TO NULL
      LET l_tmp.xreq016         = g_xreq_d[l_i].xreq016         
      LET l_tmp.xreqorga        = g_xreq_d[l_i].xreqorga        
      LET l_tmp.l_xreqorga_desc = g_xreq_d[l_i].xreq016_desc
      LET l_tmp.xreq007         = g_xreq_d[l_i].xreq007         
      LET l_tmp.l_xreq003_desc  = g_xreq_d[l_i].xreq003,":",s_desc_gzcbl004_desc('8348',g_xreq_d[l_i].xreq003)    #下拉要組             
      LET l_tmp.xreq006         = g_xreq_d[l_i].xreq006         
      LET l_tmp.xreq004         = g_xreq_d[l_i].xreq004         
      LET l_tmp.xreq005         = g_xreq_d[l_i].xreq005         
      LET l_tmp.xreq010         = g_xreq_d[l_i].xreq010         
      LET l_tmp.l_imaal003      = g_xreq_d[l_i].l_imaal003      
      LET l_tmp.l_imaal004      = g_xreq_d[l_i].l_imaal004      
      LET l_tmp.xreq009         = g_xreq_d[l_i].xreq009         
      LET l_tmp.l_xreq009_desc  = g_xreq_d[l_i].xreq009_desc  
      LET l_tmp.xreq008         = g_xreq_d[l_i].xreq008         
      LET l_tmp.l_xrca038       = g_xreq_d[l_i].l_xrca038       
      LET l_tmp.xreq012         = g_xreq_d[l_i].xreq012         
      LET l_tmp.l_xreq012_desc  = g_xreq_d[l_i].xreq012_desc  
      LET l_tmp.xreq100         = g_xreq_d[l_i].xreq100         
      LET l_tmp.xreq041         = g_xreq_d[l_i].xreq041         
      LET l_tmp.xreq103         = g_xreq_d[l_i].xreq103         
      LET l_tmp.l_xreq041103    = g_xreq_d[l_i].l_xreq041103    
      LET l_tmp.xreq042         = g_xreq_d[l_i].xreq042         
      LET l_tmp.xreq113         = g_xreq_d[l_i].xreq113         
      LET l_tmp.l_xreq042113    = g_xreq_d[l_i].l_xreq042113    
      LET l_tmp.xreq043         = g_xreq_d[l_i].xreq043         
      LET l_tmp.xreq123         = g_xreq_d[l_i].xreq123         
      LET l_tmp.l_xreq043123    = g_xreq_d[l_i].l_xreq043123    
      LET l_tmp.xreq044         = g_xreq_d[l_i].xreq044         
      LET l_tmp.xreq133         = g_xreq_d[l_i].xreq133         
      LET l_tmp.l_xreq044133    = g_xreq_d[l_i].l_xreq044133                      
      INSERT INTO axrq470_x01_tmp VALUES(l_tmp.*)
      
      LET l_sql = "SELECT  '','','',xrepdocdt, ",
                  "        xreq003,'','','','',",
                  "        '','','','',xreq008,",
                  "        xrep004,",
                  "        xreq013,(SELECT DISTINCT t132.glacl004 FROM glacl_t t132,glaa_t t131 WHERE t132.glaclent = xreqent AND t132.glacl002 = xreq013 AND t132.glacl003 = '"||g_dlang||"' AND t131.glaald = xreqld AND t131.glaaent = t132.glaclent) xreq013_desc,",
                  "        xreq100,0,xreq103,0,0, ",
                  "        xreq113,0,0, ",
                  "        xreq123,0,0, ",
                  "        xreq133,0,0 ",
                  "  FROM xrep_t,xreq_t ",
                  " WHERE xrepent = xreqent  ",
                  "   AND xrepld  = xreqld ",
                  "   AND xrepdocno = xreqdocno ",
                  "   AND xrepent = ",g_enterprise," ",
                  "   AND xrepstus <> 'X' ",
                  "   AND xreq003 IN ('2','4','21') ",
                  "   AND xrepsite = '",g_input.l_xrepsite,"' ",
                  "   AND xrepld   = '",g_input.l_xrepld,"' ",
                  "   AND xreq006 = '",g_xreq_d[l_i].xreq006,"' ",
                  "   AND xreq004 = '",g_xreq_d[l_i].xreq004,"' ",
                  "   AND xreq005 = ",g_xreq_d[l_i].xreq005," "
      PREPARE sel_xreqxgp1 FROM l_sql
      DECLARE sel_xreqxgc1 CURSOR FOR sel_xreqxgp1
      
      FOREACH sel_xreqxgc1 INTO l_tmp.*
         LET l_tmp.l_xreq003_desc  = l_tmp.l_xreq003_desc,":",s_desc_gzcbl004_desc('8348',l_tmp.l_xreq003_desc)    #下拉要組             
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.extend = 'FOREACH:sel_xreqxgc1'
            LET g_errparam.code = SQLCA.SQLCODE
            CALL cl_err()
            EXIT FOREACH
         END IF
         INSERT INTO axrq470_x01_tmp VALUES(l_tmp.*)
      END FOREACH
   END FOR
    
   CALL axrq470_x01(" 1=1","axrq470_x01_tmp" ) 
END FUNCTION

 
{</section>}
 
