#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-11-30 13:53:37), PR版次:0007(2016-11-30 15:05:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: anmq520
#+ Description: 應收票據異動查詢
#+ Creator....: 06816(2015-10-20 16:01:13)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="anmq520.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#27  2016/03/23 By 07900     重复错误信息修改
#160321-00016#39  2016/03/30 By Jessy     將重複內容的錯誤訊息置換為公用錯誤訊息
#160526-00037#2   2016/06/15 By 02599     功能调整
#160719-00022#1   2016/07/19 By Reanna    交易對象改抓nmbb026顯示
#160720-00024#1   2016/07/20 By Reanna    交易對象輸入條件查詢，都查不到資料，明明有該筆資料，開窗應該開客戶才對
#160816-00012#4   2016/09/08 By 07900     ANM增加资金中心，帐套，法人三个栏位权限
#160913-00017#5   2016/09/23 By 07900     ANM模组调整交易客商开窗
#161021-00050#8   2016/10/26 By Reanna    资金中心开窗需调整为q_ooef001_33;法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留
#161125-00036#7   161130     By albireo   增加實際兌現日邏輯
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
PRIVATE TYPE type_g_nmba_d RECORD
       
       sel LIKE type_t.chr1, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbadocno_desc LIKE type_t.chr500, 
   nmbbseq LIKE nmbb_t.nmbbseq, 
   nmba004 LIKE nmba_t.nmba004, 
   nmba004_desc LIKE type_t.chr500, 
   nmbb030 LIKE nmbb_t.nmbb030, 
   nmbb028 LIKE nmbb_t.nmbb028, 
   nmbb028_desc LIKE type_t.chr500, 
   nmbb043 LIKE nmbb_t.nmbb043, 
   nmbb043_desc LIKE type_t.chr500, 
   nmbb065 LIKE nmbb_t.nmbb065, 
   nmbb031 LIKE nmbb_t.nmbb031, 
   l_nmck012 LIKE type_t.dat, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb007 LIKE nmbb_t.nmbb007, 
   nmbb044 LIKE nmbb_t.nmbb044, 
   nmbb045 LIKE nmbb_t.nmbb045, 
   nmbb042 LIKE nmbb_t.nmbb042, 
   nmbacomp LIKE nmba_t.nmbacomp
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_nmcq_d RECORD
   nmcqdocdt LIKE nmcq_t.nmcqdocdt,
   nmcq001   LIKE nmcq_t.nmcq001, 
   nmcqdocno LIKE nmcq_t.nmcqdocno, 
   nmcr103   LIKE nmcr_t.nmcr103,   #160526-00037#2 add
   nmcr113   LIKE nmcr_t.nmcr113,   #160526-00037#2 add
   nmcqstus  LIKE nmcq_t.nmcqstus
         END RECORD
DEFINE g_master   RECORD
   nmbasite       LIKE nmba_t.nmbasite,
   nmbasite_desc  LIKE type_t.chr500,
   nmbacomp       LIKE nmba_t.nmbacomp,
   nmbacomp_desc  LIKE type_t.chr500
              END RECORD
  
 TYPE type_g_nmbb_d RECORD
   nmbb004    LIKE nmbb_t.nmbb004,
   l_total    LIKE type_t.num20_6, 
   nmbb007_s  LIKE nmbb_t.nmbb007, #160526-00037#2 add
   l_numdocno LIKE type_t.num10
          END RECORD
DEFINE g_nmcq_d       DYNAMIC ARRAY OF type_g_nmcq_d
DEFINE g_nmbb_d       DYNAMIC ARRAY OF type_g_nmbb_d
DEFINE l_ac2          LIKE type_t.num10
DEFINE l_ac3          LIKE type_t.num10
DEFINE g_glaald     LIKE glaa_t.glaald
DEFINE g_nmbacomp_str  STRING   #組織範圍
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmba_d            DYNAMIC ARRAY OF type_g_nmba_d
DEFINE g_nmba_d_t          type_g_nmba_d
 
 
 
 
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
 
{<section id="anmq520.main" >}
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
   CALL cl_ap_init("anm","")
 
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
   DECLARE anmq520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq520_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq520_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq520 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq520_init()   
 
      #進入選單 Menu (="N")
      CALL anmq520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq520
      
   END IF 
   
   CLOSE anmq520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq520_init()
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
   
      CALL cl_set_combo_scc('b_nmbb044','8715') 
   CALL cl_set_combo_scc('b_nmbb042','8714') 
  
 
   #add-point:畫面資料初始化 name="init.init"
#   CALL cl_set_combo_scc('b_nmbb042','8714') #160526-00037#2 mark
#   CALL cl_set_combo_scc_part('b_nmbastus','13','N,Y,A,D,R,W,X') #160526-00037#2 mark
   CALL cl_set_combo_scc_part('b_nmcqstus','13','N,Y,A,D,R,W,X')  #160526-00037#2 add
   CALL cl_set_combo_scc('b_nmcq001','8714')  #160526-00037#2 add
   CALL anmq520_x01_tmp()
   CALL s_fin_create_account_center_tmp()
   
   #end add-point
 
   CALL anmq520_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq520.default_search" >}
PRIVATE FUNCTION anmq520_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmbacomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmbadocno = '", g_argv[02], "' AND "
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
 
