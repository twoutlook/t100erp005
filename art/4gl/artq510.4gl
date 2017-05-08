#該程式未解開Section, 採用最新樣板產出!
{<section id="artq510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-06-14 19:27:59), PR版次:0006(2016-10-27 17:00:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000080
#+ Filename...: artq510
#+ Description: 門店商品條碼價籤查詢列印作業
#+ Creator....: 06189(2015-06-17 10:00:41)
#+ Modifier...: 07142 -SD/PR- 08742
 
{</section>}
 
{<section id="artq510.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#9   2016/10/26  by 08742    组织开窗调整 
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
PRIVATE TYPE type_g_rtdx_d RECORD
       
       sel LIKE type_t.chr500, 
   seq LIKE type_t.chr500, 
   count LIKE type_t.chr500, 
   check LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaf153 LIKE imaf_t.imaf153, 
   imaf153_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_desc LIKE type_t.chr500, 
   rtdx001_desc_1 LIKE type_t.chr500, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   imaa126 LIKE imaa_t.imaa126, 
   imaa126_desc LIKE type_t.chr500, 
   rtdx058 LIKE rtdx_t.rtdx058, 
   rtdx059 LIKE rtdx_t.rtdx059, 
   rtdx060 LIKE rtdx_t.rtdx060, 
   rtdx012 LIKE rtdx_t.rtdx012, 
   rtdx056 LIKE rtdx_t.rtdx056, 
   rtdx057 LIKE rtdx_t.rtdx057, 
   imaa105 LIKE imaa_t.imaa105, 
   imaa105_desc LIKE type_t.chr500, 
   rtdx016 LIKE rtdx_t.rtdx016, 
   rtdx017 LIKE rtdx_t.rtdx017, 
   rtdx018 LIKE rtdx_t.rtdx018, 
   rtdx019 LIKE rtdx_t.rtdx019, 
   rtdx023 LIKE rtdx_t.rtdx023, 
   rtdx022 LIKE rtdx_t.rtdx022, 
   rtdx020 LIKE rtdx_t.rtdx020, 
   rtdx021 LIKE rtdx_t.rtdx021, 
   rtdx038 LIKE rtdx_t.rtdx038, 
   rtdx039 LIKE rtdx_t.rtdx039, 
   rtdx040 LIKE rtdx_t.rtdx040, 
   rtdx034 LIKE rtdx_t.rtdx034
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rtdy001            LIKE rtdy_t.rtdy001 
DEFINE g_rtdy001_desc      LIKE type_t.chr500
DEFINE g_rtdxsite           LIKE rtdx_t.rtdxsite
DEFINE g_rtdxsite_desc      LIKE type_t.chr500
define g_name               varchar(40)
DEFINE g_checkbox           LIKE type_t.chr1
DEFINE g_checkbox_2         LIKE type_t.chr1
DEFINE g_combobox_1         LIKE type_t.chr10
DEFINE g_number        LIKE type_t.num10  
#DEFINE g_cust_rec   RECORD
#               id               STRING,
#               template         STRING,
#               data                     DYNAMIC ARRAY OF RECORD
#                rowid     LIKE          type_t.num5,           #项次
#                count     LIKE          type_t.chr500,         #打印数量
#                inna01    LIKE          rtdx_t.rtdx002,        #商品条码
#                inna02    LIKE          rtdx_t.rtdx001,        #商品编号
#                inna03    LIKE          type_t.chr500,         #品名
#                inna04    LIKE          type_t.chr500,         #规格 
#                inna05    LIKE          imaa_t.imaa009,        #商品品类
#                inna06    LIKE          type_t.chr500,         #品类说明                             
#                inna07    LIKE          imaa_t.imaa126,        #品牌
#                inna08    LIKE          type_t.chr500,         #品牌说明                
#                inna09    LIKE          rtdx_t.rtdx012,        #产地
#                inna10    LIKE          imaa_t.imaa105,        #销售单位
#                inna11    LIKE          rtdx_t.rtdx016,        #售价
#                inna12    LIKE          rtdx_t.rtdx017,        #门店会员价1
#                inna13    LIKE          rtdx_t.rtdx018,        #门店会员价2
#                inna14    LIKE          rtdx_t.rtdx019,        #门店会员价3
#                inna15    LIKE          rtdx_t.rtdx022,        #促销售价开始日期
#                inna16    LIKE          rtdx_t.rtdx023,        #促销售价结束日期
#                inna17    LIKE          rtdx_t.rtdx020,        #促销原价
#                inna18    LIKE          rtdx_t.rtdx021,        #促销售价
#                inna19    LIKE          rtdx_t.rtdx038,        #促销会员价1
#                inna20    LIKE          rtdx_t.rtdx039,        #促销会员价2
#                inna21    LIKE          rtdx_t.rtdx040,        #促销会员价3
#                inna22    LIKE          rtdx_t.rtdx034,         #执行价
#                inna23    LIKE          stba_t.stbaownid      #打印人员
#                    END RECORD
#               END RECORD
DEFINE g_cust_rec   RECORD
               id               STRING,
               template         STRING,
               data                     DYNAMIC ARRAY OF RECORD
                rowid     LIKE          type_t.num5,           #项次
                count     LIKE          type_t.chr500,         #打印数量
                inna01    LIKE          rtdx_t.rtdx002,        #商品条码
                inna02    LIKE          rtdx_t.rtdx001,        #商品编号
                inna03    LIKE          type_t.chr500,         #品名
                inna04    LIKE          type_t.chr500,         #规格 
                inna05    LIKE          imaa_t.imaa009,        #商品品类
                inna06    LIKE          type_t.chr500,         #品类说明                             
                inna07    LIKE          imaa_t.imaa126,        #品牌
                inna08    LIKE          type_t.chr500,         #品牌说明                               
                inna09    LIKE          rtdx_t.rtdx012,        #产地
                inna10    LIKE          imaa_t.imaa105,        #销售单位                
                inna11                  STRING,                #售价
                inna12                  STRING,                #门店会员价1
                inna13                  STRING,                #门店会员价2
                inna14                  STRING,                #门店会员价3
                inna15    LIKE          rtdx_t.rtdx022,        #促销售价开始日期
                inna16    LIKE          rtdx_t.rtdx023,        #促销售价结束日期
                inna17                  STRING,                #促销原价
                inna18                  STRING,                #促销售价
                inna19                  STRING,                #促销会员价1
                inna20                  STRING,                #促销会员价2
                inna21                  STRING,                #促销会员价3
                inna22                  STRING,                #执行价
                inna23    LIKE          stba_t.stbaownid,       #打印人员
                inna27    LIKE          type_t.chr500,        #销售单位说明
                inna36    like          rtdx_t.rtdx058,        #等级
                inna37    LIKE          rtdx_t.rtdx059,       #颜色
                inna38    LIKE          rtdx_t.rtdx060,        #型号
                inna39    LIKE          rtdx_t.rtdx056,       #颜色
                inna40    LIKE          rtdx_t.rtdx057,        #型号
                inna41    string 
                    END RECORD
               END RECORD
DEFINE g_rtdx_d_colour DYNAMIC ARRAY OF RECORD       
   sel STRING, 
   seq STRING, 
   count STRING, 
   check STRING, 
   rtdx002 STRING, 
   imaf153 STRING,        #add  by 06529 15/07/19
   imaf153_desc STRING,   #add  by 06529 15/07/19
   rtdx001 STRING, 
   rtdx001_desc STRING, 
   rtdx001_desc_1 STRING, 
   imaa009 STRING, 
   imaa009_desc STRING, 
   imaa126 STRING, 
   imaa126_desc STRING,
   rtdx058 STRING, 
   rtdx059 STRING, 
   rtdx060 STRING,  
   rtdx012 STRING,
   rtdx056 string, 
   rtdx057 string,   
   imaa105 STRING, 
   imaa105_desc STRING, 
   rtdx016 STRING, 
   rtdx017 STRING, 
   rtdx018 STRING, 
   rtdx019 STRING, 
   rtdx023 STRING, 
   rtdx022 STRING, 
   rtdx020 STRING, 
   rtdx021 STRING, 
   rtdx038 STRING, 
   rtdx039 STRING, 
   rtdx040 STRING, 
   rtdx034 STRING
       END RECORD               
DEFINE g_wc3                  STRING 
DEFINE g_str        LIKE type_t.chr50
DEFINE g_insert             LIKE type_t.chr5 
DEFINE g_aw                  STRING 
DEFINE g_checkbox_3         LIKE type_t.chr1   #add by geza 20150826
DEFINE g_bfill_count        LIKE type_t.num10  #160126-00002#3 s983961--add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtdx_d            DYNAMIC ARRAY OF type_g_rtdx_d
DEFINE g_rtdx_d_t          type_g_rtdx_d
 
 
 
 
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

#end add-point
 
{</section>}
 
{<section id="artq510.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success      LIKE type_t.num5   #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
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
   DECLARE artq510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artq510_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artq510_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artq510 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artq510_init()   
 
      #進入選單 Menu (="N")
      CALL artq510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artq510
      
   END IF 
   
   CLOSE artq510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artq510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artq510_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 #add by geza 20160302
   DEFINE l_success      LIKE type_t.num5   #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('imaa108','2002','1,3,4') 
   CALL cl_set_combo_scc('combobox_1','6825')
   CALL cl_set_combo_scc('b_check','6825')
   CALL cl_set_toolbaritem_visible("show",FALSE)   
   LET g_bfill_count = 0  #160126-00002#3 s983961--add
   #add by geza 20160302(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','7') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx017",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','8') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx018",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','9') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx019",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','4') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx038",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','5') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx039",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','6') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx040",l_gzcbl004)
   #add by geza 20160302(E) 
   CALL s_aooi500_create_temp() RETURNING l_success   #161024-00025#9   2016/10/26  by 08742    组织开窗调整 
   
   #end add-point
 
   CALL artq510_default_search()
END FUNCTION
 
{</section>}
 
{<section id="artq510.default_search" >}
PRIVATE FUNCTION artq510_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtdxsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtdx001 = '", g_argv[02], "' AND "
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
 
{<section id="artq510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artq510_ui_dialog() 
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
   DEFINE l_cnt         LIKE type_t.num10 
   #160126-00002#3 s983961--add(s)
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE type_t.chr10
   DEFINE l_i           LIKE type_t.num10
   DEFINE ls_sql        STRING
   DEFINE r_insert      LIKE type_t.num5
   #160126-00002#3 s983961--add(e)
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
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
   #LET g_wc2 = '1 = 2' #160126-00002#3 s983961--mark
   #160126-00002#3 s983961--add(s)
   #LET g_tot_cnt = g_rtdx_d.getLength() 
   #160126-00002#3 s983961--add(e)
   #end add-point
 
   
   CALL artq510_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtdx_d.clear()
 
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
 
         CALL artq510_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         #160126-00002#3 s983961--add(s)
         INPUT g_rtdy001,g_rtdxsite,g_checkbox,g_combobox_1,g_checkbox_2,g_number,g_checkbox_3   #add by geza 20150826  g_checkbox_3
          FROM rtdy001,rtdxsite,checkbox,combobox_1,checkbox_2,number,checkbox_3                 #add by geza 20150826  checkbox_3
         ATTRIBUTE(WITHOUT DEFAULTS)
               
         BEFORE INPUT 
         
         DISPLAY g_rtdy001,g_rtdxsite,g_checkbox,g_combobox_1,g_checkbox_2,g_number,g_checkbox_3   #add by geza 20150826  g_checkbox_3
                 TO rtdy001,rtdxsite,checkbox,combobox_1,checkbox_2,number,checkbox_3              #add by geza 20150826  checkbox_3
         
          
         ON ACTION controlp INFIELD rtdy001
           #add-point:ON ACTION controlp INFIELD rtdudocno
                                               #此段落由子樣板a07產生            
           #開窗i段
           INITIALIZE g_qryparam.* TO NULL #sakura add
           LET g_qryparam.state = 'i'      #sakura add       
           LET g_qryparam.reqry = FALSE
          
           #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值
          
           #給予arg
           LET g_qryparam.where = " rtdystus = 'Y' "
           #add by geza 20150824(S)
           IF g_rtdxsite IS NOT NULL THEN
              LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM rtdz_t WHERE rtdzent = ",g_enterprise," AND rtdz001 = rtdy001 AND rtdzstus = 'Y' AND rtdz002 = '",g_rtdxsite,"')"
           END IF 
           #add by geza 20150824(E)
           CALL q_rtdy001()                                #呼叫開窗
          
           LET g_rtdy001 = g_qryparam.return1              
          
           DISPLAY g_rtdy001 TO rtdy001             #顯示到畫面上
           
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_rtdy001
           LET ls_sql = "SELECT rtdyl003 FROM rtdyl_t WHERE rtdylent='"||g_enterprise||"' AND rtdyl001=? AND rtdyl002='"||g_dlang||"'"
           LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           LET g_rtdy001_desc = '', g_rtn_fields[1] , ''
           DISPLAY  g_rtdy001_desc TO  rtdy001_desc            
          
           NEXT FIELD rtaw001
         
         AFTER FIELD rtdy001
            IF NOT cl_null(g_rtdy001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtdy_t 
                WHERE rtdyent = g_enterprise
                  AND rtdy001 = g_rtdy001             
                  AND rtdystus = 'Y'
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00631'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF         
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdy001
            LET ls_sql = "SELECT rtdyl003 FROM rtdyl_t WHERE rtdylent='"||g_enterprise||"' AND rtdyl001=? AND rtdyl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdy001_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdy001_desc TO  rtdy001_desc         
            
         ON ACTION controlp INFIELD rtdxsite
            #add-point:ON ACTION controlp INFIELD rtdusite
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #ken---add---str 需求單號：141208-00001 項次：14
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
         
            #LET g_qryparam.default1 = g_rtdu_m.rtdusite             #給予default值
         
            #給予arg
            #LET g_qryparam.arg1 = "" #
         
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdxsite',g_site,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()                                #呼叫開窗
         
            LET g_rtdxsite = g_qryparam.return1              
         
            DISPLAY g_rtdxsite TO  rtdxsite             #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
         
            
            NEXT FIELD rtdxsite        
          
         AFTER FIELD rtdxsite
            IF NOT cl_null(g_rtdxsite) THEN
               CALL s_aooi500_chk(g_prog,'rtdxsite',g_rtdxsite,g_site)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
            
         AFTER FIELD number
            IF g_number IS NOT NULL THEN
               FOR l_i = 1 TO g_rtdx_d.getLength() STEP 1
                  LET g_rtdx_d[l_i].count = g_number                
               END FOR         
            END IF 
         
         AFTER INPUT
            
         END INPUT
         #160126-00002#3 s983961--add(e)
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #160126-00002#3 s983961--add(s)
         CONSTRUCT g_wc ON imaf153,imaa001,imaa108,imaa009,imaa126,imaa127,imaa128,imaa129,imaa131,imaa122,imaal003,rtdx022,rtdx023
                FROM  imaf153,imaa001,imaa108,imaa009,imaa126,imaa127,imaa128,imaa129,imaa131,imaa122,imaal003,rtdx022,rtdx023    
         
         BEFORE CONSTRUCT
         
#         ON ACTION controlp INFIELD imaa009
#        
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c' 
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = cl_get_para(g_enterprise,"","E-CIR-0001")
#            CALL q_rtax001_4()                    #呼叫開窗
#            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
#        
#            NEXT FIELD imaa009                    #返回原欄位
         
         ON ACTION controlp INFIELD imaf153
            
           
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf153  #顯示到畫面上
         
            NEXT FIELD imaf153 
          
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD deag002
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
               LET  g_qryparam.where = " imaa009 IN ( SELECT rtaw002 FROM rtaw_t WHERE rtawent = ",g_enterprise," AND ",g_wc3," )"
            END IF			   
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
         
            NEXT FIELD imaa001            
         
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD deag003
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
         
            NEXT FIELD imaa009  
            
         ON ACTION controlp INFIELD imaa126
            #add-point:ON ACTION controlp INFIELD deag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上
         
            NEXT FIELD imaa126                     #返回原欄位
         ON ACTION controlp INFIELD imaa127
             #add-point:ON ACTION controlp INFIELD deag004
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = '2003'
             CALL q_oocq002()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上
         
             NEXT FIELD imaa127  
                  
         ON ACTION controlp INFIELD imaa128
             #add-point:ON ACTION controlp INFIELD deag004
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = '2004'
             CALL q_oocq002()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaa128  #顯示到畫面上
         
             NEXT FIELD imaa128             
         
         ON ACTION controlp INFIELD imaa129
             #add-point:ON ACTION controlp INFIELD imaa129
                         #此段落由子樣板a08產生
             #開窗c段
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 = '2005'
             CALL q_oocq002()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO imaa129  #顯示到畫面上
         
             NEXT FIELD imaa129 
             
         ON ACTION controlp INFIELD imaa131
            #add-point:ON ACTION controlp INFIELD imaa131
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2001'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa131  #顯示到畫面上
         
            NEXT FIELD imaa131   
         
         ON ACTION controlp INFIELD imaa122
            #add-point:ON ACTION controlp INFIELD imaa122
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2000'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa122  #顯示到畫面上
         
            NEXT FIELD imaa122    
         
         AFTER CONSTRUCT
         
         END CONSTRUCT
         
           
         CONSTRUCT g_wc3 ON rtaw001 FROM  rtaw001  
         
             ON ACTION controlp INFIELD rtaw001
               #add-point:ON ACTION controlp INFIELD deag003
                                                   #此段落由子樣板a08產生
               #開窗c段
		   	   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		   	   LET g_qryparam.reqry = FALSE
		   	   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
               CALL q_rtax001_4()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtaw001  
            
            BEFORE CONSTRUCT
            
            AFTER CONSTRUCT
         
         END CONSTRUCT
         
         #160126-00002#3 s983961--add(e)
         #end add-point
     
         DISPLAY ARRAY g_rtdx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL artq510_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL artq510_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               CALL DIALOG.setCellAttributes(g_rtdx_d_colour)    #参数：屏幕变量,属性数组
               CALL DIALOG.setArrayAttributes("s_detail1",g_rtdx_d_colour)    #参数：屏幕变量,属性数组   
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            #LET ls_wc = g_wc2
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
            CALL artq510_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#3 s983961--add(s)
            CALL cl_set_act_visible("query,insert", FALSE) 
            CALL cl_set_act_visible("filter", FALSE) 
            --CALL cl_set_comp_visible("sel", FALSE)
            LET g_checkbox = 'N'
            LET g_checkbox_2 = 'N'
            LET g_checkbox_3 = 'N'   #add by geza 20150826
            LET g_combobox_1 = '0'
            IF g_number = 0 THEN
               LET g_number = 1
            END IF   
           # DISPLAY '1' TO imaa108 
            CALL s_aooi500_default(g_prog,'rtdxsite',g_rtdxsite) RETURNING r_insert,g_rtdxsite
            IF NOT r_insert THEN
               RETURN 
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
            #160126-00002#3 s983961--add(e)
            #NEXT FIELD b_sel  #160126-00002#3 s983961--mark
            #end add-point
            NEXT FIELD rtdy001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            #160126-00002#1 160201 By s983961 add(S)
            ON ACTION modify_detail
               INITIALIZE l_cnt TO NULL
               LET l_cnt = g_rtdx_d.getLength() 
               IF  g_rtdx_d.getLength() > 0 THEN
                  LET g_action_choice="modify_detail"
                  IF cl_auth_chk_act("modify") THEN
                     LET g_aw = g_curr_diag.getCurrentItem()
                     CALL cl_set_act_visible("insert", FALSE)
                     CALL artq510_modify()
                     #add-point:ON ACTION modify_detail
                                                   
                     #END add-point               
                  END IF
               END IF
            #160126-00002#1 160201 By s983961 add(E)   
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
            #160126-00002#1 160201 By s983961 add(S)
            #LET g_wc2 = ls_wc
            
            INITIALIZE l_cnt TO NULL
            LET l_cnt = g_rtdx_d.getLength() 
            IF  g_rtdx_d.getLength() > 0 THEN
              IF cl_ask_confirm('art-00667') THEN
                 CALL g_rtdx_d.clear()
                 CALL g_rtdx_d_colour.clear()
                 CLEAR FORM
              END IF
            END IF  
            
            IF cl_null(g_rtdy001) THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD rtdy001             
            END IF
            
            IF cl_null(g_rtdxsite) THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD rtdxsite             
            END IF
            
            IF cl_null(g_number) THEN 
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD number             
            END IF
            
            LET g_detail_idx = 1     
            CALL artq510_b_fill_1()
            IF g_rtdx_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)                 
            END IF            
            #160126-00002#1 160201 By s983961 add(E)
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL artq510_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtdx_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL artq510_b_fill()
 
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
            CALL artq510_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL artq510_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL artq510_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL artq510_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               LET g_rtdx_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               LET g_rtdx_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtdx_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtdx_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artq510_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print
            LET g_action_choice="print"
            IF cl_auth_chk_act("print") THEN
               
               #add-point:ON ACTION print name="menu.print"
               LET l_cnt = g_rtdx_d.getLength()
               IF l_cnt > 0 THEN 
                  
                  CALL artq510_print()
                  
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00633'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET l_cnt = g_rtdx_d.getLength()
               IF l_cnt > 0 THEN 
                  
                  CALL artq510_print()
                  
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00633'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_cnt = g_rtdx_d.getLength()
               IF l_cnt > 0 THEN 
                  
                  CALL artq510_print()
                  
               ELSE   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00633'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_action_choice= ""
                  EXIT DIALOG
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_download
            LET g_action_choice="excel_download"
            IF cl_auth_chk_act("excel_download") THEN
               
               #add-point:ON ACTION excel_download name="menu.excel_download"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               #CALL artq510_query()  #160126-00002#3 160201 By s983961 mark
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
         ON ACTION excel_upload
            LET g_action_choice="excel_upload"
            IF cl_auth_chk_act("excel_upload") THEN
               
               #add-point:ON ACTION excel_upload name="menu.excel_upload"
               
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
 
{<section id="artq510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artq510_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cn            LIKE type_t.num10  
   DEFINE ls              STRING
   DEFINE l_where1        STRING
   DEFINE l_where2        STRING
   DEFINE l_where3        STRING
   DEFINE l_str        LIKE type_t.chr50
   DEFINE l_str1       STRING
   DEFINE l_str2       STRING
   DEFINE l_dir        STRING
   DEFINE l_json_path STRING
   DEFINE ls_tmp      STRING
   DEFINE l_channel   base.Channel
   DEFINE obj util.JSONObject 
   DEFINE l_c                     STRING
   DEFINE p_content   STRING
   DEFINE l_time      DATETIME YEAR TO FRACTION(5)   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #RETURN #160126-00002#1 160201 By s983961 add
   #160126-00002#3 s983961--add(S)
   LET g_bfill_count = g_bfill_count +1
   IF g_bfill_count > 1 THEN 
     RETURN
   END IF   
   #160126-00002#3 s983961--add(E)
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
 
   CALL g_rtdx_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
#   IF g_rtdxsite IS NOT NULL THEN 
#      LET g_wc2 = " AND rtdxsite ='",g_rtdxsite,"'"
#   END IF 
#   IF g_sel2 = 'Y' THEN 
#      IF cl_null(l_str) THEN 
#         LET l_str = "AND  deaf008 <> 0"
#      ELSE
#         LET l_str = l_str," AND ","deaf008 <> 0"
#      END IF 
#   END IF 
#   LET g_wc = " 1=1"
#   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter,l_str
   INITIALIZE ls TO NULL
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',rtdx002,'','',rtdx001,'','','','','','',rtdx058,rtdx059, 
       rtdx060,rtdx012,rtdx056,rtdx057,'','',rtdx016,rtdx017,rtdx018,rtdx019,rtdx023,rtdx022,rtdx020, 
       rtdx021,rtdx038,rtdx039,rtdx040,rtdx034  ,DENSE_RANK() OVER( ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001) AS RANK FROM rtdx_t", 
 
 
 
                     "",
                     " WHERE rtdxent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtdx_t"),
                     " ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
#   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
#      LET l_where1 = " AND EXISTS (SELECT 1 FROM rtaw_t,rtax_t ",
#                     " WHERE rtawent = rtaxent AND rtaxent = ",g_enterprise,
#                     "   AND rtaw002 = imaa009 AND rtax004 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' AND ",g_wc3,")"
#                  
#   END IF 
#   LET l_where2 = "  AND EXISTS (SELECT 1 FROM prbk_t ",
#                  "  WHERE prbkent = rtdxent AND prbksite = rtdxsite ",
#                  "  AND prbksite = rtdxsite AND prbk010 = rtdx001 ",
#                  "  AND (prbk006 = '",g_today,"' OR prbk007 = '",g_today,"') ",
#                  "  AND prbkstus = '2') "  
#   LET l_where3 = "  AND EXISTS (SELECT 1 FROM prbk_t ",
#                  "  WHERE prbkent = rtdxent AND prbksite = rtdxsite ",
#                  "  AND prbksite = rtdxsite AND prbk010 = rtdx001 AND prbk011 = prbh004 ",
#                  "  AND (prbk006 = '",g_today,"' OR prbk007 = '",g_today,"') ",
#                  "  AND prbkstus = '2') "                          
#
#   LET ls_sql_rank = "SELECT 'Y','",l_cn,"','1',imay003 AS F1,imaa001 AS F2,imaal003 AS F3,imaal004 AS F4 ,imaa009 AS F5 ,rtaxl003 AS F6,imaa126 AS F7,oocql004 AS F8,imaa123 AS F9,imaa105 AS F10,(rtdx016*imay005) AS F11,(rtdx017*imay005) AS F12 ,(rtdx018*imay005) AS F13,(rtdx019*imay005) AS F14, 
#                rtdx023 AS F15,rtdx022 AS F16,(rtdx020*imay005) AS F17,(rtdx021*imay005) AS  F18,(rtdx038*imay005) AS F19,(rtdx039*imay005) AS F20,(rtdx040*imay005) AS F21,((CASE WHEN ( '",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) THEN rtdx021 ELSE rtdx016 END)*imay005) AS F22 ,
#                DENSE_RANK() OVER( ORDER BY imaa001) AS RANK",
#               " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' )  
#                             LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
#                             LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,imaf_t,imay_t",
#               " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
#               "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite ",
#               "   AND imaa108 = 1 ",
#               "   AND imaaent = imayent AND imaa001 = imay001 ",  
#               "   AND imafsite = '",g_rtdxsite,"'",  
#               "   AND imaaent = ? ",               
#               " AND ",g_wc2
#   IF g_checkbox = 'N'  THEN      
#      LET ls_sql_rank = ls_sql_rank," AND imay006 = 'Y'" 
#   END IF    
#   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
#      LET ls_sql_rank = ls_sql_rank,l_where1 
#   END IF    
#   #(IF 价格选项=1，抓rtdx022为空 OR g_taday不在rtdx022和rtdx023之间的资料；
#   #IF 价格选项=2，抓g_today在rtdx022和rtdx023之间的资料)    
#   IF g_combobox_1 = '1' THEN   
#      LET ls_sql_rank = ls_sql_rank," AND (rtdx022 IS NULL OR ('",g_today,"'< rtdx022 OR '",g_today,"' > rtdx023 ))" 
#   END IF    
#   IF g_combobox_1 = '2' THEN   
#      LET ls_sql_rank = ls_sql_rank," AND ('",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) " 
#   END IF    
#   IF g_checkbox_2 = 'Y' THEN 
#      LET ls_sql_rank = ls_sql_rank,l_where2
#   END IF    
#       
#   LET ls_sql_rank = ls_sql_rank, " UNION ALL SELECT 'Y','",l_cn,"','1',prbh004 AS F1 ,imaa001 AS F2,imaal003 AS F3,imaal004 AS F4,imaa009 AS F5,rtaxl003 AS F6,imaa126 AS F7,oocql004 AS F8,imaa123 AS F9,imaa105 AS F10,prbh012 AS F11,prbh013 AS F12,prbh014 AS F13,prbh015 AS F14, 
#             prbh018 AS F15,prbh019 AS F16,CAST('' as number(20, 6)) AS F17,CAST('' as number(20, 6)) AS F18,CAST('' as number(20, 6)) AS F19,CAST('' as number(20, 6)) AS F20,CAST('' as number(20, 6)) AS F21,prbh012 AS F22 ,DENSE_RANK() OVER( ORDER BY imaa001) AS RANK",
#           " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
#                         LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
#                         LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )   ,rtdx_t,imaf_t,prbh_t ",
#           " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
#           "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite",
#           "   AND imaa108 = 3 ",
#           "   AND imaaent = prbhent AND imaa001 = prbh003",
#           "   AND imafsite = '",g_rtdxsite,"'", 
#           "   AND imaaent = ",g_enterprise,
#           "   AND ",g_wc2    
#   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
#      LET ls_sql_rank = ls_sql_rank,l_where1 
#   END IF    
#   IF g_checkbox_2 = 'Y' THEN 
#      LET ls_sql_rank = ls_sql_rank,l_where3
#   END IF     
#   IF g_combobox_1 = '2' THEN   
#      LET ls_sql_rank = ls_sql_rank," AND 1= 2 " 
#   END IF     
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
 
   LET g_sql = "SELECT '','','','',rtdx002,'','',rtdx001,'','','','','','',rtdx058,rtdx059,rtdx060,rtdx012, 
       rtdx056,rtdx057,'','',rtdx016,rtdx017,rtdx018,rtdx019,rtdx023,rtdx022,rtdx020,rtdx021,rtdx038, 
       rtdx039,rtdx040,rtdx034",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
      LET l_where1 = " AND EXISTS (SELECT 1 FROM rtaw_t,rtax_t ",
                     " WHERE rtawent = rtaxent AND rtaxent = ",g_enterprise,
                     "   AND rtaw002 = imaa009 AND rtax004 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' AND ",g_wc3,")"
                  
   END IF 
   LET l_where2 = "  AND EXISTS (SELECT 1 FROM prbk_t ",
                  "  WHERE prbkent = rtdxent AND prbksite = rtdxsite ",
                  "  AND prbksite = rtdxsite AND prbk010 = rtdx001 ",
                  "  AND (prbk006 = '",g_today,"' OR prbk007 = '",g_today,"') ",
                  "  AND prbkstus = '2') "  
   LET l_where3 = "  AND EXISTS (SELECT 1 FROM prbk_t ",
                  "  WHERE prbkent = rtdxent AND prbksite = rtdxsite ",
                  "  AND prbksite = rtdxsite AND prbk010 = rtdx001 AND prbk011 = prbh004 ",
                  "  AND (prbk006 = '",g_today,"' OR prbk007 = '",g_today,"') ",
                  "  AND prbkstus = '2') "                          

   LET g_sql = "SELECT 'Y','",l_cn,"','1','',imay003,imaa001,imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,imaa105,oocal003,(rtdx016*imay005),(rtdx017*imay005),(rtdx018*imay005),(rtdx019*imay005), 
                rtdx023,rtdx022,(rtdx020*imay005),(rtdx021*imay005),(rtdx038*imay005),(rtdx039*imay005),(rtdx040*imay005),((CASE WHEN ( '",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) THEN rtdx021 ELSE rtdx016 END)*imay005)",
               " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' )
                             LEFT JOIN oocal_t ON (oocalent = imaaent AND oocal001 = imaa105 AND oocal002 = '"||g_dlang||"' )                      
                             LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                             LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,imaf_t,imay_t",
               " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
               "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite ",
               "   AND imaa108 in ('1','4') ",
               "   AND imaaent = imayent AND imaa001 = imay001 ",  
               "   AND imafsite = '",g_rtdxsite,"'",  
               "   AND imaaent = ? ",               
               #" AND ",g_wc2 #160126-00002#3 s983961--mark
               " AND ",g_wc  #160126-00002#3 s983961--add
   IF g_checkbox = 'N'  THEN      
      LET g_sql = g_sql," AND imay006 = 'Y'" 
   END IF    
   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
      LET g_sql = g_sql,l_where1 
   END IF    
   #(IF 价格选项=1，抓rtdx022为空 OR g_taday不在rtdx022和rtdx023之间的资料；
   #IF 价格选项=2，抓g_today在rtdx022和rtdx023之间的资料)    
   IF g_combobox_1 = '1' THEN   
      LET g_sql = g_sql," AND (rtdx022 IS NULL OR ('",g_today,"'< rtdx022 OR '",g_today,"' > rtdx023 ))" 
   END IF    
   IF g_combobox_1 = '2' THEN   
      LET g_sql = g_sql," AND ('",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) " 
   END IF    
   IF g_checkbox_2 = 'Y' THEN 
      LET g_sql = g_sql,l_where2
   END IF    
       
   LET g_sql = g_sql, " UNION ALL SELECT 'Y','",l_cn,"','1','1',prbh004,imaa001,imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,imaa105,oocal003,prbh012,prbh013,prbh014,prbh015, 
             prbh018,prbh019,CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),prbh012",
           " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
                         LEFT JOIN oocal_t ON (oocalent = imaaent AND oocal001 = imaa105 AND oocal002 = '"||g_dlang||"' )
                         LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                         LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )   ,rtdx_t,imaf_t,prbh_t ",
           " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
           "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite",
           "   AND imaa108 = 3 ",
           "   AND imaaent = prbhent AND imaa001 = prbh003",
           "   AND imafsite = '",g_rtdxsite,"'", 
           "   AND imaaent = ",g_enterprise,
           #" AND ",g_wc2 #160126-00002#3 s983961--mark
           " AND ",g_wc  #160126-00002#3 s983961--add
   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
      LET g_sql = g_sql,l_where1 
   END IF    
   IF g_checkbox_2 = 'Y' THEN 
      LET g_sql = g_sql,l_where3
   END IF     
   IF g_combobox_1 = '2' THEN   
      LET g_sql = g_sql," AND 1= 2 " 
   END IF     
#   LET g_sql = "SELECT 'Y','",l_cn,"','1',F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22 ",
#               " FROM (",ls_sql_rank,")" ,
#              " WHERE RANK >= ",g_pagestart,
#               " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq510_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artq510_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtdx_d[l_ac].sel,g_rtdx_d[l_ac].seq,g_rtdx_d[l_ac].count,g_rtdx_d[l_ac].check, 
       g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].imaf153,g_rtdx_d[l_ac].imaf153_desc,g_rtdx_d[l_ac].rtdx001, 
       g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].imaa009,g_rtdx_d[l_ac].imaa009_desc, 
       g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx058,g_rtdx_d[l_ac].rtdx059, 
       g_rtdx_d[l_ac].rtdx060,g_rtdx_d[l_ac].rtdx012,g_rtdx_d[l_ac].rtdx056,g_rtdx_d[l_ac].rtdx057,g_rtdx_d[l_ac].imaa105, 
       g_rtdx_d[l_ac].imaa105_desc,g_rtdx_d[l_ac].rtdx016,g_rtdx_d[l_ac].rtdx017,g_rtdx_d[l_ac].rtdx018, 
       g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022,g_rtdx_d[l_ac].rtdx020,g_rtdx_d[l_ac].rtdx021, 
       g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040,g_rtdx_d[l_ac].rtdx034
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_rtdx_d[l_ac].check) THEN
         IF g_today >= g_rtdx_d[l_ac].rtdx022 AND g_rtdx_d[l_ac].rtdx023 >= g_today THEN
            LET g_rtdx_d[l_ac].check = '2'
         ELSE
            LET g_rtdx_d[l_ac].check = '1'
         END IF 
      END IF
      LET g_rtdx_d[l_ac].seq = l_ac 
      #end add-point
 
      CALL artq510_detail_show("'1'")
 
      CALL artq510_rtdx_t_mask()
 
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
#   LET l_time = cl_get_timestamp()
#   LET l_str = l_time
#   LET l_str1 = l_str[1,4],l_str[6,7],l_str[9,10],l_str[12,13],l_str[15,16],l_str[18,19],l_str[21,25]
#
#   LET l_str = l_str1
#   #LET ls = "{'id' : '",l_str,"', 'template' : '",g_rtdy001,".svg' , 'data' : [",ls," ] }" 
#   LET g_str = l_str1
#   
#   LET l_dir = FGL_GETENV("TEMPDIR"),"/",l_str
#   LET l_c ="touch ",l_dir
#   RUN l_c
#   
#   LET g_cust_rec.id = l_str  
#   LET g_cust_rec.template = g_rtdy001,".svg" 
#  
#   
#   LET obj = util.JSONObject.fromFGL(g_cust_rec)
##產生json string
#   LET p_content = obj.toString()
#   LET l_json_path = os.Path.join(FGL_GETENV("TEMPDIR"), l_str)
#   LET l_channel = base.Channel.create()
#   CALL l_channel.setDelimiter("")
#   CALL l_channel.openFile(l_json_path,"w")
#   CALL l_channel.write(p_content)
#   CALL l_channel.close()
   #end add-point
 
   CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtdx_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE artq510_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL artq510_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL artq510_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtdx_d.getLength() > 0 THEN
      CALL artq510_b_fill2()
   END IF
 
      CALL artq510_filter_show('rtdx002','b_rtdx002')
   CALL artq510_filter_show('imaf153','b_imaf153')
   CALL artq510_filter_show('rtdx001','b_rtdx001')
   CALL artq510_filter_show('imaa009','b_imaa009')
   CALL artq510_filter_show('imaa126','b_imaa126')
   CALL artq510_filter_show('rtdx058','b_rtdx058')
   CALL artq510_filter_show('rtdx059','b_rtdx059')
   CALL artq510_filter_show('rtdx060','b_rtdx060')
   CALL artq510_filter_show('rtdx012','b_rtdx012')
   CALL artq510_filter_show('rtdx056','b_rtdx056')
   CALL artq510_filter_show('rtdx057','b_rtdx057')
   CALL artq510_filter_show('imaa105','b_imaa105')
   CALL artq510_filter_show('rtdx016','b_rtdx016')
   CALL artq510_filter_show('rtdx017','b_rtdx017')
   CALL artq510_filter_show('rtdx018','b_rtdx018')
   CALL artq510_filter_show('rtdx019','b_rtdx019')
   CALL artq510_filter_show('rtdx023','b_rtdx023')
   CALL artq510_filter_show('rtdx022','b_rtdx022')
   CALL artq510_filter_show('rtdx020','b_rtdx020')
   CALL artq510_filter_show('rtdx021','b_rtdx021')
   CALL artq510_filter_show('rtdx038','b_rtdx038')
   CALL artq510_filter_show('rtdx039','b_rtdx039')
   CALL artq510_filter_show('rtdx040','b_rtdx040')
   CALL artq510_filter_show('rtdx034','b_rtdx034')
 
 
