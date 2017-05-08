#該程式未解開Section, 採用最新樣板產出!
{<section id="artt302.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-08-20 16:32:34), PR版次:0007(2016-11-14 16:54:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: artt302
#+ Description: 商品轉類單維護作業
#+ Creator....: 06189(2015-08-19 18:54:51)
#+ Modifier...: 06189 -SD/PR- 02481
 
{</section>}
 
{<section id="artt302.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#16   2016/04/08  BY 07900      重复错误讯息的修改
#160816-00068#09   2016/08/22  By 08209      調整transaction
#160818-00017#34   2016-08-24  By 08734      删除修改未重新判断状态码
#161111-00028#3    2016/11/14  BY 02481      标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_rtbd_m        RECORD
       rtbdsite LIKE rtbd_t.rtbdsite, 
   rtbdsite_desc LIKE type_t.chr80, 
   rtbddocdt LIKE rtbd_t.rtbddocdt, 
   rtbddocno LIKE rtbd_t.rtbddocno, 
   rtbd001 LIKE rtbd_t.rtbd001, 
   rtbd001_desc LIKE type_t.chr80, 
   rtbd002 LIKE rtbd_t.rtbd002, 
   rtbd002_desc LIKE type_t.chr80, 
   rtbd003 LIKE rtbd_t.rtbd003, 
   rtbd003_desc LIKE type_t.chr80, 
   rtbd004 LIKE rtbd_t.rtbd004, 
   rtbd004_desc LIKE type_t.chr80, 
   rtbd005 LIKE rtbd_t.rtbd005, 
   rtbdstus LIKE rtbd_t.rtbdstus, 
   rtbdownid LIKE rtbd_t.rtbdownid, 
   rtbdownid_desc LIKE type_t.chr80, 
   rtbdowndp LIKE rtbd_t.rtbdowndp, 
   rtbdowndp_desc LIKE type_t.chr80, 
   rtbdcrtid LIKE rtbd_t.rtbdcrtid, 
   rtbdcrtid_desc LIKE type_t.chr80, 
   rtbdcrtdp LIKE rtbd_t.rtbdcrtdp, 
   rtbdcrtdp_desc LIKE type_t.chr80, 
   rtbdcrtdt LIKE rtbd_t.rtbdcrtdt, 
   rtbdmodid LIKE rtbd_t.rtbdmodid, 
   rtbdmodid_desc LIKE type_t.chr80, 
   rtbdmoddt LIKE rtbd_t.rtbdmoddt, 
   rtbdcnfid LIKE rtbd_t.rtbdcnfid, 
   rtbdcnfid_desc LIKE type_t.chr80, 
   rtbdcnfdt LIKE rtbd_t.rtbdcnfdt, 
   rtbdpstid LIKE rtbd_t.rtbdpstid, 
   rtbdpstid_desc LIKE type_t.chr80, 
   rtbdpstdt LIKE rtbd_t.rtbdpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtbe_d        RECORD
       rtbesite LIKE rtbe_t.rtbesite, 
   rtbeseq LIKE rtbe_t.rtbeseq, 
   rtbe001 LIKE rtbe_t.rtbe001, 
   rtbe002 LIKE rtbe_t.rtbe002, 
   rtbe002_desc LIKE type_t.chr500, 
   rtbe003 LIKE rtbe_t.rtbe003, 
   rtbe004 LIKE rtbe_t.rtbe004, 
   rtbe004_desc LIKE type_t.chr500, 
   rtbe005 LIKE rtbe_t.rtbe005, 
   rtbe006 LIKE rtbe_t.rtbe006
       END RECORD
PRIVATE TYPE type_g_rtbe2_d RECORD
       rtbfsite LIKE rtbf_t.rtbfsite, 
   rtbfseq LIKE rtbf_t.rtbfseq, 
   rtbfseq1 LIKE rtbf_t.rtbfseq1, 
   rtbf001 LIKE rtbf_t.rtbf001, 
   rtbf002 LIKE rtbf_t.rtbf002, 
   rtbf002_desc LIKE type_t.chr500, 
   rtbf003 LIKE rtbf_t.rtbf003, 
   rtbf004 LIKE rtbf_t.rtbf004, 
   rtbf004_desc LIKE type_t.chr500, 
   rtbf005 LIKE rtbf_t.rtbf005, 
   rtbf006 LIKE rtbf_t.rtbf006, 
   rtbf006_desc LIKE type_t.chr500, 
   rtbf007 LIKE rtbf_t.rtbf007, 
   rtbf008 LIKE rtbf_t.rtbf008, 
   rtbf009 LIKE rtbf_t.rtbf009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtbdsite LIKE rtbd_t.rtbdsite,
      b_rtbddocdt LIKE rtbd_t.rtbddocdt,
      b_rtbddocno LIKE rtbd_t.rtbddocno,
      b_rtbd001 LIKE rtbd_t.rtbd001,
      b_rtbd002 LIKE rtbd_t.rtbd002,
      b_rtbd003 LIKE rtbd_t.rtbd003,
      b_rtbd004 LIKE rtbd_t.rtbd004,
      b_rtbd005 LIKE rtbd_t.rtbd005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag    LIKE type_t.num5        #用來判斷單頭site的輸入狀況，用來欄位開關
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtbd_m          type_g_rtbd_m
DEFINE g_rtbd_m_t        type_g_rtbd_m
DEFINE g_rtbd_m_o        type_g_rtbd_m
DEFINE g_rtbd_m_mask_o   type_g_rtbd_m #轉換遮罩前資料
DEFINE g_rtbd_m_mask_n   type_g_rtbd_m #轉換遮罩後資料
 
   DEFINE g_rtbddocno_t LIKE rtbd_t.rtbddocno
 
 
DEFINE g_rtbe_d          DYNAMIC ARRAY OF type_g_rtbe_d
DEFINE g_rtbe_d_t        type_g_rtbe_d
DEFINE g_rtbe_d_o        type_g_rtbe_d
DEFINE g_rtbe_d_mask_o   DYNAMIC ARRAY OF type_g_rtbe_d #轉換遮罩前資料
DEFINE g_rtbe_d_mask_n   DYNAMIC ARRAY OF type_g_rtbe_d #轉換遮罩後資料
DEFINE g_rtbe2_d          DYNAMIC ARRAY OF type_g_rtbe2_d
DEFINE g_rtbe2_d_t        type_g_rtbe2_d
DEFINE g_rtbe2_d_o        type_g_rtbe2_d
DEFINE g_rtbe2_d_mask_o   DYNAMIC ARRAY OF type_g_rtbe2_d #轉換遮罩前資料
DEFINE g_rtbe2_d_mask_n   DYNAMIC ARRAY OF type_g_rtbe2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="artt302.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success     LIKE type_t.num5
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
   LET g_forupd_sql = " SELECT rtbdsite,'',rtbddocdt,rtbddocno,rtbd001,'',rtbd002,'',rtbd003,'',rtbd004, 
       '',rtbd005,rtbdstus,rtbdownid,'',rtbdowndp,'',rtbdcrtid,'',rtbdcrtdp,'',rtbdcrtdt,rtbdmodid,'', 
       rtbdmoddt,rtbdcnfid,'',rtbdcnfdt,rtbdpstid,'',rtbdpstdt", 
                      " FROM rtbd_t",
                      " WHERE rtbdent= ? AND rtbddocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt302_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtbdsite,t0.rtbddocdt,t0.rtbddocno,t0.rtbd001,t0.rtbd002,t0.rtbd003, 
       t0.rtbd004,t0.rtbd005,t0.rtbdstus,t0.rtbdownid,t0.rtbdowndp,t0.rtbdcrtid,t0.rtbdcrtdp,t0.rtbdcrtdt, 
       t0.rtbdmodid,t0.rtbdmoddt,t0.rtbdcnfid,t0.rtbdcnfdt,t0.rtbdpstid,t0.rtbdpstdt,t1.ooefl003 ,t2.rtaxl003 , 
       t3.rtaxl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooag011 ,t12.ooag011",
               " FROM rtbd_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtbdsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.rtbd001 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.rtbd002 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtbd003  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtbd004 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtbdownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.rtbdowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtbdcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.rtbdcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtbdmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rtbdcnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.rtbdpstid  ",
 
               " WHERE t0.rtbdent = " ||g_enterprise|| " AND t0.rtbddocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt302_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt302 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt302_init()   
 
      #進入選單 Menu (="N")
      CALL artt302_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt302
      
   END IF 
   
   CLOSE artt302_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt302.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt302_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('rtbdstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
   #初始化搜尋條件
   CALL artt302_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt302.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt302_ui_dialog()
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
   DEFINE l_cnt      LIKE type_t.num10 
   DEFINE l_success  LIKE type_t.num5 
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
            CALL artt302_insert()
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
         INITIALIZE g_rtbd_m.* TO NULL
         CALL g_rtbe_d.clear()
         CALL g_rtbe2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt302_init()
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
               
               CALL artt302_fetch('') # reload data
               LET l_ac = 1
               CALL artt302_ui_detailshow() #Setting the current row 
         
               CALL artt302_idx_chk()
               #NEXT FIELD rtbeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtbe_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt302_idx_chk()
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
               CALL artt302_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_rtbe2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt302_idx_chk()
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
               CALL artt302_idx_chk()
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
            CALL artt302_browser_fill("")
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
               CALL artt302_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt302_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt302_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt302_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt302_set_act_visible()   
            CALL artt302_set_act_no_visible()
            IF NOT (g_rtbd_m.rtbddocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtbdent = " ||g_enterprise|| " AND",
                                  " rtbddocno = '", g_rtbd_m.rtbddocno, "' "
 
               #填到對應位置
               CALL artt302_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "rtbd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtbe_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtbf_t" 
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
               CALL artt302_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rtbd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtbe_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtbf_t" 
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
                  CALL artt302_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt302_fetch("F")
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
               CALL artt302_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt302_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt302_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt302_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt302_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt302_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt302_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt302_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt302_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt302_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt302_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtbe_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rtbe2_d)
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
               NEXT FIELD rtbeseq
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
               CALL artt302_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt302_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt302_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt302_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/art/artt302_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/art/artt302_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION produce_data
            LET g_action_choice="produce_data"
            IF cl_auth_chk_act("produce_data") THEN
               
               #add-point:ON ACTION produce_data name="menu.produce_data"
               IF NOT cl_null(g_rtbd_m.rtbddocno) THEN
                  IF g_rtbd_m.rtbdstus  = 'N' THEN
                     LET l_cnt = 0 
                     SELECT COUNT(*) INTO l_cnt
                       FROM rtbe_t
                      WHERE rtbeent = g_enterprise
                        AND rtbedocno = g_rtbd_m.rtbddocno
                     IF l_cnt > 0 THEN   
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "adb-00059" 
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        CONTINUE DIALOG 
                     ELSE
                        IF cl_ask_confirm('agc-00112') THEN
                           CALL s_transaction_begin()
                           CALL artt302_rtbe_init() RETURNING l_success
                           IF NOT l_success THEN
#                              INITIALIZE g_errparam TO NULL 
#                              LET g_errparam.extend = "" 
#                              LET g_errparam.code   = "aap-00062" 
#                              LET g_errparam.popup  = FALSE 
#                              CALL cl_err()
                              CALL s_transaction_end("N","0")
                              CONTINUE DIALOG 
                           END IF
                           CALL s_transaction_end("Y","0") 
                           CALL artt302_b_fill()
                        ELSE
                           CONTINUE DIALOG             
                        END IF
                     END IF   
                  ELSE   
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "art-00608" 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     CONTINUE DIALOG 
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "std-00003" 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CONTINUE DIALOG             
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt302_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt302_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt302_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt302_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt302_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtbd_m.rtbddocdt)
 
 
 
         
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
 
{<section id="artt302.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt302_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
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
   CALL s_aooi500_sql_where(g_prog,'rtbdsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rtbddocno ",
                      " FROM rtbd_t ",
                      " ",
                      " LEFT JOIN rtbe_t ON rtbeent = rtbdent AND rtbddocno = rtbedocno ", "  ",
                      #add-point:browser_fill段sql(rtbe_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rtbf_t ON rtbfent = rtbdent AND rtbddocno = rtbfdocno", "  ",
                      #add-point:browser_fill段sql(rtbf_t1) name="browser_fill.cnt.join.rtbf_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE rtbdent = " ||g_enterprise|| " AND rtbeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtbd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtbddocno ",
                      " FROM rtbd_t ", 
                      "  ",
                      "  ",
                      " WHERE rtbdent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtbd_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
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
      INITIALIZE g_rtbd_m.* TO NULL
      CALL g_rtbe_d.clear()        
      CALL g_rtbe2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtbdsite,t0.rtbddocdt,t0.rtbddocno,t0.rtbd001,t0.rtbd002,t0.rtbd003,t0.rtbd004,t0.rtbd005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtbdstus,t0.rtbdsite,t0.rtbddocdt,t0.rtbddocno,t0.rtbd001,t0.rtbd002, 
          t0.rtbd003,t0.rtbd004,t0.rtbd005 ",
                  " FROM rtbd_t t0",
                  "  ",
                  "  LEFT JOIN rtbe_t ON rtbeent = rtbdent AND rtbddocno = rtbedocno ", "  ", 
                  #add-point:browser_fill段sql(rtbe_t1) name="browser_fill.join.rtbe_t1"
                  
                  #end add-point
                  "  LEFT JOIN rtbf_t ON rtbfent = rtbdent AND rtbddocno = rtbfdocno", "  ", 
                  #add-point:browser_fill段sql(rtbf_t1) name="browser_fill.join.rtbf_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.rtbdent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtbd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtbdstus,t0.rtbdsite,t0.rtbddocdt,t0.rtbddocno,t0.rtbd001,t0.rtbd002, 
          t0.rtbd003,t0.rtbd004,t0.rtbd005 ",
                  " FROM rtbd_t t0",
                  "  ",
                  
                  " WHERE t0.rtbdent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtbd_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtbddocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtbd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtbdsite,g_browser[g_cnt].b_rtbddocdt, 
          g_browser[g_cnt].b_rtbddocno,g_browser[g_cnt].b_rtbd001,g_browser[g_cnt].b_rtbd002,g_browser[g_cnt].b_rtbd003, 
          g_browser[g_cnt].b_rtbd004,g_browser[g_cnt].b_rtbd005
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
         CALL artt302_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_rtbddocno) THEN
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
 
{<section id="artt302.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt302_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtbd_m.rtbddocno = g_browser[g_current_idx].b_rtbddocno   
 
   EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
       g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
       g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
       g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
       g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
       g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdpstid_desc 
 
   
   CALL artt302_rtbd_t_mask()
   CALL artt302_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt302.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt302_ui_detailshow()
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
 
{<section id="artt302.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt302_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtbddocno = g_rtbd_m.rtbddocno 
 
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
 
{<section id="artt302.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt302_construct()
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
   INITIALIZE g_rtbd_m.* TO NULL
   CALL g_rtbe_d.clear()        
   CALL g_rtbe2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON rtbdsite,rtbddocdt,rtbddocno,rtbd001,rtbd002,rtbd003,rtbd004,rtbd005, 
          rtbdstus,rtbdownid,rtbdowndp,rtbdcrtid,rtbdcrtdp,rtbdcrtdt,rtbdmodid,rtbdmoddt,rtbdcnfid,rtbdcnfdt, 
          rtbdpstid,rtbdpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtbdcrtdt>>----
         AFTER FIELD rtbdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtbdmoddt>>----
         AFTER FIELD rtbdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtbdcnfdt>>----
         AFTER FIELD rtbdcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtbdpstdt>>----
         AFTER FIELD rtbdpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtbdsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdsite
            #add-point:ON ACTION controlp INFIELD rtbdsite name="construct.c.rtbdsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbdsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdsite  #顯示到畫面上
            NEXT FIELD rtbdsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdsite
            #add-point:BEFORE FIELD rtbdsite name="construct.b.rtbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdsite
            
            #add-point:AFTER FIELD rtbdsite name="construct.a.rtbdsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbddocdt
            #add-point:BEFORE FIELD rtbddocdt name="construct.b.rtbddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbddocdt
            
            #add-point:AFTER FIELD rtbddocdt name="construct.a.rtbddocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbddocdt
            #add-point:ON ACTION controlp INFIELD rtbddocdt name="construct.c.rtbddocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbddocno
            #add-point:ON ACTION controlp INFIELD rtbddocno name="construct.c.rtbddocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtbddocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbddocno  #顯示到畫面上
            NEXT FIELD rtbddocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbddocno
            #add-point:BEFORE FIELD rtbddocno name="construct.b.rtbddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbddocno
            
            #add-point:AFTER FIELD rtbddocno name="construct.a.rtbddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd001
            #add-point:ON ACTION controlp INFIELD rtbd001 name="construct.c.rtbd001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbd001  #顯示到畫面上
            NEXT FIELD rtbd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd001
            #add-point:BEFORE FIELD rtbd001 name="construct.b.rtbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd001
            
            #add-point:AFTER FIELD rtbd001 name="construct.a.rtbd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd002
            #add-point:ON ACTION controlp INFIELD rtbd002 name="construct.c.rtbd002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbd002  #顯示到畫面上
            NEXT FIELD rtbd002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd002
            #add-point:BEFORE FIELD rtbd002 name="construct.b.rtbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd002
            
            #add-point:AFTER FIELD rtbd002 name="construct.a.rtbd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd003
            #add-point:ON ACTION controlp INFIELD rtbd003 name="construct.c.rtbd003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbd003  #顯示到畫面上
            NEXT FIELD rtbd003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd003
            #add-point:BEFORE FIELD rtbd003 name="construct.b.rtbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd003
            
            #add-point:AFTER FIELD rtbd003 name="construct.a.rtbd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd004
            #add-point:ON ACTION controlp INFIELD rtbd004 name="construct.c.rtbd004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbd004  #顯示到畫面上
            NEXT FIELD rtbd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd004
            #add-point:BEFORE FIELD rtbd004 name="construct.b.rtbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd004
            
            #add-point:AFTER FIELD rtbd004 name="construct.a.rtbd004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd005
            #add-point:BEFORE FIELD rtbd005 name="construct.b.rtbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd005
            
            #add-point:AFTER FIELD rtbd005 name="construct.a.rtbd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd005
            #add-point:ON ACTION controlp INFIELD rtbd005 name="construct.c.rtbd005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdstus
            #add-point:BEFORE FIELD rtbdstus name="construct.b.rtbdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdstus
            
            #add-point:AFTER FIELD rtbdstus name="construct.a.rtbdstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdstus
            #add-point:ON ACTION controlp INFIELD rtbdstus name="construct.c.rtbdstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdownid
            #add-point:ON ACTION controlp INFIELD rtbdownid name="construct.c.rtbdownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdownid  #顯示到畫面上
            NEXT FIELD rtbdownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdownid
            #add-point:BEFORE FIELD rtbdownid name="construct.b.rtbdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdownid
            
            #add-point:AFTER FIELD rtbdownid name="construct.a.rtbdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdowndp
            #add-point:ON ACTION controlp INFIELD rtbdowndp name="construct.c.rtbdowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdowndp  #顯示到畫面上
            NEXT FIELD rtbdowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdowndp
            #add-point:BEFORE FIELD rtbdowndp name="construct.b.rtbdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdowndp
            
            #add-point:AFTER FIELD rtbdowndp name="construct.a.rtbdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdcrtid
            #add-point:ON ACTION controlp INFIELD rtbdcrtid name="construct.c.rtbdcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdcrtid  #顯示到畫面上
            NEXT FIELD rtbdcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdcrtid
            #add-point:BEFORE FIELD rtbdcrtid name="construct.b.rtbdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdcrtid
            
            #add-point:AFTER FIELD rtbdcrtid name="construct.a.rtbdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdcrtdp
            #add-point:ON ACTION controlp INFIELD rtbdcrtdp name="construct.c.rtbdcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdcrtdp  #顯示到畫面上
            NEXT FIELD rtbdcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdcrtdp
            #add-point:BEFORE FIELD rtbdcrtdp name="construct.b.rtbdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdcrtdp
            
            #add-point:AFTER FIELD rtbdcrtdp name="construct.a.rtbdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdcrtdt
            #add-point:BEFORE FIELD rtbdcrtdt name="construct.b.rtbdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdmodid
            #add-point:ON ACTION controlp INFIELD rtbdmodid name="construct.c.rtbdmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdmodid  #顯示到畫面上
            NEXT FIELD rtbdmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdmodid
            #add-point:BEFORE FIELD rtbdmodid name="construct.b.rtbdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdmodid
            
            #add-point:AFTER FIELD rtbdmodid name="construct.a.rtbdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdmoddt
            #add-point:BEFORE FIELD rtbdmoddt name="construct.b.rtbdmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbdcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdcnfid
            #add-point:ON ACTION controlp INFIELD rtbdcnfid name="construct.c.rtbdcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdcnfid  #顯示到畫面上
            NEXT FIELD rtbdcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdcnfid
            #add-point:BEFORE FIELD rtbdcnfid name="construct.b.rtbdcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdcnfid
            
            #add-point:AFTER FIELD rtbdcnfid name="construct.a.rtbdcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdcnfdt
            #add-point:BEFORE FIELD rtbdcnfdt name="construct.b.rtbdcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbdpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdpstid
            #add-point:ON ACTION controlp INFIELD rtbdpstid name="construct.c.rtbdpstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbdpstid  #顯示到畫面上
            NEXT FIELD rtbdpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdpstid
            #add-point:BEFORE FIELD rtbdpstid name="construct.b.rtbdpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdpstid
            
            #add-point:AFTER FIELD rtbdpstid name="construct.a.rtbdpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdpstdt
            #add-point:BEFORE FIELD rtbdpstdt name="construct.b.rtbdpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtbesite,rtbeseq,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005,rtbe006
           FROM s_detail1[1].rtbesite,s_detail1[1].rtbeseq,s_detail1[1].rtbe001,s_detail1[1].rtbe002, 
               s_detail1[1].rtbe003,s_detail1[1].rtbe004,s_detail1[1].rtbe005,s_detail1[1].rtbe006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbesite
            #add-point:BEFORE FIELD rtbesite name="construct.b.page1.rtbesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbesite
            
            #add-point:AFTER FIELD rtbesite name="construct.a.page1.rtbesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbesite
            #add-point:ON ACTION controlp INFIELD rtbesite name="construct.c.page1.rtbesite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbeseq
            #add-point:BEFORE FIELD rtbeseq name="construct.b.page1.rtbeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbeseq
            
            #add-point:AFTER FIELD rtbeseq name="construct.a.page1.rtbeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbeseq
            #add-point:ON ACTION controlp INFIELD rtbeseq name="construct.c.page1.rtbeseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe001
            #add-point:ON ACTION controlp INFIELD rtbe001 name="construct.c.page1.rtbe001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbe001  #顯示到畫面上
            NEXT FIELD rtbe001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe001
            #add-point:BEFORE FIELD rtbe001 name="construct.b.page1.rtbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe001
            
            #add-point:AFTER FIELD rtbe001 name="construct.a.page1.rtbe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe002
            #add-point:ON ACTION controlp INFIELD rtbe002 name="construct.c.page1.rtbe002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbe002  #顯示到畫面上
            NEXT FIELD rtbe002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe002
            #add-point:BEFORE FIELD rtbe002 name="construct.b.page1.rtbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe002
            
            #add-point:AFTER FIELD rtbe002 name="construct.a.page1.rtbe002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe003
            #add-point:ON ACTION controlp INFIELD rtbe003 name="construct.c.page1.rtbe003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbe003  #顯示到畫面上
            NEXT FIELD rtbe003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe003
            #add-point:BEFORE FIELD rtbe003 name="construct.b.page1.rtbe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe003
            
            #add-point:AFTER FIELD rtbe003 name="construct.a.page1.rtbe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe004
            #add-point:ON ACTION controlp INFIELD rtbe004 name="construct.c.page1.rtbe004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_16()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbe004  #顯示到畫面上
            NEXT FIELD rtbe004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe004
            #add-point:BEFORE FIELD rtbe004 name="construct.b.page1.rtbe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe004
            
            #add-point:AFTER FIELD rtbe004 name="construct.a.page1.rtbe004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe005
            #add-point:BEFORE FIELD rtbe005 name="construct.b.page1.rtbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe005
            
            #add-point:AFTER FIELD rtbe005 name="construct.a.page1.rtbe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe005
            #add-point:ON ACTION controlp INFIELD rtbe005 name="construct.c.page1.rtbe005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe006
            #add-point:BEFORE FIELD rtbe006 name="construct.b.page1.rtbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe006
            
            #add-point:AFTER FIELD rtbe006 name="construct.a.page1.rtbe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe006
            #add-point:ON ACTION controlp INFIELD rtbe006 name="construct.c.page1.rtbe006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rtbfsite,rtbfseq,rtbfseq1,rtbf001,rtbf002,rtbf003,rtbf004,rtbf005,rtbf006, 
          rtbf007,rtbf008,rtbf009
           FROM s_detail2[1].rtbfsite,s_detail2[1].rtbfseq,s_detail2[1].rtbfseq1,s_detail2[1].rtbf001, 
               s_detail2[1].rtbf002,s_detail2[1].rtbf003,s_detail2[1].rtbf004,s_detail2[1].rtbf005,s_detail2[1].rtbf006, 
               s_detail2[1].rtbf007,s_detail2[1].rtbf008,s_detail2[1].rtbf009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbfsite
            #add-point:BEFORE FIELD rtbfsite name="construct.b.page2.rtbfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbfsite
            
            #add-point:AFTER FIELD rtbfsite name="construct.a.page2.rtbfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbfsite
            #add-point:ON ACTION controlp INFIELD rtbfsite name="construct.c.page2.rtbfsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbfseq
            #add-point:BEFORE FIELD rtbfseq name="construct.b.page2.rtbfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbfseq
            
            #add-point:AFTER FIELD rtbfseq name="construct.a.page2.rtbfseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbfseq
            #add-point:ON ACTION controlp INFIELD rtbfseq name="construct.c.page2.rtbfseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbfseq1
            #add-point:BEFORE FIELD rtbfseq1 name="construct.b.page2.rtbfseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbfseq1
            
            #add-point:AFTER FIELD rtbfseq1 name="construct.a.page2.rtbfseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbfseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbfseq1
            #add-point:ON ACTION controlp INFIELD rtbfseq1 name="construct.c.page2.rtbfseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtbf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf001
            #add-point:ON ACTION controlp INFIELD rtbf001 name="construct.c.page2.rtbf001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbf001  #顯示到畫面上
            NEXT FIELD rtbf001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf001
            #add-point:BEFORE FIELD rtbf001 name="construct.b.page2.rtbf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf001
            
            #add-point:AFTER FIELD rtbf001 name="construct.a.page2.rtbf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf002
            #add-point:ON ACTION controlp INFIELD rtbf002 name="construct.c.page2.rtbf002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbf002  #顯示到畫面上
            NEXT FIELD rtbf002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf002
            #add-point:BEFORE FIELD rtbf002 name="construct.b.page2.rtbf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf002
            
            #add-point:AFTER FIELD rtbf002 name="construct.a.page2.rtbf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf003
            #add-point:ON ACTION controlp INFIELD rtbf003 name="construct.c.page2.rtbf003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbf003  #顯示到畫面上
            NEXT FIELD rtbf003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf003
            #add-point:BEFORE FIELD rtbf003 name="construct.b.page2.rtbf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf003
            
            #add-point:AFTER FIELD rtbf003 name="construct.a.page2.rtbf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf004
            #add-point:BEFORE FIELD rtbf004 name="construct.b.page2.rtbf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf004
            
            #add-point:AFTER FIELD rtbf004 name="construct.a.page2.rtbf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf004
            #add-point:ON ACTION controlp INFIELD rtbf004 name="construct.c.page2.rtbf004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbf004  #顯示到畫面上
            NEXT FIELD rtbf004     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf005
            #add-point:BEFORE FIELD rtbf005 name="construct.b.page2.rtbf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf005
            
            #add-point:AFTER FIELD rtbf005 name="construct.a.page2.rtbf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf005
            #add-point:ON ACTION controlp INFIELD rtbf005 name="construct.c.page2.rtbf005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rtbf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf006
            #add-point:ON ACTION controlp INFIELD rtbf006 name="construct.c.page2.rtbf006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_16()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbf006  #顯示到畫面上
            NEXT FIELD rtbf006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf006
            #add-point:BEFORE FIELD rtbf006 name="construct.b.page2.rtbf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf006
            
            #add-point:AFTER FIELD rtbf006 name="construct.a.page2.rtbf006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf007
            #add-point:BEFORE FIELD rtbf007 name="construct.b.page2.rtbf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf007
            
            #add-point:AFTER FIELD rtbf007 name="construct.a.page2.rtbf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf007
            #add-point:ON ACTION controlp INFIELD rtbf007 name="construct.c.page2.rtbf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf008
            #add-point:BEFORE FIELD rtbf008 name="construct.b.page2.rtbf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf008
            
            #add-point:AFTER FIELD rtbf008 name="construct.a.page2.rtbf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf008
            #add-point:ON ACTION controlp INFIELD rtbf008 name="construct.c.page2.rtbf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbf009
            #add-point:BEFORE FIELD rtbf009 name="construct.b.page2.rtbf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbf009
            
            #add-point:AFTER FIELD rtbf009 name="construct.a.page2.rtbf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtbf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbf009
            #add-point:ON ACTION controlp INFIELD rtbf009 name="construct.c.page2.rtbf009"
            
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
                  WHEN la_wc[li_idx].tableid = "rtbd_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtbe_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtbf_t" 
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
 
{<section id="artt302.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt302_filter()
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
      CONSTRUCT g_wc_filter ON rtbdsite,rtbddocdt,rtbddocno,rtbd001,rtbd002,rtbd003,rtbd004,rtbd005
                          FROM s_browse[1].b_rtbdsite,s_browse[1].b_rtbddocdt,s_browse[1].b_rtbddocno, 
                              s_browse[1].b_rtbd001,s_browse[1].b_rtbd002,s_browse[1].b_rtbd003,s_browse[1].b_rtbd004, 
                              s_browse[1].b_rtbd005
 
         BEFORE CONSTRUCT
               DISPLAY artt302_filter_parser('rtbdsite') TO s_browse[1].b_rtbdsite
            DISPLAY artt302_filter_parser('rtbddocdt') TO s_browse[1].b_rtbddocdt
            DISPLAY artt302_filter_parser('rtbddocno') TO s_browse[1].b_rtbddocno
            DISPLAY artt302_filter_parser('rtbd001') TO s_browse[1].b_rtbd001
            DISPLAY artt302_filter_parser('rtbd002') TO s_browse[1].b_rtbd002
            DISPLAY artt302_filter_parser('rtbd003') TO s_browse[1].b_rtbd003
            DISPLAY artt302_filter_parser('rtbd004') TO s_browse[1].b_rtbd004
            DISPLAY artt302_filter_parser('rtbd005') TO s_browse[1].b_rtbd005
      
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
 
      CALL artt302_filter_show('rtbdsite')
   CALL artt302_filter_show('rtbddocdt')
   CALL artt302_filter_show('rtbddocno')
   CALL artt302_filter_show('rtbd001')
   CALL artt302_filter_show('rtbd002')
   CALL artt302_filter_show('rtbd003')
   CALL artt302_filter_show('rtbd004')
   CALL artt302_filter_show('rtbd005')
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt302_filter_parser(ps_field)
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
 
{<section id="artt302.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt302_filter_show(ps_field)
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
   LET ls_condition = artt302_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt302_query()
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
   CALL g_rtbe_d.clear()
   CALL g_rtbe2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt302_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt302_browser_fill("")
      CALL artt302_fetch("")
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
      CALL artt302_filter_show('rtbdsite')
   CALL artt302_filter_show('rtbddocdt')
   CALL artt302_filter_show('rtbddocno')
   CALL artt302_filter_show('rtbd001')
   CALL artt302_filter_show('rtbd002')
   CALL artt302_filter_show('rtbd003')
   CALL artt302_filter_show('rtbd004')
   CALL artt302_filter_show('rtbd005')
   CALL artt302_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt302_fetch("F") 
      #顯示單身筆數
      CALL artt302_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt302_fetch(p_flag)
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
   
   LET g_rtbd_m.rtbddocno = g_browser[g_current_idx].b_rtbddocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
       g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
       g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
       g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
       g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
       g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdpstid_desc 
 
   
   #遮罩相關處理
   LET g_rtbd_m_mask_o.* =  g_rtbd_m.*
   CALL artt302_rtbd_t_mask()
   LET g_rtbd_m_mask_n.* =  g_rtbd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt302_set_act_visible()   
   CALL artt302_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtbd_m_t.* = g_rtbd_m.*
   LET g_rtbd_m_o.* = g_rtbd_m.*
   
   LET g_data_owner = g_rtbd_m.rtbdownid      
   LET g_data_dept  = g_rtbd_m.rtbdowndp
   
   #重新顯示   
   CALL artt302_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt302_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtbe_d.clear()   
   CALL g_rtbe2_d.clear()  
 
 
   INITIALIZE g_rtbd_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtbddocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtbd_m.rtbdownid = g_user
      LET g_rtbd_m.rtbdowndp = g_dept
      LET g_rtbd_m.rtbdcrtid = g_user
      LET g_rtbd_m.rtbdcrtdp = g_dept 
      LET g_rtbd_m.rtbdcrtdt = cl_get_current()
      LET g_rtbd_m.rtbdmodid = g_user
      LET g_rtbd_m.rtbdmoddt = cl_get_current()
      LET g_rtbd_m.rtbdstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      #营运据点
      CALL s_aooi500_default(g_prog,'rtbdsite',g_rtbd_m.rtbdsite) RETURNING l_insert,g_rtbd_m.rtbdsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_rtbd_m.rtbdsite) RETURNING g_rtbd_m.rtbdsite_desc
      DISPLAY BY NAME g_rtbd_m.rtbdsite_desc
      LET g_site_flag = FALSE
      #单据日期
      LET g_rtbd_m.rtbddocdt = g_today
      
      #单据别
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtbd_m.rtbdsite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_rtbd_m.rtbddocno = l_doctype
      
      LET g_rtbd_m.rtbd003   = g_user
      CALL artt302_rtbd003_ref()
      LET g_rtbd_m.rtbd004   = g_dept
      CALL artt302_rtbd004_ref()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtbd_m_t.* = g_rtbd_m.*
      LET g_rtbd_m_o.* = g_rtbd_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtbd_m.rtbdstus 
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
 
 
 
    
      CALL artt302_input("a")
      
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
         INITIALIZE g_rtbd_m.* TO NULL
         INITIALIZE g_rtbe_d TO NULL
         INITIALIZE g_rtbe2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt302_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtbe_d.clear()
      #CALL g_rtbe2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt302_set_act_visible()   
   CALL artt302_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtbdent = " ||g_enterprise|| " AND",
                      " rtbddocno = '", g_rtbd_m.rtbddocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt302_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt302_cl
   
   CALL artt302_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
       g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
       g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
       g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
       g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
       g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdpstid_desc 
 
   
   
   #遮罩相關處理
   LET g_rtbd_m_mask_o.* =  g_rtbd_m.*
   CALL artt302_rtbd_t_mask()
   LET g_rtbd_m_mask_n.* =  g_rtbd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001, 
       g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002,g_rtbd_m.rtbd002_desc,g_rtbd_m.rtbd003,g_rtbd_m.rtbd003_desc, 
       g_rtbd_m.rtbd004,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid, 
       g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp,g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmodid_desc, 
       g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdcnfdt,g_rtbd_m.rtbdpstid, 
       g_rtbd_m.rtbdpstid_desc,g_rtbd_m.rtbdpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtbd_m.rtbdownid      
   LET g_data_dept  = g_rtbd_m.rtbdowndp
   
   #功能已完成,通報訊息中心
   CALL artt302_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt302_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtbd_m_t.* = g_rtbd_m.*
   LET g_rtbd_m_o.* = g_rtbd_m.*
   
   IF g_rtbd_m.rtbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
   CALL s_transaction_begin()
   
   OPEN artt302_cl USING g_enterprise,g_rtbd_m.rtbddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt302_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt302_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
       g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
       g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
       g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
       g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
       g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdpstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT artt302_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtbd_m_mask_o.* =  g_rtbd_m.*
   CALL artt302_rtbd_t_mask()
   LET g_rtbd_m_mask_n.* =  g_rtbd_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL artt302_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtbd_m.rtbdmodid = g_user 
LET g_rtbd_m.rtbdmoddt = cl_get_current()
LET g_rtbd_m.rtbdmodid_desc = cl_get_username(g_rtbd_m.rtbdmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt302_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtbd_t SET (rtbdmodid,rtbdmoddt) = (g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt)
          WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbddocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtbd_m.* = g_rtbd_m_t.*
            CALL artt302_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtbd_m.rtbddocno != g_rtbd_m_t.rtbddocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rtbe_t SET rtbedocno = g_rtbd_m.rtbddocno
 
          WHERE rtbeent = g_enterprise AND rtbedocno = g_rtbd_m_t.rtbddocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtbe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtbe_t:",SQLERRMESSAGE 
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
         
         UPDATE rtbf_t
            SET rtbfdocno = g_rtbd_m.rtbddocno
 
          WHERE rtbfent = g_enterprise AND
                rtbfdocno = g_rtbddocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtbf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtbf_t:",SQLERRMESSAGE 
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
   CALL artt302_set_act_visible()   
   CALL artt302_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtbdent = " ||g_enterprise|| " AND",
                      " rtbddocno = '", g_rtbd_m.rtbddocno, "' "
 
   #填到對應位置
   CALL artt302_browser_fill("")
 
   CLOSE artt302_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt302_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt302.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt302_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               STRING
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
   DISPLAY BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001, 
       g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002,g_rtbd_m.rtbd002_desc,g_rtbd_m.rtbd003,g_rtbd_m.rtbd003_desc, 
       g_rtbd_m.rtbd004,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid, 
       g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp,g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmodid_desc, 
       g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdcnfdt,g_rtbd_m.rtbdpstid, 
       g_rtbd_m.rtbdpstid_desc,g_rtbd_m.rtbdpstdt
   
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
   LET g_forupd_sql = "SELECT rtbesite,rtbeseq,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005,rtbe006 FROM  
       rtbe_t WHERE rtbeent=? AND rtbedocno=? AND rtbeseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt302_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT rtbfsite,rtbfseq,rtbfseq1,rtbf001,rtbf002,rtbf003,rtbf004,rtbf005,rtbf006, 
       rtbf007,rtbf008,rtbf009 FROM rtbf_t WHERE rtbfent=? AND rtbfdocno=? AND rtbfseq=? AND rtbfseq1=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt302_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt302_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL artt302_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002, 
       g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt302.input.head" >}
      #單頭段
      INPUT BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002, 
          g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt302_cl USING g_enterprise,g_rtbd_m.rtbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt302_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt302_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt302_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL artt302_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdsite
            
            #add-point:AFTER FIELD rtbdsite name="input.a.rtbdsite"
            IF NOT cl_null(g_rtbd_m.rtbdsite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtbd_m.rtbdsite != g_rtbd_m_t.rtbdsite OR g_rtbd_m_t.rtbdsite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'rtbdsite',g_rtbd_m.rtbdsite,g_rtbd_m.rtbdsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_rtbd_m.rtbdsite = g_rtbd_m_t.rtbdsite
                     CALL s_desc_get_department_desc(g_rtbd_m.rtbdsite)
                        RETURNING g_rtbd_m.rtbdsite_desc
                     DISPLAY BY NAME g_rtbd_m.rtbdsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET g_site_flag = TRUE
               CALL artt302_set_entry(p_cmd)
               CALL artt302_set_no_entry(p_cmd)
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbd_m.rtbdsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbd_m.rtbdsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbd_m.rtbdsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdsite
            #add-point:BEFORE FIELD rtbdsite name="input.b.rtbdsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbdsite
            #add-point:ON CHANGE rtbdsite name="input.g.rtbdsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbddocdt
            #add-point:BEFORE FIELD rtbddocdt name="input.b.rtbddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbddocdt
            
            #add-point:AFTER FIELD rtbddocdt name="input.a.rtbddocdt"
            IF  NOT cl_null(g_rtbd_m.rtbddocdt) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtbd_m.rtbddocdt != g_rtbd_m_t.rtbddocdt )) THEN
                  #結算會計期檢查
                  IF NOT cl_null(g_rtbd_m.rtbdsite) AND NOT cl_null(g_rtbd_m.rtbddocdt) THEN
                     CALL s_asti206_check(g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt,g_prog) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_rtbd_m.rtbddocdt = g_rtbd_m_t.rtbddocdt
                        NEXT FIELD CURRENT
                     END IF
                  END IF

               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbddocdt
            #add-point:ON CHANGE rtbddocdt name="input.g.rtbddocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbddocno
            #add-point:BEFORE FIELD rtbddocno name="input.b.rtbddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbddocno
            
            #add-point:AFTER FIELD rtbddocno name="input.a.rtbddocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rtbd_m.rtbddocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtbd_m.rtbddocno != g_rtbddocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtbd_t WHERE "||"rtbdent = '" ||g_enterprise|| "' AND "||"rtbddocno = '"||g_rtbd_m.rtbddocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT s_aooi200_chk_slip(g_rtbd_m.rtbdsite,'',g_rtbd_m.rtbddocno,g_prog) THEN
                  LET g_rtbd_m.rtbddocno = g_rtbddocno_t
                  NEXT FIELD CURRENT   
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbddocno
            #add-point:ON CHANGE rtbddocno name="input.g.rtbddocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd001
            
            #add-point:AFTER FIELD rtbd001 name="input.a.rtbd001"
            IF NOT cl_null(g_rtbd_m.rtbd001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbd_m.rtbd001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            #转出小类不能等于转入小类
            IF NOT cl_null(g_rtbd_m.rtbd001) AND NOT cl_null(g_rtbd_m.rtbd002) THEN 
               IF g_rtbd_m.rtbd001 = g_rtbd_m.rtbd002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00698'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                 
                  LET g_rtbd_m.rtbd001 = g_rtbd_m_t.rtbd001
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbd_m.rtbd001
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbd_m.rtbd001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbd_m.rtbd001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd001
            #add-point:BEFORE FIELD rtbd001 name="input.b.rtbd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbd001
            #add-point:ON CHANGE rtbd001 name="input.g.rtbd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd002
            
            #add-point:AFTER FIELD rtbd002 name="input.a.rtbd002"
            IF NOT cl_null(g_rtbd_m.rtbd002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbd_m.rtbd002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            #转出小类不能等于转入小类
            IF NOT cl_null(g_rtbd_m.rtbd001) AND NOT cl_null(g_rtbd_m.rtbd002) THEN 
               IF g_rtbd_m.rtbd001 = g_rtbd_m.rtbd002 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00698'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                 
                  LET g_rtbd_m.rtbd002 = g_rtbd_m_t.rtbd002
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbd_m.rtbd002
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbd_m.rtbd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbd_m.rtbd002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd002
            #add-point:BEFORE FIELD rtbd002 name="input.b.rtbd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbd002
            #add-point:ON CHANGE rtbd002 name="input.g.rtbd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd003
            
            #add-point:AFTER FIELD rtbd003 name="input.a.rtbd003"
            IF NOT cl_null(g_rtbd_m.rtbd003) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbd_m.rtbd003

               #160318-00025#16  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#16  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               IF g_rtbd_m_t.rtbd003 != g_rtbd_m.rtbd003 THEN
                  SELECT ooag003 INTO g_rtbd_m.rtbd004
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_rtbd_m.rtbd003
                  CALL artt302_rtbd004_ref()
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbd_m.rtbd003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rtbd_m.rtbd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbd_m.rtbd003_desc
            LET g_rtbd_m_t.rtbd003 = g_rtbd_m.rtbd003

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd003
            #add-point:BEFORE FIELD rtbd003 name="input.b.rtbd003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbd003
            #add-point:ON CHANGE rtbd003 name="input.g.rtbd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd004
            
            #add-point:AFTER FIELD rtbd004 name="input.a.rtbd004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbd_m.rtbd004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbd_m.rtbd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbd_m.rtbd004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd004
            #add-point:BEFORE FIELD rtbd004 name="input.b.rtbd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbd004
            #add-point:ON CHANGE rtbd004 name="input.g.rtbd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbd005
            #add-point:BEFORE FIELD rtbd005 name="input.b.rtbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbd005
            
            #add-point:AFTER FIELD rtbd005 name="input.a.rtbd005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbd005
            #add-point:ON CHANGE rtbd005 name="input.g.rtbd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbdstus
            #add-point:BEFORE FIELD rtbdstus name="input.b.rtbdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbdstus
            
            #add-point:AFTER FIELD rtbdstus name="input.a.rtbdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbdstus
            #add-point:ON CHANGE rtbdstus name="input.g.rtbdstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtbdsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdsite
            #add-point:ON ACTION controlp INFIELD rtbdsite name="input.c.rtbdsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbd_m.rtbdsite             #給予default值


            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbdsite',g_rtbd_m.rtbdsite,'i')

            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtbd_m.rtbdsite = g_qryparam.return1              

            DISPLAY g_rtbd_m.rtbdsite TO rtbdsite              #

            NEXT FIELD rtbdsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbddocdt
            #add-point:ON ACTION controlp INFIELD rtbddocdt name="input.c.rtbddocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtbddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbddocno
            #add-point:ON ACTION controlp INFIELD rtbddocno name="input.c.rtbddocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbd_m.rtbddocno             #給予default值

            #給予arg
            LET l_ooef004 = ''            
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise  
            LET g_qryparam.arg1 = l_ooef004  #參照表編號
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rtbd_m.rtbddocno = g_qryparam.return1              

            DISPLAY g_rtbd_m.rtbddocno TO rtbddocno              #

            NEXT FIELD rtbddocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd001
            #add-point:ON ACTION controlp INFIELD rtbd001 name="input.c.rtbd001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbd_m.rtbd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rtax001_2()                                #呼叫開窗

            LET g_rtbd_m.rtbd001 = g_qryparam.return1              

            DISPLAY g_rtbd_m.rtbd001 TO rtbd001              #

            NEXT FIELD rtbd001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd002
            #add-point:ON ACTION controlp INFIELD rtbd002 name="input.c.rtbd002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbd_m.rtbd002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rtax001_2()                                #呼叫開窗

            LET g_rtbd_m.rtbd002 = g_qryparam.return1              

            DISPLAY g_rtbd_m.rtbd002 TO rtbd002              #

            NEXT FIELD rtbd002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd003
            #add-point:ON ACTION controlp INFIELD rtbd003 name="input.c.rtbd003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbd_m.rtbd003             #給予default值
            LET g_qryparam.default2 = "" #g_rtbd_m.ooag003 #归属部门
            LET g_qryparam.default3 = "" #g_rtbd_m.ooefl003 #說明(簡稱)
            LET g_qryparam.default4 = "" #g_rtbd_m.ooag011 #全名
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001_6()                                #呼叫開窗

            LET g_rtbd_m.rtbd003 = g_qryparam.return1              
            #LET g_rtbd_m.ooag003 = g_qryparam.return2 
            #LET g_rtbd_m.ooefl003 = g_qryparam.return3 
            #LET g_rtbd_m.ooag011 = g_qryparam.return4 
            DISPLAY g_rtbd_m.rtbd003 TO rtbd003              #
            #DISPLAY g_rtbd_m.ooag003 TO ooag003 #归属部门
            #DISPLAY g_rtbd_m.ooefl003 TO ooefl003 #說明(簡稱)
            #DISPLAY g_rtbd_m.ooag011 TO ooag011 #全名
            NEXT FIELD rtbd003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd004
            #add-point:ON ACTION controlp INFIELD rtbd004 name="input.c.rtbd004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbd_m.rtbd004             #給予default值
            LET g_qryparam.default2 = "" #g_rtbd_m.ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today #s


            CALL q_ooeg001()                                #呼叫開窗

            LET g_rtbd_m.rtbd004 = g_qryparam.return1              
            #LET g_rtbd_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_rtbd_m.rtbd004 TO rtbd004              #
            #DISPLAY g_rtbd_m.ooeg001 TO ooeg001 #部門編號
            NEXT FIELD rtbd004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbd005
            #add-point:ON ACTION controlp INFIELD rtbd005 name="input.c.rtbd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtbdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbdstus
            #add-point:ON ACTION controlp INFIELD rtbdstus name="input.c.rtbdstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtbd_m.rtbddocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_rtbd_m.rtbddocno,g_rtbd_m.rtbddocdt,g_prog) RETURNING l_success,g_rtbd_m.rtbddocno
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_rtbd_m.rtbddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG                  
               END IF
               #end add-point
               
               INSERT INTO rtbd_t (rtbdent,rtbdsite,rtbddocdt,rtbddocno,rtbd001,rtbd002,rtbd003,rtbd004, 
                   rtbd005,rtbdstus,rtbdownid,rtbdowndp,rtbdcrtid,rtbdcrtdp,rtbdcrtdt,rtbdmodid,rtbdmoddt, 
                   rtbdcnfid,rtbdcnfdt,rtbdpstid,rtbdpstdt)
               VALUES (g_enterprise,g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001, 
                   g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus, 
                   g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp,g_rtbd_m.rtbdcrtdt, 
                   g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt,g_rtbd_m.rtbdpstid, 
                   g_rtbd_m.rtbdpstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtbd_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL artt302_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt302_b_fill()
                  CALL artt302_b_fill2('0')
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
               CALL artt302_rtbd_t_mask_restore('restore_mask_o')
               
               UPDATE rtbd_t SET (rtbdsite,rtbddocdt,rtbddocno,rtbd001,rtbd002,rtbd003,rtbd004,rtbd005, 
                   rtbdstus,rtbdownid,rtbdowndp,rtbdcrtid,rtbdcrtdp,rtbdcrtdt,rtbdmodid,rtbdmoddt,rtbdcnfid, 
                   rtbdcnfdt,rtbdpstid,rtbdpstdt) = (g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno, 
                   g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
                   g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
                   g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
                   g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt)
                WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbddocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtbd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artt302_rtbd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtbd_m_t)
               LET g_log2 = util.JSON.stringify(g_rtbd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt302.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtbe_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtbe_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt302_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtbe_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            CALL artt302_b_fill() 
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
            OPEN artt302_cl USING g_enterprise,g_rtbd_m.rtbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt302_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt302_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtbe_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtbe_d[l_ac].rtbeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtbe_d_t.* = g_rtbe_d[l_ac].*  #BACKUP
               LET g_rtbe_d_o.* = g_rtbe_d[l_ac].*  #BACKUP
               CALL artt302_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL artt302_set_no_entry_b(l_cmd)
               IF NOT artt302_lock_b("rtbe_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt302_bcl INTO g_rtbe_d[l_ac].rtbesite,g_rtbe_d[l_ac].rtbeseq,g_rtbe_d[l_ac].rtbe001, 
                      g_rtbe_d[l_ac].rtbe002,g_rtbe_d[l_ac].rtbe003,g_rtbe_d[l_ac].rtbe004,g_rtbe_d[l_ac].rtbe005, 
                      g_rtbe_d[l_ac].rtbe006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtbe_d_t.rtbeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtbe_d_mask_o[l_ac].* =  g_rtbe_d[l_ac].*
                  CALL artt302_rtbe_t_mask()
                  LET g_rtbe_d_mask_n[l_ac].* =  g_rtbe_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt302_show()
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
            INITIALIZE g_rtbe_d[l_ac].* TO NULL 
            INITIALIZE g_rtbe_d_t.* TO NULL 
            INITIALIZE g_rtbe_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtbe_d[l_ac].rtbeseq = "0"
      LET g_rtbe_d[l_ac].rtbe005 = "0"
      LET g_rtbe_d[l_ac].rtbe006 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(rtbeseq)+1 INTO g_rtbe_d[l_ac].rtbeseq            #项次   
              FROM rtbe_t
             WHERE rtbeent=g_enterprise
               AND rtbedocno=g_rtbd_m.rtbddocno
            IF cl_null(g_rtbe_d[l_ac].rtbeseq) THEN
               LET g_rtbe_d[l_ac].rtbeseq=1
            END IF    
            LET g_rtbe_d[l_ac].rtbesite = g_rtbd_m.rtbdsite
            #end add-point
            LET g_rtbe_d_t.* = g_rtbe_d[l_ac].*     #新輸入資料
            LET g_rtbe_d_o.* = g_rtbe_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt302_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artt302_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtbe_d[li_reproduce_target].* = g_rtbe_d[li_reproduce].*
 
               LET g_rtbe_d[li_reproduce_target].rtbeseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM rtbe_t 
             WHERE rtbeent = g_enterprise AND rtbedocno = g_rtbd_m.rtbddocno
 
               AND rtbeseq = g_rtbe_d[l_ac].rtbeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtbd_m.rtbddocno
               LET gs_keys[2] = g_rtbe_d[g_detail_idx].rtbeseq
               CALL artt302_insert_b('rtbe_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #新增库存明细
               CALL artt302_rtbf_init(g_rtbe_d[l_ac].rtbeseq,g_rtbe_d[l_ac].rtbe001,g_rtbe_d[l_ac].rtbe002,g_rtbe_d[l_ac].rtbe003,g_rtbe_d[l_ac].rtbe004)  RETURNING l_success  
               IF NOT l_success THEN
                  INITIALIZE g_rtbe_d[l_ac].* TO NULL
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT                 
               END IF
               CALL artt302_b_fill()               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtbe_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt302_b_fill()
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
               LET gs_keys[01] = g_rtbd_m.rtbddocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtbe_d_t.rtbeseq
 
            
               #刪除同層單身
               IF NOT artt302_delete_b('rtbe_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt302_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt302_key_delete_b(gs_keys,'rtbe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt302_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt302_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               #删除库存明细单身对的资料
               DELETE FROM rtbf_t
                WHERE rtbfent = g_enterprise AND
                  rtbfdocno = g_rtbd_m.rtbddocno AND rtbfseq = g_rtbe_d_t.rtbeseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CLOSE artt302_bcl
                  CANCEL DELETE
               END IF  
                     
               #end add-point
               LET l_count = g_rtbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtbe_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbesite
            #add-point:BEFORE FIELD rtbesite name="input.b.page1.rtbesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbesite
            
            #add-point:AFTER FIELD rtbesite name="input.a.page1.rtbesite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbesite
            #add-point:ON CHANGE rtbesite name="input.g.page1.rtbesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbeseq
            #add-point:BEFORE FIELD rtbeseq name="input.b.page1.rtbeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbeseq
            
            #add-point:AFTER FIELD rtbeseq name="input.a.page1.rtbeseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtbd_m.rtbddocno IS NOT NULL AND g_rtbe_d[g_detail_idx].rtbeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtbd_m.rtbddocno != g_rtbddocno_t OR g_rtbe_d[g_detail_idx].rtbeseq != g_rtbe_d_t.rtbeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtbe_t WHERE "||"rtbeent = '" ||g_enterprise|| "' AND "||"rtbedocno = '"||g_rtbd_m.rtbddocno ||"' AND "|| "rtbeseq = '"||g_rtbe_d[g_detail_idx].rtbeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbeseq
            #add-point:ON CHANGE rtbeseq name="input.g.page1.rtbeseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe001
            
            #add-point:AFTER FIELD rtbe001 name="input.a.page1.rtbe001"
            IF NOT cl_null(g_rtbe_d[l_ac].rtbe001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbe_d[l_ac].rtbe001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imay003") THEN
                  #檢查成功時後續處理
                  #mark by geza 20150906(S)
                  #检查商品是否存在于采购协议中
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt
#                    FROM stas_t
#                   WHERE stasent = g_enterprise
#                     AND stas004 = g_rtbe_d[l_ac].rtbe001   
#                     AND stassite = g_rtbd_m.rtbdsite
#                  IF l_cnt = 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = ''
#                     LET g_errparam.code = 'art-00699'     
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_rtbe_d[l_ac].rtbe001  = g_rtbe_d_t.rtbe001 
#                     NEXT FIELD CURRENT
#                  END IF 
                  #mark by geza 20150906(E)
                  #检查商品是否属于转出小类
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM imaa_t,imay_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = imay001
                     AND imaaent = imayent
                     AND imay003 = g_rtbe_d[l_ac].rtbe001
                     AND imaa009 = g_rtbd_m.rtbd001
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'art-00700'     
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rtbe_d[l_ac].rtbe001  = g_rtbe_d_t.rtbe001 
                     NEXT FIELD CURRENT
                  END IF
                  #检查商品编号是否重复
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM rtbe_t
                   WHERE rtbeent = g_enterprise
                     AND rtbe001 = g_rtbe_d[l_ac].rtbe001
                     AND rtbedocno = g_rtbd_m.rtbddocno
                     AND rtbeseq != g_rtbe_d[l_ac].rtbeseq
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'art-00705'     
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rtbe_d[l_ac].rtbe001  = g_rtbe_d_t.rtbe001 
                     NEXT FIELD CURRENT
                  END IF                       
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               #带值
               CALL artt302_rtbe001_init()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe001
            #add-point:BEFORE FIELD rtbe001 name="input.b.page1.rtbe001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbe001
            #add-point:ON CHANGE rtbe001 name="input.g.page1.rtbe001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe002
            
            #add-point:AFTER FIELD rtbe002 name="input.a.page1.rtbe002"
            IF NOT cl_null(g_rtbe_d[l_ac].rtbe002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbe_d[l_ac].rtbe002

               #160318-00025#16 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#16 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001_5") THEN
                  #檢查成功時後續處理
                  #mark by geza 20150906(S)
                  #检查商品是否存在于采购协议中
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt
#                    FROM stas_t
#                   WHERE stasent = g_enterprise
#                     AND stas003 = g_rtbe_d[l_ac].rtbe002   
#                     AND stassite = g_rtbd_m.rtbdsite
#                  IF l_cnt = 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = ''
#                     LET g_errparam.code = 'art-00699'     
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_rtbe_d[l_ac].rtbe002  = g_rtbe_d_t.rtbe002 
#                     NEXT FIELD CURRENT
#                  END IF 
                  #mark by geza 20150906(E)
                  #检查商品是否属于转出小类
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM imaa_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_rtbe_d[l_ac].rtbe002
                     AND imaa009 = g_rtbd_m.rtbd001
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'art-00700'     
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rtbe_d[l_ac].rtbe002  = g_rtbe_d_t.rtbe002 
                     NEXT FIELD CURRENT
                  END IF 
                  #检查商品编号是否重复
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM rtbe_t
                   WHERE rtbeent = g_enterprise
                     AND rtbe002 = g_rtbe_d[l_ac].rtbe002
                     AND rtbedocno = g_rtbd_m.rtbddocno
                     AND rtbeseq != g_rtbe_d[l_ac].rtbeseq
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = 'art-00705'     
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rtbe_d[l_ac].rtbe002  = g_rtbe_d_t.rtbe002 
                     NEXT FIELD CURRENT
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               #带值
               CALL artt302_rtbe002_init()

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbe_d[l_ac].rtbe002
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbe_d[l_ac].rtbe002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbe_d[l_ac].rtbe002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe002
            #add-point:BEFORE FIELD rtbe002 name="input.b.page1.rtbe002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbe002
            #add-point:ON CHANGE rtbe002 name="input.g.page1.rtbe002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe003
            
            #add-point:AFTER FIELD rtbe003 name="input.a.page1.rtbe003"
            IF NOT cl_null(g_rtbe_d[l_ac].rtbe003) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbe_d[l_ac].rtbe003

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001_99") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe003
            #add-point:BEFORE FIELD rtbe003 name="input.b.page1.rtbe003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbe003
            #add-point:ON CHANGE rtbe003 name="input.g.page1.rtbe003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe004
            
            #add-point:AFTER FIELD rtbe004 name="input.a.page1.rtbe004"
            IF NOT cl_null(g_rtbe_d[l_ac].rtbe004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbe_d[l_ac].rtbe004

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_12") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbe_d[l_ac].rtbe004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbe_d[l_ac].rtbe004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbe_d[l_ac].rtbe004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe004
            #add-point:BEFORE FIELD rtbe004 name="input.b.page1.rtbe004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbe004
            #add-point:ON CHANGE rtbe004 name="input.g.page1.rtbe004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe005
            #add-point:BEFORE FIELD rtbe005 name="input.b.page1.rtbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe005
            
            #add-point:AFTER FIELD rtbe005 name="input.a.page1.rtbe005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbe005
            #add-point:ON CHANGE rtbe005 name="input.g.page1.rtbe005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbe006
            #add-point:BEFORE FIELD rtbe006 name="input.b.page1.rtbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbe006
            
            #add-point:AFTER FIELD rtbe006 name="input.a.page1.rtbe006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbe006
            #add-point:ON CHANGE rtbe006 name="input.g.page1.rtbe006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtbesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbesite
            #add-point:ON ACTION controlp INFIELD rtbesite name="input.c.page1.rtbesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbeseq
            #add-point:ON ACTION controlp INFIELD rtbeseq name="input.c.page1.rtbeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe001
            #add-point:ON ACTION controlp INFIELD rtbe001 name="input.c.page1.rtbe001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbe_d[l_ac].rtbe001             #給予default值

            #給予arg
#            LET g_qryparam.where = " EXISTS (SELECT 1 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa001 = imay001 AND imaa009 = '",g_rtbd_m.rtbd001,"') 
#                                     AND EXISTS (SELECT 1 FROM stas_t WHERE stasent = ",g_enterprise," AND imay001 = stas003 AND stassite = '",g_rtbd_m.rtbdsite,"')"#s 
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM imaa_t WHERE imaaent = ",g_enterprise," AND imaa001 = imay001 AND imaa009 = '",g_rtbd_m.rtbd001,"' AND imaastus = 'Y')"#s                          
            CALL q_imay003_3()                                #呼叫開窗

            LET g_rtbe_d[l_ac].rtbe001 = g_qryparam.return1              

            DISPLAY g_rtbe_d[l_ac].rtbe001 TO rtbe001              #

            NEXT FIELD rtbe001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe002
            #add-point:ON ACTION controlp INFIELD rtbe002 name="input.c.page1.rtbe002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbe_d[l_ac].rtbe002             #給予default值

            #給予arg
            #LET g_qryparam.where = " imaa009 = '",g_rtbd_m.rtbd001,"' AND EXISTS (SELECT 1 FROM stas_t WHERE stasent = ",g_enterprise," AND imaa001 = stas003 AND stassite = '",g_rtbd_m.rtbdsite,"')" #s 
            LET g_qryparam.where = " imaa009 = '",g_rtbd_m.rtbd001,"'" #s 
            CALL q_imaa001_10()                                #呼叫開窗

            LET g_rtbe_d[l_ac].rtbe002 = g_qryparam.return1              

            DISPLAY g_rtbe_d[l_ac].rtbe002 TO rtbe002              #

            NEXT FIELD rtbe002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe003
            #add-point:ON ACTION controlp INFIELD rtbe003 name="input.c.page1.rtbe003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbe_d[l_ac].rtbe003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001()                                #呼叫開窗

            LET g_rtbe_d[l_ac].rtbe003 = g_qryparam.return1              

            DISPLAY g_rtbe_d[l_ac].rtbe003 TO rtbe003              #

            NEXT FIELD rtbe003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe004
            #add-point:ON ACTION controlp INFIELD rtbe004 name="input.c.page1.rtbe004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbe_d[l_ac].rtbe004             #給予default值
            LET g_qryparam.default2 = "" #g_rtbe_d[l_ac].pmaal004 #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pmaa001_16()                                #呼叫開窗

            LET g_rtbe_d[l_ac].rtbe004 = g_qryparam.return1              
            #LET g_rtbe_d[l_ac].pmaal004 = g_qryparam.return2 
            DISPLAY g_rtbe_d[l_ac].rtbe004 TO rtbe004              #
            #DISPLAY g_rtbe_d[l_ac].pmaal004 TO pmaal004 #交易對象簡稱
            NEXT FIELD rtbe004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe005
            #add-point:ON ACTION controlp INFIELD rtbe005 name="input.c.page1.rtbe005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbe006
            #add-point:ON ACTION controlp INFIELD rtbe006 name="input.c.page1.rtbe006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtbe_d[l_ac].* = g_rtbe_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt302_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtbe_d[l_ac].rtbeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtbe_d[l_ac].* = g_rtbe_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt302_rtbe_t_mask_restore('restore_mask_o')
      
               UPDATE rtbe_t SET (rtbedocno,rtbesite,rtbeseq,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005, 
                   rtbe006) = (g_rtbd_m.rtbddocno,g_rtbe_d[l_ac].rtbesite,g_rtbe_d[l_ac].rtbeseq,g_rtbe_d[l_ac].rtbe001, 
                   g_rtbe_d[l_ac].rtbe002,g_rtbe_d[l_ac].rtbe003,g_rtbe_d[l_ac].rtbe004,g_rtbe_d[l_ac].rtbe005, 
                   g_rtbe_d[l_ac].rtbe006)
                WHERE rtbeent = g_enterprise AND rtbedocno = g_rtbd_m.rtbddocno 
 
                  AND rtbeseq = g_rtbe_d_t.rtbeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtbe_d[l_ac].* = g_rtbe_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtbe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtbe_d[l_ac].* = g_rtbe_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtbd_m.rtbddocno
               LET gs_keys_bak[1] = g_rtbddocno_t
               LET gs_keys[2] = g_rtbe_d[g_detail_idx].rtbeseq
               LET gs_keys_bak[2] = g_rtbe_d_t.rtbeseq
               CALL artt302_update_b('rtbe_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt302_rtbe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtbe_d[g_detail_idx].rtbeseq = g_rtbe_d_t.rtbeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtbd_m.rtbddocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtbe_d_t.rtbeseq
 
                  CALL artt302_key_update_b(gs_keys,'rtbe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtbd_m),util.JSON.stringify(g_rtbe_d_t)
               LET g_log2 = util.JSON.stringify(g_rtbd_m),util.JSON.stringify(g_rtbe_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #先删除再新增库存明细
               #删除库存明细单身对的资料
               DELETE FROM rtbf_t
                WHERE rtbfent = g_enterprise AND
                  rtbfdocno = g_rtbd_m.rtbddocno AND rtbfseq = g_rtbe_d_t.rtbeseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET g_rtbe_d[l_ac].* = g_rtbe_d_t.*
               END IF   
               #end add-point
               CALL artt302_rtbf_init(g_rtbe_d[l_ac].rtbeseq,g_rtbe_d[l_ac].rtbe001,g_rtbe_d[l_ac].rtbe002,g_rtbe_d[l_ac].rtbe003,g_rtbe_d[l_ac].rtbe004)  RETURNING l_success  
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  LET g_rtbe_d[l_ac].* = g_rtbe_d_t.*               
               END IF 
               CALL artt302_b_fill()               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            CALL artt302_b_fill()         
            #end add-point
            CALL artt302_unlock_b("rtbe_t","'1'")
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
               LET g_rtbe_d[li_reproduce_target].* = g_rtbe_d[li_reproduce].*
 
               LET g_rtbe_d[li_reproduce_target].rtbeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtbe_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtbe_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_rtbe2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt302_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL artt302_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="artt302.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD rtbddocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtbesite
               WHEN "s_detail2"
                  NEXT FIELD rtbfsite
 
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
 
{<section id="artt302.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt302_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt302_b_fill() #單身填充
      CALL artt302_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt302_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_rtbd_m_mask_o.* =  g_rtbd_m.*
   CALL artt302_rtbd_t_mask()
   LET g_rtbd_m_mask_n.* =  g_rtbd_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001, 
       g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002,g_rtbd_m.rtbd002_desc,g_rtbd_m.rtbd003,g_rtbd_m.rtbd003_desc, 
       g_rtbd_m.rtbd004,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid, 
       g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp,g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmodid_desc, 
       g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdcnfdt,g_rtbd_m.rtbdpstid, 
       g_rtbd_m.rtbdpstid_desc,g_rtbd_m.rtbdpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtbd_m.rtbdstus 
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
   FOR l_ac = 1 TO g_rtbe_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rtbe2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt302_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt302_detail_show()
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
 
{<section id="artt302.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt302_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtbd_t.rtbddocno 
   DEFINE l_oldno     LIKE rtbd_t.rtbddocno 
 
   DEFINE l_master    RECORD LIKE rtbd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtbe_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtbf_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
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
   
   IF g_rtbd_m.rtbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
    
   LET g_rtbd_m.rtbddocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtbd_m.rtbdownid = g_user
      LET g_rtbd_m.rtbdowndp = g_dept
      LET g_rtbd_m.rtbdcrtid = g_user
      LET g_rtbd_m.rtbdcrtdp = g_dept 
      LET g_rtbd_m.rtbdcrtdt = cl_get_current()
      LET g_rtbd_m.rtbdmodid = g_user
      LET g_rtbd_m.rtbdmoddt = cl_get_current()
      LET g_rtbd_m.rtbdstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #营运据点
   CALL s_aooi500_default(g_prog,'rtbdsite',g_rtbd_m.rtbdsite) RETURNING l_insert,g_rtbd_m.rtbdsite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_rtbd_m.rtbdsite) RETURNING g_rtbd_m.rtbdsite_desc
   DISPLAY BY NAME g_rtbd_m.rtbdsite_desc
   LET g_site_flag = FALSE
   #单据日期
   LET g_rtbd_m.rtbddocdt = g_today
   
   #单据别
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_rtbd_m.rtbdsite,g_prog,'1')
        RETURNING l_success, l_doctype
   LET g_rtbd_m.rtbddocno = l_doctype
   
   LET g_rtbd_m.rtbd003   = g_user
   CALL artt302_rtbd003_ref()
   LET g_rtbd_m.rtbd004   = g_dept
   CALL artt302_rtbd004_ref()
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtbd_m.rtbdstus 
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
   
   
   CALL artt302_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtbd_m.* TO NULL
      INITIALIZE g_rtbe_d TO NULL
      INITIALIZE g_rtbe2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt302_show()
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
   CALL artt302_set_act_visible()   
   CALL artt302_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtbdent = " ||g_enterprise|| " AND",
                      " rtbddocno = '", g_rtbd_m.rtbddocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt302_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt302_idx_chk()
   
   LET g_data_owner = g_rtbd_m.rtbdownid      
   LET g_data_dept  = g_rtbd_m.rtbdowndp
   
   #功能已完成,通報訊息中心
   CALL artt302_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt302_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtbe_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtbf_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt302_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtbe_t
    WHERE rtbeent = g_enterprise AND rtbedocno = g_rtbddocno_t
 
    INTO TEMP artt302_detail
 
   #將key修正為調整後   
   UPDATE artt302_detail 
      #更新key欄位
      SET rtbedocno = g_rtbd_m.rtbddocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtbe_t SELECT * FROM artt302_detail
   
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
   DROP TABLE artt302_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtbf_t 
    WHERE rtbfent = g_enterprise AND rtbfdocno = g_rtbddocno_t
 
    INTO TEMP artt302_detail
 
   #將key修正為調整後   
   UPDATE artt302_detail SET rtbfdocno = g_rtbd_m.rtbddocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtbf_t SELECT * FROM artt302_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt302_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt302_delete()
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
   
   IF g_rtbd_m.rtbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artt302_cl USING g_enterprise,g_rtbd_m.rtbddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt302_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt302_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
       g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
       g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
       g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
       g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
       g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdpstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT artt302_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtbd_m_mask_o.* =  g_rtbd_m.*
   CALL artt302_rtbd_t_mask()
   LET g_rtbd_m_mask_n.* =  g_rtbd_m.*
   
   CALL artt302_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt302_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtbddocno_t = g_rtbd_m.rtbddocno
 
 
      DELETE FROM rtbd_t
       WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbd_m.rtbddocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtbd_m.rtbddocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rtbe_t
       WHERE rtbeent = g_enterprise AND rtbedocno = g_rtbd_m.rtbddocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      #删除库存明细单身
      DELETE FROM rtbf_t
       WHERE rtbfent = g_enterprise AND rtbfdocno = g_rtbd_m.rtbddocno

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM rtbf_t
       WHERE rtbfent = g_enterprise AND
             rtbfdocno = g_rtbd_m.rtbddocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtbd_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt302_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtbe_d.clear() 
      CALL g_rtbe2_d.clear()       
 
     
      CALL artt302_ui_browser_refresh()  
      #CALL artt302_ui_headershow()  
      #CALL artt302_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt302_browser_fill("")
         CALL artt302_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt302_cl
 
   #功能已完成,通報訊息中心
   CALL artt302_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt302.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt302_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtbe_d.clear()
   CALL g_rtbe2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artt302_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtbesite,rtbeseq,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005,rtbe006 , 
             t1.imaal003 ,t2.pmaal004 FROM rtbe_t",   
                     " INNER JOIN rtbd_t ON rtbdent = " ||g_enterprise|| " AND rtbddocno = rtbedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=rtbe002 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=rtbe004 AND t2.pmaal002='"||g_dlang||"' ",
 
                     " WHERE rtbeent=? AND rtbedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtbe_t.rtbeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt302_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt302_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtbd_m.rtbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtbd_m.rtbddocno INTO g_rtbe_d[l_ac].rtbesite,g_rtbe_d[l_ac].rtbeseq, 
          g_rtbe_d[l_ac].rtbe001,g_rtbe_d[l_ac].rtbe002,g_rtbe_d[l_ac].rtbe003,g_rtbe_d[l_ac].rtbe004, 
          g_rtbe_d[l_ac].rtbe005,g_rtbe_d[l_ac].rtbe006,g_rtbe_d[l_ac].rtbe002_desc,g_rtbe_d[l_ac].rtbe004_desc  
            #(ver:78)
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
   IF artt302_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtbfsite,rtbfseq,rtbfseq1,rtbf001,rtbf002,rtbf003,rtbf004,rtbf005, 
             rtbf006,rtbf007,rtbf008,rtbf009 ,t3.imaal003 ,t4.inaa002 ,t5.pmaal004 FROM rtbf_t",   
                     " INNER JOIN  rtbd_t ON rtbdent = " ||g_enterprise|| " AND rtbddocno = rtbfdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=rtbf002 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaa_t t4 ON t4.inaaent="||g_enterprise||" AND t4.inaasite=rtbfsite AND t4.inaa001=rtbf004  ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=rtbf006 AND t5.pmaal002='"||g_dlang||"' ",
 
                     " WHERE rtbfent=? AND rtbfdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtbf_t.rtbfseq,rtbf_t.rtbfseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt302_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR artt302_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rtbd_m.rtbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rtbd_m.rtbddocno INTO g_rtbe2_d[l_ac].rtbfsite,g_rtbe2_d[l_ac].rtbfseq, 
          g_rtbe2_d[l_ac].rtbfseq1,g_rtbe2_d[l_ac].rtbf001,g_rtbe2_d[l_ac].rtbf002,g_rtbe2_d[l_ac].rtbf003, 
          g_rtbe2_d[l_ac].rtbf004,g_rtbe2_d[l_ac].rtbf005,g_rtbe2_d[l_ac].rtbf006,g_rtbe2_d[l_ac].rtbf007, 
          g_rtbe2_d[l_ac].rtbf008,g_rtbe2_d[l_ac].rtbf009,g_rtbe2_d[l_ac].rtbf002_desc,g_rtbe2_d[l_ac].rtbf004_desc, 
          g_rtbe2_d[l_ac].rtbf006_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL artt302_rtbf004_ref()
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
   
   CALL g_rtbe_d.deleteElement(g_rtbe_d.getLength())
   CALL g_rtbe2_d.deleteElement(g_rtbe2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt302_pb
   FREE artt302_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtbe_d.getLength()
      LET g_rtbe_d_mask_o[l_ac].* =  g_rtbe_d[l_ac].*
      CALL artt302_rtbe_t_mask()
      LET g_rtbe_d_mask_n[l_ac].* =  g_rtbe_d[l_ac].*
   END FOR
   
   LET g_rtbe2_d_mask_o.* =  g_rtbe2_d.*
   FOR l_ac = 1 TO g_rtbe2_d.getLength()
      LET g_rtbe2_d_mask_o[l_ac].* =  g_rtbe2_d[l_ac].*
      CALL artt302_rtbf_t_mask()
      LET g_rtbe2_d_mask_n[l_ac].* =  g_rtbe2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt302_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rtbe_t
       WHERE rtbeent = g_enterprise AND
         rtbedocno = ps_keys_bak[1] AND rtbeseq = ps_keys_bak[2]
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
         CALL g_rtbe_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM rtbf_t
       WHERE rtbfent = g_enterprise AND
             rtbfdocno = ps_keys_bak[1] AND rtbfseq = ps_keys_bak[2] AND rtbfseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtbe2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt302_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rtbe_t
                  (rtbeent,
                   rtbedocno,
                   rtbeseq
                   ,rtbesite,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005,rtbe006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtbe_d[g_detail_idx].rtbesite,g_rtbe_d[g_detail_idx].rtbe001,g_rtbe_d[g_detail_idx].rtbe002, 
                       g_rtbe_d[g_detail_idx].rtbe003,g_rtbe_d[g_detail_idx].rtbe004,g_rtbe_d[g_detail_idx].rtbe005, 
                       g_rtbe_d[g_detail_idx].rtbe006)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtbe_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO rtbf_t
                  (rtbfent,
                   rtbfdocno,
                   rtbfseq,rtbfseq1
                   ,rtbfsite,rtbf001,rtbf002,rtbf003,rtbf004,rtbf005,rtbf006,rtbf007,rtbf008,rtbf009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rtbe2_d[g_detail_idx].rtbfsite,g_rtbe2_d[g_detail_idx].rtbf001,g_rtbe2_d[g_detail_idx].rtbf002, 
                       g_rtbe2_d[g_detail_idx].rtbf003,g_rtbe2_d[g_detail_idx].rtbf004,g_rtbe2_d[g_detail_idx].rtbf005, 
                       g_rtbe2_d[g_detail_idx].rtbf006,g_rtbe2_d[g_detail_idx].rtbf007,g_rtbe2_d[g_detail_idx].rtbf008, 
                       g_rtbe2_d[g_detail_idx].rtbf009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtbe2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt302_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtbe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt302_rtbe_t_mask_restore('restore_mask_o')
               
      UPDATE rtbe_t 
         SET (rtbedocno,
              rtbeseq
              ,rtbesite,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005,rtbe006) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtbe_d[g_detail_idx].rtbesite,g_rtbe_d[g_detail_idx].rtbe001,g_rtbe_d[g_detail_idx].rtbe002, 
                  g_rtbe_d[g_detail_idx].rtbe003,g_rtbe_d[g_detail_idx].rtbe004,g_rtbe_d[g_detail_idx].rtbe005, 
                  g_rtbe_d[g_detail_idx].rtbe006) 
         WHERE rtbeent = g_enterprise AND rtbedocno = ps_keys_bak[1] AND rtbeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtbe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtbe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt302_rtbe_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtbf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt302_rtbf_t_mask_restore('restore_mask_o')
               
      UPDATE rtbf_t 
         SET (rtbfdocno,
              rtbfseq,rtbfseq1
              ,rtbfsite,rtbf001,rtbf002,rtbf003,rtbf004,rtbf005,rtbf006,rtbf007,rtbf008,rtbf009) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rtbe2_d[g_detail_idx].rtbfsite,g_rtbe2_d[g_detail_idx].rtbf001,g_rtbe2_d[g_detail_idx].rtbf002, 
                  g_rtbe2_d[g_detail_idx].rtbf003,g_rtbe2_d[g_detail_idx].rtbf004,g_rtbe2_d[g_detail_idx].rtbf005, 
                  g_rtbe2_d[g_detail_idx].rtbf006,g_rtbe2_d[g_detail_idx].rtbf007,g_rtbe2_d[g_detail_idx].rtbf008, 
                  g_rtbe2_d[g_detail_idx].rtbf009) 
         WHERE rtbfent = g_enterprise AND rtbfdocno = ps_keys_bak[1] AND rtbfseq = ps_keys_bak[2] AND rtbfseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtbf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtbf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt302_rtbf_t_mask_restore('restore_mask_n')
 
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
 
{<section id="artt302.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt302_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="artt302.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt302_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="artt302.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt302_lock_b(ps_table,ps_page)
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
   #CALL artt302_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtbe_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt302_bcl USING g_enterprise,
                                       g_rtbd_m.rtbddocno,g_rtbe_d[g_detail_idx].rtbeseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt302_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rtbf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt302_bcl2 USING g_enterprise,
                                             g_rtbd_m.rtbddocno,g_rtbe2_d[g_detail_idx].rtbfseq,g_rtbe2_d[g_detail_idx].rtbfseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt302_bcl2:",SQLERRMESSAGE 
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
 
{<section id="artt302.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt302_unlock_b(ps_table,ps_page)
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
      CLOSE artt302_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt302_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt302_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtbddocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtbddocno",TRUE)
      CALL cl_set_comp_entry("rtbddocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rtbdsite",TRUE)
   CALL cl_set_comp_entry("rtbd001",TRUE)
   CALL cl_set_comp_entry("rtbd002",TRUE)
   CALL cl_set_comp_entry("rtbddocdt",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt302_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtbddocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtbddocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtbddocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'rtbdsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtbdsite",FALSE)
   END IF
   IF p_cmd = 'u' THEN  
      CALL cl_set_comp_entry("rtbd001",FALSE)
      CALL cl_set_comp_entry("rtbd002",FALSE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt302_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt302_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt302_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt302_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtbd_m.rtbdstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt302_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt302.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt302_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt302.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt302_default_search()
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
      LET ls_wc = ls_wc, " rtbddocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rtbd_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtbe_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtbf_t" 
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
 
{<section id="artt302.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt302_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_errno        LIKE type_t.chr100
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_rtbd_m.rtbdstus='X' THEN
      RETURN
   END IF   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtbd_m.rtbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt302_cl USING g_enterprise,g_rtbd_m.rtbddocno
   IF STATUS THEN
      CLOSE artt302_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt302_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
       g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
       g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
       g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
       g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
       g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdpstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT artt302_action_chk() THEN
      CLOSE artt302_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001, 
       g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002,g_rtbd_m.rtbd002_desc,g_rtbd_m.rtbd003,g_rtbd_m.rtbd003_desc, 
       g_rtbd_m.rtbd004,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid, 
       g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtid_desc, 
       g_rtbd_m.rtbdcrtdp,g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmodid_desc, 
       g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdcnfdt,g_rtbd_m.rtbdpstid, 
       g_rtbd_m.rtbdpstid_desc,g_rtbd_m.rtbdpstdt
 
   CASE g_rtbd_m.rtbdstus
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
         CASE g_rtbd_m.rtbdstus
            
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_rtbd_m.rtbdstus
         WHEN "N"
            #HIDE OPTION "open"
            CALL cl_set_act_visible("unconfirmed",FALSE)
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
            #HIDE OPTION "invalid"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            #HIDE OPTION "confirmed"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
            
      END CASE
      LET l_success = TRUE
      LET g_rtbd_m.rtbdcnfdt=cl_get_current()
      LET g_rtbd_m.rtbdmoddt=cl_get_current()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt302_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt302_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt302_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt302_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
         CALL s_artt302_conf_chk(g_rtbd_m.rtbddocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_artt302_conf_upd(g_rtbd_m.rtbddocno,lc_state) RETURNING l_success,l_errno 
               UPDATE rtbd_t SET rtbdcnfid ='',rtbdcnfdt=''
                    WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbd_m.rtbddocno                 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_rtbd_m.rtbddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                 
                  RETURN
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_rtbd_m.rtbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN            
         END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
         CALL s_artt302_conf_chk(g_rtbd_m.rtbddocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_artt302_conf_upd(g_rtbd_m.rtbddocno,lc_state) RETURNING l_success,l_errno 
               UPDATE rtbd_t SET rtbdcnfid =g_user,rtbdcnfdt=g_rtbd_m.rtbdcnfdt
                    WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbd_m.rtbddocno                 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_rtbd_m.rtbddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                 
                  RETURN
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_rtbd_m.rtbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN            
         END IF 
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
         CALL s_artt302_conf_chk(g_rtbd_m.rtbddocno,lc_state) RETURNING l_success,l_errno

         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_artt302_conf_upd(g_rtbd_m.rtbddocno,lc_state) RETURNING l_success,l_errno 
               UPDATE rtbd_t SET rtbdmodid =g_user,rtbdmoddt=g_rtbd_m.rtbdmoddt
                    WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbd_m.rtbddocno                 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_rtbd_m.rtbddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                 
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_rtbd_m.rtbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN            
         END IF  
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
      g_rtbd_m.rtbdstus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt302_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_rtbd_m.rtbdmodid = g_user
   LET g_rtbd_m.rtbdmoddt = cl_get_current()
   LET g_rtbd_m.rtbdstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtbd_t 
      SET (rtbdstus,rtbdmodid,rtbdmoddt) 
        = (g_rtbd_m.rtbdstus,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt)     
    WHERE rtbdent = g_enterprise AND rtbddocno = g_rtbd_m.rtbddocno
 
    
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
      EXECUTE artt302_master_referesh USING g_rtbd_m.rtbddocno INTO g_rtbd_m.rtbdsite,g_rtbd_m.rtbddocdt, 
          g_rtbd_m.rtbddocno,g_rtbd_m.rtbd001,g_rtbd_m.rtbd002,g_rtbd_m.rtbd003,g_rtbd_m.rtbd004,g_rtbd_m.rtbd005, 
          g_rtbd_m.rtbdstus,g_rtbd_m.rtbdownid,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdcrtid,g_rtbd_m.rtbdcrtdp, 
          g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfdt, 
          g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstdt,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002_desc, 
          g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp_desc, 
          g_rtbd_m.rtbdcrtid_desc,g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdcnfid_desc, 
          g_rtbd_m.rtbdpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtbd_m.rtbdsite,g_rtbd_m.rtbdsite_desc,g_rtbd_m.rtbddocdt,g_rtbd_m.rtbddocno, 
          g_rtbd_m.rtbd001,g_rtbd_m.rtbd001_desc,g_rtbd_m.rtbd002,g_rtbd_m.rtbd002_desc,g_rtbd_m.rtbd003, 
          g_rtbd_m.rtbd003_desc,g_rtbd_m.rtbd004,g_rtbd_m.rtbd004_desc,g_rtbd_m.rtbd005,g_rtbd_m.rtbdstus, 
          g_rtbd_m.rtbdownid,g_rtbd_m.rtbdownid_desc,g_rtbd_m.rtbdowndp,g_rtbd_m.rtbdowndp_desc,g_rtbd_m.rtbdcrtid, 
          g_rtbd_m.rtbdcrtid_desc,g_rtbd_m.rtbdcrtdp,g_rtbd_m.rtbdcrtdp_desc,g_rtbd_m.rtbdcrtdt,g_rtbd_m.rtbdmodid, 
          g_rtbd_m.rtbdmodid_desc,g_rtbd_m.rtbdmoddt,g_rtbd_m.rtbdcnfid,g_rtbd_m.rtbdcnfid_desc,g_rtbd_m.rtbdcnfdt, 
          g_rtbd_m.rtbdpstid,g_rtbd_m.rtbdpstid_desc,g_rtbd_m.rtbdpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE artt302_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt302_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt302.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt302_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtbe_d.getLength() THEN
         LET g_detail_idx = g_rtbe_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtbe_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtbe_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rtbe2_d.getLength() THEN
         LET g_detail_idx = g_rtbe2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtbe2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtbe2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt302_b_fill2(pi_idx)
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
   
   CALL artt302_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt302_fill_chk(ps_idx)
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
 
{<section id="artt302.status_show" >}
PRIVATE FUNCTION artt302_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt302.mask_functions" >}
&include "erp/art/artt302_mask.4gl"
 
{</section>}
 
{<section id="artt302.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt302_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL artt302_show()
   CALL artt302_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtbd_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtbe_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_rtbe2_d))
 
 
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
   #CALL artt302_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt302_ui_headershow()
   CALL artt302_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt302_draw_out()
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
   CALL artt302_ui_headershow()  
   CALL artt302_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt302.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt302_set_pk_array()
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
   LET g_pk_array[1].values = g_rtbd_m.rtbddocno
   LET g_pk_array[1].column = 'rtbddocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt302.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt302.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt302_msgcentre_notify(lc_state)
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
   CALL artt302_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtbd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt302.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt302_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#34 add-S
   SELECT rtbdstus  INTO g_rtbd_m.rtbdstus
     FROM rtbd_t
    WHERE rtbdent = g_enterprise
      AND rtbddocno = g_rtbd_m.rtbddocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rtbd_m.rtbdstus
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
        LET g_errparam.extend = g_rtbd_m.rtbddocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL artt302_set_act_visible()
        CALL artt302_set_act_no_visible()
        CALL artt302_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#34 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt302.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artt302_rtbd003_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION artt302_rtbd003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbd_m.rtbd003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtbd_m.rtbd003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbd_m.rtbd003_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artt302_rtbd004_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION artt302_rtbd004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbd_m.rtbd004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbd_m.rtbd004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbd_m.rtbd004_desc
END FUNCTION

################################################################################
# Descriptions...: 商品主条码带值
# Memo...........:
# Usage..........: CALL artt302_rtbe001_init()
# Date & Author..: 20150819 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt302_rtbe001_init()
DEFINE  l_stas001 LIKE stas_t.stas001  
   SELECT imaa001     
     INTO g_rtbe_d[l_ac].rtbe002
     FROM imaa_t,imay_t
    WHERE imaaent = g_enterprise
      AND imaaent = imayent
      AND imaa001 = imay001
      AND imay003 = g_rtbe_d[l_ac].rtbe001 
      AND imaastus = 'Y'
      AND imaystus = 'Y'
#   SELECT star003 INTO g_rtbe_d[l_ac].rtbe004
#     FROM star_t 
#    WHERE starent = g_enterprise
#      AND starsite = g_rtbe_d[l_ac].rtbesite
#      AND star001 = l_stas001     
   
   SELECT imaa105 INTO  g_rtbe_d[l_ac].rtbe003
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_rtbe_d[l_ac].rtbe002
      AND imaastus = 'Y'   

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbe_d[l_ac].rtbe002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbe_d[l_ac].rtbe002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbe_d[l_ac].rtbe002_desc     
END FUNCTION

################################################################################
# Descriptions...: 商品编号带值
# Memo...........:
# Usage..........: CALL artt302_rtbe002_init()
# Date & Author..: 20150819 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt302_rtbe002_init()
DEFINE  l_stas001 LIKE stas_t.stas001  
    SELECT imay003
     INTO g_rtbe_d[l_ac].rtbe001
     FROM imay_t 
    WHERE imayent = g_enterprise
      AND imay001 = g_rtbe_d[l_ac].rtbe002 
      AND imay006 = 'Y'
      AND imaystus= 'Y'
#   SELECT star003 INTO g_rtbe_d[l_ac].rtbe004
#     FROM star_t 
#    WHERE starent = g_enterprise
#      AND starsite = g_rtbe_d[l_ac].rtbesite
#      AND star001 = l_stas001
   
   SELECT imaa105 INTO  g_rtbe_d[l_ac].rtbe003
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_rtbe_d[l_ac].rtbe002  
      AND imaastus = 'Y' 

END FUNCTION

################################################################################
# Descriptions...: 库存明细单身插入
# Memo...........:
# Usage..........: CALL artt302_rtbf_init(l_rtbeseq,l_rtbe001,l_rtbe002,l_rtbe003,l_rtbe004)
# Date & Author..: 20150819 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt302_rtbf_init(l_rtbeseq,l_rtbe001,l_rtbe002,l_rtbe003,l_rtbe004)
DEFINE l_sql       STRING
DEFINE l_rtbeseq   LIKE rtbe_t.rtbeseq
DEFINE l_rtbe001   LIKE rtbe_t.rtbe001
DEFINE l_rtbe002   LIKE rtbe_t.rtbe002
DEFINE l_rtbe003   LIKE rtbe_t.rtbe003
DEFINE l_rtbe004   LIKE rtbe_t.rtbe004
#161111-00028#3---modify----begin----------
#DEFINE l_inag      RECORD LIKE inag_t.*
#DEFINE l_rtbf      RECORD LIKE rtbf_t.*
DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企業編號
       inagsite LIKE inag_t.inagsite, #營運據點
       inag001 LIKE inag_t.inag001, #料件編號
       inag002 LIKE inag_t.inag002, #產品特徵
       inag003 LIKE inag_t.inag003, #庫存管理特徵
       inag004 LIKE inag_t.inag004, #庫位編號
       inag005 LIKE inag_t.inag005, #儲位編號
       inag006 LIKE inag_t.inag006, #批號
       inag007 LIKE inag_t.inag007, #庫存單位
       inag008 LIKE inag_t.inag008, #帳面庫存數量
       inag009 LIKE inag_t.inag009, #實際庫存數量
       inag010 LIKE inag_t.inag010, #庫存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本庫否
       inag013 LIKE inag_t.inag013, #揀貨優先序
       inag014 LIKE inag_t.inag014, #最近一次盤點日期
       inag015 LIKE inag_t.inag015, #最後異動日期
       inag016 LIKE inag_t.inag016, #呆滯日期
       inag017 LIKE inag_t.inag017, #第一次入庫日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #備置數量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二進位碼
       inag024 LIKE inag_t.inag024, #參考單位
       inag025 LIKE inag_t.inag025, #參考數量
       inag026 LIKE inag_t.inag026, #最近一次檢驗日期
       inag027 LIKE inag_t.inag027, #下次檢驗日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人員
       inag030 LIKE inag_t.inag030, #留置部門
       inag031 LIKE inag_t.inag031, #留置單號
       inag032 LIKE inag_t.inag032, #基礎單位
       inag033 LIKE inag_t.inag033 #基礎單位數量
       END RECORD
DEFINE l_rtbf RECORD  #商品轉類單庫存明細表
       rtbfent LIKE rtbf_t.rtbfent, #企業編號
       rtbfsite LIKE rtbf_t.rtbfsite, #營運據點
       rtbfdocno LIKE rtbf_t.rtbfdocno, #單據編號
       rtbfseq LIKE rtbf_t.rtbfseq, #項次
       rtbfseq1 LIKE rtbf_t.rtbfseq1, #序號
       rtbf001 LIKE rtbf_t.rtbf001, #商品主條碼
       rtbf002 LIKE rtbf_t.rtbf002, #商品編號
       rtbf003 LIKE rtbf_t.rtbf003, #銷售單位
       rtbf004 LIKE rtbf_t.rtbf004, #庫區編號
       rtbf005 LIKE rtbf_t.rtbf005, #批次編號
       rtbf006 LIKE rtbf_t.rtbf006, #供應商編號
       rtbf007 LIKE rtbf_t.rtbf007, #進價
       rtbf008 LIKE rtbf_t.rtbf008, #數量
       rtbf009 LIKE rtbf_t.rtbf009 #轉類發生金額
       END RECORD
#161111-00028#3---modify----end------------
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5       #成功标识 #add by geza 20151109
   LET r_success=TRUE
 # LET l_sql = " SELECT * FROM inag_t ",  #161111-00028#3--mark
   #161111-00028#3--add---begin-----------
   LET l_sql = " SELECT inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,",
               " inag007,inag008,inag009,inag010,inag011,inag012,inag013,inag014,inag015,",
               " inag016,inag017,inag018,inag019,inag020,inag021,inag022,inag023,inag024,",
               " inag025,inag026,inag027,inag028,inag029,inag030,inag031,inag032,inag033 FROM inag_t ",  
   #161111-00028#3--add---end-------------
               "  WHERE inagent = ?",
               #"    AND inagsite = ?",   #mark by geza 20150906
               "    AND inag001 = ?"
   PREPARE artt302_rtbf FROM l_sql
   DECLARE artt302_rtbf_ins CURSOR FOR artt302_rtbf
   #OPEN artt302_rtbf_ins USING g_enterprise,g_rtbd_m.rtbdsite,l_rtbe002 #mark by geza 20150906
   OPEN artt302_rtbf_ins USING g_enterprise,l_rtbe002 #add by geza 20150906
   INITIALIZE l_inag.* TO NULL
   
   FOREACH artt302_rtbf_ins INTO l_inag.*
      INITIALIZE l_rtbf.* TO NULL
      LET l_rtbf.rtbfent = g_enterprise                    #企業編號    
      LET l_rtbf.rtbfsite = l_inag.inagsite                #所屬組織
      LET l_rtbf.rtbfdocno = g_rtbd_m.rtbddocno            #单据编号 
      LET l_rtbf.rtbfseq = l_rtbeseq                       #项次  
      SELECT MAX(rtbfseq1)+1 INTO l_rtbf.rtbfseq1          #序号 
        FROM rtbf_t
       WHERE rtbfent=g_enterprise
         AND rtbfdocno=g_rtbd_m.rtbddocno
         AND rtbfseq= l_rtbeseq
      IF cl_null(l_rtbf.rtbfseq1) THEN
         LET l_rtbf.rtbfseq1=1
      END IF                                                        
      LET l_rtbf.rtbf001 = l_rtbe001                        #商品主条码  
      LET l_rtbf.rtbf002 = l_inag.inag001                   #商品编号    
      LET l_rtbf.rtbf003 = l_rtbe003                        #销售单位    
      LET l_rtbf.rtbf004 = l_inag.inag004                   #库区编号
      LET l_rtbf.rtbf005 = l_inag.inag006                   #批次编号
      #LET l_rtbf.rtbf006 = l_rtbe004                       #供应商编号 #mark by geza 20150906
      #从inad_t抓取供应商编号
      SELECT inad010 INTO l_rtbf.rtbf006
        FROM inad_t
       WHERE inadent = g_enterprise
         AND inad001 = l_inag.inag001
         AND inadsite = l_inag.inagsite
         AND inad003 = l_inag.inag006
         AND rownum = 1
      #mark by geza 20151109(S)   
#      SELECT xccu202 INTO l_rtbf.rtbf007 
#        FROM xccu_t
#       WHERE xccuent=g_enterprise
#         AND xccu004=l_inag.inag001   
#         AND xccu006=l_inag.inag006                         #进价 
      #mark by geza 20151109(E)   
      #add by geza 20151109(S)  
      #单价改由s_cost_price_get_item_cost元件抓取xccu的单价
      #营运中心编号 帐套 本位币顺序 成本计算类型 会计年度 会计期别 料件编号 产品特征 仓库 批号 库存管理特征 币种        
      CALL s_cost_price_get_item_cost(l_rtbf.rtbfsite,'','1','','','',l_rtbf.rtbf002,l_inag.inag002,l_inag.inag004,l_inag.inag006,l_inag.inag003,'')  RETURNING l_success,l_rtbf.rtbf007
      #add by geza 20151109(E)           
      IF cl_null(l_rtbf.rtbf007) THEN
         LET l_rtbf.rtbf007 = 0
      END IF
      LET l_rtbf.rtbf008 = l_inag.inag009                   #数量 
      IF cl_null(l_rtbf.rtbf008) THEN
         LET l_rtbf.rtbf008 = 0
      END IF 
      #mark by geza 20151109(S)      
#      SELECT xccu102 INTO l_rtbf.rtbf009 
#        FROM xccu_t
#       WHERE xccuent=g_enterprise
#         AND xccu004=l_inag.inag001   
#         AND xccu006=l_inag.inag006                         #转类发生金额
      #mark by geza 20151109(E)   
      #add by geza 20151109(S)  
      #金额= 单价 * 数量
      LET l_rtbf.rtbf009 = l_rtbf.rtbf008 * l_rtbf.rtbf007     
      #add by geza 20151109(E)
      IF cl_null(l_rtbf.rtbf009) THEN
         LET l_rtbf.rtbf009 = 0
      END IF    
    # INSERT INTO rtbf_t VALUES (l_rtbf.*)    #161111-00028#3--mark
     #161111-00028#3--add---begin-----------
      INSERT INTO rtbf_t (rtbfent,rtbfsite,rtbfdocno,rtbfseq,rtbfseq1,rtbf001,rtbf002,rtbf003,rtbf004,rtbf005,
                         rtbf006,rtbf007,rtbf008,rtbf009)
       VALUES (l_rtbf.rtbfent,l_rtbf.rtbfsite,l_rtbf.rtbfdocno,l_rtbf.rtbfseq,l_rtbf.rtbfseq1,l_rtbf.rtbf001,
               l_rtbf.rtbf002,l_rtbf.rtbf003,l_rtbf.rtbf004,l_rtbf.rtbf005,l_rtbf.rtbf006,l_rtbf.rtbf007,
               l_rtbf.rtbf008,l_rtbf.rtbf009)
     #161111-00028#3--add---end-------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "into rtbf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET r_success=FALSE
         RETURN r_success  
      END IF                                   
   END FOREACH
   
   FREE artt302_rtbf

   #更新单身1的数量和金额
   UPDATE rtbe_t SET rtbe005 = (COALESCE((SELECT SUM(rtbf008) 
                                  FROM rtbf_t    
                                 WHERE rtbfent = g_enterprise 
                                   AND rtbfdocno = g_rtbd_m.rtbddocno
                                   #AND rtbfsite = g_rtbd_m.rtbdsite  #mark by geza 20150906
                                   AND rtbfseq = l_rtbeseq),0)),
                     rtbe006 = (COALESCE((SELECT SUM(rtbf009) 
                                  FROM rtbf_t    
                                 WHERE rtbfent = g_enterprise 
                                   AND rtbfdocno = g_rtbd_m.rtbddocno
                                   #AND rtbfsite = g_rtbd_m.rtbdsite  #mark by geza 20150906
                                   AND rtbfseq = l_rtbeseq),0))                           
   WHERE rtbeent = g_enterprise
     AND rtbedocno = g_rtbd_m.rtbddocno
     #AND rtbesite = g_rtbd_m.rtbdsite    #mark by geza 20150906
     AND rtbeseq = l_rtbeseq 
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd rtbe_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()         
      LET r_success=FALSE
      RETURN r_success  
   END IF   
   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 批量产生转出小类的商品
# Memo...........:
# Usage..........: CALL artt302_rtbe_init()
# Date & Author..: 20150820 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt302_rtbe_init()
DEFINE l_sql       STRING
#161111-00028#3---modify---begin------------
#DEFINE l_stas      RECORD LIKE stas_t.*
#DEFINE l_rtbe      RECORD LIKE rtbe_t.*
DEFINE l_stas RECORD  #採購協議明細檔
       stasent LIKE stas_t.stasent, #企業編號
       stas001 LIKE stas_t.stas001, #協議編號
       stas002 LIKE stas_t.stas002, #序號
       stas003 LIKE stas_t.stas003, #商品編號
       stas004 LIKE stas_t.stas004, #商品條碼
       stas005 LIKE stas_t.stas005, #包裝單位
       stas006 LIKE stas_t.stas006, #件裝數
       stas007 LIKE stas_t.stas007, #配送方式
       stas008 LIKE stas_t.stas008, #採購單位
       stas009 LIKE stas_t.stas009, #採購員
       stas010 LIKE stas_t.stas010, #進價
       stas011 LIKE stas_t.stas011, #促銷進價
       stas012 LIKE stas_t.stas012, #最小採購量
       stas013 LIKE stas_t.stas013, #採購倍量
       stas014 LIKE stas_t.stas014, #最小採購額
       stas015 LIKE stas_t.stas015, #是否保證毛利率
       stas016 LIKE stas_t.stas016, #保證毛利率
       stas017 LIKE stas_t.stas017, #退廠標誌
       stas018 LIKE stas_t.stas018, #生效日期
       stas019 LIKE stas_t.stas019, #失效日期
       stas020 LIKE stas_t.stas020, #進項稅別
       stas021 LIKE stas_t.stas021, #No use
       stas022 LIKE stas_t.stas022, #採購幣別
       stas023 LIKE stas_t.stas023, #採購計價單位
       stas024 LIKE stas_t.stas024, #No use
       stas025 LIKE stas_t.stas025, #結算扣率
       stassite LIKE stas_t.stassite, #營運據點
       stas026 LIKE stas_t.stas026, #促銷進價開始日
       stas027 LIKE stas_t.stas027, #促銷進價結束日
       stas028 LIKE stas_t.stas028, #商品生命週期
       stas029 LIKE stas_t.stas029, #最近入庫進價
       stas030 LIKE stas_t.stas030  #執行進價
       END RECORD
DEFINE l_rtbe RECORD  #商品轉類單單身明細表
       rtbeent LIKE rtbe_t.rtbeent, #企業編號
       rtbesite LIKE rtbe_t.rtbesite, #營運據點
       rtbedocno LIKE rtbe_t.rtbedocno, #單據編號
       rtbeseq LIKE rtbe_t.rtbeseq, #項次
       rtbe001 LIKE rtbe_t.rtbe001, #商品主條碼
       rtbe002 LIKE rtbe_t.rtbe002, #商品編號
       rtbe003 LIKE rtbe_t.rtbe003, #銷售單位
       rtbe004 LIKE rtbe_t.rtbe004, #供應商編號
       rtbe005 LIKE rtbe_t.rtbe005, #數量
       rtbe006 LIKE rtbe_t.rtbe006 #轉類發生金額
       END RECORD
#161111-00028#3---modify---end---------------
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num10
DEFINE l_imaa001   LIKE imaa_t.imaa001
DEFINE l_imay003   LIKE imay_t.imay003

   LET r_success=TRUE
   #判断产生单身的资料，没资料产生提示
   LET l_cnt = 0
   #mark by geza 20150906(S)
#   SELECT COUNT(*) INTO l_cnt 
#     FROM stas_t 
#    WHERE stasent = g_enterprise
#      AND stassite = g_rtbd_m.rtbdsite
#      AND EXISTS (SELECT 1 
#                    FROM imaa_t 
#                   WHERE imaaent = g_enterprise 
#                     AND stas003 = IMAA001 
#                     AND imaa009 = g_rtbd_m.rtbd001)
   #mark by geza 20150906(E)  
   #add by geza 20150906(S)
   SELECT COUNT(*) INTO l_cnt 
     FROM imaa_t,imay_t 
    WHERE imaaent = g_enterprise  
      AND imaa009 = g_rtbd_m.rtbd001
      AND imaaent = imayent
      AND imay001 = imaa001
      AND imaastus = 'Y'
      AND imaystus = 'Y'
      AND imay006 =  'Y'   
   #add by geza 20150906(E)    
   IF l_cnt = 0 THEN  
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "art-00704" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success=FALSE
      RETURN r_success    
   END IF
#   #mark by geza 20150906(S)
#   LET l_sql = " SELECT * FROM stas_t ",
#               "  WHERE stasent = ?",
#               "    AND stassite = ?",
#               "    AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent = ",g_enterprise," AND stas003 = IMAA001 AND imaa009 = '",g_rtbd_m.rtbd001,"')"
#   #mark by geza 20150906(E)
   #add by geza 20150906(S)
   LET l_sql = " SELECT imaa001,imay003 FROM imaa_t,imay_t ",
               "  WHERE imaaent = ?",
               "    AND imaaent = imayent",
               "    AND imay001 = imaa001 ",
               "    AND imaa009 = '",g_rtbd_m.rtbd001,"'",
               "    AND imaastus = 'Y' ",
               "    AND imaystus = 'Y' ",
               "    AND imay006 =  'Y' "
   #add by geza 20150906(E)
   PREPARE artt302_rtbe FROM l_sql
   DECLARE artt302_rtbe_ins CURSOR FOR artt302_rtbe
   #OPEN artt302_rtbe_ins USING g_enterprise,g_rtbd_m.rtbdsite  #mark by geza 20150906
   OPEN artt302_rtbe_ins USING g_enterprise                     #add by geza 20150906
   INITIALIZE l_stas.* TO NULL
   INITIALIZE l_imaa001 TO NULL
   INITIALIZE l_imay003 TO NULL
   FOREACH artt302_rtbe_ins INTO l_imaa001,l_imay003    
      INITIALIZE l_rtbe.* TO NULL
      LET l_rtbe.rtbeent = g_enterprise                    #企業編號    
      LET l_rtbe.rtbesite = g_rtbd_m.rtbdsite              #所屬組織
      LET l_rtbe.rtbedocno = g_rtbd_m.rtbddocno            #单据编号        
      SELECT MAX(rtbeseq)+1 INTO l_rtbe.rtbeseq            #项次   
        FROM rtbe_t
       WHERE rtbeent=g_enterprise
         AND rtbedocno=g_rtbd_m.rtbddocno
      IF cl_null(l_rtbe.rtbeseq) THEN
         LET l_rtbe.rtbeseq=1
      END IF                                                        
      LET l_rtbe.rtbe001 = l_imay003                       #商品主条码  
      LET l_rtbe.rtbe002 = l_imaa001                       #商品编号    
      
      SELECT imaa105 INTO  l_rtbe.rtbe003                  #销售单位    
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_rtbe.rtbe002  
      #mark by geza 20150906(S)                
#      SELECT star003 INTO l_rtbe.rtbe004                    #供应商编号
#        FROM star_t 
#       WHERE starent = g_enterprise
#         AND starsite = l_stas.stassite
#         AND star001 = l_stas.stas001                    
      #mark by geza 20150906(E) 
      LET l_rtbe.rtbe005 = 0                                #数量
      LET l_rtbe.rtbe006 = 0                                #金额
   #  INSERT INTO rtbe_t VALUES (l_rtbe.*)    #161111-00028#3--mark
   #161111-00028#3 ---add---begin---------
      INSERT INTO rtbe_t (rtbeent,rtbesite,rtbedocno,rtbeseq,rtbe001,rtbe002,rtbe003,rtbe004,rtbe005,rtbe006)
       VALUES (l_rtbe.rtbeent,l_rtbe.rtbesite,l_rtbe.rtbedocno,l_rtbe.rtbeseq,l_rtbe.rtbe001,l_rtbe.rtbe002,
               l_rtbe.rtbe003,l_rtbe.rtbe004,l_rtbe.rtbe005,l_rtbe.rtbe006)
   #161111-00028#3 ---add---end-----------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "into rtbe_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success=FALSE
         RETURN r_success    
      END IF
      #插入库存明细单身
      CALL artt302_rtbf_init(l_rtbe.rtbeseq,l_rtbe.rtbe001,l_rtbe.rtbe002,l_rtbe.rtbe003,l_rtbe.rtbe004)  RETURNING l_success      
      IF NOT l_success THEN
         LET r_success=FALSE
         RETURN r_success                     
      END IF
   END FOREACH
   RETURN r_success
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
PRIVATE FUNCTION artt302_rtbf004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbe2_d[l_ac].rtbf004
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbe2_d[l_ac].rtbf004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbe2_d[l_ac].rtbf004_desc   
END FUNCTION

 
{</section>}
 