{<section id="anmq520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq520_ui_dialog() 
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
   DEFINE l_ld      LIKE glaa_t.glaald
   DEFINE l_comp    LIKE ooef_t.ooef001
   DEFINE l_errno   LIKE gzze_t.gzze001
   DEFINE l_success LIKE type_t.num10
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_date_chr   LIKE type_t.chr100 #160526-00037#2 add
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5  #160816-00012#4 Add
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
 
   
   CALL anmq520_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmba_d.clear()
 
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
 
         CALL anmq520_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.nmbasite,g_master.nmbasite_desc,g_master.nmbacomp,g_master.nmbacomp_desc
            ATTRIBUTE(WITHOUT DEFAULTS)
                        
            ON ACTION controlp INFIELD nmbasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmbasite
               LET g_qryparam.default2 = g_master.nmbasite_desc  #g_master.nmbasite_desc #說明(簡稱)
               LET g_qryparam.where = " ooef206 = 'Y' "
               #CALL q_ooef001()    #161021-00050#8 mark
               CALL q_ooef001_33()  #161021-00050#8
               LET g_master.nmbasite = g_qryparam.return1
               LET g_master.nmbasite_desc = g_qryparam.return2
               DISPLAY BY NAME g_master.nmbasite,g_master.nmbasite_desc
               NEXT FIELD nmbasite
            
            
            AFTER FIELD nmbasite
               LET g_master.nmbasite_desc = ''
               DISPLAY BY NAME g_master.nmbasite_desc
               IF NOT cl_null(g_master.nmbasite) THEN 
                  CALL anmq520_nmbasite_chk(g_master.nmbasite)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.nmbasite
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_orga_get_comp_ld(g_master.nmbasite) RETURNING g_sub_success,g_errno,g_master.nmbacomp,g_glaald
                  #160816-00012#4 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmbacomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep1 FROM l_sql
                  EXECUTE anmp410_count_prep1 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     LET g_master.nmbacomp = ''           
                     DISPLAY BY NAME g_master.nmbacomp
                  END IF
                  #160816-00012#4 Add  ---(E)---
                  CALL s_fin_account_center_sons_query('6',g_master.nmbasite,g_today,'')
                  CALL s_fin_account_center_comp_str()  RETURNING g_nmbacomp_str
                  CALL s_fin_get_wc_str(g_nmbacomp_str) RETURNING g_nmbacomp_str
               END IF
               LET g_master.nmbasite_desc = s_desc_get_department_desc(g_master.nmbasite)
               DISPLAY BY NAME g_master.nmbasite,g_master.nmbasite_desc
               LET g_master.nmbacomp_desc = s_desc_get_department_desc(g_master.nmbacomp)
               DISPLAY BY NAME g_master.nmbacomp,g_master.nmbacomp_desc
            
            
            ON ACTION controlp INFIELD nmbacomp
               #160816-00012#4 Add  ---(S)---
               CALL s_fin_account_center_sons_query('6',g_master.nmbasite,g_today,'')
               CALL s_fin_account_center_comp_str()  RETURNING g_nmbacomp_str
               CALL s_fin_get_wc_str(g_nmbacomp_str) RETURNING g_nmbacomp_str
               #160816-00012#4 Add  ---(E)---
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmbacomp
               LET g_qryparam.default2 = g_master.nmbacomp_desc #g_master.nmbacomp_desc #說明(簡稱)
               #160816-00012#4 mark---(S)---
#               IF cl_null(g_nmbacomp_str) THEN
#                  LET g_qryparam.where = " ooef001 IN(SELECT ooef017 FROM ooef_t WHERE ooef001 = '",g_master.nmbasite,"' )"
#               ELSE                        
#                  LET g_qryparam.where = " ooef001 IN ",g_nmbacomp_str CLIPPED
#               END IF
               #160816-00012#4 mark---(E)---               
               #160816-00012#4 Add  ---(S)---
               LET g_qryparam.where = " ooef001 IN ",g_nmbacomp_str CLIPPED             
               #160816-00012#4 Add  ---(E)---
               #CALL q_ooef001()  #161021-00050#8 mark
               CALL q_ooef001_2() #161021-00050#8
               LET g_master.nmbacomp = g_qryparam.return1
               LET g_master.nmbacomp_desc = g_qryparam.return2
               DISPLAY BY NAME g_master.nmbacomp,g_master.nmbacomp_desc
               NEXT FIELD nmbacomp
               
            AFTER FIELD nmbacomp
               LET g_master.nmbacomp_desc = ''
               DISPLAY BY NAME g_master.nmbacomp_desc
               IF NOT cl_null(g_master.nmbacomp) THEN
                  CALL s_fin_comp_chk(g_master.nmbacomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#39 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#39 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmbacomp = ''
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.nmbasite) THEN  #160816-00012#4 Add  
                      LET l_cnt = 0
                      SELECT COUNT(1) INTO l_cnt
                        FROM ooef_t
                       WHERE ooefent = g_enterprise AND ooef017 = g_master.nmbacomp 
                         AND ooef001 = g_master.nmbasite
                      IF s_chr_get_index_of(g_nmbacomp_str,g_master.nmbacomp,1) = 0 AND l_cnt = 0 THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = 'anm-02928'
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET g_master.nmbacomp = ''
                         NEXT FIELD CURRENT
                      END IF
                  END IF  #160816-00012#4 Add  
                  #160816-00012#4 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmbacomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep2 FROM l_sql
                  EXECUTE anmp410_count_prep2 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmbacomp = ''                     
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add  ---(E)---
               END IF
               LET g_master.nmbacomp_desc = s_desc_get_department_desc(g_master.nmbacomp)
               DISPLAY BY NAME g_master.nmbacomp,g_master.nmbacomp_desc
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON nmbadocno,nmba004,nmbb031,nmbb004
                      FROM nmbadocno,nmba004,nmbb031,nmbb004
            
            #R 單號卡法人
            ON ACTION controlp INFIELD nmbadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " nmbacomp = '",g_master.nmbacomp,"' AND nmbasite = '",g_master.nmbasite,"' "
               CALL q_nmbadocno()
               DISPLAY g_qryparam.return1 TO nmbadocno
               NEXT FIELD nmbadocno
            
            ON ACTION controlp INFIELD nmba004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') " #160720-00024#1
               # CALL q_pmaa001()   #160913-00017#5  mark                  #呼叫開窗
               #160913-00017#5--ADD(S)--
               LET g_qryparam.arg1="('2','3')"
               CALL q_pmaa001_1()
               #160913-00017#5--ADD(E)- 
               DISPLAY g_qryparam.return1 TO nmba004
               NEXT FIELD nmba004
            
            ON ACTION controlp INFIELD nmbb004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()
               DISPLAY g_qryparam.return1 TO nmbb004
               NEXT FIELD nmbb004
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_nmba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq520_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq520_b_fill2()
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
         DISPLAY ARRAY g_nmcq_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)  
            BEFORE DISPLAY 
               LET g_current_page = 2            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_nmcq_d.getLength() TO FORMONLY.cnt
               LET g_master_idx = l_ac
            
            ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                     
               ON ACTION prog_anmt510
                  LET g_action_choice="prog_anmt510"
                  IF cl_auth_chk_act("prog_anmt510") THEN
                     INITIALIZE la_param.* TO NULL
                     IF g_nmcq_d[g_detail_idx2].nmcq001 = '1' THEN
                        LET la_param.prog  = 'anmt510'
                     ELSE                  
                        LET la_param.prog  = 'anmt520'
                     END IF
                     LET la_param.param[1] = g_nmba_d[g_master_idx].nmbacomp
                     LET la_param.param[2] = g_nmcq_d[g_detail_idx2].nmcqdocno
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  END IF
               END MENU
         END DISPLAY
         
         DISPLAY ARRAY g_nmbb_d TO s_detail3.*   ATTRIBUTES(COUNT=g_detail_cnt)  
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq520_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL anmq520_qbe_clear()
#            LET g_wc = "1 =1"  #160526-00037#2 mark
            #160526-00037#2--add--str--
            LET l_date_chr = ">=",g_today
            DISPLAY l_date_chr TO nmbb031
            LET g_wc = " nmbb031 >='",g_today,"'"
            #160526-00037#2--add--end
            #end add-point
            NEXT FIELD nmbasite
 
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
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL anmq520_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_nmba_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_nmcq_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_nmbb_d)
               LET g_export_id[3]   = "s_detail3"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq520_b_fill()
 
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
            CALL anmq520_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq520_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq520_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq520_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmba_d.getLength()
               LET g_nmba_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmba_d.getLength()
               LET g_nmba_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmba_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmba_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq520_filter()
            #add-point:ON ACTION filter name="menu.filter"
            NEXT FIELD nmbasite
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL anmq520_ins_tmp()
               CALL anmq520_x01(" 1 = 1","anmq520_x01_tmp")
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL anmq520_ins_tmp()
               CALL anmq520_x01(" 1 = 1","anmq520_x01_tmp")
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL anmq520_qbe_clear()
               LET g_wc = "1 =1"
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
 