END FUNCTION
 
{</section>}
 
{<section id="artq510.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artq510_b_fill2()
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
   LET g_detail_cnt = g_rtdx_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="artq510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artq510_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_rtdx_d[l_ac].rtdx001
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdx_d[l_ac].rtdx001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtdx_d[l_ac].rtdx001_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq510.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION artq510_filter()
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
      CONSTRUCT g_wc_filter ON rtdx002,imaf153,rtdx001,imaa009,imaa126,rtdx058,rtdx059,rtdx060,rtdx012, 
          rtdx056,rtdx057,imaa105,rtdx016,rtdx017,rtdx018,rtdx019,rtdx023,rtdx022,rtdx020,rtdx021,rtdx038, 
          rtdx039,rtdx040,rtdx034
                          FROM s_detail1[1].b_rtdx002,s_detail1[1].b_imaf153,s_detail1[1].b_rtdx001, 
                              s_detail1[1].b_imaa009,s_detail1[1].b_imaa126,s_detail1[1].b_rtdx058,s_detail1[1].b_rtdx059, 
                              s_detail1[1].b_rtdx060,s_detail1[1].b_rtdx012,s_detail1[1].b_rtdx056,s_detail1[1].b_rtdx057, 
                              s_detail1[1].b_imaa105,s_detail1[1].b_rtdx016,s_detail1[1].b_rtdx017,s_detail1[1].b_rtdx018, 
                              s_detail1[1].b_rtdx019,s_detail1[1].b_rtdx023,s_detail1[1].b_rtdx022,s_detail1[1].b_rtdx020, 
                              s_detail1[1].b_rtdx021,s_detail1[1].b_rtdx038,s_detail1[1].b_rtdx039,s_detail1[1].b_rtdx040, 
                              s_detail1[1].b_rtdx034
 
         BEFORE CONSTRUCT
                     DISPLAY artq510_filter_parser('rtdx002') TO s_detail1[1].b_rtdx002
            DISPLAY artq510_filter_parser('imaf153') TO s_detail1[1].b_imaf153
            DISPLAY artq510_filter_parser('rtdx001') TO s_detail1[1].b_rtdx001
            DISPLAY artq510_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY artq510_filter_parser('imaa126') TO s_detail1[1].b_imaa126
            DISPLAY artq510_filter_parser('rtdx058') TO s_detail1[1].b_rtdx058
            DISPLAY artq510_filter_parser('rtdx059') TO s_detail1[1].b_rtdx059
            DISPLAY artq510_filter_parser('rtdx060') TO s_detail1[1].b_rtdx060
            DISPLAY artq510_filter_parser('rtdx012') TO s_detail1[1].b_rtdx012
            DISPLAY artq510_filter_parser('rtdx056') TO s_detail1[1].b_rtdx056
            DISPLAY artq510_filter_parser('rtdx057') TO s_detail1[1].b_rtdx057
            DISPLAY artq510_filter_parser('imaa105') TO s_detail1[1].b_imaa105
            DISPLAY artq510_filter_parser('rtdx016') TO s_detail1[1].b_rtdx016
            DISPLAY artq510_filter_parser('rtdx017') TO s_detail1[1].b_rtdx017
            DISPLAY artq510_filter_parser('rtdx018') TO s_detail1[1].b_rtdx018
            DISPLAY artq510_filter_parser('rtdx019') TO s_detail1[1].b_rtdx019
            DISPLAY artq510_filter_parser('rtdx023') TO s_detail1[1].b_rtdx023
            DISPLAY artq510_filter_parser('rtdx022') TO s_detail1[1].b_rtdx022
            DISPLAY artq510_filter_parser('rtdx020') TO s_detail1[1].b_rtdx020
            DISPLAY artq510_filter_parser('rtdx021') TO s_detail1[1].b_rtdx021
            DISPLAY artq510_filter_parser('rtdx038') TO s_detail1[1].b_rtdx038
            DISPLAY artq510_filter_parser('rtdx039') TO s_detail1[1].b_rtdx039
            DISPLAY artq510_filter_parser('rtdx040') TO s_detail1[1].b_rtdx040
            DISPLAY artq510_filter_parser('rtdx034') TO s_detail1[1].b_rtdx034
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<b_sel>>----
         #----<<b_seq>>----
         #----<<count>>----
         #----<<b_check>>----
         #----<<b_rtdx002>>----
         #Ctrlp:construct.c.page1.b_rtdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx002
            #add-point:ON ACTION controlp INFIELD b_rtdx002 name="construct.c.filter.page1.b_rtdx002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx002  #顯示到畫面上
            NEXT FIELD b_rtdx002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf153>>----
         #Ctrlp:construct.c.page1.b_imaf153
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf153
            #add-point:ON ACTION controlp INFIELD b_imaf153 name="construct.c.filter.page1.b_imaf153"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf153  #顯示到畫面上
            NEXT FIELD b_imaf153                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf153_desc>>----
         #----<<b_rtdx001>>----
         #Ctrlp:construct.c.page1.b_rtdx001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx001
            #add-point:ON ACTION controlp INFIELD b_rtdx001 name="construct.c.filter.page1.b_rtdx001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx001  #顯示到畫面上
            NEXT FIELD b_rtdx001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx001_desc>>----
         #----<<b_rtdx001_desc_1>>----
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.filter.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_imaa126>>----
         #Ctrlp:construct.c.page1.b_imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa126
            #add-point:ON ACTION controlp INFIELD b_imaa126 name="construct.c.filter.page1.b_imaa126"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa126  #顯示到畫面上
            NEXT FIELD b_imaa126                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa126_desc>>----
         #----<<b_rtdx058>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx058
            #add-point:ON ACTION controlp INFIELD b_rtdx058 name="construct.c.filter.page1.b_rtdx058"
            
            #END add-point
 
 
         #----<<b_rtdx059>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx059
            #add-point:ON ACTION controlp INFIELD b_rtdx059 name="construct.c.filter.page1.b_rtdx059"
            
            #END add-point
 
 
         #----<<b_rtdx060>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx060
            #add-point:ON ACTION controlp INFIELD b_rtdx060 name="construct.c.filter.page1.b_rtdx060"
            
            #END add-point
 
 
         #----<<b_rtdx012>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx012
            #add-point:ON ACTION controlp INFIELD b_rtdx012 name="construct.c.filter.page1.b_rtdx012"
            
            #END add-point
 
 
         #----<<b_rtdx056>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx056
            #add-point:ON ACTION controlp INFIELD b_rtdx056 name="construct.c.filter.page1.b_rtdx056"
            
            #END add-point
 
 
         #----<<b_rtdx057>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx057
            #add-point:ON ACTION controlp INFIELD b_rtdx057 name="construct.c.filter.page1.b_rtdx057"
            
            #END add-point
 
 
         #----<<b_imaa105>>----
         #Ctrlp:construct.c.page1.b_imaa105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa105
            #add-point:ON ACTION controlp INFIELD b_imaa105 name="construct.c.filter.page1.b_imaa105"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa105  #顯示到畫面上
            NEXT FIELD b_imaa105                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa105_desc>>----
         #----<<b_rtdx016>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx016
            #add-point:ON ACTION controlp INFIELD b_rtdx016 name="construct.c.filter.page1.b_rtdx016"
            
            #END add-point
 
 
         #----<<b_rtdx017>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx017
            #add-point:ON ACTION controlp INFIELD b_rtdx017 name="construct.c.filter.page1.b_rtdx017"
            
            #END add-point
 
 
         #----<<b_rtdx018>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx018
            #add-point:ON ACTION controlp INFIELD b_rtdx018 name="construct.c.filter.page1.b_rtdx018"
            
            #END add-point
 
 
         #----<<b_rtdx019>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx019
            #add-point:ON ACTION controlp INFIELD b_rtdx019 name="construct.c.filter.page1.b_rtdx019"
            
            #END add-point
 
 
         #----<<b_rtdx023>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx023
            #add-point:ON ACTION controlp INFIELD b_rtdx023 name="construct.c.filter.page1.b_rtdx023"
            
            #END add-point
 
 
         #----<<b_rtdx022>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx022
            #add-point:ON ACTION controlp INFIELD b_rtdx022 name="construct.c.filter.page1.b_rtdx022"
            
            #END add-point
 
 
         #----<<b_rtdx020>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx020
            #add-point:ON ACTION controlp INFIELD b_rtdx020 name="construct.c.filter.page1.b_rtdx020"
            
            #END add-point
 
 
         #----<<b_rtdx021>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx021
            #add-point:ON ACTION controlp INFIELD b_rtdx021 name="construct.c.filter.page1.b_rtdx021"
            
            #END add-point
 
 
         #----<<b_rtdx038>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx038
            #add-point:ON ACTION controlp INFIELD b_rtdx038 name="construct.c.filter.page1.b_rtdx038"
            
            #END add-point
 
 
         #----<<b_rtdx039>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx039
            #add-point:ON ACTION controlp INFIELD b_rtdx039 name="construct.c.filter.page1.b_rtdx039"
            
            #END add-point
 
 
         #----<<b_rtdx040>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx040
            #add-point:ON ACTION controlp INFIELD b_rtdx040 name="construct.c.filter.page1.b_rtdx040"
            
            #END add-point
 
 
         #----<<b_rtdx034>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx034
            #add-point:ON ACTION controlp INFIELD b_rtdx034 name="construct.c.filter.page1.b_rtdx034"
            
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
 
      CALL artq510_filter_show('rtdx002','b_rtdx002')
   CALL artq510_filter_show('imaf153','b_imaf153')
   CALL artq510_filter_show('rtdx001','b_rtdx001')
   CALL artq510_filter_show('imaa009','b_imaa009')
   CALL artq510_filter_show('imaa126','b_imaa126')
   CALL artq510_filter_show('rtdx058','b_rtdx058')
   CALL artq510_filter_show('rtdx059','b_rtdx059')
   CALL artq510_filter_show('rtdx060','b_rtdx060')
   CALL artq510_filter_show('rtdx012','b_rtdx012')
   CALL artq510_filter_show('rtdx056','b_rtdx056')
   CALL artq510_filter_show('rtdx057','b_rtdx057')
   CALL artq510_filter_show('imaa105','b_imaa105')
   CALL artq510_filter_show('rtdx016','b_rtdx016')
   CALL artq510_filter_show('rtdx017','b_rtdx017')
   CALL artq510_filter_show('rtdx018','b_rtdx018')
   CALL artq510_filter_show('rtdx019','b_rtdx019')
   CALL artq510_filter_show('rtdx023','b_rtdx023')
   CALL artq510_filter_show('rtdx022','b_rtdx022')
   CALL artq510_filter_show('rtdx020','b_rtdx020')
   CALL artq510_filter_show('rtdx021','b_rtdx021')
   CALL artq510_filter_show('rtdx038','b_rtdx038')
   CALL artq510_filter_show('rtdx039','b_rtdx039')
   CALL artq510_filter_show('rtdx040','b_rtdx040')
   CALL artq510_filter_show('rtdx034','b_rtdx034')
 
 
   CALL artq510_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="artq510.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION artq510_filter_parser(ps_field)
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
 
{<section id="artq510.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION artq510_filter_show(ps_field,ps_object)
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
   LET ls_condition = artq510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="artq510.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION artq510_detail_action_trans()
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
 
{<section id="artq510.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION artq510_detail_index_setting()
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
            IF g_rtdx_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtdx_d.getLength() AND g_rtdx_d.getLength() > 0
            LET g_detail_idx = g_rtdx_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtdx_d.getLength() THEN
               LET g_detail_idx = g_rtdx_d.getLength()
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
 
{<section id="artq510.mask_functions" >}
 &include "erp/art/artq510_mask.4gl"
 
{</section>}
 
{<section id="artq510.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询方法
# Memo...........:
# Usage..........: CALL artq510_query()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150615 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_query()
DEFINE ls_wc         LIKE type_t.chr500
DEFINE ls_return     STRING
DEFINE ls_result     STRING 
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_success     LIKE type_t.num5 
DEFINE l_errno       LIKE type_t.chr10
DEFINE r_insert      LIKE type_t.num5
DEFINE l_i         LIKE type_t.num10
DEFINE ls_sql        STRING
   LET INT_FLAG = 0
   #CLEAR FORM
   LET l_cnt = g_rtdx_d.getLength() 
   IF  g_rtdx_d.getLength() > 0 THEN
     IF cl_ask_confirm('art-00667') THEN
        CALL g_rtdx_d.clear()
        CALL g_rtdx_d_colour.clear()
        CLEAR FORM
     END IF
   END IF  
  # INITIALIZE g_rtdy001 TO NULL #
   INITIALIZE g_rtdxsite TO NULL #
   INITIALIZE g_combobox_1 TO NULL #
   LET g_qryparam.state = "c"
   LET g_checkbox = 'N'
   LET g_checkbox_2 = 'N'
   LET g_checkbox_3 = 'N'   #add by geza 20150826
   LET g_combobox_1 = '0'
   IF g_number = 0 THEN
      LET g_number = 1
   END IF   
   #wc備份
   CALL s_aooi500_default(g_prog,'rtdxsite',g_rtdxsite) RETURNING r_insert,g_rtdxsite
   IF NOT r_insert THEN
      RETURN 
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtdxsite
   LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
   
   LET ls_wc = g_wc2
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON imaf153,imaa001,imaa108,imaa009,imaa126,imaa127,imaa128,imaa129,imaa131,imaa122,imaal003,rtdx022,rtdx023
                FROM  imaf153,imaa001,imaa108,imaa009,imaa126,imaa127,imaa128,imaa129,imaa131,imaa122,imaal003,rtdx022,rtdx023    

         BEFORE CONSTRUCT
         
#         ON ACTION controlp INFIELD imaa009
#
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c' 
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = cl_get_para(g_enterprise,"","E-CIR-0001")
#            CALL q_rtax001_4()                    #呼叫開窗
#            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
#
#            NEXT FIELD imaa009                    #返回原欄位

         ON ACTION controlp INFIELD imaf153
            
           
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf153  #顯示到畫面上

            NEXT FIELD imaf153 
          
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD deag002
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
               LET  g_qryparam.where = " imaa009 IN ( SELECT rtaw002 FROM rtaw_t WHERE rtawent = ",g_enterprise," AND ",g_wc3," )"
            END IF			   
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上

            NEXT FIELD imaa001            
        
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD deag003
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009  
            
         ON ACTION controlp INFIELD imaa126
            #add-point:ON ACTION controlp INFIELD deag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上

            NEXT FIELD imaa126                     #返回原欄位
        ON ACTION controlp INFIELD imaa127
            #add-point:ON ACTION controlp INFIELD deag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2003'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上

            NEXT FIELD imaa127  
                 
        ON ACTION controlp INFIELD imaa128
            #add-point:ON ACTION controlp INFIELD deag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2004'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa128  #顯示到畫面上

            NEXT FIELD imaa128             
        
        ON ACTION controlp INFIELD imaa129
            #add-point:ON ACTION controlp INFIELD imaa129
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2005'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa129  #顯示到畫面上

            NEXT FIELD imaa129 
            
         ON ACTION controlp INFIELD imaa131
            #add-point:ON ACTION controlp INFIELD imaa131
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2001'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa131  #顯示到畫面上

            NEXT FIELD imaa131   

         ON ACTION controlp INFIELD imaa122
            #add-point:ON ACTION controlp INFIELD imaa122
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2000'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa122  #顯示到畫面上

            NEXT FIELD imaa122    
         
         AFTER CONSTRUCT
#         IF g_wc2.getIndexOf('deafdocdt',1) = 0 THEN
#            INITIALIZE g_errparam TO NULL   # 初始化清空
#            LET g_errparam.extend = ""
#            LET g_errparam.code   = 'ade-00074' #错误代码
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            NEXT FIELD deafdocdt
#         END IF 
#         
#         IF g_wc2.getIndexOf('deafsite',1) = 0 THEN
#            INITIALIZE g_errparam TO NULL   # 初始化清空
#            LET g_errparam.extend = ""
#            LET g_errparam.code   = 'art-00317' #错误代码
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            NEXT FIELD deafsite
#         END IF 
         
      END CONSTRUCT
      
     
      
      CONSTRUCT g_wc3 ON rtaw001 FROM  rtaw001  

          ON ACTION controlp INFIELD rtaw001
            #add-point:ON ACTION controlp INFIELD deag003
                                                #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaw001  
         
         BEFORE CONSTRUCT
         
         AFTER CONSTRUCT
      
      END CONSTRUCT
      
      INPUT g_rtdy001,g_rtdxsite,g_checkbox,g_combobox_1,g_checkbox_2,g_number,g_checkbox_3   #add by geza 20150826  g_checkbox_3
       FROM rtdy001,rtdxsite,checkbox,combobox_1,checkbox_2,number,checkbox_3                 #add by geza 20150826  checkbox_3
           ATTRIBUTE(WITHOUT DEFAULTS)
#       
          BEFORE INPUT 
          
          DISPLAY g_rtdy001,g_rtdxsite,g_checkbox,g_combobox_1,g_checkbox_2,g_number,g_checkbox_3   #add by geza 20150826  g_checkbox_3
                  TO rtdy001,rtdxsite,checkbox,combobox_1,checkbox_2,number,checkbox_3              #add by geza 20150826  checkbox_3
          

          ON ACTION controlp INFIELD rtdy001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            LET g_qryparam.where = " rtdystus = 'Y' "
            #add by geza 20150824(S)
            IF g_rtdxsite IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM rtdz_t WHERE rtdzent = ",g_enterprise," AND rtdz001 = rtdy001 AND rtdzstus = 'Y' AND rtdz002 = '",g_rtdxsite,"')"
            END IF 
            #add by geza 20150824(E)
            CALL q_rtdy001()                                #呼叫開窗

            LET g_rtdy001 = g_qryparam.return1              

            DISPLAY g_rtdy001 TO rtdy001             #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdy001
            LET ls_sql = "SELECT rtdyl003 FROM rtdyl_t WHERE rtdylent='"||g_enterprise||"' AND rtdyl001=? AND rtdyl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdy001_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdy001_desc TO  rtdy001_desc            

            NEXT FIELD rtdy001
         
         AFTER FIELD rtdy001
            IF NOT cl_null(g_rtdy001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtdy_t 
                WHERE rtdyent = g_enterprise
                  AND rtdy001 = g_rtdy001             
                  AND rtdystus = 'Y'
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00631'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF         
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdy001
            LET ls_sql = "SELECT rtdyl003 FROM rtdyl_t WHERE rtdylent='"||g_enterprise||"' AND rtdyl001=? AND rtdyl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdy001_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdy001_desc TO  rtdy001_desc         
            
         ON ACTION controlp INFIELD rtdxsite
            #add-point:ON ACTION controlp INFIELD rtdusite
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #ken---add---str 需求單號：141208-00001 項次：14
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdusite             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdxsite',g_site,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtdxsite = g_qryparam.return1              

            DISPLAY g_rtdxsite TO  rtdxsite             #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc

            
            NEXT FIELD rtdxsite        
          
         AFTER FIELD rtdxsite
            IF NOT cl_null(g_rtdxsite) THEN
               CALL s_aooi500_chk(g_prog,'rtdxsite',g_rtdxsite,g_site)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
            
         AFTER FIELD number
            IF g_number IS NOT NULL THEN
               FOR l_i = 1 TO g_rtdx_d.getLength() STEP 1
                  LET g_rtdx_d[l_i].count = g_number                
               END FOR         
            END IF 
     
         AFTER INPUT
            
      END INPUT


      BEFORE DIALOG 
#         LET g_deaf_d[1].deafdocdt = g_today
#         DISPLAY g_deaf_d[1].deafdocdt TO deafdocdt
#         LET g_deaf_d[1].deafsite = g_site
#         DISPLAY g_deaf_d[1].deafsite TO deafsite
#         CALL cl_qbe_init()
      #DISPLAY '1' TO imaa108 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
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
      LET g_wc2 = ls_wc
   ELSE
      CALL artq510_b_fill_1()   
   END IF
    
   LET g_error_show = 1
   #CALL artq510_b_fill_1()
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET INT_FLAG = FALSE
END FUNCTION

################################################################################
# Descriptions...: 打印预览
# Memo...........:
# Usage..........: CALL artq510_show()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150617 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_show()
 DEFINE l_cn         LIKE type_t.num10
 DEFINE l_sql        STRING
 DEFINE ls          STRING
 DEFINE l_str        LIKE type_t.chr50
 DEFINE l_str1       STRING
 DEFINE l_str2       STRING
 DEFINE l_dir        STRING
 DEFINE l_json_path STRING
 DEFINE ls_tmp      STRING
 DEFINE l_channel   base.Channel
 DEFINE obj util.JSONObject
 DEFINE  l_url                  STRING
 DEFINE l_c                     STRING
 DEFINE p_content   STRING
 DEFINE l_time      DATETIME YEAR TO FRACTION(5)
 DEFINE l_code      LIKE type_t.chr50

   CALL g_cust_rec.data.clear()
   FOR l_ac = 1 TO g_rtdx_d.getLength() STEP 1
      LET g_rtdx_d[l_ac].seq = l_ac
      IF g_rtdx_d[l_ac].sel = 'Y' THEN

         LET l_cn = g_cust_rec.data.getLength()+1         
         LET g_cust_rec.data[l_cn].rowid=g_rtdx_d[l_ac].seq
         LET g_cust_rec.data[l_cn].count=g_rtdx_d[l_ac].count
         LET g_cust_rec.data[l_cn].inna01=g_rtdx_d[l_ac].rtdx002
         LET g_cust_rec.data[l_cn].inna02=g_rtdx_d[l_ac].rtdx001
         LET g_cust_rec.data[l_cn].inna03=g_rtdx_d[l_ac].rtdx001_desc
         LET g_cust_rec.data[l_cn].inna04=g_rtdx_d[l_ac].rtdx001_desc_1
         LET g_cust_rec.data[l_cn].inna05=g_rtdx_d[l_ac].imaa009
         LET g_cust_rec.data[l_cn].inna06=g_rtdx_d[l_ac].imaa009_desc         
         LET g_cust_rec.data[l_cn].inna07=g_rtdx_d[l_ac].imaa126
         LET g_cust_rec.data[l_cn].inna08=g_rtdx_d[l_ac].imaa126_desc
         LET g_cust_rec.data[l_cn].inna09=g_rtdx_d[l_ac].rtdx012
         LET g_cust_rec.data[l_cn].inna10=g_rtdx_d[l_ac].imaa105         
         LET g_cust_rec.data[l_cn].inna11=g_rtdx_d[l_ac].rtdx016
         LET g_cust_rec.data[l_cn].inna12=g_rtdx_d[l_ac].rtdx017
         LET g_cust_rec.data[l_cn].inna13=g_rtdx_d[l_ac].rtdx018
         LET g_cust_rec.data[l_cn].inna14=g_rtdx_d[l_ac].rtdx019
         LET g_cust_rec.data[l_cn].inna15=g_rtdx_d[l_ac].rtdx022
         LET g_cust_rec.data[l_cn].inna16=g_rtdx_d[l_ac].rtdx023
         LET g_cust_rec.data[l_cn].inna17=g_rtdx_d[l_ac].rtdx020
         LET g_cust_rec.data[l_cn].inna18=g_rtdx_d[l_ac].rtdx021
         LET g_cust_rec.data[l_cn].inna19=g_rtdx_d[l_ac].rtdx038
         LET g_cust_rec.data[l_cn].inna20=g_rtdx_d[l_ac].rtdx039
         LET g_cust_rec.data[l_cn].inna21=g_rtdx_d[l_ac].rtdx040
         LET g_cust_rec.data[l_cn].inna22=g_rtdx_d[l_ac].rtdx034
         LET g_cust_rec.data[l_cn].inna23=g_name
         LET g_cust_rec.data[l_cn].inna27=g_rtdx_d[l_ac].imaa105_desc
         let g_cust_rec.data[l_cn].inna36=g_rtdx_d[l_ac].rtdx058
         let g_cust_rec.data[l_cn].inna37=g_rtdx_d[l_ac].rtdx059
         let g_cust_rec.data[l_cn].inna38=g_rtdx_d[l_ac].rtdx060
         let g_cust_rec.data[l_cn].inna39=g_rtdx_d[l_ac].rtdx056
         let g_cust_rec.data[l_cn].inna40=g_rtdx_d[l_ac].rtdx057
         let g_cust_rec.data[l_cn].inna41=g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx001_desc
      END IF       
   END FOR
   
   
   LET l_time = cl_get_timestamp()
   LET l_str = l_time
   LET l_str1 = l_str[1,4],l_str[6,7],l_str[9,10],l_str[12,13],l_str[15,16],l_str[18,19],l_str[21,25]

   LET l_str = l_str1
   #LET ls = "{'id' : '",l_str,"', 'template' : '",g_rtdy001,".svg' , 'data' : [",ls," ] }" 
   LET g_str = l_str1
   
   LET l_dir = FGL_GETENV("TEMPDIR"),"/",l_str
   LET l_c ="touch ",l_dir
   RUN l_c
   
   LET g_cust_rec.id = l_str  
   LET g_cust_rec.template = g_rtdy001,".svg" 
  
   
   LET obj = util.JSONObject.fromFGL(g_cust_rec)
#產生json string
   LET p_content = obj.toString()
   LET l_json_path = os.Path.join(FGL_GETENV("TEMPDIR"), l_str)
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(l_json_path,"w")
   CALL l_channel.write(p_content)
   CALL l_channel.close()
   
   LET l_code = FGL_GETENV("FGLASIP")
   LET l_code = l_code[8,18],"/tmp/",g_str

   LET l_url = FGL_GETENV("FGLASIP"),"/compontents/tag/preview.html?data=",l_code

   #LET l_url = l_url, "?id=", l_code
   
   CALL ui.Interface.frontCall("standard", "launchurl", [l_url], [])
   
   
END FUNCTION

################################################################################
# Descriptions...: 打印功能
# Memo...........:
# Usage..........: CALL  artq510_print()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150617 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_print()
 DEFINE l_cn         LIKE type_t.num10
 DEFINE l_sql        STRING
 DEFINE ls          STRING
 DEFINE l_str        LIKE type_t.chr50
 DEFINE l_str1       STRING
 DEFINE l_str2       STRING
 DEFINE l_dir        STRING
 DEFINE l_json_path STRING
 DEFINE ls_tmp      STRING
 DEFINE l_channel   base.Channel
 DEFINE obj util.JSONObject
 DEFINE  l_url                  STRING
 DEFINE l_c                     STRING
 DEFINE p_content   STRING
 DEFINE l_time      DATETIME YEAR TO FRACTION(5)
 DEFINE path          STRING
 DEFINE l_result INTEGER
 DEFINE parm1          STRING
 DEFINE parm2          STRING
 DEFINE parm3          STRING
 DEFINE l_str3          STRING
#   INITIALIZE ls TO NULL
#   LET l_cn = 1
#   LET l_ac = 1
#   LET l_sql = "SELECT 'Y','",l_cn,"','1',rtdx002,rtdx001,'',imaa009,'',imaa126,rtdx012,imaa105,rtdx016,rtdx017,rtdx018,rtdx019, 
#       rtdx023,rtdx022,rtdx020,rtdx021,rtdx038,rtdx039,rtdx040",
#               " FROM rtdx_t",
#               "      LEFT JOIN imaf_t ON imafent = rtdxent AND imafsite = rtdxsite AND imaf001 = rtdx001 ",
#               "      LEFT JOIN prbk_t ON prbkent = rtdxent AND prbksite = rtdxsite AND prbk010 = rtdx001 ",
#               "      LEFT JOIN imaa_t ON imaaent = rtdxent AND imaa001 = rtdx001 ",               
#              " WHERE rtdxent = ? ",
#                " AND ",g_wc2
#   #end add-point
# 
#   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
#   PREPARE artq510_pb2 FROM l_sql
#   DECLARE b_fill_curs2 CURSOR FOR artq510_pb2
# 
#   OPEN b_fill_curs2 USING g_enterprise
# 
#   FOREACH b_fill_curs2 INTO g_rtdx_d[l_ac].sel,g_rtdx_d[l_ac].seq,g_rtdx_d[l_ac].count,g_rtdx_d[l_ac].rtdx002, 
#       g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].rtdx001_desc_1_desc, 
#       g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].rtdx012,g_rtdx_d[l_ac].imaa105,g_rtdx_d[l_ac].rtdx016,g_rtdx_d[l_ac].rtdx017, 
#       g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022,g_rtdx_d[l_ac].rtdx020, 
#       g_rtdx_d[l_ac].rtdx021,g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
# 
#      
# 
#      #add-point:b_fill段資料填充
#      IF g_rtdx_d[l_ac].sel = 'Y' THEN
#         #IF cl_null(ls) THEN
##            LET ls = "{","'inaa01':'",g_rtdx_d[l_ac].seq,"','inaa02'：'", g_rtdx_d[l_ac].count,"','inaa03':'",
##                     g_rtdx_d[l_ac].rtdx002,"','inaa04':'",g_rtdx_d[l_ac].rtdx001,"','inaa05':'",g_rtdx_d[l_ac].rtdx001_desc,
##                     "','inaa06':'",g_rtdx_d[l_ac].rtdx001_desc_1,"','inna07':'",g_rtdx_d[l_ac].rtdx001_desc_1_desc,"','inaa08':'",
##                     g_rtdx_d[l_ac].imaa126,"','inna09':'",g_rtdx_d[l_ac].rtdx012,"','inna10':'",g_rtdx_d[l_ac].imaa105,"','inna11':'",
##                     g_rtdx_d[l_ac].rtdx016,"','inna12':'",g_rtdx_d[l_ac].rtdx017,"','inna13':'",g_rtdx_d[l_ac].rtdx018,"','inna14':'",
##                     g_rtdx_d[l_ac].rtdx019,"','inna15':'",g_rtdx_d[l_ac].rtdx023,"','inna16':'",g_rtdx_d[l_ac].rtdx022,"','inna17':'",
##                     g_rtdx_d[l_ac].rtdx020,"','inna18':'",g_rtdx_d[l_ac].rtdx021,"','inna19':'",g_rtdx_d[l_ac].rtdx038,"','inna20':'",
##                     g_rtdx_d[l_ac].rtdx039,"','inna21':'",g_rtdx_d[l_ac].rtdx040,"'} " 
##                    
##         ELSE
##            LET ls = ls," , {","'inaa01':'",g_rtdx_d[l_ac].seq,"','inaa02'：'", g_rtdx_d[l_ac].count,"','inaa03':'",
##                     g_rtdx_d[l_ac].rtdx002,"','inaa04':'",g_rtdx_d[l_ac].rtdx001,"','inaa05':'",g_rtdx_d[l_ac].rtdx001_desc,
##                     "','inaa06':'",g_rtdx_d[l_ac].rtdx001_desc_1,"','inna07':'",g_rtdx_d[l_ac].rtdx001_desc_1_desc,"','inaa08':'",
##                     g_rtdx_d[l_ac].imaa126,"','inna09':'",g_rtdx_d[l_ac].rtdx012,"','inna10':'",g_rtdx_d[l_ac].imaa105,"','inna11':'",
##                     g_rtdx_d[l_ac].rtdx016,"','inna12':'",g_rtdx_d[l_ac].rtdx017,"','inna13':'",g_rtdx_d[l_ac].rtdx018,"','inna14':'",
##                     g_rtdx_d[l_ac].rtdx019,"','inna15':'",g_rtdx_d[l_ac].rtdx023,"','inna16':'",g_rtdx_d[l_ac].rtdx022,"','inna17':'",
##                     g_rtdx_d[l_ac].rtdx020,"','inna18':'",g_rtdx_d[l_ac].rtdx021,"','inna19':'",g_rtdx_d[l_ac].rtdx038,"','inna20':'",
##                   g_rtdx_d[l_ac].rtdx039,"','inna21':'",g_rtdx_d[l_ac].rtdx040,"'} ,"
##         END IF
#          LET g_cust_rec.data[l_ac].inaa01=g_rtdx_d[l_ac].seq
#           LET g_cust_rec.data[l_ac].inaa02=g_rtdx_d[l_ac].count
#           LET g_cust_rec.data[l_ac].inaa03=g_rtdx_d[l_ac].rtdx002
#           LET g_cust_rec.data[l_ac].inaa04=g_rtdx_d[l_ac].rtdx001
#           LET g_cust_rec.data[l_ac].inaa05=g_rtdx_d[l_ac].rtdx001_desc
#           LET g_cust_rec.data[l_ac].inaa06=g_rtdx_d[l_ac].rtdx001_desc_1
#           LET g_cust_rec.data[l_ac].inaa07=g_rtdx_d[l_ac].rtdx001_desc_1_desc
#           LET g_cust_rec.data[l_ac].inaa08=g_rtdx_d[l_ac].imaa126
#           LET g_cust_rec.data[l_ac].inna09=g_rtdx_d[l_ac].rtdx012
#           LET g_cust_rec.data[l_ac].inna10=g_rtdx_d[l_ac].imaa105
#           LET g_cust_rec.data[l_ac].inna11=g_rtdx_d[l_ac].rtdx016
#           LET g_cust_rec.data[l_ac].inna12=g_rtdx_d[l_ac].rtdx017
#           LET g_cust_rec.data[l_ac].inna13=g_rtdx_d[l_ac].rtdx018
#           LET g_cust_rec.data[l_ac].inna14=g_rtdx_d[l_ac].rtdx019
#           LET g_cust_rec.data[l_ac].inna15=g_rtdx_d[l_ac].rtdx023
#           LET g_cust_rec.data[l_ac].inna16=g_rtdx_d[l_ac].rtdx022
#           LET g_cust_rec.data[l_ac].inna17=g_rtdx_d[l_ac].rtdx020
#           LET g_cust_rec.data[l_ac].inna18=g_rtdx_d[l_ac].rtdx021
#           LET g_cust_rec.data[l_ac].inna19=g_rtdx_d[l_ac].rtdx038
#           LET g_cust_rec.data[l_ac].inna20=g_rtdx_d[l_ac].rtdx039
#           LET g_cust_rec.data[l_ac].inna21=g_rtdx_d[l_ac].rtdx040      
#      END IF         
#      #end add-point
#      LET l_ac = l_ac + 1
#      LET g_rtdx_d[l_ac].seq = l_ac
#   END FOREACH
#   
#   LET l_time = cl_get_timestamp()
#   LET l_str = l_time
#   LET l_str1 = l_str[1,4],l_str[6,7],l_str[9,10],l_str[12,13],l_str[15,16],l_str[18,19],l_str[21,25]
#
#   LET l_str = l_str1
#
#   #LET ls = "{'id' : '",l_str,"', 'template' : '",g_rtdy001,".svg' , 'data' : [",ls," ] }" 
#   
#   
#   LET l_dir = FGL_GETENV("TEMPDIR"),"/",l_str
#   LET l_c ="touch ",l_dir
#   RUN l_c
#   
#   LET g_cust_rec.id = l_str  
#   LET g_cust_rec.template = g_rtdy001,".svg" 
#  
#   
#   LET obj = util.JSONObject.fromFGL(g_cust_rec)
##產生json string
#   LET p_content = obj.toString()
#   LET l_json_path = os.Path.join(FGL_GETENV("TEMPDIR"), l_str)
#   LET l_channel = base.Channel.create()
#   CALL l_channel.setDelimiter("")
#   CALL l_channel.openFile(l_json_path,"w")
#   CALL l_channel.write(p_content)
#   CALL l_channel.close()
   
#   LET l_url = FGL_GETENV("FGLASIP"),"/printhelper?data="
#   LET l_url = l_url, "?id="
#   
#   CALL ui.Interface.frontCall("standard", "launchurl", [l_url], [])

  # CALL artq510_b_fill()
   #LET path =  "cmd.exe /C:\\T100\\tag\\TPrinter.exe \"test\" \"test2\""
   CALL g_cust_rec.data.clear()
   FOR l_ac = 1 TO g_rtdx_d.getLength() STEP 1
      LET g_rtdx_d[l_ac].seq = l_ac
      IF g_rtdx_d[l_ac].sel = 'Y' AND g_rtdx_d[l_ac].count >=1 THEN
         LET l_cn = g_cust_rec.data.getLength()+1
                  
         LET g_cust_rec.data[l_cn].rowid=g_rtdx_d[l_ac].seq
         LET g_cust_rec.data[l_cn].count=g_rtdx_d[l_ac].count
         LET g_cust_rec.data[l_cn].inna01=g_rtdx_d[l_ac].rtdx002
         LET g_cust_rec.data[l_cn].inna02=g_rtdx_d[l_ac].rtdx001
         LET g_cust_rec.data[l_cn].inna03=g_rtdx_d[l_ac].rtdx001_desc
         LET g_cust_rec.data[l_cn].inna04=g_rtdx_d[l_ac].rtdx001_desc_1
         LET g_cust_rec.data[l_cn].inna05=g_rtdx_d[l_ac].imaa009
         LET g_cust_rec.data[l_cn].inna06=g_rtdx_d[l_ac].imaa009_desc         
         LET g_cust_rec.data[l_cn].inna07=g_rtdx_d[l_ac].imaa126
         LET g_cust_rec.data[l_cn].inna08=g_rtdx_d[l_ac].imaa126_desc
         LET g_cust_rec.data[l_cn].inna09=g_rtdx_d[l_ac].rtdx012
         LET g_cust_rec.data[l_cn].inna10=g_rtdx_d[l_ac].imaa105
         LET l_str3  = g_rtdx_d[l_ac].rtdx016
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna11=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx017
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna12=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx018
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna13=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx019
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna14=l_str3
         LET g_cust_rec.data[l_cn].inna15=g_rtdx_d[l_ac].rtdx022
         LET g_cust_rec.data[l_cn].inna16=g_rtdx_d[l_ac].rtdx023
         LET l_str3  = g_rtdx_d[l_ac].rtdx020
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna17=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx021
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna18=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx038
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna19=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx039
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna20=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx040
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna21=l_str3
         LET l_str3  = g_rtdx_d[l_ac].rtdx034
         LET l_str3  = l_str3.subString(1,l_str3.getLength()-4)
         LET g_cust_rec.data[l_cn].inna22=l_str3
         LET g_cust_rec.data[l_cn].inna23=g_name
         LET g_cust_rec.data[l_cn].inna27=g_rtdx_d[l_ac].imaa105_desc
         let g_cust_rec.data[l_cn].inna36=g_rtdx_d[l_ac].rtdx058
         let g_cust_rec.data[l_cn].inna37=g_rtdx_d[l_ac].rtdx059
         let g_cust_rec.data[l_cn].inna38=g_rtdx_d[l_ac].rtdx060
         let g_cust_rec.data[l_cn].inna39=g_rtdx_d[l_ac].rtdx056
         let g_cust_rec.data[l_cn].inna40=g_rtdx_d[l_ac].rtdx057
         let g_cust_rec.data[l_cn].inna41=g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx001_desc
      END IF       
   END FOR
   
   LET l_time = cl_get_timestamp()
   LET l_str = l_time
   LET l_str1 = l_str[1,4],l_str[6,7],l_str[9,10],l_str[12,13],l_str[15,16],l_str[18,19],l_str[21,25]

   LET l_str = l_str1,".dt"
   #LET ls = "{'id' : '",l_str,"', 'template' : '",g_rtdy001,".svg' , 'data' : [",ls," ] }" 
   LET g_str = l_str1
   
   LET l_dir = FGL_GETENV("TEMPDIR"),"/",l_str
   LET l_c ="touch ",l_dir
   RUN l_c
   
   LET g_cust_rec.id = l_str1  
   LET g_cust_rec.template = g_rtdy001,".svg" 
  
   
   LET obj = util.JSONObject.fromFGL(g_cust_rec)
#產生json string
   LET p_content = obj.toString()
   LET l_json_path = os.Path.join(FGL_GETENV("TEMPDIR"), l_str)
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter("")
   CALL l_channel.openFile(l_json_path,"w")
   CALL l_channel.write(p_content)
   CALL l_channel.close()
   #parm1: 模版文件下载路径
   #parm2: 数据文件下载路径
   LET parm1 = FGL_GETENV("FGLASIP"),"/components/tag/templates/",g_rtdy001,".svg"
   LET parm2 = FGL_GETENV("FGLASIP"),"/out/",l_str
  # LET path =  "cmd.exe /C:\\T100\\tag\\TPrinter.exe \"test\" \"test2\""
   LET parm3 = FGL_GETENV("FGLASIP"),"/components/tag/config.csv"
   LET path =  "C:\\\\T100\\tag\\TPrinter.exe ",parm1," ",parm2," ",parm3
   CALL ui.interface.frontCall("standard", "execute", [path,0],[l_result]);
   
END FUNCTION

################################################################################
# Descriptions...: 修改
# Memo...........:
# Usage..........: CALL artq520_modify()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150622 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_modify()
DEFINE  l_cmd                  LIKE type_t.chr1
DEFINE  l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT 
DEFINE  l_n                    LIKE type_t.num5                #檢查重複用  
DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用  
DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
DEFINE  l_count                LIKE type_t.num5
DEFINE  ls_return              STRING
DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
DEFINE  l_fields               DYNAMIC ARRAY OF STRING
DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
DEFINE  li_reproduce           LIKE type_t.num5
DEFINE  li_reproduce_target    LIKE type_t.num5
DEFINE  lb_reproduce           BOOLEAN
DEFINE  l_sql                  STRING
DEFINE  r_success              LIKE type_t.num5
DEFINE  r_errno                LIKE type_t.chr50
DEFINE  l_stdb002              LIKE stdb_t.stdb002
DEFINE  l_stdb007              LIKE stdb_t.stdb007
DEFINE  l_stdbstus             LIKE stdb_t.stdbstus
DEFINE  l_insert               BOOLEAN
DEFINE  l_site                 LIKE rtdx_t.rtdxsite
DEFINE  l_i                    LIKE type_t.num10
DEFINE  ls_sql                 STRING
DEFINE  r_insert               LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5 
DEFINE l_errno       LIKE type_t.chr10
#end add-point
   #add-point:modify段define-客製

   #end add-point
 
   #add-point:modify段control
   LET g_action_choice = ""

   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   
  
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_rtdx_d FROM s_detail1.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
                  
         BEFORE INPUT
            #单身没资料关闭单身
#            IF g_rtdx_d.getLength() = 0  THEN
#               EXIT DIALOG
#            END IF 
            
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtdx_d.getLength()+1) 
              LET g_insert = 'N' 
            END IF 
 
            #CALL artq520_b_fill()
            LET g_detail_cnt = g_rtdx_d.getLength()
         
            
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.h_index
            DISPLAY g_rtdx_d.getLength() TO FORMONLY.h_count
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_rtdx_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_rtdx_d[l_ac].sel IS NOT NULL
               AND g_rtdx_d[l_ac].seq IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*
            ELSE
               LET l_cmd='a'
            END IF   
            IF l_cmd = 'a' THEN               
             #  CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
         BEFORE INSERT
            
            LET l_cmd = 'a'
            INITIALIZE g_rtdx_d[l_ac].* TO NULL
            INITIALIZE g_rtdx_d_t.* TO NULL            
            #公用欄位給值(單身2)
            LET g_rtdx_d[l_ac].sel = 'Y'
            LET g_rtdx_d[l_ac].seq = l_ac
            LET g_rtdx_d[l_ac].count = g_number
            
            LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*
            #add-point:modify段before備份

            #end add-point
            CALL cl_show_fld_cont()
         
         
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
         
         ON ACTION controlp INFIELD b_imaf153
            
           
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf153  #顯示到畫面上

            NEXT FIELD b_imaf153 
            
         ON ACTION controlp INFIELD b_rtdx002
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值
            IF NOT cl_null(g_rtdxsite) THEN
               LET g_qryparam.arg1 = g_rtdxsite
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            #給予arg
            CALL q_imay003_8()                                #呼叫開窗

            LET g_rtdx_d[l_ac].rtdx002 = g_qryparam.return1              

            DISPLAY g_rtdx_d[l_ac].rtdx002 TO b_rtdx002             #顯示到畫面上

            NEXT FIELD b_rtdx002
         
         AFTER FIELD b_rtdx002
            IF NOT cl_null(g_rtdx_d[l_ac].rtdx002) THEN
               LET l_cnt = 0
               IF NOT cl_null(g_rtdxsite) THEN
                  LET l_site = g_rtdxsite
               ELSE
                  LET l_site = g_site
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM imay_t LEFT OUTER JOIN imaa_t ON imaa001=imay001 AND imaaent = imayent,rtdx_t
                WHERE rtdx001 = imay001
                  AND imayent = rtdxent
                  AND imayent = g_enterprise
                  AND rtdxstus='Y'
                  AND rtdxsite = l_site 
                  AND imay003 =  g_rtdx_d[l_ac].rtdx002                
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00152'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
               IF g_rtdx_d_t.rtdx002 != g_rtdx_d[l_ac].rtdx002 OR l_cmd ='a'  THEN
                  CALL artq510_rtdx002_init(l_site)
               END IF   
               LET g_rtdx_d_t.rtdx002 = g_rtdx_d[l_ac].rtdx002
               LET g_rtdx_d_t.rtdx001 = g_rtdx_d[l_ac].rtdx001
            END IF

         ON ACTION controlp INFIELD b_rtdx001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值
            IF NOT cl_null(g_rtdxsite) THEN
               LET g_qryparam.arg1 = g_rtdxsite
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            #給予arg
            CALL q_rtdx001_1()                                #呼叫開窗

            LET g_rtdx_d[l_ac].rtdx001 = g_qryparam.return1              

            DISPLAY g_rtdx_d[l_ac].rtdx001 TO b_rtdx001             #顯示到畫面上

            NEXT FIELD b_rtdx001
         
         AFTER FIELD b_rtdx001
            IF NOT cl_null(g_rtdx_d[l_ac].rtdx001) THEN
               LET l_cnt = 0
               IF NOT cl_null(g_rtdxsite) THEN
                  LET l_site = g_rtdxsite
               ELSE
                  LET l_site = g_site
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtdx_t,imaa_t
                WHERE rtdx001 = imaa001
                  AND imaaent = rtdxent
                  AND rtdxent = g_enterprise
                  AND rtdxstus='Y'
                  AND rtdxsite = l_site 
                  AND rtdx001 = g_rtdx_d[l_ac].rtdx001                  
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00151'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
               IF g_rtdx_d_t.rtdx001 != g_rtdx_d[l_ac].rtdx001 OR l_cmd ='a' THEN
                  CALL artq510_rtdx001_init(l_site)
               END IF   
               LET g_rtdx_d_t.rtdx002 = g_rtdx_d[l_ac].rtdx002
               LET g_rtdx_d_t.rtdx001 = g_rtdx_d[l_ac].rtdx001
               
            END IF            
            
         AFTER ROW
#            CALL astq730_unlock_b("stde_t")
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
#               IF l_cmd = 'u' THEN
#                  LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
#               END IF       
               EXIT DIALOG 
            END IF
            #其他table進行unlock
            
             #add-point:單身after row

            #end add-point
            
         AFTER INPUT
            #add-point:單身input後

            #end add-point
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_rtdx_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_rtdx_d.getLength()+1
            
      END INPUT
      
      #add-point:before_more_input
      INPUT g_rtdy001,g_number,g_rtdxsite FROM rtdy001,number,rtdxsite  
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
         IF g_number = 0 THEN
            LET g_number = 1
         END IF
         #add by geza 20150824(S)
         IF cl_null(g_rtdxsite) THEN
            CALL s_aooi500_default(g_prog,'rtdxsite',g_rtdxsite) RETURNING r_insert,g_rtdxsite
            IF NOT r_insert THEN
               RETURN 
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
         END IF   
         #add by geza 20150824(E)
         DISPLAY g_rtdy001,g_number,g_rtdxsite,g_rtdxsite_desc TO rtdy001,number,rtdxsite,rtdxsite_desc
          
          
         #add by geza 20150824(S)
         ON ACTION controlp INFIELD rtdxsite
            #add-point:ON ACTION controlp INFIELD rtdusite
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #ken---add---str 需求單號：141208-00001 項次：14
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdusite             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdxsite',g_site,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtdxsite = g_qryparam.return1              

            DISPLAY g_rtdxsite TO  rtdxsite             #
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc

            
            NEXT FIELD rtdxsite        
          
         AFTER FIELD rtdxsite
            IF NOT cl_null(g_rtdxsite) THEN
               CALL s_aooi500_chk(g_prog,'rtdxsite',g_rtdxsite,g_site)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
         #add by geza 20150824(E)
         
         
         ON ACTION controlp INFIELD rtdy001
            #add-point:ON ACTION controlp INFIELD rtdudocno
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add       
            LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_rtdu_m.rtdy001             #給予default值

            #給予arg
            LET g_qryparam.where = " rtdystus = 'Y' "
            #add by geza 20150824(S)
            IF g_rtdxsite IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM rtdz_t WHERE rtdzent = ",g_enterprise," AND rtdz001 = rtdy001 AND rtdzstus = 'Y'  AND rtdz002 = '",g_rtdxsite,"')"
            END IF 
            #add by geza 20150824(E)
            CALL q_rtdy001()                                #呼叫開窗

            LET g_rtdy001 = g_qryparam.return1              

            DISPLAY g_rtdy001 TO rtdy001             #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
            
            NEXT FIELD rtdy001
         
         AFTER FIELD rtdy001
            IF NOT cl_null(g_rtdy001) THEN
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM rtdy_t 
                WHERE rtdyent = g_enterprise
                  AND rtdy001 = g_rtdy001             
                  AND rtdystus = 'Y'
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'art-00631'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                 
                  NEXT FIELD CURRENT
               
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtdxsite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtdxsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_rtdxsite_desc TO  rtdxsite_desc
            
         AFTER FIELD number
            IF g_number IS NOT NULL THEN
               FOR l_i = 1 TO g_rtdx_d.getLength() STEP 1
                  LET g_rtdx_d[l_i].count = g_number
                  DISPLAY g_rtdx_d[l_i].count TO count                   
               END FOR         
            END IF   
            
            
         AFTER INPUT
      END INPUT
      #add-point:單身input後
      
      #end add-point 
      #end add-point
      
      BEFORE DIALOG 

         LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog

         #end add-point

   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         IF l_cmd = 'a'  THEN
            CALL g_rtdx_d.deleteElement(l_ac) 
         END IF
         IF l_cmd = 'u' THEN
            LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
         END IF
         EXIT DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
   
   #add-point:modify段修改後
 
  
END FUNCTION

################################################################################
# Descriptions...: 商品条码带值
# Memo...........:
# Usage..........: CALL artq510_rtdx002_init(p_site)
#                  RETURNING 回传参数
# Date & Author..: 20150630 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_rtdx002_init(p_site)
DEFINE  l_imaa001   LIKE imaa_t.imaa001
DEFINE  l_imaa108   LIKE imaa_t.imaa108
DEFINE  p_site                 LIKE rtdx_t.rtdxsite
DEFINE  l_sql       STRING 
   SELECT imaa108,imaa001 INTO l_imaa108,l_imaa001 
     FROM imaa_t,imay_t
    WHERE imaa001 = imay001 
      AND imaaent = imayent
      AND imay003 = g_rtdx_d[l_ac].rtdx002 
   LET g_rtdx_d[l_ac].rtdx001 =  l_imaa001 
   IF l_imaa108 != 3 THEN
      LET l_sql = "SELECT imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,imay004,oocal003,(rtdx016*imay005),(rtdx017*imay005),(rtdx018*imay005),(rtdx019*imay005), 
                   rtdx023,rtdx022,(rtdx020*imay005),(rtdx021*imay005),(rtdx038*imay005),(rtdx039*imay005),(rtdx040*imay005),((CASE WHEN ( '",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) THEN rtdx021 ELSE rtdx016 END)*imay005)",
                  " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' )
                                LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                                LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,imay_t LEFT JOIN oocal_t ON (oocalent = imayent AND oocal001 = imay004 AND oocal002 = '"||g_dlang||"' ) ",
                  " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
                  "   AND imaaent = imayent AND imaa001 = imay001 ",  
                  "   AND rtdxsite = '",p_site,"'",  
                  "   AND imaaent = ",g_enterprise," ",
                  "   AND imay003 ='",g_rtdx_d[l_ac].rtdx002,"'" 
      PREPARE artq510_rtdx002_pre FROM l_sql
      EXECUTE artq510_rtdx002_pre INTO g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].imaa009, 
             g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx012, 
             g_rtdx_d[l_ac].imaa105,g_rtdx_d[l_ac].imaa105_desc,g_rtdx_d[l_ac].rtdx016,g_rtdx_d[l_ac].rtdx017, 
             g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022,g_rtdx_d[l_ac].rtdx020, 
             g_rtdx_d[l_ac].rtdx021,g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040,g_rtdx_d[l_ac].rtdx034 
      IF g_today >= g_rtdx_d[l_ac].rtdx022 AND g_rtdx_d[l_ac].rtdx023 >= g_today THEN
         LET g_rtdx_d[l_ac].check = '2'
      ELSE
         LET g_rtdx_d[l_ac].check = '1'
      END IF
      IF g_rtdx_d[l_ac].check = '2' THEN
         IF g_rtdx_d[l_ac].rtdx021 = g_rtdx_d[l_ac].rtdx038 THEN
            LET g_rtdx_d_colour[l_ac].sel = "red reverse"
            LET g_rtdx_d_colour[l_ac].seq = "red reverse"
            LET g_rtdx_d_colour[l_ac].count  = "red reverse"
            LET g_rtdx_d_colour[l_ac].check  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx002  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa009  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa126  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx012  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa105  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx016  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx017  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx018  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx019  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx023  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx022  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx020  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx021  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx038  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx039  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx040  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx034  = "red reverse"
         ELSE
            LET g_rtdx_d_colour[l_ac].sel = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].seq = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].count  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].check  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx002  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa009  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa126  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx012  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa105  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx016  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx017  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx018  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx019  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx023  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx022  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx020  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx021  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx038  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx039  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx040  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx034  = "yellow reverse"         
         END IF
      ELSE   
         IF g_rtdx_d[l_ac].rtdx016 != g_rtdx_d[l_ac].rtdx017 THEN
            LET g_rtdx_d_colour[l_ac].sel = "blue reverse"
            LET g_rtdx_d_colour[l_ac].seq = "blue reverse"
            LET g_rtdx_d_colour[l_ac].count  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].check  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx002  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa009  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa126  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx012  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa105  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx016  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx017  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx018  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx019  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx023  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx022  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx020  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx021  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx038  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx039  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx040  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx034  = "blue reverse"
         END IF         
      END IF       
   ELSE
      LET l_sql = " SELECT imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,prbh006,oocal003,prbh012,prbh013,prbh014,prbh015, 
                    prbh018,prbh019,CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),prbh012",
                   " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
                                 LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                                 LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,prbh_t LEFT JOIN oocal_t ON (oocalent = prbhent AND oocal001 = prbh006 AND oocal002 = '"||g_dlang||"' )  ",
                   " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
                   "   AND imaaent = prbhent AND imaa001 = prbh003",
                   "   AND rtdxsite = '",p_site,"'", 
                   "   AND imaaent = ",g_enterprise,
                   "   AND prbh004 ='",g_rtdx_d[l_ac].rtdx002,"'"     
      PREPARE artq510_rtdx002_pre1 FROM l_sql
      EXECUTE artq510_rtdx002_pre1 INTO g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].imaa009, 
              g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx012, 
              g_rtdx_d[l_ac].imaa105,g_rtdx_d[l_ac].imaa105_desc,g_rtdx_d[l_ac].rtdx016,g_rtdx_d[l_ac].rtdx017, 
              g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022,g_rtdx_d[l_ac].rtdx020, 
              g_rtdx_d[l_ac].rtdx021,g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040,g_rtdx_d[l_ac].rtdx034
      LET g_rtdx_d[l_ac].check = '1'  
      IF g_rtdx_d[l_ac].rtdx016 != g_rtdx_d[l_ac].rtdx017 THEN
         LET g_rtdx_d_colour[l_ac].sel = "blue reverse"
         LET g_rtdx_d_colour[l_ac].seq = "blue reverse"
         LET g_rtdx_d_colour[l_ac].count  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].check  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx002  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa009  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa009_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa126  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa126_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx012  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa105  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa105_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx016  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx017  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx018  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx019  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx023  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx022  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx020  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx021  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx038  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx039  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx040  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx034  = "blue reverse"       
      END IF                 
   END IF

