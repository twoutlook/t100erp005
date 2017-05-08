#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq604.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-28 10:58:18), PR版次:0002(2016-08-16 18:08:52)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: axcq604
#+ Description: 成本勾稽明細查詢作業
#+ Creator....: 02295(2016-03-28 10:58:18)
#+ Modifier...: 02295 -SD/PR- 07024
 
{</section>}
 
{<section id="axcq604.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160802-00020#8   2016/08/16  By dorislai 增加帳套權限管控、法人權限管控
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
PRIVATE TYPE type_g_xckl_d RECORD
       
       sel LIKE type_t.chr1, 
   xcklcomp LIKE xckl_t.xcklcomp, 
   xcklld LIKE xckl_t.xcklld, 
   xckl003 LIKE xckl_t.xckl003, 
   xckl004 LIKE xckl_t.xckl004, 
   xckl001 LIKE xckl_t.xckl001, 
   xckl002 LIKE xckl_t.xckl002, 
   xckl005 LIKE xckl_t.xckl005, 
   xckl005_desc LIKE type_t.chr500, 
   xckl006 LIKE xckl_t.xckl006, 
   xckl007 LIKE xckl_t.xckl007, 
   xckl007_desc LIKE type_t.chr500, 
   xckl007_desc_1 LIKE type_t.chr500, 
   xckl008 LIKE xckl_t.xckl008, 
   xckl009 LIKE xckl_t.xckl009, 
   xckl010 LIKE xckl_t.xckl010, 
   xckl101 LIKE xckl_t.xckl101, 
   xckl102 LIKE xckl_t.xckl102, 
   xckl103 LIKE xckl_t.xckl103, 
   xckl104 LIKE xckl_t.xckl104, 
   xckl105 LIKE xckl_t.xckl105, 
   xckl106 LIKE xckl_t.xckl106, 
   xckl090 LIKE xckl_t.xckl090, 
   xckl102a LIKE xckl_t.xckl102a, 
   xckl104a LIKE xckl_t.xckl104a, 
   xckl106a LIKE xckl_t.xckl106a, 
   xckl102b LIKE xckl_t.xckl102b, 
   xckl104b LIKE xckl_t.xckl104b, 
   xckl106b LIKE xckl_t.xckl106b, 
   xckl102c LIKE xckl_t.xckl102c, 
   xckl104c LIKE xckl_t.xckl104c, 
   xckl106c LIKE xckl_t.xckl106c, 
   xckl102d LIKE xckl_t.xckl102d, 
   xckl104d LIKE xckl_t.xckl104d, 
   xckl106d LIKE xckl_t.xckl106d, 
   xckl102e LIKE xckl_t.xckl102e, 
   xckl104e LIKE xckl_t.xckl104e, 
   xckl106e LIKE xckl_t.xckl106e, 
   xckl102f LIKE xckl_t.xckl102f, 
   xckl104f LIKE xckl_t.xckl104f, 
   xckl106f LIKE xckl_t.xckl106f, 
   xckl102g LIKE xckl_t.xckl102g, 
   xckl104g LIKE xckl_t.xckl104g, 
   xckl106g LIKE xckl_t.xckl106g, 
   xckl102h LIKE xckl_t.xckl102h, 
   xckl104h LIKE xckl_t.xckl104h, 
   xckl106h LIKE xckl_t.xckl106h
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_master RECORD 
   xcklcomp LIKE xckl_t.xcklcomp,
   xcklcomp_desc LIKE type_t.chr500,   
   xcklld LIKE xckl_t.xcklld,
   xcklld_desc LIKE type_t.chr500,   
   xckl003 LIKE xckl_t.xckl003, 
   xckl004 LIKE xckl_t.xckl004, 
   xckl001 LIKE xckl_t.xckl001, 
   xckl002 LIKE xckl_t.xckl002,
   xckl002_desc LIKE type_t.chr500   
       END RECORD
DEFINE g_master     type_g_master       
DEFINE g_wc_cs_ld            STRING          #160802-00020#8-add
DEFINE g_wc_cs_comp          STRING          #160802-00020#8-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xckl_d            DYNAMIC ARRAY OF type_g_xckl_d
DEFINE g_xckl_d_t          type_g_xckl_d
 
 
 
 
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
 
{<section id="axcq604.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   #160802-00020#8-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#8-add-(E)
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
   DECLARE axcq604_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq604_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq604_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq604 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq604_init()   
 
      #進入選單 Menu (="N")
      CALL axcq604_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq604
      
   END IF 
   
   CLOSE axcq604_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq604.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq604_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_glaa001        LIKE glaa_t.glaa001
   DEFINE l_s_fin_6013     LIKE type_t.chr80     #采用特性否    
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xckl001','8914')
   CALL cl_set_combo_scc('b_xckl005','8922')
   LET g_master.xckl001 = '1'
   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_master.xcklcomp,g_master.xcklld,g_master.xckl003,
                                           g_master.xckl004,g_master.xckl002  

   #根據參數顯示隱藏料件特性
   IF cl_null(g_master.xcklcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING l_s_fin_6013   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_master.xcklcomp,'S-FIN-6013') RETURNING l_s_fin_6013   #采用特性否       
   END IF
   IF l_s_fin_6013 = 'Y' THEN
      CALL cl_set_comp_visible('b_xckl008',TRUE)                    
   ELSE                     
      CALL cl_set_comp_visible('b_xckl008',FALSE)                
   END IF 
   
   CALL s_desc_get_department_desc(g_master.xcklcomp) RETURNING g_master.xcklcomp_desc
   
   CALL s_desc_get_ld_desc(g_master.xcklld) RETURNING g_master.xcklld_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xckl002
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xckl002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcklcomp,g_master.xcklcomp_desc,g_master.xcklld,g_master.xcklld_desc,g_master.xckl003,
                   g_master.xckl004,g_master.xckl001,g_master.xckl002,g_master.xckl002_desc 
   #end add-point
 
   CALL axcq604_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq604.default_search" >}
PRIVATE FUNCTION axcq604_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
  
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcklcomp = '", g_argv[01], "' AND "
      LET g_master.xcklcomp = g_argv[01]
   END IF   
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcklld = '", g_argv[02], "' AND "
      LET g_master.xcklld = g_argv[02]
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xckl001 = '", g_argv[03], "' AND "
      LET g_master.xckl001 = g_argv[03]
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xckl002 = '", g_argv[04], "' AND "
      LET g_master.xckl002 = g_argv[04]
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xckl003 = '", g_argv[05], "' AND "
      LET g_master.xckl003 = g_argv[05]
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xckl004 = '", g_argv[06], "' AND "
      LET g_master.xckl004 = g_argv[06]
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " gzcb002 = '", g_argv[07], "' AND "
   END IF

   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
   RETURN
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcklld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xckl001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xckl002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xckl003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xckl004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xckl005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xckl006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xckl007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xckl008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " xckl009 = '", g_argv[10], "' AND "
   END IF
   IF NOT cl_null(g_argv[11]) THEN
      LET g_wc = g_wc, " xckl010 = '", g_argv[11], "' AND "
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
 
{<section id="axcq604.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq604_ui_dialog() 
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
   DEFINE l_col   LIKE type_t.chr10
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
   
   #end add-point
 
   
   CALL axcq604_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xckl_d.clear()
 
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
 
         CALL axcq604_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.xcklcomp,g_master.xcklld,g_master.xckl003,
                       g_master.xckl004,g_master.xckl001,g_master.xckl002
            ATTRIBUTE(WITHOUT DEFAULTS)              
                  
            AFTER FIELD xcklcomp
               IF NOT cl_null(g_master.xcklcomp) THEN
                  #校验
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcklcomp
                  IF NOT cl_chk_exist("v_ooef001_1") THEN
                     LET g_master.xcklcomp = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_master.xcklcomp) AND NOT cl_null(g_master.xcklld) THEN
                  #校验
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcklld
                  LET g_chkparam.arg2 = g_master.xcklcomp
                  IF NOT cl_chk_exist("v_glaald_5") THEN
                     LET g_master.xcklcomp = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF               
               CALL s_desc_get_department_desc(g_master.xcklcomp) RETURNING g_master.xcklcomp_desc #法人組織
               DISPLAY g_master.xcklcomp_desc TO xcklcomp_desc  
               
            AFTER FIELD xcklld
               IF NOT cl_null(g_master.xcklld) THEN
                  #校验
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcklld
                  IF NOT cl_chk_exist("v_glaald") THEN
                     LET g_master.xcklld = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_master.xcklcomp) AND NOT cl_null(g_master.xcklld) THEN
                  #校验
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcklld
                  LET g_chkparam.arg2 = g_master.xcklcomp
                  IF NOT cl_chk_exist("v_glaald_5") THEN
                     LET g_master.xcklld = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF                
               CALL s_desc_get_ld_desc(g_master.xcklld) RETURNING g_master.xcklld_desc #帳別編號
               DISPLAY g_master.xcklld_desc TO xcklld_desc  
               
            AFTER FIELD xckl002
               IF NOT cl_null(g_master.xckl002) THEN
                  #校验
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xckl002
                  IF NOT cl_chk_exist("v_xcat001") THEN
                     LET g_master.xckl002 = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #成本計算類型说明
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xckl002
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xckl002_desc = '', g_rtn_fields[1] , ''
               DISPLAY g_master.xckl002_desc TO xckl003_desc 
               
            ON ACTION controlp INFIELD xcklcomp #法人组织
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               #160802-00020#8-add-(S)
      		   #增加法人過濾條件
               IF cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " 1=1 "
               ELSE
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #160802-00020#8-add-(E)
               #160802-00020#8-mod-(S)
#               IF NOT cl_null(g_master.xcklld) THEN 
#                  LET g_qryparam.where = " ooef001 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_master.xcklld,"' )"
#               END IF
               IF NOT cl_null(g_master.xcklld) THEN 
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                         " AND ooef001 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_master.xcklld,"' )"
               END IF
               #160802-00020#8-mod-(E)
               CALL q_ooef001_2()                      #呼叫開窗
               LET g_master.xcklcomp = g_qryparam.return1
               CALL s_desc_get_department_desc(g_master.xcklcomp) RETURNING g_master.xcklcomp_desc #法人組織
               DISPLAY BY NAME g_master.xcklcomp,g_master.xcklcomp_desc
               NEXT FIELD xcklcomp                     #返回原欄位
            
            ON ACTION controlp INFIELD xcklld   #账别编号
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               #160802-00020#8-add-(S)
               #增加帳套權限控制
               IF cl_null(g_wc_cs_ld) THEN
                  LET g_qryparam.where = " 1=1 "
               ELSE
                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
               END IF
               #160802-00020#8-add-(E)
               #160802-00020#8-mod-(S)
#               IF NOT cl_null(g_master.xcklcomp) THEN 
#                  LET g_qryparam.where = " glaald IN (SELECT glaald FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaacomp = '",g_master.xcklcomp,"' )"
#               END IF  
               IF NOT cl_null(g_master.xcklcomp) THEN 
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                         " AND glaald IN (SELECT glaald FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaacomp = '",g_master.xcklcomp,"' )"
               END IF
               #160802-00020#8-mod-(E)
               CALL q_authorised_ld()                #呼叫開窗
               LET g_master.xcklld = g_qryparam.return1     
               CALL s_desc_get_ld_desc(g_master.xcklld) RETURNING g_master.xcklld_desc #帳別編號
               DISPLAY BY NAME g_master.xcklld,g_master.xcklld_desc
               NEXT FIELD xcklld                     #返回原欄位
               
            ON ACTION controlp INFIELD xckl002   #成本计算类型
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               CALL q_xcat001()                       #呼叫開窗
               LET g_master.xckl002 = g_qryparam.return1
               
               #成本計算類型说明
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xckl002
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xckl002_desc = g_rtn_fields[1]
               DISPLAY BY NAME g_master.xckl002,g_master.xckl002_desc
               NEXT FIELD xckl002                     #返回原欄位               
         END INPUT              
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xckl_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq604_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq604_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
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
            CALL axcq604_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_wc = ''
            #end add-point
            NEXT FIELD xcklcomp
 
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
            CALL axcq604_col_chk() RETURNING l_col
            CASE 
               WHEN l_col = 'xcklcomp'
                  NEXT FIELD xcklcomp
               WHEN l_col = 'xcklld'
                  NEXT FIELD xcklld                  
               WHEN l_col = 'xckl002'
                  NEXT FIELD xckl002                  
               WHEN l_col = 'xckl003'
                  NEXT FIELD xckl003
               WHEN l_col = 'xckl004'
                  NEXT FIELD xckl004                  
            END CASE
            LET g_wc =" xcklcomp = '",g_master.xcklcomp,"'",
                      " AND xcklld = '",g_master.xcklld,"'",
                      " AND xckl001 ='",g_master.xckl001,"'",
                      " AND xckl002 ='",g_master.xckl002,"'",
                      " AND xckl003 ='",g_master.xckl003,"'",
                      " AND xckl004 ='",g_master.xckl004,"'"
            #160802-00020#8-add-(S)
            #---增加帳套權限控管
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_wc = g_wc ," AND xcklld IN ",g_wc_cs_ld
             END IF
            #---增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_wc = g_wc ," AND xcklcomp IN ",g_wc_cs_comp
            END IF
            #160802-00020#8-add-(E)
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axcq604_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xckl_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axcq604_b_fill()
 
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
            CALL axcq604_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq604_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq604_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq604_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xckl_d.getLength()
               LET g_xckl_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xckl_d.getLength()
               LET g_xckl_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xckl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xckl_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xckl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xckl_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq604_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
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
 
{<section id="axcq604.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq604_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xckl_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xcklcomp,xcklld,xckl003,xckl004,xckl001,xckl002,xckl005,'',xckl006, 
       xckl007,'','',xckl008,xckl009,xckl010,xckl101,xckl102,xckl103,xckl104,xckl105,xckl106,xckl090, 
       xckl102a,xckl104a,xckl106a,xckl102b,xckl104b,xckl106b,xckl102c,xckl104c,xckl106c,xckl102d,xckl104d, 
       xckl106d,xckl102e,xckl104e,xckl106e,xckl102f,xckl104f,xckl106f,xckl102g,xckl104g,xckl106g,xckl102h, 
       xckl104h,xckl106h  ,DENSE_RANK() OVER( ORDER BY xckl_t.xcklld,xckl_t.xckl001,xckl_t.xckl002,xckl_t.xckl003, 
       xckl_t.xckl004,xckl_t.xckl005,xckl_t.xckl006,xckl_t.xckl007,xckl_t.xckl008,xckl_t.xckl009,xckl_t.xckl010) AS RANK FROM xckl_t", 
 
 
 
                     "",
                     " WHERE xcklent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xckl_t"),
                     " ORDER BY xckl_t.xcklld,xckl_t.xckl001,xckl_t.xckl002,xckl_t.xckl003,xckl_t.xckl004,xckl_t.xckl005,xckl_t.xckl006,xckl_t.xckl007,xckl_t.xckl008,xckl_t.xckl009,xckl_t.xckl010"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT UNIQUE '',xcklcomp,xcklld,xckl003,xckl004, ",
                     "              xckl001,xckl002,gzcb002,xckl006,xckl007, ",
                     "              '','',xckl008,xckl009, ",
                     "              xckl010,xckl101,xckl102,xckl103,xckl104, ",
                     "              xckl105,xckl106,xckl090,xckl102a,xckl104a, ",
                     "              xckl106a,xckl102b,xckl104b,xckl106b,xckl102c, ",
                     "              xckl104c,xckl106c,xckl102d,xckl104d,xckl106d, ",
                     "              xckl102e,xckl104e,xckl106e,xckl102f,xckl104f, ",
                     "              xckl106f,xckl102g,xckl104g,xckl106g,xckl102h,  ",
                     "              xckl104h,xckl106h,gzcb012 ",
                     "  FROM gzcb_t "
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_sql_rank = ls_sql_rank,"  INNER JOIN xckl_t ON gzcb002 = xckl005 AND xcklent = ? AND ",g_wc,
                                    " WHERE gzcb001 = '8922' AND gzcb002 NOT LIKE '9%' AND ",g_wc_filter,
                                    " ORDER BY gzcb012"
   ELSE
      LET ls_sql_rank = ls_sql_rank,"  LEFT JOIN xckl_t ON gzcb002 = xckl005 AND xcklent = ? AND ",g_wc,
                                    " WHERE gzcb001 = '8922' AND gzcb002 NOT LIKE '9%' AND ",g_wc_filter,
                                    " ORDER BY gzcb012"   
   END IF
                     
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
 
   LET g_sql = "SELECT '',xcklcomp,xcklld,xckl003,xckl004,xckl001,xckl002,xckl005,'',xckl006,xckl007, 
       '','',xckl008,xckl009,xckl010,xckl101,xckl102,xckl103,xckl104,xckl105,xckl106,xckl090,xckl102a, 
       xckl104a,xckl106a,xckl102b,xckl104b,xckl106b,xckl102c,xckl104c,xckl106c,xckl102d,xckl104d,xckl106d, 
       xckl102e,xckl104e,xckl106e,xckl102f,xckl104f,xckl106f,xckl102g,xckl104g,xckl106g,xckl102h,xckl104h, 
       xckl106h",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT UNIQUE '',xcklcomp,xcklld,xckl003,xckl004, ",
               "              xckl001,xckl002,gzcb002,gzcbl004,xckl006,xckl007, ",
               "              '','',xckl008,xckl009, ",
               "              xckl010,xckl101,xckl102,xckl103,xckl104, ",
               "              xckl105,xckl106,xckl090,xckl102a,xckl104a, ",
               "              xckl106a,xckl102b,xckl104b,xckl106b,xckl102c, ",
               "              xckl104c,xckl106c,xckl102d,xckl104d,xckl106d, ",
               "              xckl102e,xckl104e,xckl106e,xckl102f,xckl104f, ",
               "              xckl106f,xckl102g,xckl104g,xckl106g,xckl102h,  ",
               "              xckl104h,xckl106h,gzcb012 ",
               "  FROM gzcb_t "
   IF NOT cl_null(g_argv[01]) THEN
      LET g_sql = g_sql,"  LEFT JOIN gzcbl_t ON gzcbl001 = '8922' AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'",
                        "  INNER JOIN xckl_t ON gzcb002 = xckl005 AND xcklent = ? AND ",g_wc,
                        " WHERE gzcb001 = '8922' AND gzcb002 NOT LIKE '9%' AND ",g_wc_filter,
                        " ORDER BY gzcb012"
   ELSE
      LET g_sql = g_sql,"  LEFT JOIN gzcbl_t ON gzcbl001 = '8922' AND gzcb002 = gzcbl002 AND gzcbl003 = '",g_dlang,"'",
                        "  LEFT JOIN xckl_t ON gzcb002 = xckl005 AND xcklent = ? AND ",g_wc,
                        " WHERE gzcb001 = '8922' AND gzcb002 NOT LIKE '9%' AND ",g_wc_filter,
                        " ORDER BY gzcb012"  
   END IF               
               
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq604_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq604_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xckl_d[l_ac].sel,g_xckl_d[l_ac].xcklcomp,g_xckl_d[l_ac].xcklld,g_xckl_d[l_ac].xckl003, 
       g_xckl_d[l_ac].xckl004,g_xckl_d[l_ac].xckl001,g_xckl_d[l_ac].xckl002,g_xckl_d[l_ac].xckl005,g_xckl_d[l_ac].xckl005_desc, 
       g_xckl_d[l_ac].xckl006,g_xckl_d[l_ac].xckl007,g_xckl_d[l_ac].xckl007_desc,g_xckl_d[l_ac].xckl007_desc_1, 
       g_xckl_d[l_ac].xckl008,g_xckl_d[l_ac].xckl009,g_xckl_d[l_ac].xckl010,g_xckl_d[l_ac].xckl101,g_xckl_d[l_ac].xckl102, 
       g_xckl_d[l_ac].xckl103,g_xckl_d[l_ac].xckl104,g_xckl_d[l_ac].xckl105,g_xckl_d[l_ac].xckl106,g_xckl_d[l_ac].xckl090, 
       g_xckl_d[l_ac].xckl102a,g_xckl_d[l_ac].xckl104a,g_xckl_d[l_ac].xckl106a,g_xckl_d[l_ac].xckl102b, 
       g_xckl_d[l_ac].xckl104b,g_xckl_d[l_ac].xckl106b,g_xckl_d[l_ac].xckl102c,g_xckl_d[l_ac].xckl104c, 
       g_xckl_d[l_ac].xckl106c,g_xckl_d[l_ac].xckl102d,g_xckl_d[l_ac].xckl104d,g_xckl_d[l_ac].xckl106d, 
       g_xckl_d[l_ac].xckl102e,g_xckl_d[l_ac].xckl104e,g_xckl_d[l_ac].xckl106e,g_xckl_d[l_ac].xckl102f, 
       g_xckl_d[l_ac].xckl104f,g_xckl_d[l_ac].xckl106f,g_xckl_d[l_ac].xckl102g,g_xckl_d[l_ac].xckl104g, 
       g_xckl_d[l_ac].xckl106g,g_xckl_d[l_ac].xckl102h,g_xckl_d[l_ac].xckl104h,g_xckl_d[l_ac].xckl106h 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axcq604_detail_show("'1'")
 
      CALL axcq604_xckl_t_mask()
 
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
   
   #end add-point
 
   CALL g_xckl_d.deleteElement(g_xckl_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xckl_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axcq604_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq604_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq604_detail_action_trans()
 
   LET l_ac = 1
   IF g_xckl_d.getLength() > 0 THEN
      CALL axcq604_b_fill2()
   END IF
 
      CALL axcq604_filter_show('xckl007','b_xckl007')
   CALL axcq604_filter_show('xckl010','b_xckl010')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq604.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq604_b_fill2()
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
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axcq604.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq604_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_xckl_d[l_ac].xckl007
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xckl_d[l_ac].xckl007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xckl_d[l_ac].xckl007_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq604.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axcq604_filter()
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
      CONSTRUCT g_wc_filter ON xckl007,xckl010
                          FROM s_detail1[1].b_xckl007,s_detail1[1].b_xckl010
 
         BEFORE CONSTRUCT
                     DISPLAY axcq604_filter_parser('xckl007') TO s_detail1[1].b_xckl007
            DISPLAY axcq604_filter_parser('xckl010') TO s_detail1[1].b_xckl010
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xcklcomp>>----
         #----<<b_xcklld>>----
         #----<<b_xckl003>>----
         #----<<b_xckl004>>----
         #----<<b_xckl001>>----
         #----<<b_xckl002>>----
         #----<<b_xckl005>>----
         #----<<b_xckl005_desc>>----
         #----<<b_xckl006>>----
         #----<<b_xckl007>>----
         #Ctrlp:construct.c.filter.page1.b_xckl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckl007
            #add-point:ON ACTION controlp INFIELD b_xckl007 name="construct.c.filter.page1.b_xckl007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE           
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xckl007   #顯示到畫面上
            NEXT FIELD b_xckl007                     #返回原欄位   
            #END add-point
 
 
         #----<<b_xckl007_desc>>----
         #----<<b_xckl007_desc_1>>----
         #----<<b_xckl008>>----
         #----<<b_xckl009>>----
         #----<<b_xckl010>>----
         #Ctrlp:construct.c.filter.page1.b_xckl010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckl010
            #add-point:ON ACTION controlp INFIELD b_xckl010 name="construct.c.filter.page1.b_xckl010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE           
            CALL q_xcbf001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xckl010   #顯示到畫面上
            NEXT FIELD b_xckl010                     #返回原欄位           
            #END add-point
 
 
         #----<<b_xckl101>>----
         #----<<b_xckl102>>----
         #----<<b_xckl103>>----
         #----<<b_xckl104>>----
         #----<<b_xckl105>>----
         #----<<b_xckl106>>----
         #----<<b_xckl090>>----
         #----<<b_xckl102a>>----
         #----<<b_xckl104a>>----
         #----<<b_xckl106a>>----
         #----<<b_xckl102b>>----
         #----<<b_xckl104b>>----
         #----<<b_xckl106b>>----
         #----<<b_xckl102c>>----
         #----<<b_xckl104c>>----
         #----<<b_xckl106c>>----
         #----<<b_xckl102d>>----
         #----<<b_xckl104d>>----
         #----<<b_xckl106d>>----
         #----<<b_xckl102e>>----
         #----<<b_xckl104e>>----
         #----<<b_xckl106e>>----
         #----<<b_xckl102f>>----
         #----<<b_xckl104f>>----
         #----<<b_xckl106f>>----
         #----<<b_xckl102g>>----
         #----<<b_xckl104g>>----
         #----<<b_xckl106g>>----
         #----<<b_xckl102h>>----
         #----<<b_xckl104h>>----
         #----<<b_xckl106h>>----
 
 
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
 
      CALL axcq604_filter_show('xckl007','b_xckl007')
   CALL axcq604_filter_show('xckl010','b_xckl010')
 
 
   CALL axcq604_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq604.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axcq604_filter_parser(ps_field)
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
 
{<section id="axcq604.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq604_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq604_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axcq604.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq604_detail_action_trans()
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
 
{<section id="axcq604.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq604_detail_index_setting()
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
            IF g_xckl_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xckl_d.getLength() AND g_xckl_d.getLength() > 0
            LET g_detail_idx = g_xckl_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xckl_d.getLength() THEN
               LET g_detail_idx = g_xckl_d.getLength()
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
 
{<section id="axcq604.mask_functions" >}
 &include "erp/axc/axcq604_mask.4gl"
 
{</section>}
 
{<section id="axcq604.other_function" readonly="Y" >}

################################################################################
#查询条件栏位为空检查
################################################################################
PRIVATE FUNCTION axcq604_col_chk()
DEFINE r_col   LIKE type_t.chr10   
   
   LET r_col = ''
   IF cl_null(g_master.xcklcomp) THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcklcomp" 
      LET g_errparam.code   = 'sub-00379'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()      
      LET r_col = 'xcklcomp'
      RETURN r_col
   END IF

   IF cl_null(g_master.xcklld) THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcklld" 
      LET g_errparam.code   = 'sub-00379'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()      
      LET r_col = 'xcklld'
      RETURN r_col
   END IF
   
   IF cl_null(g_master.xckl002) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xckl002" 
      LET g_errparam.code   = 'sub-00379'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()    
      LET r_col = 'xckl002'
      RETURN r_col
   END IF
   
   IF cl_null(g_master.xckl003) THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xckl003" 
      LET g_errparam.code   = 'sub-00379'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()    
      LET r_col = 'xckl003'
      RETURN r_col
   END IF

   IF cl_null(g_master.xckl004) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xckl004" 
      LET g_errparam.code   = 'sub-00379'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()    
      LET r_col = 'xckl004'
      RETURN r_col
   END IF
   
   RETURN r_col
END FUNCTION

 
{</section>}
 