{<section id="anmq520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq520_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING   #161125-00036#7
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
 
   CALL g_nmba_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #160720-00024#1-s
   IF NOT cl_null(ls_wc) THEN
      CALL s_chr_replace(ls_wc,'nmba004','nmbb026',0) RETURNING ls_wc
   END IF
   #160720-00024#1-e
   
   #161125-00036#7-----s
   LET l_sql = "SELECT MAX(nmbc005) FROM nmbc_t ",
               " WHERE nmbcent = ",g_enterprise," ",
               "   AND nmbc012 = ? ",
               "   AND nmbccomp = ? ",
               "   AND nmbc003 = ? "
   PREPARE sel_nmbc005p FROM l_sql
   #161125-00036#7-----e
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',nmbadocno,'','',nmba004,'','','','','','','','','','','','', 
       '','','','',nmbacomp  ,DENSE_RANK() OVER( ORDER BY nmba_t.nmbacomp,nmba_t.nmbadocno) AS RANK FROM nmba_t", 
 
 
 
                     "",
                     " WHERE nmbaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmba_t"),
                     " ORDER BY nmba_t.nmbacomp,nmba_t.nmbadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #LET ls_sql_rank = "SELECT UNIQUE 'N',nmbadocno,'',nmbbseq,nmba004,", #160526-00037#2 add nmbbseq #160719-00022#1 mark
   LET ls_sql_rank = "SELECT UNIQUE 'N',nmbadocno,'',nmbbseq,nmbb026,",  #160719-00022#1
                     "       '',nmbb030,nmbb028,'',nmbb043,",
                     "       '',nmbb065,nmbb031,'',nmbb004,nmbb006,",    #161125-00036#7 add '' l_nmck012
                     "       nmbb005,nmbb007,nmbb044,nmbb045,nmbb042,",  #160526-00037#2 add nmbb042
                     "       nmbacomp ",
                     "  FROM nmba_t,nmbb_t ",
                     " WHERE nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno",
                     "   AND nmbaent= ?  AND nmbb029 = '30' ",
                     "   AND nmbasite = '",g_master.nmbasite,"' AND nmbacomp = '",g_master.nmbacomp,"' ",
                     "   AND ", ls_wc
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
 
   LET g_sql = "SELECT '',nmbadocno,'','',nmba004,'','','','','','','','','','','','','','','','',nmbacomp", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
  #LET g_sql = "SELECT UNIQUE 'N',nmbadocno,'',nmbbseq,nmbb004,", #160526-00037#2 add nmbbseq #160719-00022#1 mark
   LET g_sql = "SELECT UNIQUE 'N',nmbadocno,'',nmbbseq,nmbb026,", #160719-00022#1
               "       '',nmbb030,nmbb028,'',nmbb043,",
               "       '',nmbb065,nmbb031,'',nmbb004,nmbb006,",   #161125-00036#7 add '' l_nmck012
               "       nmbb005,nmbb007,nmbb044,nmbb045,nmbb042,", #160526-00037#2 add nmbb042
               "       nmbacomp ",
               "  FROM (",ls_sql_rank,")",
               " ORDER BY nmbb004,nmbadocno "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq520_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq520_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_nmba_d[l_ac].sel,g_nmba_d[l_ac].nmbadocno,g_nmba_d[l_ac].nmbadocno_desc, 
       g_nmba_d[l_ac].nmbbseq,g_nmba_d[l_ac].nmba004,g_nmba_d[l_ac].nmba004_desc,g_nmba_d[l_ac].nmbb030, 
       g_nmba_d[l_ac].nmbb028,g_nmba_d[l_ac].nmbb028_desc,g_nmba_d[l_ac].nmbb043,g_nmba_d[l_ac].nmbb043_desc, 
       g_nmba_d[l_ac].nmbb065,g_nmba_d[l_ac].nmbb031,g_nmba_d[l_ac].l_nmck012,g_nmba_d[l_ac].nmbb004, 
       g_nmba_d[l_ac].nmbb006,g_nmba_d[l_ac].nmbb005,g_nmba_d[l_ac].nmbb007,g_nmba_d[l_ac].nmbb044,g_nmba_d[l_ac].nmbb045, 
       g_nmba_d[l_ac].nmbb042,g_nmba_d[l_ac].nmbacomp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #161125-00036#7-----s
      EXECUTE sel_nmbc005p USING g_nmba_d[l_ac].nmbb030,g_nmba_d[l_ac].nmbacomp,g_nmba_d[l_ac].nmba004
         INTO g_nmba_d[l_ac].l_nmck012
      #161125-00036#7-----e
      #end add-point
 
      CALL anmq520_detail_show("'1'")
 
      CALL anmq520_nmba_t_mask()
 
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
   CALL anmq520_b_fill3(ls_wc)
   #end add-point
 
   CALL g_nmba_d.deleteElement(g_nmba_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_nmba_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmq520_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq520_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq520_detail_action_trans()
 
   LET l_ac = 1
   IF g_nmba_d.getLength() > 0 THEN
      CALL anmq520_b_fill2()
   END IF
 
      CALL anmq520_filter_show('nmbadocno','b_nmbadocno')
   CALL anmq520_filter_show('nmbbseq','b_nmbbseq')
   CALL anmq520_filter_show('nmba004','b_nmba004')
   CALL anmq520_filter_show('nmbb030','b_nmbb030')
   CALL anmq520_filter_show('nmbb028','b_nmbb028')
   CALL anmq520_filter_show('nmbb043','b_nmbb043')
   CALL anmq520_filter_show('nmbb065','b_nmbb065')
   CALL anmq520_filter_show('nmbb031','b_nmbb031')
   CALL anmq520_filter_show('nmbb004','b_nmbb004')
   CALL anmq520_filter_show('nmbb006','b_nmbb006')
   CALL anmq520_filter_show('nmbb005','b_nmbb005')
   CALL anmq520_filter_show('nmbb007','b_nmbb007')
   CALL anmq520_filter_show('nmbb044','b_nmbb044')
   CALL anmq520_filter_show('nmbb045','b_nmbb045')
   CALL anmq520_filter_show('nmbb042','b_nmbb042')
   CALL anmq520_filter_show('nmbacomp','b_nmbacomp')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq520_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   CALL g_nmcq_d.clear()   
  
   LET g_cnt = l_ac2
   LET l_ac2 = 1
   #第一筆：開票單
   SELECT nmbadocdt,'1',nmbadocno,nmbastus
         ,nmbb006,nmbb007   #160526-00037#2 add
     INTO g_nmcq_d[l_ac2].nmcqdocdt,g_nmcq_d[l_ac2].nmcq001,g_nmcq_d[l_ac2].nmcqdocno,g_nmcq_d[l_ac2].nmcqstus
         ,g_nmcq_d[l_ac2].nmcr103,g_nmcq_d[l_ac2].nmcr113  #160526-00037#2 add
     FROM nmba_t,nmbb_t #160526-00037#2 add nmbb_t
    WHERE nmbaent = g_enterprise AND nmbadocno = g_nmba_d[g_detail_idx].nmbadocno
      AND nmbacomp = g_nmba_d[g_detail_idx].nmbacomp
      AND nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno #160526-00037#2 add
   LET l_ac2 = l_ac2 + 1 
   #票據異動歷程資料
   LET l_sql = " SELECT DISTINCT nmcqdocdt,nmcq001,nmcqdocno,nmcqstus,nmcr103,nmcr113 ", #160526-00037#2 add nmcr103,nmcr113
               "   FROM nmcq_t,nmcr_t ",
               "  WHERE nmcqent = nmcrent AND nmcqdocno = nmcrdocno AND nmcqcomp = nmcrcomp",
               "    AND nmcqent = ",g_enterprise," AND nmcr003 = '",g_nmba_d[g_detail_idx].nmbadocno,"' ",
               "    AND nmcqcomp = '",g_nmba_d[g_detail_idx].nmbacomp,"'",
               "    AND nmcr001 = '",g_nmba_d[g_detail_idx].nmbb030,"'", #160526-00037#2 add
               "  ORDER BY nmcqdocdt,nmcq001 "
   PREPARE anmq520_pb2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR anmq520_pb2   
   FOREACH b_fill_curs2 INTO g_nmcq_d[l_ac2].nmcqdocdt,g_nmcq_d[l_ac2].nmcq001,
                             g_nmcq_d[l_ac2].nmcqdocno,g_nmcq_d[l_ac2].nmcqstus
                            ,g_nmcq_d[l_ac2].nmcr103,g_nmcq_d[l_ac2].nmcr113 #160526-00037#2 add
                             
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
#   LET l_ac2 = l_ac2 - 1
#   IF l_ac2 > 1 THEN
      CALL g_nmcq_d.deleteElement(g_nmcq_d.getLength())
#   END IF
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   LET li_ac = g_nmcq_d.getLength()
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq520_detail_show(ps_page)
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
      LET g_ref_fields[1] = g_nmba_d[l_ac].nmbadocno
      LET ls_sql = "SELECT oobal004 FROM oobal_t WHERE oobalent='"||g_enterprise||"' AND oobal001='' AND oobal002=? AND oobal003='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_nmba_d[l_ac].nmbadocno_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmba_d[l_ac].nmbadocno_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmba_d[l_ac].nmba004
      LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_nmba_d[l_ac].nmba004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmba_d[l_ac].nmba004_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmba_d[l_ac].nmbb028
      LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_nmba_d[l_ac].nmbb028_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmba_d[l_ac].nmbb028_desc
 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmba_d[l_ac].nmbb043
      LET ls_sql = "SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_nmba_d[l_ac].nmbb043_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmba_d[l_ac].nmbb043_desc
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmq520_filter()
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
      CONSTRUCT g_wc_filter ON nmbadocno,nmbbseq,nmba004,nmbb030,nmbb028,nmbb043,nmbb065,nmbb031,nmbb004, 
          nmbb006,nmbb005,nmbb007,nmbb044,nmbb045,nmbb042,nmbacomp
                          FROM s_detail1[1].b_nmbadocno,s_detail1[1].b_nmbbseq,s_detail1[1].b_nmba004, 
                              s_detail1[1].b_nmbb030,s_detail1[1].b_nmbb028,s_detail1[1].b_nmbb043,s_detail1[1].b_nmbb065, 
                              s_detail1[1].b_nmbb031,s_detail1[1].b_nmbb004,s_detail1[1].b_nmbb006,s_detail1[1].b_nmbb005, 
                              s_detail1[1].b_nmbb007,s_detail1[1].b_nmbb044,s_detail1[1].b_nmbb045,s_detail1[1].b_nmbb042, 
                              s_detail1[1].b_nmbacomp
 
         BEFORE CONSTRUCT
                     DISPLAY anmq520_filter_parser('nmbadocno') TO s_detail1[1].b_nmbadocno
            DISPLAY anmq520_filter_parser('nmbbseq') TO s_detail1[1].b_nmbbseq
            DISPLAY anmq520_filter_parser('nmba004') TO s_detail1[1].b_nmba004
            DISPLAY anmq520_filter_parser('nmbb030') TO s_detail1[1].b_nmbb030
            DISPLAY anmq520_filter_parser('nmbb028') TO s_detail1[1].b_nmbb028
            DISPLAY anmq520_filter_parser('nmbb043') TO s_detail1[1].b_nmbb043
            DISPLAY anmq520_filter_parser('nmbb065') TO s_detail1[1].b_nmbb065
            DISPLAY anmq520_filter_parser('nmbb031') TO s_detail1[1].b_nmbb031
            DISPLAY anmq520_filter_parser('nmbb004') TO s_detail1[1].b_nmbb004
            DISPLAY anmq520_filter_parser('nmbb006') TO s_detail1[1].b_nmbb006
            DISPLAY anmq520_filter_parser('nmbb005') TO s_detail1[1].b_nmbb005
            DISPLAY anmq520_filter_parser('nmbb007') TO s_detail1[1].b_nmbb007
            DISPLAY anmq520_filter_parser('nmbb044') TO s_detail1[1].b_nmbb044
            DISPLAY anmq520_filter_parser('nmbb045') TO s_detail1[1].b_nmbb045
            DISPLAY anmq520_filter_parser('nmbb042') TO s_detail1[1].b_nmbb042
            DISPLAY anmq520_filter_parser('nmbacomp') TO s_detail1[1].b_nmbacomp
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmbadocno>>----
         #Ctrlp:construct.c.page1.b_nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbadocno
            #add-point:ON ACTION controlp INFIELD b_nmbadocno name="construct.c.filter.page1.b_nmbadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbadocno  #顯示到畫面上
            NEXT FIELD b_nmbadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbadocno_desc>>----
         #----<<b_nmbbseq>>----
         #Ctrlp:construct.c.filter.page1.b_nmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbbseq
            #add-point:ON ACTION controlp INFIELD b_nmbbseq name="construct.c.filter.page1.b_nmbbseq"
            
            #END add-point
 
 
         #----<<b_nmba004>>----
         #Ctrlp:construct.c.filter.page1.b_nmba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmba004
            #add-point:ON ACTION controlp INFIELD b_nmba004 name="construct.c.filter.page1.b_nmba004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()   #160913-00017#5  mark                  #呼叫開窗
            #160913-00017#5--ADD(S)--
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            #160913-00017#5--ADD(E)- 
            DISPLAY g_qryparam.return1 TO b_nmba004
            NEXT FIELD b_nmba004
            #END add-point
 
 
         #----<<b_nmba004_desc>>----
         #----<<b_nmbb030>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb030
            #add-point:ON ACTION controlp INFIELD b_nmbb030 name="construct.c.filter.page1.b_nmbb030"
            
            #END add-point
 
 
         #----<<b_nmbb028>>----
         #Ctrlp:construct.c.page1.b_nmbb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb028
            #add-point:ON ACTION controlp INFIELD b_nmbb028 name="construct.c.filter.page1.b_nmbb028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooie001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb028  #顯示到畫面上
            NEXT FIELD b_nmbb028                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb028_desc>>----
         #----<<b_nmbb043>>----
         #Ctrlp:construct.c.page1.b_nmbb043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb043
            #add-point:ON ACTION controlp INFIELD b_nmbb043 name="construct.c.filter.page1.b_nmbb043"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb043  #顯示到畫面上
            NEXT FIELD b_nmbb043                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb043_desc>>----
         #----<<b_nmbb065>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb065
            #add-point:ON ACTION controlp INFIELD b_nmbb065 name="construct.c.filter.page1.b_nmbb065"
            
            #END add-point
 
 
         #----<<b_nmbb031>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb031
            #add-point:ON ACTION controlp INFIELD b_nmbb031 name="construct.c.filter.page1.b_nmbb031"
            
            #END add-point
 
 
         #----<<l_nmck012>>----
         #----<<b_nmbb004>>----
         #Ctrlp:construct.c.page1.b_nmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb004
            #add-point:ON ACTION controlp INFIELD b_nmbb004 name="construct.c.filter.page1.b_nmbb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbb004  #顯示到畫面上
            NEXT FIELD b_nmbb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbb006>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb006
            #add-point:ON ACTION controlp INFIELD b_nmbb006 name="construct.c.filter.page1.b_nmbb006"
            
            #END add-point
 
 
         #----<<b_nmbb005>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb005
            #add-point:ON ACTION controlp INFIELD b_nmbb005 name="construct.c.filter.page1.b_nmbb005"
            
            #END add-point
 
 
         #----<<b_nmbb007>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb007
            #add-point:ON ACTION controlp INFIELD b_nmbb007 name="construct.c.filter.page1.b_nmbb007"
            
            #END add-point
 
 
         #----<<b_nmbb044>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb044
            #add-point:ON ACTION controlp INFIELD b_nmbb044 name="construct.c.filter.page1.b_nmbb044"
            
            #END add-point
 
 
         #----<<b_nmbb045>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb045
            #add-point:ON ACTION controlp INFIELD b_nmbb045 name="construct.c.filter.page1.b_nmbb045"
            
            #END add-point
 
 
         #----<<b_nmbb042>>----
         #Ctrlp:construct.c.filter.page1.b_nmbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbb042
            #add-point:ON ACTION controlp INFIELD b_nmbb042 name="construct.c.filter.page1.b_nmbb042"
            
            #END add-point
 
 
         #----<<b_nmbacomp>>----
         #Ctrlp:construct.c.page1.b_nmbacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbacomp
            #add-point:ON ACTION controlp INFIELD b_nmbacomp name="construct.c.filter.page1.b_nmbacomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbacomp  #顯示到畫面上
            NEXT FIELD b_nmbacomp                     #返回原欄位
    


            #END add-point
 
 
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         CALL gfrm_curr.setFieldHidden("formonly.sel",FALSE)
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
 
      CALL anmq520_filter_show('nmbadocno','b_nmbadocno')
   CALL anmq520_filter_show('nmbbseq','b_nmbbseq')
   CALL anmq520_filter_show('nmba004','b_nmba004')
   CALL anmq520_filter_show('nmbb030','b_nmbb030')
   CALL anmq520_filter_show('nmbb028','b_nmbb028')
   CALL anmq520_filter_show('nmbb043','b_nmbb043')
   CALL anmq520_filter_show('nmbb065','b_nmbb065')
   CALL anmq520_filter_show('nmbb031','b_nmbb031')
   CALL anmq520_filter_show('nmbb004','b_nmbb004')
   CALL anmq520_filter_show('nmbb006','b_nmbb006')
   CALL anmq520_filter_show('nmbb005','b_nmbb005')
   CALL anmq520_filter_show('nmbb007','b_nmbb007')
   CALL anmq520_filter_show('nmbb044','b_nmbb044')
   CALL anmq520_filter_show('nmbb045','b_nmbb045')
   CALL anmq520_filter_show('nmbb042','b_nmbb042')
   CALL anmq520_filter_show('nmbacomp','b_nmbacomp')
 
 
   CALL anmq520_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq520.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmq520_filter_parser(ps_field)
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
 
{<section id="anmq520.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq520_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmq520.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq520_detail_action_trans()
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
 
{<section id="anmq520.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq520_detail_index_setting()
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
            IF g_nmba_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmba_d.getLength() AND g_nmba_d.getLength() > 0
            LET g_detail_idx = g_nmba_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmba_d.getLength() THEN
               LET g_detail_idx = g_nmba_d.getLength()
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
 
{<section id="anmq520.mask_functions" >}
 &include "erp/anm/anmq520_mask.4gl"
 
{</section>}
 
{<section id="anmq520.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 填充第三單身
# Memo...........:
# Usage..........: CALL anmq520_b_fill3(ls_wc)
#                : ls_wc   QBE條件
# Date & Author..: 151021 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq520_b_fill3(ls_wc)
DEFINE ls_wc            STRING
DEFINE l_sql            STRING
   CALL g_nmbb_d.clear()   
  
   LET l_ac3 = 1
   
   LET l_sql = "SELECT nmbb004,SUM(nmbb006),SUM(nmbb007),COUNT(1) ",  #160526-00037#2 add sum(nmbb007)
               "  FROM nmba_t,nmbb_t ", 
               " WHERE nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno",
               "   AND nmbaent= ",g_enterprise," AND 1=1 AND nmbb029 = '30' AND ",ls_wc,
               "   AND nmbasite = '",g_master.nmbasite,"' AND nmbacomp = '",g_master.nmbacomp,"' ",
               " GROUP BY nmbb004 "
   
   PREPARE anmq520_pb3 FROM l_sql
   DECLARE b_fill_curs3 CURSOR FOR anmq520_pb3
   FOREACH b_fill_curs3 INTO g_nmbb_d[l_ac3].nmbb004,g_nmbb_d[l_ac3].l_total,g_nmbb_d[l_ac3].nmbb007_s,#160526-00037#2 add nmbb007_s
                             g_nmbb_d[l_ac3].l_numdocno 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH

   
   LET l_ac3 = l_ac3 - 1
END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: 
#
# Date & Author..: 15/10/21 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq520_x01_tmp()
DROP TABLE anmq520_x01_tmp;
CREATE TEMP TABLE anmq520_x01_tmp(
#   seq          LIKE type_t.num10,    #160526-00037#2 mark
   nmbadocno    LIKE nmba_t.nmbadocno, #160526-00037#2 add
   nmbbseq      LIKE nmbb_t.nmbbseq,   #160526-00037#2 add
   nmba004      LIKE nmba_t.nmba004, 
   nmba004_desc LIKE type_t.chr500,
   nmbb030      LIKE nmbb_t.nmbb030,
   nmbb028      LIKE nmbb_t.nmbb028, 
   nmbb028_desc LIKE type_t.chr500,
   nmbb043      LIKE nmbb_t.nmbb043, 
   nmbb043_desc LIKE type_t.chr500,
   nmbb065      LIKE nmbb_t.nmbb065,  #160526-00037#2 add
   nmbb031      LIKE nmbb_t.nmbb031,  #160526-00037#2 add
   l_nmck012    LIKE nmck_t.nmck012,  #161125-00036#7
   nmbb004      LIKE type_t.chr500,
   nmbb006      LIKE nmbb_t.nmbb006,
   nmbb005      LIKE nmbb_t.nmbb005,  #160526-00037#2 add
   nmbb007      LIKE nmbb_t.nmbb007, 
   nmbb044_desc LIKE type_t.chr500,
   nmbb045      LIKE nmbb_t.nmbb045, 
   nmbb042      LIKE type_t.chr500,   #160526-00037#2 add
   nmbacomp     LIKE nmba_t.nmbacomp, #160526-00037#2 add
   l_keys       LIKE type_t.chr1000   #160526-00037#2 add
#   nmcqdocdt    LIKE nmcq_t.nmcqdocdt, #160526-00037#2 mark
#   nmcq001_desc LIKE type_t.chr500     #160526-00037#2 mark
   )
END FUNCTION
################################################################################
# Descriptions...: ins TEMP TABLE
# Memo...........: 
#
# Date & Author..: 15/10/21 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq520_ins_tmp()
DEFINE l_nmcq001_desc  LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_nmbb044_desc  LIKE type_t.chr500
DEFINE l_sum_nmbb006   LIKE type_t.num20_6
DEFINE l_sum_nmbb007   LIKE type_t.num20_6
DEFINE l_i             LIKE type_t.num10
DEFINE l_j             LIKE type_t.num10
DEFINE l_n             LIKE type_t.num10   
DEFINE l_x01_tmp   RECORD
   seq             LIKE type_t.num10,
   nmba004         LIKE nmba_t.nmba004, 
   nmba004_desc    LIKE type_t.chr500,
   nmbb030         LIKE nmbb_t.nmbb030,
   nmbb028         LIKE nmbb_t.nmbb028, 
   nmbb028_desc    LIKE type_t.chr500,
   nmbb043         LIKE nmbb_t.nmbb043,
   nmbb043_desc    LIKE type_t.chr500,
   nmbb004         LIKE type_t.chr500,
   nmbb006         LIKE nmbb_t.nmbb006,
   nmbb007         LIKE nmbb_t.nmbb007, 
   nmbb044         LIKE type_t.chr500, 
   nmbb045         LIKE nmbb_t.nmbb045, 
   nmcqdocdt       LIKE nmcq_t.nmcqdocdt,
   nmcq001_desc    LIKE type_t.chr500 
                   END RECORD
   DEFINE l_nmbb042_desc LIKE type_t.chr500  #160526-00037#2 add
   DEFINE l_keys         LIKE type_t.chr1000 #160526-00037#2 add
   
   DELETE FROM anmq520_x01_tmp
   #160526-00037#2--add--str--
   #XG報表採用明細+子報表模式
   LET l_n = g_nmba_d.getLength()
   FOR l_i = 1 TO l_n
      #利率方式
      CALL s_desc_gzcbl004_desc('8715',g_nmba_d[l_i].nmbb044)  RETURNING l_nmbb044_desc
      IF NOT cl_null(l_nmbb044_desc) THEN
         LET l_nmbb044_desc = g_nmba_d[l_i].nmbb044,":",l_nmbb044_desc
      ELSE
         LET l_nmbb044_desc = g_nmba_d[l_i].nmbb044
      END IF
      #票況
      CALL s_desc_gzcbl004_desc('8714',g_nmba_d[l_i].nmbb042)  RETURNING l_nmbb042_desc
      IF NOT cl_null(l_nmbb042_desc) THEN
         LET l_nmbb042_desc = g_nmba_d[l_i].nmbb042,":",l_nmbb042_desc
      ELSE
         LET l_nmbb042_desc = g_nmba_d[l_i].nmbb042
      END IF
      #與子報表關聯主鍵組合
      LET l_keys=g_nmba_d[l_i].nmbadocno||'-'||g_nmba_d[l_i].nmbacomp||'-'||g_nmba_d[l_i].nmbb030
      INSERT INTO anmq520_x01_tmp (nmbadocno,nmbbseq,nmba004,nmba004_desc,nmbb030,
                                   nmbb028,nmbb028_desc,nmbb043,nmbb043_desc,nmbb065,
                                   nmbb031,nmbb004,nmbb006,nmbb005,nmbb007,
                                   l_nmck012,    #161125-00036#7
                                   nmbb044_desc,nmbb045,nmbb042,nmbacomp,l_keys) 
      VALUES(g_nmba_d[l_i].nmbadocno,g_nmba_d[l_i].nmbbseq,g_nmba_d[l_i].nmba004,g_nmba_d[l_i].nmba004_desc,g_nmba_d[l_i].nmbb030,
             g_nmba_d[l_i].nmbb028,g_nmba_d[l_i].nmbb028_desc,g_nmba_d[l_i].nmbb043,g_nmba_d[l_i].nmbb043_desc,g_nmba_d[l_i].nmbb065,
             g_nmba_d[l_i].nmbb031,g_nmba_d[l_i].nmbb004,g_nmba_d[l_i].nmbb006,g_nmba_d[l_i].nmbb005,g_nmba_d[l_i].nmbb007,
             g_nmba_d[l_i].l_nmck012,   #161125-00036#7
             l_nmbb044_desc,g_nmba_d[l_i].nmbb045,l_nmbb042_desc,g_nmba_d[l_i].nmbacomp,l_keys)
   END FOR
   #160526-00037#2--add--end

#160526-00037#2--mark--str--
#   LET l_n = 0
#   LET l_sum_nmbb006 = 0
#   LET l_sum_nmbb007 = 0
#   FOR l_i = 1 TO g_nmba_d.getLength()
#      LET g_detail_idx = l_i
#      CALL anmq520_b_fill2()
#      IF l_i > 1 THEN
#         IF g_nmba_d[l_i].nmbb004 <> g_nmba_d[l_i - 1].nmbb004 THEN
#            LET l_n = l_n + 1
#            INITIALIZE l_x01_tmp.* TO NULL
#            LET l_x01_tmp.seq          = l_n
#            LET l_x01_tmp.nmba004      = ''
#            LET l_x01_tmp.nmba004_desc = ''
#            LET l_x01_tmp.nmbb030      = ''
#            LET l_x01_tmp.nmbb028      = ''
#            LET l_x01_tmp.nmbb028_desc = ''
#            LET l_x01_tmp.nmbb043      = ''
#            LET l_x01_tmp.nmbb043_desc = ''
#            LET l_x01_tmp.nmbb004      = g_nmba_d[l_i - 1 ].nmbb004,cl_getmsg("aap-00287",g_lang)
#            LET l_x01_tmp.nmbb006      = l_sum_nmbb006
#            LET l_x01_tmp.nmbb007      = l_sum_nmbb007
#            LET l_x01_tmp.nmbb044      = ''
#            LET l_x01_tmp.nmbb045      = '' 
#            LET l_x01_tmp.nmcqdocdt    = ''
#            LET l_x01_tmp.nmcq001_desc = ''
#            INSERT INTO anmq520_x01_tmp VALUES(l_x01_tmp.*)
#            LET l_sum_nmbb006 = 0
#            LET l_sum_nmbb007 = 0
#         END IF
#      END IF
#      FOR l_j = 1 TO g_nmcq_d.getLength()
#         LET l_n = l_n + 1
#         LET l_nmcq001_desc  = '' 
#         LET l_nmbb044_desc  = ''   
#         CALL s_desc_gzcbl004_desc('8715',g_nmba_d[l_i].nmbb044)  RETURNING l_nmbb044_desc
#         CALL s_desc_gzcbl004_desc('8714',g_nmcq_d[l_j].nmcq001)  RETURNING l_nmcq001_desc
#         INITIALIZE l_x01_tmp.* TO NULL
#         IF l_j = 1 THEN
#            LET l_x01_tmp.seq          = l_n
#            LET l_x01_tmp.nmba004      = g_nmba_d[l_i].nmba004
#            LET l_x01_tmp.nmba004_desc = g_nmba_d[l_i].nmba004_desc
#            LET l_x01_tmp.nmbb030      = g_nmba_d[l_i].nmbb030
#            LET l_x01_tmp.nmbb028      = g_nmba_d[l_i].nmbb028
#            LET l_x01_tmp.nmbb028_desc = g_nmba_d[l_i].nmbb028_desc 
#            LET l_x01_tmp.nmbb043      = g_nmba_d[l_i].nmbb043
#            LET l_x01_tmp.nmbb043_desc = g_nmba_d[l_i].nmbb043_desc 
#            LET l_x01_tmp.nmbb004      = g_nmba_d[l_i].nmbb004 
#            LET l_x01_tmp.nmbb006      = g_nmba_d[l_i].nmbb006 
#            LET l_x01_tmp.nmbb007      = g_nmba_d[l_i].nmbb007 
#            IF NOT cl_null(g_nmba_d[l_i].nmbb044) THEN
#               LET l_x01_tmp.nmbb044   = g_nmba_d[l_i].nmbb044,":",l_nmbb044_desc
#            ELSE
#               LET l_x01_tmp.nmbb044   = g_nmba_d[l_i].nmbb044
#            END IF
#            LET l_x01_tmp.nmbb045      = g_nmba_d[l_i].nmbb045 / 100 
#            LET l_x01_tmp.nmcqdocdt    = g_nmcq_d[l_j].nmcqdocdt
#            LET l_x01_tmp.nmcq001_desc = g_nmcq_d[l_j].nmcq001,":",l_nmcq001_desc
#            LET l_sum_nmbb006 = l_sum_nmbb006 + g_nmba_d[l_i].nmbb006
#            LET l_sum_nmbb007 = l_sum_nmbb007 + g_nmba_d[l_i].nmbb007
#         ELSE
#            LET l_x01_tmp.seq          = l_n
#            LET l_x01_tmp.nmba004      = ''
#            LET l_x01_tmp.nmba004_desc = ''
#            LET l_x01_tmp.nmbb030      = ''
#            LET l_x01_tmp.nmbb028      = ''
#            LET l_x01_tmp.nmbb028_desc = ''
#            LET l_x01_tmp.nmbb043      = ''
#            LET l_x01_tmp.nmbb043_desc = ''
#            LET l_x01_tmp.nmbb004      = '' 
#            LET l_x01_tmp.nmbb006      = '' 
#            LET l_x01_tmp.nmbb007      = '' 
#            LET l_x01_tmp.nmbb044      = ''
#            LET l_x01_tmp.nmbb045      = '' 
#            LET l_x01_tmp.nmcqdocdt    = g_nmcq_d[l_j].nmcqdocdt
#            LET l_x01_tmp.nmcq001_desc = g_nmcq_d[l_j].nmcq001,":",l_nmcq001_desc
#         END IF
#         INSERT INTO anmq520_x01_tmp VALUES(l_x01_tmp.*)
#      END FOR
#      IF l_i = g_nmba_d.getLength() THEN
#         LET l_n = l_n + 1
#         INITIALIZE l_x01_tmp.* TO NULL
#         LET l_x01_tmp.seq          = l_n
#         LET l_x01_tmp.nmba004      = ''
#         LET l_x01_tmp.nmba004_desc = ''
#         LET l_x01_tmp.nmbb030      = ''
#         LET l_x01_tmp.nmbb028      = ''
#         LET l_x01_tmp.nmbb028_desc = ''
#         LET l_x01_tmp.nmbb043      = ''
#         LET l_x01_tmp.nmbb043_desc = ''
#         LET l_x01_tmp.nmbb004      = g_nmba_d[l_i].nmbb004,cl_getmsg("aap-00287",g_lang)
#         LET l_x01_tmp.nmbb006      = l_sum_nmbb006
#         LET l_x01_tmp.nmbb007      = l_sum_nmbb007
#         LET l_x01_tmp.nmbb044      = ''
#         LET l_x01_tmp.nmbb045      = '' 
#         LET l_x01_tmp.nmcqdocdt    = ''
#         LET l_x01_tmp.nmcq001_desc = ''
#         INSERT INTO anmq520_x01_tmp VALUES(l_x01_tmp.*)
#      END IF   
#   END FOR
#160526-00037#2--mark--end    
END FUNCTION
################################################################################
# Descriptions...: 資金中心檢查
# Memo...........:
# Usage..........: CALL anmq520_nmbasite_chk(p_nmbasite)
# Date & Author..: 2015/10/28 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq520_nmbasite_chk(p_nmbasite)
   DEFINE l_ooef206  LIKE ooef_t.ooef206
   DEFINE l_ooefstus LIKE ooef_t.ooefstus
   DEFINE p_nmbasite LIKE nmba_t.nmbasite

   LET g_errno = ''
   SELECT ooef206,ooefstus INTO l_ooef206,l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_nmbasite  
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aoo-00094'
      WHEN l_ooefstus = 'N'    LET g_errno = 'sub-01302' #aoo-00095 #160318-00005#27  By 07900 --mod
      WHEN l_ooef206 <> 'Y'    LET g_errno = 'anm-00272'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL anmq520_qbe_clear()
# Date & Author..: 2015/10/29 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq520_qbe_clear()
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5  #160816-00012#4 Add
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_nmba_d.clear()
   CALL g_nmcq_d.clear()
   CALL g_nmbb_d.clear()
   
   CALL s_fin_account_center_sons_query('6',g_site,g_today,'')
   CALL s_fin_account_center_comp_str()  RETURNING g_nmbacomp_str
   CALL s_fin_get_wc_str(g_nmbacomp_str) RETURNING g_nmbacomp_str
   CALL s_fin_account_center_with_ld_chk(g_site,'',g_user,'6','N','',g_today) RETURNING g_sub_success,g_errno
   IF g_sub_success THEN
      CALL anmq520_nmbasite_chk(g_site)
      IF NOT cl_null(g_errno) THEN
         # g_site <> 資金中心,則空白
         LET g_master.nmbasite = ''
         LET g_master.nmbacomp = ''
      ELSE
         LET g_master.nmbasite = g_site
         CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master.nmbacomp,g_glaald   
         #160816-00012#4 Add  ---(S)---
         #检查用户是否有资金中心对应法人的权限
         CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
         LET l_count = 0
         LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                     "   AND ooef001 = '",g_master.nmbacomp,"'",
                     "   AND ooef003 = 'Y'",
                     "   AND ",l_wc CLIPPED
         PREPARE anmp410_count_prep FROM l_sql
         EXECUTE anmp410_count_prep INTO l_count
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         IF l_count = 0 THEN
            LET g_master.nmbacomp = ''           
            DISPLAY BY NAME g_master.nmbacomp
         END IF
         #160816-00012#4 Add  ---(E)---
      END IF
   ELSE
      LET g_master.nmbasite = ''
      LET g_master.nmbacomp = ''
   END IF
   
   LET g_master.nmbacomp_desc = s_desc_get_department_desc(g_master.nmbacomp)
   LET g_master.nmbasite_desc = s_desc_get_department_desc(g_master.nmbasite)
   DISPLAY BY NAME g_master.nmbasite,g_master.nmbasite_desc,g_master.nmbacomp,g_master.nmbacomp_desc
END FUNCTION

 
{</section>}
 