END FUNCTION

################################################################################
# Descriptions...: 商品编号带值
# Memo...........:
# Usage..........: CALL artq510_rtdx001_init(p_site)
#                  RETURNING 回传参数
# Date & Author..: 20150630 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_rtdx001_init(p_site)
DEFINE  l_imay003   LIKE imay_t.imay003
DEFINE  l_imaa108   LIKE imaa_t.imaa108
DEFINE  p_site                 LIKE rtdx_t.rtdxsite
DEFINE  l_sql       STRING 
   SELECT imaa108,imay003 INTO l_imaa108,l_imay003 
     FROM imaa_t,imay_t
    WHERE imaa001 = imay001 
      AND imaaent = imayent
      AND imaaent = g_enterprise
      AND imaa001 = g_rtdx_d[l_ac].rtdx001 
      AND imay006 = 'Y'
   LET g_rtdx_d[l_ac].rtdx002 =  l_imay003 
   IF l_imaa108 != 3 THEN
      LET l_sql = "SELECT imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,imay004,oocal003,(rtdx016*imay005),(rtdx017*imay005),(rtdx018*imay005),(rtdx019*imay005), 
                   rtdx023,rtdx022,(rtdx020*imay005),(rtdx021*imay005),(rtdx038*imay005),(rtdx039*imay005),(rtdx040*imay005),((CASE WHEN ( '",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) THEN rtdx021 ELSE rtdx016 END)*imay005)",
                  " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' )                               
                                LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                                LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,imay_t LEFT JOIN oocal_t ON (oocalent = imayent AND oocal001 = imay004 AND oocal002 = '"||g_dlang||"' )",
                  " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
                  "   AND imaaent = imayent AND imaa001 = imay001 ",  
                  "   AND rtdxsite = '",p_site,"'",  
                  "   AND imaaent = ",g_enterprise," ",
                  "   AND imaa001 ='",g_rtdx_d[l_ac].rtdx001,"'",
                  "   AND imay003 ='",g_rtdx_d[l_ac].rtdx002,"'"                  
      PREPARE artq510_rtdx001_pre FROM l_sql
      EXECUTE artq510_rtdx001_pre INTO g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].imaa009, 
             g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx012, 
             g_rtdx_d[l_ac].imaa105,g_rtdx_d[l_ac].imaa105_desc,g_rtdx_d[l_ac].rtdx016,g_rtdx_d[l_ac].rtdx017, 
             g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022,g_rtdx_d[l_ac].rtdx020, 
             g_rtdx_d[l_ac].rtdx021,g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040,g_rtdx_d[l_ac].rtdx034
      IF g_today >= g_rtdx_d[l_ac].rtdx022 AND g_rtdx_d[l_ac].rtdx023 >= g_today THEN
         LET g_rtdx_d[l_ac].check = '2'
      ELSE
         LET g_rtdx_d[l_ac].check = '1'
      END IF     
      IF g_rtdx_d[l_ac].check = '2' THEN
         IF g_rtdx_d[l_ac].rtdx021 = g_rtdx_d[l_ac].rtdx038 THEN
            LET g_rtdx_d_colour[l_ac].sel = "red reverse"
            LET g_rtdx_d_colour[l_ac].seq = "red reverse"
            LET g_rtdx_d_colour[l_ac].count  = "red reverse"
            LET g_rtdx_d_colour[l_ac].check  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx002  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa009  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa126  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx012  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa105  = "red reverse"
            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx016  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx017  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx018  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx019  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx023  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx022  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx020  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx021  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx038  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx039  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx040  = "red reverse"
            LET g_rtdx_d_colour[l_ac].rtdx034  = "red reverse"
         ELSE
            LET g_rtdx_d_colour[l_ac].sel = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].seq = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].count  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].check  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx002  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa009  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa126  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx012  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa105  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx016  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx017  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx018  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx019  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx023  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx022  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx020  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx021  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx038  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx039  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx040  = "yellow reverse"
            LET g_rtdx_d_colour[l_ac].rtdx034  = "yellow reverse"         
         END IF
      ELSE   
         IF g_rtdx_d[l_ac].rtdx016 != g_rtdx_d[l_ac].rtdx017 THEN
            LET g_rtdx_d_colour[l_ac].sel = "blue reverse"
            LET g_rtdx_d_colour[l_ac].seq = "blue reverse"
            LET g_rtdx_d_colour[l_ac].count  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].check  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx002  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa009  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa126  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx012  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa105  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx016  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx017  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx018  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx019  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx023  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx022  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx020  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx021  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx038  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx039  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx040  = "blue reverse"
            LET g_rtdx_d_colour[l_ac].rtdx034  = "blue reverse"
         END IF         
      END IF             
   ELSE
      LET l_sql = " SELECT imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,prbh006,oocal003,prbh012,prbh013,prbh014,prbh015, 
                    prbh018,prbh019,CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),prbh012",
                   " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
                                 LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                                 LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,prbh_t LEFT JOIN oocal_t ON (oocalent = prbhent AND oocal001 = prbh006 AND oocal002 = '"||g_dlang||"' )  ",
                   " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
                   "   AND imaaent = prbhent AND imaa001 = prbh003",
                   "   AND rtdxsite = '",p_site,"'", 
                   "   AND imaaent = ",g_enterprise,
                   "   AND imaa001 ='",g_rtdx_d[l_ac].rtdx001,"'", 
                   "   AND prbh004 ='",g_rtdx_d[l_ac].rtdx002,"'"                     
      PREPARE artq510_rtdx001_pre1 FROM l_sql
      EXECUTE artq510_rtdx001_pre1 INTO g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1,g_rtdx_d[l_ac].imaa009, 
              g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc,g_rtdx_d[l_ac].rtdx012, 
              g_rtdx_d[l_ac].imaa105,g_rtdx_d[l_ac].imaa105_desc,g_rtdx_d[l_ac].rtdx016,g_rtdx_d[l_ac].rtdx017, 
              g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022,g_rtdx_d[l_ac].rtdx020, 
              g_rtdx_d[l_ac].rtdx021,g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040,g_rtdx_d[l_ac].rtdx034
      LET g_rtdx_d[l_ac].check = '1'  
      IF g_rtdx_d[l_ac].rtdx016 != g_rtdx_d[l_ac].rtdx017 THEN
         LET g_rtdx_d_colour[l_ac].sel = "blue reverse"
         LET g_rtdx_d_colour[l_ac].seq = "blue reverse"
         LET g_rtdx_d_colour[l_ac].count  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].check  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx002  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa009  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa009_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa126  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa126_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx012  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa105  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa105_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx016  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx017  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx018  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx019  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx023  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx022  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx020  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx021  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx038  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx039  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx040  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx034  = "blue reverse"       
      END IF             
   END IF

