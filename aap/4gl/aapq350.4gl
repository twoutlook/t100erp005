#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-08-05 09:20:15), PR版次:0008(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000111
#+ Filename...: aapq350
#+ Description: 零用金費用報支查詢作業
#+ Creator....: 05016(2014-09-23 11:06:24)
#+ Modifier...: 05016 -SD/PR- 00000
 
{</section>}
 
{<section id="aapq350.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1             By Reanna    掃把清空&給預設值
#150518-00053#1             By albireo   串接零用金帳戶的SQL改先串apde
#150319-00004#4             By RayHuang  新增Q轉XG功能
#160122-00001#5  2015/02/23 By 07673     添加交易账户编号用户权限控管
#160414-00018#7  2016/04/28 By Hans      效能調整
#160518-00075#25 2016/08/03 By Hans      使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#160812-00027#2  2016/08/16 By 06821     全面盤點應付程式帳套權限控管
#161108-00017#2  2016/11/09 By Reanna    程式中INSERT INTO 有星號作整批調整
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
PRIVATE TYPE type_g_apcb_d RECORD
       
       sel LIKE type_t.chr1, 
   apcbseq LIKE apcb_t.apcbseq, 
   apcbld LIKE apcb_t.apcbld, 
   apcbdocno LIKE apcb_t.apcbdocno, 
   apcb022 LIKE apcb_t.apcb022, 
   apcb014 LIKE apcb_t.apcb014, 
   apcb005 LIKE apcb_t.apcb005, 
   apcb105 LIKE apcb_t.apcb105, 
   apcb007 LIKE apcb_t.apcb007, 
   apcb102 LIKE apcb_t.apcb102, 
   apcb115 LIKE apcb_t.apcb115, 
   apcb027 LIKE apcb_t.apcb027, 
   apcb028 LIKE apcb_t.apcb028, 
   apca014 LIKE type_t.chr500, 
   apca014_desc LIKE type_t.chr500, 
   apcb030 LIKE apcb_t.apcb030, 
   apcb030_desc LIKE type_t.chr500, 
   apcb010 LIKE apcb_t.apcb010, 
   apcb010_desc LIKE type_t.chr500, 
   apcb015 LIKE apcb_t.apcb015, 
   apcb015_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
   apcald          LIKE apca_t.apcald,
   apcald_desc     LIKE type_t.chr500,
   apcacomp        LIKE apca_t.apcacomp,
   apcacomp_desc   LIKE type_t.chr500,
   apca057         LIKE apca_t.apca057, #零用金交易帳號
   apca057_desc    LIKE type_t.chr500,
   apacsite        LIKE apad_t.apadsite,
   apacsite_desc   LIKE type_t.chr500,  #交易帳號的零用金歸屬營運據點
   nmas003         LIKE nmas_t.nmas003,
   year            LIKE type_t.num5,
   month           LIKE type_t.num5
   END RECORD

DEFINE g_strdt     LIKE apca_t.apcadocdt
DEFINE g_enddt     LIKE apca_t.apcadocdt
DEFINE g_comp_str  STRING

DEFINE g_sql_bank       STRING #160122-00001#5 add by 07675
DEFINE g_user_dept_wc      STRING      #160518-00075#25
DEFINE g_user_dept_wc_q    STRING      #160518-00075#25
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apcb_d            DYNAMIC ARRAY OF type_g_apcb_d
DEFINE g_apcb_d_t          type_g_apcb_d
 
 
 
 
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
 
{<section id="aapq350.main" >}
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
   CALL aapq350_x01_tmp()               #150319-00004#4 
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
   DECLARE aapq350_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq350_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq350_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq350 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq350_init()   
 
      #進入選單 Menu (="N")
      CALL aapq350_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq350
      
   END IF 
   
   CLOSE aapq350_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq350.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapq350_init()
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
   CALL s_fin_create_account_center_tmp()
   
   CALL s_fin_set_comp_scc('year','43')   #年度
   CALL s_fin_set_comp_scc('month','111')  #期別 
   CALL cl_set_combo_scc('b_apcb022','8708') #帳款單性質
   
   #160122-00001#5  --add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#5  --add--end
   #end add-point
 
   CALL aapq350_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aapq350.default_search" >}
PRIVATE FUNCTION aapq350_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apcbld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apcbdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " apcbseq = '", g_argv[03], "' AND "
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
 
{<section id="aapq350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq350_ui_dialog() 
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
   DEFINE l_origin_str STRING
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
   #150127-00007#1 mark
   #CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_input.apcald,g_input.apcacomp,g_errno  #回傳帳套和歸屬法人
   #LET g_input.apcald_desc = s_desc_get_ld_desc(g_input.apcald)
   #LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
   #LET g_input.year = YEAR(g_today)
   #LET g_input.month = MONTH(g_today)    
   ##取得帳務組織下所屬成員
   #CALL s_fin_account_center_sons_query('3',g_input.apcacomp,g_today,'1')
   ##帳務組織底下所屬成員
   #CALL s_fin_account_center_sons_str() RETURNING g_comp_str 
   ##取得所屬成員字串
   #CALL aapq350_change_to_sql(g_comp_str)RETURNING g_comp_str
   ##法人/帳套說明
   #CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
   #CALL s_desc_get_department_desc(g_input.apcacomp) RETURNING g_input.apcacomp_desc   
   #DISPLAY BY NAME g_input.apcald_desc,g_input.apcacomp_desc,g_input.apcacomp
   #150127-00007#1 add
   CALL aapq350_qbe_clear()
   #end add-point
 
   
   CALL aapq350_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apcb_d.clear()
 
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
 
         CALL aapq350_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_input.apcald,g_input.apca057,g_input.year,g_input.month,
                       g_input.apcacomp,g_input.apcacomp_desc,g_input.apacsite_desc,g_input.apcald_desc
               ATTRIBUTE(WITHOUT DEFAULTS)
         
            AFTER FIELD apcald
               LET g_input.apcald_desc = ''
               IF NOT cl_null(g_input.apcald) THEN
                  #CALL s_fin_account_center_with_ld_chk('',g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno     #160812-00027#2 mark
                  CALL s_fin_account_center_with_ld_chk(g_site,g_input.apcald,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno  #160812-00027#2 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                    
                     CALL s_fin_ld_carry('',g_user)RETURNING g_sub_success,g_input.apcald,g_input.apcacomp,g_errno #取回預設值
                     CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
                     CALL s_desc_get_department_desc(g_input.apcacomp) RETURNING g_input.apcacomp_desc
                     DISPLAY BY NAME g_input.apcald_desc,g_input.apcacomp_desc,g_input.apcacomp
                     NEXT FIELD apcald                                         
                  END IF
               END IF
               #取得帳套所屬法人
               CALL s_fin_ld_carry(g_input.apcald,g_user)RETURNING g_sub_success,g_input.apcald,g_input.apcacomp,g_errno
               CALL s_desc_get_department_desc(g_input.apcacomp)RETURNING g_input.apcacomp_desc
               CALL s_desc_get_ld_desc(g_input.apcald)RETURNING g_input.apcald_desc 
               CALL s_fin_account_center_sons_query('3',g_input.apcacomp,g_today,'1')
               CALL s_fin_account_center_sons_str() RETURNING g_comp_str 
               CALL aapq350_change_to_sql(g_comp_str)RETURNING g_comp_str 
               DISPLAY BY NAME g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc
            
            AFTER FIELD apca057
               LET g_input.apca057_desc = ''
               LET g_input.apacsite_desc = ''
               IF NOT cl_null(g_input.apca057) THEN            
                  CALL aapq350_apca057_chk()RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_input.apca057 = ''
                     LET g_input.apca057_desc = ''
                     LET g_input.apacsite_desc = ''
                     DISPLAY BY NAME  g_input.apca057_desc,g_input.apacsite_desc
                     CALL cl_err()                     
                     NEXT FIELD apca057               
                  END IF
                  CALL aapq350_apca057_ref()
                  #160122-00001#5--add---str
                  IF NOT s_anmi120_nmll002_chk(g_input.apca057,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_input.apca057
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE                     
                     CALL cl_err()
                     LET g_input.apca057 = ''
                     LET g_input.apca057_desc = ''
                     LET g_input.apacsite_desc = ''
                     DISPLAY BY NAME  g_input.apca057_desc,g_input.apacsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#5--add---end
               END IF            
               
            ON ACTION controlp  INFIELD apcald 
               CALL s_fin_account_center_sons_query('3',g_site,g_today,'')
               CALL s_fin_account_center_ld_str()RETURNING l_origin_str
               CALL aapq350_change_to_sql(l_origin_str)RETURNING l_origin_str
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               #160812-00027#2 --s mark
               #LET g_qryparam.arg2 = g_grup
               #LET g_qryparam.where = " glaald IN(",l_origin_str CLIPPED,") "
               #160812-00027#2 --e mark
               #160812-00027#2 --s add
               LET g_qryparam.arg2 = g_dept
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN(",l_origin_str CLIPPED,") "
               #160812-00027#2 --e add
               CALL q_authorised_ld()
               LET g_input.apcald = g_qryparam.return1
               #抓取法人
               CALL s_fin_ld_carry(g_input.apcald,g_user)RETURNING g_sub_success,g_input.apcald,g_input.apcacomp,g_errno           
               #抓取帳套/法人名稱
               CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
               CALL s_desc_get_department_desc(g_input.apcacomp) RETURNING g_input.apcacomp_desc
               DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp_desc
               NEXT FIELD apcald
               
            ON ACTION controlp INFIELD apca057
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.where    = "apadsite IN(",g_comp_str CLIPPED,") "  #160122-00001#5 -mrak
               #160122-00001#5 --add --str 
               LET g_qryparam.where =  " apadsite IN(",g_comp_str CLIPPED,") ",
#                                       " AND apad002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise,
#                                       " AND nmll002 = '",g_user,"')"
                                       " AND apad002 IN (",g_sql_bank,")"# mod by 07675
               #160122-00001#5 --add --end               
               CALL q_apad001()
               LET g_input.apca057 = g_qryparam.return1
               CALL aapq350_apca057_ref()
               DISPLAY BY NAME g_input.apca057
               NEXT FIELD apca057                                          
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_apcb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aapq350_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq350_b_fill2()
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
            CALL aapq350_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #150127-00007#1
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            NEXT FIELD apcald
            #end add-point
            NEXT FIELD apcbdocno
 
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
            CALL aapq350_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_apcb_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aapq350_b_fill()
 
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
            CALL aapq350_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq350_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq350_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq350_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apcb_d.getLength()
               LET g_apcb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_apcb_d.getLength()
               LET g_apcb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_apcb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apcb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_apcb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apcb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapq350_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #150319-00004#4-----s
               #CALL aapq350_insert_tmp()                     #160414-00018#7
               #CALL aapq350_x01(" 1 = 1","aapq350_x01_tmp")  #160414-00018#7
               #150319-00004#4-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150319-00004#4-----s
               #CALL aapq350_insert_tmp()                     #160414-00018#7
               #CALL aapq350_x01(" 1 = 1","aapq350_x01_tmp")  #160414-00018#7
               #150319-00004#4-----e
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
            #150127-00007#1 add
            CALL aapq350_qbe_clear()
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aapq350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq350_b_fill()
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
 
   CALL g_apcb_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',apcbseq,apcbld,apcbdocno,apcb022,apcb014,apcb005,apcb105,apcb007, 
       apcb102,apcb115,apcb027,apcb028,'','',apcb030,'',apcb010,'',apcb015,''  ,DENSE_RANK() OVER( ORDER BY apcb_t.apcbld, 
       apcb_t.apcbdocno,apcb_t.apcbseq) AS RANK FROM apcb_t",
 
 
                     "",
                     " WHERE apcbent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apcb_t"),
                     " ORDER BY apcb_t.apcbld,apcb_t.apcbdocno,apcb_t.apcbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
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
 
   LET g_sql = "SELECT '',apcbseq,apcbld,apcbdocno,apcb022,apcb014,apcb005,apcb105,apcb007,apcb102,apcb115, 
       apcb027,apcb028,'','',apcb030,'',apcb010,'',apcb015,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CALL s_date_get_ymtodate(g_input.year,g_input.month,g_input.year,g_input.month)RETURNING g_strdt,g_enddt 
   
   #150518-00053#1-----s
   #LET g_sql = " SELECT '',apcbseq,apcbld,apcbdocno,apcb022,apcb014,apcb005,apcb105,      ", 
   #            "           apcb007,apcb102,apcb115,apcb027,apcb028,apca014,'',apcb030,'', ",  
   #            "           apcb010,'',apcb015,''                                          ",
   #            "   FROM apca_t,apcb_t                                                     ",
   #            "  WHERE apcaent = apcbent AND apcbent= ?                      ",
   #            "    AND apcald = apcbld AND apcald = '",g_input.apcald,"'     ",
   #            "    AND apcadocno = apcbdocno                                 ",
   #            "    AND apca057 = '",g_input.apca057,"'                       ",
   #            "    AND apcadocdt  BETWEEN  '",g_strdt,"' AND '",g_enddt,"'   ",
   #            " ORDER BY apcbdocno,apcbseq   " 
   #160414-00018#7---s---
   #LET g_sql = " SELECT '',apcbseq,apcbld,apcbdocno,apcb022,apcb014,apcb005,apcb105,      ", 
   #            "           apcb007,apcb102,apcb115,apcb027,apcb028,apca014,'',apcb030,'', ",  
   #            "           apcb010,'',apcb015,''                                          ",
   #            "   FROM apca_t,apcb_t                                                     ",
   #            "  WHERE apcaent = apcbent AND apcbent= ?                      ",
   #            "    AND apcald = apcbld AND apcald = '",g_input.apcald,"'     ",
   #            "    AND apcadocno = apcbdocno                                 ",
   #            "    AND (apcald,apcadocno) IN (",
   #            "                   SELECT apdeld,apdedocno FROM apde_t  ",
   #            "                    WHERE apdeent = ",g_enterprise,"        ",
   #            "                      AND apde008 = '",g_input.apca057,"'     ",
   #            "                               )",
   #            "    AND apcadocdt  BETWEEN  '",g_strdt,"' AND '",g_enddt,"'   ",
   #            " ORDER BY apcbdocno,apcbseq      "
   #DISPLAY g_sql
   LET g_sql = " SELECT '',apcbseq,apcbld,apcbdocno,apcb022,apcb014,apcb005,apcb105,             ", 
               "           apcb007,apcb102,apcb115,apcb027,apcb028,                              ",
               "           apca014,(CASE WHEN (SELECT ooag011 FROM ooag_t WHERE ooag001 = apca014 AND ooagent = apcaent) IS NULL THEN apca014    ",
               "               ELSE (SELECT ooag011||' '||'('||apca014||')' FROM ooag_t WHERE ooag001 = apca014 AND ooagent = apcaent) END ),    ",
               "           apcb030,'',                                                              ",  
               "           apcb010,(CASE WHEN(SELECT ooefl003 FROM ooefl_t WHERE ooefl001 = apcb010 AND ooeflent = apcbent AND ooefl002 =  '",g_dlang,"') IS NULL THEN apcb010   ",
               "              ELSE (SELECT ooefl003||' '||'('||apcb010||')' FROM ooefl_t WHERE ooefl001 = apcb010 AND ooeflent = apcbent AND ooefl002 = '",g_dlang,"') END ),   ",
               "           apcb015, ",
               "          (CASE WHEN(CASE WHEN (SELECT pjabl003 FROM pjabl_t WHERE pjablent = apcbent AND pjabl001 = apcb015 AND pjabl002 = '",g_dlang,"') IS NULL THEN ",
               "                               (SELECT pjbal003 FROM pjbal_t WHERE pjbalent = apcbent AND pjbal001 = apcb015 AND pjbal002 = '",g_dlang,"') END)         ",
               "           IS NULL THEN apcb015 ELSE ",
               "                               (CASE WHEN (SELECT apcb015||' '||'('||pjabl003||')' FROM pjabl_t WHERE pjablent = apcbent AND pjabl001 = apcb015 AND pjabl002 = '",g_dlang,"') IS NULL THEN ",
               "                                          (SELECT apcb015||' '||'('||pjbal003||')' FROM pjbal_t WHERE pjbalent = apcbent AND pjbal001 = apcb015 AND pjbal002 = '",g_dlang,"') END)         ",
               "            END)        ",
               "   FROM apca_t,apcb_t   ",
               "  WHERE apcaent = apcbent AND apcbent= ?                      ",
               "    AND apcald = apcbld AND apcald = '",g_input.apcald,"'     ",
               "    AND apcadocno = apcbdocno                                 ",
               "    AND (apcald,apcadocno) IN (                               ",
               "                   SELECT apdeld,apdedocno FROM apde_t        ",
               "                    WHERE apdeent = ",g_enterprise,"          ",
               "                      AND apde008 = '",g_input.apca057,"'     ",
               "                               )",
               "    AND apcadocdt  BETWEEN  '",g_strdt,"' AND '",g_enddt,"' AND ",g_user_dept_wc, #160518-00075#25  
               " ORDER BY apcbdocno,apcbseq      "
   #160414-00018#7 ---e---
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq350_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq350_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_apcb_d[l_ac].sel,g_apcb_d[l_ac].apcbseq,g_apcb_d[l_ac].apcbld,g_apcb_d[l_ac].apcbdocno, 
       g_apcb_d[l_ac].apcb022,g_apcb_d[l_ac].apcb014,g_apcb_d[l_ac].apcb005,g_apcb_d[l_ac].apcb105,g_apcb_d[l_ac].apcb007, 
       g_apcb_d[l_ac].apcb102,g_apcb_d[l_ac].apcb115,g_apcb_d[l_ac].apcb027,g_apcb_d[l_ac].apcb028,g_apcb_d[l_ac].apca014, 
       g_apcb_d[l_ac].apca014_desc,g_apcb_d[l_ac].apcb030,g_apcb_d[l_ac].apcb030_desc,g_apcb_d[l_ac].apcb010, 
       g_apcb_d[l_ac].apcb010_desc,g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].apcb015_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_apcb_d[l_ac].apcb022 = '1' THEN
         LET g_apcb_d[l_ac].apcb022 = 1
      ELSE
         LET g_apcb_d[l_ac].apcb022 = 2
      END IF
#      #付款條件
#      CALL s_desc_get_ooib002_desc(g_apcb_d[l_ac].apcb030) RETURNING g_apcb_d[l_ac].apcb030_desc    
#      CALL s_desc_show1(g_apcb_d[l_ac].apcb030,g_apcb_d[l_ac].apcb030_desc)RETURNING g_apcb_d[l_ac].apcb030_desc
      #160414-00018#7 ---s---
      #費用部門
      #CALL s_desc_get_department_desc(g_apcb_d[l_ac].apcb010) RETURNING g_apcb_d[l_ac].apcb010_desc
      #CALL s_desc_show1(g_apcb_d[l_ac].apcb010,g_apcb_d[l_ac].apcb010_desc)RETURNING g_apcb_d[l_ac].apcb010_desc
      #人員
      #CALL s_desc_get_person_desc(g_apcb_d[l_ac].apca014) RETURNING g_apcb_d[l_ac].apca014_desc
      #CALL s_desc_show1(g_apcb_d[l_ac].apca014,g_apcb_d[l_ac].apca014_desc)RETURNING g_apcb_d[l_ac].apca014_desc
      #專案編號      
      #CALL s_desc_get_project_desc(g_apcb_d[l_ac].apcb015)RETURNING g_apcb_d[l_ac].apcb015_desc
      #CALL s_desc_show1(g_apcb_d[l_ac].apcb015,g_apcb_d[l_ac].apcb015_desc)RETURNING g_apcb_d[l_ac].apcb015_desc
      #160414-00018#7 ---e---
      
      #end add-point
 
      CALL aapq350_detail_show("'1'")
 
      CALL aapq350_apcb_t_mask()
 
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
 
   CALL g_apcb_d.deleteElement(g_apcb_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_apcb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aapq350_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq350_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq350_detail_action_trans()
 
   LET l_ac = 1
   IF g_apcb_d.getLength() > 0 THEN
      CALL aapq350_b_fill2()
   END IF
 
      CALL aapq350_filter_show('apcbseq','b_apcbseq')
   CALL aapq350_filter_show('apcbld','b_apcbld')
   CALL aapq350_filter_show('apcbdocno','b_apcbdocno')
   CALL aapq350_filter_show('apcb022','b_apcb022')
   CALL aapq350_filter_show('apcb014','b_apcb014')
   CALL aapq350_filter_show('apcb005','b_apcb005')
   CALL aapq350_filter_show('apcb105','b_apcb105')
   CALL aapq350_filter_show('apcb007','b_apcb007')
   CALL aapq350_filter_show('apcb102','b_apcb102')
   CALL aapq350_filter_show('apcb115','b_apcb115')
   CALL aapq350_filter_show('apcb027','b_apcb027')
   CALL aapq350_filter_show('apcb028','b_apcb028')
   CALL aapq350_filter_show('apcb030','b_apcb030')
   CALL aapq350_filter_show('apcb010','b_apcb010')
   CALL aapq350_filter_show('apcb015','b_apcb015')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapq350.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq350_b_fill2()
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
 
{<section id="aapq350.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq350_detail_show(ps_page)
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
 
{<section id="aapq350.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aapq350_filter()
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
      CONSTRUCT g_wc_filter ON apcbseq,apcbld,apcbdocno,apcb022,apcb014,apcb005,apcb105,apcb007,apcb102, 
          apcb115,apcb027,apcb028,apcb030,apcb010,apcb015
                          FROM s_detail1[1].b_apcbseq,s_detail1[1].b_apcbld,s_detail1[1].b_apcbdocno, 
                              s_detail1[1].b_apcb022,s_detail1[1].b_apcb014,s_detail1[1].b_apcb005,s_detail1[1].b_apcb105, 
                              s_detail1[1].b_apcb007,s_detail1[1].b_apcb102,s_detail1[1].b_apcb115,s_detail1[1].b_apcb027, 
                              s_detail1[1].b_apcb028,s_detail1[1].b_apcb030,s_detail1[1].b_apcb010,s_detail1[1].b_apcb015 
 
 
         BEFORE CONSTRUCT
                     DISPLAY aapq350_filter_parser('apcbseq') TO s_detail1[1].b_apcbseq
            DISPLAY aapq350_filter_parser('apcbld') TO s_detail1[1].b_apcbld
            DISPLAY aapq350_filter_parser('apcbdocno') TO s_detail1[1].b_apcbdocno
            DISPLAY aapq350_filter_parser('apcb022') TO s_detail1[1].b_apcb022
            DISPLAY aapq350_filter_parser('apcb014') TO s_detail1[1].b_apcb014
            DISPLAY aapq350_filter_parser('apcb005') TO s_detail1[1].b_apcb005
            DISPLAY aapq350_filter_parser('apcb105') TO s_detail1[1].b_apcb105
            DISPLAY aapq350_filter_parser('apcb007') TO s_detail1[1].b_apcb007
            DISPLAY aapq350_filter_parser('apcb102') TO s_detail1[1].b_apcb102
            DISPLAY aapq350_filter_parser('apcb115') TO s_detail1[1].b_apcb115
            DISPLAY aapq350_filter_parser('apcb027') TO s_detail1[1].b_apcb027
            DISPLAY aapq350_filter_parser('apcb028') TO s_detail1[1].b_apcb028
            DISPLAY aapq350_filter_parser('apcb030') TO s_detail1[1].b_apcb030
            DISPLAY aapq350_filter_parser('apcb010') TO s_detail1[1].b_apcb010
            DISPLAY aapq350_filter_parser('apcb015') TO s_detail1[1].b_apcb015
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_apcbseq>>----
         #Ctrlp:construct.c.filter.page1.b_apcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbseq
            #add-point:ON ACTION controlp INFIELD b_apcbseq name="construct.c.filter.page1.b_apcbseq"
            
            #END add-point
 
 
         #----<<b_apcbld>>----
         #Ctrlp:construct.c.filter.page1.b_apcbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbld
            #add-point:ON ACTION controlp INFIELD b_apcbld name="construct.c.filter.page1.b_apcbld"
            
            #END add-point
 
 
         #----<<b_apcbdocno>>----
         #Ctrlp:construct.c.page1.b_apcbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcbdocno
            #add-point:ON ACTION controlp INFIELD b_apcbdocno name="construct.c.filter.page1.b_apcbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160518-00075#25--s
            IF NOT cl_null(g_user_dept_wc_q) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
            END IF
            #160518-00075#25--e    
            CALL q_apcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcbdocno  #顯示到畫面上
            NEXT FIELD b_apcbdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apcb022>>----
         #Ctrlp:construct.c.filter.page1.b_apcb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb022
            #add-point:ON ACTION controlp INFIELD b_apcb022 name="construct.c.filter.page1.b_apcb022"
            
            #END add-point
 
 
         #----<<b_apcb014>>----
         #Ctrlp:construct.c.page1.b_apcb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb014
            #add-point:ON ACTION controlp INFIELD b_apcb014 name="construct.c.filter.page1.b_apcb014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcb014  #顯示到畫面上
            NEXT FIELD b_apcb014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apcb005>>----
         #Ctrlp:construct.c.filter.page1.b_apcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb005
            #add-point:ON ACTION controlp INFIELD b_apcb005 name="construct.c.filter.page1.b_apcb005"
            
            #END add-point
 
 
         #----<<b_apcb105>>----
         #Ctrlp:construct.c.filter.page1.b_apcb105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb105
            #add-point:ON ACTION controlp INFIELD b_apcb105 name="construct.c.filter.page1.b_apcb105"
            
            #END add-point
 
 
         #----<<b_apcb007>>----
         #Ctrlp:construct.c.filter.page1.b_apcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb007
            #add-point:ON ACTION controlp INFIELD b_apcb007 name="construct.c.filter.page1.b_apcb007"
            
            #END add-point
 
 
         #----<<b_apcb102>>----
         #Ctrlp:construct.c.filter.page1.b_apcb102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb102
            #add-point:ON ACTION controlp INFIELD b_apcb102 name="construct.c.filter.page1.b_apcb102"
            
            #END add-point
 
 
         #----<<b_apcb115>>----
         #Ctrlp:construct.c.filter.page1.b_apcb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb115
            #add-point:ON ACTION controlp INFIELD b_apcb115 name="construct.c.filter.page1.b_apcb115"
            
            #END add-point
 
 
         #----<<b_apcb027>>----
         #Ctrlp:construct.c.filter.page1.b_apcb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb027
            #add-point:ON ACTION controlp INFIELD b_apcb027 name="construct.c.filter.page1.b_apcb027"
            
            #END add-point
 
 
         #----<<b_apcb028>>----
         #Ctrlp:construct.c.filter.page1.b_apcb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb028
            #add-point:ON ACTION controlp INFIELD b_apcb028 name="construct.c.filter.page1.b_apcb028"
            
            #END add-point
 
 
         #----<<b_apca014>>----
         #----<<b_apca014_desc>>----
         #----<<b_apcb030>>----
         #Ctrlp:construct.c.filter.page1.b_apcb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb030
            #add-point:ON ACTION controlp INFIELD b_apcb030 name="construct.c.filter.page1.b_apcb030"
            
            #END add-point
 
 
         #----<<apcb030_desc>>----
         #----<<b_apcb010>>----
         #Ctrlp:construct.c.filter.page1.b_apcb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb010
            #add-point:ON ACTION controlp INFIELD b_apcb010 name="construct.c.filter.page1.b_apcb010"
            
            #END add-point
 
 
         #----<<b_apcb010_desc>>----
         #----<<b_apcb015>>----
         #Ctrlp:construct.c.page1.b_apcb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcb015
            #add-point:ON ACTION controlp INFIELD b_apcb015 name="construct.c.filter.page1.b_apcb015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apcb015  #顯示到畫面上
            NEXT FIELD b_apcb015                     #返回原欄位
    


            #END add-point
 
 
         #----<<apcb015_desc>>----
 
 
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
 
      CALL aapq350_filter_show('apcbseq','b_apcbseq')
   CALL aapq350_filter_show('apcbld','b_apcbld')
   CALL aapq350_filter_show('apcbdocno','b_apcbdocno')
   CALL aapq350_filter_show('apcb022','b_apcb022')
   CALL aapq350_filter_show('apcb014','b_apcb014')
   CALL aapq350_filter_show('apcb005','b_apcb005')
   CALL aapq350_filter_show('apcb105','b_apcb105')
   CALL aapq350_filter_show('apcb007','b_apcb007')
   CALL aapq350_filter_show('apcb102','b_apcb102')
   CALL aapq350_filter_show('apcb115','b_apcb115')
   CALL aapq350_filter_show('apcb027','b_apcb027')
   CALL aapq350_filter_show('apcb028','b_apcb028')
   CALL aapq350_filter_show('apcb030','b_apcb030')
   CALL aapq350_filter_show('apcb010','b_apcb010')
   CALL aapq350_filter_show('apcb015','b_apcb015')
 
 
   CALL aapq350_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq350.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aapq350_filter_parser(ps_field)
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
 
{<section id="aapq350.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq350_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aapq350.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq350_detail_action_trans()
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
 
{<section id="aapq350.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq350_detail_index_setting()
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
            IF g_apcb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apcb_d.getLength() AND g_apcb_d.getLength() > 0
            LET g_detail_idx = g_apcb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apcb_d.getLength() THEN
               LET g_detail_idx = g_apcb_d.getLength()
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
 
{<section id="aapq350.mask_functions" >}
 &include "erp/aap/aapq350_mask.4gl"
 
{</section>}
 
{<section id="aapq350.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢核零用金交易帳戶是否存在
# Memo...........:
# Usage..........: CALL aapq350_apca057_chk()
# Date & Author..: 2014/09/23 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq350_apca057_chk()
   DEFINE l_count     LIKE type_t.num10
   DEFINE r_success   BOOLEAN
   DEFINE r_errno     LIKE gzze_t.gzze001
      
   LET r_success = TRUE
   LET r_errno = ''
      
   SELECT COUNT(*) INTO l_count
     FROM apad_t
    WHERE apadent = g_enterprise
      AND apad002 = g_input.apca057
      AND apad005 = 'Y'
   
   IF cl_null(l_count) THEN 
      LET l_count = 0 
   END IF
   
   IF l_count = 0 THEN
      LET r_success = FALSE 
      LET r_errno = 'aap-00113'
   END IF
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 切帳套字串
# Memo...........:
# Usage..........: CALL aapq350_change_to_sql(p_wc)
# Date & Author..: 2014/09/23 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq350_change_to_sql(p_wc)
DEFINE p_wc       STRING
DEFINE r_wc       STRING
DEFINE tok        base.StringTokenizer
DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: apca057 說明
# Memo...........:
# Usage..........: CALL aapq350_apca057_ref()
# Date & Author..: 2014/09/23 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq350_apca057_ref()
DEFINE l_nmas003    LIKE nmas_t.nmas003  # 幣別

   #歸屬site名稱
   SELECT nmaal003,nmas003,ooefl003 
     INTO g_input.apca057_desc,l_nmas003,g_input.apacsite_desc
     FROM apac_t 
     LEFT OUTER JOIN ooefl_t ON apacent = ooeflent AND apacsite = ooefl001 AND ooefl002 = g_dlang , apad_t, nmas_t 
     LEFT OUTER JOIN nmaal_t ON nmasent = nmaalent AND nmas001 = nmaal001  AND nmaal002 = g_dlang , ooag_t 
     LEFT OUTER JOIN oofa_t  ON ooagent = oofaent  AND oofa001 = ooag002   
    WHERE  apacent = apadent
      AND apac001 = apad001 
      AND apacent = nmasent 
      AND apad002 = nmas002 
      AND apacent = ooagent 
      AND apac003 = ooag001 
      AND apacent=  g_enterprise 
      AND apacstus ='Y' 
      AND apad005 = 'Y' 
      AND apad002 = g_input.apca057
      
      LET g_input.apacsite_desc = g_input.apacsite_desc||'/'||l_nmas003
 DISPLAY BY NAME  g_input.apca057_desc,g_input.apacsite_desc




END FUNCTION

################################################################################
# Descriptions...: 掃把清空&給預設值 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapq350_qbe_clear()

# Date & Author..: 2015/02/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq350_qbe_clear()
   
   CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_input.apcald,g_input.apcacomp,g_errno  #回傳帳套和歸屬法人
   LET g_input.apcald_desc = s_desc_get_ld_desc(g_input.apcald)
   LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
   LET g_input.year = YEAR(g_today)
   LET g_input.month = MONTH(g_today)
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.apcacomp,g_today,'1')
   #帳務組織底下所屬成員
   CALL s_fin_account_center_sons_str() RETURNING g_comp_str
   #取得所屬成員字串
   CALL aapq350_change_to_sql(g_comp_str)RETURNING g_comp_str
   #法人/帳套說明
   CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc
   CALL s_desc_get_department_desc(g_input.apcacomp) RETURNING g_input.apcacomp_desc
   
   LET g_input.apca057 = ''
   LET g_input.apca057_desc = ''
   #160518-00075#25--s
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','apcbld','apcbent','apcbdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = cl_replace_str(g_user_dept_wc,'apcb','apca')
   #160518-00075#25--e 
   
   DISPLAY BY NAME g_input.apcald_desc,g_input.apcacomp_desc,g_input.apcacomp,g_input.apca057,g_input.apca057_desc
   
END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: #150319-00004#4
#
# Date & Author..: 150629 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq350_x01_tmp()
   DROP TABLE aapq350_x01_tmp;
   CREATE TEMP TABLE aapq350_x01_tmp(
      apcbdocno       LIKE apcb_t.apcbdocno,
      l_apcb022_desc  LIKE type_t.chr500,
      apcb014         LIKE apcb_t.apcb014,
      apcb005         LIKE apcb_t.apcb005,
      apcb105         LIKE apcb_t.apcb105,
      apcb007         LIKE apcb_t.apcb007,
      apcb102         LIKE apcb_t.apcb102,
      apcb115         LIKE apcb_t.apcb115,
      apcb027         LIKE apcb_t.apcb027,
      apcb028         LIKE apcb_t.apcb028,
      l_apca014_desc  LIKE type_t.chr500,
      l_apcb010_desc  LIKE type_t.chr500,
      l_apcb015_desc  LIKE type_t.chr500,
      l_apcald_desc   LIKE type_t.chr500,
      l_apca057_desc  LIKE type_t.chr500,
      l_year          LIKE type_t.num5,
      l_month         LIKE type_t.num5
   )
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #150319-00004#4
#
# Date & Author..: 150629 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq350_insert_tmp()
DEFINE l_i LIKE type_t.num10
DEFINE l_apcb022_desc LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_x01_tmp   RECORD
   apcbdocno       LIKE apcb_t.apcbdocno, 
   l_apcb022_desc  LIKE type_t.chr500, 
   apcb014         LIKE apcb_t.apcb014, 
   apcb005         LIKE apcb_t.apcb005, 
   apcb105         LIKE apcb_t.apcb105, 
   apcb007         LIKE apcb_t.apcb007, 
   apcb102         LIKE apcb_t.apcb102, 
   apcb115         LIKE apcb_t.apcb115, 
   apcb027         LIKE apcb_t.apcb027, 
   apcb028         LIKE apcb_t.apcb028, 
   l_apca014_desc  LIKE type_t.chr500, 
   l_apcb010_desc  LIKE type_t.chr500, 
   l_apcb015_desc  LIKE type_t.chr500,
   l_apcald_desc   LIKE type_t.chr500,
   l_apca057_desc  LIKE type_t.chr500,
   l_year          LIKE type_t.num5,
   l_month         LIKE type_t.num5
                   END RECORD
                   
   DELETE FROM aapq350_x01_tmp
   FOR l_i = 1 TO g_apcb_d.getLength()
      CALL s_desc_gzcbl004_desc('8708',g_apcb_d[l_i].apcb022) RETURNING l_apcb022_desc
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.apcbdocno       = g_apcb_d[l_i].apcbdocno 
      LET l_x01_tmp.l_apcb022_desc  = g_apcb_d[l_i].apcb022,":",l_apcb022_desc
      LET l_x01_tmp.apcb014         = g_apcb_d[l_i].apcb014 
      LET l_x01_tmp.apcb005         = g_apcb_d[l_i].apcb005 
      LET l_x01_tmp.apcb105         = g_apcb_d[l_i].apcb105 
      LET l_x01_tmp.apcb007         = g_apcb_d[l_i].apcb007 
      LET l_x01_tmp.apcb102         = g_apcb_d[l_i].apcb102 
      LET l_x01_tmp.apcb115         = g_apcb_d[l_i].apcb115 
      LET l_x01_tmp.apcb027         = g_apcb_d[l_i].apcb027 
      LET l_x01_tmp.apcb028         = g_apcb_d[l_i].apcb028
      LET l_x01_tmp.l_apca014_desc  = g_apcb_d[l_i].apca014_desc
      LET l_x01_tmp.l_apcb010_desc  = g_apcb_d[l_i].apcb010_desc
      LET l_x01_tmp.l_apcb015_desc  = g_apcb_d[l_i].apcb015_desc
      IF NOT cl_null(g_input.apcald_desc) THEN
         LET l_x01_tmp.l_apcald_desc   = g_input.apcald,":",g_input.apcald_desc
      ELSE
         LET l_x01_tmp.l_apcald_desc   = g_input.apcald
      END IF
      IF NOT cl_null(g_input.apca057_desc) THEN
         LET l_x01_tmp.l_apca057_desc  = g_input.apca057,":",g_input.apca057_desc
      ELSE
         LET l_x01_tmp.l_apca057_desc  = g_input.apca057
      END IF
      LET l_x01_tmp.l_year          = g_input.year
      LET l_x01_tmp.l_month         = g_input.month
      #INSERT INTO aapq350_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq350_x01_tmp (apcbdocno,l_apcb022_desc,apcb014,apcb005,apcb105,
                                   apcb007,apcb102,apcb115,apcb027,apcb028,
                                   l_apca014_desc,l_apcb010_desc,l_apcb015_desc,l_apcald_desc,l_apca057_desc,
                                   l_year,l_month
                                  )
      VALUES (l_x01_tmp.apcbdocno,l_x01_tmp.l_apcb022_desc,l_x01_tmp.apcb014,l_x01_tmp.apcb005,l_x01_tmp.apcb105,
              l_x01_tmp.apcb007,l_x01_tmp.apcb102,l_x01_tmp.apcb115,l_x01_tmp.apcb027,l_x01_tmp.apcb028,
              l_x01_tmp.l_apca014_desc,l_x01_tmp.l_apcb010_desc,l_x01_tmp.l_apcb015_desc,l_x01_tmp.l_apcald_desc,l_x01_tmp.l_apca057_desc,
              l_x01_tmp.l_year,l_x01_tmp.l_month
             )
      #161108-00017#2 add end---
   END FOR
END FUNCTION

 
{</section>}
 
