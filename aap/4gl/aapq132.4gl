#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq132.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-10-04 14:54:28), PR版次:0008(2017-01-06 17:09:24)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: aapq132
#+ Description: 入庫/退貨明細查詢
#+ Creator....: 02291(2015-09-29 10:23:40)
#+ Modifier...: 08171 -SD/PR- 06821
 
{</section>}
 
{<section id="aapq132.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#4   2016/01/11  By 02097    增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite 
#160414-00018#5   2016/05/05  By 03538    效能調整
#160518-00075#19  2016/08/03  By Hans     使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#160912-00028#1   2016/10/04  By 08171    位稅單價金額取位
#161006-00005#19  2016/10/24  By 08732    組織類型與職能開窗調整
#161114-00017#1   2016/11/14  By Reanna   開窗權限調整
#161229-00047#25  2017/01/06  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
PRIVATE TYPE type_g_pmds_d RECORD
       
       sel LIKE type_t.chr1, 
   pmdssite LIKE pmds_t.pmdssite, 
   pmdssite_desc LIKE type_t.chr500, 
   l_pmds000 LIKE type_t.chr500, 
   pmdsdocno LIKE pmds_t.pmdsdocno, 
   pmdtseq LIKE type_t.chr500, 
   pmds001 LIKE pmds_t.pmds001, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds007_desc LIKE type_t.chr500, 
   pmdt027 LIKE type_t.chr500, 
   pmdw010 LIKE type_t.chr500, 
   pmdt005 LIKE type_t.chr500, 
   pmdt006 LIKE type_t.chr500, 
   pmdt006_desc LIKE type_t.chr500, 
   pmdt006_desc_1 LIKE type_t.chr500, 
   pmdt020 LIKE type_t.chr500, 
   pmdt019 LIKE type_t.chr500, 
   pmdt019_desc LIKE type_t.chr500, 
   pmdt036 LIKE pmdt_t.pmdt036, 
   l_pmdt036 LIKE type_t.chr500, 
   pmdt038 LIKE type_t.chr500, 
   pmdt039 LIKE type_t.chr500, 
   l_pmdt0361 LIKE type_t.chr500, 
   l_pmdt0362 LIKE type_t.chr500, 
   l_pmdt038 LIKE type_t.chr500, 
   l_pmdt039 LIKE type_t.chr500, 
   pmdt046 LIKE type_t.chr500, 
   pmdt046_desc LIKE type_t.chr500, 
   pmdt037 LIKE type_t.chr500, 
   pmds037 LIKE type_t.chr500, 
   pmds038 LIKE type_t.chr500, 
   pmdt016 LIKE type_t.chr500, 
   pmdt016_desc LIKE type_t.chr500, 
   pmdt017 LIKE type_t.chr500, 
   pmdt017_desc LIKE type_t.chr500, 
   pmdt018 LIKE type_t.chr500, 
   pmdt001 LIKE type_t.chr500, 
   pmds031 LIKE type_t.chr500, 
   pmds031_desc LIKE type_t.chr500, 
   pmds002 LIKE pmds_t.pmds002, 
   pmds002_desc LIKE type_t.chr500, 
   pmds045 LIKE type_t.chr500, 
   pmdsstus LIKE pmds_t.pmdsstus
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master            RECORD
          pmds000             LIKE pmds_t.pmds000
                           END RECORD
DEFINE g_sql_ctrl          STRING               #151231-00010#4
DEFINE g_user_dept_wc      STRING               #160518-00075#19
DEFINE g_user_dept_wc_q    STRING               #160518-00075#19
DEFINE g_wc_cs_orga        STRING               #161006-00005#19  add  在azzi800權限中的組織
DEFINE g_comp              LIKE glaa_t.glaacomp #161114-00017#1
DEFINE g_wc_cs_comp        STRING               #161229-00047#25 add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmds_d            DYNAMIC ARRAY OF type_g_pmds_d
DEFINE g_pmds_d_t          type_g_pmds_d
 
 
 
 
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
 
{<section id="aapq132.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_sql   STRING   #160414-00018#5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#4--(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161114-00017#1 mark
   #160414-00018#4--s
   #161114-00017#1 add ------
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#25 mark
   #161114-00017#1 add end---
   #151231-00010#4--(E)
   #160414-00018#5--s
   LET l_sql = "SELECT ooef019 FROM ooef_t ",
               " WHERE ooefent = '",g_enterprise,"'",
               "   AND ooef001 = ? "  
   PREPARE sel_ooef019_pre FROM l_sql   
   
   
   LET l_sql = "SELECT oodb005 FROM oodb_t ",
               " WHERE oodbent = '",g_enterprise,"' ",
               "   AND oodb001 = ? ",
               "   AND oodb002 = ? "
   PREPARE sel_oodb005_pre FROM l_sql                  
   #160414-00018#5--e
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
   DECLARE aapq132_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq132_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq132_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq132 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq132_init()   
 
      #進入選單 Menu (="N")
      CALL aapq132_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq132
      
   END IF 
   
   CLOSE aapq132_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq132.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapq132_init()
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
      CALL cl_set_combo_scc_part('b_pmdsstus','13','N,Y,S,A,D,R,W,X,Z')
 
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('pmdsstus','13','N,X,Y,S')
   CALL cl_set_combo_scc('pmds000','4048')
   CALL cl_set_combo_scc('l_pmds000','4048')
   CALL cl_set_combo_scc('b_pmdt005','2055')   #add by lixh 20150212
   CALL cl_set_combo_scc('pmdt005','2055')     #add by lixh 20150212
   CALL cl_set_combo_scc_part('b_pmdsstus','13','N,X,Y,S')   
   #160518-00075#19--s
   LET g_user_dept_wc = '' 
   CALL s_fin_get_user_dept_control('pmdssite','','pmdsent','pmdsdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q  = g_user_dept_wc
   #160518-00075#19--e 
   #161006-00005#19   add---s
   CALL s_fin_create_account_center_tmp()                      
   CALL s_fin_azzi800_sons_query(g_today)                      
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga 
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  
   #161006-00005#19   add---e
   #161229-00047#25 --s add
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#25 --e add    
   #end add-point
 
   CALL aapq132_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aapq132.default_search" >}
PRIVATE FUNCTION aapq132_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdsdocno = '", g_argv[01], "' AND "
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
 
{<section id="aapq132.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq132_ui_dialog() 
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
 
   
   CALL aapq132_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmds_d.clear()
 
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
 
         CALL aapq132_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.pmds000
         
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmdssite,pmdsdocno,pmds001,pmdt001,pmds007,pmdt006,
                                   pmds002,pmds003,pmdsstus,imaa009,imaf141,pmdt005      
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD pmdssite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef201 = 'Y' AND ooef001 IN ", g_wc_cs_orga  #161006-00005#19   add
               #CALL q_ooef001_14()   #161006-00005#19   mark
               CALL q_ooef001()       #161006-00005#19   add         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdssite  #顯示到畫面上
               NEXT FIELD pmdssite                     #返回原欄位 
               
            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15')"
               #151231-00010#4--(S)
               LET g_qryparam.where = g_qryparam.where, " AND pmds008 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                                        " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               #160518-00075#19--s
               IF NOT cl_null(g_user_dept_wc_q) THEN
                  LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q
               END IF               
               #160518-00075#19--e
               CALL q_pmdsdocno_1()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsdocno  #顯示到畫面上
               NEXT FIELD pmdsdocno                     #返回原欄位      

            ON ACTION controlp INFIELD pmdt001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #151231-00010#4--(S)
               LET g_qryparam.where = " pmdl004 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND pmdl004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               CALL q_pmdldocno()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdt001  #顯示到畫面上
               NEXT FIELD pmdt001                     #返回原欄位 
               
            ON ACTION controlp INFIELD pmds007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #151231-00010#4--(S)
               LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
               NEXT FIELD pmds007                     #返回原欄位
    
            ON ACTION controlp INFIELD pmdt006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_imaf001_15()  #161114-00017#1 mark
               #161114-00017#1 add ------
               SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
               LET g_qryparam.arg1 = g_comp
               CALL q_imaf001_21()
               #161114-00017#1 add end---
               DISPLAY g_qryparam.return1 TO pmdt006
               NEXT FIELD pmdt006
               
            ON ACTION controlp INFIELD pmds002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds002  #顯示到畫面上
               NEXT FIELD pmds002                     #返回原欄位
    
            ON ACTION controlp INFIELD pmds003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds003  #顯示到畫面上
               NEXT FIELD pmds003                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                     #返回原欄位
    
            ON ACTION controlp INFIELD imaf141
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imce141()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
               NEXT FIELD imaf141                     #返回原欄位
           
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmds_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aapq132_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq132_b_fill2()
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
            CALL aapq132_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD pmdssite
 
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
            CALL aapq132_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmds_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aapq132_b_fill()
 
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
            CALL aapq132_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq132_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq132_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq132_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmds_d.getLength()
               LET g_pmds_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmds_d.getLength()
               LET g_pmds_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmds_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmds_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmds_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmds_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapq132_filter()
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
 
{<section id="aapq132.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq132_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   DEFINE l_oodb005  LIKE oodb_t.oodb005
   #160414-00018#5 --s
   DEFINE l_ooefl003_sql  STRING
   DEFINE l_pmaal004_sql  STRING
   DEFINE l_ooibl004_sql  STRING
   DEFINE l_ooag011_sql   STRING
   DEFINE l_imaal003_sql  STRING
   DEFINE l_imaal004_sql  STRING
   DEFINE l_oocal003_sql  STRING
   DEFINE l_inayl003_sql  STRING
   DEFINE l_inab003_sql   STRING
   #160414-00018#5 --e
   
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
 
   CALL g_pmds_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmdssite,'','',pmdsdocno,'',pmds001,pmds007,'','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','',pmds002,'','',pmdsstus  , 
       DENSE_RANK() OVER( ORDER BY pmds_t.pmdsdocno) AS RANK FROM pmds_t",
 
 
                     "",
                     " WHERE pmdsent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmds_t"),
                     " ORDER BY pmds_t.pmdsdocno"
 
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
 
   LET g_sql = "SELECT '',pmdssite,'','',pmdsdocno,'',pmds001,pmds007,'','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','',pmds002,'','',pmdsstus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc = ls_wc," AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)   
   LET ls_wc = ls_wc," AND ",g_user_dept_wc     #160518-00075#19
  #160414-00018#5 mod--s
   LET l_ooefl003_sql = s_fin_get_department_sql('a','pmdsent','pmdssite')
   LET l_pmaal004_sql = s_fin_get_trading_partner_abbr_sql('b','pmdsent','pmds007')
   LET l_ooibl004_sql = "(SELECT ooibl004 FROM ooibl_t WHERE ooiblent=pmdsent AND ooibl002=pmds031 AND ooibl003='",g_dlang,"')"
   LET l_ooag011_sql  = s_fin_get_person_sql('c','pmdsent','pmds002')
   LET l_imaal003_sql = "(SELECT imaal003 FROM imaal_t WHERE imaalent=pmdsent AND imaal001=pmdt006 AND imaal002='",g_dlang,"')"
   LET l_imaal004_sql = cl_replace_str(l_imaal003_sql,'imaal003','imaal004')
   LET l_oocal003_sql = "(SELECT oocal003 FROM oocal_t WHERE oocalent=pmdsent AND oocal001=pmdt019 AND oocal002='",g_dlang,"')"
   LET l_inayl003_sql = "(SELECT inayl003 FROM inayl_t WHERE inaylent=pmdsent AND inayl001=pmdt016 AND inayl002='",g_dlang,"')"
   LET l_inab003_sql  = "(SELECT inab003 FROM inab_t WHERE inabent=pmdsent AND inab001=pmdt016 AND inab002=pmdt017 AND inabsite=pmdtsite)"
  #LET g_sql = "SELECT 'N',pmdssite,ooefl003,pmds000,pmdsdocno,pmdtseq,pmds001,pmds007,pmaal004,pmdt027,'',pmdt005,pmdt006,imaal003,imaal004,pmdt020,pmdt019,oocal003,",
              #據點名稱/交易對象名稱
  LET g_sql = "SELECT 'N',pmdssite,",l_ooefl003_sql,",pmds000,pmdsdocno,pmdtseq,pmds001,pmds007,",l_pmaal004_sql,",pmdt027, ",
              #發票號碼
              "       (SELECT pmdw010 FROM pmdw_t WHERE pmdwent = pmdtent AND pmdwdocno = pmdt027),",
              #品名/規格/單位說明
              "       pmdt005,pmdt006,",l_imaal003_sql,",",l_imaal004_sql,",pmdt020,pmdt019,",l_oocal003_sql,",",
  #160414-00018#5 mod--e
               "       pmdt036,0,pmdt038,pmdt039,",
               "       0,0,pmdt038*(NVL(pmds038,1)),pmdt039*(NVL(pmds038,1)),",
              #"       pmdt046,'',pmdt037,pmds037, ",   #160414-00018#5 mark
              #160414-00018#5--s
              #稅別說明
              "       pmdt046,(SELECT oodbl004 FROM oodbl_t WHERE oodblent=pmdsent ",
              "       AND oodbl001=(SELECT ooef019 FROM ooef_t WHERE ooefent = pmdsent AND ooef001 = pmdssite)",
              "       AND oodbl002=pmdt046 AND oodbl003='",g_dlang,"'),",
              "       pmdt037,pmds037, ",
              #160414-00018#5--e
              
               #"       NVL(pmds038,1),pmdt016,inayl003,pmdt017,inab003,pmdt018,pmdt001,pmds031,ooibl004,pmds002,ooag011,pmds045,pmdsstus ",  #160414-00018#5 mark
               #庫位說明/儲位名稱/款別說明
               "       NVL(pmds038,1),pmdt016,",l_inayl003_sql,",pmdt017,",l_inab003_sql,",pmdt018,pmdt001,pmds031,",l_ooibl004_sql,",",                          #160414-00018#5          
               #人員全名
               "       pmds002,",l_ooag011_sql,",pmds045,pmdsstus ",                                                                          #160414-00018#5
               " FROM pmds_t",
               #160414-00018#5 mark--s
               #"      LEFT OUTER JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=pmdssite AND ooefl002='"||g_dlang||"'",
               #"      LEFT OUTER JOIN pmaal_t ON pmaalent='"||g_enterprise||"' AND pmaal001=pmds007 AND pmaal002='"||g_dlang||"'",
               #"      LEFT OUTER JOIN ooibl_t ON ooiblent='"||g_enterprise||"' AND ooibl002=pmds031 AND ooibl003='"||g_dlang||"'",
               #"      LEFT OUTER JOIN ooag_t ON ooagent='"||g_enterprise||"' AND ooag001=pmds002 ",
               #160414-00018#5 mark--e
               "      ,pmdt_t",
               #160414-00018#5 mark--s
               #"      LEFT OUTER JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=pmdt006 AND imaal002='"||g_dlang||"'",
               #"      LEFT OUTER JOIN oocal_t ON oocalent='"||g_enterprise||"' AND oocal001=pmdt019 AND oocal002='"||g_dlang||"'",
               #"      LEFT OUTER JOIN inayl_t ON inaylent='"||g_enterprise||"' AND inayl001=pmdt016 AND inayl002 ='"||g_dlang||"'",
               #"      LEFT OUTER JOIN inab_t ON inabent='"||g_enterprise||"' AND inab001=pmdt016 AND inab002=pmdt017 AND inabsite=pmdtsite",
               #160414-00018#5 mark--e
               " WHERE pmdsent=pmdtent AND pmdsdocno=pmdtdocno",
               "   AND pmdsent= ? AND ",ls_wc                       
   CASE g_master.pmds000  
      WHEN '1'
         LET g_sql = g_sql," AND pmds000 IN ('3','4','6','12','13') "
      WHEN '2'
         LET g_sql = g_sql," AND pmds000 IN ('7','14','15') "
      OTHERWISE
         LET g_sql = g_sql," AND pmds000 IN ('3','4','6','7','12','13','14','15') "         
   END CASE 
   LET g_sql = g_sql," ORDER BY pmdsdocno"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq132_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq132_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmds_d[l_ac].sel,g_pmds_d[l_ac].pmdssite,g_pmds_d[l_ac].pmdssite_desc, 
       g_pmds_d[l_ac].l_pmds000,g_pmds_d[l_ac].pmdsdocno,g_pmds_d[l_ac].pmdtseq,g_pmds_d[l_ac].pmds001, 
       g_pmds_d[l_ac].pmds007,g_pmds_d[l_ac].pmds007_desc,g_pmds_d[l_ac].pmdt027,g_pmds_d[l_ac].pmdw010, 
       g_pmds_d[l_ac].pmdt005,g_pmds_d[l_ac].pmdt006,g_pmds_d[l_ac].pmdt006_desc,g_pmds_d[l_ac].pmdt006_desc_1, 
       g_pmds_d[l_ac].pmdt020,g_pmds_d[l_ac].pmdt019,g_pmds_d[l_ac].pmdt019_desc,g_pmds_d[l_ac].pmdt036, 
       g_pmds_d[l_ac].l_pmdt036,g_pmds_d[l_ac].pmdt038,g_pmds_d[l_ac].pmdt039,g_pmds_d[l_ac].l_pmdt0361, 
       g_pmds_d[l_ac].l_pmdt0362,g_pmds_d[l_ac].l_pmdt038,g_pmds_d[l_ac].l_pmdt039,g_pmds_d[l_ac].pmdt046, 
       g_pmds_d[l_ac].pmdt046_desc,g_pmds_d[l_ac].pmdt037,g_pmds_d[l_ac].pmds037,g_pmds_d[l_ac].pmds038, 
       g_pmds_d[l_ac].pmdt016,g_pmds_d[l_ac].pmdt016_desc,g_pmds_d[l_ac].pmdt017,g_pmds_d[l_ac].pmdt017_desc, 
       g_pmds_d[l_ac].pmdt018,g_pmds_d[l_ac].pmdt001,g_pmds_d[l_ac].pmds031,g_pmds_d[l_ac].pmds031_desc, 
       g_pmds_d[l_ac].pmds002,g_pmds_d[l_ac].pmds002_desc,g_pmds_d[l_ac].pmds045,g_pmds_d[l_ac].pmdsstus 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_pmds_d[l_ac].l_pmds000 = '3' OR g_pmds_d[l_ac].l_pmds000 = '4' OR g_pmds_d[l_ac].l_pmds000 = '6' 
         OR g_pmds_d[l_ac].l_pmds000 = '12' OR g_pmds_d[l_ac].l_pmds000 = '13' THEN 
         LET g_pmds_d[l_ac].l_pmds000 = '1'
      END IF 
      IF g_pmds_d[l_ac].l_pmds000 = '7' OR g_pmds_d[l_ac].l_pmds000 = '14' OR g_pmds_d[l_ac].l_pmds000 = '15' THEN
         LET g_pmds_d[l_ac].l_pmds000 ='2'        
      END IF 
      EXECUTE sel_ooef019_pre USING g_pmds_d[l_ac].pmdssite INTO l_ooef019   #160414-00018#5       
      #160414-00018#5 mark--s
      #SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_pmds_d[l_ac].pmdssite       
      #SELECT oodbl004 INTO g_pmds_d[l_ac].pmdt046_desc
      #  FROM oodbl_t 
      # WHERE oodblent=g_enterprise 
      #   AND oodbl001=l_ooef019 
      #   AND oodbl002=g_pmds_d[l_ac].pmdt046 
      #   AND oodbl003=g_dlang
      
      #SELECT oodb005 INTO l_oodb005
      #  FROM oodb_t
      # WHERE oodbent = g_enterprise
      #   AND oodb001 = l_ooef019
      #   AND oodb002 = g_pmds_d[l_ac].pmdt046      
      #160414-00018#5 mark--e 
      EXECUTE sel_oodb005_pre USING l_ooef019,g_pmds_d[l_ac].pmdt046 INTO l_oodb005   #160414-00018#5
      IF l_oodb005 = 'Y' THEN 
         LET g_pmds_d[l_ac].l_pmdt036 = g_pmds_d[l_ac].pmdt036
         LET g_pmds_d[l_ac].pmdt036 = g_pmds_d[l_ac].l_pmdt036/(1+g_pmds_d[l_ac].pmdt037/100)
         #160912-00028#1--s
         IF NOT cl_null(g_pmds_d[l_ac].pmdt036) THEN
            LET g_pmds_d[l_ac].pmdt036 = s_curr_round(g_pmds_d[l_ac].pmdssite,g_pmds_d[l_ac].pmds037,g_pmds_d[l_ac].pmdt036,1) 
         END IF
         #160912-00028#1--e
      ELSE
         LET g_pmds_d[l_ac].l_pmdt036 = g_pmds_d[l_ac].pmdt036*(1+g_pmds_d[l_ac].pmdt037/100)
      END IF
      LET g_pmds_d[l_ac].l_pmdt0361 = g_pmds_d[l_ac].pmdt036*g_pmds_d[l_ac].pmds038
      LET g_pmds_d[l_ac].l_pmdt0362 = g_pmds_d[l_ac].l_pmdt036*g_pmds_d[l_ac].pmds038 

      IF g_pmds_d[l_ac].l_pmds000 ='2' THEN 
         LET g_pmds_d[l_ac].pmdt020 = g_pmds_d[l_ac].pmdt020 * -1
         LET g_pmds_d[l_ac].pmdt038 = g_pmds_d[l_ac].pmdt038 * -1
         LET g_pmds_d[l_ac].pmdt039 = g_pmds_d[l_ac].pmdt039 * -1
         LET g_pmds_d[l_ac].l_pmdt038 = g_pmds_d[l_ac].l_pmdt038 * -1
         LET g_pmds_d[l_ac].l_pmdt039 = g_pmds_d[l_ac].l_pmdt039 * -1
      END IF
      #160414-00018#5 mark--s
      ##显示发票号码  by cyj
      #SELECT pmdw010 INTO g_pmds_d[l_ac].pmdw010 FROM pmdw_t WHERE pmdwdocno = g_pmds_d[l_ac].pmdt027
      #160414-00018#5 mark--e
      #end add-point
 
      CALL aapq132_detail_show("'1'")
 
      CALL aapq132_pmds_t_mask()
 
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
 
   CALL g_pmds_d.deleteElement(g_pmds_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmds_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aapq132_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq132_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq132_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmds_d.getLength() > 0 THEN
      CALL aapq132_b_fill2()
   END IF
 
      CALL aapq132_filter_show('pmdssite','b_pmdssite')
   CALL aapq132_filter_show('pmdsdocno','b_pmdsdocno')
   CALL aapq132_filter_show('pmds001','b_pmds001')
   CALL aapq132_filter_show('pmds007','b_pmds007')
   CALL aapq132_filter_show('pmdt036','b_pmdt036')
   CALL aapq132_filter_show('pmds002','b_pmds002')
   CALL aapq132_filter_show('pmdsstus','b_pmdsstus')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapq132.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq132_b_fill2()
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
 
{<section id="aapq132.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq132_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
           #160414-00018#5 mark--s
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_pmds_d[l_ac].pmds007
           #LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
           #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           #LET g_pmds_d[l_ac].pmds007_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_pmds_d[l_ac].pmds007_desc
           #
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_pmds_d[l_ac].pmds031
           #LET ls_sql = "SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'"
           #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           #LET g_pmds_d[l_ac].pmds031_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_pmds_d[l_ac].pmds031_desc
           #
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_pmds_d[l_ac].pmds002
           #LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
           #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           #LET g_pmds_d[l_ac].pmds002_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_pmds_d[l_ac].pmds002_desc
           #160414-00018#5 mark--e

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq132.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aapq132_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   #CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   #CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:3)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON pmdssite,pmdsdocno,pmds001,pmds007,pmdt006,pmdt020,pmdt019,pmdt036,pmdt038, 
          pmdt039,pmdt046,pmdt037,pmds037,pmds038,pmdt016,pmdt017,pmdt018,pmdt001,pmds031,pmds002,pmds045, 
          pmdsstus
                          FROM s_detail1[1].b_pmdssite,s_detail1[1].b_pmdsdocno,s_detail1[1].b_pmds001, 
                              s_detail1[1].b_pmds007,s_detail1[1].b_pmdt006,s_detail1[1].b_pmdt020,s_detail1[1].b_pmdt019, 
                              s_detail1[1].b_pmdt036,s_detail1[1].b_pmdt038,s_detail1[1].b_pmdt039,s_detail1[1].b_pmdt046, 
                              s_detail1[1].b_pmdt037,s_detail1[1].b_pmds037,s_detail1[1].b_pmds038,s_detail1[1].b_pmdt016, 
                              s_detail1[1].b_pmdt017,s_detail1[1].b_pmdt018,s_detail1[1].b_pmdt001,s_detail1[1].b_pmds031, 
                              s_detail1[1].b_pmds002,s_detail1[1].b_pmds045,s_detail1[1].b_pmdsstus
 
         BEFORE CONSTRUCT
                     DISPLAY aapq132_filter_parser('pmdssite') TO s_detail1[1].b_pmdssite
            DISPLAY aapq132_filter_parser('pmdsdocno') TO s_detail1[1].b_pmdsdocno
            DISPLAY aapq132_filter_parser('pmds001') TO s_detail1[1].b_pmds001
            DISPLAY aapq132_filter_parser('pmds007') TO s_detail1[1].b_pmds007
            DISPLAY aapq132_filter_parser('pmdt006') TO s_detail1[1].b_pmdt006
            DISPLAY aapq132_filter_parser('pmdt020') TO s_detail1[1].b_pmdt020
            DISPLAY aapq132_filter_parser('pmdt019') TO s_detail1[1].b_pmdt019
            DISPLAY aapq132_filter_parser('pmdt036') TO s_detail1[1].b_pmdt036
            DISPLAY aapq132_filter_parser('pmdt038') TO s_detail1[1].b_pmdt038
            DISPLAY aapq132_filter_parser('pmdt039') TO s_detail1[1].b_pmdt039
            DISPLAY aapq132_filter_parser('pmdt046') TO s_detail1[1].b_pmdt046
            DISPLAY aapq132_filter_parser('pmdt037') TO s_detail1[1].b_pmdt037
            DISPLAY aapq132_filter_parser('pmds037') TO s_detail1[1].b_pmds037
            DISPLAY aapq132_filter_parser('pmds038') TO s_detail1[1].b_pmds038
            DISPLAY aapq132_filter_parser('pmdt016') TO s_detail1[1].b_pmdt016
            DISPLAY aapq132_filter_parser('pmdt017') TO s_detail1[1].b_pmdt017
            DISPLAY aapq132_filter_parser('pmdt018') TO s_detail1[1].b_pmdt018
            DISPLAY aapq132_filter_parser('pmdt001') TO s_detail1[1].b_pmdt001
            DISPLAY aapq132_filter_parser('pmds031') TO s_detail1[1].b_pmds031
            DISPLAY aapq132_filter_parser('pmds002') TO s_detail1[1].b_pmds002
            DISPLAY aapq132_filter_parser('pmds045') TO s_detail1[1].b_pmds045
            DISPLAY aapq132_filter_parser('pmdsstus') TO s_detail1[1].b_pmdsstus
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
   CALL aapq132_filter_show('pmdsdocno','b_pmdsdocno')
   CALL aapq132_filter_show('pmds001','b_pmds001')
   CALL aapq132_filter_show('pmds007','b_pmds007')
   CALL aapq132_filter_show('pmdt006','b_pmdt006')
   CALL aapq132_filter_show('pmdt020','b_pmdt020')
   CALL aapq132_filter_show('pmdt019','b_pmdt019')
   CALL aapq132_filter_show('pmdt036','b_pmdt036')
   CALL aapq132_filter_show('pmdt038','b_pmdt038')
   CALL aapq132_filter_show('pmdt039','b_pmdt039')
   CALL aapq132_filter_show('pmdt046','b_pmdt046')
   CALL aapq132_filter_show('pmdt037','b_pmdt037')
   CALL aapq132_filter_show('pmds037','b_pmds037')
   CALL aapq132_filter_show('pmds038','b_pmds038')
   CALL aapq132_filter_show('pmdt016','b_pmdt016')
   CALL aapq132_filter_show('pmdt017','b_pmdt017')
   CALL aapq132_filter_show('pmdt018','b_pmdt018')
   CALL aapq132_filter_show('pmdt001','b_pmdt001')
   CALL aapq132_filter_show('pmds031','b_pmds031')
   CALL aapq132_filter_show('pmds002','b_pmds002')
   CALL aapq132_filter_show('pmds045','b_pmds045')
   CALL aapq132_filter_show('pmdsstus','b_pmdsstus')
   LET g_wc= g_wc_t 
 
   CALL aapq132_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
   RETURN
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
      CONSTRUCT g_wc_filter ON pmdssite,pmdsdocno,pmds001,pmds007,pmdt036,pmds002,pmdsstus
                          FROM s_detail1[1].b_pmdssite,s_detail1[1].b_pmdsdocno,s_detail1[1].b_pmds001, 
                              s_detail1[1].b_pmds007,s_detail1[1].b_pmdt036,s_detail1[1].b_pmds002,s_detail1[1].b_pmdsstus 
 
 
         BEFORE CONSTRUCT
                     DISPLAY aapq132_filter_parser('pmdssite') TO s_detail1[1].b_pmdssite
            DISPLAY aapq132_filter_parser('pmdsdocno') TO s_detail1[1].b_pmdsdocno
            DISPLAY aapq132_filter_parser('pmds001') TO s_detail1[1].b_pmds001
            DISPLAY aapq132_filter_parser('pmds007') TO s_detail1[1].b_pmds007
            DISPLAY aapq132_filter_parser('pmdt036') TO s_detail1[1].b_pmdt036
            DISPLAY aapq132_filter_parser('pmds002') TO s_detail1[1].b_pmds002
            DISPLAY aapq132_filter_parser('pmdsstus') TO s_detail1[1].b_pmdsstus
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdssite>>----
         #Ctrlp:construct.c.filter.page1.b_pmdssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdssite
            #add-point:ON ACTION controlp INFIELD b_pmdssite name="construct.c.filter.page1.b_pmdssite"
            
            #END add-point
 
 
         #----<<b_pmdssite_desc>>----
         #----<<l_pmds000>>----
         #----<<b_pmdsdocno>>----
         #Ctrlp:construct.c.page1.b_pmdsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdsdocno
            #add-point:ON ACTION controlp INFIELD b_pmdsdocno name="construct.c.filter.page1.b_pmdsdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmds008 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmds008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmdsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdsdocno  #顯示到畫面上
            NEXT FIELD b_pmdsdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdtseq>>----
         #----<<b_pmds001>>----
         #Ctrlp:construct.c.filter.page1.b_pmds001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds001
            #add-point:ON ACTION controlp INFIELD b_pmds001 name="construct.c.filter.page1.b_pmds001"
            
            #END add-point
 
 
         #----<<b_pmds007>>----
         #Ctrlp:construct.c.page1.b_pmds007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds007
            #add-point:ON ACTION controlp INFIELD b_pmds007 name="construct.c.filter.page1.b_pmds007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#4--(S)
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            #151231-00010#4--(E)
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO b_pmds007
            NEXT FIELD b_pmds007
            #END add-point
 
 
         #----<<b_pmds007_desc>>----
         #----<<b_pmdt027>>----
         #----<<b_pmdw010>>----
         #----<<b_pmdt005>>----
         #----<<b_pmdt006>>----
         #----<<b_pmdt006_desc>>----
         #----<<b_pmdt006_desc_1>>----
         #----<<b_pmdt020>>----
         #----<<b_pmdt019>>----
         #----<<b_pmdt019_desc>>----
         #----<<b_pmdt036>>----
         #Ctrlp:construct.c.filter.page1.b_pmdt036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdt036
            #add-point:ON ACTION controlp INFIELD b_pmdt036 name="construct.c.filter.page1.b_pmdt036"
            
            #END add-point
 
 
         #----<<l_pmdt036>>----
         #----<<b_pmdt038>>----
         #----<<b_pmdt039>>----
         #----<<l_pmdt0361>>----
         #----<<l_pmdt0362>>----
         #----<<l_pmdt038>>----
         #----<<l_pmdt039>>----
         #----<<b_pmdt046>>----
         #----<<b_pmdt046_desc>>----
         #----<<b_pmdt037>>----
         #----<<b_pmds037>>----
         #----<<b_pmds038>>----
         #----<<b_pmdt016>>----
         #----<<b_pmdt016_desc>>----
         #----<<b_pmdt017>>----
         #----<<b_pmdt017_desc>>----
         #----<<b_pmdt018>>----
         #----<<b_pmdt001>>----
         #----<<b_pmds031>>----
         #----<<b_pmds031_desc>>----
         #----<<b_pmds002>>----
         #Ctrlp:construct.c.page1.b_pmds002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmds002
            #add-point:ON ACTION controlp INFIELD b_pmds002 name="construct.c.filter.page1.b_pmds002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_pmds002
            NEXT FIELD b_pmds002
            #END add-point
 
 
         #----<<b_pmds002_desc>>----
         #----<<b_pmds045>>----
         #----<<b_pmdsstus>>----
         #Ctrlp:construct.c.filter.page1.b_pmdsstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdsstus
            #add-point:ON ACTION controlp INFIELD b_pmdsstus name="construct.c.filter.page1.b_pmdsstus"
            
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
 
      CALL aapq132_filter_show('pmdssite','b_pmdssite')
   CALL aapq132_filter_show('pmdsdocno','b_pmdsdocno')
   CALL aapq132_filter_show('pmds001','b_pmds001')
   CALL aapq132_filter_show('pmds007','b_pmds007')
   CALL aapq132_filter_show('pmdt036','b_pmdt036')
   CALL aapq132_filter_show('pmds002','b_pmds002')
   CALL aapq132_filter_show('pmdsstus','b_pmdsstus')
 
 
   CALL aapq132_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq132.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aapq132_filter_parser(ps_field)
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
 
{<section id="aapq132.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq132_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq132_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aapq132.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq132_detail_action_trans()
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
 
{<section id="aapq132.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq132_detail_index_setting()
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
            IF g_pmds_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmds_d.getLength() AND g_pmds_d.getLength() > 0
            LET g_detail_idx = g_pmds_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmds_d.getLength() THEN
               LET g_detail_idx = g_pmds_d.getLength()
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
 
{<section id="aapq132.mask_functions" >}
 &include "erp/aap/aapq132_mask.4gl"
 
{</section>}
 
{<section id="aapq132.other_function" readonly="Y" >}

 
{</section>}
 
