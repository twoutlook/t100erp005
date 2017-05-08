#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq330.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-10 15:50:16), PR版次:0003(2016-11-22 10:42:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: afaq330
#+ Description: 資產擔保明細查詢
#+ Creator....: 02114(2016-04-10 15:50:16)
#+ Modifier...: 02114 -SD/PR- 06189
 
{</section>}
 
{<section id="afaq330.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#161006-00005#22  2016/10/24  By 06137    組織類型與職能開窗清單需測試及調整開窗內容
#161111-00028#6   2016/11/21  by 06189    标准程式定义采用宣告模式,弃用.*写
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
       edit_1 LIKE type_t.chr500, 
   fabasite LIKE type_t.chr10, 
   fabasite_desc LIKE type_t.chr80, 
   fabacomp LIKE type_t.chr10, 
   fabacomp_desc LIKE type_t.chr80, 
   glaa001 LIKE type_t.chr10, 
   sdate LIKE type_t.dat, 
   sy LIKE type_t.num5, 
   sm LIKE type_t.num5, 
   edate LIKE type_t.dat, 
   ey LIKE type_t.num5, 
   em LIKE type_t.num5
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   fabzdocno LIKE fabz_t.fabzdocno, 
   fabzseq LIKE fabz_t.fabzseq, 
   faby001 LIKE faby_t.faby001, 
   fabz001 LIKE fabz_t.fabz001, 
   fabz002 LIKE fabz_t.fabz002, 
   fabz003 LIKE fabz_t.fabz003, 
   fabz004 LIKE fabz_t.fabz004, 
   fabz005 LIKE fabz_t.fabz005, 
   fabz006 LIKE fabz_t.fabz006, 
   fabz007 LIKE fabz_t.fabz007, 
   fabz008 LIKE fabz_t.fabz008, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faaj016 LIKE faaj_t.faaj016, 
   fabz009 LIKE fabz_t.fabz009, 
   fabz009_desc LIKE type_t.chr500, 
   fabz010 LIKE fabz_t.fabz010, 
   fabz011 LIKE fabz_t.fabz011
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_glaa                RECORD LIKE glaa_t.*   #mark by geza 20161122 #161111-00028#6
#add by geza 20161122 #161111-00028#6(S)
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企业编号
       glaaownid LIKE glaa_t.glaaownid, #资料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
       glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
       glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
       glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
       glaamodid LIKE glaa_t.glaamodid, #资料更改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
       glaastus LIKE glaa_t.glaastus, #状态码
       glaald LIKE glaa_t.glaald, #账套编号
       glaacomp LIKE glaa_t.glaacomp, #归属法人
       glaa001 LIKE glaa_t.glaa001, #使用币种
       glaa002 LIKE glaa_t.glaa002, #汇率参照表号
       glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
       glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
       glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
       glaa006 LIKE glaa_t.glaa006, #月结方式
       glaa007 LIKE glaa_t.glaa007, #年结方式
       glaa008 LIKE glaa_t.glaa008, #平行记账否
       glaa009 LIKE glaa_t.glaa009, #凭证登录方式
       glaa010 LIKE glaa_t.glaa010, #现行年度
       glaa011 LIKE glaa_t.glaa011, #现行期别
       glaa012 LIKE glaa_t.glaa012, #最后过账日期
       glaa013 LIKE glaa_t.glaa013, #关账日期
       glaa014 LIKE glaa_t.glaa014, #主账套
       glaa015 LIKE glaa_t.glaa015, #启用本位币二
       glaa016 LIKE glaa_t.glaa016, #本位币二
       glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
       glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
       glaa019 LIKE glaa_t.glaa019, #启用本位币三
       glaa020 LIKE glaa_t.glaa020, #本位币三
       glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
       glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
       glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
       glaa024 LIKE glaa_t.glaa024, #单据别参照表号
       glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
       glaa026 LIKE glaa_t.glaa026, #币种参照表号
       glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
       glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
       glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
       glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
       glaa111 LIKE glaa_t.glaa111, #应计调整单别
       glaa112 LIKE glaa_t.glaa112, #期末结转单别
       glaa113 LIKE glaa_t.glaa113, #年底结转单别
       glaa120 LIKE glaa_t.glaa120, #成本计算类型
       glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
       glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
       glaa027 LIKE glaa_t.glaa027, #单据据点编号
       glaa130 LIKE glaa_t.glaa130, #合并账套否
       glaa131 LIKE glaa_t.glaa131, #分层合并
       glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
       glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
       glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
       glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
       glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
       glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
       glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
       glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
       glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
       glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
       glaa028 LIKE glaa_t.glaa028  #汇率来源
END RECORD
#add by geza 20161122 #161111-00028#6(E)
DEFINE g_fabasite_t          LIKE faba_t.fabasite
DEFINE g_fabacomp_t          LIKE faba_t.fabacomp
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
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
 
{<section id="afaq330.main" >}
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
   CALL cl_ap_init("afa","")
 
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
   DECLARE afaq330_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq330_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq330_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq330 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq330_init()   
 
      #進入選單 Menu (="N")
      CALL afaq330_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq330
      
   END IF 
   
   CLOSE afaq330_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq330.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afaq330_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp() 
   #end add-point
 
   CALL afaq330_default_search()
END FUNCTION
 
{</section>}
 
{<section id="afaq330.default_search" >}
PRIVATE FUNCTION afaq330_default_search()
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
 
{<section id="afaq330.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afaq330_ui_dialog() 
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_origin_str          STRING   #組織範圍 
   DEFINE  l_flag1               LIKE type_t.chr1
   DEFINE  l_errno               LIKE type_t.chr100
   DEFINE  l_glav002             LIKE glav_t.glav002
   DEFINE  l_glav005             LIKE glav_t.glav005
   DEFINE  l_sdate_s             LIKE glav_t.glav004
   DEFINE  l_sdate_e             LIKE glav_t.glav004
   DEFINE  l_glav006             LIKE glav_t.glav006
   DEFINE  l_glav007             LIKE glav_t.glav007
   DEFINE  l_pdate_s             LIKE glav_t.glav004
   DEFINE  l_pdate_e             LIKE glav_t.glav004
   DEFINE  l_wdate_s             LIKE glav_t.glav004
   DEFINE  l_wdate_e             LIKE glav_t.glav004
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
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL afaq330_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
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
 
         CALL afaq330_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.fabasite,g_master.fabasite_desc,g_master.fabacomp,g_master.fabacomp_desc,
                       g_master.glaa001,g_master.sdate,g_master.sy,g_master.sm,
                       g_master.edate,g_master.ey,g_master.em
         
            BEFORE INPUT 
               
            
            AFTER FIELD fabasite
               IF NOT cl_null(g_master.fabasite) THEN 
                  CALL s_afa_site_chk(g_master.fabasite,g_fabasite_t,g_master.fabacomp,g_glaa.glaald,g_today)
                  RETURNING l_success,g_master.fabacomp,g_glaa.glaald
                  
                  IF l_success = FALSE THEN 
                     LET g_master.fabasite = g_fabasite_t
                     LET g_master.fabacomp = g_fabacomp_t
                     CALL s_desc_get_department_desc(g_master.fabasite) RETURNING g_master.fabasite_desc
                     CALL s_desc_get_department_desc(g_master.fabacomp) RETURNING g_master.fabacomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_fin_account_center_sons_query('5',g_master.fabasite,g_today,'1')
               LET g_fabasite_t = g_master.fabasite
               LET g_fabacomp_t = g_master.fabacomp
               CALL s_desc_get_department_desc(g_master.fabasite) RETURNING g_master.fabasite_desc
               CALL s_desc_get_department_desc(g_master.fabacomp) RETURNING g_master.fabacomp_desc
               CALL afaq330_get_glaa()
               LET g_master.glaa001 = g_glaa.glaa001
               DISPLAY g_master.glaa001 TO glaa001
            
            AFTER FIELD fabacomp
               IF NOT cl_null(g_master.fabacomp) THEN 
                  CALL s_afa_comp_chk(g_master.fabasite,g_master.fabacomp)
                  RETURNING l_success,g_glaa.glaald
                  
                  IF l_success = FALSE THEN 
                     LET g_master.fabacomp = g_fabacomp_t
                     CALL s_desc_get_department_desc(g_master.fabacomp) RETURNING g_master.fabacomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_fabacomp_t = g_master.fabacomp
               CALL s_desc_get_department_desc(g_master.fabacomp) RETURNING g_master.fabacomp_desc
               CALL afaq330_get_glaa()
               LET g_master.glaa001 = g_glaa.glaa001
               DISPLAY g_master.glaa001 TO glaa001
            
            AFTER FIELD sdate
               IF NOT cl_null(g_master.sdate) AND NOT cl_null(g_master.edate) THEN 
                  IF g_master.sdate > g_master.edate THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.sdate = ''
                     LET g_master.sy = ''
                     LET g_master.sm = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_get_accdate(g_glaa.glaa003,g_master.sdate,'','') 
               RETURNING l_flag1,l_errno,g_master.sy,l_glav005,l_sdate_s,l_sdate_e,
                         g_master.sm,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               DISPLAY g_master.sy,g_master.sm TO sy,sm
               
            AFTER FIELD edate
               IF NOT cl_null(g_master.sdate) AND NOT cl_null(g_master.edate) THEN 
                  IF g_master.edate < g_master.sdate THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.edate = ''
                     LET g_master.ey = ''
                     LET g_master.em = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_get_accdate(g_glaa.glaa003,g_master.edate,'','') 
               RETURNING l_flag1,l_errno,g_master.ey,l_glav005,l_sdate_s,l_sdate_e,
                         g_master.em,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               DISPLAY g_master.ey,g_master.em TO ey,em
            
            ON ACTION controlp INFIELD fabasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_master.fabasite             #給予default值
               LET g_qryparam.where = " ooef207 = 'Y'"
               #給予arg
               LET g_qryparam.arg1 = "" #
               
               
               #CALL q_ooef001()        #161006-00005#22 Mark By Ken 161024                        #呼叫開窗
               CALL q_ooef001_47()      #161006-00005#22 Add By Ken 161024
               
               LET g_master.fabasite = g_qryparam.return1              
               
               DISPLAY g_master.fabasite TO fabasite              #
               CALL s_desc_get_department_desc(g_master.fabasite) RETURNING g_master.fabasite_desc
               NEXT FIELD fabasite                          #返回原欄位
               
            ON ACTION controlp INFIELD fabacomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_master.fabacomp             #給予default值
               CALL s_fin_account_center_sons_query('5',g_master.fabasite,g_today,'')
               CALL s_fin_account_center_comp_str()RETURNING l_origin_str
               CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
               #LET g_qryparam.where    = "ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,")" #161006-00005#22 Mark By Ken 161024  
               LET g_qryparam.where    = "ooef003 = 'Y' AND ooef001 IN ",l_origin_str CLIPPED      #161006-00005#22 Add By Ken 161024  
               #給予arg
               LET g_qryparam.arg1 = "" #
               
               
               #CALL q_ooef001()       #161006-00005#22 Mark By Ken 161024                         #呼叫開窗
               CALL q_ooef001_2()      #161006-00005#22 Add By Ken 161024
               
               LET g_master.fabacomp = g_qryparam.return1              
               DISPLAY g_master.fabacomp TO fabacomp              #
               CALL s_desc_get_department_desc(g_master.fabacomp) RETURNING g_master.fabacomp_desc
               NEXT FIELD fabacomp                          #返回原欄位
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afaq330_detail_action_trans()
               LET g_master_idx = l_ac
               CALL afaq330_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL afaq330_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL afaq330_default()
            #end add-point
            NEXT FIELD fabasite
 
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
            IF g_wc = " 1=2 " THEN 
               LET g_wc = " 1=1 " 
            END IF
            CALL afaq330_b_fill()
            #end add-point
 
            CALL afaq330_cs()
 
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
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq330_fetch('F')
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
            CALL afaq330_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq330_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq330_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq330_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq330_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq330_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL afaq330_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL afaq330_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL afaq330_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL afaq330_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
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
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         ON ACTION modify_detail
            IF NOT cl_null(g_detail[l_ac].fabzdocno) AND NOT cl_null(g_detail[l_ac].fabzseq) THEN 
               LET la_param.prog = 'afat492'
               LET la_param.param[1] = g_detail[l_ac].fabzdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
            END IF
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            CALL afaq330_default()
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="afaq330.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION afaq330_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   RETURN
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE afaq330_pre FROM g_sql
   DECLARE afaq330_curs SCROLL CURSOR WITH HOLD FOR afaq330_pre
   OPEN afaq330_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE afaq330_precount FROM g_cnt_sql
   EXECUTE afaq330_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL afaq330_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="afaq330.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION afaq330_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
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
      DISPLAY g_master.* TO edit_1,fabasite,fabasite_desc,fabacomp,fabacomp_desc,glaa001,sdate,sy,sm, 
          edate,ey,em
      CALL g_detail.clear()
 
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
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL afaq330_show()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq330.show" >}
PRIVATE FUNCTION afaq330_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO edit_1,fabasite,fabasite_desc,fabacomp,fabacomp_desc,glaa001,sdate,sy,sm,edate, 
       ey,em
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL afaq330_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq330_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_wc = " 1=2 " THEN 
      RETURN
   END IF
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL afaq330_create_tmp()
   CALL afaq330_ins_tmp()
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   LET ls_sql_rank = "SELECT * FROM afaq330_tmp ",
                     " ORDER BY fabzdocno,fabzseq,fabz001 "
                     
   #end add-point
 
   LET g_sql = "SELECT COUNT(*) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre INTO g_tot_cnt
   FREE b_fill_cnt_pre
   
   IF g_tot_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
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
   
   LET g_sql = "SELECT * FROM (",ls_sql_rank,")"
                
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq330_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq330_pb
   
   OPEN b_fill_curs
   
   FOREACH b_fill_curs INTO g_detail[l_ac].* 
                            

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      IF NOT cl_null(g_detail[l_ac].faby001) THEN 
         LET g_detail[l_ac].fabzdocno = ''
         LET g_detail[l_ac].fabzseq = ''
      END IF
 
      CALL afaq330_detail_show("'1'")      
 
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
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq330_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq330_detail_action_trans()
 
   CALL afaq330_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="afaq330.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq330_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq330.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq330_detail_show(ps_page)
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
 
{<section id="afaq330.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION afaq330_maintain_prog()
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
 
{<section id="afaq330.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq330_detail_action_trans()
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
 
{<section id="afaq330.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq330_detail_index_setting()
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
 
{<section id="afaq330.mask_functions" >}
 &include "erp/afa/afaq330_mask.4gl"
 
{</section>}
 
{<section id="afaq330.other_function" readonly="Y" >}
# 獲取agli010的資料
PRIVATE FUNCTION afaq330_get_glaa()
   INITIALIZE g_glaa.* TO NULL
   #SELECT * #mark by geza 20161122 #161111-00028#6
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,
          glaacrtdp,glaacrtdt,glaamodid,glaamoddt,
          glaastus,glaald,glaacomp,
          glaa001,glaa002,glaa003,glaa004,glaa005,
          glaa006,glaa007,glaa008,glaa009,glaa010,
          glaa011,glaa012,glaa013,glaa014,glaa015,
          glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022,glaa023,glaa024,glaa025,
          glaa026,glaa100,glaa101,glaa102,glaa103,
          glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,
          glaa133,glaa134,glaa135,glaa136,glaa137,
          glaa138,glaa139,glaa140,glaa123,glaa124,
          glaa028 #add by geza 20161122 #161111-00028#6
     INTO g_glaa.* 
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_master.fabacomp
      AND glaa014 = 'Y'
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION afaq330_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE afaq330_tmp;
   CREATE TEMP TABLE afaq330_tmp (
      sel             VARCHAR(1), 
      fabzdocno       VARCHAR(20), 
      fabzseq         INTEGER, 
      faby001         INTEGER, 
      fabz001         VARCHAR(10), 
      fabz002         DATE, 
      fabz003         DATE, 
      fabz004         VARCHAR(20), 
      fabz005         VARCHAR(20), 
      fabz006         VARCHAR(10), 
      fabz007         VARCHAR(40), 
      fabz008         VARCHAR(40), 
      faah006         VARCHAR(10), 
      faah006_desc    VARCHAR(500), 
      faaj016         DECIMAL(20,6), 
      fabz009         VARCHAR(10), 
      fabz009_desc    VARCHAR(500), 
      fabz010         DECIMAL(20,10), 
      fabz011         DECIMAL(20,6)
      ); 
END FUNCTION
# 插入臨時表
PRIVATE FUNCTION afaq330_ins_tmp()
   DEFINE l_sql            STRING
   DEFINE l_faaj016        LIKE faaj_t.faaj016
   DEFINE l_tmp            RECORD
                           sel            LIKE type_t.chr1, 
                           fabzdocno      LIKE fabz_t.fabzdocno, 
                           fabzseq        LIKE fabz_t.fabzseq, 
                           faby001        LIKE faby_t.faby001, 
                           fabz001        LIKE fabz_t.fabz001, 
                           fabz002        LIKE fabz_t.fabz002, 
                           fabz003        LIKE fabz_t.fabz003, 
                           fabz004        LIKE fabz_t.fabz004, 
                           fabz005        LIKE fabz_t.fabz005, 
                           fabz006        LIKE fabz_t.fabz006, 
                           fabz007        LIKE fabz_t.fabz007, 
                           fabz008        LIKE fabz_t.fabz008, 
                           faah006        LIKE faah_t.faah006, 
                           faah006_desc   LIKE type_t.chr500, 
                           faaj016        LIKE faaj_t.faaj016, 
                           fabz009        LIKE fabz_t.fabz009, 
                           fabz009_desc   LIKE type_t.chr500, 
                           fabz010        LIKE fabz_t.fabz010, 
                           fabz011        LIKE fabz_t.fabz011
                           END RECORD
   
   LET l_sql = "SELECT '',fabzdocno,fabzseq,'',fabz001,fabz002,fabz003,fabz004,fabz005,fabz006,fabz007,fabz008, ",
               "          '','','',fabz009,'',fabz010,fabz011",
               "  FROM faba_t,fabz_t ",
               " WHERE fabaent = ",g_enterprise,
               "   AND fabaent = fabzent ",
               "   AND fabadocno = fabzdocno ",
               "   AND fabastus = 'Y' ",
               "   AND fabasite = '",g_master.fabasite,"'",
               "   AND fabacomp = '",g_master.fabacomp,"'"
               
    IF NOT cl_null(g_master.sdate) THEN 
       LET l_sql = l_sql," AND fabadocdt >= '",g_master.sdate,"'"
    END IF
    
    IF NOT cl_null(g_master.edate) THEN 
       LET l_sql = l_sql," AND fabadocdt <= '",g_master.edate,"'"
    END IF
               
    PREPARE afaq330_tmp_pre FROM l_sql
    DECLARE afaq330_tmp_cs CURSOR FOR afaq330_tmp_pre
    
    LET l_sql = "SELECT '',fabydocno,fabyseq,faby001,'','','',",
                "       faby002,faby003,faby004,faby005,faby006,'','','', ",
                "       '','','','' ",
                "  FROM fabz_t,faby_t ",
                " WHERE fabyent = ",g_enterprise,
                "   AND fabzent = fabyent ",
                "   AND fabzdocno = fabydocno ",
                "   AND fabzseq = fabyseq ",
                "   AND fabzdocno = ? ",
                "   AND fabzseq = ? "
    PREPARE afaq330_tmp_pre1 FROM l_sql
    DECLARE afaq330_tmp_cs1 CURSOR FOR afaq330_tmp_pre1
    
    FOREACH afaq330_tmp_cs INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
       
          EXIT FOREACH
       END IF
       
       SELECT faah006 INTO l_tmp.faah006
         FROM faah_t
        WHERE faahent = g_enterprise
          AND faah003 = l_tmp.fabz004
          AND faah004 = l_tmp.fabz005
          AND faah001 = l_tmp.fabz006
       
       IF NOT cl_null(l_tmp.faah006) THEN 
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_tmp.faah006
          CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET l_tmp.faah006_desc = '', g_rtn_fields[1] , ''
       END IF
       
       SELECT faaj016-faaj017-faaj021 INTO l_tmp.faaj016
         FROM faaj_t
        WHERE faajent = g_enterprise
          AND faajld = g_glaa.glaald
          AND faaj001 = l_tmp.fabz004
          AND faaj002 = l_tmp.fabz005
          AND faaj037 = l_tmp.fabz006
          
       IF cl_null(l_tmp.faaj016) THEN LET l_tmp.faaj016 = 0 END IF
          
       IF NOT cl_null(l_tmp.fabz009) THEN    
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_tmp.fabz009
          CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET l_tmp.fabz009_desc = '', g_rtn_fields[1] , ''
       END IF

       INSERT INTO afaq330_tmp VALUES(l_tmp.*)
   
       IF l_tmp.fabz004 = 'MISC' THEN 
          FOREACH afaq330_tmp_cs1 USING l_tmp.fabzdocno,l_tmp.fabzseq INTO l_tmp.*
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "FOREACH:" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
             
                EXIT FOREACH
             END IF
             
             SELECT faah006 INTO l_tmp.faah006
               FROM faah_t
              WHERE faahent = g_enterprise
                AND faah003 = l_tmp.fabz004
                AND faah004 = l_tmp.fabz005
                AND faah001 = l_tmp.fabz006
             
             INITIALIZE g_ref_fields TO NULL
             LET g_ref_fields[1] = l_tmp.faah006
             CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
             LET l_tmp.faah006_desc = '', g_rtn_fields[1] , ''
             
             SELECT faaj016-faaj017-faaj021 INTO l_tmp.faaj016
               FROM faaj_t
              WHERE faajent = g_enterprise
                AND faajld = g_glaa.glaald
                AND faaj001 = l_tmp.fabz004
                AND faaj002 = l_tmp.fabz005
                AND faaj037 = l_tmp.fabz006
                
             IF cl_null(l_tmp.faaj016) THEN LET l_tmp.faaj016 = 0 END IF
          
             INSERT INTO afaq330_tmp VALUES(l_tmp.*)
          END FOREACH
       END IF 
       
       SELECT SUM(faaj016) INTO l_faaj016
         FROM afaq330_tmp
        WHERE fabzdocno = l_tmp.fabzdocno
          AND fabzseq = l_tmp.fabzseq  
          AND fabz004 <> 'MISC'      
       IF cl_null(l_faaj016) THEN 
          LET l_faaj016 = 0
       END IF
       
       UPDATE afaq330_tmp SET faaj016 = l_faaj016
        WHERE fabzdocno = l_tmp.fabzdocno
          AND fabzseq = l_tmp.fabzseq  
          AND fabz004 = 'MISC'    
      
    END FOREACH 
END FUNCTION
# 默認值
PRIVATE FUNCTION afaq330_default()
   INITIALIZE g_master.* TO NULL
   CALL g_detail.clear()
   
   #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING g_sub_success,g_master.fabasite,g_errno
   CALL s_desc_get_department_desc(g_master.fabasite) RETURNING g_master.fabasite_desc
   DISPLAY g_master.fabasite_desc TO fabasite_desc
   
   #所屬法人
   SELECT ooef017 INTO g_master.fabacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.fabasite
      AND ooefstus = 'Y'  
   CALL s_desc_get_department_desc(g_master.fabacomp) RETURNING g_master.fabacomp_desc
   DISPLAY g_master.fabacomp_desc TO fabacomp_desc
   
   LET g_fabasite_t = g_master.fabasite
   LET g_fabacomp_t = g_master.fabacomp
   
   CALL afaq330_get_glaa()
   LET g_master.glaa001 = g_glaa.glaa001
   DISPLAY g_master.glaa001 TO glaa001
END FUNCTION

 
{</section>}
 