END FUNCTION

################################################################################
# Descriptions...: 单身查询
# Memo...........:
# Usage..........: CALL artq510_b_fill_1()
# Date & Author..: 20150702 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artq510_b_fill_1()
DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準
   DEFINE l_cn            LIKE type_t.num10  
   DEFINE ls              STRING
   DEFINE l_where1        STRING
   DEFINE l_where2        STRING
   DEFINE l_where3        STRING
   DEFINE l_str        LIKE type_t.chr50
   DEFINE l_str1       STRING
   DEFINE l_str2       STRING
   DEFINE l_dir        STRING
   DEFINE l_json_path STRING
   DEFINE ls_tmp      STRING
   DEFINE l_channel   base.Channel
   DEFINE obj util.JSONObject 
   DEFINE l_c                     STRING
   DEFINE p_content   STRING
   DEFINE l_time      DATETIME YEAR TO FRACTION(5)   

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   #160126-00002#3 s983961--mod(s)
   #IF cl_null(g_wc2) THEN
   #   LET g_wc2 = " 1=1"
   #END IF   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   SELECT ooag011 into g_name  from ooag_t where ooagent =g_enterprise  and ooag001=g_user
   #LET ls_wc = g_wc3, " AND ", g_wc2, " AND ", g_wc_filter
   LET ls_wc = g_wc3, " AND ", g_wc, " AND ", g_wc_filter
   #160126-00002#3 s983961--mod(e)
 
   #add-point:陣列清空
   INITIALIZE ls TO NULL
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1+g_rtdx_d.getLength() 
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:4)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql_after
   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
      LET l_where1 = " AND EXISTS (SELECT 1 FROM rtaw_t,rtax_t ",
                     " WHERE rtawent = rtaxent AND rtaxent = ",g_enterprise,
                     "   AND rtaw002 = imaa009 AND rtax004 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' AND ",g_wc3,")"
                  
   END IF 
   LET l_where2 = "  AND EXISTS (SELECT 1 FROM prbk_t ",
                  "  WHERE prbkent = rtdxent AND prbksite = rtdxsite ",
                  "  AND prbksite = rtdxsite AND prbk010 = rtdx001 ",
                  "  AND (prbk006 = '",g_today,"' OR prbk007 = '",g_today,"') ",
                  "  AND prbkstus = '2') "  
   LET l_where3 = "  AND EXISTS (SELECT 1 FROM prbk_t ",
                  "  WHERE prbkent = rtdxent AND prbksite = rtdxsite ",
                  "  AND prbksite = rtdxsite AND prbk010 = rtdx001 AND prbk011 = prbh004 ",
                  "  AND (prbk006 = '",g_today,"' OR prbk007 = '",g_today,"') ",
                  "  AND prbkstus = '2') "                          

   LET g_sql = "SELECT 'Y','",l_cn,"','1','',imay003,imaf153,'',imaa001,imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa151,imaa152,imaa153,imaa123,imaa130,imaa150,imaa105,oocal003,(rtdx016*imay005),(rtdx017*imay005),(rtdx018*imay005),(rtdx019*imay005), 
                rtdx023,rtdx022,(rtdx020*imay005),(rtdx021*imay005),(rtdx038*imay005),(rtdx039*imay005),(rtdx040*imay005),((CASE WHEN ( '",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) THEN rtdx021 ELSE rtdx016 END)*imay005)", #add  by 06529 15/07/19(单身添加两个栏位，供应商编号及名称) 
               " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' )
                             LEFT JOIN oocal_t ON (oocalent = imaaent AND oocal001 = imaa105 AND oocal002 = '"||g_dlang||"' )                      
                             LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                             LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )  ,rtdx_t,imaf_t,imay_t",
               " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
               "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite ",
               "   AND imaa108 in ('1','4') ",
               "   AND imaaent = imayent AND imaa001 = imay001 ",  
               "   AND imafsite = '",g_rtdxsite,"'",  
               "   AND imaaent = ? ",               
               #" AND ",g_wc2 #160126-00002#3 s983961--mark
                " AND ",g_wc  #160126-00002#3 s983961--add
   IF g_checkbox = 'N'  THEN      
      LET g_sql = g_sql," AND imay006 = 'Y'" 
   END IF    
   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
      LET g_sql = g_sql,l_where1 
   END IF    
   #(IF 价格选项=1，抓rtdx022为空 OR g_taday不在rtdx022和rtdx023之间的资料；
   #IF 价格选项=2，抓g_today在rtdx022和rtdx023之间的资料) 
   #mark by geza 20150826(S)   
#   IF g_combobox_1 = '1' THEN   
#      LET g_sql = g_sql," AND (rtdx022 IS NULL OR ('",g_today,"'< rtdx022 OR '",g_today,"' > rtdx023 ))" 
#   END IF    
#   IF g_combobox_1 = '2' THEN   
#      LET g_sql = g_sql," AND ('",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 ) " 
#   END IF  
   #mark by geza 20150826(E)
   #add by geza 20150826(S)
   #1.售价: 没有促销价AND会员价=售价
   #2.促销价: 有促销价AND 促销会员价=促销价
   #3.会员价: 没有促销价 AND 会员价<>售价
   #4.促销会员价： 有促销价AND 促销会员价<>促销价
   IF g_combobox_1 = '1' THEN   
      LET g_sql = g_sql," AND (rtdx022 IS NULL OR ('",g_today,"'< rtdx022 OR '",g_today,"' > rtdx023 ))  AND rtdx016 = rtdx017 "  
   END IF    
   IF g_combobox_1 = '2' THEN   
      LET g_sql = g_sql," AND ('",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 )  AND rtdx021 = rtdx038 " 
   END IF 
   IF g_combobox_1 = '3' THEN   
      LET g_sql = g_sql," AND (rtdx022 IS NULL OR ('",g_today,"'< rtdx022 OR '",g_today,"' > rtdx023 ))  AND rtdx016 != rtdx017 " 
   END IF   
   IF g_combobox_1 = '4' THEN   
      LET g_sql = g_sql," AND ('",g_today,"' >= rtdx022 AND '",g_today,"' <= rtdx023 )  AND rtdx021 != rtdx038 " 
   END IF      
   #add by geza 20150826(E)
   IF g_checkbox_2 = 'Y' THEN 
      LET g_sql = g_sql,l_where2
   END IF    
   #mark by geza 20150826(S)    
#   LET g_sql = g_sql, " UNION ALL SELECT 'Y','",l_cn,"','1','1',prbh004,imaa001,imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa123,imaa105,oocal003,prbh012,prbh013,prbh014,prbh015, 
#             prbh018,prbh019,CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),prbh012",
#           " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
#                         LEFT JOIN oocal_t ON (oocalent = imaaent AND oocal001 = imaa105 AND oocal002 = '"||g_dlang||"' )
#                         LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
#                         LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )   ,rtdx_t,imaf_t,prbh_t ",
#           " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
#           "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite",
#           "   AND imaa108 = 3 ",
#           "   AND imaaent = prbhent AND imaa001 = prbh003",
#           "   AND imafsite = '",g_rtdxsite,"'", 
#           "   AND imaaent = ",g_enterprise,
#           "   AND ",g_wc2
   #mark by geza 20150826(E)
   #add by geza 20150825(S)
   #按斤打印价格除以2
   IF g_checkbox_3 = 'Y' THEN
      LET g_sql = g_sql, " UNION ALL SELECT 'Y','",l_cn,"','1','1',prbh004,imaf153,'',imaa001,imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,imaa151,imaa152,imaa153,imaa123,imaa130,imaa150,imaa105,oocal003,CAST(prbh012/2 as number(20, 6)),CAST(prbh013/2 as number(20, 6)),CAST(prbh014/2 as number(20, 6)),CAST(prbh015/2 as number(20, 6)),   
                prbh018,prbh019,CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST(prbh012/2 as number(20, 6))", #add  by 06529 15/07/19(单身添加两个栏位，供应商编号及名称) 
              " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
                            LEFT JOIN oocal_t ON (oocalent = imaaent AND oocal001 = imaa105 AND oocal002 = '"||g_dlang||"' )
                            LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                            LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )   ,rtdx_t,imaf_t,prbh_t ",
              " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
              "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite",
              "   AND imaa108 = 3 ",
              "   AND imaaent = prbhent AND imaa001 = prbh003",
              "   AND imafsite = '",g_rtdxsite,"'", 
              "   AND imaaent = ",g_enterprise,
              #" AND ",g_wc2 #160126-00002#3 s983961--mark
              " AND ",g_wc  #160126-00002#3 s983961--add
   ELSE
      LET g_sql = g_sql, " UNION ALL SELECT 'Y','",l_cn,"','1','1',prbh004,imaf153,'',imaa001,imaal003,imaal004,imaa009,rtaxl003,imaa126,oocql004,rtdx058,rtdx059,rtdx060,imaa123,rtdx056,rtdx057,imaa105,oocal003,prbh012,prbh013,prbh014,prbh015, 
             prbh018,prbh019,CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),CAST('' as number(20, 6)),prbh012",
           " FROM imaa_t LEFT JOIN imaal_t ON (imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '"||g_dlang||"' ) 
                         LEFT JOIN oocal_t ON (oocalent = imaaent AND oocal001 = imaa105 AND oocal002 = '"||g_dlang||"' )
                         LEFT JOIN rtaxl_t ON (rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '"||g_dlang||"' )     
                         LEFT JOIN oocql_t ON (oocqlent = imaaent AND oocql001 = '2002'  AND oocql002 = imaa126  AND oocql003 = '"||g_dlang||"' )   ,rtdx_t,imaf_t,prbh_t ",
           " WHERE imaaent = rtdxent AND imaa001 = rtdx001 ",
           "   AND imaaent = imafent AND imaa001 = imaf001  AND rtdxsite = imafsite",
           "   AND imaa108 = 3 ",
           "   AND imaaent = prbhent AND imaa001 = prbh003",
           "   AND imafsite = '",g_rtdxsite,"'", 
           "   AND imaaent = ",g_enterprise,
           #" AND ",g_wc2 #160126-00002#3 s983961--mark
           " AND ",g_wc  #160126-00002#3 s983961--add
   END IF
   #add by geza 20150825(E)
   IF g_wc3 IS NOT NULL AND g_wc3 != " 1=1" THEN
      LET g_sql = g_sql,l_where1 
   END IF    
   IF g_checkbox_2 = 'Y' THEN 
      LET g_sql = g_sql,l_where3
   END IF     
   IF g_combobox_1 = '2' THEN   
      LET g_sql = g_sql," AND 1= 2 " 
   END IF    
   #1.售价: 会员价=售价
   #2.促销价: 没有
   #3.会员价:  会员价<>售价
   #4.促销会员价： 没有 
   #add by geza 20150826(S)
   IF g_combobox_1 = '1' THEN   
      LET g_sql = g_sql," AND prbh012 = prbh013 " 
   END IF
   IF g_combobox_1 = '3' THEN   
      LET g_sql = g_sql," AND prbh012 != prbh013 " 
   END IF
   IF g_combobox_1 = '4' THEN   
      LET g_sql = g_sql," AND 1= 2 " 
   END IF    
   #add by geza 20150826(E)
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq510_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR artq510_pb1
 
   OPEN b_fill_curs1 USING g_enterprise
 
   FOREACH b_fill_curs1 INTO g_rtdx_d[l_ac].sel,g_rtdx_d[l_ac].seq,g_rtdx_d[l_ac].count,g_rtdx_d[l_ac].check, 
       g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].imaf153,g_rtdx_d[l_ac].imaf153_desc,g_rtdx_d[l_ac].rtdx001,      #add by 06529 15/07/19 imaf153,imaf153_desc 
       g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_1, 
       g_rtdx_d[l_ac].imaa009,g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].imaa126,g_rtdx_d[l_ac].imaa126_desc, 
       g_rtdx_d[l_ac].rtdx058,g_rtdx_d[l_ac].rtdx059,g_rtdx_d[l_ac].rtdx060,g_rtdx_d[l_ac].rtdx012,g_rtdx_d[l_ac].rtdx056,g_rtdx_d[l_ac].rtdx057,g_rtdx_d[l_ac].imaa105,g_rtdx_d[l_ac].imaa105_desc,g_rtdx_d[l_ac].rtdx016, 
       g_rtdx_d[l_ac].rtdx017,g_rtdx_d[l_ac].rtdx018,g_rtdx_d[l_ac].rtdx019,g_rtdx_d[l_ac].rtdx023,g_rtdx_d[l_ac].rtdx022, 
       g_rtdx_d[l_ac].rtdx020,g_rtdx_d[l_ac].rtdx021,g_rtdx_d[l_ac].rtdx038,g_rtdx_d[l_ac].rtdx039,g_rtdx_d[l_ac].rtdx040, 
       g_rtdx_d[l_ac].rtdx034
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      #add by geza 20150911(S)
      #按斤打印的时候，单位KG转换成500g
      IF g_checkbox_3 = 'Y' THEN
         IF g_rtdx_d[l_ac].imaa105 ='KG' THEN
            LET g_rtdx_d[l_ac].imaa105 ='500g'
            LET g_rtdx_d[l_ac].imaa105_desc ='500g'
         END IF
      END IF
      #add by geza 20150911(E)
      #mark by geza 20150910(S)
