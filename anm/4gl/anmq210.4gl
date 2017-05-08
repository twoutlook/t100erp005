#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq210.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:17(2016-04-01 16:36:06), PR版次:0017(2016-12-02 16:41:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000110
#+ Filename...: anmq210
#+ Description: 銀行交易明細查詢作業
#+ Creator....: 04152(2014-07-30 14:37:40)
#+ Modifier...: 07673 -SD/PR- 01531
 
{</section>}
 
{<section id="anmq210.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150616-00026#7  2015/06/17 By apo      第一單身切換時,當下的交易帳戶編碼每次都需重新組進sql
#150626-00011#1  2015/06/26 By Reanna   增加取位
#150817-00025#1  2015/08/18 By Reanna   增加主帳套匯率
#150818-00032#3  2015/08/20 By RayHuang 增加 入帳匯率、平均匯率、支票號碼、收支對象,並增加XG列印的功能
#151015-00007#1  2015/10/15 by 03538    加上ENT條件
#151013-00019#6  2015/10/20 By Reanna   修正XG列印無出現帳戶編號
#151103-00010#2  2015/11/04 By Jessy    1.對象NMBC003=’EMPL’情形時,則改取nmbc004 識別碼內的資料,說明也改取”員工姓名”顯示 2. 報表輸出時, 亦同修改
#151105-00001#6  2015/11/10 By Jessy    交易帳戶後方加上帳戶名稱,xg呈現也要
#151013-00019#11 2015/11/19 By Reanna   第二單身排序日期+單號+項次
#151127-00002#4  2015/12/16 By sakura   XG列印時，單頭增加增加日期顯示
#160122-00001#24 2016/02/15 By yangtt   添加交易帳戶編號用戶權限空管   
#160203-00009#1  2016/02/25 By 02097    提供aapt420可查詢
#160122-00001#24 2016/03/17 By 07900    添加交易帳戶編號用戶權限空管，增加部门权限
#160322-00025#13 2016/04/01 By 07673    添加来源组织栏位
#160822-00018#1  2016/08/22 By Reanna   調整匯率取位問題，應用原幣幣別取位
#160816-00012#4  2016/09/06 By 07900    ANM增加资金中心，帐套，法人三个栏位权限
#161110-00001#1  2016/11/28 By 07900    ANM模組使用ooea_t/ooeaf_t的需替換ooef_t/ooefl_t
#161130-00049#1  2016/12/02 By 01531    q_nmaa001開窗增加權限
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
PRIVATE TYPE type_g_nmaa_d RECORD
       
       sel LIKE type_t.chr1, 
   nmaa001 LIKE nmaa_t.nmaa001, 
   nmaa002 LIKE nmaa_t.nmaa002, 
   nmaa002_desc LIKE type_t.chr500, 
   nmaa003 LIKE nmaa_t.nmaa003, 
   nmaa003_desc LIKE type_t.chr500, 
   nmas002 LIKE nmas_t.nmas002, 
   nmas002_desc LIKE type_t.chr500, 
   nmas003 LIKE nmas_t.nmas003, 
   nmbcorga LIKE nmbc_t.nmbcorga
       END RECORD
PRIVATE TYPE type_g_nmaa2_d RECORD
       nmbc005 LIKE nmbc_t.nmbc005, 
   nmbcdocno LIKE nmbc_t.nmbcdocno, 
   prog_nmbcdocno STRING, 
   nmbcseq LIKE nmbc_t.nmbcseq, 
   nmbc006 LIKE nmbc_t.nmbc006, 
   nmbc007 LIKE nmbc_t.nmbc007, 
   l_nmbc007_desc LIKE type_t.chr500, 
   nmbc003 LIKE nmbc_t.nmbc003, 
   l_nmbc003_desc LIKE type_t.chr500, 
   nmbc012 LIKE nmbc_t.nmbc012, 
   nmbc013 LIKE nmbc_t.nmbc013, 
   l_average LIKE type_t.num26_10, 
   nmbc101 LIKE type_t.chr500, 
   nmbc103 LIKE nmbc_t.nmbc103, 
   l_nmbc1031 LIKE type_t.num20_6, 
   nmbc113 LIKE nmbc_t.nmbc113, 
   l_nmbc1131 LIKE type_t.num20_6, 
   nmbc011 LIKE nmbc_t.nmbc011, 
   nmbc010 LIKE nmbc_t.nmbc010
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc3                 STRING
DEFINE g_nmbc005_desc        LIKE type_t.chr500   #151127-00002#4
DEFINE g_sql_bank            STRING               #160122-00001#24 By 07900 --add
DEFINE g_wc_oraga            STRING               #160322-00025#13
#end add-point
 
#模組變數(Module Variables)
DEFINE g_nmaa_d            DYNAMIC ARRAY OF type_g_nmaa_d
DEFINE g_nmaa_d_t          type_g_nmaa_d
DEFINE g_nmaa2_d     DYNAMIC ARRAY OF type_g_nmaa2_d
DEFINE g_nmaa2_d_t   type_g_nmaa2_d
 
 
 
 
 
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmq210.main" >}
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
   DECLARE anmq210_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq210_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq210_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq210 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq210_init()   
 
      #進入選單 Menu (="N")
      CALL anmq210_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq210
      
   END IF 
   
   CLOSE anmq210_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq210.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq210_init()
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
   CALL cl_set_combo_scc_part('b_nmbc006','8701','1,2')
   CALL anmq210_create_tmp()                           #150818-00032#3
   #160122-00001#24 By 07900 --add--str
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank   
   #160122-00001#24 By 07900 --add--end
   #end add-point
 
   CALL anmq210_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq210.default_search" >}
PRIVATE FUNCTION anmq210_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmaa001 = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   #160203-00009#1--(S)
   IF g_argv[3] = '1' THEN
      LET g_wc3 = " nmbc005=TO_DATE('",g_argv[2]," 00:00:00','YYYY/MM/DD HH24:MI:SS')"      
   END IF
   #160203-00009#1--(E)     
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq210_ui_dialog() 
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
   DEFINE l_wc       STRING   #160816-00012#4 Add
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
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_nmbcdocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_nmbcdocno', FALSE) 
 
  
 
 
 
   CALL anmq210_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmaa_d.clear()
         CALL g_nmaa2_d.clear()
 
 
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
 
         CALL anmq210_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON nmaa001,nmaa002,nmas003,nmaa003 

            ON ACTION controlp INFIELD nmaa001 #帳戶編碼
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")" #161130-00049#1 add
               #CALL q_nmaa001()      #161130-00049#1 mark
               CALL q_nmaa001_03()    #161130-00049#1 add
               DISPLAY g_qryparam.return1 TO nmaa001
               NEXT FIELD nmaa001
               
            ON ACTION controlp INFIELD nmaa002 #開戶人（組織）
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160816-00012#3 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
               LET l_wc = cl_replace_str(l_wc,"ooef001","ooed004")
               LET g_qryparam.where = l_wc CLIPPED
               #160816-00012#3 Add  ---(E)---
               CALL q_ooed004_8()
               DISPLAY g_qryparam.return1 TO nmaa002
               NEXT FIELD nmaa002
         
            ON ACTION controlp INFIELD nmas003 #幣別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()
               DISPLAY g_qryparam.return1 TO nmas003
               NEXT FIELD nmas003

            ON ACTION controlp INFIELD nmaa003 #帳戶類型
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_nmag001()
               DISPLAY g_qryparam.return1 TO nmaa003
               NEXT FIELD nmaa003
                  
         END CONSTRUCT
         #160322-00025#13 add -str
         CONSTRUCT BY NAME g_wc_oraga ON nmbcorga 
            ON ACTION controlp INFIELD nmbcorga
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               #160816-00012#3 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
               LET l_wc = cl_replace_str(l_wc,"ooef001","nmbcorga")
               LET g_qryparam.where = l_wc CLIPPED
               #160816-00012#3 Add  ---(E)---
               CALL q_nmbcorga_02()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmbcorga  #顯示到畫面上
               NEXT FIELD nmbcorga            
         END CONSTRUCT
         #160322-00025#13 add -end
         CONSTRUCT BY NAME g_wc3 ON nmbc005
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_nmaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq210_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq210_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_nmaa2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               CALL anmq210_b_fill2()
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page2_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_anmt310
                  LET g_action_choice="prog_anmt310"
                  IF cl_auth_chk_act("prog_anmt310") THEN
                     
                     #add-point:ON ACTION prog_anmt310 name="menu.detail_show.page2_sub.prog_anmt310"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'anmt310'
               LET la_param.param[1] = g_nmaa2_d[g_detail_idx2].nmbcdocno

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page2.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq210_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            #160203-00009#1--(S)
            IF g_argv[3] = '1' THEN
               DISPLAY g_argv[1] TO nmaa001
               DISPLAY g_argv[2] TO nmbc005
            END IF
            #160203-00009#1--(E)  
            #end add-point
            NEXT FIELD nmaa001
 
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
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            LET g_nmbc005_desc = GET_FLDBUF(nmbc005)
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL anmq210_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_nmaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_nmaa2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq210_b_fill()
 
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
            CALL anmq210_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq210_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq210_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq210_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               LET g_nmaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               LET g_nmaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq210_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)   #150629
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #150818-00032#3
               #150818-00032#3-----s
               CALL anmq210_insert_tmp()
               CALL anmq210_x01(" 1 = 1","anmq210_x01_tmp")
               #150818-00032#3-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150818-00032#3
               #150818-00032#3-----s
               CALL anmq210_insert_tmp()
               CALL anmq210_x01(" 1 = 1","anmq210_x01_tmp")
               #150818-00032#3-----e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
              #CALL anmq210_query()
               CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
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
 
