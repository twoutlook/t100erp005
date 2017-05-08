#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq160.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-13 16:52:46), PR版次:0001(2016-12-20 15:41:21)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: afaq160
#+ Description: 固定資產及折舊變動表
#+ Creator....: 07900(2016-11-11 18:04:59)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="afaq160.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_faah_d RECORD
       
       sel LIKE type_t.chr1, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faah007 LIKE faah_t.faah007, 
   faah007_desc LIKE type_t.chr500, 
   faah032 LIKE type_t.chr500, 
   faah032_desc LIKE type_t.chr500, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah012 LIKE type_t.chr500, 
   faah013 LIKE type_t.chr500, 
   faaj023 LIKE type_t.chr500, 
   faaj023_desc LIKE type_t.chr500, 
   faaj048 LIKE type_t.chr500, 
   faan014 LIKE faan_t.faan014, 
   faaj016 LIKE faaj_t.faaj016, 
   faaj017 LIKE faaj_t.faaj017, 
   fabh010 LIKE fabh_t.fabh010, 
   faaj018 LIKE faaj_t.faaj018, 
   fabh011 LIKE fabh_t.fabh011, 
   fabh012 LIKE fabh_t.fabh012, 
   faah022 LIKE faah_t.faah022, 
   fabo018 LIKE fabo_t.fabo018, 
   fabh008 LIKE fabh_t.fabh008, 
   fabr043 LIKE fabr_t.fabr043, 
   fabh009 LIKE fabh_t.fabh009, 
   fabo019 LIKE fabo_t.fabo019, 
   fabr041 LIKE fabr_t.fabr041, 
   faan015 LIKE faan_t.faan015
       END RECORD
PRIVATE TYPE type_g_faah2_d RECORD
       faah006 LIKE faah_t.faah006, 
   faah006_1_desc LIKE type_t.chr500, 
   faah007 LIKE faah_t.faah007, 
   faah007_1_desc LIKE type_t.chr500, 
   faah032 LIKE faah_t.faah032, 
   faah032_1_desc LIKE type_t.chr500, 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faaj024 LIKE faaj_t.faaj024, 
   faaj024_1_desc LIKE type_t.chr500, 
   faaj048 LIKE faaj_t.faaj048, 
   faan018 LIKE faan_t.faan018, 
   faam015 LIKE faam_t.faam015, 
   fabh011 LIKE fabh_t.fabh011, 
   fabh015 LIKE fabh_t.fabh015, 
   fabo019 LIKE fabo_t.fabo019, 
   fabh012 LIKE fabh_t.fabh012, 
   fabh016 LIKE fabh_t.fabh016, 
   faan019 LIKE faan_t.faan019, 
   faan020 LIKE faan_t.faan020
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master   RECORD 
         ooef001       LIKE ooef_t.ooef001,
         ooef001_desc  LIKE type_t.chr80,
         glaald        LIKE glaa_t.glaald,
         glaald_desc   LIKE type_t.chr80,
         faaj009       LIKE faaj_t.faaj009,
         faaj010_1     LIKE faaj_t.faaj010,
         faaj010_2     LIKE faaj_t.faaj010
   END RECORD 
DEFINE g_master_t   RECORD 
         ooef001       LIKE ooef_t.ooef001,
         ooef001_desc  LIKE type_t.chr80,
         glaald        LIKE glaa_t.glaald,
         glaald_desc   LIKE type_t.chr80,
         faaj009       LIKE faaj_t.faaj009,
         faaj010_1     LIKE faaj_t.faaj010,
         faaj010_2     LIKE faaj_t.faaj010
   END RECORD  
DEFINE g_detail_cnt2          LIKE type_t.num10   #第二页签单身总笔数
DEFINE g_wc_cs_ld           STRING      
DEFINE g_wc_cs_orga         STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_faah_d            DYNAMIC ARRAY OF type_g_faah_d
DEFINE g_faah_d_t          type_g_faah_d
DEFINE g_faah2_d     DYNAMIC ARRAY OF type_g_faah2_d
DEFINE g_faah2_d_t   type_g_faah2_d
 
 
 
 
 
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
 
{<section id="afaq160.main" >}
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
   DECLARE afaq160_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq160_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq160_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq160 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq160_init()   
 
      #進入選單 Menu (="N")
      CALL afaq160_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq160
      
   END IF 
   
   CLOSE afaq160_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq160.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afaq160_init()
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
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_faaj048','9897')
   CALL cl_set_combo_scc('b_faaj048_1','9897')
   CALL afaq160_create_tmp()
   #end add-point
 
   CALL afaq160_default_search()
END FUNCTION
 
{</section>}
 
{<section id="afaq160.default_search" >}
PRIVATE FUNCTION afaq160_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " faah000 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " faah001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " faah003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " faah004 = '", g_argv[04], "' AND "
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
 