#      IF cl_null(g_rtdx_d[l_ac].check) THEN
#         IF g_today >= g_rtdx_d[l_ac].rtdx022 AND g_rtdx_d[l_ac].rtdx023 >= g_today THEN
#            LET g_rtdx_d[l_ac].check = '2'
#         ELSE
#            LET g_rtdx_d[l_ac].check = '1'
#         END IF 
#      END IF
      #mark by geza 20150910(E)
      #1.售价: 没有促销价AND会员价=售价
      #2.促销价: 有促销价AND 促销会员价=促销价
      #3.会员价: 没有促销价 AND 会员价<>售价
      #4.促销会员价： 有促销价AND 促销会员价<>促销价
      #add by geza 20150910(S)
      IF g_today >= g_rtdx_d[l_ac].rtdx022 AND g_rtdx_d[l_ac].rtdx023 >= g_today AND g_rtdx_d[l_ac].rtdx021 = g_rtdx_d[l_ac].rtdx038  THEN    
         LET g_rtdx_d[l_ac].check = '2'
      END IF
      IF g_rtdx_d[l_ac].rtdx022 IS NULL OR (g_rtdx_d[l_ac].rtdx023 < g_today OR g_rtdx_d[l_ac].rtdx022 > g_today) AND g_rtdx_d[l_ac].rtdx016 = g_rtdx_d[l_ac].rtdx017  THEN    
         LET g_rtdx_d[l_ac].check = '1'
      END IF 
      IF g_today >= g_rtdx_d[l_ac].rtdx022 AND g_rtdx_d[l_ac].rtdx023 >= g_today AND g_rtdx_d[l_ac].rtdx021 != g_rtdx_d[l_ac].rtdx038  THEN    
         LET g_rtdx_d[l_ac].check = '4'
      END IF
      IF (g_rtdx_d[l_ac].rtdx022 IS NULL OR (g_rtdx_d[l_ac].rtdx023 < g_today OR g_rtdx_d[l_ac].rtdx022 > g_today)) AND g_rtdx_d[l_ac].rtdx016 != g_rtdx_d[l_ac].rtdx017  THEN    
         LET g_rtdx_d[l_ac].check = '3'
      END IF 
      #add by geza 20150910(E)
      LET g_rtdx_d[l_ac].seq = l_ac
      IF g_number IS NOT NULL THEN
         LET g_rtdx_d[l_ac].count = g_number                
      END IF  
      
      #add by 06529 15/07/19 (s)
         
      SELECT pmaal004 INTO g_rtdx_d[l_ac].imaf153_desc  #查找主供应商名称
        FROM pmaal_t
       WHERE pmaalent=g_enterprise
         AND pmaal002=g_dlang
         AND pmaal001= g_rtdx_d[l_ac].imaf153 
         
      #add by 06529 15/07/19 (e)
      
      #售价显示白色，促销价显示红色
      #mark by geza 20150914(S)