{<section id="anmq210.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq210_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_wc1       STRING   #160816-00012#4 Add
   DEFINE l_wc2       STRING   #160816-00012#4 Add
   DEFINE l_wc        STRING   #160816-00012#4 Add
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
 
   CALL g_nmaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = g_wc, " AND ", g_wc_filter
   #160816-00012#3 Add  ---(S)---
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
   LET l_wc1 = cl_replace_str(l_wc,"ooef001","nmaa002")
   LET l_wc2 = cl_replace_str(l_wc,"ooef001","nmbcorga")
   LET ls_wc = ls_wc," AND ", l_wc1
   #160816-00012#3 Add  ---(E)---
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',nmaa001,nmaa002,'',nmaa003,'','','','',''  ,DENSE_RANK() OVER( ORDER BY nmaa_t.nmaa001) AS RANK FROM nmaa_t", 
 
 
#table2
                     " LEFT JOIN nmbc_t ON nmbcent = nmaaent AND nmaa001 = nmbc002",
 
                     "",
                     " WHERE nmaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmaa_t"),
                     " ORDER BY nmaa_t.nmaa001"
 
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
 
   LET g_sql = "SELECT '',nmaa001,nmaa002,'',nmaa003,'','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #因還要串nmas_t所以重寫SQL by Reanna 140801
    #160322-00025#13 -add -str   
    IF cl_null(g_wc_oraga) OR g_wc_oraga = ' 1=1'  THEN
       LET g_sql = "SELECT UNIQUE '',nmaa001,nmaa002,'',nmaa003,'',nmas002,'',nmas003",
                  "  FROM nmaa_t",
                  "  INNER JOIN nmas_t ON nmaaent = nmasent AND nmaa001 = nmas001",
                  " WHERE nmaaent= ? AND ", ls_wc
                  #160122-00001#24--add---str
                  ," AND (nmas002 IN(",g_sql_bank,")
                         OR TRIM(nmas002) IS NULL)"     #160122-00001#24 By 07900--mod
                  #160122-00001#24--add---end
        LET g_sql = g_sql, cl_sql_add_filter("nmaa_t"),
                         " ORDER BY nmaa_t.nmaa001"
    ELSE 

         LET g_sql = "SELECT UNIQUE '',nmaa001,nmaa002,'',nmaa003,'',nmas002,'',nmas003,nmbcorga", 
                    "  FROM nmaa_t",
                    "  INNER JOIN nmas_t ON nmaaent = nmasent AND nmaa001 = nmas001",
                    "  LEFT  JOIN nmbc_t  ON nmaaent = nmbcent AND nmbc002=nmaa001 ",  
                    " WHERE nmaaent= ? AND ", ls_wc," AND ",g_wc_oraga
                    #160122-00001#24--add---str
                    ," AND (nmas002 IN(",g_sql_bank,")
                           OR TRIM(nmas002) IS NULL)"     #160122-00001#24 By 07900--mod
                    #160122-00001#24--add---end
                    #160816-00012#3 Add  ---(S)---
                    ," AND ",l_wc2
                    #160816-00012#3 Add  ---(S)---
         LET g_sql = g_sql, cl_sql_add_filter("nmaa_t"),
                           " ORDER BY nmaa_t.nmaa001"    
    END IF
    #160322-00025#13 -add -end 
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq210_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq210_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_nmaa_d[l_ac].sel,g_nmaa_d[l_ac].nmaa001,g_nmaa_d[l_ac].nmaa002,g_nmaa_d[l_ac].nmaa002_desc, 
       g_nmaa_d[l_ac].nmaa003,g_nmaa_d[l_ac].nmaa003_desc,g_nmaa_d[l_ac].nmas002,g_nmaa_d[l_ac].nmas002_desc, 
       g_nmaa_d[l_ac].nmas003,g_nmaa_d[l_ac].nmbcorga
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_nmaa_d[l_ac].nmas002_desc = s_desc_get_nmas002_desc(g_nmaa_d[l_ac].nmas002)   #151105-00001#6
      #end add-point
 
      CALL anmq210_detail_show("'1'")
 
      CALL anmq210_nmaa_t_mask()
 
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
 
   CALL g_nmaa_d.deleteElement(g_nmaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_nmaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmq210_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq210_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq210_detail_action_trans()
 
   LET l_ac = 1
   IF g_nmaa_d.getLength() > 0 THEN
      CALL anmq210_b_fill2()
   END IF
 
      CALL anmq210_filter_show('nmaa001','b_nmaa001')
   CALL anmq210_filter_show('nmaa002','b_nmaa002')
   CALL anmq210_filter_show('nmaa003','b_nmaa003')
   CALL anmq210_filter_show('nmas002','b_nmas002')
   CALL anmq210_filter_show('nmas003','b_nmas003')
   CALL anmq210_filter_show('nmbcorga','b_nmbcorga')
   CALL anmq210_filter_show('nmbc005','b_nmbc005')
   CALL anmq210_filter_show('nmbcdocno','b_nmbcdocno')
   CALL anmq210_filter_show('nmbcseq','b_nmbcseq')
   CALL anmq210_filter_show('nmbc006','b_nmbc006')
   CALL anmq210_filter_show('nmbc007','b_nmbc007')
   CALL anmq210_filter_show('nmbc003','b_nmbc003')
   CALL anmq210_filter_show('nmbc012','b_nmbc012')
   CALL anmq210_filter_show('nmbc013','b_nmbc013')
   CALL anmq210_filter_show('nmbc103','b_nmbc103')
   CALL anmq210_filter_show('nmbc113','b_nmbc113')
   CALL anmq210_filter_show('nmbc011','b_nmbc011')
   CALL anmq210_filter_show('nmbc010','b_nmbc010')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq210_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_nmbx1031      LIKE nmbx_t.nmbx103   #上期餘額(原幣)
   DEFINE l_nmbx1032      LIKE nmbx_t.nmbx103   #本期異動(原幣)
   DEFINE l_nmbx1131      LIKE nmbx_t.nmbx113   #上期餘額(本幣)
   DEFINE l_nmbx1132      LIKE nmbx_t.nmbx113   #本期異動(本幣)
   DEFINE l_yy            LIKE type_t.num5      #取得該日期年
   DEFINE l_mm            LIKE type_t.num5      #取得該日期月
   DEFINE l_strdt         LIKE type_t.dat       #取得該日期之該月第一天
   DEFINE l_enddt         LIKE type_t.dat       #取得該日期之前一天
   DEFINE l_action_choice STRING                #150616-00026#7
   DEFINE l_ld            LIKE glaa_t.glaald    #150626-00011#1
   DEFINE l_glaa001       LIKE glaa_t.glaa001   #150626-00011#1
   DEFINE l_nmbc004       LIKE nmbc_t.nmbc004   #151103-00010#2
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_nmaa2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   #150616-00026#7--(s)
   #為了讓單身一切換時,依單身一的nmas002切換單身二資料,因此特別處理每次都要組SQL
   IF g_action_choice = 'fetch' THEN
      LET l_action_choice = g_action_choice
      LET g_action_choice = 'xxx'
   END IF
   #150616-00026#7--(e)
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE nmbc005,nmbcdocno,nmbcseq,nmbc006,nmbc007,'',nmbc003,'',nmbc012,nmbc013, 
          '','',nmbc103,'',nmbc113,'',nmbc011,nmbc010 FROM nmbc_t",
                  "",
                  " WHERE"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY nmbc_t.nmbc002"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      #150616-00026#7--(s)
      IF g_action_choice = 'xxx' THEN
         LET g_action_choice = l_action_choice
      END IF
      #150616-00026#7--(e) 
      #150626-00011#1 add ------
      #撈取該組織的主帳套
      LET l_ld = ""
      SELECT glaald,glaa001 INTO l_ld,l_glaa001
        FROM glaa_t
        LEFT JOIN ooef_t ON glaaent = ooefent AND glaacomp = ooef017
       WHERE glaaent = g_enterprise
         AND ooef001 = g_nmaa_d[g_detail_idx].nmaa002
         AND glaa014 = 'Y'
      #150626-00011#1 add end---
      #因SQL不需串nmbccomp、nmbcdocno、nmbcseq所以重寫SQL by Reanna 140801
      #150626-00011#1 add nmbc101
      LET g_sql = "SELECT UNIQUE nmbc005,nmbcdocno,nmbcseq,nmbc006,nmbc007,'', ",
                  "              nmbc003,'',nmbc012,nmbc013,'',nmbc101,nmbc103,'',nmbc113,",
                  "              '',nmbc011,nmbc010",
                  "  FROM nmbc_t,nmas_t",
                  " WHERE nmasent = nmbcent AND nmas002 = nmbc002 ",
                  "   AND nmbcent=? AND nmas001=? ",
                  "   AND nmbc002 = '",g_nmaa_d[g_detail_idx].nmas002,"' AND nmbc100 = '",g_nmaa_d[g_detail_idx].nmas003,"'"
      #160322-00025#13 add -str
      IF NOT (cl_null(g_wc_oraga) OR  g_wc_oraga =' 1=1')THEN
         LET g_sql = g_sql CLIPPED," AND  nmbcorga = '",g_nmaa_d[g_detail_idx].nmbcorga,"'"
      END IF 
      #160322-00025#13 add -end      
      IF NOT cl_null(g_wc3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc3 CLIPPED
      END IF
     #LET g_sql = g_sql, " ORDER BY nmbc_t.nmbc005"                                  #151013-00019#11 mark
      LET g_sql = g_sql, " ORDER BY nmbc_t.nmbc005,nmbc_t.nmbcdocno,nmbc_t.nmbcseq"  #151013-00019#11
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE anmq210_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR anmq210_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_nmaa_d[g_detail_idx].nmaa001
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_nmaa_d[g_detail_idx].nmaa001
 
      INTO g_nmaa2_d[l_ac].nmbc005,g_nmaa2_d[l_ac].nmbcdocno,g_nmaa2_d[l_ac].nmbcseq,g_nmaa2_d[l_ac].nmbc006, 
          g_nmaa2_d[l_ac].nmbc007,g_nmaa2_d[l_ac].l_nmbc007_desc,g_nmaa2_d[l_ac].nmbc003,g_nmaa2_d[l_ac].l_nmbc003_desc, 
          g_nmaa2_d[l_ac].nmbc012,g_nmaa2_d[l_ac].nmbc013,g_nmaa2_d[l_ac].l_average,g_nmaa2_d[l_ac].nmbc101, 
          g_nmaa2_d[l_ac].nmbc103,g_nmaa2_d[l_ac].l_nmbc1031,g_nmaa2_d[l_ac].nmbc113,g_nmaa2_d[l_ac].l_nmbc1131, 
          g_nmaa2_d[l_ac].nmbc011,g_nmaa2_d[l_ac].nmbc010
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = anmq210_get_hyper_data("prog_nmbcdocno")
         LET g_nmaa2_d[l_ac].prog_nmbcdocno = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_nmaa2_d[l_ac].nmbcdocno), 
             "</a>"
 
      ELSE 
         LET g_nmaa2_d[l_ac].prog_nmbcdocno = g_nmaa2_d[l_ac].nmbcdocno
 
      END IF 
 
 
 
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      LET g_nmaa2_d[l_ac].l_nmbc003_desc = s_desc_get_trading_partner_full_desc(g_nmaa2_d[l_ac].nmbc003)
      
      #151103-00010#2---s
      IF g_nmaa2_d[l_ac].nmbc003 = 'EMPL' THEN 
         LET l_nmbc004 = ''
         #160322-00025#13 -add -str
         IF cl_null(g_wc_oraga) OR g_wc_oraga = ' 1=1'  THEN
            SELECT nmbc004 INTO l_nmbc004 FROM nmbc_t
             WHERE nmbcent = g_enterprise
               AND nmbc002 = g_nmaa_d[g_detail_idx].nmas002 
               AND nmbc100 = g_nmaa_d[g_detail_idx].nmas003
               AND nmbcdocno = g_nmaa2_d[l_ac].nmbcdocno AND nmbcseq = g_nmaa2_d[l_ac].nmbcseq
         ELSE
            SELECT nmbc004 INTO l_nmbc004 FROM nmbc_t
             WHERE nmbcent = g_enterprise
               AND nmbc002 = g_nmaa_d[g_detail_idx].nmas002 
               AND nmbc100 = g_nmaa_d[g_detail_idx].nmas003
               AND nmbcorga = g_nmaa_d[g_detail_idx].nmbcorga  
               AND nmbcdocno = g_nmaa2_d[l_ac].nmbcdocno AND nmbcseq = g_nmaa2_d[l_ac].nmbcseq
         END IF 
         #160322-00025#13 -add -end
         
         LET g_nmaa2_d[l_ac].nmbc003 = l_nmbc004
         LET g_nmaa2_d[l_ac].l_nmbc003_desc = s_desc_get_person_desc(g_nmaa2_d[l_ac].nmbc003) 
      END IF 
      #151103-00010#2---e
      
      
      #上期餘額show第一筆
      IF l_ac = 1 THEN
         LET g_nmaa2_d[2].* = g_nmaa2_d[1].*
         LET l_ac = 2
         INITIALIZE g_nmaa2_d[1].* TO NULL
         
         #取得月結檔金額(原幣、本幣)
         LET l_yy = YEAR(g_nmaa2_d[l_ac].nmbc005)
         LET l_mm = MONTH(g_nmaa2_d[l_ac].nmbc005)
         
         #160322-00025#13 -add -str
         IF cl_null(g_wc_oraga) OR g_wc_oraga = ' 1=1'  THEN
            SELECT SUM(nmbx103-nmbx104),SUM(nmbx113-nmbx114)
              INTO l_nmbx1031,l_nmbx1131
              FROM nmbx_t LEFT JOIN nmas_t ON nmbx003=nmas002
               AND nmasent = nmbxent        #151015-00007#1
             WHERE nmas001=g_nmaa_d[g_detail_idx].nmaa001
               AND nmas003=g_nmaa_d[g_detail_idx].nmas003
               AND nmbx001 = l_yy AND nmbx002 < l_mm
               AND nmbxent = g_enterprise   #151015-00007#1 
         ELSE
            SELECT SUM(nmbx103-nmbx104),SUM(nmbx113-nmbx114)
              INTO l_nmbx1031,l_nmbx1131
              FROM nmbx_t LEFT JOIN nmas_t ON nmbx003=nmas002
               AND nmasent = nmbxent        #151015-00007#1
             WHERE nmas001=g_nmaa_d[g_detail_idx].nmaa001
               AND nmas003=g_nmaa_d[g_detail_idx].nmas003
               AND nmbx001 = l_yy AND nmbx002 < l_mm
               AND nmbxent = g_enterprise   #151015-00007#1
               AND nmbxorga = g_nmaa_d[g_detail_idx].nmbcorga  
         END IF 
         #160322-00025#13 -add -end
         
         IF cl_null(l_nmbx1031) THEN LET l_nmbx1031=0 END IF
         IF cl_null(l_nmbx1131) THEN LET l_nmbx1131=0 END IF

         #本期異動金額(原幣、本幣)
         CALL s_date_get_ymtodate(l_yy,l_mm,l_yy,l_mm) RETURNING l_strdt,l_enddt #符合日期的第一天
         LET l_enddt = g_nmaa2_d[l_ac].nmbc005-1 #符合日期的前一天
         #160322-00025#13 -add -str
         IF cl_null(g_wc_oraga) OR g_wc_oraga = ' 1=1'  THEN
            SELECT SUM(CASE nmbc006 WHEN '1' THEN nmbc103 ELSE 0 END - CASE nmbc006 WHEN '2' THEN nmbc103 ELSE 0 END),
                   SUM(CASE nmbc006 WHEN '1' THEN nmbc113 ELSE 0 END - CASE nmbc006 WHEN '2' THEN nmbc113 ELSE 0 END) 
              INTO l_nmbx1032,l_nmbx1132
              FROM nmbc_t
             WHERE nmbc002 = g_nmaa_d[g_detail_idx].nmas002
               AND nmbc100 = g_nmaa_d[g_detail_idx].nmas003
               AND nmbc005 BETWEEN l_strdt AND l_enddt
               AND nmbcent = g_enterprise   #151015-00007#1
         ELSE
            SELECT SUM(CASE nmbc006 WHEN '1' THEN nmbc103 ELSE 0 END - CASE nmbc006 WHEN '2' THEN nmbc103 ELSE 0 END),
                   SUM(CASE nmbc006 WHEN '1' THEN nmbc113 ELSE 0 END - CASE nmbc006 WHEN '2' THEN nmbc113 ELSE 0 END) 
              INTO l_nmbx1032,l_nmbx1132
              FROM nmbc_t
             WHERE nmbc002 = g_nmaa_d[g_detail_idx].nmas002
               AND nmbc100 = g_nmaa_d[g_detail_idx].nmas003
               AND nmbc005 BETWEEN l_strdt AND l_enddt
               AND nmbcent = g_enterprise   #151015-00007#1
               AND nmbcorga = g_nmaa_d[g_detail_idx].nmbcorga 
            END IF 
         #160322-00025#13 -add -end

         IF cl_null(l_nmbx1032) THEN LET l_nmbx1032=0 END IF
         IF cl_null(l_nmbx1132) THEN LET l_nmbx1132=0 END IF

         #總餘額(原幣)
         LET g_nmaa2_d[1].l_nmbc1031=l_nmbx1031+l_nmbx1032
         CALL s_curr_round_ld('1',l_ld,g_nmaa_d[g_detail_idx].nmas003,g_nmaa2_d[1].l_nmbc1031,2) RETURNING g_sub_success,g_errno,g_nmaa2_d[1].l_nmbc1031 #150626-00011#1
         #總餘額(本幣)
         LET g_nmaa2_d[1].l_nmbc1131=l_nmbx1131+l_nmbx1132
         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_nmaa2_d[1].l_nmbc1131,2) RETURNING g_sub_success,g_errno,g_nmaa2_d[1].l_nmbc1131 #150626-00011#1
         
         #顯示"上期餘額"的字
         LET g_nmaa2_d[1].l_nmbc007_desc = cl_getmsg("anm-00214",g_lang)
      END IF
      
      IF g_nmaa2_d[l_ac].nmbc006 ='2' THEN #提出要變成負數
         LET g_nmaa2_d[l_ac].nmbc103 = 0 - g_nmaa2_d[l_ac].nmbc103
         LET g_nmaa2_d[l_ac].nmbc113 = 0 - g_nmaa2_d[l_ac].nmbc113
      END IF
      
      #150626-00011#1 add ------
      CALL s_curr_round_ld('1',l_ld,g_nmaa_d[g_detail_idx].nmas003,g_nmaa2_d[l_ac].nmbc103,2) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].nmbc103
      CALL s_curr_round_ld('1',l_ld,l_glaa001,g_nmaa2_d[l_ac].nmbc113,2) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].nmbc113
      #150626-00011#1 add end---
      
      #結存金額
      LET g_nmaa2_d[l_ac].l_nmbc1031 = g_nmaa2_d[l_ac-1].l_nmbc1031 + g_nmaa2_d[l_ac].nmbc103
      LET g_nmaa2_d[l_ac].l_nmbc1131 = g_nmaa2_d[l_ac-1].l_nmbc1131 + g_nmaa2_d[l_ac].nmbc113
      
      #150626-00011#1 add ------
      CALL s_curr_round_ld('1',l_ld,g_nmaa_d[g_detail_idx].nmas003,g_nmaa2_d[l_ac].l_nmbc1031,2) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].l_nmbc1031
      CALL s_curr_round_ld('1',l_ld,l_glaa001,g_nmaa2_d[l_ac].l_nmbc1131,2) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].l_nmbc1131
      #150626-00011#1 add end---
      
      #取得平均匯率
      LET g_nmaa2_d[l_ac].l_average = g_nmaa2_d[l_ac].l_nmbc1131 / g_nmaa2_d[l_ac].l_nmbc1031
      CALL s_curr_round_ld('1',l_ld,g_nmaa_d[g_detail_idx].nmas003,g_nmaa2_d[l_ac].l_average,3) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].l_average
      
      #存提碼
      LET g_nmaa2_d[l_ac].l_nmbc007_desc = s_desc_get_nmajl003_desc(g_nmaa2_d[l_ac].nmbc007)
      
      #150817-00025#1 add ------
     #CALL s_curr_round_ld('1',l_ld,l_glaa001,g_nmaa2_d[l_ac].nmbc101,3) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].nmbc101 #160822-00018#1 mark
      CALL s_curr_round_ld('1',l_ld,g_nmaa_d[g_detail_idx].nmas003,g_nmaa2_d[l_ac].nmbc101,3) RETURNING g_sub_success,g_errno,g_nmaa2_d[l_ac].nmbc101 #160822-00018#1
      LET g_nmaa2_d[l_ac].nmbc101 = g_nmaa2_d[l_ac].nmbc101 USING '########&.&&&&&&'
      #150817-00025#1 add end---
      #end add-point
 
      CALL anmq210_detail_show("'2'")
 
      CALL anmq210_nmbc_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_nmaa2_d.deleteElement(g_nmaa2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_nmaa2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
 
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq210_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_nmaa_d[l_ac].nmaa002
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmaa_d[l_ac].nmaa002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmaa_d[l_ac].nmaa002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmaa_d[l_ac].nmaa003
            LET ls_sql = "SELECT nmagl003 FROM nmagl_t WHERE nmaglent='"||g_enterprise||"' AND nmagl001=? AND nmagl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmaa_d[l_ac].nmaa003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmaa_d[l_ac].nmaa003_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmq210_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_wc       STRING   #160816-00012#4 Add
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
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_nmbcdocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_nmbcdocno', FALSE) 
 
  
 
 
 
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON nmaa001,nmaa002,nmaa003,nmas002,nmas003,nmbcorga
                          FROM s_detail1[1].b_nmaa001,s_detail1[1].b_nmaa002,s_detail1[1].b_nmaa003, 
                              s_detail1[1].b_nmas002,s_detail1[1].b_nmas003,s_detail1[1].b_nmbcorga
 
         BEFORE CONSTRUCT
                     DISPLAY anmq210_filter_parser('nmaa001') TO s_detail1[1].b_nmaa001
            DISPLAY anmq210_filter_parser('nmaa002') TO s_detail1[1].b_nmaa002
            DISPLAY anmq210_filter_parser('nmaa003') TO s_detail1[1].b_nmaa003
            DISPLAY anmq210_filter_parser('nmas002') TO s_detail1[1].b_nmas002
            DISPLAY anmq210_filter_parser('nmas003') TO s_detail1[1].b_nmas003
            DISPLAY anmq210_filter_parser('nmbcorga') TO s_detail1[1].b_nmbcorga
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmaa001>>----
         #Ctrlp:construct.c.page1.b_nmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmaa001
            #add-point:ON ACTION controlp INFIELD b_nmaa001 name="construct.c.filter.page1.b_nmaa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161130-00049#1 mod s---
            #CALL q_nmaa001()                           #呼叫開窗
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  
            CALL q_nmaa001_03()           
            #161130-00049#1 mod e---
            DISPLAY g_qryparam.return1 TO b_nmaa001  #顯示到畫面上
            NEXT FIELD b_nmaa001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmaa002>>----
         #Ctrlp:construct.c.page1.b_nmaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmaa002
            #add-point:ON ACTION controlp INFIELD b_nmaa002 name="construct.c.filter.page1.b_nmaa002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooef()     #161110-00001#1  ADD  xul  
          # CALL q_ooea()     #161110-00001#1  MARK                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmaa002  #顯示到畫面上
            NEXT FIELD b_nmaa002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmaa002_desc>>----
         #----<<b_nmaa003>>----
         #Ctrlp:construct.c.filter.page1.b_nmaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmaa003
            #add-point:ON ACTION controlp INFIELD b_nmaa003 name="construct.c.filter.page1.b_nmaa003"
            
            #END add-point
 
 
         #----<<b_nmaa003_desc>>----
         #----<<b_nmas002>>----
         #Ctrlp:construct.c.filter.page1.b_nmas002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmas002
            #add-point:ON ACTION controlp INFIELD b_nmas002 name="construct.c.filter.page1.b_nmas002"
            
            #END add-point
 
 
         #----<<nmas002_desc>>----
         #----<<b_nmas003>>----
         #Ctrlp:construct.c.page1.b_nmas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmas003
            #add-point:ON ACTION controlp INFIELD b_nmas003 name="construct.c.filter.page1.b_nmas003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmas003  #顯示到畫面上
            NEXT FIELD b_nmas003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbcorga>>----
         #Ctrlp:construct.c.page1.b_nmbcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbcorga
            #add-point:ON ACTION controlp INFIELD b_nmbcorga name="construct.c.filter.page1.b_nmbcorga"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
            LET l_wc = cl_replace_str(l_wc,"ooef001","nmbcorga")
            LET g_qryparam.where = l_wc CLIPPED
            #160816-00012#3 Add  ---(E)---
            CALL q_nmbcorga_02()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbcorga  #顯示到畫面上
            NEXT FIELD b_nmbcorga                     #返回原欄位
    



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
 
 
 
 
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_nmbcdocno', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_nmbcdocno', FALSE) 
 
  
 
 
 
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL anmq210_filter_show('nmaa001','b_nmaa001')
   CALL anmq210_filter_show('nmaa002','b_nmaa002')
   CALL anmq210_filter_show('nmaa003','b_nmaa003')
   CALL anmq210_filter_show('nmas002','b_nmas002')
   CALL anmq210_filter_show('nmas003','b_nmas003')
   CALL anmq210_filter_show('nmbcorga','b_nmbcorga')
   CALL anmq210_filter_show('nmbc005','b_nmbc005')
   CALL anmq210_filter_show('nmbcdocno','b_nmbcdocno')
   CALL anmq210_filter_show('nmbcseq','b_nmbcseq')
   CALL anmq210_filter_show('nmbc006','b_nmbc006')
   CALL anmq210_filter_show('nmbc007','b_nmbc007')
   CALL anmq210_filter_show('nmbc003','b_nmbc003')
   CALL anmq210_filter_show('nmbc012','b_nmbc012')
   CALL anmq210_filter_show('nmbc013','b_nmbc013')
   CALL anmq210_filter_show('nmbc103','b_nmbc103')
   CALL anmq210_filter_show('nmbc113','b_nmbc113')
   CALL anmq210_filter_show('nmbc011','b_nmbc011')
   CALL anmq210_filter_show('nmbc010','b_nmbc010')
 
 
   CALL anmq210_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq210.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmq210_filter_parser(ps_field)
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
 