{<section id="afaq160.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afaq160_ui_dialog() 
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
   DEFINE l_count       LIKE type_t.num5  
   DEFINE l_ooef017     LIKE ooef_t.ooef017 
   DEFINE l_sql         STRING
   DEFINE l_origin_str  STRING
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   CALL afaq160_ui_dialog_1()
   RETURN
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
 
   
   CALL afaq160_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faah_d.clear()
         CALL g_faah2_d.clear()
 
 
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
 
         CALL afaq160_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_master.ooef001,g_master.glaald,g_master.faaj009,g_master.faaj010_1,g_master.faaj010_2
          FROM ooef001,glaald,faaj009,faaj010_1,faaj010_2          
         BEFORE INPUT
         
         BEFORE FIELD ooef001
           LET g_master_t.ooef001 = g_master.ooef001
         AFTER  FIELD ooef001
           IF NOT cl_null(g_master.ooef001) THEN
              #检查组织资料的合理性             
              IF NOT s_afat502_site_chk(g_master.ooef001) THEN                                 
                  LET g_master.ooef001 = g_master_t.ooef001
                  CALL afaq160_ooef001_desc()
                  NEXT FIELD CURRENT
              END IF 
              #檢查是否資產組織                 
              LET l_count = 0
              SELECT COUNT(1) INTO l_count 
                FROM ooef_t
               WHERE ooefent = g_enterprise 
                 AND ooef001 = g_master.ooef001
                 AND ooef207 = 'Y'
              IF l_count =0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-00004'
                 LET g_errparam.extend = g_master.ooef001
                 LET g_errparam.popup = FALSE
                 CALL cl_err()                   
                 LET g_master.ooef001 = g_master_t.ooef001
                 CALL afaq160_ooef001_desc()
                 NEXT FIELD CURRENT
              END IF       
              
                                                  
           END IF
           
           #法人
           SELECT ooef017 INTO l_ooef017    
             FROM ooef_t
            WHERE ooefent = g_enterprise AND ooef001 = g_master.ooef001
            
            #账套 
             CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_sql
             LET l_sql = " SELECT DISTINCT glaald ",
                         "   FROM glaa_t ",
                         "  WHERE glaaent = ",g_enterprise," AND glaacomp = '",l_ooef017,"'",
                         "    AND glaastus = 'Y' AND glaa014 = 'Y' AND ",l_sql  
             PREPARE glaald_pre_1 FROM l_sql
             EXECUTE glaald_pre_1 INTO g_master.glaald
                FREE glaald_pre_1
            
             CALL afaq160_ooef001_desc()
             CALL afaq160_glaald_desc()
           

         ON ACTION controlp INFIELD ooef001
            INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	          LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = ''      #給予default值
             LET g_qryparam.where = " ooef207 = 'Y' "            
             CALL q_ooef001_47()   
             LET g_master.ooef001 = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master.ooef001 TO ooef001             #顯示到畫面上
             CALL afaq160_ooef001_desc()
             NEXT FIELD ooef001               
         
         BEFORE FIELD glaald
            LET g_master_t.glaald = g_master.glaald
            
         AFTER  FIELD glaald
              IF NOT cl_null(g_master.glaald) THEN
                
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master.glaald
               
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
              
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  
               ELSE
                  LET g_master.glaald = g_master_t.glaald
                  CALL afaq160_glaald_desc()                
               END IF               
            
               IF NOT s_ld_chk_authorization(g_user,g_master.glaald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_master.glaald
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.glaald = g_master_t.glaald
                  CALL afaq160_glaald_desc()          
                  NEXT FIELD CURRENT
               END IF
               
              #资产中心不为空时
                 IF NOT cl_null(g_master.ooef001) THEN
                    IF NOT s_afat502_site_ld_chk(g_master.ooef001,g_master.glaald) THEN
                       LET g_master.glaald = g_master_t.glaald
                       CALL afaq160_glaald_desc()   
                       NEXT FIELD CURRENT
                    END IF
                 END IF
               
            END IF  
         ON ACTION controlp INFIELD glaald
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master_t.glaald         #給予default值
 
            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_master.ooef001,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_afat502_change_to_sql(l_origin_str) RETURNING l_origin_str  
            LET l_origin_str=l_origin_str.substring(2,l_origin_str.getLength()-1)          
             LET g_qryparam.where = " glaa014 = 'Y'" 
            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            
            CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING g_wc_cs_ld
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_qryparam.where," AND ",g_wc_cs_ld
            END IF
           
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.glaald  = g_qryparam.return1              
            DISPLAY g_master.glaald TO glaald 
            CALL afaq160_glaald_desc()
            NEXT FIELD glaald
            
            
         AFTER FIELD faaj009
         
         BEFORE FIELD faaj010_1
          LET g_master_t.faaj010_1 = g_master.faaj010_1
          
         AFTER FIELD faaj010_1
         
           IF NOT cl_null(g_master.faaj010_1) THEN 
             IF g_master.faaj010_1 < 1 OR g_master.faaj010_1 > 12 THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'afa-00380'
                LET g_errparam.extend = g_master.faaj010_1
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_1 = g_master_t.faaj010_1
                NEXT FIELD faaj010_1
             END IF 
             IF NOT cl_null(g_master.faaj010_2) AND g_master.faaj010_1 > g_master.faaj010_2  THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00227'
                LET g_errparam.extend = g_master.faaj010_1
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_1 = g_master_t.faaj010_1
                NEXT FIELD faaj010_1
             END IF 
          END IF 
          
          
         BEFORE FIELD faaj010_2
            LET g_master_t.faaj010_2 = g_master.faaj010_2
         
         AFTER FIELD faaj010_2
             IF NOT cl_null(g_master.faaj010_2) THEN 
             IF g_master.faaj010_2 < 1 OR g_master.faaj010_2 > 12 THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'afa-00380'
                LET g_errparam.extend = g_master.faaj010_2
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_2 = g_master_t.faaj010_2
                NEXT FIELD faaj010_2
             END IF 
             IF NOT cl_null(g_master.faaj010_1) AND g_master.faaj010_1 > g_master.faaj010_2  THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00228'
                LET g_errparam.extend = g_master.faaj010_2
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_2 = g_master_t.faaj010_2
                NEXT FIELD faaj010_2
             END IF 
          END IF 
          
         
        END INPUT        
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
#         CONSTRUCT g_wc ON faah006,faah007,faah032,faah003,faah004,faah001                      
#          FROM s_detail1[1].b_faah006,s_detail1[1].b_faah007,s_detail1[1].b_faah032,s_detail1[1].b_faah003,
#               s_detail1[1].b_faah004,s_detail1[1].b_faah001
#               
#           BEFORE CONSTRUCT
#          
#           ON ACTION controlp INFIELD b_faah006
#	        INITIALIZE g_qryparam.* TO NULL
#           LET g_qryparam.state = 'c'
#	        LET g_qryparam.reqry = FALSE
#           CALL q_faac001()                                    #呼叫開窗
#           DISPLAY g_qryparam.return1 TO b_faah006             #顯示到畫面上
#           NEXT FIELD b_faah006
#           
#           
#           ON ACTION controlp INFIELD b_faah007
#	        INITIALIZE g_qryparam.* TO NULL
#           LET g_qryparam.state = 'c'
#	        LET g_qryparam.reqry = FALSE
#           CALL q_faad001()                                    #呼叫開窗
#           DISPLAY g_qryparam.return1 TO b_faah007             #顯示到畫面上
#           NEXT FIELD b_faah007
#           
#           ON ACTION controlp INFIELD b_faah032
#	        INITIALIZE g_qryparam.* TO NULL
#           LET g_qryparam.state = 'c'
#	        LET g_qryparam.reqry = FALSE
#           CALL q_ooef001()                                    #呼叫開窗
#           DISPLAY g_qryparam.return1 TO b_faah032             #顯示到畫面上
#           NEXT FIELD b_faah032
#           
#           ON ACTION controlp INFIELD b_faah001
#	        INITIALIZE g_qryparam.* TO NULL
#           LET g_qryparam.state = 'c'
#	        LET g_qryparam.reqry = FALSE
#           CALL q_faah001()                                    #呼叫開窗
#           DISPLAY g_qryparam.return1 TO b_faah001             #顯示到畫面上
#           NEXT FIELD b_faah001
#           
#           ON ACTION controlp INFIELD b_faah003
#	        INITIALIZE g_qryparam.* TO NULL
#           LET g_qryparam.state = 'c'
#	        LET g_qryparam.reqry = FALSE
#           CALL q_faah003()                                    #呼叫開窗
#           DISPLAY g_qryparam.return1 TO b_faah003             #顯示到畫面上
#           NEXT FIELD b_faah003
#          
#           ON ACTION controlp INFIELD b_faah004
#	        INITIALIZE g_qryparam.* TO NULL
#           LET g_qryparam.state = 'c'
#	        LET g_qryparam.reqry = FALSE
#           CALL q_faah004()                                    #呼叫開窗
#           DISPLAY g_qryparam.return1 TO b_faah004             #顯示到畫面上
#           NEXT FIELD b_faah004
#           
#         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_faah_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afaq160_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afaq160_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_faah2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afaq160_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL afaq160_qbeclear()
            #end add-point
            NEXT FIELD ooef001
 
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
            LET g_wc = " 1=1"
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL afaq160_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_faah_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_faah2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL afaq160_b_fill()
 
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
            CALL afaq160_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq160_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq160_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq160_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_faah_d.getLength()
               LET g_faah_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_faah_d.getLength()
               LET g_faah_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_faah_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_faah_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_faah_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_faah_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afaq160_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
 
{<section id="afaq160.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq160_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_faan014       LIKE faan_t.faan014 #期初数小计
   DEFINE l_faan014_sum   LIKE faan_t.faan014 #累计期初数小计
   DEFINE l_faaj016       LIKE faaj_t.faaj016 #购入小计
   DEFINE l_faaj016_sum   LIKE faaj_t.faaj016 #累计购入小计
   DEFINE l_faaj017       LIKE faaj_t.faaj017 #建造完成小计
   DEFINE l_faaj017_sum   LIKE faaj_t.faaj017 #累计建造完成小计
   DEFINE l_fabh010       LIKE fabh_t.fabh010 #盘盈小计
   DEFINE l_fabh010_sum   LIKE fabh_t.fabh010 #累计盘盈小计
   DEFINE l_faaj018       LIKE faaj_t.faaj018 #投资转入小计
   DEFINE l_faaj018_sum   LIKE faaj_t.faaj018 #累计投资转入小计
   DEFINE l_fabh011       LIKE fabh_t.fabh011 #重估小计
   DEFINE l_fabh011_sum   LIKE fabh_t.fabh011 #累计重估小计
   DEFINE l_fabh012       LIKE fabh_t.fabh012 #改良小计
   DEFINE l_fabh012_sum   LIKE fabh_t.fabh012 #累计改良小计
   DEFINE l_faah022       LIKE faah_t.faah022 #本年增加合计小计
   DEFINE l_faah022_sum   LIKE faah_t.faah022 #累计本年增加合计小计
   DEFINE l_fabo018       LIKE fabo_t.fabo018 #出售小计
   DEFINE l_fabo018_sum   LIKE fabo_t.fabo018 #累计出售小计
   DEFINE l_fabh008       LIKE fabh_t.fabh008 #报废小计
   DEFINE l_fabh008_sum   LIKE fabh_t.fabh008 #累计报废小计
   DEFINE l_fabr043       LIKE fabr_t.fabr043 #盘亏小计
   DEFINE l_fabr043_sum   LIKE fabr_t.fabr043 #累计盘亏小计
   DEFINE l_fabh009       LIKE fabh_t.fabh009 #非常损失小计
   DEFINE l_fabh009_sum   LIKE fabh_t.fabh009 #累计非常损失小计
   DEFINE l_fabo019       LIKE fabo_t.fabo019 #投资转出小计
   DEFINE l_fabo019_sum   LIKE fabo_t.fabo019 #累计投资转出小计
   DEFINE l_fabr041       LIKE fabr_t.fabr041 #本年减少合计小计
   DEFINE l_fabr041_sum   LIKE fabr_t.fabr041 #累计本年减少合计小计
   DEFINE l_faan015       LIKE faan_t.faan015 #期末数小计
   DEFINE l_faan015_sum   LIKE faan_t.faan015 #累计期末数小计  
   DEFINE l_faan018       LIKE faan_t.faan018 #期初数小计
   DEFINE l_faan018_sum   LIKE faan_t.faan018 #累计期初数小计
   DEFINE l_faam015       LIKE faam_t.faam015 #期间累计折旧小计 
   DEFINE l_faam015_sum   LIKE faam_t.faam015 #累计期间累计折旧小计
   DEFINE l_fabh011_1       LIKE fabh_t.fabh011 #重估小计
   DEFINE l_fabh011_1_sum   LIKE fabh_t.fabh011 #累计重估小计
   DEFINE l_fabh015         LIKE fabh_t.fabh015 #销账小计
   DEFINE l_fabh015_sum     LIKE fabh_t.fabh015 #累计销账小计
   DEFINE l_fabo019_1       LIKE fabo_t.fabo019 #出售小计
   DEFINE l_fabo019_1_sum   LIKE fabo_t.fabo019 #累计出售小计
   DEFINE l_fabh012_1       LIKE fabh_t.fabh012 #报废小计
   DEFINE l_fabh012_1_sum   LIKE fabh_t.fabh012 #累计报废小计
   DEFINE l_fabh016         LIKE fabh_t.fabh016 #盘点小计
   DEFINE l_fabh016_sum     LIKE fabh_t.fabh016 #累计盘点小计
   DEFINE l_faan019         LIKE faan_t.faan019 #其他小计
   DEFINE l_faan019_sum     LIKE faan_t.faan019 #累计其他小计
   DEFINE l_faan020         LIKE faan_t.faan020 #期末数小计
   DEFINE l_faan020_sum     LIKE faan_t.faan020 #累计期末数小计 
   DEFINE l_cnt             LIKE type_t.num10
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_sql             STRING
   DEFINE l_flag            LIKE type_t.chr1
   DEFINE l_errno           LIKE type_t.chr100
   DEFINE l_glav002         LIKE glav_t.glav002
   DEFINE l_glav005         LIKE glav_t.glav005
   DEFINE l_sdate_s         LIKE glav_t.glav004
   DEFINE l_sdate_e         LIKE glav_t.glav004
   DEFINE l_glav006         LIKE glav_t.glav006
   DEFINE l_pdate_s         LIKE glav_t.glav004
   DEFINE l_pdate_e         LIKE glav_t.glav004
   DEFINE l_glav007         LIKE glav_t.glav007
   DEFINE l_wdate_s         LIKE glav_t.glav004
   DEFINE l_wdate_e         LIKE glav_t.glav004
   DEFINE l_date_s          LIKE glav_t.glav004  #起始日期
   DEFINE l_date_e          LIKE glav_t.glav004  #截止日期
   DEFINE l_glaa003         LIKE glaa_t.glaa003
   DEFINE l_glaa004         LIKE glaa_t.glaa004 
   DEFINE l_faaj009         LIKE faaj_t.faaj009 #上期年度
   DEFINE l_faaj010         LIKE faaj_t.faaj010 #上期期别
   DEFINE l_fabo018_1       LIKE fabo_t.fabo018 #计算本年减少之投资转出的出售金额
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
 
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_faan014 = 0      
   LET l_faan014_sum = 0  
   LET l_faaj016 = 0      
   LET l_faaj016_sum = 0  
   LET l_faaj017 = 0      
   LET l_faaj017_sum = 0  
   LET l_fabh010 = 0      
   LET l_fabh010_sum = 0  
   LET l_faaj018 = 0      
   LET l_faaj018_sum = 0  
   LET l_fabh011 = 0      
   LET l_fabh011_sum = 0  
   LET l_fabh012 = 0      
   LET l_fabh012_sum = 0
   LET l_faah022 = 0     
   LET l_faah022_sum = 0 
   LET l_fabo018 = 0     
   LET l_fabo018_sum = 0 
   LET l_fabh008 = 0     
   LET l_fabh008_sum = 0 
   LET l_fabr043 = 0     
   LET l_fabr043_sum = 0 
   LET l_fabh009 = 0     
   LET l_fabh009_sum = 0 
   LET l_fabo019 = 0
   LET l_fabo019_sum = 0
   LET l_fabr041 = 0
   LET l_fabr041_sum = 0
   LET l_faan015 = 0
   LET l_faan015_sum = 0
   LET l_faan018_sum = 0   
   LET l_faam015_sum = 0   
   LET l_fabh011_1_sum = 0 
   LET l_fabh015_sum = 0   
   LET l_fabo019_1_sum = 0 
   LET l_fabh012_1_sum = 0 
   LET l_fabh016_sum = 0   
   LET l_faan019_sum = 0   
   LET l_faan020_sum = 0  
   LET l_faan018 = 0   
   LET l_faam015 = 0
   LET l_fabh011_1 = 0
   LET l_fabh015 = 0
   LET l_fabo019_1 = 0
   LET l_fabh012_1 = 0
   LET l_fabh016 = 0
   LET l_faan019 = 0
   LET l_faan020 = 0
   
   DELETE FROM afaq160_x01_tmp
   DELETE FROM afaq160_x01_tmp   
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',faah006,'',faah007,'','','',faah003,faah004,faah001,'','','', 
       '','','','','','','','','',faah022,'','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY faah_t.faah000,faah_t.faah001,faah_t.faah003, 
       faah_t.faah004) AS RANK FROM faah_t",
 
 
                     "",
                     " WHERE faahent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("faah_t"),
                     " ORDER BY faah_t.faah000,faah_t.faah001,faah_t.faah003,faah_t.faah004"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   #取得会计期间内的起讫日期 #会计科目参照表
   SELECT glaa003,glaa004 INTO l_glaa003,l_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_master.glaald
    #起始日期
    CALL s_get_accdate(l_glaa003,'',g_master.faaj009,g_master.faaj010_1)
    RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
              l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
    IF l_flag='N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = l_errno
       LET g_errparam.extend = ''
       LET g_errparam.popup = FALSE
       CALL cl_err()            
    END IF
    LET l_date_s = l_pdate_s 
    #截止日期
    CALL s_get_accdate(l_glaa003,'',g_master.faaj009,g_master.faaj010_2)
    RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
              l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
    IF l_flag='N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = l_errno
       LET g_errparam.extend = ''
       LET g_errparam.popup = FALSE
       CALL cl_err()            
    END IF
    LET l_date_e = l_pdate_e
    
   #期初数取起始年度期别的上期值
   CALL s_fin_date_get_last_period(l_glaa003,g_master.glaald,g_master.faaj009,g_master.faaj010_1) RETURNING g_sub_success,l_faaj009,l_faaj010    
   #固资变动表页签的期初数
   LET l_sql =" SELECT faan014 ",
              "   FROM faan_t,faah_t ",
              "  WHERE faanent = faahent AND faan003 = faah001 AND faan004 = faah003 AND faahent = ",g_enterprise,
              "    AND faan005 = faah004 AND faan001 = ",l_faaj009," AND faan002 = ",l_faaj010,
              "    AND faanld ='",g_master.glaald,"' AND faah001 = ? AND faah003 =? AND faah004 = ? " 
   PREPARE faan014_pre FROM l_sql
   
   #1:本年增加之购入
     # 购入=ALL-2-3-4
   #ALL
   LET l_sql = " SELECT faaj016 ",
               "   FROM faah_t,faaj_t ",
               "  WHERE faahent = faajent  ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ", 
               "    AND faah000 = faaj000 ",
               "    AND faahent = ",g_enterprise," AND faajld ='",g_master.glaald,"'",
               "    AND faah014 BETWEEN '",l_date_s,"' AND '",l_date_e,"'",
               "    AND faah016 = '1' AND faah042 NOT IN (4,5) AND faahstus = 'Y' ",
               "    AND faah001 =? AND faah003 =? AND faah004 =? "
    PREPARE faaj016_pre FROM l_sql           
   #2:本年增加之建造完成
   LET l_sql = " SELECT faaj016 ",
               "   FROM faah_t,faaj_t ",
               "  WHERE faahent = faajent  ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ", 
               "    AND faah000 = faaj000 ",
               "    AND EXISTS (SELECT 1 FROM faap_t WHERE faapent = faahent AND faap007 = faah001 AND faap008 = faah003 AND faap009 =faah004 )",
               "    AND faahent = ",g_enterprise," AND faajld ='",g_master.glaald,"'",
               "    AND faah014 BETWEEN '",l_date_s,"' AND '",l_date_e,"'",
               "    AND faah042 NOT IN (4,5) AND faahstus = 'Y' ",
               "    AND faah001 =? AND faah003 =? AND faah004 =? "
   PREPARE faaj017_pre FROM l_sql
   #3：本年增加之盘盈
   LET l_sql = " SELECT SUM(fabh010) ",
               "   FROM faah_t,fabh_t,fabg_t ",              
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '23' AND faah042 NOT IN (4,5) AND fabgstus = 'S'",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "
   PREPARE fabh010_pre FROM l_sql  
   
   #4:本年增加之投资转入
   LET l_sql = " SELECT faaj016 ",
               "   FROM faah_t,faaj_t ",
               "  WHERE faahent = faajent  ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ", 
               "    AND faah000 = faaj000 ",
               "    AND faahent = ",g_enterprise," AND faajld ='",g_master.glaald,"'",
               "    AND faah014 BETWEEN '",l_date_s,"' AND '",l_date_e,"'",
               "    AND faah016 = '1' AND faah042 IN (4,5) AND faahstus = 'Y' ",
               "    AND faah001 =? AND faah003 =? AND faah004 =? "
   PREPARE faaj018_pre FROM l_sql
   
   #5:本年增加之重估
   LET l_sql = " SELECT SUM(fabh010) ",
               "   FROM faah_t,fabh_t,fabg_t",             
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '8' AND faah042 NOT IN (4,5) ",
               "     AND fabh018 = '1' AND fabgstus = 'S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "   
   PREPARE fabh011_pre FROM l_sql            
               
   #6:本年增加之改良
   LET l_sql = " SELECT SUM(fabh010) ",
               "   FROM faah_t,fabh_t,fabg_t",             
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '9' AND faah042 NOT IN (4,5) ",
               "     AND fabh018 = '1' AND fabgstus = 'S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "  
   PREPARE fabh012_pre FROM l_sql
   
   #7:本年增加之合计
    #1+2+3+4+5+6  
    
   #1:本年减少之出售
   LET l_sql = " SELECT SUM(fabo018) ",
               "   FROM faah_t,fabo_t,fabg_t",             
               "   WHERE faahent = faboent AND faah001 = fabo003 AND faah003 = fabo001 AND faah004 = fabo002 ",
               "     AND faboent = fabgent AND fabold = fabgld AND fabodocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '4' AND faah042 NOT IN (4,5) AND fabgstus ='S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? " 
    PREPARE fabo018_pre FROM l_sql
   #2:本年减少组织报废
   LET l_sql = " SELECT SUM(fabh008) ",
               "   FROM faah_t,fabh_t,fabg_t",             
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '21' AND faah042 NOT IN (4,5) AND fabgstus ='S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "  
    PREPARE fabh008_pre FROM l_sql
   
   #3:本年减少之盘亏
   LET l_sql = " SELECT ABS(SUM(fabh008)) ",
               "   FROM faah_t,fabh_t,fabg_t ",            
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '24' AND faah042 NOT IN (4,5) AND fabgstus = 'S'  ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "
               
   PREPARE fabr043_pre FROM l_sql
   
   #4:本年减少之非常损失
   LET l_sql = "  SELECT SUM(fabh008) ",
               "    FROM faah_t,fabh_t,fabg_t",             
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '6' AND faah042 NOT IN (4,5) AND fabgstus = 'S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "  
   PREPARE fabh009_pre FROM l_sql   
   #5:本年减少之投资转出 投资转出金额=销账报废金额sum(fabh008)+出售金额sum(fabo018)
   LET l_sql = "  SELECT SUM(fabh008) ",
               "    FROM faah_t,fabh_t,fabg_t",             
               "   WHERE faahent = fabhent AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002 ",
               "     AND fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 IN ('6','21') AND faah042 IN (4,5) AND fabgstus = 'S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? "  
   PREPARE fabo019_pre FROM l_sql 
   #出售金额sum(fabo018)
   LET l_sql = " SELECT SUM(fabo018) ",
               "   FROM faah_t,fabo_t,fabg_t",             
               "   WHERE faahent = faboent AND faah001 = fabo003 AND faah003 = fabo001 AND faah004 = fabo002 ",
               "     AND faboent = fabgent AND fabold = fabgld AND fabodocno = fabgdocno ",
               "     AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 = '4' AND faah042 IN (4,5) AND fabgstus ='S' ",
               "     AND faahent =",g_enterprise," AND fabgld = '",g_master.glaald,"'",
               "     AND faah001 =? AND faah003 =? AND faah004 =? " 
   PREPARE fabo018_fabo019_pre FROM l_sql   
   #6:本年减少合计 
     #1~5 相加
     
   #7.期末数
    #期初数+本年增加合计-本年减少合计 
    
   #固资折旧变动表页签 
   #期初数
   LET l_sql =" SELECT faan018 ",
              "   FROM faan_t ",
              "  WHERE faanent = ",g_enterprise,
              "    AND faan001 = ",l_faaj009," AND faan002 = ",l_faaj010,
              "    AND faanld ='",g_master.glaald,"' AND faan003 = ? AND faan004 =? AND faan005 = ? " 
   PREPARE faan018_pre FROM l_sql    
   #1.期间累计折旧
   LET l_sql = " SELECT SUM(faam013) ",
               "   FROM faam_t ",
               "  WHERE faament = ",g_enterprise," AND faamld ='",g_master.glaald,"' ",
               "    AND faam004 = ",g_master.faaj009," AND faam005 BETWEEN ",g_master.faaj010_1," AND ",g_master.faaj010_2,
               "    AND faam007 <> '3' ",
               "    AND faam000 =? AND faam001 = ? AND faam002 = ? "
   PREPARE faam015_pre FROM l_sql            
   #2.重估
   LET l_sql = " SELECT SUM(fabh011-fabh012) ",
               "   FROM fabh_t,fabg_t ",
               "  WHERE fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "    AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 ='8' AND fabgstus = 'S' ",
               "    AND fabgld ='",g_master.glaald,"' AND fabh000 = ? AND fabh001 =? AND fabh002 =? "            
   PREPARE fabh011_1_pre FROM l_sql
   #3.销账  
   LET l_sql = " SELECT SUM(fabh011-fabh012) ",
               "   FROM fabh_t,fabg_t ",
               "  WHERE fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "    AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 ='6' AND fabgstus = 'S' ",
               "    AND fabgld ='",g_master.glaald,"' AND fabh000 = ? AND fabh001 =? AND fabh002 =? "               
   PREPARE fabh015_pre FROM l_sql
   #4.出售
   LET l_sql = " SELECT SUM(fabo019) ",
               "   FROM fabo_t,fabg_t ",
               "  WHERE faboent = fabgent AND fabold = fabgld AND fabodocno = fabgdocno ",
               "    AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 ='4' AND fabgstus = 'S' ",
               "    AND fabgld ='",g_master.glaald,"' AND fabo003 = ? AND fabo001 =? AND fabh002 =? "               
   PREPARE fabo019_1_pre FROM l_sql
   #5.报废
   LET l_sql = " SELECT SUM(fabh011-fabh012) ",
               "   FROM fabh_t,fabg_t ",
               "  WHERE fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "    AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 ='21' AND fabgstus = 'S' ",
               "    AND fabgld ='",g_master.glaald,"' AND fabh000 = ? AND fabh001 =? AND fabh002 =? "               
   PREPARE fabh012_1_pre FROM l_sql
   #6.盘点
   LET l_sql = " SELECT SUM(fabh011-fabh012) ",
               "   FROM fabh_t,fabg_t ",
               "  WHERE fabhent = fabgent AND fabhld = fabgld AND fabhdocno = fabgdocno ",
               "    AND fabgdocdt BETWEEN '",l_date_s,"' AND '",l_date_e,"' AND fabg005 IN ('23','24') AND fabgstus = 'S' ",
               "    AND fabgld ='",g_master.glaald,"' AND fabh000 = ? AND fabh001 =? AND fabh002 =? "               
   PREPARE fabh016_pre FROM l_sql
   #7. 期末数
   LET l_sql =" SELECT faan018 ",
              "   FROM faan_t ",
              "  WHERE faanent = ",g_enterprise,
              "    AND faan001 = ",g_master.faaj009," AND faan002 = ",g_master.faaj010_2,
              "    AND faanld ='",g_master.glaald,"' AND faan003 = ? AND faan004 =? AND faan005 = ? "              
   PREPARE faan020_pre FROM l_sql
   
   #8. 其他 =  期末数 + 中间异动 - 期初数   
   
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
 
   LET g_sql = "SELECT '',faah006,'',faah007,'','','',faah003,faah004,faah001,'','','','','','','','', 
       '','','','',faah022,'','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = " SELECT 'Y',faah006 AS y,'',faah007 AS w,'',faah032,'',faah003 AS z,faah004,faah001,faah012,faah013,faaj023,'',faaj048,",
               "        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,faah006,'',faah007,'',faah032,'',faah003,faah004,faah001,faah012,",
               "        faah013,faaj024,'',faaj048,0,0,0,0,0,0,0,0,0 ",
               "   FROM faah_t,faaj_t ",
               "  WHERE faahent = faajent  ",
               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
               "    AND faah001 = faaj037 ", 
               "    AND faah000 = faaj000 ",
               "    AND faahent = ? AND faajld ='",g_master.glaald,"'",
               "    AND ",ls_wc CLIPPED 
               
   LET g_sql =g_sql," ORDER BY y,w,z "
   
   #计算 总笔数
   LET  l_sql = "SELECT COUNT(1) FROM (",g_sql,")"
   PREPARE l_cnt_pre FROM l_sql
   EXECUTE l_cnt_pre USING g_enterprise INTO l_cnt
            
   
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq160_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq160_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_faah_d[l_ac].sel,g_faah_d[l_ac].faah006,g_faah_d[l_ac].faah006_desc,g_faah_d[l_ac].faah007, 
       g_faah_d[l_ac].faah007_desc,g_faah_d[l_ac].faah032,g_faah_d[l_ac].faah032_desc,g_faah_d[l_ac].faah003, 
       g_faah_d[l_ac].faah004,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013,g_faah_d[l_ac].faaj023, 
       g_faah_d[l_ac].faaj023_desc,g_faah_d[l_ac].faaj048,g_faah_d[l_ac].faan014,g_faah_d[l_ac].faaj016, 
       g_faah_d[l_ac].faaj017,g_faah_d[l_ac].fabh010,g_faah_d[l_ac].faaj018,g_faah_d[l_ac].fabh011,g_faah_d[l_ac].fabh012, 
       g_faah_d[l_ac].faah022,g_faah_d[l_ac].fabo018,g_faah_d[l_ac].fabh008,g_faah_d[l_ac].fabr043,g_faah_d[l_ac].fabh009, 
       g_faah_d[l_ac].fabo019,g_faah_d[l_ac].fabr041,g_faah_d[l_ac].faan015,g_faah2_d[l_ac].faah006, 
       g_faah2_d[l_ac].faah006_1_desc,g_faah2_d[l_ac].faah007,g_faah2_d[l_ac].faah007_1_desc,g_faah2_d[l_ac].faah032, 
       g_faah2_d[l_ac].faah032_1_desc,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004,g_faah2_d[l_ac].faah001, 
       g_faah2_d[l_ac].faah012,g_faah2_d[l_ac].faah013,g_faah2_d[l_ac].faaj024,g_faah2_d[l_ac].faaj024_1_desc, 
       g_faah2_d[l_ac].faaj048,g_faah2_d[l_ac].faan018,g_faah2_d[l_ac].faam015,g_faah2_d[l_ac].fabh011, 
       g_faah2_d[l_ac].fabh015,g_faah2_d[l_ac].fabo019,g_faah2_d[l_ac].fabh012,g_faah2_d[l_ac].fabh016, 
       g_faah2_d[l_ac].faan019,g_faah2_d[l_ac].faan020
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #资产科目名称
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaa004
      LET g_ref_fields[2] = g_faah_d[l_ac].faaj023
      CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_faah_d[l_ac].faaj023_desc = '', g_rtn_fields[1] , ''
      #累计折旧科目名称
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaa004
      LET g_ref_fields[2] = g_faah2_d[l_ac].faaj024
      CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_faah2_d[l_ac].faaj024_1_desc = '', g_rtn_fields[1] , ''
      
      #固资变动表页签的  期初数
       EXECUTE faan014_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].faan014
       IF cl_null(g_faah_d[l_ac].faan014) THEN
          LET g_faah_d[l_ac].faan014 = 0
       END IF       
      #2:本年增加之建造完成
       EXECUTE faaj017_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].faaj017
       IF cl_null(g_faah_d[l_ac].faaj017) THEN
          LET g_faah_d[l_ac].faaj017 = 0
       END IF
      #3：本年增加之盘盈
       EXECUTE fabh010_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabh010
       IF cl_null(g_faah_d[l_ac].fabh010) THEN
          LET g_faah_d[l_ac].fabh010 = 0
       END IF
      #4:本年增加之投资转入
       EXECUTE faaj018_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].faaj018
       IF cl_null(g_faah_d[l_ac].faaj018) THEN
          LET g_faah_d[l_ac].faaj018 = 0
       END IF       
      #1:本年增加之购入
       EXECUTE faaj016_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].faaj016
       IF cl_null(g_faah_d[l_ac].faaj016) THEN
          LET g_faah_d[l_ac].faaj016 = 0
       END IF
       LET g_faah_d[l_ac].faaj016 = g_faah_d[l_ac].faaj016 - g_faah_d[l_ac].faaj017 - g_faah_d[l_ac].fabh010 - g_faah_d[l_ac].faaj018
       IF g_faah_d[l_ac].faaj016 < 0 THEN
          LET g_faah_d[l_ac].faaj016 = 0 
       END IF       
      #5:本年增加之重估 
       EXECUTE fabh011_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabh011
       IF cl_null(g_faah_d[l_ac].fabh011) THEN
          LET g_faah_d[l_ac].fabh011 = 0
       END IF       
      #6:本年增加之改良 
       EXECUTE fabh012_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabh012
       IF cl_null(g_faah_d[l_ac].fabh012) THEN
          LET g_faah_d[l_ac].fabh012 = 0
       END IF
      #7:本年增加之合计 1+2+3+4+5+6   
       LET g_faah_d[l_ac].faah022 = g_faah_d[l_ac].faaj016 + g_faah_d[l_ac].faaj017 + g_faah_d[l_ac].fabh010 + g_faah_d[l_ac].faaj018 +
                                    g_faah_d[l_ac].fabh011 + g_faah_d[l_ac].fabh012
      
      #1:本年减少之出售
       EXECUTE fabo018_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabo018
       IF cl_null(g_faah_d[l_ac].fabo018) THEN
          LET g_faah_d[l_ac].fabo018 = 0
       END IF  
      #2:本年减少之报废
       EXECUTE fabh008_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabh008             
       IF cl_null(g_faah_d[l_ac].fabh008) THEN
          LET g_faah_d[l_ac].fabh008 = 0
       END IF
      #3:本年减少之盘亏
       EXECUTE fabr043_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabr043             
       IF cl_null(g_faah_d[l_ac].fabr043) THEN
          LET g_faah_d[l_ac].fabr043 = 0
       END IF
      #4:本年减少之非常损失
       EXECUTE fabh009_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabh009             
       IF cl_null(g_faah_d[l_ac].fabh009) THEN
          LET g_faah_d[l_ac].fabh009 = 0
       END IF     
      #5:本年减少之投资转出 投资转出金额=销账报废金额sum(fabh008)+出售金额sum(fabo018)
       EXECUTE fabo019_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO g_faah_d[l_ac].fabo019
       IF cl_null(g_faah_d[l_ac].fabo019) THEN
          LET g_faah_d[l_ac].fabo019 = 0
       END IF
       #出售金额sum(fabo018)
       EXECUTE fabo018_fabo019_pre USING g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah003,g_faah_d[l_ac].faah004 INTO l_fabo018_1
       IF cl_null(l_fabo018_1) THEN
          LET l_fabo018_1 = 0
       END IF 
       LET g_faah_d[l_ac].fabo019 = g_faah_d[l_ac].fabo019 + l_fabo018_1
      #6:本年减少合计 
       #1~5 相加
       LET g_faah_d[l_ac].fabr041 = g_faah_d[l_ac].fabo018 + g_faah_d[l_ac].fabh008 + g_faah_d[l_ac].fabr043 + 
                                    g_faah_d[l_ac].fabh009 + g_faah_d[l_ac].fabo019
                                    
      #7.期末数   #期初数+本年增加合计-本年减少合计    
       LET g_faah_d[l_ac].faan015 = g_faah_d[l_ac].faan014 + g_faah_d[l_ac].faah022 - g_faah_d[l_ac].fabr041
      
      #固资折旧变动表页签 
      #期初数      
       EXECUTE faan018_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].faan018
       IF cl_null(g_faah2_d[l_ac].faan018) THEN
          LET g_faah2_d[l_ac].faan018 = 0
       END IF      
      #1.期间累计折旧
       EXECUTE faam015_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].faam015
       IF cl_null(g_faah2_d[l_ac].faam015) THEN
          LET g_faah2_d[l_ac].faam015 = 0
       END IF 
      #2.重估
       EXECUTE fabh011_1_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].fabh011
       IF cl_null(g_faah2_d[l_ac].fabh011) THEN
          LET g_faah2_d[l_ac].fabh011 = 0
       END IF
      #3.销账
       EXECUTE fabh015_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].fabh015
       IF cl_null(g_faah2_d[l_ac].fabh015) THEN
          LET g_faah2_d[l_ac].fabh015 = 0
       END IF
      #4.出售
       EXECUTE fabo019_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].fabo019
       IF cl_null(g_faah2_d[l_ac].fabo019) THEN
          LET g_faah2_d[l_ac].fabo019 = 0
       END IF
      #5.报废 
       EXECUTE fabh012_1_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].fabh012
       IF cl_null(g_faah2_d[l_ac].fabh012) THEN
          LET g_faah2_d[l_ac].fabh012 = 0
       END IF  
      #6.盘点
       EXECUTE fabh016_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].fabh016
       IF cl_null(g_faah2_d[l_ac].fabh016) THEN
          LET g_faah2_d[l_ac].fabh016 = 0
       END IF
      #7. 期末数
       EXECUTE faan020_pre USING g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah003,g_faah2_d[l_ac].faah004 INTO g_faah2_d[l_ac].faan020
       IF cl_null(g_faah2_d[l_ac].faan020) THEN
          LET g_faah2_d[l_ac].faan020 = 0
       END IF
      #8. 其他 =  期末数 + 中间异动 - 期初数 
       LET g_faah2_d[l_ac].faan019 = g_faah2_d[l_ac].faan020 + g_faah2_d[l_ac].fabh016 + g_faah2_d[l_ac].fabh012 + g_faah2_d[l_ac].fabo019 +
                                     g_faah2_d[l_ac].fabh015 + g_faah2_d[l_ac].fabh011 + g_faah2_d[l_ac].faam015 - g_faah2_d[l_ac].faan018
      
      #插入临时表数据（不含小计，合计）
      CALL afaq160_ins_tmp()
      
      IF l_ac =1 THEN
         LET g_faah_d_t.* = g_faah_d[l_ac].*
         LET g_faah2_d_t.* = g_faah2_d[l_ac].*
      ELSE
         IF g_faah_d[l_ac].faah006 = g_faah_d_t.faah006 THEN
          # LET g_faah_d[l_ac].faah006 = NULL
          # LET g_faah2_d[l_ac].faah006 = NULL
           
           LET l_faan014 = l_faan014 + g_faah_d[l_ac].faan014 #累計同一主要类别 中faan014（期初数） 的值（少了第一筆）
           LET l_faaj016 = l_faaj016 + g_faah_d[l_ac].faaj016 #累計同一主要类别 中faaj016（购入） 的值（少了第一筆）
           LET l_faaj017 = l_faaj017 + g_faah_d[l_ac].faaj017 #累計同一主要类别 中faaj017（建造完成） 的值（少了第一筆）
           LET l_fabh010 = l_fabh010 + g_faah_d[l_ac].fabh010 #累計同一主要类别 中faaj010（盘盈） 的值（少了第一筆）
           LET l_faaj018 = l_faaj018 + g_faah_d[l_ac].faaj018 #累計同一主要类别 中faaj018 （投资转入） 的值（少了第一筆）
           LET l_fabh011 = l_fabh011 + g_faah_d[l_ac].fabh011 #累計同一主要类别 中fabh011（重估） 的值（少了第一筆）
           LET l_fabh012 = l_fabh012 + g_faah_d[l_ac].fabh012 #累計同一主要类别 中fabh012（改良） 的值（少了第一筆）
           LET l_faah022 = l_faah022 + g_faah_d[l_ac].faah022 #累計同一主要类别 中fabh022（本年增加合计） 的值（少了第一筆） 
           LET l_fabo018 = l_fabo018 + g_faah_d[l_ac].fabo018 #累計同一主要类别 中fabo018（出售） 的值（少了第一筆）     
           LET l_fabh008 = l_fabh008 + g_faah_d[l_ac].fabh008 #累計同一主要类别 中fabh008（报废） 的值（少了第一筆）
           LET l_fabr043 = l_fabr043 + g_faah_d[l_ac].fabr043 #累計同一主要类别 中fabr043（盘亏） 的值（少了第一筆）
           LET l_fabh009 = l_fabh009 + g_faah_d[l_ac].fabh009 #累計同一主要类别 中fabh009（非常损失） 的值（少了第一筆） 
           LET l_fabo019 = l_fabo019 + g_faah_d[l_ac].fabo019 #累計同一主要类别 中fabo019（投资转出） 的值（少了第一筆） 
           LET l_fabr041 = l_fabr041 + g_faah_d[l_ac].fabr041 #累計同一主要类别 中fabr041（本年减少合计） 的值（少了第一筆）
           LET l_faan015 = l_faan015 + g_faah_d[l_ac].faan015 #累計同一主要类别 中faan015（期末数） 的值（少了第一筆） 
          #第二页签 
           LET l_faan018 = l_faan018 + g_faah2_d[l_ac].faan018 #累計同一主要类别 中faan018（期初数） 的值（少了第一筆）
           LET l_faam015 = l_faam015 + g_faah2_d[l_ac].faam015 #累計同一主要类别 中faam015（期间累计折旧） 的值（少了第一筆）
           LET l_fabh011_1 = l_fabh011_1 + g_faah2_d[l_ac].fabh011 #累計同一主要类别 中fabh011（重估） 的值（少了第一筆）
           LET l_fabh015 = l_fabh015 + g_faah2_d[l_ac].fabh015 #累計同一主要类别 中fabh015（销账） 的值（少了第一筆）
           LET l_fabo019_1 = l_fabo019_1 + g_faah2_d[l_ac].fabo019 #累計同一主要类别 中fabo019（出售） 的值（少了第一筆）
           LET l_fabh012_1 = l_fabh012_1 + g_faah2_d[l_ac].fabh012 #累計同一主要类别 中fabh012（报废） 的值（少了第一筆）
           LET l_fabh016 = l_fabh016 + g_faah2_d[l_ac].fabh016 #累計同一主要类别 中fabh016（盘点） 的值（少了第一筆）
           LET l_faan019 = l_faan019 + g_faah2_d[l_ac].faan019 #累計同一主要类别 中faan019（其他） 的值（少了第一筆）
           LET l_faan020 = l_faan020 + g_faah2_d[l_ac].faan020 #累計同一主要类别 中faan014（期末数） 的值（少了第一筆）
           
         ELSE #主要类别改变
         
            LET l_faan014 = l_faan014 + g_faah_d_t.faan014 #加上同主要类别里的第一笔期初数的值
            LET l_faaj016 = l_faaj016 + g_faah_d_t.faaj016 #加上同主要类别里的第一笔购入的值
            LET l_faaj017 = l_faaj017 + g_faah_d_t.faaj017 #加上同主要类别里的第一笔建造完成的值
            LET l_fabh010 = l_fabh010 + g_faah_d_t.fabh010 #加上同主要类别里的第一笔盘盈的值
            LET l_faaj018 = l_faaj018 + g_faah_d_t.faaj018 #加上同主要类别里的第一笔投资转入的值
            LET l_fabh011 = l_fabh011 + g_faah_d_t.fabh011 #加上同主要类别里的第一笔重估的值
            LET l_fabh012 = l_fabh012 + g_faah_d_t.fabh012 #加上同主要类别里的第一笔改良的值
            LET l_faah022 = l_faah022 + g_faah_d_t.faah022 #加上同主要类别里的第一笔本年增加合计的值
            LET l_fabo018 = l_fabo018 + g_faah_d_t.fabo018 #加上同主要类别里的第一笔出售的值
            LET l_fabh008 = l_fabh008 + g_faah_d_t.fabh008 #加上同主要类别里的第一笔报废的值
            LET l_fabr043 = l_fabr043 + g_faah_d_t.fabr043 #加上同主要类别里的第一笔盘亏的值
            LET l_fabh009 = l_fabh009 + g_faah_d_t.fabh009 #加上同主要类别里的第一笔非常损失的值
            LET l_fabo019 = l_fabo019 + g_faah_d_t.fabo019 #加上同主要类别里的第一笔投资转出的值
            LET l_fabr041 = l_fabr041 + g_faah_d_t.fabr041 #加上同主要类别里的第一笔本年减少合计的值
            LET l_faan015 = l_faan015 + g_faah_d_t.faan015 #加上同主要类别里的第一笔期末数的值
            #第二页签
            LET l_faan018 = l_faan018 + g_faah2_d_t.faan018 #加上同一主要类别 中第一筆faan018（期初数） 的值
            LET l_faam015 = l_faam015 + g_faah2_d_t.faam015 #加上同一主要类别 中第一筆faam015（期间累计折旧） 的值
            LET l_fabh011_1 = l_fabh011_1 + g_faah2_d_t.fabh011 #加上同一主要类别 中第一筆fabh011（重估） 的值
            LET l_fabh015 = l_fabh015 + g_faah2_d_t.fabh015 #加上同一主要类别 中第一筆fabh015（销账） 的值
            LET l_fabo019_1 = l_fabo019_1 + g_faah2_d_t.fabo019 #加上同一主要类别 中第一筆fabo019（出售） 的值
            LET l_fabh012_1 = l_fabh012_1 + g_faah2_d_t.fabh012 #加上同一主要类别 中第一筆fabh012（报废） 的值
            LET l_fabh016 = l_fabh016 + g_faah2_d_t.fabh016 #加上同一主要类别 中第一筆fabh016（盘点） 的值
            LET l_faan019 = l_faan019 + g_faah2_d_t.faan019 #加上同一主要类别 中第一筆faan019（其他） 的值
            LET l_faan020 = l_faan020 + g_faah2_d_t.faan020 #加上同一主要类别 中第一筆faan014（期末数） 的值
            #把当前笔赋给旧值
            LET g_faah_d_t.* = g_faah_d[l_ac].*
            LET g_faah2_d_t.* = g_faah2_d[l_ac].*
            
            LET g_faah_d[l_ac+1].* = g_faah_d[l_ac].*
            LET g_faah2_d[l_ac+1].* = g_faah2_d[l_ac].*
            INITIALIZE g_faah_d[l_ac].* TO NULL
            INITIALIZE g_faah2_d[l_ac].* TO NULL
            #小計
            LET g_faah_d[l_ac].faah003 = cl_getmsg('aap-00287',g_dlang)
            LET g_faah2_d[l_ac].faah003 = cl_getmsg('aap-00287',g_dlang)
            #sum小计
            LET g_faah_d[l_ac].faan014 = l_faan014
            LET g_faah_d[l_ac].faaj016 = l_faaj016
            LET g_faah_d[l_ac].faaj017 = l_faaj017
            LET g_faah_d[l_ac].fabh010 = l_fabh010
            LET g_faah_d[l_ac].faaj018 = l_faaj018
            LET g_faah_d[l_ac].fabh011 = l_fabh011
            LET g_faah_d[l_ac].fabh012 = l_fabh012
            LET g_faah_d[l_ac].faah022 = l_faah022
            LET g_faah_d[l_ac].fabo018 = l_fabo018
            LET g_faah_d[l_ac].fabh008 = l_fabh008
            LET g_faah_d[l_ac].fabr043 = l_fabr043
            LET g_faah_d[l_ac].fabh009 = l_fabh009
            LET g_faah_d[l_ac].fabo019 = l_fabo019
            LET g_faah_d[l_ac].fabr041 = l_fabr041
            LET g_faah_d[l_ac].faan015 = l_faan015
            #第二页签sum小计
            LET g_faah2_d[l_ac].faan018 = l_faan018
            LET g_faah2_d[l_ac].faam015 = l_faam015
            LET g_faah2_d[l_ac].fabh011 = l_fabh011_1
            LET g_faah2_d[l_ac].fabh015 = l_fabh015
            LET g_faah2_d[l_ac].fabo019 = l_fabo019_1
            LET g_faah2_d[l_ac].fabh012 = l_fabh012_1
            LET g_faah2_d[l_ac].fabh016 = l_fabh016
            LET g_faah2_d[l_ac].faan019 = l_faan019
            LET g_faah2_d[l_ac].faan020 = l_faan020
            #累计 小计 用于sum合计
            LET l_faan014_sum = l_faan014_sum + g_faah_d[l_ac].faan014
            LET l_faaj016_sum = l_faaj016_sum + g_faah_d[l_ac].faaj016
            LET l_faaj017_sum = l_faaj017_sum + g_faah_d[l_ac].faaj017
            LET l_fabh010_sum = l_fabh010_sum + g_faah_d[l_ac].fabh010
            LET l_faaj018_sum = l_faaj018_sum + g_faah_d[l_ac].faaj018
            LET l_fabh011_sum = l_fabh011_sum + g_faah_d[l_ac].fabh011
            LET l_fabh012_sum = l_fabh012_sum + g_faah_d[l_ac].fabh012
            LET l_faah022_sum = l_faah022_sum + g_faah_d[l_ac].faah022
            LET l_fabo018_sum = l_fabo018_sum + g_faah_d[l_ac].fabo018
            LET l_fabh008_sum = l_fabh008_sum + g_faah_d[l_ac].fabh008
            LET l_fabr043_sum = l_fabr043_sum + g_faah_d[l_ac].fabr043
            LET l_fabh009_sum = l_fabh009_sum + g_faah_d[l_ac].fabh009
            LET l_fabo019_sum = l_fabo019_sum + g_faah_d[l_ac].fabo019
            LET l_fabr041_sum = l_fabr041_sum + g_faah_d[l_ac].fabr041
            LET l_faan015_sum = l_faan015_sum + g_faah_d[l_ac].faan015
            #第二页签 累计 小计 用于sum合计
            LET l_faan018_sum = l_faan018_sum + g_faah2_d[l_ac].faan018 
            LET l_faam015_sum = l_faam015_sum + g_faah2_d[l_ac].faam015 
            LET l_fabh011_1_sum = l_fabh011_1_sum + g_faah2_d[l_ac].fabh011 
            LET l_fabh015_sum = l_fabh015_sum + g_faah2_d[l_ac].fabh015 
            LET l_fabo019_1_sum = l_fabo019_1_sum + g_faah2_d[l_ac].fabo019 
            LET l_fabh012_1_sum = l_fabh012_1_sum + g_faah2_d[l_ac].fabh012 
            LET l_fabh016_sum = l_fabh016_sum + g_faah2_d[l_ac].fabh016
            LET l_faan019_sum = l_faan019_sum + g_faah2_d[l_ac].faan019 
            LET l_faan020_sum = l_faan020_sum + g_faah2_d[l_ac].faan020 
                                              
            LET l_faan014 = 0   
            LET l_faaj016 = 0       
            LET l_faaj017 = 0   
            LET l_fabh010 = 0   
            LET l_faaj018 = 0   
            LET l_fabh011 = 0   
            LET l_fabh012 = 0   
            LET l_faah022 = 0   
            LET l_fabo018 = 0   
            LET l_fabh008 = 0
            LET l_fabr043 = 0
            LET l_fabh009 = 0
            LET l_fabo019 = 0
            LET l_fabr041 = 0
            LET l_faan015 = 0
            LET l_faan018   = 0 
            LET l_faam015   = 0 
            LET l_fabh011_1 = 0 
            LET l_fabh015   = 0 
            LET l_fabo019_1 = 0 
            LET l_fabh012_1 = 0 
            LET l_fabh016   = 0 
            LET l_faan019   = 0 
            LET l_faan020   = 0 
            
            LET l_i =l_i+1
            LET l_ac = l_ac + 1
            
         END IF                     
      END IF  
      #最後一期的小計
      IF l_ac = l_cnt + l_i THEN          
         #小計
         LET g_faah_d[l_ac+1].faah003 = cl_getmsg('aap-00287',g_dlang)
         LET g_faah2_d[l_ac+1].faah003 = cl_getmsg('aap-00287',g_dlang)        
         #sum 小計
         LET g_faah_d[l_ac+1].faan014 = l_faan014 + g_faah_d_t.faan014
         LET g_faah_d[l_ac+1].faaj016 = l_faaj016 + g_faah_d_t.faaj016
         LET g_faah_d[l_ac+1].faaj017 = l_faaj017 + g_faah_d_t.faaj017
         LET g_faah_d[l_ac+1].fabh010 = l_fabh010 + g_faah_d_t.fabh010
         LET g_faah_d[l_ac+1].faaj018 = l_faaj018 + g_faah_d_t.faaj018
         LET g_faah_d[l_ac+1].fabh011 = l_fabh011 + g_faah_d_t.fabh011
         LET g_faah_d[l_ac+1].fabh012 = l_fabh012 + g_faah_d_t.fabh012
         LET g_faah_d[l_ac+1].faah022 = l_faah022 + g_faah_d_t.faah022
         LET g_faah_d[l_ac+1].fabo018 = l_fabo018 + g_faah_d_t.fabo018
         LET g_faah_d[l_ac+1].fabh008 = l_fabh008 + g_faah_d_t.fabh008
         LET g_faah_d[l_ac+1].fabr043 = l_fabr043 + g_faah_d_t.fabr043
         LET g_faah_d[l_ac+1].fabh009 = l_fabh009 + g_faah_d_t.fabh009
         LET g_faah_d[l_ac+1].fabo019 = l_fabo019 + g_faah_d_t.fabo019
         LET g_faah_d[l_ac+1].fabr041 = l_fabr041 + g_faah_d_t.fabr041
         LET g_faah_d[l_ac+1].faan015 = l_faan015 + g_faah_d_t.faan015
         #第二1页签 sum 小計
         LET g_faah2_d[l_ac+1].faan018 = l_faan018 + g_faah2_d_t.faan018 
         LET g_faah2_d[l_ac+1].faam015 = l_faam015 + g_faah2_d_t.faam015 
         LET g_faah2_d[l_ac+1].fabh011 = l_fabh011_1 + g_faah2_d_t.fabh011
         LET g_faah2_d[l_ac+1].fabh015 = l_fabh015 + g_faah2_d_t.fabh015 
         LET g_faah2_d[l_ac+1].fabo019 = l_fabo019_1 + g_faah2_d_t.fabo019 
         LET g_faah2_d[l_ac+1].fabh012 = l_fabh012_1 + g_faah2_d_t.fabh012
         LET g_faah2_d[l_ac+1].fabh016 = l_fabh016 + g_faah2_d_t.fabh016 
         LET g_faah2_d[l_ac+1].faan019 = l_faan019 + g_faah2_d_t.faan019 
         LET g_faah2_d[l_ac+1].faan020 = l_faan020 + g_faah2_d_t.faan020 
         
         LET l_ac = l_ac+1 
         #合計
         LET g_faah_d[l_ac+1].faah003 = cl_getmsg('axc-00204',g_dlang) 
         LET g_faah2_d[l_ac+1].faah003 = cl_getmsg('axc-00204',g_dlang) 
         #sum 合計            
         LET g_faah_d[l_ac+1].faan014 = l_faan014_sum + g_faah_d[l_ac].faan014
         LET g_faah_d[l_ac+1].faaj016 = l_faaj016_sum + g_faah_d[l_ac].faaj016
         LET g_faah_d[l_ac+1].faaj017 = l_faaj017_sum + g_faah_d[l_ac].faaj017
         LET g_faah_d[l_ac+1].fabh010 = l_fabh010_sum + g_faah_d[l_ac].fabh010
         LET g_faah_d[l_ac+1].faaj018 = l_faaj018_sum + g_faah_d[l_ac].faaj018
         LET g_faah_d[l_ac+1].fabh011 = l_fabh011_sum + g_faah_d[l_ac].fabh011
         LET g_faah_d[l_ac+1].fabh012 = l_fabh012_sum + g_faah_d[l_ac].fabh012
         LET g_faah_d[l_ac+1].faah022 = l_faah022_sum + g_faah_d[l_ac].faah022
         LET g_faah_d[l_ac+1].fabo018 = l_fabo018_sum + g_faah_d[l_ac].fabo018
         LET g_faah_d[l_ac+1].fabh008 = l_fabh008_sum + g_faah_d[l_ac].fabh008
         LET g_faah_d[l_ac+1].fabr043 = l_fabr043_sum + g_faah_d[l_ac].fabr043
         LET g_faah_d[l_ac+1].fabh009 = l_fabh009_sum + g_faah_d[l_ac].fabh009
         LET g_faah_d[l_ac+1].fabo019 = l_fabo019_sum + g_faah_d[l_ac].fabo019
         LET g_faah_d[l_ac+1].fabr041 = l_fabr041_sum + g_faah_d[l_ac].fabr041
         LET g_faah_d[l_ac+1].faan015 = l_faan015_sum + g_faah_d[l_ac].faan015
         #第二页签sum 合計
         LET g_faah2_d[l_ac+1].faan018 = l_faan018_sum + g_faah2_d[l_ac].faan018 
         LET g_faah2_d[l_ac+1].faam015 = l_faam015_sum + g_faah2_d[l_ac].faam015 
         LET g_faah2_d[l_ac+1].fabh011 = l_fabh011_1_sum + g_faah2_d[l_ac].fabh011 
         LET g_faah2_d[l_ac+1].fabh015 = l_fabh015_sum + g_faah2_d[l_ac].fabh015 
         LET g_faah2_d[l_ac+1].fabo019 = l_fabo019_1_sum + g_faah2_d[l_ac].fabo019 
         LET g_faah2_d[l_ac+1].fabh012 = l_fabh012_1_sum + g_faah2_d[l_ac].fabh012 
         LET g_faah2_d[l_ac+1].fabh016 = l_fabh016_sum + g_faah2_d[l_ac].fabh016
         LET g_faah2_d[l_ac+1].faan019 = l_faan019_sum + g_faah2_d[l_ac].faan019 
         LET g_faah2_d[l_ac+1].faan020 = l_faan020_sum + g_faah2_d[l_ac].faan020 
         
         LET l_ac = l_ac+1
      END IF

      CALL afaq160_detail_show("'2'")
      #end add-point
 
      CALL afaq160_detail_show("'1'")
 
      CALL afaq160_faah_t_mask()
 
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
 
   CALL g_faah_d.deleteElement(g_faah_d.getLength())
   CALL g_faah2_d.deleteElement(g_faah2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_faah_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE afaq160_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq160_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq160_detail_action_trans()
 
   LET l_ac = 1
   IF g_faah_d.getLength() > 0 THEN
      CALL afaq160_b_fill2()
   END IF
 
      CALL afaq160_filter_show('faah006','b_faah006')
   CALL afaq160_filter_show('faah007','b_faah007')
   CALL afaq160_filter_show('faah003','b_faah003')
   CALL afaq160_filter_show('faah004','b_faah004')
   CALL afaq160_filter_show('faah001','b_faah001')
   CALL afaq160_filter_show('faan014','b_faan014')
   CALL afaq160_filter_show('faaj016','b_faaj016')
   CALL afaq160_filter_show('faaj017','b_faaj017')
   CALL afaq160_filter_show('fabh010','b_fabh010')
   CALL afaq160_filter_show('faaj018','b_faaj018')
   CALL afaq160_filter_show('fabh011','b_fabh011')
   CALL afaq160_filter_show('fabh012','b_fabh012')
   CALL afaq160_filter_show('faah022','b_faah022')
   CALL afaq160_filter_show('fabo018','b_fabo018')
   CALL afaq160_filter_show('fabh008','b_fabh008')
   CALL afaq160_filter_show('fabr043','b_fabr043')
   CALL afaq160_filter_show('fabh009','b_fabh009')
   CALL afaq160_filter_show('fabo019','b_fabo019')
   CALL afaq160_filter_show('fabr041','b_fabr041')
   CALL afaq160_filter_show('faan015','b_faan015')
 
 
END FUNCTION
 
{</section>}
 
{<section id="afaq160.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq160_b_fill2()
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
 
{<section id="afaq160.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq160_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_faah_d[l_ac].faah006
            LET ls_sql = "SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah007
            LET ls_sql = "SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_d[l_ac].faah032
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faah_d[l_ac].faah032_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_d[l_ac].faah032_desc
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah2_d[l_ac].faah006
            LET ls_sql = "SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faah2_d[l_ac].faah006_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah2_d[l_ac].faah006_1_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah2_d[l_ac].faah007
            LET ls_sql = "SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faah2_d[l_ac].faah007_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah2_d[l_ac].faah007_1_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah2_d[l_ac].faah032
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_faah2_d[l_ac].faah032_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah2_d[l_ac].faah032_1_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq160.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION afaq160_filter()
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
      CONSTRUCT g_wc_filter ON faah006,faah007,faah003,faah004,faah001,faan014,faaj016,faaj017,fabh010, 
          faaj018,fabh011,fabh012,faah022,fabo018,fabh008,fabr043,fabh009,fabo019,fabr041,faan015
                          FROM s_detail1[1].b_faah006,s_detail1[1].b_faah007,s_detail1[1].b_faah003, 
                              s_detail1[1].b_faah004,s_detail1[1].b_faah001,s_detail1[1].b_faan014,s_detail1[1].b_faaj016, 
                              s_detail1[1].b_faaj017,s_detail1[1].b_fabh010,s_detail1[1].b_faaj018,s_detail1[1].b_fabh011, 
                              s_detail1[1].b_fabh012,s_detail1[1].b_faah022,s_detail1[1].b_fabo018,s_detail1[1].b_fabh008, 
                              s_detail1[1].b_fabr043,s_detail1[1].b_fabh009,s_detail1[1].b_fabo019,s_detail1[1].b_fabr041, 
                              s_detail1[1].b_faan015
 
         BEFORE CONSTRUCT
                     DISPLAY afaq160_filter_parser('faah006') TO s_detail1[1].b_faah006
            DISPLAY afaq160_filter_parser('faah007') TO s_detail1[1].b_faah007
            DISPLAY afaq160_filter_parser('faah003') TO s_detail1[1].b_faah003
            DISPLAY afaq160_filter_parser('faah004') TO s_detail1[1].b_faah004
            DISPLAY afaq160_filter_parser('faah001') TO s_detail1[1].b_faah001
            DISPLAY afaq160_filter_parser('faan014') TO s_detail1[1].b_faan014
            DISPLAY afaq160_filter_parser('faaj016') TO s_detail1[1].b_faaj016
            DISPLAY afaq160_filter_parser('faaj017') TO s_detail1[1].b_faaj017
            DISPLAY afaq160_filter_parser('fabh010') TO s_detail1[1].b_fabh010
            DISPLAY afaq160_filter_parser('faaj018') TO s_detail1[1].b_faaj018
            DISPLAY afaq160_filter_parser('fabh011') TO s_detail1[1].b_fabh011
            DISPLAY afaq160_filter_parser('fabh012') TO s_detail1[1].b_fabh012
            DISPLAY afaq160_filter_parser('faah022') TO s_detail1[1].b_faah022
            DISPLAY afaq160_filter_parser('fabo018') TO s_detail1[1].b_fabo018
            DISPLAY afaq160_filter_parser('fabh008') TO s_detail1[1].b_fabh008
            DISPLAY afaq160_filter_parser('fabr043') TO s_detail1[1].b_fabr043
            DISPLAY afaq160_filter_parser('fabh009') TO s_detail1[1].b_fabh009
            DISPLAY afaq160_filter_parser('fabo019') TO s_detail1[1].b_fabo019
            DISPLAY afaq160_filter_parser('fabr041') TO s_detail1[1].b_fabr041
            DISPLAY afaq160_filter_parser('faan015') TO s_detail1[1].b_faan015
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_faah006>>----
         #Ctrlp:construct.c.page1.b_faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.filter.page1.b_faah006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah006  #顯示到畫面上
            NEXT FIELD b_faah006                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_faah006_desc>>----
         #----<<b_faah007>>----
         #Ctrlp:construct.c.page1.b_faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah007
            #add-point:ON ACTION controlp INFIELD b_faah007 name="construct.c.filter.page1.b_faah007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah007  #顯示到畫面上
            NEXT FIELD b_faah007                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_faah007_desc>>----
         #----<<b_faah032>>----
         #----<<b_faah032_desc>>----
         #----<<b_faah003>>----
         #Ctrlp:construct.c.page1.b_faah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah003
            #add-point:ON ACTION controlp INFIELD b_faah003 name="construct.c.filter.page1.b_faah003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah003  #顯示到畫面上
            NEXT FIELD b_faah003                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_faah004>>----
         #Ctrlp:construct.c.page1.b_faah004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah004
            #add-point:ON ACTION controlp INFIELD b_faah004 name="construct.c.filter.page1.b_faah004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah004  #顯示到畫面上
            NEXT FIELD b_faah004                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_faah001>>----
         #Ctrlp:construct.c.page1.b_faah001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah001
            #add-point:ON ACTION controlp INFIELD b_faah001 name="construct.c.filter.page1.b_faah001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah001  #顯示到畫面上
            NEXT FIELD b_faah001                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_faah012>>----
         #----<<b_faah013>>----
         #----<<b_faaj023>>----
         #----<<b_faaj023_desc>>----
         #----<<b_faaj048>>----
         #----<<b_faan014>>----
         #Ctrlp:construct.c.filter.page1.b_faan014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan014
            #add-point:ON ACTION controlp INFIELD b_faan014 name="construct.c.filter.page1.b_faan014"
            
            #END add-point
 
 
         #----<<b_faaj016>>----
         #Ctrlp:construct.c.filter.page1.b_faaj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faaj016
            #add-point:ON ACTION controlp INFIELD b_faaj016 name="construct.c.filter.page1.b_faaj016"
            
            #END add-point
 
 
         #----<<b_faaj017>>----
         #Ctrlp:construct.c.filter.page1.b_faaj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faaj017
            #add-point:ON ACTION controlp INFIELD b_faaj017 name="construct.c.filter.page1.b_faaj017"
            
            #END add-point
 
 
         #----<<b_fabh010>>----
         #Ctrlp:construct.c.filter.page1.b_fabh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabh010
            #add-point:ON ACTION controlp INFIELD b_fabh010 name="construct.c.filter.page1.b_fabh010"
            
            #END add-point
 
 
         #----<<b_faaj018>>----
         #Ctrlp:construct.c.filter.page1.b_faaj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faaj018
            #add-point:ON ACTION controlp INFIELD b_faaj018 name="construct.c.filter.page1.b_faaj018"
            
            #END add-point
 
 
         #----<<b_fabh011>>----
         #Ctrlp:construct.c.filter.page1.b_fabh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabh011
            #add-point:ON ACTION controlp INFIELD b_fabh011 name="construct.c.filter.page1.b_fabh011"
            
            #END add-point
 
 
         #----<<b_fabh012>>----
         #Ctrlp:construct.c.filter.page1.b_fabh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabh012
            #add-point:ON ACTION controlp INFIELD b_fabh012 name="construct.c.filter.page1.b_fabh012"
            
            #END add-point
 
 
         #----<<b_faah022>>----
         #Ctrlp:construct.c.filter.page1.b_faah022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah022
            #add-point:ON ACTION controlp INFIELD b_faah022 name="construct.c.filter.page1.b_faah022"
            
            #END add-point
 
 
         #----<<b_fabo018>>----
         #Ctrlp:construct.c.filter.page1.b_fabo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabo018
            #add-point:ON ACTION controlp INFIELD b_fabo018 name="construct.c.filter.page1.b_fabo018"
            
            #END add-point
 
 
         #----<<b_fabh008>>----
         #Ctrlp:construct.c.filter.page1.b_fabh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabh008
            #add-point:ON ACTION controlp INFIELD b_fabh008 name="construct.c.filter.page1.b_fabh008"
            
            #END add-point
 
 
         #----<<b_fabr043>>----
         #Ctrlp:construct.c.filter.page1.b_fabr043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabr043
            #add-point:ON ACTION controlp INFIELD b_fabr043 name="construct.c.filter.page1.b_fabr043"
            
            #END add-point
 
 
         #----<<b_fabh009>>----
         #Ctrlp:construct.c.filter.page1.b_fabh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabh009
            #add-point:ON ACTION controlp INFIELD b_fabh009 name="construct.c.filter.page1.b_fabh009"
            
            #END add-point
 
 
         #----<<b_fabo019>>----
         #Ctrlp:construct.c.filter.page1.b_fabo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabo019
            #add-point:ON ACTION controlp INFIELD b_fabo019 name="construct.c.filter.page1.b_fabo019"
            
            #END add-point
 
 
         #----<<b_fabr041>>----
         #Ctrlp:construct.c.filter.page1.b_fabr041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fabr041
            #add-point:ON ACTION controlp INFIELD b_fabr041 name="construct.c.filter.page1.b_fabr041"
            
            #END add-point
 
 
         #----<<b_faan015>>----
         #Ctrlp:construct.c.filter.page1.b_faan015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan015
            #add-point:ON ACTION controlp INFIELD b_faan015 name="construct.c.filter.page1.b_faan015"
            
            #END add-point
 
 
         #----<<b_faah006_1>>----
         #----<<b_faah006_1_desc>>----
         #----<<b_faah007_1>>----
         #----<<b_faah007_1_desc>>----
         #----<<b_faah032_1>>----
         #----<<b_faah032_1_desc>>----
         #----<<b_faah003_1>>----
         #----<<b_faah004_1>>----
         #----<<b_faah001_1>>----
         #----<<b_faah012_1>>----
         #----<<b_faah013_1>>----
         #----<<b_faaj024_1>>----
         #----<<b_faaj024_1_desc>>----
         #----<<b_faaj048_1>>----
         #----<<b_faan018_1>>----
         #----<<b_faam015_1>>----
         #----<<b_fabh011_1>>----
         #----<<b_fabh015_1>>----
         #----<<b_fabo019_1>>----
         #----<<b_fabh012_1>>----
         #----<<b_fabh016_1>>----
         #----<<b_faan019_1>>----
         #----<<b_faan020_1>>----
 
 
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
 
      CALL afaq160_filter_show('faah006','b_faah006')
   CALL afaq160_filter_show('faah007','b_faah007')
   CALL afaq160_filter_show('faah003','b_faah003')
   CALL afaq160_filter_show('faah004','b_faah004')
   CALL afaq160_filter_show('faah001','b_faah001')
   CALL afaq160_filter_show('faan014','b_faan014')
   CALL afaq160_filter_show('faaj016','b_faaj016')
   CALL afaq160_filter_show('faaj017','b_faaj017')
   CALL afaq160_filter_show('fabh010','b_fabh010')
   CALL afaq160_filter_show('faaj018','b_faaj018')
   CALL afaq160_filter_show('fabh011','b_fabh011')
   CALL afaq160_filter_show('fabh012','b_fabh012')
   CALL afaq160_filter_show('faah022','b_faah022')
   CALL afaq160_filter_show('fabo018','b_fabo018')
   CALL afaq160_filter_show('fabh008','b_fabh008')
   CALL afaq160_filter_show('fabr043','b_fabr043')
   CALL afaq160_filter_show('fabh009','b_fabh009')
   CALL afaq160_filter_show('fabo019','b_fabo019')
   CALL afaq160_filter_show('fabr041','b_fabr041')
   CALL afaq160_filter_show('faan015','b_faan015')
 
 
   CALL afaq160_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq160.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION afaq160_filter_parser(ps_field)
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
 
{<section id="afaq160.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION afaq160_filter_show(ps_field,ps_object)
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
   LET ls_condition = afaq160_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="afaq160.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq160_detail_action_trans()
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
 
{<section id="afaq160.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq160_detail_index_setting()
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
            IF g_faah_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_faah_d.getLength() AND g_faah_d.getLength() > 0
            LET g_detail_idx = g_faah_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_faah_d.getLength() THEN
               LET g_detail_idx = g_faah_d.getLength()
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
 
{<section id="afaq160.mask_functions" >}
 &include "erp/afa/afaq160_mask.4gl"
 
{</section>}
 
{<section id="afaq160.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 预设值
# Memo...........:
# Date & Author..: 2016/11/13 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_qbeclear()
 DEFINE l_ooef207    LIKE ooef_t.ooef207
 DEFINE l_ooef017    LIKE ooef_t.ooef017 
 DEFINE l_sql        STRING
  #預設值
  SELECT ooef207 INTO l_ooef207
    FROM ooef_t
   WHERE ooefent = g_enterprise AND ooef001 = g_site 
  IF l_ooef207 = 'Y' THEN
     LET g_master.ooef001 = g_site
  ELSE
     LET g_master.ooef001 = '' 
  END IF
  CALL afaq160_ooef001_desc()
  
  #根据资产中心带出法人
  SELECT ooef017 INTO l_ooef017
    FROM ooef_t
   WHERE ooefent = g_enterprise AND ooef001 = g_master.ooef001
    #账套 
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_sql
   LET l_sql = " SELECT DISTINCT glaald ",
               "   FROM glaa_t ",
               "  WHERE glaaent = ",g_enterprise," AND glaacomp = '",l_ooef017,"'",
               "    AND glaastus = 'Y' AND glaa014 = 'Y' AND ",l_sql  
   PREPARE glaald_pre FROM l_sql
   EXECUTE glaald_pre INTO g_master.glaald
      FREE glaald_pre
   CALL afaq160_glaald_desc()
   #年度 期別 
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9018') RETURNING g_master.faaj009
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9019') RETURNING g_master.faaj010_1
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9019') RETURNING g_master.faaj010_2
  
  
END FUNCTION

################################################################################
# Descriptions...: 资产中心名称
# Memo...........:
# Date & Author..: 2016/11/13 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_ooef001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.ooef001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.ooef001,g_master.ooef001_desc
END FUNCTION

################################################################################
# Descriptions...: 账套名称
# Memo...........:
# Date & Author..: 2016/11/13 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_glaald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.glaald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.glaald,g_master.glaald_desc
END FUNCTION

################################################################################
# Descriptions...: 选单功能
# Memo...........:
# Date & Author..: 2016/11/13 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_ui_dialog_1()
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
      CALL afaq160_b_fill()
   ELSE
      CALL afaq160_query_1()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faah_d.clear()
         CALL g_faah2_d.clear()
 
 
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
 
         CALL afaq160_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faah_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afaq160_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
              # CALL afaq160_b_fill2()
               #单身第一页签总数显示
               LET g_detail_cnt = g_faah_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               #單身第二页签總筆數顯示
               LET g_detail_cnt2 = g_faah2_d.getLength()
               DISPLAY g_detail_cnt2 TO FORMONLY.cnt
               IF g_detail_cnt2 > 0 THEN
                  LET g_detail_idx2 = 1
                  DISPLAY g_detail_idx2 TO FORMONLY.idx
               ELSE
                  LET g_detail_idx2 = 0
                  DISPLAY ' ' TO FORMONLY.idx
               END IF
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
         DISPLAY ARRAY g_faah2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               #單身第二页签總筆數顯示
               LET g_detail_cnt2 = g_faah2_d.getLength()
               DISPLAY g_detail_cnt2 TO FORMONLY.cnt
               #單身第一页签總筆數顯示
               LET g_detail_cnt = g_faah_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               IF g_detail_cnt > 0 THEN
                  LET g_detail_idx = 1
                  DISPLAY g_detail_idx TO FORMONLY.h_index
               ELSE
                  LET g_detail_idx = 0
                  DISPLAY ' ' TO FORMONLY.h_index
               END IF
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"

            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afaq160_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"

            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               IF NOT cl_ask_confirm("afa-01129") THEN
                  #按否列印匯總
                  CALL afaq160_x02('1=1','afaq160_x02_tmp')  
               ELSE
                  CALL afaq160_x01('1=1','afaq160_x01_tmp') 
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afaq160_query_1()
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
            CALL afaq160_filter()
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
            CALL afaq160_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_faah_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_faah2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
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
            CALL afaq160_b_fill()
           
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq160_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq160_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq160_b_fill()
 
         
         
 
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

################################################################################
# Descriptions...: 查询
# Memo...........:
# Date & Author..: 2016/11/13 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_query_1()
DEFINE ls_wc      LIKE type_t.chr500
  DEFINE ls_return  STRING
  DEFINE ls_result  STRING 
  DEFINE l_origin_str  STRING
  DEFINE l_count    LIKE type_t.num5  
  DEFINE l_ooef017    LIKE ooef_t.ooef017 
  DEFINE l_sql      STRING


   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faah_d.clear()
   CALL g_faah2_d.clear()
   LET g_wc_filter = " 1=1"
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   INITIALIZE g_master.* TO NULL 
   
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

       INPUT BY NAME g_master.ooef001,g_master.glaald,g_master.faaj009,g_master.faaj010_1,g_master.faaj010_2
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         BEFORE FIELD ooef001
           LET g_master_t.ooef001 = g_master.ooef001
         AFTER  FIELD ooef001
           IF NOT cl_null(g_master.ooef001) THEN
              #检查组织资料的合理性             
              IF NOT s_afat502_site_chk(g_master.ooef001) THEN                                 
                  LET g_master.ooef001 = g_master_t.ooef001
                  CALL afaq160_ooef001_desc()
                  NEXT FIELD CURRENT
              END IF 
              #檢查是否資產組織                 
              LET l_count = 0
              SELECT COUNT(1) INTO l_count 
                FROM ooef_t
               WHERE ooefent = g_enterprise 
                 AND ooef001 = g_master.ooef001
                 AND ooef207 = 'Y'
              IF l_count =0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-00004'
                 LET g_errparam.extend = g_master.ooef001
                 LET g_errparam.popup = FALSE
                 CALL cl_err()                   
                 LET g_master.ooef001 = g_master_t.ooef001
                 CALL afaq160_ooef001_desc()
                 NEXT FIELD CURRENT
              END IF                     
                                                  
           END IF
           
           #法人
           SELECT ooef017 INTO l_ooef017    
             FROM ooef_t
            WHERE ooefent = g_enterprise AND ooef001 = g_master.ooef001
            
            #账套 
             CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_sql
             LET l_sql = " SELECT DISTINCT glaald ",
                         "   FROM glaa_t ",
                         "  WHERE glaaent = ",g_enterprise," AND glaacomp = '",l_ooef017,"'",
                         "    AND glaastus = 'Y' AND glaa014 = 'Y' AND ",l_sql  
             PREPARE glaald_pre_2 FROM l_sql
             EXECUTE glaald_pre_2 INTO g_master.glaald
                FREE glaald_pre_2
            
             CALL afaq160_ooef001_desc()
             CALL afaq160_glaald_desc()
           

         ON ACTION controlp INFIELD ooef001
            INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	          LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = ''      #給予default值
             LET g_qryparam.where = " ooef207 = 'Y' "            
             CALL q_ooef001_47()   
             LET g_master.ooef001 = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master.ooef001 TO ooef001             #顯示到畫面上
             CALL afaq160_ooef001_desc()
             NEXT FIELD ooef001               
         
         BEFORE FIELD glaald
            LET g_master_t.glaald = g_master.glaald
            
         AFTER  FIELD glaald
              IF NOT cl_null(g_master.glaald) THEN
                
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_master.glaald
               
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
              
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  
               ELSE
                  LET g_master.glaald = g_master_t.glaald
                  CALL afaq160_glaald_desc()                
               END IF               
            
               IF NOT s_ld_chk_authorization(g_user,g_master.glaald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_master.glaald
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master.glaald = g_master_t.glaald
                  CALL afaq160_glaald_desc()          
                  NEXT FIELD CURRENT
               END IF
               
              #资产中心不为空时
               IF NOT cl_null(g_master.ooef001) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.ooef001,g_master_t.glaald,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master_t.glaald =  g_master_t.glaald
                     DISPLAY g_master_t.glaald TO glaald
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            END IF  
         ON ACTION controlp INFIELD glaald
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master_t.glaald         #給予default值
 
            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_master.ooef001,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_afat502_change_to_sql(l_origin_str) RETURNING l_origin_str  
            LET l_origin_str=l_origin_str.substring(2,l_origin_str.getLength()-1)          
             LET g_qryparam.where = " glaa014 = 'Y'" 
            #給予arg
            LET g_qryparam.arg1 = g_user #
            LET g_qryparam.arg2 = g_dept #
            
            CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING g_wc_cs_ld
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_qryparam.where," AND ",g_wc_cs_ld
            END IF
           
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.glaald  = g_qryparam.return1              
            DISPLAY g_master.glaald TO glaald 
            CALL afaq160_glaald_desc()
            NEXT FIELD glaald
            
            
         AFTER FIELD faaj009
         
         BEFORE FIELD faaj010_1
          LET g_master_t.faaj010_1 = g_master.faaj010_1
          
         AFTER FIELD faaj010_1
         
           IF NOT cl_null(g_master.faaj010_1) THEN 
             IF g_master.faaj010_1 < 1 OR g_master.faaj010_1 > 13 THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'afa-01125'
                LET g_errparam.extend = g_master.faaj010_1
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_1 = g_master_t.faaj010_1
                NEXT FIELD faaj010_1
             END IF 
             IF NOT cl_null(g_master.faaj010_2) AND g_master.faaj010_1 > g_master.faaj010_2  THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00227'
                LET g_errparam.extend = g_master.faaj010_1
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_1 = g_master_t.faaj010_1
                NEXT FIELD faaj010_1
             END IF 
          END IF 
          
          
         BEFORE FIELD faaj010_2
            LET g_master_t.faaj010_2 = g_master.faaj010_2
         
         AFTER FIELD faaj010_2
             IF NOT cl_null(g_master.faaj010_2) THEN 
             IF g_master.faaj010_2 < 1 OR g_master.faaj010_2 > 13 THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'afa-01125'
                LET g_errparam.extend = g_master.faaj010_2
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_2 = g_master_t.faaj010_2
                NEXT FIELD faaj010_2
             END IF 
             IF NOT cl_null(g_master.faaj010_1) AND g_master.faaj010_1 > g_master.faaj010_2  THEN 
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00228'
                LET g_errparam.extend = g_master.faaj010_2
                LET g_errparam.popup = FALSE
                CALL cl_err()
                LET g_master.faaj010_2 = g_master_t.faaj010_2
                NEXT FIELD faaj010_2
             END IF 
          END IF 
          
         
       END INPUT 
       
       CONSTRUCT g_wc ON faah006,faah007,faah032,faah003,faah004,faah001                      
          FROM s_detail1[1].b_faah006,s_detail1[1].b_faah007,s_detail1[1].b_faah032,s_detail1[1].b_faah003,
               s_detail1[1].b_faah004,s_detail1[1].b_faah001
               
       BEFORE CONSTRUCT
          
           ON ACTION controlp INFIELD b_faah006
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
           CALL q_faac001()                                    #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah006             #顯示到畫面上
           NEXT FIELD b_faah006
           
           
           ON ACTION controlp INFIELD b_faah007
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
           CALL q_faad001()                                    #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah007             #顯示到畫面上
           NEXT FIELD b_faah007
           
           ON ACTION controlp INFIELD b_faah032
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
           CALL q_ooef001()                                    #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah032             #顯示到畫面上
           NEXT FIELD b_faah032
           
           ON ACTION controlp INFIELD b_faah001
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
           CALL q_faah001()                                    #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah001             #顯示到畫面上
           NEXT FIELD b_faah001
           
           ON ACTION controlp INFIELD b_faah003
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
           CALL q_faah003()                                    #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah003             #顯示到畫面上
           NEXT FIELD b_faah003
           
           ON ACTION controlp INFIELD b_faah004
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
           CALL q_faah004()                                    #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah004             #顯示到畫面上
           NEXT FIELD b_faah004
           
       END CONSTRUCT
       
      BEFORE DIALOG
        CALL afaq160_qbeclear()
       
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
     
      END DIALOG
      
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_error_show = 1

   CALL afaq160_b_fill()
   LET l_ac = g_master_idx
   
END FUNCTION

################################################################################
# Descriptions...: 建临时表用于Q转XG
# Memo...........:
# Date & Author..: 2016/11/16 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_create_tmp()
  DROP TABLE afaq160_x01_tmp;
  CREATE TEMP TABLE afaq160_x01_tmp(
   ooef001_desc  VARCHAR(80),
   glaald_desc   VARCHAR(80),
   faaj009  SMALLINT,
   faaj010_1  SMALLINT,
   faaj010_2  SMALLINT,
   faah006_desc  VARCHAR(500), 
   faah007_desc  VARCHAR(500), 
   faah032_desc  VARCHAR(500), 
   faah003  VARCHAR(20), 
   faah004  VARCHAR(20), 
   faah001  VARCHAR(10), 
   faah012  VARCHAR(500), 
   faah013  VARCHAR(500), 
   faaj023  VARCHAR(500),
   faaj023_desc  VARCHAR(80),   
   faaj048_desc  VARCHAR(80), 
   faan014  DECIMAL(20,6), 
   faaj016  DECIMAL(20,6), 
   faaj017  DECIMAL(20,6), 
   fabh010  DECIMAL(20,6), 
   faaj018  DECIMAL(20,6), 
   fabh011  DECIMAL(20,6), 
   fabh012  DECIMAL(20,6), 
   faah022  DECIMAL(20,6), 
   fabo018  DECIMAL(20,6), 
   fabh008  DECIMAL(20,6), 
   fabr043  DECIMAL(20,6), 
   fabh009  DECIMAL(20,6), 
   fabo019  DECIMAL(20,6), 
   fabr041  DECIMAL(20,6), 
   faan015  DECIMAL(20,6)
   );
  DROP TABLE afaq160_x02_tmp;
  CREATE TEMP TABLE afaq160_x02_tmp(
   ooef001_desc  VARCHAR(80),
   glaald_desc   VARCHAR(80),
   faaj009  SMALLINT,
   faaj010_1  SMALLINT,
   faaj010_2  SMALLINT,  
   faah006_desc  VARCHAR(500), 
   faah007_desc  VARCHAR(500), 
   faah032_desc  VARCHAR(500), 
   faah003  VARCHAR(20), 
   faah004  VARCHAR(20), 
   faah001  VARCHAR(10), 
   faah012  VARCHAR(255), 
   faah013  VARCHAR(255), 
   faaj024  VARCHAR(24),
   faaj024_desc  VARCHAR(80),   
   faaj048_desc  VARCHAR(80),
   faan018  DECIMAL(20,6), 
   faam015  DECIMAL(20,6), 
   fabh011  DECIMAL(20,6), 
   fabh015  DECIMAL(20,6), 
   fabo019  DECIMAL(20,6), 
   fabh012  DECIMAL(20,6), 
   fabh016  DECIMAL(20,6), 
   faan019  DECIMAL(20,6), 
   faan020  DECIMAL(20,6)
   ) 
END FUNCTION

################################################################################
# Descriptions...: 插入临时表数据
# Memo...........:
# Date & Author..: 2016/11/16 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq160_ins_tmp()
   DEFINE ls_sql         STRING
   DEFINE l_faaj048_desc LIKE type_t.chr80
   DEFINE l_faah006_desc LIKE type_t.chr500
   DEFINE l_faah007_desc LIKE type_t.chr500 
   DEFINE l_faah032_desc LIKE type_t.chr500 
   DEFINE l_ooef001_desc LIKE type_t.chr80
   DEFINE l_glaald_desc  LIKE type_t.chr80
    

   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_d[l_ac].faah006
   LET ls_sql = "SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET g_faah_d[l_ac].faah006_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_d[l_ac].faah007
   LET ls_sql = "SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET g_faah_d[l_ac].faah007_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faah_d[l_ac].faah032
   LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
   LET g_faah_d[l_ac].faah032_desc = '', g_rtn_fields[1] , ''
   
   #列管/列账 说明
   LET l_faaj048_desc = ''
   SELECT gzcbl004 INTO l_faaj048_desc
     FROM gzcbl_t
    WHERE gzcbl001 = '9897'
      AND gzcbl002 = g_faah_d[l_ac].faaj048
      AND gzcbl003 = g_dlang          
   LET l_faaj048_desc = g_faah_d[l_ac].faaj048,":",l_faaj048_desc   
   IF cl_null(g_faah_d[l_ac].faaj048) THEN
      LET l_faaj048_desc =''
   END IF
   
   #资产中心
   LET l_ooef001_desc = g_master.ooef001," ",g_master.ooef001_desc
   #账套
   LET l_glaald_desc = g_master.glaald," ",g_master.glaald_desc
   
   #主要类别说明
   LET l_faah006_desc = g_faah_d[l_ac].faah006,":",g_faah_d[l_ac].faah006_desc
   IF cl_null(g_faah_d[l_ac].faah006)THEN
      LET l_faah006_desc = ''
   END IF
   #次要类别
   LET l_faah007_desc = g_faah_d[l_ac].faah007,":",g_faah_d[l_ac].faah007_desc 
   IF cl_null(g_faah_d[l_ac].faah007)THEN
      LET l_faah007_desc = ''
   END IF
   #法人说明
   LET l_faah032_desc = g_faah_d[l_ac].faah032,":",g_faah_d[l_ac].faah032_desc 
   IF cl_null(g_faah_d[l_ac].faah032)THEN
      LET l_faah032_desc = ''
   END IF
   
   #插入第一页签的数据 （不含小计，合计） 
   INSERT INTO afaq160_x01_tmp VALUES(l_ooef001_desc,l_glaald_desc,g_master.faaj009,g_master.faaj010_1,g_master.faaj010_2,
       l_faah006_desc,l_faah007_desc,l_faah032_desc,g_faah_d[l_ac].faah003, 
       g_faah_d[l_ac].faah004,g_faah_d[l_ac].faah001,g_faah_d[l_ac].faah012,g_faah_d[l_ac].faah013,g_faah_d[l_ac].faaj023, 
       g_faah_d[l_ac].faaj023_desc,l_faaj048_desc,g_faah_d[l_ac].faan014,g_faah_d[l_ac].faaj016,g_faah_d[l_ac].faaj017,g_faah_d[l_ac].fabh010, 
       g_faah_d[l_ac].faaj018,g_faah_d[l_ac].fabh011,g_faah_d[l_ac].fabh012,g_faah_d[l_ac].faah022,g_faah_d[l_ac].fabo018, 
       g_faah_d[l_ac].fabh008,g_faah_d[l_ac].fabr043,g_faah_d[l_ac].fabh009,g_faah_d[l_ac].fabo019,g_faah_d[l_ac].fabr041, 
       g_faah_d[l_ac].faan015)
       
   
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faah2_d[l_ac].faah006
    LET ls_sql = "SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'"
    LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
    CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
    LET g_faah2_d[l_ac].faah006_1_desc = '', g_rtn_fields[1] , ''
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faah2_d[l_ac].faah007
    LET ls_sql = "SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'"
    LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
    CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
    LET g_faah2_d[l_ac].faah007_1_desc = '', g_rtn_fields[1] , ''
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faah2_d[l_ac].faah032
    LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
    LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
    CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
    LET g_faah2_d[l_ac].faah032_1_desc = '', g_rtn_fields[1] , ''
    
    #列管/列账 说明
    LET l_faaj048_desc = ''
    SELECT gzcbl004 INTO l_faaj048_desc
      FROM gzcbl_t
     WHERE gzcbl001 = '9897'
       AND gzcbl002 = g_faah2_d[l_ac].faaj048
       AND gzcbl003 = g_dlang          
    LET l_faaj048_desc = g_faah2_d[l_ac].faaj048,":",l_faaj048_desc   
    IF cl_null(g_faah2_d[l_ac].faaj048) THEN
      LET l_faaj048_desc =''
    END IF
    
    #主要类别说明
   LET l_faah006_desc = g_faah2_d[l_ac].faah006,":",g_faah2_d[l_ac].faah006_1_desc
   IF cl_null(g_faah2_d[l_ac].faah006)THEN
      LET l_faah006_desc = ''
   END IF
   #次要类别
   LET l_faah007_desc = g_faah2_d[l_ac].faah007,":",g_faah2_d[l_ac].faah007_1_desc 
   IF cl_null(g_faah2_d[l_ac].faah007)THEN
      LET l_faah007_desc = ''
   END IF
   #法人说明
   LET l_faah032_desc = g_faah2_d[l_ac].faah032,":",g_faah2_d[l_ac].faah032_1_desc 
   IF cl_null(g_faah2_d[l_ac].faah032)THEN
      LET l_faah032_desc = ''
   END IF
    
   #插入第二页签的数据（不含小计，合计）
   INSERT INTO afaq160_x02_tmp VALUES(l_ooef001_desc,l_glaald_desc,g_master.faaj009,g_master.faaj010_1,g_master.faaj010_2,
       l_faah006_desc,l_faah007_desc,l_faah032_desc,g_faah2_d[l_ac].faah003, 
       g_faah2_d[l_ac].faah004,g_faah2_d[l_ac].faah001,g_faah2_d[l_ac].faah012,g_faah2_d[l_ac].faah013, 
       g_faah2_d[l_ac].faaj024,g_faah2_d[l_ac].faaj024_1_desc,l_faaj048_desc,g_faah2_d[l_ac].faan018,g_faah2_d[l_ac].faam015, 
       g_faah2_d[l_ac].fabh011,g_faah2_d[l_ac].fabh015,g_faah2_d[l_ac].fabo019,g_faah2_d[l_ac].fabh012, 
       g_faah2_d[l_ac].fabh016,g_faah2_d[l_ac].faan019,g_faah2_d[l_ac].faan020)

       
       
END FUNCTION

 
{</section>}
 
