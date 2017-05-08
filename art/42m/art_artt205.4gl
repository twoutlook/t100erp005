#該程式未解開Section, 採用最新樣板產出!
{<section id="artt205.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-05-11 12:32:22), PR版次:0013(2016-11-25 14:05:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000363
#+ Filename...: artt205
#+ Description: 品類策略異動申請作業
#+ Creator....: 02331(2013-09-23 15:39:20)
#+ Modifier...: 08172 -SD/PR- 06814
 
{</section>}
 
{<section id="artt205.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160504-00013#1   2016/05/05  by 08172   画面调整
#160504-00016#    2016/05/05  by 08172   单头策略编号开窗修改及单身修改控制
#160816-00068#8   2016/08/17  By 08209   調整transaction
#160818-00017#34  2016-08-29  By 08734   删除修改未重新判断状态码
#160824-00007#159 2016/11/25  By 06814   新舊值處理
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_rtaf_m        RECORD
       rtafsite LIKE rtaf_t.rtafsite, 
   rtafsite_desc LIKE type_t.chr80, 
   rtafdocdt LIKE rtaf_t.rtafdocdt, 
   rtafdocno LIKE rtaf_t.rtafdocno, 
   rtaf000 LIKE rtaf_t.rtaf000, 
   rtaf001 LIKE rtaf_t.rtaf001, 
   rtafl002 LIKE rtafl_t.rtafl002, 
   rtafunit LIKE rtaf_t.rtafunit, 
   rtafl003 LIKE rtafl_t.rtafl003, 
   rtaf006 LIKE type_t.chr10, 
   rtaf006_desc LIKE type_t.chr80, 
   rtaf002 LIKE rtaf_t.rtaf002, 
   rtaf002_desc LIKE type_t.chr80, 
   rtaf004 LIKE rtaf_t.rtaf004, 
   rtaf004_desc LIKE type_t.chr80, 
   rtaf005 LIKE rtaf_t.rtaf005, 
   rtaf005_desc LIKE type_t.chr80, 
   rtaf003 LIKE rtaf_t.rtaf003, 
   rtafacti LIKE rtaf_t.rtafacti, 
   rtafstus LIKE rtaf_t.rtafstus, 
   rtafownid LIKE rtaf_t.rtafownid, 
   rtafownid_desc LIKE type_t.chr80, 
   rtafowndp LIKE rtaf_t.rtafowndp, 
   rtafowndp_desc LIKE type_t.chr80, 
   rtafcrtid LIKE rtaf_t.rtafcrtid, 
   rtafcrtid_desc LIKE type_t.chr80, 
   rtafcrtdp LIKE rtaf_t.rtafcrtdp, 
   rtafcrtdp_desc LIKE type_t.chr80, 
   rtafcrtdt LIKE rtaf_t.rtafcrtdt, 
   rtafmodid LIKE rtaf_t.rtafmodid, 
   rtafmodid_desc LIKE type_t.chr80, 
   rtafmoddt LIKE rtaf_t.rtafmoddt, 
   rtafcnfid LIKE rtaf_t.rtafcnfid, 
   rtafcnfid_desc LIKE type_t.chr80, 
   rtafcnfdt LIKE rtaf_t.rtafcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtag_d        RECORD
       rtag001 LIKE rtag_t.rtag001, 
   rtag002 LIKE rtag_t.rtag002, 
   rtag002_desc LIKE type_t.chr500, 
   rtax003 LIKE type_t.chr500, 
   rtax003_desc LIKE type_t.chr500, 
   rtag003 LIKE rtag_t.rtag003, 
   rtag003_desc LIKE type_t.chr500, 
   rtag004 LIKE rtag_t.rtag004, 
   rtag005 LIKE rtag_t.rtag005, 
   rtag006 LIKE rtag_t.rtag006, 
   rtag007 LIKE rtag_t.rtag007, 
   rtag008 LIKE rtag_t.rtag008, 
   rtagacti LIKE rtag_t.rtagacti
       END RECORD
PRIVATE TYPE type_g_rtag2_d RECORD
       rtah001 LIKE rtah_t.rtah001, 
   rtah002 LIKE rtah_t.rtah002, 
   rtah002_desc LIKE type_t.chr500, 
   rtahacti LIKE rtah_t.rtahacti
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtafsite LIKE rtaf_t.rtafsite,
   b_rtafsite_desc LIKE type_t.chr80,
      b_rtafdocno LIKE rtaf_t.rtafdocno,
      b_rtafdocdt LIKE rtaf_t.rtafdocdt,
      b_rtaf000 LIKE rtaf_t.rtaf000,
      b_rtaf001 LIKE rtaf_t.rtaf001,
      b_rtaf002 LIKE rtaf_t.rtaf002,
   b_rtaf002_desc LIKE type_t.chr80,
      b_rtaf003 LIKE rtaf_t.rtaf003,
      b_rtafacti LIKE rtaf_t.rtafacti
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_multi  STRING
DEFINE g_site_flag           LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：11
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtaf_m          type_g_rtaf_m
DEFINE g_rtaf_m_t        type_g_rtaf_m
DEFINE g_rtaf_m_o        type_g_rtaf_m
DEFINE g_rtaf_m_mask_o   type_g_rtaf_m #轉換遮罩前資料
DEFINE g_rtaf_m_mask_n   type_g_rtaf_m #轉換遮罩後資料
 
   DEFINE g_rtafdocno_t LIKE rtaf_t.rtafdocno
 
 
DEFINE g_rtag_d          DYNAMIC ARRAY OF type_g_rtag_d
DEFINE g_rtag_d_t        type_g_rtag_d
DEFINE g_rtag_d_o        type_g_rtag_d
DEFINE g_rtag_d_mask_o   DYNAMIC ARRAY OF type_g_rtag_d #轉換遮罩前資料
DEFINE g_rtag_d_mask_n   DYNAMIC ARRAY OF type_g_rtag_d #轉換遮罩後資料
DEFINE g_rtag2_d          DYNAMIC ARRAY OF type_g_rtag2_d
DEFINE g_rtag2_d_t        type_g_rtag2_d
DEFINE g_rtag2_d_o        type_g_rtag2_d
DEFINE g_rtag2_d_mask_o   DYNAMIC ARRAY OF type_g_rtag2_d #轉換遮罩前資料
DEFINE g_rtag2_d_mask_n   DYNAMIC ARRAY OF type_g_rtag2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      rtafldocno LIKE rtafl_t.rtafldocno,
      rtafl002 LIKE rtafl_t.rtafl002,
      rtafl003 LIKE rtafl_t.rtafl003
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artt205.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   #150424-00018#3 150529 by s983961 add(s) 
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0037') ='N' THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'art-00579'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()    
          CALL cl_ap_exitprogram("0")    
   END IF       
   #150424-00018#3 150529 by s983961 add(e) 
   SELECT ooef004 INTO g_ooef004  FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rtafsite,'',rtafdocdt,rtafdocno,rtaf000,rtaf001,'',rtafunit,'','','', 
       rtaf002,'',rtaf004,'',rtaf005,'',rtaf003,rtafacti,rtafstus,rtafownid,'',rtafowndp,'',rtafcrtid, 
       '',rtafcrtdp,'',rtafcrtdt,rtafmodid,'',rtafmoddt,rtafcnfid,'',rtafcnfdt", 
                      " FROM rtaf_t",
                      " WHERE rtafent= ? AND rtafdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt205_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtafsite,t0.rtafdocdt,t0.rtafdocno,t0.rtaf000,t0.rtaf001,t0.rtafunit, 
       t0.rtaf006,t0.rtaf002,t0.rtaf004,t0.rtaf005,t0.rtaf003,t0.rtafacti,t0.rtafstus,t0.rtafownid,t0.rtafowndp, 
       t0.rtafcrtid,t0.rtafcrtdp,t0.rtafcrtdt,t0.rtafmodid,t0.rtafmoddt,t0.rtafcnfid,t0.rtafcnfdt,t1.ooefl003 , 
       t2.ooefl003 ,t3.rtaal003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM rtaf_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtafsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.rtaf006 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaal_t t3 ON t3.rtaalent="||g_enterprise||" AND t3.rtaal001=t0.rtaf002 AND t3.rtaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtaf004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtaf005 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtafownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.rtafowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtafcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.rtafcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtafmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rtafcnfid  ",
 
               " WHERE t0.rtafent = " ||g_enterprise|| " AND t0.rtafdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt205_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt205 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt205_init()   
 
      #進入選單 Menu (="N")
      CALL artt205_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt205
      
   END IF 
   
   CLOSE artt205_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt205.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt205_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('rtafstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('rtaf000','32') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_rtaf000','32') 
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
   
   #初始化搜尋條件
   CALL artt205_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt205.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt205_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL artt205_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_rtaf_m.* TO NULL
         CALL g_rtag_d.clear()
         CALL g_rtag2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt205_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL artt205_fetch('') # reload data
               LET l_ac = 1
               CALL artt205_ui_detailshow() #Setting the current row 
         
               CALL artt205_idx_chk()
               #NEXT FIELD rtag002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtag_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt205_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL artt205_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_rtag2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt205_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL artt205_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL artt205_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL artt205_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt205_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt205_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt205_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt205_set_act_visible()   
            CALL artt205_set_act_no_visible()
            IF NOT (g_rtaf_m.rtafdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtafent = " ||g_enterprise|| " AND",
                                  " rtafdocno = '", g_rtaf_m.rtafdocno, "' "
 
               #填到對應位置
               CALL artt205_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rtaf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtag_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtah_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL artt205_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rtaf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtag_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtah_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL artt205_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt205_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL artt205_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt205_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt205_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt205_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt205_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt205_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt205_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt205_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt205_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt205_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt205_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_rtag_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rtag2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD rtag002
            END IF
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL artt205_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt205_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt205_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt205_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/art/artt205_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/art/artt205_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt205_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt205_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt205_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt205_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtaf_m.rtafdocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="artt205.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt205_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #ken---add 需求單號：141208-00001 項次：11
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'rtafsite') RETURNING l_where #ken---add 需求單號：141208-00001 項次：11
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rtafdocno ",
                      " FROM rtaf_t ",
                      " ",
                      " LEFT JOIN rtag_t ON rtagent = rtafent AND rtafdocno = rtagdocno ", "  ",
                      #add-point:browser_fill段sql(rtag_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rtah_t ON rtahent = rtafent AND rtafdocno = rtahdocno", "  ",
                      #add-point:browser_fill段sql(rtah_t1) name="browser_fill.cnt.join.rtah_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN rtafl_t ON rtaflent = "||g_enterprise||" AND rtafdocno = rtafldocno AND rtafl001 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE rtafent = " ||g_enterprise|| " AND rtagent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtaf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtafdocno ",
                      " FROM rtaf_t ", 
                      "  ",
                      "  LEFT JOIN rtafl_t ON rtaflent = "||g_enterprise||" AND rtafdocno = rtafldocno AND rtafl001 = '",g_dlang,"' ",
                      " WHERE rtafent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtaf_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where #ken---add 需求單號：141208-00001 項次：11
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_rtaf_m.* TO NULL
      CALL g_rtag_d.clear()        
      CALL g_rtag2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtafsite,t0.rtafdocno,t0.rtafdocdt,t0.rtaf000,t0.rtaf001,t0.rtaf002,t0.rtaf003,t0.rtafacti Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtafstus,t0.rtafsite,t0.rtafdocno,t0.rtafdocdt,t0.rtaf000,t0.rtaf001, 
          t0.rtaf002,t0.rtaf003,t0.rtafacti,t1.ooefl003 ,t2.rtaal003 ",
                  " FROM rtaf_t t0",
                  "  ",
                  "  LEFT JOIN rtag_t ON rtagent = rtafent AND rtafdocno = rtagdocno ", "  ", 
                  #add-point:browser_fill段sql(rtag_t1) name="browser_fill.join.rtag_t1"
                  
                  #end add-point
                  "  LEFT JOIN rtah_t ON rtahent = rtafent AND rtafdocno = rtahdocno", "  ", 
                  #add-point:browser_fill段sql(rtah_t1) name="browser_fill.join.rtah_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtafsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaal_t t2 ON t2.rtaalent="||g_enterprise||" AND t2.rtaal001=t0.rtaf002 AND t2.rtaal002='"||g_dlang||"' ",
 
               " LEFT JOIN rtafl_t ON rtaflent = "||g_enterprise||" AND rtafdocno = rtafldocno AND rtafl001 = '",g_dlang,"' ",
                  " WHERE t0.rtafent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtaf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtafstus,t0.rtafsite,t0.rtafdocno,t0.rtafdocdt,t0.rtaf000,t0.rtaf001, 
          t0.rtaf002,t0.rtaf003,t0.rtafacti,t1.ooefl003 ,t2.rtaal003 ",
                  " FROM rtaf_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtafsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaal_t t2 ON t2.rtaalent="||g_enterprise||" AND t2.rtaal001=t0.rtaf002 AND t2.rtaal002='"||g_dlang||"' ",
 
               " LEFT JOIN rtafl_t ON rtaflent = "||g_enterprise||" AND rtafdocno = rtafldocno AND rtafl001 = '",g_dlang,"' ",
                  " WHERE t0.rtafent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtaf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where #ken---add 需求單號：141208-00001 項次：11
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtafdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtaf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtafsite,g_browser[g_cnt].b_rtafdocno, 
          g_browser[g_cnt].b_rtafdocdt,g_browser[g_cnt].b_rtaf000,g_browser[g_cnt].b_rtaf001,g_browser[g_cnt].b_rtaf002, 
          g_browser[g_cnt].b_rtaf003,g_browser[g_cnt].b_rtafacti,g_browser[g_cnt].b_rtafsite_desc,g_browser[g_cnt].b_rtaf002_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL artt205_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_rtafdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt205_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtaf_m.rtafdocno = g_browser[g_current_idx].b_rtafdocno   
 
   EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
       g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
       g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp_desc, 
       g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafcnfid_desc 
 
   
   CALL artt205_rtaf_t_mask()
   CALL artt205_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt205.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt205_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt205_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_rtafdocno = g_rtaf_m.rtafdocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt205_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_rtaf_m.* TO NULL
   CALL g_rtag_d.clear()        
   CALL g_rtag2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON rtafsite,rtafdocdt,rtafdocno,rtaf000,rtaf001,rtafl002,rtafunit,rtafl003, 
          rtaf006,rtaf002,rtaf004,rtaf005,rtaf003,rtafacti,rtafstus,rtafownid,rtafowndp,rtafcrtid,rtafcrtdp, 
          rtafcrtdt,rtafmodid,rtafmoddt,rtafcnfid,rtafcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtafcrtdt>>----
         AFTER FIELD rtafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtafmoddt>>----
         AFTER FIELD rtafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtafcnfdt>>----
         AFTER FIELD rtafcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtafpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtafsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafsite
            #add-point:ON ACTION controlp INFIELD rtafsite name="construct.c.rtafsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #ken---add---s 需求單號：141208-00001 項次：11
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtafsite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafsite  #顯示到畫面上
            NEXT FIELD rtafsite                     #返回原欄位
            #ken---add---e


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafsite
            #add-point:BEFORE FIELD rtafsite name="construct.b.rtafsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafsite
            
            #add-point:AFTER FIELD rtafsite name="construct.a.rtafsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafdocdt
            #add-point:BEFORE FIELD rtafdocdt name="construct.b.rtafdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafdocdt
            
            #add-point:AFTER FIELD rtafdocdt name="construct.a.rtafdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafdocdt
            #add-point:ON ACTION controlp INFIELD rtafdocdt name="construct.c.rtafdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafdocno
            #add-point:ON ACTION controlp INFIELD rtafdocno name="construct.c.rtafdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'              
            LET g_qryparam.reqry = FALSE
            CALL q_rtafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafdocno  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO rtafdocno #單號 

            NEXT FIELD rtafdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafdocno
            #add-point:BEFORE FIELD rtafdocno name="construct.b.rtafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafdocno
            
            #add-point:AFTER FIELD rtafdocno name="construct.a.rtafdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf000
            #add-point:BEFORE FIELD rtaf000 name="construct.b.rtaf000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf000
            
            #add-point:AFTER FIELD rtaf000 name="construct.a.rtaf000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtaf000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf000
            #add-point:ON ACTION controlp INFIELD rtaf000 name="construct.c.rtaf000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf001
            #add-point:ON ACTION controlp INFIELD rtaf001 name="construct.c.rtaf001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_rtaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaf001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO rtafl003 #說明 

            NEXT FIELD rtaf001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf001
            #add-point:BEFORE FIELD rtaf001 name="construct.b.rtaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf001
            
            #add-point:AFTER FIELD rtaf001 name="construct.a.rtaf001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafl002
            #add-point:BEFORE FIELD rtafl002 name="construct.b.rtafl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafl002
            
            #add-point:AFTER FIELD rtafl002 name="construct.a.rtafl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafl002
            #add-point:ON ACTION controlp INFIELD rtafl002 name="construct.c.rtafl002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafunit
            #add-point:BEFORE FIELD rtafunit name="construct.b.rtafunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafunit
            
            #add-point:AFTER FIELD rtafunit name="construct.a.rtafunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafunit
            #add-point:ON ACTION controlp INFIELD rtafunit name="construct.c.rtafunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafl003
            #add-point:BEFORE FIELD rtafl003 name="construct.b.rtafl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafl003
            
            #add-point:AFTER FIELD rtafl003 name="construct.a.rtafl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafl003
            #add-point:ON ACTION controlp INFIELD rtafl003 name="construct.c.rtafl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf006
            #add-point:BEFORE FIELD rtaf006 name="construct.b.rtaf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf006
            
            #add-point:AFTER FIELD rtaf006 name="construct.a.rtaf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtaf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf006
            #add-point:ON ACTION controlp INFIELD rtaf006 name="construct.c.rtaf006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaf006  #顯示到畫面上
            NEXT FIELD rtaf006                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.rtaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf002
            #add-point:ON ACTION controlp INFIELD rtaf002 name="construct.c.rtaf002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_rtaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaf002  #顯示到畫面上

            NEXT FIELD rtaf002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf002
            #add-point:BEFORE FIELD rtaf002 name="construct.b.rtaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf002
            
            #add-point:AFTER FIELD rtaf002 name="construct.a.rtaf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf004
            #add-point:ON ACTION controlp INFIELD rtaf004 name="construct.c.rtaf004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaf004  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD rtaf004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf004
            #add-point:BEFORE FIELD rtaf004 name="construct.b.rtaf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf004
            
            #add-point:AFTER FIELD rtaf004 name="construct.a.rtaf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtaf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf005
            #add-point:ON ACTION controlp INFIELD rtaf005 name="construct.c.rtaf005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaf005  #顯示到畫面上

            NEXT FIELD rtaf005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf005
            #add-point:BEFORE FIELD rtaf005 name="construct.b.rtaf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf005
            
            #add-point:AFTER FIELD rtaf005 name="construct.a.rtaf005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf003
            #add-point:BEFORE FIELD rtaf003 name="construct.b.rtaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf003
            
            #add-point:AFTER FIELD rtaf003 name="construct.a.rtaf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtaf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf003
            #add-point:ON ACTION controlp INFIELD rtaf003 name="construct.c.rtaf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafacti
            #add-point:BEFORE FIELD rtafacti name="construct.b.rtafacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafacti
            
            #add-point:AFTER FIELD rtafacti name="construct.a.rtafacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafacti
            #add-point:ON ACTION controlp INFIELD rtafacti name="construct.c.rtafacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafstus
            #add-point:BEFORE FIELD rtafstus name="construct.b.rtafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafstus
            
            #add-point:AFTER FIELD rtafstus name="construct.a.rtafstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafstus
            #add-point:ON ACTION controlp INFIELD rtafstus name="construct.c.rtafstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafownid
            #add-point:ON ACTION controlp INFIELD rtafownid name="construct.c.rtafownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafownid  #顯示到畫面上

            NEXT FIELD rtafownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafownid
            #add-point:BEFORE FIELD rtafownid name="construct.b.rtafownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafownid
            
            #add-point:AFTER FIELD rtafownid name="construct.a.rtafownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafowndp
            #add-point:ON ACTION controlp INFIELD rtafowndp name="construct.c.rtafowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafowndp  #顯示到畫面上

            NEXT FIELD rtafowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafowndp
            #add-point:BEFORE FIELD rtafowndp name="construct.b.rtafowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafowndp
            
            #add-point:AFTER FIELD rtafowndp name="construct.a.rtafowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafcrtid
            #add-point:ON ACTION controlp INFIELD rtafcrtid name="construct.c.rtafcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafcrtid  #顯示到畫面上

            NEXT FIELD rtafcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafcrtid
            #add-point:BEFORE FIELD rtafcrtid name="construct.b.rtafcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafcrtid
            
            #add-point:AFTER FIELD rtafcrtid name="construct.a.rtafcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafcrtdp
            #add-point:ON ACTION controlp INFIELD rtafcrtdp name="construct.c.rtafcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafcrtdp  #顯示到畫面上

            NEXT FIELD rtafcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafcrtdp
            #add-point:BEFORE FIELD rtafcrtdp name="construct.b.rtafcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafcrtdp
            
            #add-point:AFTER FIELD rtafcrtdp name="construct.a.rtafcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafcrtdt
            #add-point:BEFORE FIELD rtafcrtdt name="construct.b.rtafcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafmodid
            #add-point:ON ACTION controlp INFIELD rtafmodid name="construct.c.rtafmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafmodid  #顯示到畫面上

            NEXT FIELD rtafmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafmodid
            #add-point:BEFORE FIELD rtafmodid name="construct.b.rtafmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafmodid
            
            #add-point:AFTER FIELD rtafmodid name="construct.a.rtafmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafmoddt
            #add-point:BEFORE FIELD rtafmoddt name="construct.b.rtafmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtafcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafcnfid
            #add-point:ON ACTION controlp INFIELD rtafcnfid name="construct.c.rtafcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtafcnfid  #顯示到畫面上

            NEXT FIELD rtafcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafcnfid
            #add-point:BEFORE FIELD rtafcnfid name="construct.b.rtafcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafcnfid
            
            #add-point:AFTER FIELD rtafcnfid name="construct.a.rtafcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafcnfdt
            #add-point:BEFORE FIELD rtafcnfdt name="construct.b.rtafcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtag002,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008,rtagacti
           FROM s_detail1[1].rtag002,s_detail1[1].rtag003,s_detail1[1].rtag004,s_detail1[1].rtag005, 
               s_detail1[1].rtag006,s_detail1[1].rtag007,s_detail1[1].rtag008,s_detail1[1].rtagacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.rtag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag002
            #add-point:ON ACTION controlp INFIELD rtag002 name="construct.c.page1.rtag002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'                
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtag002  #顯示到畫面上

            NEXT FIELD rtag002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag002
            #add-point:BEFORE FIELD rtag002 name="construct.b.page1.rtag002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag002
            
            #add-point:AFTER FIELD rtag002 name="construct.a.page1.rtag002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag003
            #add-point:ON ACTION controlp INFIELD rtag003 name="construct.c.page1.rtag003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2059'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtag003  #顯示到畫面上

            NEXT FIELD rtag003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag003
            #add-point:BEFORE FIELD rtag003 name="construct.b.page1.rtag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag003
            
            #add-point:AFTER FIELD rtag003 name="construct.a.page1.rtag003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag004
            #add-point:BEFORE FIELD rtag004 name="construct.b.page1.rtag004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag004
            
            #add-point:AFTER FIELD rtag004 name="construct.a.page1.rtag004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtag004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag004
            #add-point:ON ACTION controlp INFIELD rtag004 name="construct.c.page1.rtag004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag005
            #add-point:BEFORE FIELD rtag005 name="construct.b.page1.rtag005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag005
            
            #add-point:AFTER FIELD rtag005 name="construct.a.page1.rtag005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtag005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag005
            #add-point:ON ACTION controlp INFIELD rtag005 name="construct.c.page1.rtag005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag006
            #add-point:BEFORE FIELD rtag006 name="construct.b.page1.rtag006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag006
            
            #add-point:AFTER FIELD rtag006 name="construct.a.page1.rtag006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtag006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag006
            #add-point:ON ACTION controlp INFIELD rtag006 name="construct.c.page1.rtag006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag007
            #add-point:BEFORE FIELD rtag007 name="construct.b.page1.rtag007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag007
            
            #add-point:AFTER FIELD rtag007 name="construct.a.page1.rtag007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtag007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag007
            #add-point:ON ACTION controlp INFIELD rtag007 name="construct.c.page1.rtag007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag008
            #add-point:BEFORE FIELD rtag008 name="construct.b.page1.rtag008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag008
            
            #add-point:AFTER FIELD rtag008 name="construct.a.page1.rtag008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtag008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag008
            #add-point:ON ACTION controlp INFIELD rtag008 name="construct.c.page1.rtag008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtagacti
            #add-point:BEFORE FIELD rtagacti name="construct.b.page1.rtagacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtagacti
            
            #add-point:AFTER FIELD rtagacti name="construct.a.page1.rtagacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtagacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtagacti
            #add-point:ON ACTION controlp INFIELD rtagacti name="construct.c.page1.rtagacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rtah002,rtahacti
           FROM s_detail2[1].rtah002,s_detail2[1].rtahacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.rtah002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtah002
            #add-point:ON ACTION controlp INFIELD rtah002 name="construct.c.page2.rtah002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtah002  #顯示到畫面上

            NEXT FIELD rtah002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtah002
            #add-point:BEFORE FIELD rtah002 name="construct.b.page2.rtah002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtah002
            
            #add-point:AFTER FIELD rtah002 name="construct.a.page2.rtah002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtahacti
            #add-point:BEFORE FIELD rtahacti name="construct.b.page2.rtahacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtahacti
            
            #add-point:AFTER FIELD rtahacti name="construct.a.page2.rtahacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtahacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtahacti
            #add-point:ON ACTION controlp INFIELD rtahacti name="construct.c.page2.rtahacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "rtaf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtag_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtah_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt205_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON rtafsite,rtafdocno,rtafdocdt,rtaf000,rtaf001,rtaf002,rtaf003,rtafacti
                          FROM s_browse[1].b_rtafsite,s_browse[1].b_rtafdocno,s_browse[1].b_rtafdocdt, 
                              s_browse[1].b_rtaf000,s_browse[1].b_rtaf001,s_browse[1].b_rtaf002,s_browse[1].b_rtaf003, 
                              s_browse[1].b_rtafacti
 
         BEFORE CONSTRUCT
               DISPLAY artt205_filter_parser('rtafsite') TO s_browse[1].b_rtafsite
            DISPLAY artt205_filter_parser('rtafdocno') TO s_browse[1].b_rtafdocno
            DISPLAY artt205_filter_parser('rtafdocdt') TO s_browse[1].b_rtafdocdt
            DISPLAY artt205_filter_parser('rtaf000') TO s_browse[1].b_rtaf000
            DISPLAY artt205_filter_parser('rtaf001') TO s_browse[1].b_rtaf001
            DISPLAY artt205_filter_parser('rtaf002') TO s_browse[1].b_rtaf002
            DISPLAY artt205_filter_parser('rtaf003') TO s_browse[1].b_rtaf003
            DISPLAY artt205_filter_parser('rtafacti') TO s_browse[1].b_rtafacti
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL artt205_filter_show('rtafsite')
   CALL artt205_filter_show('rtafdocno')
   CALL artt205_filter_show('rtafdocdt')
   CALL artt205_filter_show('rtaf000')
   CALL artt205_filter_show('rtaf001')
   CALL artt205_filter_show('rtaf002')
   CALL artt205_filter_show('rtaf003')
   CALL artt205_filter_show('rtafacti')
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt205_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="artt205.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt205_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = artt205_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt205_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_rtag_d.clear()
   CALL g_rtag2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt205_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt205_browser_fill("")
      CALL artt205_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL artt205_filter_show('rtafsite')
   CALL artt205_filter_show('rtafdocno')
   CALL artt205_filter_show('rtafdocdt')
   CALL artt205_filter_show('rtaf000')
   CALL artt205_filter_show('rtaf001')
   CALL artt205_filter_show('rtaf002')
   CALL artt205_filter_show('rtaf003')
   CALL artt205_filter_show('rtafacti')
   CALL artt205_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt205_fetch("F") 
      #顯示單身筆數
      CALL artt205_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt205_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_rtaf_m.rtafdocno = g_browser[g_current_idx].b_rtafdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
       g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
       g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp_desc, 
       g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafcnfid_desc 
 
   
   #遮罩相關處理
   LET g_rtaf_m_mask_o.* =  g_rtaf_m.*
   CALL artt205_rtaf_t_mask()
   LET g_rtaf_m_mask_n.* =  g_rtaf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt205_set_act_visible()   
   CALL artt205_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_rtaf_m.rtafstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtaf_m_t.* = g_rtaf_m.*
   LET g_rtaf_m_o.* = g_rtaf_m.*
   
   LET g_data_owner = g_rtaf_m.rtafownid      
   LET g_data_dept  = g_rtaf_m.rtafowndp
   
   #重新顯示   
   CALL artt205_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt205_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   #ken---add---s 需求單號：141208-00001 項次：11
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5  
   #ken---add---e
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtag_d.clear()   
   CALL g_rtag2_d.clear()  
 
 
   INITIALIZE g_rtaf_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtafdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtaf_m.rtafownid = g_user
      LET g_rtaf_m.rtafowndp = g_dept
      LET g_rtaf_m.rtafcrtid = g_user
      LET g_rtaf_m.rtafcrtdp = g_dept 
      LET g_rtaf_m.rtafcrtdt = cl_get_current()
      LET g_rtaf_m.rtafmodid = g_user
      LET g_rtaf_m.rtafmoddt = cl_get_current()
      LET g_rtaf_m.rtafstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rtaf_m.rtaf000 = "I"
      LET g_rtaf_m.rtafacti = "Y"
      LET g_rtaf_m.rtafstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_rtaf_m.rtafdocdt = cl_get_current()
      DISPLAY BY NAME g_rtaf_m.rtafdocdt
      LET g_rtaf_m.rtaf004 = g_user
      #ken---add---s 需求單號：141208-00001 項次：11
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'rtafsite',g_rtaf_m.rtafsite)
         RETURNING l_insert,g_rtaf_m.rtafsite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_rtaf_m.rtafunit = g_rtaf_m.rtafsite
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtaf_m.rtafsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_rtaf_m.rtafdocno = r_doctype
      #ken---add---e
      
      
     #LET g_rtaf_m.rtaf003 = 1
      #取得系统参数
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING g_rtaf_m.rtaf003
      IF cl_null(g_rtaf_m.rtaf003) THEN
         LET g_rtaf_m.rtaf003 = 1
      END IF
      DISPLAY BY NAME g_rtaf_m.rtaf003
      SELECT ooag003 INTO g_rtaf_m.rtaf005 FROM ooag_t WHERE ooag001 = g_rtaf_m.rtaf004 AND ooagent = g_enterprise
      DISPLAY BY NAME g_rtaf_m.rtaf005
      CALL artt205_rtaf004_desc(g_rtaf_m.rtaf004)
      CALL artt205_rtaf005_desc(g_rtaf_m.rtaf005)
      LET g_rtaf_m_t.* = g_rtaf_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtaf_m_t.* = g_rtaf_m.*
      LET g_rtaf_m_o.* = g_rtaf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtaf_m.rtafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL artt205_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_rtaf_m.* TO NULL
         INITIALIZE g_rtag_d TO NULL
         INITIALIZE g_rtag2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt205_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtag_d.clear()
      #CALL g_rtag2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt205_set_act_visible()   
   CALL artt205_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtafent = " ||g_enterprise|| " AND",
                      " rtafdocno = '", g_rtaf_m.rtafdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt205_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt205_cl
   
   CALL artt205_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
       g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
       g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp_desc, 
       g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_rtaf_m_mask_o.* =  g_rtaf_m.*
   CALL artt205_rtaf_t_mask()
   LET g_rtaf_m_mask_n.* =  g_rtaf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000, 
       g_rtaf_m.rtaf001,g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002,g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005, 
       g_rtaf_m.rtaf005_desc,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp,g_rtaf_m.rtafowndp_desc,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtid_desc, 
       g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid,g_rtaf_m.rtafmodid_desc, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfid_desc,g_rtaf_m.rtafcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtaf_m.rtafownid      
   LET g_data_dept  = g_rtaf_m.rtafowndp
   
   #功能已完成,通報訊息中心
   CALL artt205_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt205_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_rtaf_m.rtafstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = g_rtaf_m.rtafdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF    
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtaf_m_t.* = g_rtaf_m.*
   LET g_rtaf_m_o.* = g_rtaf_m.*
   
   IF g_rtaf_m.rtafdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
   CALL s_transaction_begin()
   
   OPEN artt205_cl USING g_enterprise,g_rtaf_m.rtafdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
       g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
       g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp_desc, 
       g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT artt205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtaf_m_mask_o.* =  g_rtaf_m.*
   CALL artt205_rtaf_t_mask()
   LET g_rtaf_m_mask_n.* =  g_rtaf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL artt205_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtaf_m.rtafmodid = g_user 
LET g_rtaf_m.rtafmoddt = cl_get_current()
LET g_rtaf_m.rtafmodid_desc = cl_get_username(g_rtaf_m.rtafmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_rtaf_m.rtafstus MATCHES "[DR]" THEN
         LET g_rtaf_m.rtafstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt205_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtaf_t SET (rtafmodid,rtafmoddt) = (g_rtaf_m.rtafmodid,g_rtaf_m.rtafmoddt)
          WHERE rtafent = g_enterprise AND rtafdocno = g_rtafdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtaf_m.* = g_rtaf_m_t.*
            CALL artt205_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtaf_m.rtafdocno != g_rtaf_m_t.rtafdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rtag_t SET rtagdocno = g_rtaf_m.rtafdocno
 
          WHERE rtagent = g_enterprise AND rtagdocno = g_rtaf_m_t.rtafdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtag_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtag_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE rtah_t
            SET rtahdocno = g_rtaf_m.rtafdocno
 
          WHERE rtahent = g_enterprise AND
                rtahdocno = g_rtafdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtah_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt205_set_act_visible()   
   CALL artt205_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtafent = " ||g_enterprise|| " AND",
                      " rtafdocno = '", g_rtaf_m.rtafdocno, "' "
 
   #填到對應位置
   CALL artt205_browser_fill("")
 
   CLOSE artt205_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt205_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt205.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt205_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   #ken---add---s 需求單號：141208-00001 項次：11
   DEFINE  l_success       LIKE type_t.chr1
   DEFINE  l_errno         LIKE type_t.chr10 
   #ken---add---e
   DEFINE l_cnt_rtad       LIKE type_t.num5 #add by dengdd 160113
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000, 
       g_rtaf_m.rtaf001,g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002,g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005, 
       g_rtaf_m.rtaf005_desc,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp,g_rtaf_m.rtafowndp_desc,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtid_desc, 
       g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid,g_rtaf_m.rtafmodid_desc, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfid_desc,g_rtaf_m.rtafcnfdt
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rtag001,rtag002,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008,rtagacti  
       FROM rtag_t WHERE rtagent=? AND rtagdocno=? AND rtag002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt205_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rtah001,rtah002,rtahacti FROM rtah_t WHERE rtahent=? AND rtahdocno=? AND  
       rtah002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt205_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt205_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL artt205_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001, 
       g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002,g_rtaf_m.rtaf004, 
       g_rtaf_m.rtaf003,g_rtaf_m.rtafacti
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt205.input.head" >}
      #單頭段
      INPUT BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001, 
          g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002,g_rtaf_m.rtaf004, 
          g_rtaf_m.rtaf003,g_rtaf_m.rtafacti 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_rtaf_m.rtafdocno)  THEN
                  CALL n_rtafl(g_rtaf_m.rtafdocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtaf_m.rtafdocno
                  CALL ap_ref_array2(g_ref_fields," SELECT rtafl002,rtafl003 FROM rtafl_t WHERE rtaflent = '"
                      ||g_enterprise||"' AND rtafldocno = ? AND rtafl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rtaf_m.rtafl002 = g_rtn_fields[1]
                  LET g_rtaf_m.rtafl003 = g_rtn_fields[2]

                  DISPLAY BY NAME g_rtaf_m.rtafl002
                  DISPLAY BY NAME g_rtaf_m.rtafl003
               END IF 
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt205_cl USING g_enterprise,g_rtaf_m.rtafdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.rtafldocno = g_rtaf_m.rtafdocno
LET g_master_multi_table_t.rtafl002 = g_rtaf_m.rtafl002
LET g_master_multi_table_t.rtafl003 = g_rtaf_m.rtafl003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.rtafldocno = ''
LET g_master_multi_table_t.rtafl002 = ''
LET g_master_multi_table_t.rtafl003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt205_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL artt205_set_entry(p_cmd)
            CALL artt205_set_no_entry(p_cmd)
            #end add-point
            CALL artt205_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafsite
            
            #add-point:AFTER FIELD rtafsite name="input.a.rtafsite"
            #ken---add---s 需求單號：141208-00001 項次：17
            IF NOT cl_null(g_rtaf_m.rtafsite) THEN
               CALL s_aooi500_chk(g_prog,'rtafsite',g_rtaf_m.rtafsite,g_rtaf_m.rtafsite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_rtaf_m.rtafsite = g_rtaf_m_t.rtafsite
                  CALL s_desc_get_department_desc(g_rtaf_m.rtafsite)
                     RETURNING g_rtaf_m.rtafsite_desc
                  DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL artt205_set_entry(p_cmd)
               CALL artt205_set_no_entry(p_cmd)
            END IF              
           
            CALL s_desc_get_department_desc(g_rtaf_m.rtafsite)
               RETURNING g_rtaf_m.rtafsite_desc
            DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc               
            #ken---add---e            
            
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_rtaf_m.rtafsite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_rtaf_m.rtafsite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_rtaf_m.rtafsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafsite
            #add-point:BEFORE FIELD rtafsite name="input.b.rtafsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafsite
            #add-point:ON CHANGE rtafsite name="input.g.rtafsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafdocdt
            #add-point:BEFORE FIELD rtafdocdt name="input.b.rtafdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafdocdt
            
            #add-point:AFTER FIELD rtafdocdt name="input.a.rtafdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafdocdt
            #add-point:ON CHANGE rtafdocdt name="input.g.rtafdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafdocno
            #add-point:BEFORE FIELD rtafdocno name="input.b.rtafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafdocno
            
            #add-point:AFTER FIELD rtafdocno name="input.a.rtafdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_rtaf_m.rtafdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_rtaf_m.rtafdocno != g_rtafdocno_t ))) THEN 
                  IF NOT s_aooi200_chk_slip(g_site,'',g_rtaf_m.rtafdocno,g_prog) THEN
                     LET g_rtaf_m.rtafdocno = g_rtafdocno_t
                     DISPLAY BY NAME g_rtaf_m.rtafdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafdocno
            #add-point:ON CHANGE rtafdocno name="input.g.rtafdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf000
            #add-point:BEFORE FIELD rtaf000 name="input.b.rtaf000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf000
            
            #add-point:AFTER FIELD rtaf000 name="input.a.rtaf000"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaf000
            #add-point:ON CHANGE rtaf000 name="input.g.rtaf000"
            CALL artt205_set_entry(p_cmd)
            CALL artt205_set_no_entry(p_cmd)
            IF NOT (cl_null(g_rtaf_m.rtaf001) AND cl_null(g_rtaf_m.rtaf002) AND cl_null(g_rtaf_m.rtaf003)) THEN
              # IF cl_ask_confirm('') THEN
                  LET g_rtaf_m.rtaf001 = ''
                  LET g_rtaf_m.rtaf002 = ''
                  LET g_rtaf_m.rtaf003 = '' 
                  LET g_rtaf_m.rtafacti = 'Y'    
                  LET g_rtaf_m.rtafl002 = ''
                  LET g_rtaf_m.rtafl003 = ''
                  CALL artt205_rtaf002_desc('')
                  DISPLAY BY NAME g_rtaf_m.rtafl002
                  DISPLAY BY NAME g_rtaf_m.rtafl003                  
                  DISPLAY BY NAME  g_rtaf_m.rtaf001, g_rtaf_m.rtaf002, g_rtaf_m.rtaf003,g_rtaf_m.rtafacti                  
              # END IF
            END IF
            IF g_rtaf_m.rtaf000 = 'I' THEN
               #取得系统参数
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING g_rtaf_m.rtaf003
               IF cl_null(g_rtaf_m.rtaf003) THEN
                  LET g_rtaf_m.rtaf003 = 1
               END IF
               DISPLAY BY NAME g_rtaf_m.rtaf003
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf001
            #add-point:BEFORE FIELD rtaf001 name="input.b.rtaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf001
            
            #add-point:AFTER FIELD rtaf001 name="input.a.rtaf001"
            CALL artt205_rtaf001_desc('',g_rtaf_m.rtaf000)
            #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtaf_m.rtaf001 != g_rtaf_m_t.rtaf001)) THEN   #160824-00007#159 20161125 mark by beckxie
            IF g_rtaf_m.rtaf001 != g_rtaf_m_o.rtaf001 OR cl_null(g_rtaf_m_o.rtaf001) THEN   #160824-00007#159 20161125 add by beckxie
               IF NOT cl_null(g_rtaf_m.rtaf001) THEN
                  CALL artt205_rtaf001_chk(g_rtaf_m.rtaf001) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtaf_m.rtaf001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtaf_m.rtaf001 = g_rtaf_m_t.rtaf001   #160824-00007#159 20161125 mark by beckxie
                     #CALL artt205_rtaf001_desc(g_rtaf_m.rtaf001,g_rtaf_m.rtaf000)   #160824-00007#159 20161125 mark by beckxie
                     #160824-00007#159 20161125 add by beckxie---S
                     LET g_rtaf_m.rtaf001 = g_rtaf_m_o.rtaf001   
                     LET g_rtaf_m.rtaf002 = g_rtaf_m_o.rtaf002 
                     LET g_rtaf_m.rtaf003 = g_rtaf_m_o.rtaf003 
                     LET g_rtaf_m.rtafacti =g_rtaf_m_o.rtafacti
                     LET g_rtaf_m.rtaf002_desc =g_rtaf_m_o.rtaf002_desc
                     #160824-00007#159 20161125 add by beckxie---E
                     
                     NEXT FIELD CURRENT
                  END IF   
                  CALL artt205_rtaf001_desc(g_rtaf_m.rtaf001,g_rtaf_m.rtaf000)
               END IF
            END IF
            LET g_rtaf_m_o.* = g_rtaf_m.*   #160824-00007#159 20161125 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaf001
            #add-point:ON CHANGE rtaf001 name="input.g.rtaf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafl002
            #add-point:BEFORE FIELD rtafl002 name="input.b.rtafl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafl002
            
            #add-point:AFTER FIELD rtafl002 name="input.a.rtafl002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafl002
            #add-point:ON CHANGE rtafl002 name="input.g.rtafl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafunit
            #add-point:BEFORE FIELD rtafunit name="input.b.rtafunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafunit
            
            #add-point:AFTER FIELD rtafunit name="input.a.rtafunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafunit
            #add-point:ON CHANGE rtafunit name="input.g.rtafunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafl003
            #add-point:BEFORE FIELD rtafl003 name="input.b.rtafl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafl003
            
            #add-point:AFTER FIELD rtafl003 name="input.a.rtafl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafl003
            #add-point:ON CHANGE rtafl003 name="input.g.rtafl003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf006
            
            #add-point:AFTER FIELD rtaf006 name="input.a.rtaf006"
            #151214-00017#12 add by dengdd 160113(S)
            IF NOT cl_null(g_rtaf_m.rtaf006) THEN
               LET g_rtaf_m.rtaf003=cl_get_para(g_enterprise,g_rtaf_m.rtafsite,'E-CIR-0001')
            END IF
            #151214-00017#12 add by dengdd 160113(E)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtaf_m.rtaf006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtaf_m.rtaf006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtaf_m.rtaf006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf006
            #add-point:BEFORE FIELD rtaf006 name="input.b.rtaf006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaf006
            #add-point:ON CHANGE rtaf006 name="input.g.rtaf006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf002
            
            #add-point:AFTER FIELD rtaf002 name="input.a.rtaf002"
            CALL artt205_rtaf002_desc('')
            IF NOT cl_null(g_rtaf_m.rtaf002) THEN 
               CALL artt205_rtaf002_chk(g_rtaf_m.rtaf002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtaf_m.rtaf002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtaf_m.rtaf002 = g_rtaf_m_t.rtaf002
                  CALL artt205_rtaf002_desc(g_rtaf_m.rtaf002)
                  NEXT FIELD CURRENT
               END IF
            END IF    
            CALL artt205_rtaf002_desc(g_rtaf_m.rtaf002)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf002
            #add-point:BEFORE FIELD rtaf002 name="input.b.rtaf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaf002
            #add-point:ON CHANGE rtaf002 name="input.g.rtaf002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf004
            
            #add-point:AFTER FIELD rtaf004 name="input.a.rtaf004"
            CALL artt205_rtaf004_desc('')
            LET g_rtaf_m.rtaf005 = ''
            CALL artt205_rtaf005_desc('')            
            IF NOT cl_null(g_rtaf_m.rtaf004) THEN 
               CALL artt205_rtaf004_chk(g_rtaf_m.rtaf004)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtaf_m.rtaf004
                  #160318-00005#42 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'aooi130'
                        LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi130'
                  END CASE
                  #160318-00005#42 --s add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtaf_m.rtaf004 = g_rtaf_m_t.rtaf004
                  SELECT ooag003 INTO g_rtaf_m.rtaf005 FROM ooag_t WHERE ooag001 = g_rtaf_m.rtaf004 AND ooagent = g_enterprise
                  CALL artt205_rtaf004_desc(g_rtaf_m.rtaf004)
                  CALL artt205_rtaf005_desc(g_rtaf_m.rtaf005)
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_rtaf_m.rtaf005 FROM ooag_t WHERE ooag001 = g_rtaf_m.rtaf004 AND ooagent = g_enterprise     
            END IF 
                   
            CALL artt205_rtaf004_desc(g_rtaf_m.rtaf004)
            CALL artt205_rtaf005_desc(g_rtaf_m.rtaf005)
            DISPLAY BY NAME g_rtaf_m.rtaf005
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf004
            #add-point:BEFORE FIELD rtaf004 name="input.b.rtaf004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaf004
            #add-point:ON CHANGE rtaf004 name="input.g.rtaf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaf003
            #add-point:BEFORE FIELD rtaf003 name="input.b.rtaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaf003
            
            #add-point:AFTER FIELD rtaf003 name="input.a.rtaf003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaf003
            #add-point:ON CHANGE rtaf003 name="input.g.rtaf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtafacti
            #add-point:BEFORE FIELD rtafacti name="input.b.rtafacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtafacti
            
            #add-point:AFTER FIELD rtafacti name="input.a.rtafacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtafacti
            #add-point:ON CHANGE rtafacti name="input.g.rtafacti"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtafsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafsite
            #add-point:ON ACTION controlp INFIELD rtafsite name="input.c.rtafsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            #ken---add---s 需求單號：141208-00001 項次：11
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtaf_m.rtafsite             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtafsite',g_rtaf_m.rtafsite,'i')   #150308-00001#5  By benson add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtaf_m.rtafsite = g_qryparam.return1              

            DISPLAY g_rtaf_m.rtafsite TO rtafsite              #

            NEXT FIELD rtafsite                          #返回原欄位
            #ken---add---e

            #END add-point
 
 
         #Ctrlp:input.c.rtafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafdocdt
            #add-point:ON ACTION controlp INFIELD rtafdocdt name="input.c.rtafdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafdocno
            #add-point:ON ACTION controlp INFIELD rtafdocno name="input.c.rtafdocno"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'               
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtaf_m.rtafdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "artt205" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rtaf_m.rtafdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtaf_m.rtafdocno TO rtafdocno              #顯示到畫面上

            NEXT FIELD rtafdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtaf000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf000
            #add-point:ON ACTION controlp INFIELD rtaf000 name="input.c.rtaf000"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf001
            #add-point:ON ACTION controlp INFIELD rtaf001 name="input.c.rtaf001"
#此段落由子樣板a07產生            
            #開窗i段
            IF g_rtaf_m.rtaf000 = 'U' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'   
               LET g_qryparam.reqry = FALSE

               LET g_qryparam.default1 = g_rtaf_m.rtaf001             #給予default值
               LET g_qryparam.default2 = "" #g_rtaf_m.rtacl003 #說明
     
               #給予arg
     
               CALL q_rtac001()                                #呼叫開窗
     
               LET g_rtaf_m.rtaf001 = g_qryparam.return1              #將開窗取得的值回傳到變數
               #LET g_rtaf_m.rtacl003 = g_qryparam.return2 #說明
               CALL artt205_rtaf001_desc(g_rtaf_m.rtaf001,g_rtaf_m.rtaf000)
               DISPLAY g_rtaf_m.rtaf001 TO rtaf001              #顯示到畫面上
               #DISPLAY g_rtaf_m.rtacl003 TO rtacl003 #說明
     
               NEXT FIELD rtaf001                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.rtafl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafl002
            #add-point:ON ACTION controlp INFIELD rtafl002 name="input.c.rtafl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtafunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafunit
            #add-point:ON ACTION controlp INFIELD rtafunit name="input.c.rtafunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtafl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafl003
            #add-point:ON ACTION controlp INFIELD rtafl003 name="input.c.rtafl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtaf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf006
            #add-point:ON ACTION controlp INFIELD rtaf006 name="input.c.rtaf006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            LET g_rtaf_m.rtaf006 = g_qryparam.return1
            DISPLAY g_rtaf_m.rtaf006 TO rtaf006  #顯示到畫面上
            CALL artt205_rtaf006_ref()
            NEXT FIELD rtaf006                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.rtaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf002
            #add-point:ON ACTION controlp INFIELD rtaf002 name="input.c.rtaf002"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'               
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtaf_m.rtaf002             #給予default值

            #給予arg
            #huangrh modify to q_rtaa001_3()-----20150603
            CALL q_rtaa001_3()                                #呼叫開窗

            LET g_rtaf_m.rtaf002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL artt205_rtaf002_desc(g_rtaf_m.rtaf002) 
            DISPLAY g_rtaf_m.rtaf002 TO rtaf002              #顯示到畫面上

            NEXT FIELD rtaf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf004
            #add-point:ON ACTION controlp INFIELD rtaf004 name="input.c.rtaf004"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'               
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtaf_m.rtaf004             #給予default值
            LET g_qryparam.default2 = "" #g_rtaf_m.oofa011 #全名

            #給予arg

            CALL q_ooag001_3()                                #呼叫開窗

            LET g_rtaf_m.rtaf004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_rtaf_m.oofa011 = g_qryparam.return2 #全名
            DISPLAY g_rtaf_m.rtaf004 TO rtaf004    
            SELECT ooag003 INTO g_rtaf_m.rtaf005 FROM ooag_t WHERE ooag001 = g_rtaf_m.rtaf004 AND ooagent = g_enterprise
            DISPLAY g_rtaf_m.rtaf005 TO rtaf005    
            CALL artt205_rtaf004_desc(g_rtaf_m.rtaf004)
            CALL artt205_rtaf005_desc(g_rtaf_m.rtaf005)
                      #顯示到畫面上
            #DISPLAY g_rtaf_m.oofa011 TO oofa011 #全名

            NEXT FIELD rtaf004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtaf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaf003
            #add-point:ON ACTION controlp INFIELD rtaf003 name="input.c.rtaf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtafacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtafacti
            #add-point:ON ACTION controlp INFIELD rtafacti name="input.c.rtafacti"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtaf_m.rtafdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  IF NOT cl_null(g_rtaf_m.rtafdocno) THEN
                     CALL s_aooi200_gen_docno(g_site,g_rtaf_m.rtafdocno,g_rtaf_m.rtafdocdt,g_prog) 
                     RETURNING  g_success,g_rtaf_m.rtafdocno
                     IF g_success<>'1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "amm-00001"
                        LET g_errparam.extend = g_rtaf_m.rtafdocno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_rtaf_m.rtafdocno = g_rtafdocno_t
                        NEXT FIELD rtafdocno
                     ELSE
                        IF NOT ap_chk_notDup(g_rtaf_m.rtafdocno,"SELECT COUNT(*) FROM rtaf_t WHERE "||"rtafent = '" ||g_enterprise|| "' AND "||"rtafdocno = '"||g_rtaf_m.rtafdocno ||"'",'std-00004',0) THEN 
                           LET g_rtaf_m.rtafdocno = g_rtafdocno_t
                           NEXT FIELD rtafdocno
                        END IF    
                                      
                     END IF
                  END IF  
                  LET g_rtaf_m.rtafunit = g_rtaf_m.rtafsite #ken---add 需求單號：141208-00001 項次：11
               #end add-point
               
               INSERT INTO rtaf_t (rtafent,rtafsite,rtafdocdt,rtafdocno,rtaf000,rtaf001,rtafunit,rtaf006, 
                   rtaf002,rtaf004,rtaf005,rtaf003,rtafacti,rtafstus,rtafownid,rtafowndp,rtafcrtid,rtafcrtdp, 
                   rtafcrtdt,rtafmodid,rtafmoddt,rtafcnfid,rtafcnfdt)
               VALUES (g_enterprise,g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000, 
                   g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002,g_rtaf_m.rtaf004, 
                   g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
                   g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
                   g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtaf_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_rtaf_m.rtafdocno = g_master_multi_table_t.rtafldocno AND
         g_rtaf_m.rtafl002 = g_master_multi_table_t.rtafl002 AND 
         g_rtaf_m.rtafl003 = g_master_multi_table_t.rtafl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtaflent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtaf_m.rtafdocno
            LET l_field_keys[02] = 'rtafldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.rtafldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtafl001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_rtaf_m.rtafl002
            LET l_fields[01] = 'rtafl002'
            LET l_vars[02] = g_rtaf_m.rtafl003
            LET l_fields[02] = 'rtafl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtafl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
#151214-00017#12  mark by dengdd 160113(S)
#                  IF g_rtaf_m.rtaf000 = 'U' THEN
#                     INSERT INTO rtag_t(rtagent,rtagdocno,rtag001,rtag002,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008,rtagacti)
#                      SELECT g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,rtad002,rtad003,rtad004,rtad005,rtad006,rtad007,rtad008,rtadstus
#                        FROM rtad_t WHERE rtadent = g_enterprise AND rtad001 = g_rtaf_m.rtaf001
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "rtag_t"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#  
#                        CALL s_transaction_end('N','0') 
#                     ELSE
#                        INSERT INTO rtah_t(rtahent,rtahdocno,rtah001,rtah002,rtahacti)
#                        SELECT g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,rtae002,rtaestus
#                          FROM rtae_t WHERE rtaeent = g_enterprise AND rtae001 = g_rtaf_m.rtaf001           
#                        IF SQLCA.sqlcode THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = SQLCA.sqlcode
#                           LET g_errparam.extend = "rtah_t"
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#  
#                           CALL s_transaction_end('N','0')  
#                        END IF
#                     END IF      
#                  ELSE
#                     INSERT INTO rtag_t(rtagent,rtagdocno,rtag001,rtag002,rtagacti)
#                     SELECT g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,rtax001,'Y' FROM rtax_t
#                      WHERE rtax004 = g_rtaf_m.rtaf003 AND rtaxstus = 'Y' AND rtaxent = g_enterprise 
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "g_rtaf_m"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#  
#                        CALL s_transaction_end('N','0')
#                        NEXT FIELD rtafdocno
#                     END IF                  
#                     INSERT INTO rtah_t(rtahent,rtahdocno,rtah001,rtah002,rtahacti)
#                     SELECT g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,rtab002,'Y' FROM rtab_t,rtaa_t
#                       WHERE rtabent = rtaaent AND rtab001 = rtaa001 
#                         AND rtaa001 = g_rtaf_m.rtaf002
#                         AND rtaastus = 'Y' AND rtabent = g_enterprise
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "g_rtaf_m"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#  
#                        CALL s_transaction_end('N','0')
#                        NEXT FIELD rtafdocno
#                     END IF                  
#                  END IF
#151214-00017#12  mark by dengdd 160113(E)
#151214-00017#12  mark by dengdd 160113(S)       
                  IF g_rtaf_m.rtaf000 = 'U' THEN
                     INSERT INTO rtag_t(rtagent,rtagdocno,rtag001,rtag002,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008,rtagacti)
                     SELECT DISTINCT g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,rtad002,rtad003,rtad004,rtad005,rtad006,rtad007,rtad008,rtadstus
                       FROM rtad_t WHERE rtadent = g_enterprise AND rtad001 = g_rtaf_m.rtaf001
                    IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "rtag_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0') 
                    ELSE
                       INSERT INTO rtah_t(rtahent,rtahdocno,rtah001,rtah002,rtahacti)
                       SELECT DISTINCT g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,rtadsite,'Y'
                         FROM rtad_t WHERE rtadent = g_enterprise AND rtad001 = g_rtaf_m.rtaf001           
                       IF SQLCA.sqlcode THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = SQLCA.sqlcode
                          LET g_errparam.extend = "rtah_t"
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          CALL s_transaction_end('N','0')  
                       END IF
                    END IF 
                  END IF       
#151214-00017#12  mark by dengdd 160113(E)                  
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL artt205_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt205_b_fill()
                  CALL artt205_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL artt205_rtaf_t_mask_restore('restore_mask_o')
               
               UPDATE rtaf_t SET (rtafsite,rtafdocdt,rtafdocno,rtaf000,rtaf001,rtafunit,rtaf006,rtaf002, 
                   rtaf004,rtaf005,rtaf003,rtafacti,rtafstus,rtafownid,rtafowndp,rtafcrtid,rtafcrtdp, 
                   rtafcrtdt,rtafmodid,rtafmoddt,rtafcnfid,rtafcnfdt) = (g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
                   g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006, 
                   g_rtaf_m.rtaf002,g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti, 
                   g_rtaf_m.rtafstus,g_rtaf_m.rtafownid,g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp, 
                   g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid,g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt) 
 
                WHERE rtafent = g_enterprise AND rtafdocno = g_rtafdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtaf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_rtaf_m.rtafdocno = g_master_multi_table_t.rtafldocno AND
         g_rtaf_m.rtafl002 = g_master_multi_table_t.rtafl002 AND 
         g_rtaf_m.rtafl003 = g_master_multi_table_t.rtafl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtaflent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtaf_m.rtafdocno
            LET l_field_keys[02] = 'rtafldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.rtafldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'rtafl001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_rtaf_m.rtafl002
            LET l_fields[01] = 'rtafl002'
            LET l_vars[02] = g_rtaf_m.rtafl003
            LET l_fields[02] = 'rtafl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtafl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL artt205_rtaf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtaf_m_t)
               LET g_log2 = util.JSON.stringify(g_rtaf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt205.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtag_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #检查rtad_t是否有符合条件的资料
            CALL artt205_cnt_rtad() RETURNING l_cnt_rtad
            IF l_cnt_rtad>0 THEN
               IF cl_ask_confirm('art-00743') THEN
                  CALL artt205_02(g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,g_rtaf_m.rtaf006)
                  CALL artt205_b_fill()
               END IF
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtag_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt205_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtag_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artt205_cl USING g_enterprise,g_rtaf_m.rtafdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtag_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtag_d[l_ac].rtag002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtag_d_t.* = g_rtag_d[l_ac].*  #BACKUP
               LET g_rtag_d_o.* = g_rtag_d[l_ac].*  #BACKUP
               CALL artt205_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               #160504-00016#1 by 08172
               IF g_rtaf_m.rtaf000='U' THEN
                  IF NOT cl_null(g_rtag_d[l_ac].rtag002) THEN
                     SELECT COUNT(*) INTO l_n FROM rtad_t WHERE rtadent=g_enterprise AND rtad002=g_rtag_d[l_ac].rtag002 AND rtad001=g_rtag_d[l_ac].rtag001
                     IF l_n=0 THEN
                        LET g_rtag_d[l_ac].rtagacti='Y'
                        CALL cl_set_comp_entry("rtagacti",FALSE)
                     END IF 
                  END IF
               END IF
               #end add-point  
               CALL artt205_set_no_entry_b(l_cmd)
               IF NOT artt205_lock_b("rtag_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt205_bcl INTO g_rtag_d[l_ac].rtag001,g_rtag_d[l_ac].rtag002,g_rtag_d[l_ac].rtag003, 
                      g_rtag_d[l_ac].rtag004,g_rtag_d[l_ac].rtag005,g_rtag_d[l_ac].rtag006,g_rtag_d[l_ac].rtag007, 
                      g_rtag_d[l_ac].rtag008,g_rtag_d[l_ac].rtagacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtag_d_t.rtag002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtag_d_mask_o[l_ac].* =  g_rtag_d[l_ac].*
                  CALL artt205_rtag_t_mask()
                  LET g_rtag_d_mask_n[l_ac].* =  g_rtag_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt205_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtag_d[l_ac].* TO NULL 
            INITIALIZE g_rtag_d_t.* TO NULL 
            INITIALIZE g_rtag_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtag_d[l_ac].rtagacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_rtag_d_t.* = g_rtag_d[l_ac].*     #新輸入資料
            LET g_rtag_d_o.* = g_rtag_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt205_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artt205_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtag_d[li_reproduce_target].* = g_rtag_d[li_reproduce].*
 
               LET g_rtag_d[li_reproduce_target].rtag002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_rtag_d[l_ac].rtag001 = g_rtaf_m.rtaf001
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtag_t 
             WHERE rtagent = g_enterprise AND rtagdocno = g_rtaf_m.rtafdocno
 
               AND rtag002 = g_rtag_d[l_ac].rtag002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtaf_m.rtafdocno
               LET gs_keys[2] = g_rtag_d[g_detail_idx].rtag002
               CALL artt205_insert_b('rtag_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtag_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtag_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt205_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtaf_m.rtafdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtag_d_t.rtag002
 
            
               #刪除同層單身
               IF NOT artt205_delete_b('rtag_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt205_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt205_key_delete_b(gs_keys,'rtag_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt205_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt205_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rtag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtag_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag002
            
            #add-point:AFTER FIELD rtag002 name="input.a.page1.rtag002"
            CALL artt205_rtag002_desc('')
            CALL artt205_rtag002_desc1('') 
            IF  NOT cl_null(g_rtaf_m.rtafdocno) AND NOT cl_null(g_rtag_d[g_detail_idx].rtag002) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_rtaf_m.rtafdocno != g_rtafdocno_t OR g_rtag_d[g_detail_idx].rtag002 != g_rtag_d_t.rtag002))) THEN    #160824-00007#159 20161125 mark by beckxie
               IF g_rtaf_m.rtafdocno != g_rtafdocno_t OR (g_rtag_d[g_detail_idx].rtag002 != g_rtag_d_o.rtag002 OR cl_null(g_rtag_d_o.rtag002) ) THEN    #160824-00007#159 20161125 add by beckxie
                  IF NOT ap_chk_notDup(g_rtag_d[g_detail_idx].rtag002,"SELECT COUNT(*) FROM rtag_t WHERE "||"rtagent = '" ||g_enterprise|| "' AND "||"rtagdocno = '"||g_rtaf_m.rtafdocno ||"' AND "|| "rtag002 = '"||g_rtag_d[g_detail_idx].rtag002 ||"'",'std-00004',1) THEN 
                     #160824-00007#159 20161125 mark by beckxie---S
                     #LET g_rtag_d[l_ac].rtag002 = g_rtag_d_t.rtag002   
                     #CALL artt205_rtag002_desc(g_rtag_d[l_ac].rtag002)
                     #CALL artt205_rtag002_desc1(g_rtag_d[l_ac].rtag002)
                     #160824-00007#159 20161125 mark by beckxie---E
                     #160824-00007#159 20161125 add by beckxie---S
                     LET g_rtag_d[l_ac].rtag002 = g_rtag_d_o.rtag002
                     LET g_rtag_d[l_ac].rtag002_desc = g_rtag_d_o.rtag002_desc
                     LET g_rtag_d[l_ac].rtax003 = g_rtag_d_o.rtax003
                     LET g_rtag_d[l_ac].rtax003_desc = g_rtag_d_o.rtax003_desc
                     #160824-00007#159 20161125 add by beckxie---E
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF

               CALL artt205_rtag002_chk(g_rtag_d[l_ac].rtag002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtag_d[l_ac].rtag002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #160824-00007#159 20161125 mark by beckxie---S
                  #LET g_rtag_d[l_ac].rtag002 = g_rtag_d_t.rtag002   
                  #CALL artt205_rtag002_desc(g_rtag_d[l_ac].rtag002)
                  #CALL artt205_rtag002_desc1(g_rtag_d[l_ac].rtag002)
                  #160824-00007#159 20161125 mark by beckxie---E
                  #160824-00007#159 20161125 add by beckxie---S
                  LET g_rtag_d[l_ac].rtag002 = g_rtag_d_o.rtag002
                  LET g_rtag_d[l_ac].rtag002_desc = g_rtag_d_o.rtag002_desc
                  LET g_rtag_d[l_ac].rtax003 = g_rtag_d_o.rtax003
                  LET g_rtag_d[l_ac].rtax003_desc = g_rtag_d_o.rtax003_desc
                  #160824-00007#159 20161125 add by beckxie---E
                  NEXT FIELD CURRENT
               END IF
            END IF               
            CALL artt205_rtag002_desc(g_rtag_d[l_ac].rtag002)
            CALL artt205_rtag002_desc1(g_rtag_d[l_ac].rtag002)
            #160504-00016#1 by 08172
            IF g_rtaf_m.rtaf000='U' THEN
               IF NOT cl_null(g_rtag_d[l_ac].rtag002) THEN
                  SELECT COUNT(*) INTO l_n FROM rtad_t WHERE rtadent=g_enterprise  AND rtad002=g_rtag_d[l_ac].rtag002 AND rtad001=g_rtag_d[l_ac].rtag001
                  IF l_n=0 THEN
                     LET g_rtag_d[l_ac].rtagacti='Y'
                     CALL cl_set_comp_entry("rtagacti",FALSE)
                  END IF 
               END IF
            END IF
            
            LET g_rtag_d_o.* = g_rtag_d[l_ac].*   #160824-00007#159 20161125 add by beckxie
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag002
            #add-point:BEFORE FIELD rtag002 name="input.b.page1.rtag002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag002
            #add-point:ON CHANGE rtag002 name="input.g.page1.rtag002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag003
            
            #add-point:AFTER FIELD rtag003 name="input.a.page1.rtag003"
            CALL artt205_rtag003_desc('')
            IF NOT cl_null(g_rtag_d[l_ac].rtag003) THEN
               CALL artt205_rtag003_chk(g_rtag_d[l_ac].rtag003)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtag_d[l_ac].rtag003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtag_d[l_ac].rtag003 = g_rtag_d_t.rtag003
                  CALL artt205_rtag003_desc(g_rtag_d[l_ac].rtag003)
                  NEXT FIELD CURRENT
               END IF
            END IF  
            CALL artt205_rtag003_desc(g_rtag_d[l_ac].rtag003)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag003
            #add-point:BEFORE FIELD rtag003 name="input.b.page1.rtag003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag003
            #add-point:ON CHANGE rtag003 name="input.g.page1.rtag003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtag_d[l_ac].rtag004,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtag004
            END IF 
 
 
 
            #add-point:AFTER FIELD rtag004 name="input.a.page1.rtag004"
            IF NOT cl_null(g_rtag_d[l_ac].rtag003) THEN 
               IF g_rtag_d[l_ac].rtag003 = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'azz-00079'
                  LET g_errparam.extend = g_rtag_d[l_ac].rtag003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtag_d[l_ac].rtag003 = g_rtag_d_t.rtag003
                  NEXT FIELD rtag003
               END IF   
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag004
            #add-point:BEFORE FIELD rtag004 name="input.b.page1.rtag004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag004
            #add-point:ON CHANGE rtag004 name="input.g.page1.rtag004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtag_d[l_ac].rtag005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtag005
            END IF 
 
 
 
            #add-point:AFTER FIELD rtag005 name="input.a.page1.rtag005"
            IF NOT cl_null(g_rtag_d[l_ac].rtag005) THEN 
               IF NOT cl_null(g_rtag_d[l_ac].rtag006) THEN
                  IF g_rtag_d[l_ac].rtag005 < g_rtag_d[l_ac].rtag006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00070'
                     LET g_errparam.extend = g_rtag_d[l_ac].rtag005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD rtag005
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag005
            #add-point:BEFORE FIELD rtag005 name="input.b.page1.rtag005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag005
            #add-point:ON CHANGE rtag005 name="input.g.page1.rtag005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtag_d[l_ac].rtag006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtag006
            END IF 
 
 
 
            #add-point:AFTER FIELD rtag006 name="input.a.page1.rtag006"
            IF NOT cl_null(g_rtag_d[l_ac].rtag006) THEN 
               IF NOT cl_null(g_rtag_d[l_ac].rtag005) THEN
                  IF g_rtag_d[l_ac].rtag005 < g_rtag_d[l_ac].rtag006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00070'
                     LET g_errparam.extend = g_rtag_d[l_ac].rtag006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD rtag006
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag006
            #add-point:BEFORE FIELD rtag006 name="input.b.page1.rtag006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag006
            #add-point:ON CHANGE rtag006 name="input.g.page1.rtag006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtag_d[l_ac].rtag007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtag007
            END IF 
 
 
 
            #add-point:AFTER FIELD rtag007 name="input.a.page1.rtag007"
            IF NOT cl_null(g_rtag_d[l_ac].rtag007) THEN 
               IF NOT cl_null(g_rtag_d[l_ac].rtag008) THEN
                  IF g_rtag_d[l_ac].rtag007 < g_rtag_d[l_ac].rtag008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00070'
                     LET g_errparam.extend = g_rtag_d[l_ac].rtag007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD rtag007
                  END IF
               END IF            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag007
            #add-point:BEFORE FIELD rtag007 name="input.b.page1.rtag007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag007
            #add-point:ON CHANGE rtag007 name="input.g.page1.rtag007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtag008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtag_d[l_ac].rtag008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD rtag008
            END IF 
 
 
 
            #add-point:AFTER FIELD rtag008 name="input.a.page1.rtag008"
            IF NOT cl_null(g_rtag_d[l_ac].rtag008) THEN 
               IF NOT cl_null(g_rtag_d[l_ac].rtag007) THEN
                  IF g_rtag_d[l_ac].rtag007 < g_rtag_d[l_ac].rtag008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00070'
                     LET g_errparam.extend = g_rtag_d[l_ac].rtag007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD rtag008
                  END IF
               END IF            
            END IF             

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtag008
            #add-point:BEFORE FIELD rtag008 name="input.b.page1.rtag008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtag008
            #add-point:ON CHANGE rtag008 name="input.g.page1.rtag008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtagacti
            #add-point:BEFORE FIELD rtagacti name="input.b.page1.rtagacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtagacti
            
            #add-point:AFTER FIELD rtagacti name="input.a.page1.rtagacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtagacti
            #add-point:ON CHANGE rtagacti name="input.g.page1.rtagacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag002
            #add-point:ON ACTION controlp INFIELD rtag002 name="input.c.page1.rtag002"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'               
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtag_d[l_ac].rtag002             #給予default值

            #給予arg
            LET g_qryparam.where = " rtax004 = '",g_rtaf_m.rtaf003,"'"
            CALL q_rtax001_1()                                #呼叫開窗
            
            LET g_rtag_d[l_ac].rtag002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            CALL artt205_rtag002_desc(g_rtag_d[l_ac].rtag002)
            CALL artt205_rtag002_desc1(g_rtag_d[l_ac].rtag002)
            DISPLAY g_rtag_d[l_ac].rtag002 TO rtag002              #顯示到畫面上

            NEXT FIELD rtag002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag003
            #add-point:ON ACTION controlp INFIELD rtag003 name="input.c.page1.rtag003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtag_d[l_ac].rtag003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2059" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_rtag_d[l_ac].rtag003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL artt205_rtag003_desc(g_rtag_d[l_ac].rtag003)
            DISPLAY g_rtag_d[l_ac].rtag003 TO rtag003              #顯示到畫面上

            NEXT FIELD rtag003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtag004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag004
            #add-point:ON ACTION controlp INFIELD rtag004 name="input.c.page1.rtag004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtag005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag005
            #add-point:ON ACTION controlp INFIELD rtag005 name="input.c.page1.rtag005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtag006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag006
            #add-point:ON ACTION controlp INFIELD rtag006 name="input.c.page1.rtag006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtag007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag007
            #add-point:ON ACTION controlp INFIELD rtag007 name="input.c.page1.rtag007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtag008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtag008
            #add-point:ON ACTION controlp INFIELD rtag008 name="input.c.page1.rtag008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtagacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtagacti
            #add-point:ON ACTION controlp INFIELD rtagacti name="input.c.page1.rtagacti"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtag_d[l_ac].* = g_rtag_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt205_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtag_d[l_ac].rtag002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtag_d[l_ac].* = g_rtag_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt205_rtag_t_mask_restore('restore_mask_o')
      
               UPDATE rtag_t SET (rtagdocno,rtag001,rtag002,rtag003,rtag004,rtag005,rtag006,rtag007, 
                   rtag008,rtagacti) = (g_rtaf_m.rtafdocno,g_rtag_d[l_ac].rtag001,g_rtag_d[l_ac].rtag002, 
                   g_rtag_d[l_ac].rtag003,g_rtag_d[l_ac].rtag004,g_rtag_d[l_ac].rtag005,g_rtag_d[l_ac].rtag006, 
                   g_rtag_d[l_ac].rtag007,g_rtag_d[l_ac].rtag008,g_rtag_d[l_ac].rtagacti)
                WHERE rtagent = g_enterprise AND rtagdocno = g_rtaf_m.rtafdocno 
 
                  AND rtag002 = g_rtag_d_t.rtag002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtag_d[l_ac].* = g_rtag_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtag_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtag_d[l_ac].* = g_rtag_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtag_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtaf_m.rtafdocno
               LET gs_keys_bak[1] = g_rtafdocno_t
               LET gs_keys[2] = g_rtag_d[g_detail_idx].rtag002
               LET gs_keys_bak[2] = g_rtag_d_t.rtag002
               CALL artt205_update_b('rtag_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt205_rtag_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtag_d[g_detail_idx].rtag002 = g_rtag_d_t.rtag002 
 
                  ) THEN
                  LET gs_keys[01] = g_rtaf_m.rtafdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtag_d_t.rtag002
 
                  CALL artt205_key_update_b(gs_keys,'rtag_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtaf_m),util.JSON.stringify(g_rtag_d_t)
               LET g_log2 = util.JSON.stringify(g_rtaf_m),util.JSON.stringify(g_rtag_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL artt205_unlock_b("rtag_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtag_d[li_reproduce_target].* = g_rtag_d[li_reproduce].*
 
               LET g_rtag_d[li_reproduce_target].rtag002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtag_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtag_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_rtag2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtag2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt205_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_rtag2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtag2_d[l_ac].* TO NULL 
            INITIALIZE g_rtag2_d_t.* TO NULL 
            INITIALIZE g_rtag2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_rtag2_d_t.* = g_rtag2_d[l_ac].*     #新輸入資料
            LET g_rtag2_d_o.* = g_rtag2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt205_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL artt205_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtag2_d[li_reproduce_target].* = g_rtag2_d[li_reproduce].*
 
               LET g_rtag2_d[li_reproduce_target].rtah002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_rtag2_d[l_ac].rtah001 = g_rtaf_m.rtaf001
            LET g_rtag2_d[l_ac].rtahacti = 'Y'
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artt205_cl USING g_enterprise,g_rtaf_m.rtafdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt205_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt205_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtag2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtag2_d[l_ac].rtah002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rtag2_d_t.* = g_rtag2_d[l_ac].*  #BACKUP
               LET g_rtag2_d_o.* = g_rtag2_d[l_ac].*  #BACKUP
               CALL artt205_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               #160504-00016#1 by 08172
               IF g_rtaf_m.rtaf000='U' THEN
                  IF NOT cl_null(g_rtag2_d[l_ac].rtah002) THEN
                     SELECT COUNT(*) INTO l_n FROM rtad_t WHERE rtadent=g_enterprise AND rtadsite=g_rtag2_d[l_ac].rtah002  AND rtad001=g_rtaf_m.rtaf001
                     IF l_n=0 THEN
                        LET g_rtag2_d[l_ac].rtahacti='Y'
                        CALL cl_set_comp_entry("rtahacti",FALSE)
                     END IF
                  END IF
               END IF
               #end add-point  
               CALL artt205_set_no_entry_b(l_cmd)
               IF NOT artt205_lock_b("rtah_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt205_bcl2 INTO g_rtag2_d[l_ac].rtah001,g_rtag2_d[l_ac].rtah002,g_rtag2_d[l_ac].rtahacti 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtag2_d_mask_o[l_ac].* =  g_rtag2_d[l_ac].*
                  CALL artt205_rtah_t_mask()
                  LET g_rtag2_d_mask_n[l_ac].* =  g_rtag2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt205_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtaf_m.rtafdocno
               LET gs_keys[gs_keys.getLength()+1] = g_rtag2_d_t.rtah002
            
               #刪除同層單身
               IF NOT artt205_delete_b('rtah_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt205_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt205_key_delete_b(gs_keys,'rtah_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt205_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE artt205_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_rtag_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtag2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtah_t 
             WHERE rtahent = g_enterprise AND rtahdocno = g_rtaf_m.rtafdocno
               AND rtah002 = g_rtag2_d[l_ac].rtah002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtaf_m.rtafdocno
               LET gs_keys[2] = g_rtag2_d[g_detail_idx].rtah002
               CALL artt205_insert_b('rtah_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rtag_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt205_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtag2_d[l_ac].* = g_rtag2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt205_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtag2_d[l_ac].* = g_rtag2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL artt205_rtah_t_mask_restore('restore_mask_o')
                              
               UPDATE rtah_t SET (rtahdocno,rtah001,rtah002,rtahacti) = (g_rtaf_m.rtafdocno,g_rtag2_d[l_ac].rtah001, 
                   g_rtag2_d[l_ac].rtah002,g_rtag2_d[l_ac].rtahacti) #自訂欄位頁簽
                WHERE rtahent = g_enterprise AND rtahdocno = g_rtaf_m.rtafdocno
                  AND rtah002 = g_rtag2_d_t.rtah002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtag2_d[l_ac].* = g_rtag2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtah_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtag2_d[l_ac].* = g_rtag2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtaf_m.rtafdocno
               LET gs_keys_bak[1] = g_rtafdocno_t
               LET gs_keys[2] = g_rtag2_d[g_detail_idx].rtah002
               LET gs_keys_bak[2] = g_rtag2_d_t.rtah002
               CALL artt205_update_b('rtah_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL artt205_rtah_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_rtag2_d[g_detail_idx].rtah002 = g_rtag2_d_t.rtah002 
                  ) THEN
                  LET gs_keys[01] = g_rtaf_m.rtafdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_rtag2_d_t.rtah002
                  CALL artt205_key_update_b(gs_keys,'rtah_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtaf_m),util.JSON.stringify(g_rtag2_d_t)
               LET g_log2 = util.JSON.stringify(g_rtaf_m),util.JSON.stringify(g_rtag2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtah002
            
            #add-point:AFTER FIELD rtah002 name="input.a.page2.rtah002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_rtaf_m.rtafdocno) AND NOT cl_null(g_rtag2_d[g_detail_idx].rtah002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_rtaf_m.rtafdocno != g_rtafdocno_t OR g_rtag2_d[g_detail_idx].rtah002 != g_rtag2_d_t.rtah002))) THEN 
                  IF NOT ap_chk_notDup(g_rtag2_d[g_detail_idx].rtah002,"SELECT COUNT(*) FROM rtah_t WHERE "||"rtahent = '" ||g_enterprise|| "' AND "||"rtahdocno = '"||g_rtaf_m.rtafdocno ||"' AND "|| "rtah002 = '"||g_rtag2_d[g_detail_idx].rtah002 ||"'",'std-00004',0) THEN 
                     LET g_rtag2_d[l_ac].rtah002 = g_rtag2_d_t.rtah002
                     CALL artt205_rtah002_desc(g_rtag2_d[l_ac].rtah002)
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL artt205_rtah002_desc('')
               CALL artt205_rtah002_chk(g_rtag2_d[l_ac].rtah002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtag2_d[l_ac].rtah002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtag2_d[l_ac].rtah002 = g_rtag2_d_t.rtah002
                  CALL artt205_rtah002_desc(g_rtag2_d[l_ac].rtah002)
                  NEXT FIELD CURRENT
               END IF
            END IF   
            CALL artt205_rtah002_desc(g_rtag2_d[l_ac].rtah002)
            #160504-00016#1 by 08172
            IF g_rtaf_m.rtaf000='U' THEN
               IF NOT cl_null(g_rtag2_d[l_ac].rtah002) THEN
                  SELECT COUNT(*) INTO l_n FROM rtad_t WHERE rtadent=g_enterprise AND rtadsite=g_rtag2_d[l_ac].rtah002  AND rtad001=g_rtaf_m.rtaf001
                  IF l_n=0 THEN
                     LET g_rtag2_d[l_ac].rtahacti='Y'
                     CALL cl_set_comp_entry("rtahacti",FALSE)
                  END IF
               END IF
            END IF

           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtah002
            #add-point:BEFORE FIELD rtah002 name="input.b.page2.rtah002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtah002
            #add-point:ON CHANGE rtah002 name="input.g.page2.rtah002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtahacti
            #add-point:BEFORE FIELD rtahacti name="input.b.page2.rtahacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtahacti
            
            #add-point:AFTER FIELD rtahacti name="input.a.page2.rtahacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtahacti
            #add-point:ON CHANGE rtahacti name="input.g.page2.rtahacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.rtah002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtah002
            #add-point:ON ACTION controlp INFIELD rtah002 name="input.c.page2.rtah002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtag2_d[l_ac].rtah002             #給予default值

            #給予arg
            IF l_cmd = 'a' THEN 
               LET g_qryparam.state = 'm'
            END IF 
            LET g_qryparam.arg1 = g_rtaf_m.rtaf002
            CALL q_rtab002_2()                              #呼叫開窗
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  CALL artt205_analyse_str_array(g_qryparam.str_array)
               END IF   
                
            ELSE  
               LET g_rtag2_d[l_ac].rtah002 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL artt205_rtah002_desc(g_rtag2_d[l_ac].rtah002)  
               DISPLAY g_rtag2_d[l_ac].rtah002 TO rtah002              #顯示到畫面上
            END IF
            NEXT FIELD rtah002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.rtahacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtahacti
            #add-point:ON ACTION controlp INFIELD rtahacti name="input.c.page2.rtahacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtag2_d[l_ac].* = g_rtag2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt205_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL artt205_unlock_b("rtah_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtag2_d[li_reproduce_target].* = g_rtag2_d[li_reproduce].*
 
               LET g_rtag2_d[li_reproduce_target].rtah002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtag2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtag2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="artt205.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD rtafsite #ken---add
            #end add-point  
            NEXT FIELD rtafdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtag001
               WHEN "s_detail2"
                  NEXT FIELD rtah001
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt205_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt205_b_fill() #單身填充
      CALL artt205_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt205_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtaf_m.rtafdocno
   CALL ap_ref_array2(g_ref_fields," SELECT rtafl002,rtafl003 FROM rtafl_t WHERE rtaflent = '"||g_enterprise||"' AND rtafldocno = ? AND rtafl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_rtaf_m.rtafl002 = g_rtn_fields[1] 
   LET g_rtaf_m.rtafl003 = g_rtn_fields[2] 
   DISPLAY BY NAME g_rtaf_m.rtafl002,g_rtaf_m.rtafl003
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtaf002
#   CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtaf002_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtaf002_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtaf004
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtaf004_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtaf004_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtaf005
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtaf005_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtaf005_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtafownid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtafownid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtafownid_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtafowndp
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtafowndp_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtafowndp_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtafcrtid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtafcrtid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtafcrtid_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtafcrtdp
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtafcrtdp_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtafcrtdp_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtafmodid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtafmodid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtafmodid_desc
#
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_rtaf_m.rtafcnfid
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#   LET g_rtaf_m.rtafcnfid_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_rtaf_m.rtafcnfid_desc
   #end add-point
   
   #遮罩相關處理
   LET g_rtaf_m_mask_o.* =  g_rtaf_m.*
   CALL artt205_rtaf_t_mask()
   LET g_rtaf_m_mask_n.* =  g_rtaf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000, 
       g_rtaf_m.rtaf001,g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002,g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005, 
       g_rtaf_m.rtaf005_desc,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp,g_rtaf_m.rtafowndp_desc,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtid_desc, 
       g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid,g_rtaf_m.rtafmodid_desc, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfid_desc,g_rtaf_m.rtafcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtaf_m.rtafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_rtag_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_rtag_d[l_ac].rtag002
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_rtag_d[l_ac].rtag002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_rtag_d[l_ac].rtag002_desc
            CALL artt205_rtag002_desc1(g_rtag_d[l_ac].rtag002)
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_rtag_d[l_ac].rtag003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2059' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_rtag_d[l_ac].rtag003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_rtag_d[l_ac].rtag003_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rtag2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_rtag2_d[l_ac].rtah002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_rtag2_d[l_ac].rtah002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_rtag2_d[l_ac].rtah002_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt205_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt205_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt205_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtaf_t.rtafdocno 
   DEFINE l_oldno     LIKE rtaf_t.rtafdocno 
 
   DEFINE l_master    RECORD LIKE rtaf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtag_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtah_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   #RETURN
   #ken---add---s 需求單號：141208-00001 項次：11
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5 
   #ken---add---e
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_rtaf_m.rtafdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
    
   LET g_rtaf_m.rtafdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtaf_m.rtafownid = g_user
      LET g_rtaf_m.rtafowndp = g_dept
      LET g_rtaf_m.rtafcrtid = g_user
      LET g_rtaf_m.rtafcrtdp = g_dept 
      LET g_rtaf_m.rtafcrtdt = cl_get_current()
      LET g_rtaf_m.rtafmodid = g_user
      LET g_rtaf_m.rtafmoddt = cl_get_current()
      LET g_rtaf_m.rtafstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #ken---add---s 需求單號：141208-00001 項次：17
   CALL s_aooi500_default(g_prog,'rtafsite',g_rtaf_m.rtafsite)
      RETURNING l_insert,g_rtaf_m.rtafsite
   IF l_insert = FALSE THEN
      RETURN
   END IF   

   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_rtaf_m.rtafsite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_rtaf_m.rtafdocno = r_doctype
   #ken---add---e
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtaf_m.rtafstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL artt205_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtaf_m.* TO NULL
      INITIALIZE g_rtag_d TO NULL
      INITIALIZE g_rtag2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt205_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt205_set_act_visible()   
   CALL artt205_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtafent = " ||g_enterprise|| " AND",
                      " rtafdocno = '", g_rtaf_m.rtafdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt205_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt205_idx_chk()
   
   LET g_data_owner = g_rtaf_m.rtafownid      
   LET g_data_dept  = g_rtaf_m.rtafowndp
   
   #功能已完成,通報訊息中心
   CALL artt205_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt205_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtag_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtah_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt205_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtag_t
    WHERE rtagent = g_enterprise AND rtagdocno = g_rtafdocno_t
 
    INTO TEMP artt205_detail
 
   #將key修正為調整後   
   UPDATE artt205_detail 
      #更新key欄位
      SET rtagdocno = g_rtaf_m.rtafdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtag_t SELECT * FROM artt205_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt205_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtah_t 
    WHERE rtahent = g_enterprise AND rtahdocno = g_rtafdocno_t
 
    INTO TEMP artt205_detail
 
   #將key修正為調整後   
   UPDATE artt205_detail SET rtahdocno = g_rtaf_m.rtafdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtah_t SELECT * FROM artt205_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt205_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt205_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rtaf_m.rtafdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.rtafldocno = g_rtaf_m.rtafdocno
LET g_master_multi_table_t.rtafl002 = g_rtaf_m.rtafl002
LET g_master_multi_table_t.rtafl003 = g_rtaf_m.rtafl003
 
   
   CALL s_transaction_begin()
 
   OPEN artt205_cl USING g_enterprise,g_rtaf_m.rtafdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
       g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
       g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp_desc, 
       g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT artt205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtaf_m_mask_o.* =  g_rtaf_m.*
   CALL artt205_rtaf_t_mask()
   LET g_rtaf_m_mask_n.* =  g_rtaf_m.*
   
   CALL artt205_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt205_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtafdocno_t = g_rtaf_m.rtafdocno
 
 
      DELETE FROM rtaf_t
       WHERE rtafent = g_enterprise AND rtafdocno = g_rtaf_m.rtafdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtaf_m.rtafdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #ken---add---str 需求單號：141208-00001 項次：11
      IF NOT s_aooi200_del_docno(g_rtaf_m.rtafdocno,g_rtaf_m.rtafdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken---add---end
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rtag_t
       WHERE rtagent = g_enterprise AND rtagdocno = g_rtaf_m.rtafdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtag_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM rtah_t
       WHERE rtahent = g_enterprise AND
             rtahdocno = g_rtaf_m.rtafdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtaf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt205_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtag_d.clear() 
      CALL g_rtag2_d.clear()       
 
     
      CALL artt205_ui_browser_refresh()  
      #CALL artt205_ui_headershow()  
      #CALL artt205_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'rtaflent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.rtafldocno
   LET l_field_keys[02] = 'rtafldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtafl_t')
 
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt205_browser_fill("")
         CALL artt205_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt205_cl
 
   #功能已完成,通報訊息中心
   CALL artt205_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt205.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt205_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtag_d.clear()
   CALL g_rtag2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artt205_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtag001,rtag002,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008, 
             rtagacti ,t1.rtaxl003 ,t2.oocql004 FROM rtag_t",   
                     " INNER JOIN rtaf_t ON rtafent = " ||g_enterprise|| " AND rtafdocno = rtagdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=rtag002 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2059' AND t2.oocql002=rtag003 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE rtagent=? AND rtagdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtag_t.rtag002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt205_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt205_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtaf_m.rtafdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtaf_m.rtafdocno INTO g_rtag_d[l_ac].rtag001,g_rtag_d[l_ac].rtag002, 
          g_rtag_d[l_ac].rtag003,g_rtag_d[l_ac].rtag004,g_rtag_d[l_ac].rtag005,g_rtag_d[l_ac].rtag006, 
          g_rtag_d[l_ac].rtag007,g_rtag_d[l_ac].rtag008,g_rtag_d[l_ac].rtagacti,g_rtag_d[l_ac].rtag002_desc, 
          g_rtag_d[l_ac].rtag003_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF artt205_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtah001,rtah002,rtahacti ,t3.ooefl003 FROM rtah_t",   
                     " INNER JOIN  rtaf_t ON rtafent = " ||g_enterprise|| " AND rtafdocno = rtahdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=rtah002 AND t3.ooefl002='"||g_dlang||"' ",
 
                     " WHERE rtahent=? AND rtahdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtah_t.rtah002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt205_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR artt205_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rtaf_m.rtafdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rtaf_m.rtafdocno INTO g_rtag2_d[l_ac].rtah001,g_rtag2_d[l_ac].rtah002, 
          g_rtag2_d[l_ac].rtahacti,g_rtag2_d[l_ac].rtah002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_rtag_d.deleteElement(g_rtag_d.getLength())
   CALL g_rtag2_d.deleteElement(g_rtag2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt205_pb
   FREE artt205_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtag_d.getLength()
      LET g_rtag_d_mask_o[l_ac].* =  g_rtag_d[l_ac].*
      CALL artt205_rtag_t_mask()
      LET g_rtag_d_mask_n[l_ac].* =  g_rtag_d[l_ac].*
   END FOR
   
   LET g_rtag2_d_mask_o.* =  g_rtag2_d.*
   FOR l_ac = 1 TO g_rtag2_d.getLength()
      LET g_rtag2_d_mask_o[l_ac].* =  g_rtag2_d[l_ac].*
      CALL artt205_rtah_t_mask()
      LET g_rtag2_d_mask_n[l_ac].* =  g_rtag2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt205_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM rtag_t
       WHERE rtagent = g_enterprise AND
         rtagdocno = ps_keys_bak[1] AND rtag002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtag_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM rtah_t
       WHERE rtahent = g_enterprise AND
             rtahdocno = ps_keys_bak[1] AND rtah002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtag2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt205_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO rtag_t
                  (rtagent,
                   rtagdocno,
                   rtag002
                   ,rtag001,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008,rtagacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtag_d[g_detail_idx].rtag001,g_rtag_d[g_detail_idx].rtag003,g_rtag_d[g_detail_idx].rtag004, 
                       g_rtag_d[g_detail_idx].rtag005,g_rtag_d[g_detail_idx].rtag006,g_rtag_d[g_detail_idx].rtag007, 
                       g_rtag_d[g_detail_idx].rtag008,g_rtag_d[g_detail_idx].rtagacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtag_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtag_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO rtah_t
                  (rtahent,
                   rtahdocno,
                   rtah002
                   ,rtah001,rtahacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtag2_d[g_detail_idx].rtah001,g_rtag2_d[g_detail_idx].rtahacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtag2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt205_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtag_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt205_rtag_t_mask_restore('restore_mask_o')
               
      UPDATE rtag_t 
         SET (rtagdocno,
              rtag002
              ,rtag001,rtag003,rtag004,rtag005,rtag006,rtag007,rtag008,rtagacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtag_d[g_detail_idx].rtag001,g_rtag_d[g_detail_idx].rtag003,g_rtag_d[g_detail_idx].rtag004, 
                  g_rtag_d[g_detail_idx].rtag005,g_rtag_d[g_detail_idx].rtag006,g_rtag_d[g_detail_idx].rtag007, 
                  g_rtag_d[g_detail_idx].rtag008,g_rtag_d[g_detail_idx].rtagacti) 
         WHERE rtagent = g_enterprise AND rtagdocno = ps_keys_bak[1] AND rtag002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtag_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtag_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt205_rtag_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtah_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt205_rtah_t_mask_restore('restore_mask_o')
               
      UPDATE rtah_t 
         SET (rtahdocno,
              rtah002
              ,rtah001,rtahacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtag2_d[g_detail_idx].rtah001,g_rtag2_d[g_detail_idx].rtahacti) 
         WHERE rtahent = g_enterprise AND rtahdocno = ps_keys_bak[1] AND rtah002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtah_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtah_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt205_rtah_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt205_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt205_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt205_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL artt205_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtag_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt205_bcl USING g_enterprise,
                                       g_rtaf_m.rtafdocno,g_rtag_d[g_detail_idx].rtag002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt205_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rtah_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt205_bcl2 USING g_enterprise,
                                             g_rtaf_m.rtafdocno,g_rtag2_d[g_detail_idx].rtah002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt205_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt205_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt205_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt205_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt205_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtafdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtafdocno",TRUE)
      CALL cl_set_comp_entry("rtafdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      #ken---add---s 需求單號：141208-00001 項次：11
      CALL cl_set_comp_entry("rtafsite",TRUE)
      CALL cl_set_comp_entry("rtafdocdt",TRUE)
      CALL cl_set_comp_entry("rtaf003",TRUE)         #add by yangxf 
      #ken---add---e
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rtafdocdt,rtaf000,rtaf001,rtaf002,rtafacti",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt205_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtafdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtafdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtafdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   SELECT COUNT(*) INTO l_cnt FROM rtaf_t WHERE rtafdocno = g_rtaf_m.rtafdocno AND rtafent = g_enterprise
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("rtafdocdt,rtaf000,rtaf001",FALSE)
   END IF  
   SELECT COUNT(*) INTO l_cnt FROM rtah_t WHERE rtahdocno = g_rtaf_m.rtafdocno AND rtahent = g_enterprise
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("rtaf002",FALSE)
   END IF  
   IF g_rtaf_m.rtaf000 = 'I' THEN
      CALL cl_set_comp_entry("rtafacti",FALSE)   
   END IF   
   IF p_cmd = 'a' AND  g_rtaf_m.rtaf000 = 'U' THEN
      CALL cl_set_comp_entry("rtaf002",FALSE)
   END IF
   #ken---add---str 需求單號：141208-00001 項次：11
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("rtafsite",FALSE)
      CALL cl_set_comp_entry("rtafdocdt",FALSE)
      CALL cl_set_comp_entry("rtafdocno",FALSE)
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'rtafsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtafsite",FALSE)
   END IF 
   #ken---add---end
   #add by yangxf ---start---- 需求單號：150521-00031 項次：1
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rtag_t
    WHERE rtagent = g_enterprise
      AND rtagdocno = g_rtaf_m.rtafdocno
   IF l_cnt > 0 THEN 
      CALL cl_set_comp_entry("rtaf003",FALSE)
   END IF 
   #add by yangxf ----end-----
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt205_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   CALL cl_set_comp_entry("rtag001,rtah001",TRUE)
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   IF g_rtaf_m.rtaf000 = 'U' THEN
      CALL cl_set_comp_entry("rtagacti,rtahacti",TRUE)
   END IF   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt205_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   #CALL cl_set_comp_entry("rtag001,rtah001",FALSE)
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_rtaf_m.rtaf000 = 'I' THEN
      CALL cl_set_comp_entry("rtagacti,rtahacti",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt205_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt205_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtaf_m.rtafstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt205_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt205.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt205_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt205.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt205_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " rtafdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "rtaf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtag_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtah_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt205_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_rtaf_m.rtafstus = 'Y' OR g_rtaf_m.rtafstus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtaf_m.rtafdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt205_cl USING g_enterprise,g_rtaf_m.rtafdocno
   IF STATUS THEN
      CLOSE artt205_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt205_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
       g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
       g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp_desc, 
       g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT artt205_action_chk() THEN
      CLOSE artt205_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000, 
       g_rtaf_m.rtaf001,g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006,g_rtaf_m.rtaf006_desc, 
       g_rtaf_m.rtaf002,g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005, 
       g_rtaf_m.rtaf005_desc,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
       g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp,g_rtaf_m.rtafowndp_desc,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtid_desc, 
       g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid,g_rtaf_m.rtafmodid_desc, 
       g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfid_desc,g_rtaf_m.rtafcnfdt
 
   CASE g_rtaf_m.rtafstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_rtaf_m.rtafstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_rtaf_m.rtafstus 
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "X"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "confirmed"
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt205_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt205_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt205_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt205_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_rtaf_m.rtafstus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt205_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'       
         CALL s_artt205_conf_chk(g_rtaf_m.rtafdocno,g_rtaf_m.rtafstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_artt205_conf_upd(g_rtaf_m.rtafdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_rtaf_m.rtafdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_artt205_void_chk(g_rtaf_m.rtafdocno,g_rtaf_m.rtafstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_artt205_void_upd(g_rtaf_m.rtafdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_rtaf_m.rtafdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#8 by 08209 add
            RETURN    
         END IF
   END CASE
   #end add-point
   
   LET g_rtaf_m.rtafmodid = g_user
   LET g_rtaf_m.rtafmoddt = cl_get_current()
   LET g_rtaf_m.rtafstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtaf_t 
      SET (rtafstus,rtafmodid,rtafmoddt) 
        = (g_rtaf_m.rtafstus,g_rtaf_m.rtafmodid,g_rtaf_m.rtafmoddt)     
    WHERE rtafent = g_enterprise AND rtafdocno = g_rtaf_m.rtafdocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE artt205_master_referesh USING g_rtaf_m.rtafdocno INTO g_rtaf_m.rtafsite,g_rtaf_m.rtafdocdt, 
          g_rtaf_m.rtafdocno,g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafunit,g_rtaf_m.rtaf006,g_rtaf_m.rtaf002, 
          g_rtaf_m.rtaf004,g_rtaf_m.rtaf005,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus,g_rtaf_m.rtafownid, 
          g_rtaf_m.rtafowndp,g_rtaf_m.rtafcrtid,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
          g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfdt,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtaf006_desc, 
          g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004_desc,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtafownid_desc, 
          g_rtaf_m.rtafowndp_desc,g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafmodid_desc, 
          g_rtaf_m.rtafcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtaf_m.rtafsite,g_rtaf_m.rtafsite_desc,g_rtaf_m.rtafdocdt,g_rtaf_m.rtafdocno, 
          g_rtaf_m.rtaf000,g_rtaf_m.rtaf001,g_rtaf_m.rtafl002,g_rtaf_m.rtafunit,g_rtaf_m.rtafl003,g_rtaf_m.rtaf006, 
          g_rtaf_m.rtaf006_desc,g_rtaf_m.rtaf002,g_rtaf_m.rtaf002_desc,g_rtaf_m.rtaf004,g_rtaf_m.rtaf004_desc, 
          g_rtaf_m.rtaf005,g_rtaf_m.rtaf005_desc,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti,g_rtaf_m.rtafstus, 
          g_rtaf_m.rtafownid,g_rtaf_m.rtafownid_desc,g_rtaf_m.rtafowndp,g_rtaf_m.rtafowndp_desc,g_rtaf_m.rtafcrtid, 
          g_rtaf_m.rtafcrtid_desc,g_rtaf_m.rtafcrtdp,g_rtaf_m.rtafcrtdp_desc,g_rtaf_m.rtafcrtdt,g_rtaf_m.rtafmodid, 
          g_rtaf_m.rtafmodid_desc,g_rtaf_m.rtafmoddt,g_rtaf_m.rtafcnfid,g_rtaf_m.rtafcnfid_desc,g_rtaf_m.rtafcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE artt205_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt205_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt205.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt205_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtag_d.getLength() THEN
         LET g_detail_idx = g_rtag_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtag_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtag_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rtag2_d.getLength() THEN
         LET g_detail_idx = g_rtag2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtag2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtag2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt205_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL artt205_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt205_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artt205.status_show" >}
PRIVATE FUNCTION artt205_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt205.mask_functions" >}
&include "erp/art/artt205_mask.4gl"
 
{</section>}
 
{<section id="artt205.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt205_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL artt205_show()
   CALL artt205_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_artt205_conf_chk(g_rtaf_m.rtafdocno,g_rtaf_m.rtafstus) RETURNING l_success,g_errno
   IF NOT l_success THEN
      CLOSE artt205_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtaf_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtag_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_rtag2_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL artt205_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt205_ui_headershow()
   CALL artt205_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt205_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt205_ui_headershow()  
   CALL artt205_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt205.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt205_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_rtaf_m.rtafdocno
   LET g_pk_array[1].column = 'rtafdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt205.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt205.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt205_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL artt205_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtaf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt205.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt205_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#34 add-S
   SELECT rtafstus  INTO g_rtaf_m.rtafstus
     FROM rtaf_t
    WHERE rtafent = g_enterprise
      AND rtafdocno = g_rtaf_m.rtafdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN     
     LET g_errno = NULL
     CASE g_rtaf_m.rtafstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_rtaf_m.rtafdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL artt205_set_act_visible()
        CALL artt205_set_act_no_visible()
        CALL artt205_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#34 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt205.other_function" readonly="Y" >}
#上級品類，上級品類名稱
PRIVATE FUNCTION artt205_rtag002_desc1(p_rtag002)
DEFINE p_rtag002   LIKE rtag_t.rtag002
   IF cl_null(p_rtag002) THEN
      LET g_rtag_d[l_ac].rtax003 = ''
      LET g_rtag_d[l_ac].rtax003_desc = ''
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_rtag002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtax003 FROM rtax_t WHERE rtaxent='"||g_enterprise||"' AND rtax001=? ","") RETURNING g_rtn_fields
      LET g_rtag_d[l_ac].rtax003 = '', g_rtn_fields[1] , ''
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtag_d[l_ac].rtax003
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtag_d[l_ac].rtax003_desc = '', g_rtn_fields[1] , ''
   END IF   
   DISPLAY BY NAME g_rtag_d[l_ac].rtax003,g_rtag_d[l_ac].rtax003_desc 
END FUNCTION
#門店名稱
PRIVATE FUNCTION artt205_rtah002_desc(p_rtah002)
DEFINE p_rtah002  LIKE rtah_t.rtah002
   IF cl_null(p_rtah002) THEN
      LET g_rtag2_d[l_ac].rtah002_desc = ''
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_rtah002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtag2_d[l_ac].rtah002_desc = '', g_rtn_fields[1] , ''
   END IF   
   DISPLAY BY NAME g_rtag2_d[l_ac].rtah002_desc
END FUNCTION
#店群名稱顯示
PRIVATE FUNCTION artt205_rtaf002_desc(p_rtaf002)
DEFINE p_rtaf002   LIKE rtaf_t.rtaf002
   IF cl_null(p_rtaf002) THEN
      LET g_rtaf_m.rtaf002_desc = ''
   ELSE      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_rtaf002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtaf_m.rtaf002_desc = '', g_rtn_fields[1] , ''
   END IF           
   DISPLAY BY NAME g_rtaf_m.rtaf002_desc
END FUNCTION
#品類名稱
PRIVATE FUNCTION artt205_rtag002_desc(p_rtag002)
DEFINE p_rtag002   LIKE rtag_t.rtag002
   IF cl_null(p_rtag002) THEN
      LET g_rtag_d[l_ac].rtag002_desc = ''
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_rtag002
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtag_d[l_ac].rtag002_desc = '', g_rtn_fields[1] , ''
   END IF   
   DISPLAY BY NAME g_rtag_d[l_ac].rtag002_desc
END FUNCTION
#角色名稱
PRIVATE FUNCTION artt205_rtag003_desc(p_rtag003)
DEFINE p_rtag003  LIKE rtag_t.rtag003
   IF cl_null(p_rtag003) THEN
      LET g_rtag_d[l_ac].rtag003_desc = ''
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_rtag003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2059' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtag_d[l_ac].rtag003_desc = '', g_rtn_fields[1] , ''
   END IF   
   DISPLAY BY NAME g_rtag_d[l_ac].rtag003_desc
END FUNCTION
#單號檢核
PRIVATE FUNCTION artt205_rtafdocno_chk()
DEFINE l_stus   LIKE ooba_t.oobastus
   LET g_errno = null
   SELECT oobastus INTO l_stus  FROM ooba_t,oobl_t 
    WHERE oobaent = ooblent  AND ooba001 = oobl001
      AND ooba002 = oobl002   AND oobl003 = 'artt205'
      AND oobl001 = g_ooef004 AND oobl002= g_rtaf_m.rtafdocno
      AND ooblent = g_enterprise
      
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aim-00056'
        WHEN l_stus='N'            LET g_errno = 'aoo-00102'       
   END CASE  
END FUNCTION
#策略編號檢查
PRIVATE FUNCTION artt205_rtaf001_chk(p_rtaf001)
DEFINE l_cnt   LIKE type_t.num5
DEFINE p_rtaf001   LIKE rtaf_t.rtaf001
   LET g_errno = null
   IF g_rtaf_m.rtaf000 = 'U' THEN   
      SELECT COUNT(*) INTO l_cnt  FROM rtac_t WHERE rtac001 = p_rtaf001 AND rtacent = g_enterprise
      IF l_cnt <= 0 THEN
         LET g_errno = "art-00076"
         RETURN 
      END IF
   ELSE   
      SELECT COUNT(*) INTO l_cnt  FROM rtac_t WHERE rtac001 = p_rtaf001 AND rtacent = g_enterprise
      IF l_cnt > 0 THEN
         LET g_errno = "art-00122"
         RETURN 
      END IF
   END IF      
   IF NOT cl_null(g_rtaf_m.rtafdocno) THEN
      SELECT COUNT(*) INTO l_cnt FROM rtaf_t
       WHERE rtaf001 = p_rtaf001 AND rtafent = g_enterprise
        AND rtafdocno <> g_rtaf_m.rtafdocno AND rtafstus = 'N' 
   ELSE
      SELECT COUNT(*) INTO l_cnt FROM rtaf_t
       WHERE rtaf001 = p_rtaf001 AND rtafent = g_enterprise AND rtafstus = 'N' 
   END IF
   IF l_cnt > 0 THEN
      LET g_errno = "art-00112"
      RETURN 
   END IF   
END FUNCTION
#修改狀態帶出值
PRIVATE FUNCTION artt205_rtaf001_desc(p_rtaf001,p_rtaf000)
DEFINE p_rtaf001  LIKE rtaf_t.rtaf001
DEFINE p_rtaf000  LIKE rtaf_t.rtaf000
DEFINE l_rtacstus LIKE rtac_t.rtacstus
   IF p_rtaf000 = 'U' THEN
      #IF NOT cl_null() THEN 
      SELECT rtacl003,rtacl004 INTO g_rtaf_m.rtafl002,g_rtaf_m.rtafl003 FROM rtacl_t
       WHERE rtaclent = g_enterprise AND rtacl001 = g_rtaf_m.rtaf001 AND rtacl002 = g_dlang
      DISPLAY BY NAME g_rtaf_m.rtafl002,g_rtaf_m.rtafl003       
      SELECT rtac002,rtac003,rtacstus INTO g_rtaf_m.rtaf002,g_rtaf_m.rtaf003,l_rtacstus FROM rtac_t
       WHERE rtac001 =g_rtaf_m.rtaf001 AND rtacent = g_enterprise 
      IF l_rtacstus = 'X' THEN
         LET g_rtaf_m.rtafacti = 'N'
      ELSE
         LET g_rtaf_m.rtafacti = 'Y'
      END IF
      CALL artt205_rtaf002_desc(g_rtaf_m.rtaf002)
      DISPLAY BY NAME g_rtaf_m.rtaf002,g_rtaf_m.rtaf003,g_rtaf_m.rtafacti
   END IF          
END FUNCTION
#申請部門顯示
PRIVATE FUNCTION artt205_rtaf005_desc(p_rtaf005)
DEFINE p_rtaf005  LIKE rtaf_t.rtaf005
   IF cl_null(p_rtaf005) THEN
      LET g_rtaf_m.rtaf005_desc = ''
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtaf_m.rtaf005
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtaf_m.rtaf005_desc = '', g_rtn_fields[1] , ''
   END IF    
   DISPLAY BY NAME g_rtaf_m.rtaf005_desc
END FUNCTION
#店群編號檢查
PRIVATE FUNCTION artt205_rtaf002_chk(p_rtaf002)
DEFINE p_rtaf002   LIKE rtaf_t.rtaf002
DEFINE l_rtaastus  LIKE rtaa_t.rtaastus
DEFINE l_rtak003   LIKE rtak_t.rtak003

   LET g_errno = ''
   #huangrh add rtak----20150603
   SELECT rtaastus,rtak003 INTO l_rtaastus ,l_rtak003 FROM rtaa_t,rtak_t
    WHERE rtaa001 = p_rtaf002
      AND rtaaent = g_enterprise 
      AND rtakent=rtaaent
      AND rtak001=rtaa001
      AND rtak002='3'
   IF cl_null(l_rtaastus) THEN
      LET g_errno = 'art-00068'
      RETURN
   END IF
   IF l_rtaastus <> 'Y' THEN
      LET g_errno = 'art-00067'
      RETURN
   END IF     
   IF l_rtak003 <> 'Y' THEN
      LET g_errno = 'art-00066'
      RETURN
   END IF  
END FUNCTION
#員工名稱
PRIVATE FUNCTION artt205_rtaf004_desc(p_rtaf004)
DEFINE p_rtaf004  LIKE rtaf_t.rtaf004
   IF cl_null(p_rtaf004) THEN
      LET g_rtaf_m.rtaf004_desc = ''
   ELSE      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtaf_m.rtaf004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_rtaf_m.rtaf004_desc = '', g_rtn_fields[1] , ''
   END IF   
   DISPLAY BY NAME g_rtaf_m.rtaf004_desc
END FUNCTION
#員工編號檢查
PRIVATE FUNCTION artt205_rtaf004_chk(p_rtaf004)
DEFINE p_rtaf004   LIKE rtaf_t.rtaf004
DEFINE l_stus      LIKE ooag_t.ooagstus
   LET g_errno = null
   SELECT ooagstus INTO l_stus  FROM ooag_t WHERE ooag001 =p_rtaf004 AND ooagent = g_enterprise
   IF cl_null(l_stus) THEN
      LET g_errno = "aim-00069"
      RETURN
   END IF
   IF l_stus <> 'Y' THEN
#      LET g_errno = "amm-00008"     #160318-00005#42  mark
      LET g_errno = "sub-01302"     #160318-00005#42  add
      RETURN
   END IF         
END FUNCTION
#門店範圍批量新增
PRIVATE FUNCTION artt205_analyse_str_array(p_str_array)
DEFINE   l_rtah002   LIKE rtah_t.rtah002
DEFINE   l_n         LIKE type_t.num5
DEFINE   l_i         LIKE type_t.num5
DEFINE   p_str_array DYNAMIC ARRAY OF STRING
DEFINE   l_ac_t      LIKE type_t.num5
DEFINE   l_cnt       LIKE type_t.num5
DEFINE   i           LIKE type_t.num5

   LET l_ac_t = l_ac
   LET l_cnt = 0
   FOR l_i = 1 TO p_str_array.getlength()
      INITIALIZE l_rtah002 TO NULL
      LET l_rtah002 = p_str_array[l_i]
      SELECT count(*) INTO l_n FROM rtah_t
       WHERE rtahdocno = g_rtaf_m.rtafdocno
         AND rtahent = g_enterprise
         AND rtah002 = l_rtah002
      IF l_n > 0 THEN
         CONTINUE FOR
      ELSE
         LET l_cnt = l_cnt + 1 
      END IF
      #當前行不insert到數據庫      
      IF l_cnt > 1 THEN
         CALL artt205_rtah002_chk(l_rtah002)
         IF cl_null(g_errno) THEN
            INSERT INTO rtah_t(rtahent,rtahdocno,rtah001,rtah002,rtahacti)
            VALUES(g_enterprise,g_rtaf_m.rtafdocno,g_rtaf_m.rtaf001,l_rtah002,'Y')
            IF sqlca.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = l_rtah002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CONTINUE FOR
            END IF   
         END IF 
         IF g_rtag2_d.getLength() >= l_ac THEN
            FOR i = g_rtag2_d.getLength() TO l_ac STEP -1
               LET  g_rtag2_d[i+1].* = g_rtag2_d[i].*  
               DISPLAY BY NAME g_rtag2_d[i+1].*
            END FOR       
         END IF         
      END IF
      LET g_rtag2_d[l_ac].rtahacti = 'Y'
      LET g_rtag2_d[l_ac].rtah002 = l_rtah002
      CALL artt205_rtah002_desc(l_rtah002)
      DISPLAY BY NAME g_rtag2_d[l_ac].rtahacti,g_rtag2_d[l_ac].rtah002
      LET l_ac = l_ac + 1  
   END FOR
   #CALL s_transaction_end('Y','0')
   SELECT COUNT(*) INTO g_rec_b FROM rtah_t  WHERE rtahent = g_enterprise AND rtahdocno = g_rtaf_m.rtafdocno
   IF cl_null(g_rtag2_d[l_ac].rtah002) THEN
      CALL g_rtag2_d.deleteElement(l_ac) 
   END IF   
   LET l_ac = l_ac_t
END FUNCTION
#門店編號檢查
PRIVATE FUNCTION artt205_rtah002_chk(p_rtah002)
DEFINE p_rtah002   LIKE rtah_t.rtah002
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_rtaastus  LIKE rtaa_t.rtaastus
   LET g_errno = ''
   SELECT rtaastus INTO l_rtaastus FROM rtab_t,rtaa_t
    WHERE rtab001 = rtaa001 AND rtabent = rtaaent
      AND rtab001 = g_rtaf_m.rtaf002
      AND rtab002 = p_rtah002
      AND rtabent = g_enterprise      
   IF cl_null(l_rtaastus) THEN
      LET g_errno = 'art-00061'
      RETURN
   END IF  
   IF l_rtaastus <> 'Y' THEN
      LET g_errno = 'art-00060'
      RETURN
   END IF 
END FUNCTION
#品類編號檢查
PRIVATE FUNCTION artt205_rtag002_chk(p_rtag002)
DEFINE p_rtag002   LIKE rtag_t.rtag002
DEFINE l_rtaxstus  LIKE rtax_t.rtaxstus
DEFINE l_rtax004   LIKE rtax_t.rtax004
   LET g_errno = ''
   SELECT rtaxstus,rtax004 INTO l_rtaxstus,l_rtax004 FROM rtax_t
    WHERE rtax001 = p_rtag002
      AND rtaxent = g_enterprise     
   IF cl_null(l_rtaxstus) THEN
      LET g_errno = 'art-00059'
      RETURN
   END IF
   IF l_rtaxstus <> 'Y' THEN
      LET g_errno = 'art-00048'
      RETURN
   END IF    
   
   IF l_rtax004 <> g_rtaf_m.rtaf003 THEN
      LET g_errno = 'art-00058'
      RETURN
   END IF
END FUNCTION
#角色編號檢查
PRIVATE FUNCTION artt205_rtag003_chk(p_rtag003)
DEFINE p_rtag003   LIKE rtag_t.rtag003
DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_cnt       LIKE type_t.num5
   LET g_errno = ''
   SELECT COUNT(oocq001) INTO l_cnt FROM oocq_t 
    WHERE oocqent = g_enterprise 
      AND oocq002 = p_rtag003
   IF l_cnt = 0 THEN
      LET g_errno = 'art-00065'
      RETURN
   END IF   
   SELECT oocqstus INTO l_oocqstus FROM oocq_t 
    WHERE oocqent = g_enterprise 
      AND oocq002 = p_rtag003
      AND oocq001 = '2059'
   IF cl_null(l_oocqstus) THEN
      LET g_errno = 'art-00064'
      RETURN
   END IF
   IF l_oocqstus <> 'Y' THEN
      LET g_errno = 'art-00063'
      RETURN
   END IF 
END FUNCTION

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
PRIVATE FUNCTION artt205_rtaf006_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_rtaf_m.rtaf006
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_rtaf_m.rtaf006_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_rtaf_m.rtaf006_desc
END FUNCTION

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
PRIVATE FUNCTION artt205_cnt_rtad()
DEFINE l_cnt_rtad LIKE type_t.num5

   LET l_cnt_rtad = 0
   IF NOT cl_null(g_rtaf_m.rtaf006) THEN
      SELECT COUNT(*) INTO l_cnt_rtad 
        FROM rtad_t
       WHERE rtadent=g_enterprise
         AND rtadsite=g_rtaf_m.rtaf006
   END IF
   RETURN l_cnt_rtad
END FUNCTION

 
{</section>}
 