#      IF g_rtdx_d[l_ac].check = '2' THEN
#         IF g_rtdx_d[l_ac].rtdx021 = g_rtdx_d[l_ac].rtdx038 THEN
#            LET g_rtdx_d_colour[l_ac].sel = "red reverse"
#            LET g_rtdx_d_colour[l_ac].seq = "red reverse"
#            LET g_rtdx_d_colour[l_ac].count  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].check  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx002  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaf153  = "red reverse"        #add  by 06529 15/07/19
#            LET g_rtdx_d_colour[l_ac].imaf153_desc  = "red reverse"   #add  by 06529 15/07/19
#            LET g_rtdx_d_colour[l_ac].rtdx001  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaa009  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaa126  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx012  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaa105  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx016  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx017  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx018  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx019  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx023  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx022  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx020  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx021  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx038  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx039  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx040  = "red reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx034  = "red reverse"
#         ELSE
#            LET g_rtdx_d_colour[l_ac].sel = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].seq = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].count  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].check  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx002  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaf153  = "yellow reverse"        #add  by 06529 15/07/19
#            LET g_rtdx_d_colour[l_ac].imaf153_desc  = "yellow reverse"   #add  by 06529 15/07/19
#            LET g_rtdx_d_colour[l_ac].rtdx001  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaa009  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaa126  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx012  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaa105  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx016  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx017  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx018  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx019  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx023  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx022  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx020  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx021  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx038  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx039  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx040  = "yellow reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx034  = "yellow reverse"         
#         END IF
#      ELSE   
#         IF g_rtdx_d[l_ac].rtdx016 != g_rtdx_d[l_ac].rtdx017 THEN
#            LET g_rtdx_d_colour[l_ac].sel = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].seq = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].count  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].check  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx002  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaf153  = "blue reverse"        #add  by 06529 15/07/19
#            LET g_rtdx_d_colour[l_ac].imaf153_desc  = "blue reverse"   #add  by 06529 15/07/19
#            LET g_rtdx_d_colour[l_ac].rtdx001  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaa009  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaa009_desc  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaa126  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaa126_desc  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx012  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaa105  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].imaa105_desc  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx016  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx017  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx018  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx019  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx023  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx022  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx020  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx021  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx038  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx039  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx040  = "blue reverse"
#            LET g_rtdx_d_colour[l_ac].rtdx034  = "blue reverse"
#         END IF         
#      END IF    
      #mark by geza 20150914(E)
      #add by geza 20150914(S)
      #售价显示白色，促销价显示红色 会员价蓝色 促销会员价黄色
      IF g_rtdx_d[l_ac].check = '2' THEN
         LET g_rtdx_d_colour[l_ac].sel = "red reverse"
         LET g_rtdx_d_colour[l_ac].seq = "red reverse"
         LET g_rtdx_d_colour[l_ac].count  = "red reverse"
         LET g_rtdx_d_colour[l_ac].check  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx002  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaf153  = "red reverse"        #add  by 06529 15/07/19
         LET g_rtdx_d_colour[l_ac].imaf153_desc  = "red reverse"   #add  by 06529 15/07/19
         LET g_rtdx_d_colour[l_ac].rtdx001  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaa009  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaa009_desc  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaa126  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaa126_desc  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx012  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaa105  = "red reverse"
         LET g_rtdx_d_colour[l_ac].imaa105_desc  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx016  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx017  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx018  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx019  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx023  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx022  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx020  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx021  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx038  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx039  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx040  = "red reverse"
         LET g_rtdx_d_colour[l_ac].rtdx034  = "red reverse"
      END IF      
      IF g_rtdx_d[l_ac].check = '4' THEN
         LET g_rtdx_d_colour[l_ac].sel = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].seq = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].count  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].check  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx002  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaf153  = "yellow reverse"        #add  by 06529 15/07/19
         LET g_rtdx_d_colour[l_ac].imaf153_desc  = "yellow reverse"   #add  by 06529 15/07/19
         LET g_rtdx_d_colour[l_ac].rtdx001  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaa009  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaa009_desc  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaa126  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaa126_desc  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx012  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaa105  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].imaa105_desc  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx016  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx017  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx018  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx019  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx023  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx022  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx020  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx021  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx038  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx039  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx040  = "yellow reverse"
         LET g_rtdx_d_colour[l_ac].rtdx034  = "yellow reverse"         
      END IF
      IF g_rtdx_d[l_ac].check = '3' THEN
         LET g_rtdx_d_colour[l_ac].sel = "blue reverse"
         LET g_rtdx_d_colour[l_ac].seq = "blue reverse"
         LET g_rtdx_d_colour[l_ac].count  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].check  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx002  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaf153  = "blue reverse"        #add  by 06529 15/07/19
         LET g_rtdx_d_colour[l_ac].imaf153_desc  = "blue reverse"   #add  by 06529 15/07/19
         LET g_rtdx_d_colour[l_ac].rtdx001  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx001_desc_1  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa009  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa009_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa126  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa126_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx012  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa105  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].imaa105_desc  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx016  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx017  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx018  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx019  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx023  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx022  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx020  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx021  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx038  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx039  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx040  = "blue reverse"
         LET g_rtdx_d_colour[l_ac].rtdx034  = "blue reverse"
      END IF  
      #add by geza 20150914(E)     
      #end add-point
 
      CALL artq510_detail_show("'1'")
 
      CALL artq510_rtdx_t_mask()
 
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
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
   CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())
 
   #add-point:陣列長度調整
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtdx_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:2)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE artq510_pb
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL artq510_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL artq510_detail_action_trans()
 
   LET l_ac = 1
   CALL artq510_b_fill2()
 
      CALL artq510_filter_show('rtdx002','b_rtdx002')
   CALL artq510_filter_show('rtdx001','b_rtdx001')
   CALL artq510_filter_show('imaa009','b_imaa009')
   CALL artq510_filter_show('imaa126','b_imaa126')
   CALL artq510_filter_show('rtdx012','b_rtdx012')
   CALL artq510_filter_show('imaa105','b_imaa105')
   CALL artq510_filter_show('rtdx016','b_rtdx016')
   CALL artq510_filter_show('rtdx017','b_rtdx017')
   CALL artq510_filter_show('rtdx018','b_rtdx018')
   CALL artq510_filter_show('rtdx019','b_rtdx019')
   CALL artq510_filter_show('rtdx023','b_rtdx023')
   CALL artq510_filter_show('rtdx022','b_rtdx022')
   CALL artq510_filter_show('rtdx020','b_rtdx020')
   CALL artq510_filter_show('rtdx021','b_rtdx021')
   CALL artq510_filter_show('rtdx038','b_rtdx038')
   CALL artq510_filter_show('rtdx039','b_rtdx039')
   CALL artq510_filter_show('rtdx040','b_rtdx040')
   CALL artq510_filter_show('rtdx034','b_rtdx034')
END FUNCTION

 
{</section>}
 
