#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq132.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2015-09-29 09:32:36), PR版次:0006(2016-11-28 14:12:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: axrq132
#+ Description: 出貨/銷退明細查詢
#+ Creator....: 02291(2015-09-29 09:32:36)
#+ Modifier...: 02291 -SD/PR- 01727
 
{</section>}
 
{<section id="axrq132.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#7   2016/02/23 By yangtt    增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite
#160518-00075#6   2016/07/18 By 01531     (依單別參數作權限管理)aooi200的控制組設定, 取7/8 設定的部門及人員
#160811-00009#2   2016/08/17 By 01531     账务中心/法人/账套权限控管
#161026-00013#1   2016/10/26 By 06821     組織類型與職能開窗調整
#161111-00049#8   2016/11/28 By 01727     控制组权限修改

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
PRIVATE TYPE type_g_xmdk_d RECORD
       
       sel LIKE type_t.chr1, 
   l_xmdksite LIKE type_t.chr500, 
   l_xmdksite_desc LIKE type_t.chr500, 
   l_xmdk000 LIKE type_t.chr500, 
   xmdk002 LIKE xmdk_t.xmdk002, 
   xmdk082 LIKE xmdk_t.xmdk082, 
   xmdk LIKE type_t.chr500, 
   xmdkdocno LIKE type_t.chr500, 
   xmdlseq LIKE type_t.chr500, 
   xmdk001 LIKE type_t.chr500, 
   xmdk008 LIKE type_t.chr500, 
   xmdk008_desc_1 LIKE type_t.chr500, 
   xmdk008_desc LIKE type_t.chr500, 
   oocml006 LIKE type_t.chr500, 
   oocil004 LIKE type_t.chr500, 
   xmdk003 LIKE type_t.chr500, 
   xmdk003_desc LIKE type_t.chr500, 
   xmdk004 LIKE type_t.chr500, 
   xmdk004_desc LIKE type_t.chr500, 
   xmdl003 LIKE type_t.chr500, 
   l_xmdl007 LIKE type_t.chr500, 
   xmdl014 LIKE type_t.chr500, 
   xmdl014_desc LIKE type_t.chr500, 
   xmdl008 LIKE type_t.chr500, 
   xmdl008_desc LIKE type_t.chr500, 
   xmdl008_desc_desc LIKE type_t.chr500, 
   imag011 LIKE type_t.chr500, 
   imag011_desc LIKE type_t.chr500, 
   xmdl021 LIKE type_t.chr500, 
   xmdl021_desc LIKE type_t.chr500, 
   xmdk016 LIKE type_t.chr500, 
   xmdk016_desc LIKE type_t.chr500, 
   xmdl026 LIKE type_t.chr500, 
   xmdl024 LIKE type_t.chr500, 
   xmdl018 LIKE type_t.chr500, 
   xmdk017 LIKE type_t.chr500, 
   xmdl027 LIKE type_t.chr500, 
   xmdl029 LIKE type_t.chr500, 
   xmdl028 LIKE type_t.chr500, 
   l_xmdl027 LIKE type_t.chr500, 
   l_xmdl029 LIKE type_t.chr500, 
   l_xmdl028 LIKE type_t.chr500, 
   l_stus LIKE type_t.chr500, 
   xmdl035 LIKE type_t.chr500, 
   xmdl036 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE   g_state    LIKE inpa_t.inpa009
DEFINE   g_xmdk000  LIKE xmdk_t.xmdk000
DEFINE   g_xmdkstus LIKE xmdk_t.xmdkstus
DEFINE   g_xmdk002  LIKE xmdk_t.xmdk002
DEFINE   g_a        LIKE type_t.chr1
DEFINE g_sql_ctrl       STRING                #151231-00010#4
DEFINE g_sql_ctr2       STRING                #160518-00075#6
DEFINE g_sql_ctr3       STRING                #160518-00075#6
DEFINE g_ooef004        LIKE ooef_t.ooef004   #160518-00075#6
DEFINE l_site_len       LIKE type_t.num5      #SITE段长度 #160518-00075#6
DEFINE l_slip_len       LIKE type_t.num5      #单别段长度 #160518-00075#6
DEFINE l_i              LIKE type_t.num5      #160518-00075#6
DEFINE l_j              LIKE type_t.num5      #160518-00075#6
DEFINE g_sql_ctrl2      STRING                #161111-00049#8 Add 料件控制组
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmdk_d            DYNAMIC ARRAY OF type_g_xmdk_d
DEFINE g_xmdk_d_t          type_g_xmdk_d
 
 
 
 
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
 
{<section id="axrq132.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#8 Add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#4(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161111-00049#8 Mark
  #161111-00049#8 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl

   LET g_sql_ctrl2 = NULL
   CALL s_control_get_item_sql('2',l_ooef017,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
  #161111-00049#8 Add  ---(E)---
   #151231-00010#4(E)
   
   #160518-00075#6 add s--- 
   #用g_site的單別參照表
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site

   CALL s_control_get_docno_sql_q(g_user,g_dept,g_ooef004) RETURNING g_sub_success,g_sql_ctr2,g_sql_ctr3 
     
   #SITE 长度
   LET l_site_len = cl_get_para(g_enterprise,g_site,'E-COM-0003')
   
   #单别长度
   LET l_slip_len = cl_get_para(g_enterprise,g_site,'E-COM-0001')
   
   #第一个分隔符
   IF cl_get_para(g_enterprise,g_site,'E-COM-0008') = '1' THEN    #据点+单别
      LET l_i = l_site_len + 2
      LET l_j = l_slip_len
   ELSE
      LET l_i = 1
      LET l_j = l_slip_len
   END IF    

   #160518-00075#6 add e---   
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
   DECLARE axrq132_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq132_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq132_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq132 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq132_init()   
 
      #進入選單 Menu (="N")
      CALL axrq132_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq132
      
   END IF 
   
   CLOSE axrq132_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq132.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq132_init()
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
   
      CALL cl_set_combo_scc('b_xmdk002','2063') 
   CALL cl_set_combo_scc('b_xmdk082','2088') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('l_xmdk000','4049')
   CALL cl_set_combo_scc('xmdk000','4049')
   CALL cl_set_combo_scc('xmdk002','2063')
   CALL cl_set_combo_scc('l_stus','13')
   CALL cl_set_combo_scc('l_state','4047')
   CALL cl_set_combo_scc_part('xmdkstus','13','N,X,Y,S,A,D,R,W,UH,H,Z')
   CALL cl_set_combo_scc('l_xmdl007','2055')
   CALL cl_set_combo_scc('xmdl007','2055')
   CALL cl_set_combo_scc('xmdk082','2088')
   #end add-point
 
   CALL axrq132_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrq132.default_search" >}
PRIVATE FUNCTION axrq132_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdkdocno = '", g_argv[01], "' AND "
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
 
{<section id="axrq132.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq132_ui_dialog() 
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
   DEFINE l_ld_str          STRING #160811-00009#2 
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#8 Add
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   #161111-00049#8 Add
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
 
   
   CALL axrq132_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmdk_d.clear()
 
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
 
         CALL axrq132_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xmdksite,xmdk002,xmdk082,xmdkdocno,xmdk001,xmdk008,xmdk003,xmdk004,xmdl003,xmdl008,imaa009,
                                   imaf111,xmdkstus,xmdl007
         
            BEFORE CONSTRUCT    

            ON ACTION controlp INFIELD xmdksite
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str #160811-00009#2 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = l_ld_str CLIPPED #160811-00009#2 
               #CALL q_ooef001_12()                      #呼叫開窗  #161026-00013#1 mark
               CALL q_ooef001_1()                      #呼叫開窗    #161026-00013#1 add
               DISPLAY g_qryparam.return1 TO xmdksite   #顯示到畫面上
               NEXT FIELD xmdksite
               
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #151231-00010#7--(S)
               LET g_qryparam.where = " xmdk008 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND xmdk008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
               #160518-00075#6 add s---            
               IF NOT cl_null(g_sql_ctr2) AND NOT cl_null(g_sql_ctr3) THEN
                  LET g_qryparam.where = g_qryparam.where," AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
               END IF
               #160518-00075#6 add e---                
               CALL q_xmdkdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上
               NEXT FIELD xmdkdocno          
       

            ON ACTION controlp INFIELD xmdk008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               #151231-00010#7--(S)
               LET g_qryparam.where = " pmac001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND pmac001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
               CALL q_pmac002_12()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk008  #顯示到畫面上
               NEXT FIELD xmdk008

            ON ACTION controlp INFIELD xmdk003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003  #顯示到畫面上
               NEXT FIELD xmdk003

            ON ACTION controlp INFIELD xmdk004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上
               NEXT FIELD xmdk004
                            
             ON ACTION controlp INFIELD xmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xmdadocno_2()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdl003  #顯示到畫面上
               NEXT FIELD xmdl003
               
             ON ACTION controlp INFIELD xmdl008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
              #CALL q_imaa001()                       #呼叫開窗   #161111-00049#8 Mark
		  	      #161111-00049#8 Add  ---(S)---
               IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where,g_sql_ctrl2," AND imafsite = '",l_ooef017,"'"
               END IF
               LET g_qryparam.arg1 = l_ooef017
               CALL q_imaf001_7()                     #呼叫開窗   
		  	      #161111-00049#8 Add  ---(E)---
               DISPLAY g_qryparam.return1 TO xmdl008  #顯示到畫面上
               NEXT FIELD xmdl008
               
             ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009               
          
             ON ACTION controlp INFIELD imaf111
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imcd111()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaf111  #顯示到畫面上
               NEXT FIELD imaf111
               
         END CONSTRUCT
         
         INPUT g_state FROM l_state
         
         END INPUT
         INPUT g_xmdk000,g_a FROM xmdk000,a
            BEFORE INPUT
               
         END INPUT 
         #end add-point
     
         DISPLAY ARRAY g_xmdk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq132_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq132_b_fill2()
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
            CALL axrq132_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_a = 'N'
            DISPLAY g_a TO a
            #end add-point
            NEXT FIELD xmdksite
 
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
            CALL axrq132_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xmdk_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axrq132_b_fill()
 
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
            CALL axrq132_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq132_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq132_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq132_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq132_filter()
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
 
{<section id="axrq132.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq132_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE  l_qty          LIKE xmdl_t.xmdl018
   DEFINE  l_pmaa027      LIKE pmaa_t.pmaa027
   DEFINE  l_oofb012      LIKE oofb_t.oofb012
   DEFINE  l_oofb014      LIKE oofb_t.oofb014
   DEFINE  l_oofb015      LIKE oofb_t.oofb015
   DEFINE  l_oofb016      LIKE oofb_t.oofb016
   DEFINE  l_count        LIKE type_t.num5
   DEFINE  l_gzcbl004     LIKE gzcbl_t.gzcbl004
   DEFINE  l_ooef004       LIKE ooef_t.ooef004  #160518-00075#6
   DEFINE  l_n1            LIKE type_t.num5     #160518-00075#6
   DEFINE  l_n2            LIKE type_t.num5     #160518-00075#6
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   DEFINE l_ld_str  STRING #160811-00009#2 
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
 
   CALL g_xmdk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #160811-00009#2  Add  ---(S)---
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"ooef001","xmdksite")
   LET g_wc = g_wc," AND ",l_ld_str
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   #160811-00009#2  Add  ---(E)---
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',xmdk002,xmdk082,'','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xmdk_t.xmdkdocno) AS RANK FROM xmdk_t", 
 
 
 
                     "",
                     " WHERE xmdkent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmdk_t"),
                     " ORDER BY xmdk_t.xmdkdocno"
 
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
 
   LET g_sql = "SELECT '','','','',xmdk002,xmdk082,'','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc = g_wc," AND xmdk008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)

   #161111-00049#8 Add  ---(S)---
   IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
      LET g_wc = g_wc," AND ",g_sql_ctrl2
   END IF
   #161111-00049#8 Add  ---(E)---

   #160518-00075#6 add s---
   LET g_sql = " SELECT ooef004 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef001 = ? "
   PREPARE axrq132_ooef_pre FROM g_sql

   LET g_sql = " SELECT COUNT(*) FROM oobc_t,ooba_t WHERE oobcent = oobaent AND oobc001 = ooba001 AND oobc002 = ooba002 ",
               "    AND oobc001 = ? AND oobc002 = substr(?,?,?) "
   PREPARE axrq132_oobc_pre1 FROM g_sql 

   LET g_sql = " SELECT COUNT(*) FROM oobc_t,ooba_t WHERE oobcent = oobaent AND oobc001 = ooba001 AND oobc002 = ooba002 ",  
               "            AND oobc001 = ? ",
               "            AND oobc002 = substr(?,?,?) ",
               "            AND (oobc003 IN (SELECT ooha001 FROM ooha_t,oohc_t WHERE oohaent = oohcent AND ooha001 = oohc001 ",
               "                                AND oohc002 = '",g_user,"' ",
               "                                AND oohastus = 'Y'",  
               "                                AND oohc003 <= '",g_today,"' AND (oohc004 IS NULL OR oohc004 > '",g_today,"') ",
               "                              UNION ",
               "                             SELECT ooha001 FROM ooha_t,oohb_t WHERE oohaent = oohbent AND ooha001 = oohb001 ",
               "                                AND oohb002 = '",g_dept,"' ",
               "                                AND oohastus = 'Y'",  
               "                                AND oohb003 <= '",g_today,"' AND (oohb004 IS NULL OR oohb004 > '",g_today,"')) ",
               "             OR ((oobc003 = '",g_user,"' AND oobc004 = '8') ",
               "             OR (oobc003 = '",g_dept,"' AND oobc004 = '7')))"
   PREPARE axrq132_oobc_pre2 FROM g_sql 
   #160518-00075#6 add e---   
   
   LET g_sql = " SELECT UNIQUE '',xmdksite,t9.ooefl003,xmdk000,xmdk002,xmdk082,'',xmdkdocno,xmdlseq,xmdk001,xmdk008,t1.pmaal004,t1.pmaal003,'','',xmdk003,t2.ooag011,xmdk004,t5.ooefl003,
                 xmdl003,xmdl007,xmdl014,t10.inayl003,xmdl008,t3.imaal003,t4.imaal004,imag011,t8.oocql004,xmdl021,t6.oocal003,xmdk016,t7.ooail003,xmdl026,xmdl024,xmdl018,xmdk017,
                 xmdl027,xmdl029,xmdl028,0,0,0,xmdkstus,xmdk035,xmdl036 FROM xmdk_t ",
               "   LEFT OUTER JOIN xmdl_t ON xmdkent = xmdlent AND xmdksite = xmdlsite AND xmdkdocno = xmdldocno ",
               "   LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND xmdl008 = imaa001 ",
               "   LEFT OUTER JOIN imag_t ON imagent = xmdlent AND imagsite = xmdlsite AND imag001 = xmdl008 " ,
               "   LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=xmdk008 AND t1.pmaal002='"||g_dlang||"' ",
               "   LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=xmdk003 ",
               "   LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xmdl008 AND t3.imaal002='"||g_dlang||"' ",
               "   LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xmdl008 AND t4.imaal002='"||g_dlang||"' ",
               "   LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=xmdk004 AND t5.ooefl002='"||g_dlang||"' ",
               "   LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=xmdl021 AND t6.oocal002='"||g_dlang||"' ",
               "   LEFT JOIN ooail_t t7 ON t7.ooailent='"||g_enterprise||"' AND t7.ooail001=xmdk016 AND t7.ooail002='"||g_dlang||"' ",
               "   LEFT JOIN oocql_t t8 ON t8.oocqlent='"||g_enterprise||"' AND t8.oocql001='206' AND t8.oocql002 = imag011 AND oocql003='"||g_dlang||"'",
               "   LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=xmdksite AND t9.ooefl002='"||g_dlang||"' ",
               "   LEFT JOIN inayl_t t10 ON t10.inaylent='"||g_enterprise||"' AND t10.inayl001=xmdl014 AND t10.inayl002='"||g_dlang||"' ",
               " WHERE xmdkent = ?  AND " ,g_wc
   #IF NOT cl_null(g_xmdkstus) THEN 
   #   LET g_sql = g_sql,"  AND xmdkstus = '",g_xmdkstus,"'"
   #END IF
   #IF NOT cl_null(g_xmdk002) THEN 
   #   LET g_sql = g_sql,"  AND xmdk002 = '",g_xmdk002,"'"
   #END IF
   IF g_xmdk000 = '1' THEN
      LET g_sql = g_sql," AND (xmdk000 = '1' OR xmdk000 = '2' OR xmdk000 = '3' ) AND xmdk002 = '1' "  
   END IF
   IF g_xmdk000 = '2' THEN
      LET g_sql = g_sql," AND xmdk000 = '6' "  
   END IF 
   #IF cl_null(g_xmdk000) THEN
   #   LET g_sql = g_sql," AND (((xmdk000 = '1' OR xmdk000 = '2' OR xmdk000 = '3') AND xmdk002 = '1') OR (xmdk000 = '6')) "
   #END IF   
   
   IF g_a = 'Y' THEN 
      LET g_sql = g_sql,"   AND xmdk000 IN ('1','2','3','6') ",             #性質不含4.出货签收单,5.出货签退单
                        "   AND ((xmdk000 <> 6 AND xmdk002 = '1') OR (xmdk000 = '6' AND xmdk082 <> 5))",  #銷退只取一般訂單及排除不立帳款者
                        "   AND xmdkstus = 'S' "  
   END IF
   LET g_sql = g_sql, "  ORDER BY xmdksite,xmdk000,xmdkdocno,xmdk001 "  

   LET l_n1 = 0               #160518-00075#6
   LET l_n2 = 0               #160518-00075#6
   LET l_ooef004 = NULL       #160518-00075#6
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq132_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq132_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmdk_d[l_ac].sel,g_xmdk_d[l_ac].l_xmdksite,g_xmdk_d[l_ac].l_xmdksite_desc, 
       g_xmdk_d[l_ac].l_xmdk000,g_xmdk_d[l_ac].xmdk002,g_xmdk_d[l_ac].xmdk082,g_xmdk_d[l_ac].xmdk,g_xmdk_d[l_ac].xmdkdocno, 
       g_xmdk_d[l_ac].xmdlseq,g_xmdk_d[l_ac].xmdk001,g_xmdk_d[l_ac].xmdk008,g_xmdk_d[l_ac].xmdk008_desc_1, 
       g_xmdk_d[l_ac].xmdk008_desc,g_xmdk_d[l_ac].oocml006,g_xmdk_d[l_ac].oocil004,g_xmdk_d[l_ac].xmdk003, 
       g_xmdk_d[l_ac].xmdk003_desc,g_xmdk_d[l_ac].xmdk004,g_xmdk_d[l_ac].xmdk004_desc,g_xmdk_d[l_ac].xmdl003, 
       g_xmdk_d[l_ac].l_xmdl007,g_xmdk_d[l_ac].xmdl014,g_xmdk_d[l_ac].xmdl014_desc,g_xmdk_d[l_ac].xmdl008, 
       g_xmdk_d[l_ac].xmdl008_desc,g_xmdk_d[l_ac].xmdl008_desc_desc,g_xmdk_d[l_ac].imag011,g_xmdk_d[l_ac].imag011_desc, 
       g_xmdk_d[l_ac].xmdl021,g_xmdk_d[l_ac].xmdl021_desc,g_xmdk_d[l_ac].xmdk016,g_xmdk_d[l_ac].xmdk016_desc, 
       g_xmdk_d[l_ac].xmdl026,g_xmdk_d[l_ac].xmdl024,g_xmdk_d[l_ac].xmdl018,g_xmdk_d[l_ac].xmdk017,g_xmdk_d[l_ac].xmdl027, 
       g_xmdk_d[l_ac].xmdl029,g_xmdk_d[l_ac].xmdl028,g_xmdk_d[l_ac].l_xmdl027,g_xmdk_d[l_ac].l_xmdl029, 
       g_xmdk_d[l_ac].l_xmdl028,g_xmdk_d[l_ac].l_stus,g_xmdk_d[l_ac].xmdl035,g_xmdk_d[l_ac].xmdl036
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160518-00075#6 add s---
      EXECUTE axrq132_ooef_pre USING g_xmdk_d[l_ac].l_xmdksite INTO l_ooef004 
      
      #检查单别是否有设置控制组，若有再继续检查 user或dept是否在該控制組內
      EXECUTE axrq132_oobc_pre1 USING l_ooef004,g_xmdk_d[l_ac].xmdkdocno,l_i,l_j INTO l_n1
      IF l_n1 != 0 THEN 
         EXECUTE axrq132_oobc_pre2 USING l_ooef004,g_xmdk_d[l_ac].xmdkdocno,l_i,l_j INTO l_n2
         IF l_n2 = 0 THEN 
            #当查询的单号都是不可查询的单别时，将默认的第一笔删除，否则始终会查询出一笔不可查询的资料
            IF g_cnt = 1 THEN 
               CALL g_xmdk_d.deleteElement(1)
            END IF          
            CONTINUE FOREACH 
         END IF
      END IF   
      #160518-00075#6 add e ---      
      
      SELECT pmaa027 INTO l_pmaa027 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_xmdk_d[l_ac].xmdk008
      SELECT oofb014,oofb016,oofb012,oofb015 INTO l_oofb014,l_oofb016,l_oofb012,l_oofb015 FROM oofb_t WHERE oofbent = g_enterprise
         AND oofb002 = l_pmaa027
         AND oofb008 = '1'
         AND oofb010 = 'Y'
      #---州省名稱
      SELECT oocil004 INTO g_xmdk_d[l_ac].oocil004
        FROM oocil_t
       WHERE oocilent = g_enterprise
         AND oocil001 = l_oofb012
         AND oocil002 = l_oofb014
         AND oocil003 = g_dlang
     
      #---行政區域名稱
      SELECT oocml006 INTO g_xmdk_d[l_ac].oocml006
        FROM oocml_t
       WHERE oocmlent = g_enterprise
         AND oocml001 = l_oofb012
         AND oocml002 = l_oofb014
         AND oocml003 = l_oofb015
         AND oocml004 = l_oofb016
         AND oocml005 = g_dlang        
                   
      LET g_xmdk_d[l_ac].l_xmdl029 = g_xmdk_d[l_ac].xmdl029 * g_xmdk_d[l_ac].xmdk017
      LET g_xmdk_d[l_ac].l_xmdl028 = g_xmdk_d[l_ac].xmdl028 * g_xmdk_d[l_ac].xmdk017
      LET g_xmdk_d[l_ac].l_xmdl027 = g_xmdk_d[l_ac].xmdl027 * g_xmdk_d[l_ac].xmdk017
#      IF g_xmdk_d[l_ac].xmdk002 = '3' THEN
#         LET l_qty = g_xmdk_d[l_ac].xmdl018 - g_xmdk_d[l_ac].xmdl035 - g_xmdk_d[l_ac].xmdl036
#         IF g_state = '1' AND l_qty <= 0 THEN  #未簽收
#            CONTINUE FOREACH
#         END IF
#         IF g_state = '2' AND l_qty > 0 THEN   #已簽收
#            CONTINUE FOREACH
#         END IF         
#      END IF 
      LET l_count = 0
      SELECT COUNT(*) INTO l_count FROM xmdk_t,xmdl_t
       WHERE xmdkent = xmdlent 
         AND xmdksite = xmdlsite
         AND xmdkdocno = xmdldocno
         AND xmdk000 = '4'
         AND xmdl001 = g_xmdk_d[l_ac].xmdkdocno
         AND xmdkstus <> 'X'
         
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF g_state = '1' AND l_count > 0 THEN
         CONTINUE FOREACH
      END IF   
      IF g_state = '2' AND l_count <= 0 THEN 
         CONTINUE FOREACH
      END IF      
      IF g_xmdk_d[l_ac].l_xmdk000 MATCHES'[123]' THEN
         LET g_xmdk_d[l_ac].l_xmdk000 = 1
      END IF
      IF g_xmdk_d[l_ac].l_xmdk000 = '6' THEN
         LET g_xmdk_d[l_ac].l_xmdk000 = 2
      END IF
      
      IF g_xmdk_d[l_ac].l_xmdk000 = 2 THEN 
         LET g_xmdk_d[l_ac].xmdl018 = g_xmdk_d[l_ac].xmdl018 * -1
         LET g_xmdk_d[l_ac].xmdl027 = g_xmdk_d[l_ac].xmdl027 * -1
         LET g_xmdk_d[l_ac].xmdl029 = g_xmdk_d[l_ac].xmdl029 * -1
         LET g_xmdk_d[l_ac].xmdl028 = g_xmdk_d[l_ac].xmdl028 * -1
         LET g_xmdk_d[l_ac].l_xmdl027 = g_xmdk_d[l_ac].l_xmdl027 * -1
         LET g_xmdk_d[l_ac].l_xmdl029 = g_xmdk_d[l_ac].l_xmdl029 * -1
         LET g_xmdk_d[l_ac].l_xmdl028 = g_xmdk_d[l_ac].l_xmdl028 * -1
      END IF
      #add by lixh 20150505
#      CALL s_num_round('1',g_xmdk_d[l_ac].l_xmdl028,2) RETURNING g_xmdk_d[l_ac].l_xmdl028 
#      CALL s_num_round('1',g_xmdk_d[l_ac].l_xmdl029,2) RETURNING g_xmdk_d[l_ac].l_xmdl029
#      CALL s_num_round('1',g_xmdk_d[l_ac].l_xmdl027,2) RETURNING g_xmdk_d[l_ac].l_xmdl027      
      #add by lixh 20150505
      LET l_gzcbl004 = ''
      IF g_xmdk_d[l_ac].l_xmdk000 = 1 THEN 
         SELECT gzcbl004 INTO l_gzcbl004 
           FROM gzcbl_t
          WHERE gzcbl001 = '2063'
            AND gzcbl002 = g_xmdk_d[l_ac].xmdk002
            AND gzcbl003 = g_dlang
         LET g_xmdk_d[l_ac].xmdk = g_xmdk_d[l_ac].xmdk002,':',l_gzcbl004
      END IF

      IF g_xmdk_d[l_ac].l_xmdk000 = 2 THEN 
         SELECT gzcbl004 INTO l_gzcbl004 
           FROM gzcbl_t
          WHERE gzcbl001 = '2088'
            AND gzcbl002 = g_xmdk_d[l_ac].xmdk082
            AND gzcbl003 = g_dlang
         LET g_xmdk_d[l_ac].xmdk = g_xmdk_d[l_ac].xmdk082,':',l_gzcbl004 
      END IF
      #end add-point
 
      CALL axrq132_detail_show("'1'")
 
      CALL axrq132_xmdk_t_mask()
 
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
 
   CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmdk_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrq132_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq132_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq132_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmdk_d.getLength() > 0 THEN
      CALL axrq132_b_fill2()
   END IF
 
      CALL axrq132_filter_show('xmdk002','b_xmdk002')
   CALL axrq132_filter_show('xmdk082','b_xmdk082')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq132.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq132_b_fill2()
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
 
{<section id="axrq132.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq132_detail_show(ps_page)
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
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq132.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrq132_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   CALL axrq132_filter1()
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
      CONSTRUCT g_wc_filter ON xmdk002,xmdk082
                          FROM s_detail1[1].b_xmdk002,s_detail1[1].b_xmdk082
 
         BEFORE CONSTRUCT
                     DISPLAY axrq132_filter_parser('xmdk002') TO s_detail1[1].b_xmdk002
            DISPLAY axrq132_filter_parser('xmdk082') TO s_detail1[1].b_xmdk082
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<l_xmdksite>>----
         #----<<l_xmdksite_desc>>----
         #----<<l_xmdk000>>----
         #----<<b_xmdk002>>----
         #Ctrlp:construct.c.page1.b_xmdk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk002
            #add-point:ON ACTION controlp INFIELD b_xmdk002 name="construct.c.filter.page1.b_xmdk002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk002  #顯示到畫面上
            NEXT FIELD b_xmdk002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdk082>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk082
            #add-point:ON ACTION controlp INFIELD b_xmdk082 name="construct.c.filter.page1.b_xmdk082"
            
            #END add-point
 
 
         #----<<b_xmdk>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk
            #add-point:ON ACTION controlp INFIELD b_xmdk name="construct.c.filter.page1.b_xmdk"
            
            #END add-point
 
 
         #----<<b_xmdkdocno>>----
         #----<<b_xmdlseq>>----
         #----<<b_xmdk001>>----
         #----<<b_xmdk008>>----
         #----<<b_xmdk008_desc_1>>----
         #----<<b_xmdk008_desc>>----
         #----<<b_oocml006>>----
         #----<<b_oocil004>>----
         #----<<b_xmdk003>>----
         #----<<b_xmdk003_desc>>----
         #----<<b_xmdk004>>----
         #----<<b_xmdk004_desc>>----
         #----<<b_xmdl003>>----
         #----<<l_xmdl007>>----
         #----<<b_xmdl014>>----
         #----<<b_xmdl014_desc>>----
         #----<<b_xmdl008>>----
         #----<<b_xmdl008_desc>>----
         #----<<b_xmdl008_desc_desc>>----
         #----<<imag011>>----
         #----<<imag011_desc>>----
         #----<<b_xmdl021>>----
         #----<<b_xmdl021_desc>>----
         #----<<b_xmdk016>>----
         #----<<b_xmdk016_desc>>----
         #----<<b_xmdl026>>----
         #----<<b_xmdl024>>----
         #----<<b_xmdl018>>----
         #----<<b_xmdk017>>----
         #----<<b_xmdl027>>----
         #----<<b_xmdl029>>----
         #----<<b_xmdl028>>----
         #----<<l_xmdl027>>----
         #----<<l_xmdl029>>----
         #----<<l_xmdl028>>----
         #----<<l_stus>>----
         #----<<xmdl035>>----
         #----<<xmdl036>>----
 
 
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
 
      CALL axrq132_filter_show('xmdk002','b_xmdk002')
   CALL axrq132_filter_show('xmdk082','b_xmdk082')
 
 
   CALL axrq132_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq132.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrq132_filter_parser(ps_field)
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
 
{<section id="axrq132.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq132_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq132_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrq132.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq132_detail_action_trans()
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
 
{<section id="axrq132.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq132_detail_index_setting()
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
            IF g_xmdk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmdk_d.getLength() AND g_xmdk_d.getLength() > 0
            LET g_detail_idx = g_xmdk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmdk_d.getLength() THEN
               LET g_detail_idx = g_xmdk_d.getLength()
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
 
{<section id="axrq132.mask_functions" >}
 &include "erp/axr/axrq132_mask.4gl"
 
{</section>}
 
{<section id="axrq132.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq132_filter1()
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#8 Add

   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site   #161111-00049#8 Add
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:4)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xmdk002,xmdk082,xmdkdocno,xmdlseq,xmdk001,xmdk008,oocml006,oocil004,xmdk003, 
          xmdk004,xmdl003,xmdl014,xmdl008,xmdl021,xmdk016,xmdl026,xmdl024,xmdl018,xmdk017,xmdl027,xmdl029, 
          xmdl028
                          FROM s_detail1[1].b_xmdk002,s_detail1[1].b_xmdk082,s_detail1[1].b_xmdkdocno, 
                              s_detail1[1].b_xmdlseq,s_detail1[1].b_xmdk001,s_detail1[1].b_xmdk008,s_detail1[1].b_oocml006, 
                              s_detail1[1].b_oocil004,s_detail1[1].b_xmdk003,s_detail1[1].b_xmdk004, 
                              s_detail1[1].b_xmdl003,s_detail1[1].b_xmdl014,s_detail1[1].b_xmdl008,s_detail1[1].b_xmdl021, 
                              s_detail1[1].b_xmdk016,s_detail1[1].b_xmdl026,s_detail1[1].b_xmdl024,s_detail1[1].b_xmdl018, 
                              s_detail1[1].b_xmdk017,s_detail1[1].b_xmdl027,s_detail1[1].b_xmdl029,s_detail1[1].b_xmdl028 

 
         BEFORE CONSTRUCT
                     DISPLAY axrq132_filter_parser('xmdk002') TO s_detail1[1].b_xmdk002
            DISPLAY axrq132_filter_parser('xmdk082') TO s_detail1[1].b_xmdk082
            DISPLAY axrq132_filter_parser('xmdkdocno') TO s_detail1[1].b_xmdkdocno
            DISPLAY axrq132_filter_parser('xmdlseq') TO s_detail1[1].b_xmdlseq
            DISPLAY axrq132_filter_parser('xmdk001') TO s_detail1[1].b_xmdk001
            DISPLAY axrq132_filter_parser('xmdk008') TO s_detail1[1].b_xmdk008
            DISPLAY axrq132_filter_parser('oocml006') TO s_detail1[1].b_oocml006
            DISPLAY axrq132_filter_parser('oocil004') TO s_detail1[1].b_oocil004
            DISPLAY axrq132_filter_parser('xmdk003') TO s_detail1[1].b_xmdk003
            DISPLAY axrq132_filter_parser('xmdk004') TO s_detail1[1].b_xmdk004
            DISPLAY axrq132_filter_parser('xmdl003') TO s_detail1[1].b_xmdl003
            DISPLAY axrq132_filter_parser('xmdl014') TO s_detail1[1].b_xmdl014
            DISPLAY axrq132_filter_parser('xmdl008') TO s_detail1[1].b_xmdl008
            DISPLAY axrq132_filter_parser('xmdl021') TO s_detail1[1].b_xmdl021
            DISPLAY axrq132_filter_parser('xmdk016') TO s_detail1[1].b_xmdk016
            DISPLAY axrq132_filter_parser('xmdl026') TO s_detail1[1].b_xmdl026
            DISPLAY axrq132_filter_parser('xmdl024') TO s_detail1[1].b_xmdl024
            DISPLAY axrq132_filter_parser('xmdl018') TO s_detail1[1].b_xmdl018
            DISPLAY axrq132_filter_parser('xmdk017') TO s_detail1[1].b_xmdk017
            DISPLAY axrq132_filter_parser('xmdl027') TO s_detail1[1].b_xmdl027
            DISPLAY axrq132_filter_parser('xmdl029') TO s_detail1[1].b_xmdl029
            DISPLAY axrq132_filter_parser('xmdl028') TO s_detail1[1].b_xmdl028
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<l_xmdksite>>----
         #----<<l_xmdksite_desc>>----
         #----<<l_xmdk000>>----
         #----<<b_xmdk002>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk002
            #add-point:ON ACTION controlp INFIELD b_xmdk002

            #END add-point
 
         #----<<b_xmdk082>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk082
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk082
            #add-point:ON ACTION controlp INFIELD b_xmdk082

            #END add-point
 
         #----<<b_xmdk>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk
            #add-point:ON ACTION controlp INFIELD b_xmdk

            #END add-point
 
         #----<<b_xmdkdocno>>----
         #Ctrlp:construct.c.page1.b_xmdkdocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdkdocno
            #add-point:ON ACTION controlp INFIELD b_xmdkdocno
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161111-00049#8 Add  ---(S)---
            LET g_qryparam.where = " xmdk008 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND xmdk008 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF        
            IF NOT cl_null(g_sql_ctr2) AND NOT cl_null(g_sql_ctr3) THEN
               LET g_qryparam.where = g_qryparam.where," AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
            END IF
            #161111-00049#8 Add  ---(E)---
            CALL q_xmdkdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdkdocno  #顯示到畫面上
            NEXT FIELD b_xmdkdocno                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdlseq>>----
         #Ctrlp:construct.c.filter.page1.b_xmdlseq
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdlseq
            #add-point:ON ACTION controlp INFIELD b_xmdlseq

            #END add-point
 
         #----<<b_xmdk001>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk001
            #add-point:ON ACTION controlp INFIELD b_xmdk001

            #END add-point
 
         #----<<b_xmdk008>>----
         #Ctrlp:construct.c.page1.b_xmdk008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk008
            #add-point:ON ACTION controlp INFIELD b_xmdk008
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
           #CALL q_pmac002()                           #呼叫開窗   #161111-00049#8 Mark
           #161111-00049#8 Add  ---(S)---
            LET g_qryparam.arg2 = g_site
            LET g_qryparam.where = " pmac001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                   " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND pmac001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            CALL q_pmac002_12()                       #呼叫開窗
           #161111-00049#8 Add  ---(E)---
            DISPLAY g_qryparam.return1 TO b_xmdk008  #顯示到畫面上
            NEXT FIELD b_xmdk008                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdk008_desc_1>>----
         #----<<b_xmdk008_desc>>----
         #----<<b_oocml006>>----
         #Ctrlp:construct.c.filter.page1.b_oocml006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_oocml006
            #add-point:ON ACTION controlp INFIELD b_oocml006

            #END add-point
 
         #----<<b_oocil004>>----
         #Ctrlp:construct.c.filter.page1.b_oocil004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_oocil004
            #add-point:ON ACTION controlp INFIELD b_oocil004

            #END add-point
 
         #----<<b_xmdk003>>----
         #Ctrlp:construct.c.page1.b_xmdk003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk003
            #add-point:ON ACTION controlp INFIELD b_xmdk003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk003  #顯示到畫面上
            NEXT FIELD b_xmdk003                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdk003_desc>>----
         #----<<b_xmdk004>>----
         #Ctrlp:construct.c.page1.b_xmdk004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk004
            #add-point:ON ACTION controlp INFIELD b_xmdk004
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk004  #顯示到畫面上
            NEXT FIELD b_xmdk004                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdk004_desc>>----
         #----<<b_xmdl003>>----
         #Ctrlp:construct.c.page1.b_xmdl003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl003
            #add-point:ON ACTION controlp INFIELD b_xmdl003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl003  #顯示到畫面上
            NEXT FIELD b_xmdl003                     #返回原欄位
    


            #END add-point
 
         #----<<l_xmdl007>>----
         #----<<b_xmdl014>>----
         #Ctrlp:construct.c.page1.b_xmdl014
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl014
            #add-point:ON ACTION controlp INFIELD b_xmdl014
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl014  #顯示到畫面上
            NEXT FIELD b_xmdl014                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdl014_desc>>----
         #----<<b_xmdl008>>----
         #Ctrlp:construct.c.page1.b_xmdl008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl008
            #add-point:ON ACTION controlp INFIELD b_xmdl008
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
           #CALL q_imaa001()                       #呼叫開窗   #161111-00049#8 Mark
		  	   #161111-00049#8 Add  ---(S)---
            IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where,g_sql_ctrl2," AND imafsite = '",l_ooef017,"'"
            END IF
            LET g_qryparam.arg1 = l_ooef017
            CALL q_imaf001_7()                     #呼叫開窗   
		  	   #161111-00049#8 Add  ---(E)---
            DISPLAY g_qryparam.return1 TO b_xmdl008  #顯示到畫面上
            NEXT FIELD b_xmdl008                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdl008_desc>>----
         #----<<b_xmdl008_desc_desc>>----
         #----<<imag011>>----
         #----<<imag011_desc>>----
         #----<<b_xmdl021>>----
         #Ctrlp:construct.c.page1.b_xmdl021
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl021
            #add-point:ON ACTION controlp INFIELD b_xmdl021
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl021  #顯示到畫面上
            NEXT FIELD b_xmdl021                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdl021_desc>>----
         #----<<b_xmdk016>>----
         #Ctrlp:construct.c.page1.b_xmdk016
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk016
            #add-point:ON ACTION controlp INFIELD b_xmdk016
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk016  #顯示到畫面上
            NEXT FIELD b_xmdk016                     #返回原欄位
    


            #END add-point
 
         #----<<b_xmdk016_desc>>----
         #----<<b_xmdl026>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl026
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl026
            #add-point:ON ACTION controlp INFIELD b_xmdl026

            #END add-point
 
         #----<<b_xmdl024>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl024
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl024
            #add-point:ON ACTION controlp INFIELD b_xmdl024

            #END add-point
 
         #----<<b_xmdl018>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl018
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl018
            #add-point:ON ACTION controlp INFIELD b_xmdl018

            #END add-point
 
         #----<<b_xmdk017>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk017
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdk017
            #add-point:ON ACTION controlp INFIELD b_xmdk017

            #END add-point
 
         #----<<b_xmdl027>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl027
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl027
            #add-point:ON ACTION controlp INFIELD b_xmdl027

            #END add-point
 
         #----<<b_xmdl029>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl029
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl029
            #add-point:ON ACTION controlp INFIELD b_xmdl029

            #END add-point
 
         #----<<b_xmdl028>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl028
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_xmdl028
            #add-point:ON ACTION controlp INFIELD b_xmdl028

            #END add-point
 
         #----<<l_xmdl027>>----
         #----<<l_xmdl029>>----
         #----<<l_xmdl028>>----
         #----<<l_stus>>----
         #----<<xmdl035>>----
         #----<<xmdl036>>----
 
 
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
 
      CALL axrq132_filter_show('xmdk002','b_xmdk002')
   CALL axrq132_filter_show('xmdk082','b_xmdk082')
   CALL axrq132_filter_show('xmdkdocno','b_xmdkdocno')
   CALL axrq132_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq132_filter_show('xmdk001','b_xmdk001')
   CALL axrq132_filter_show('xmdk008','b_xmdk008')
   CALL axrq132_filter_show('oocml006','b_oocml006')
   CALL axrq132_filter_show('oocil004','b_oocil004')
   CALL axrq132_filter_show('xmdk003','b_xmdk003')
   CALL axrq132_filter_show('xmdk004','b_xmdk004')
   CALL axrq132_filter_show('xmdl003','b_xmdl003')
   CALL axrq132_filter_show('xmdl014','b_xmdl014')
   CALL axrq132_filter_show('xmdl008','b_xmdl008')
   CALL axrq132_filter_show('xmdl021','b_xmdl021')
   CALL axrq132_filter_show('xmdk016','b_xmdk016')
   CALL axrq132_filter_show('xmdl026','b_xmdl026')
   CALL axrq132_filter_show('xmdl024','b_xmdl024')
   CALL axrq132_filter_show('xmdl018','b_xmdl018')
   CALL axrq132_filter_show('xmdk017','b_xmdk017')
   CALL axrq132_filter_show('xmdl027','b_xmdl027')
   CALL axrq132_filter_show('xmdl029','b_xmdl029')
   CALL axrq132_filter_show('xmdl028','b_xmdl028')
 
 
   CALL axrq132_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
END FUNCTION

 
{</section>}
 