{<section id="anmq210.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq210_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq210_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmq210.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION anmq210_get_hyper_data(ps_field_name) 
   #add-point:get_hyper_data段define-客製 name="get_hyper_data.define_customerization" 
   
   #end add-point 
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog       STRING, 
                           actionid   STRING, 
                           background LIKE type_t.chr1, 
                           param      DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
   #add-point:get_hyper_data段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="get_hyper_data.define" 
   
   #end add-point 
  
  
   #add-point:FUNCTION前置處理 name="get_hyper_data.before_function" 
   
   #end add-point 
  
   LET ps_url = NULL 
  
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_nmbcdocno" 
         LET la_param.prog = "anmt310" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_nmaa2_d[l_ac].nmbcdocno 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_nmbcdocno" 
         LET la_param.param[1] = g_nmaa_d[g_detail_idx].nmaa002  #開戶人(組織)=nmbacomp(法人)
         LET la_param.param[2] = g_nmaa2_d[l_ac].nmbcdocno       #來源單號=nmbadocno(收支單號)
         #end add-point 
  
 
   END CASE 
  
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
   #add-point:傳入參數設定 name="get_hyper_data.set_parameter" 
   
   #end add-point 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
  
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   #add-point:定義執行模式 name="get_hyper_data.set_env" 
   
   #end add-point 
  
   #呼叫lib，取得完整的url資訊 
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   LET ps_url = cl_replace_str(ps_url, "&", "&amp;")  
   RETURN ps_url 
  
END FUNCTION 
 
{</section>}
 
{<section id="anmq210.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq210_detail_action_trans()
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
 
{<section id="anmq210.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq210_detail_index_setting()
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
            IF g_nmaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmaa_d.getLength() AND g_nmaa_d.getLength() > 0
            LET g_detail_idx = g_nmaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmaa_d.getLength() THEN
               LET g_detail_idx = g_nmaa_d.getLength()
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
 
{<section id="anmq210.mask_functions" >}
 &include "erp/anm/anmq210_mask.4gl"
 
{</section>}
 
{<section id="anmq210.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 傳入日期，計算出當日平均匯率
# Memo...........:
# Usage..........: CALL anmq210_average(p_nmbc005)
# Input parameter: p_nmbc005      銀行日期
# Return code....: r_average      平均匯率
# Date & Author..: 15/08/20 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq210_average(p_nmbc005)
DEFINE p_nmbc005  LIKE nmbc_t.nmbc005
DEFINE r_average  LIKE type_t.num26_10
DEFINE l_sum103   LIKE type_t.num20_6
DEFINE l_sum113   LIKE type_t.num20_6
DEFINE l_sql      STRING
   
   LET l_sql = "SELECT SUM(nmbc103),SUM(nmbc113) FROM nmbc_t,nmas_t",
               " WHERE nmasent = nmbcent AND nmas002 = nmbc002 ",
               "   AND nmbcent=? AND nmas001=? AND nmbc002 = '",g_nmaa_d[g_detail_idx].nmas002,
               "'  AND nmbc100 = '",g_nmaa_d[g_detail_idx].nmas003,"' AND nmbc005 = ? "
   IF NOT cl_null(g_wc3) THEN
      LET l_sql = l_sql CLIPPED," AND ",g_wc3 CLIPPED
   END IF
   PREPARE average_pre FROM l_sql  
   EXECUTE average_pre USING g_enterprise,g_nmaa_d[g_detail_idx].nmaa001,p_nmbc005 
   INTO l_sum103,l_sum113
   
   FREE average_pre
   
   LET r_average = l_sum113 / l_sum103
   RETURN r_average

END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: #150818-00032#3
#
# Date & Author..: 2015/08/21 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq210_create_tmp()
DROP TABLE anmq210_x01_tmp;
CREATE TEMP TABLE anmq210_x01_tmp(
   l_seq          LIKE type_t.num10,
   nmaa001        LIKE nmaa_t.nmaa001,
   nmaa002_desc   LIKE type_t.chr500,
   nmaa003_desc   LIKE type_t.chr500,
   #nmas002        LIKE nmas_t.nmas002,  #151105-00001#6 mark
   l_nmas002      LIKE type_t.chr500,    #151105-00001#6 交易帳戶+帳戶說明
   nmbc100        LIKE nmbc_t.nmbc100,
   nmbc005        LIKE nmbc_t.nmbc005, 
   nmbcdocno      LIKE nmbc_t.nmbcdocno, 
   nmbcseq        LIKE nmbc_t.nmbcseq, 
   nmbc006        LIKE type_t.chr500,
   nmbc007        LIKE nmbc_t.nmbc007, 
   l_nmbc007_desc LIKE type_t.chr500, 
   nmbc003        LIKE nmbc_t.nmbc003,
   l_nmbc003_desc LIKE type_t.chr500,
   nmbc012        LIKE nmbc_t.nmbc012, 
   nmbc013        LIKE nmbc_t.nmbc013, 
   l_average      LIKE type_t.num26_10, 
   nmbc101        LIKE type_t.chr500, 
   nmbc103        LIKE nmbc_t.nmbc103, 
   l_nmbc1031     LIKE type_t.num20_6, 
   nmbc113        LIKE nmbc_t.nmbc113, 
   l_nmbc1131     LIKE type_t.num20_6, 
   nmbc011        LIKE nmbc_t.nmbc011, 
   nmbc010        LIKE nmbc_t.nmbc010,
   l_nmbc005_desc LIKE type_t.chr500)   #151127-00002#4

END FUNCTION
################################################################################
# Descriptions...: 
# Memo...........: #150818-00032#3
#
# Date & Author..: 2015/08/21 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq210_insert_tmp()
DEFINE l_nmbc006_desc LIKE type_t.chr500    #取得SCC的說明文字
DEFINE l_i         LIKE type_t.num10
DEFINE l_j         LIKE type_t.num10
DEFINE l_n         LIKE type_t.num10   
DEFINE l_nmas002   LIKE type_t.chr500    #151105-00001#6
DEFINE l_x01_tmp   RECORD
   l_seq           LIKE type_t.num10,
  #nmaa001         LIKE nmbc_t.nmbcent,  #151013-00019#6 mark
   nmaa001         LIKE nmaa_t.nmaa001,  #151013-00019#6
   nmaa002_desc    LIKE type_t.chr500,
   nmaa003_desc    LIKE type_t.chr500,
   #nmas002         LIKE nmas_t.nmas002,  #151105-00001#6 mark
   l_nmas002      LIKE type_t.chr500,     #151105-00001#6 交易帳戶+帳戶說明
   nmbc100         LIKE nmbc_t.nmbc100,
   nmbc005         LIKE nmbc_t.nmbc005, 
   nmbcdocno       LIKE nmbc_t.nmbcdocno, 
   nmbcseq         LIKE nmbc_t.nmbcseq, 
   nmbc006         LIKE type_t.chr500, 
   nmbc007         LIKE nmbc_t.nmbc007, 
   l_nmbc007_desc  LIKE type_t.chr500,  
   nmbc003         LIKE nmbc_t.nmbc003, 
   l_nmbc003_desc  LIKE type_t.chr500,
   nmbc012         LIKE nmbc_t.nmbc012, 
   nmbc013         LIKE nmbc_t.nmbc013, 
   l_average       LIKE type_t.num26_10, 
   nmbc101         LIKE type_t.chr500, 
   nmbc103         LIKE nmbc_t.nmbc103, 
   l_nmbc1031      LIKE type_t.num20_6, 
   nmbc113         LIKE nmbc_t.nmbc113, 
   l_nmbc1131      LIKE type_t.num20_6, 
   nmbc011         LIKE nmbc_t.nmbc011, 
   nmbc010         LIKE nmbc_t.nmbc010,
   l_nmbc005_desc  LIKE type_t.chr500   #151127-00002#4
                   END RECORD
   
   DELETE FROM anmq210_x01_tmp
   LET l_n = 0
   FOR l_i = 1 TO g_nmaa_d.getLength()
      LET g_detail_idx = l_i
      CALL anmq210_b_fill2()
      FOR l_j = 1 TO g_nmaa2_d.getLength()
         LET l_n = l_n + 1
         LET l_nmbc006_desc = ''  
         LET l_nmas002 = ''
         LET l_nmas002 = s_desc_show1(g_nmaa_d[l_i].nmas002,s_desc_get_nmas002_desc(g_nmaa_d[l_i].nmas002))         
         CALL s_desc_gzcbl004_desc('8701',g_nmaa2_d[l_j].nmbc006) RETURNING l_nmbc006_desc
         INITIALIZE l_x01_tmp.* TO NULL
         LET l_x01_tmp.l_seq           = l_n
         LET l_x01_tmp.nmaa001         = g_nmaa_d[l_i].nmaa001 
         LET l_x01_tmp.nmaa002_desc    = g_nmaa_d[l_i].nmaa002,".",g_nmaa_d[l_i].nmaa002_desc
         LET l_x01_tmp.nmaa003_desc    = g_nmaa_d[l_i].nmaa003,".",g_nmaa_d[l_i].nmaa003_desc
         #LET l_x01_tmp.nmas002         = g_nmaa_d[l_i].nmas002                                 #151105-00001#6 mark
         LET l_x01_tmp.l_nmas002       = l_nmas002                                              #151105-00001#6 交易帳戶+帳戶說明
         LET l_x01_tmp.nmbc100         = g_nmaa_d[l_i].nmas003
         LET l_x01_tmp.nmbc005         = g_nmaa2_d[l_j].nmbc005
         LET l_x01_tmp.nmbcdocno       = g_nmaa2_d[l_j].nmbcdocno
         LET l_x01_tmp.nmbcseq         = g_nmaa2_d[l_j].nmbcseq 
         IF NOT cl_null(g_nmaa2_d[l_j].nmbc006) THEN
            LET l_x01_tmp.nmbc006         = g_nmaa2_d[l_j].nmbc006,".",l_nmbc006_desc
         ELSE
            LET l_x01_tmp.nmbc006         = l_nmbc006_desc
         END IF
         LET l_x01_tmp.nmbc007         = g_nmaa2_d[l_j].nmbc007
         LET l_x01_tmp.l_nmbc007_desc  = g_nmaa2_d[l_j].l_nmbc007_desc
         LET l_x01_tmp.nmbc003         = g_nmaa2_d[l_j].nmbc003         
         LET l_x01_tmp.l_nmbc003_desc  = g_nmaa2_d[l_j].l_nmbc003_desc
         LET l_x01_tmp.nmbc012         = g_nmaa2_d[l_j].nmbc012
         LET l_x01_tmp.nmbc013         = g_nmaa2_d[l_j].nmbc013
         LET l_x01_tmp.l_average       = g_nmaa2_d[l_j].l_average
         LET l_x01_tmp.nmbc101         = g_nmaa2_d[l_j].nmbc101
         LET l_x01_tmp.nmbc103         = g_nmaa2_d[l_j].nmbc103
         LET l_x01_tmp.l_nmbc1031      = g_nmaa2_d[l_j].l_nmbc1031
         LET l_x01_tmp.nmbc113         = g_nmaa2_d[l_j].nmbc113
         LET l_x01_tmp.l_nmbc1131      = g_nmaa2_d[l_j].l_nmbc1131
         LET l_x01_tmp.nmbc011         = g_nmaa2_d[l_j].nmbc011
         LET l_x01_tmp.nmbc010         = g_nmaa2_d[l_j].nmbc010
         LET l_x01_tmp.l_nmbc005_desc  = g_nmbc005_desc   #151127-00002#4         
         INSERT INTO anmq210_x01_tmp VALUES(l_x01_tmp.*)
      END FOR
   END FOR 
END FUNCTION

 
{</section>}
 
