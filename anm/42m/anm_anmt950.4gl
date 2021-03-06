#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt950.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-05-04 12:38:31), PR版次:0008(2016-10-28 09:58:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000112
#+ Filename...: anmt950
#+ Description: 內部資金調度項目利息維護作業
#+ Creator....: 03538(2014-09-01 14:19:05)
#+ Modifier...: 07900 -SD/PR- 08171
 
{</section>}
 
{<section id="anmt950.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13  15/07/21  By RayHuang statechange段問題修正
#151125-00001#3   15/11/27  By Charles4m 增加詢問是否作廢。
#151125-00006#3   15/12/03  By 07166     新增[編輯完單據後立即審核]功能
#160328-00020#11  16/04/27  By 02599     利息金额汇总该抓取nmbp016,修改抓取新增本金SQL，排除费用金额
#160427-00018#1   16/05/04  By 07900     1:资金中心nmbz001开窗有误，应为ooef206=Y
#                                        2:查询时，资金中心录入资料报:"指定的资料无法查询到，请再审核条件是否正确"
#                                          不下条件或在年度期别字段下条件时，可查询到正确的资料。
#160816-00068#7   16/08/18  By earl      調整transaction
#160818-00017#24 2016-08-23 By 08734 删除修改未重新判断状态码
#161006-00005#37  16/10/28  By 08171     资金中心开窗需调整为q_ooef001_33
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
PRIVATE type type_g_nmbz_m        RECORD
       nmbz001 LIKE nmbz_t.nmbz001, 
   nmbz001_desc LIKE type_t.chr80, 
   nmbz002 LIKE nmbz_t.nmbz002, 
   nmbz003 LIKE nmbz_t.nmbz003, 
   nmbzdocno LIKE nmbz_t.nmbzdocno, 
   nmbzstus LIKE nmbz_t.nmbzstus, 
   nmbzownid LIKE nmbz_t.nmbzownid, 
   nmbzownid_desc LIKE type_t.chr80, 
   nmbzowndp LIKE nmbz_t.nmbzowndp, 
   nmbzowndp_desc LIKE type_t.chr80, 
   nmbzcrtid LIKE nmbz_t.nmbzcrtid, 
   nmbzcrtid_desc LIKE type_t.chr80, 
   nmbzcrtdp LIKE nmbz_t.nmbzcrtdp, 
   nmbzcrtdp_desc LIKE type_t.chr80, 
   nmbzcrtdt LIKE nmbz_t.nmbzcrtdt, 
   nmbzmodid LIKE nmbz_t.nmbzmodid, 
   nmbzmodid_desc LIKE type_t.chr80, 
   nmbzmoddt LIKE nmbz_t.nmbzmoddt, 
   nmbzcnfid LIKE nmbz_t.nmbzcnfid, 
   nmbzcnfid_desc LIKE type_t.chr80, 
   nmbzcnfdt LIKE nmbz_t.nmbzcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmbp_d        RECORD
       nmbpseq1 LIKE nmbp_t.nmbpseq1, 
   nmbp012 LIKE nmbp_t.nmbp012, 
   nmbp013 LIKE nmbp_t.nmbp013, 
   nmbp004 LIKE nmbp_t.nmbp004, 
   nmbnl003 LIKE type_t.chr500, 
   nmbo012 LIKE type_t.dat, 
   nmbp007 LIKE nmbp_t.nmbp007, 
   nmbp0110 LIKE type_t.num20_6, 
   nmbp0111 LIKE type_t.num20_6, 
   nmbp0112 LIKE type_t.num20_6, 
   nmbp0113 LIKE type_t.num20_6, 
   nmbp0114 LIKE type_t.num20_6, 
   nmbp0115 LIKE type_t.num20_6, 
   nmbpseq LIKE nmbp_t.nmbpseq, 
   nmbp014 LIKE nmbp_t.nmbp014
       END RECORD
PRIVATE TYPE type_g_nmbp3_d RECORD
       nmbp006 LIKE type_t.chr500, 
   nmbp005 LIKE type_t.chr500, 
   nmbp007 LIKE nmbp_t.nmbp007, 
   nmbx103 LIKE type_t.num20_6, 
   nmbo008 LIKE type_t.num20_6, 
   nmbp0116 LIKE type_t.num20_6, 
   nmbp0117 LIKE type_t.num20_6, 
   nmbp0118 LIKE type_t.num20_6, 
   nmbp0119 LIKE type_t.num20_6, 
   balance LIKE type_t.num20_6, 
   nmbpseq LIKE nmbp_t.nmbpseq, 
   nmbpseq1 LIKE nmbp_t.nmbpseq1, 
   nmbp014 LIKE nmbp_t.nmbp014
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmbz001 LIKE nmbz_t.nmbz001,
      b_nmbz002 LIKE nmbz_t.nmbz002,
      b_nmbz003 LIKE nmbz_t.nmbz003,
      b_nmbzdocno LIKE nmbz_t.nmbzdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_para_data LIKE type_t.chr80
DEFINE l_ac_b                LIKE type_t.num5

#end add-point
       
#模組變數(Module Variables)
DEFINE g_nmbz_m          type_g_nmbz_m
DEFINE g_nmbz_m_t        type_g_nmbz_m
DEFINE g_nmbz_m_o        type_g_nmbz_m
DEFINE g_nmbz_m_mask_o   type_g_nmbz_m #轉換遮罩前資料
DEFINE g_nmbz_m_mask_n   type_g_nmbz_m #轉換遮罩後資料
 
   DEFINE g_nmbz001_t LIKE nmbz_t.nmbz001
DEFINE g_nmbz002_t LIKE nmbz_t.nmbz002
DEFINE g_nmbz003_t LIKE nmbz_t.nmbz003
DEFINE g_nmbzdocno_t LIKE nmbz_t.nmbzdocno
 
 
DEFINE g_nmbp_d          DYNAMIC ARRAY OF type_g_nmbp_d
DEFINE g_nmbp_d_t        type_g_nmbp_d
DEFINE g_nmbp_d_o        type_g_nmbp_d
DEFINE g_nmbp_d_mask_o   DYNAMIC ARRAY OF type_g_nmbp_d #轉換遮罩前資料
DEFINE g_nmbp_d_mask_n   DYNAMIC ARRAY OF type_g_nmbp_d #轉換遮罩後資料
DEFINE g_nmbp3_d          DYNAMIC ARRAY OF type_g_nmbp3_d
DEFINE g_nmbp3_d_t        type_g_nmbp3_d
DEFINE g_nmbp3_d_o        type_g_nmbp3_d
DEFINE g_nmbp3_d_mask_o   DYNAMIC ARRAY OF type_g_nmbp3_d #轉換遮罩前資料
DEFINE g_nmbp3_d_mask_n   DYNAMIC ARRAY OF type_g_nmbp3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
 
{<section id="anmt950.main" >}
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
   LET g_forupd_sql = " SELECT nmbz001,'',nmbz002,nmbz003,nmbzdocno,nmbzstus,nmbzownid,'',nmbzowndp, 
       '',nmbzcrtid,'',nmbzcrtdp,'',nmbzcrtdt,nmbzmodid,'',nmbzmoddt,nmbzcnfid,'',nmbzcnfdt", 
                      " FROM nmbz_t",
                      " WHERE nmbzent= ? AND nmbzdocno=? AND nmbz001=? AND nmbz002=? AND nmbz003=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt950_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbz001,t0.nmbz002,t0.nmbz003,t0.nmbzdocno,t0.nmbzstus,t0.nmbzownid, 
       t0.nmbzowndp,t0.nmbzcrtid,t0.nmbzcrtdp,t0.nmbzcrtdt,t0.nmbzmodid,t0.nmbzmoddt,t0.nmbzcnfid,t0.nmbzcnfdt, 
       t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM nmbz_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmbz001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.nmbzownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.nmbzowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.nmbzcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.nmbzcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.nmbzmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmbzcnfid  ",
 
               " WHERE t0.nmbzent = " ||g_enterprise|| " AND t0.nmbzdocno = ? AND t0.nmbz001 = ? AND t0.nmbz002 = ? AND t0.nmbz003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt950_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt950 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt950_init()   
 
      #進入選單 Menu (="N")
      CALL anmt950_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt950
      
   END IF 
   
   CLOSE anmt950_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt950.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt950_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  value       STRING,
                  label_tag   STRING,
                  label       STRING
              END RECORD
   DEFINE i       LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('nmbzstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL anmt950_create_tmp()
   CALL l_array.clear()
   FOR i = 2000 TO 2100
      CALL l_array.appendElement()
      LET l_array[l_array.getLength()].value = i
      LET l_array[l_array.getLength()].label = i
   END FOR
   CALL cl_set_combo_detail('nmbz002',l_array)     #年度
   CALL l_array.clear()
   FOR i = 1 TO 12
      LET l_array[i].value = i
      LET l_array[i].label = i
   END FOR
   CALL cl_set_combo_detail('nmbz003',l_array)     #期別
   CALL l_array.clear()    

   #end add-point
   
   #初始化搜尋條件
   CALL anmt950_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt950.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt950_ui_dialog()
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
   DEFINE  l_n      LIKE type_t.num10          #151125-00006#3
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_nmbz_m.* TO NULL
         CALL g_nmbp_d.clear()
         CALL g_nmbp3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt950_init()
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
               
               CALL anmt950_fetch('') # reload data
               LET l_ac = 1
               CALL anmt950_ui_detailshow() #Setting the current row 
         
               CALL anmt950_idx_chk()
               #NEXT FIELD nmbpseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_nmbp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt950_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL anmt950_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_anmt940
                  LET g_action_choice="prog_anmt940"
                  IF cl_auth_chk_act("prog_anmt940") THEN
                     
                     #add-point:ON ACTION prog_anmt940 name="menu.detail_show.page1_sub.prog_anmt940"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'anmt940'
               LET la_param.param[1] = g_nmbp_d[l_ac].nmbp012

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
 
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_nmbp3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt950_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
               LET l_ac_b = l_ac
               CALL anmt950_b_fill()             
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL anmt950_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
 
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt950_browser_fill("")
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
               CALL anmt950_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt950_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt950_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"

         
         #此段落由子樣板a32產生
         #151013-00016#7 151102 by sakura mark(S)
         ##簽核狀況
         #ON ACTION bpm_status
         #   #查詢簽核狀況, 統一建立HyperLink
         #   CALL cl_bpm_status()
         #151013-00016#7 151102 by sakura mark(E)

            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt950_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt950_set_act_visible()   
            CALL anmt950_set_act_no_visible()
            IF NOT (g_nmbz_m.nmbzdocno IS NULL
              OR g_nmbz_m.nmbz001 IS NULL
              OR g_nmbz_m.nmbz002 IS NULL
              OR g_nmbz_m.nmbz003 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmbzent = " ||g_enterprise|| " AND",
                                  " nmbzdocno = '", g_nmbz_m.nmbzdocno, "' "
                                  ," AND nmbz001 = '", g_nmbz_m.nmbz001, "' "
                                  ," AND nmbz002 = '", g_nmbz_m.nmbz002, "' "
                                  ," AND nmbz003 = '", g_nmbz_m.nmbz003, "' "
 
               #填到對應位置
               CALL anmt950_browser_fill("")
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
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmbz_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbp_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL anmt950_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmbz_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbp_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL anmt950_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt950_fetch("F")
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
               CALL anmt950_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt950_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt950_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt950_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt950_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt950_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt950_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt950_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt950_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt950_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt950_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmbp_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmbp3_d)
                  LET g_export_id[2]   = "s_detail3"
 
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
               NEXT FIELD nmbpseq
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
               CALL anmt950_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s           
               CALL anmt950_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmbz_t
                WHERE nmbzent = g_enterprise AND nmbzdocno = g_nmbz_m.nmbzdocno
                IF l_n > 0 THEN CALL anmt950_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt950_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s           
               CALL anmt950_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmbz_t
                WHERE nmbzent = g_enterprise AND nmbzdocno = g_nmbz_m.nmbzdocno
                IF l_n > 0 THEN CALL anmt950_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt950_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/anm/anmt950_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/anm/anmt950_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt950_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt950_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt950_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt950_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="anmt950.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt950_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
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
#liuym 2014/11/27 mark----str----
#   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
#      LET l_searchcol = "nmbz001,nmbz002,nmbz003"
#   ELSE
#      LET l_searchcol = g_searchcol
#   END IF
#--mark---end
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmbzdocno,nmbz001,nmbz002,nmbz003 ",
                      " FROM nmbz_t ",
                      " ",
                      " LEFT JOIN nmbp_t ON nmbpent = nmbzent AND nmbzdocno = nmbpdocno AND nmbz001 = nmbp001 AND nmbz002 = nmbp002 AND nmbz003 = nmbp003 ", "  ",
                      #add-point:browser_fill段sql(nmbp_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE nmbzent = " ||g_enterprise|| " AND nmbpent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmbz_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmbzdocno,nmbz001,nmbz002,nmbz003 ",
                      " FROM nmbz_t ", 
                      "  ",
                      "  ",
                      " WHERE nmbzent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmbz_t")
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
      INITIALIZE g_nmbz_m.* TO NULL
      CALL g_nmbp_d.clear()        
      CALL g_nmbp3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmbz001,t0.nmbz002,t0.nmbz003,t0.nmbzdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbzstus,t0.nmbz001,t0.nmbz002,t0.nmbz003,t0.nmbzdocno ",
                  " FROM nmbz_t t0",
                  "  ",
                  "  LEFT JOIN nmbp_t ON nmbpent = nmbzent AND nmbzdocno = nmbpdocno AND nmbz001 = nmbp001 AND nmbz002 = nmbp002 AND nmbz003 = nmbp003 ", "  ", 
                  #add-point:browser_fill段sql(nmbp_t1) name="browser_fill.join.nmbp_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.nmbzent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmbz_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbzstus,t0.nmbz001,t0.nmbz002,t0.nmbz003,t0.nmbzdocno ",
                  " FROM nmbz_t t0",
                  "  ",
                  
                  " WHERE t0.nmbzent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("nmbz_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY nmbzdocno,nmbz001,nmbz002,nmbz003 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmbz_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_nmbz001,g_browser[g_cnt].b_nmbz002, 
          g_browser[g_cnt].b_nmbz003,g_browser[g_cnt].b_nmbzdocno
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
         CALL anmt950_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_nmbzdocno) THEN
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
 
{<section id="anmt950.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt950_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmbz_m.nmbzdocno = g_browser[g_current_idx].b_nmbzdocno   
   LET g_nmbz_m.nmbz001 = g_browser[g_current_idx].b_nmbz001   
   LET g_nmbz_m.nmbz002 = g_browser[g_current_idx].b_nmbz002   
   LET g_nmbz_m.nmbz003 = g_browser[g_current_idx].b_nmbz003   
 
   EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
       g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt, 
       g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzcnfid_desc 
 
   
   CALL anmt950_nmbz_t_mask()
   CALL anmt950_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt950.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt950_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt950_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmbzdocno = g_nmbz_m.nmbzdocno 
         AND g_browser[l_i].b_nmbz001 = g_nmbz_m.nmbz001 
         AND g_browser[l_i].b_nmbz002 = g_nmbz_m.nmbz002 
         AND g_browser[l_i].b_nmbz003 = g_nmbz_m.nmbz003 
 
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
 
{<section id="anmt950.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt950_construct()
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
   INITIALIZE g_nmbz_m.* TO NULL
   CALL g_nmbp_d.clear()        
   CALL g_nmbp3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmbz001,nmbz002,nmbz003,nmbzstus,nmbzownid,nmbzowndp,nmbzcrtid,nmbzcrtdp, 
          nmbzcrtdt,nmbzmodid,nmbzmoddt,nmbzcnfid,nmbzcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmbzcrtdt>>----
         AFTER FIELD nmbzcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmbzmoddt>>----
         AFTER FIELD nmbzmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbzcnfdt>>----
         AFTER FIELD nmbzcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbzpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbz001
            #add-point:BEFORE FIELD nmbz001 name="construct.b.nmbz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbz001
            
            #add-point:AFTER FIELD nmbz001 name="construct.a.nmbz001"
           #160427-00018#1  by 07900 --mark-str
        #   LET g_nmbz_m.nmbz001_desc = ''
         #   DISPLAY BY NAME g_nmbz_m.nmbz001_desc             
        #    LET g_nmbz_m.nmbz001 = GET_FLDBUF(nmbz001)
            #取得資金關帳日+1天之所在年月當預設值
       #     IF NOT cl_null (g_nmbz_m.nmbz001) THEN
       #        CALL cl_get_para(g_enterprise,g_nmbz_m.nmbz001,'S-FIN-4007') RETURNING l_para_data
        #       LET l_para_data = s_date_get_date(l_para_data,0,1)
        #       LET g_nmbz_m.nmbz002 = YEAR(l_para_data)
        #       LET g_nmbz_m.nmbz003 = MONTH(l_para_data)
       #     END IF
         #   CALL s_desc_get_department_desc(g_nmbz_m.nmbz001) RETURNING g_nmbz_m.nmbz001_desc
        #    DISPLAY BY NAME g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 
            #160427-00018#1  by 07900 --mark-end
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbz001
            #add-point:ON ACTION controlp INFIELD nmbz001 name="construct.c.nmbz001"
            #開窗c段

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE           
            #LET g_qryparam.where = "ooef206 ='Y'"  #160427-00018#1  By 07900 add  #161006-00005#37 mark
            #CALL q_ooef001()                           #呼叫開窗  #161006-00005#37 mark
            CALL q_ooef001_33()                                   #161006-00005#37 add
            DISPLAY g_qryparam.return1 TO nmbz001  #顯示到畫面上
            LET g_nmbz_m.nmbz001 = GET_FLDBUF(nmbz001)
            CALL s_desc_get_department_desc(g_nmbz_m.nmbz001) RETURNING g_nmbz_m.nmbz001_desc
            DISPLAY BY NAME g_nmbz_m.nmbz001_desc              
            NEXT FIELD nmbz001                     #返回原欄位
       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbz002
            #add-point:BEFORE FIELD nmbz002 name="construct.b.nmbz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbz002
            
            #add-point:AFTER FIELD nmbz002 name="construct.a.nmbz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbz002
            #add-point:ON ACTION controlp INFIELD nmbz002 name="construct.c.nmbz002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbz003
            #add-point:BEFORE FIELD nmbz003 name="construct.b.nmbz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbz003
            
            #add-point:AFTER FIELD nmbz003 name="construct.a.nmbz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbz003
            #add-point:ON ACTION controlp INFIELD nmbz003 name="construct.c.nmbz003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzstus
            #add-point:BEFORE FIELD nmbzstus name="construct.b.nmbzstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzstus
            
            #add-point:AFTER FIELD nmbzstus name="construct.a.nmbzstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbzstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzstus
            #add-point:ON ACTION controlp INFIELD nmbzstus name="construct.c.nmbzstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbzownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzownid
            #add-point:ON ACTION controlp INFIELD nmbzownid name="construct.c.nmbzownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbzownid  #顯示到畫面上
            NEXT FIELD nmbzownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzownid
            #add-point:BEFORE FIELD nmbzownid name="construct.b.nmbzownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzownid
            
            #add-point:AFTER FIELD nmbzownid name="construct.a.nmbzownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbzowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzowndp
            #add-point:ON ACTION controlp INFIELD nmbzowndp name="construct.c.nmbzowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbzowndp  #顯示到畫面上
            NEXT FIELD nmbzowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzowndp
            #add-point:BEFORE FIELD nmbzowndp name="construct.b.nmbzowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzowndp
            
            #add-point:AFTER FIELD nmbzowndp name="construct.a.nmbzowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbzcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzcrtid
            #add-point:ON ACTION controlp INFIELD nmbzcrtid name="construct.c.nmbzcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbzcrtid  #顯示到畫面上
            NEXT FIELD nmbzcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzcrtid
            #add-point:BEFORE FIELD nmbzcrtid name="construct.b.nmbzcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzcrtid
            
            #add-point:AFTER FIELD nmbzcrtid name="construct.a.nmbzcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbzcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzcrtdp
            #add-point:ON ACTION controlp INFIELD nmbzcrtdp name="construct.c.nmbzcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbzcrtdp  #顯示到畫面上
            NEXT FIELD nmbzcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzcrtdp
            #add-point:BEFORE FIELD nmbzcrtdp name="construct.b.nmbzcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzcrtdp
            
            #add-point:AFTER FIELD nmbzcrtdp name="construct.a.nmbzcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzcrtdt
            #add-point:BEFORE FIELD nmbzcrtdt name="construct.b.nmbzcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbzmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzmodid
            #add-point:ON ACTION controlp INFIELD nmbzmodid name="construct.c.nmbzmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbzmodid  #顯示到畫面上
            NEXT FIELD nmbzmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzmodid
            #add-point:BEFORE FIELD nmbzmodid name="construct.b.nmbzmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzmodid
            
            #add-point:AFTER FIELD nmbzmodid name="construct.a.nmbzmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzmoddt
            #add-point:BEFORE FIELD nmbzmoddt name="construct.b.nmbzmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbzcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzcnfid
            #add-point:ON ACTION controlp INFIELD nmbzcnfid name="construct.c.nmbzcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbzcnfid  #顯示到畫面上
            NEXT FIELD nmbzcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzcnfid
            #add-point:BEFORE FIELD nmbzcnfid name="construct.b.nmbzcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzcnfid
            
            #add-point:AFTER FIELD nmbzcnfid name="construct.a.nmbzcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzcnfdt
            #add-point:BEFORE FIELD nmbzcnfdt name="construct.b.nmbzcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON NULL
           FROM NULL
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
          
       
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "nmbz_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbp_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION anmt950_filter()
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
      CONSTRUCT g_wc_filter ON nmbz001,nmbz002,nmbz003,nmbzdocno
                          FROM s_browse[1].b_nmbz001,s_browse[1].b_nmbz002,s_browse[1].b_nmbz003,s_browse[1].b_nmbzdocno 
 
 
         BEFORE CONSTRUCT
               DISPLAY anmt950_filter_parser('nmbz001') TO s_browse[1].b_nmbz001
            DISPLAY anmt950_filter_parser('nmbz002') TO s_browse[1].b_nmbz002
            DISPLAY anmt950_filter_parser('nmbz003') TO s_browse[1].b_nmbz003
            DISPLAY anmt950_filter_parser('nmbzdocno') TO s_browse[1].b_nmbzdocno
      
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
 
      CALL anmt950_filter_show('nmbz001')
   CALL anmt950_filter_show('nmbz002')
   CALL anmt950_filter_show('nmbz003')
   CALL anmt950_filter_show('nmbzdocno')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION anmt950_filter_parser(ps_field)
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
 
{<section id="anmt950.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION anmt950_filter_show(ps_field)
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
   LET ls_condition = anmt950_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt950_query()
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
   CALL g_nmbp_d.clear()
   CALL g_nmbp3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt950_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt950_browser_fill("")
      CALL anmt950_fetch("")
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
      CALL anmt950_filter_show('nmbz001')
   CALL anmt950_filter_show('nmbz002')
   CALL anmt950_filter_show('nmbz003')
   CALL anmt950_filter_show('nmbzdocno')
   CALL anmt950_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt950_fetch("F") 
      #顯示單身筆數
      CALL anmt950_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt950_fetch(p_flag)
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
   
   LET g_nmbz_m.nmbzdocno = g_browser[g_current_idx].b_nmbzdocno
   LET g_nmbz_m.nmbz001 = g_browser[g_current_idx].b_nmbz001
   LET g_nmbz_m.nmbz002 = g_browser[g_current_idx].b_nmbz002
   LET g_nmbz_m.nmbz003 = g_browser[g_current_idx].b_nmbz003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
       g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt, 
       g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzcnfid_desc 
 
   
   #遮罩相關處理
   LET g_nmbz_m_mask_o.* =  g_nmbz_m.*
   CALL anmt950_nmbz_t_mask()
   LET g_nmbz_m_mask_n.* =  g_nmbz_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt950_set_act_visible()   
   CALL anmt950_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_nmbz_m.nmbzstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmbz_m_t.* = g_nmbz_m.*
   LET g_nmbz_m_o.* = g_nmbz_m.*
   
   LET g_data_owner = g_nmbz_m.nmbzownid      
   LET g_data_dept  = g_nmbz_m.nmbzowndp
   
   #重新顯示   
   CALL anmt950_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt950_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmbp_d.clear()   
   CALL g_nmbp3_d.clear()  
 
 
   INITIALIZE g_nmbz_m.* TO NULL             #DEFAULT 設定
   
   LET g_nmbzdocno_t = NULL
   LET g_nmbz001_t = NULL
   LET g_nmbz002_t = NULL
   LET g_nmbz003_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbz_m.nmbzownid = g_user
      LET g_nmbz_m.nmbzowndp = g_dept
      LET g_nmbz_m.nmbzcrtid = g_user
      LET g_nmbz_m.nmbzcrtdp = g_dept 
      LET g_nmbz_m.nmbzcrtdt = cl_get_current()
      LET g_nmbz_m.nmbzmodid = g_user
      LET g_nmbz_m.nmbzmoddt = cl_get_current()
      LET g_nmbz_m.nmbzstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmbz_m_t.* = g_nmbz_m.*
      LET g_nmbz_m_o.* = g_nmbz_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbz_m.nmbzstus 
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
 
 
 
    
      CALL anmt950_input("a")
      
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
         INITIALIZE g_nmbz_m.* TO NULL
         INITIALIZE g_nmbp_d TO NULL
         INITIALIZE g_nmbp3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt950_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmbp_d.clear()
      #CALL g_nmbp3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt950_set_act_visible()   
   CALL anmt950_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
   LET g_nmbz001_t = g_nmbz_m.nmbz001
   LET g_nmbz002_t = g_nmbz_m.nmbz002
   LET g_nmbz003_t = g_nmbz_m.nmbz003
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbzent = " ||g_enterprise|| " AND",
                      " nmbzdocno = '", g_nmbz_m.nmbzdocno, "' "
                      ," AND nmbz001 = '", g_nmbz_m.nmbz001, "' "
                      ," AND nmbz002 = '", g_nmbz_m.nmbz002, "' "
                      ," AND nmbz003 = '", g_nmbz_m.nmbz003, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt950_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt950_cl
   
   CALL anmt950_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
       g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt, 
       g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_nmbz_m_mask_o.* =  g_nmbz_m.*
   CALL anmt950_nmbz_t_mask()
   LET g_nmbz_m_mask_n.* =  g_nmbz_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbz_m.nmbz001,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno, 
       g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzcrtdt, 
       g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfid_desc, 
       g_nmbz_m.nmbzcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmbz_m.nmbzownid      
   LET g_data_dept  = g_nmbz_m.nmbzowndp
   
   #功能已完成,通報訊息中心
   CALL anmt950_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt950_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmbz_m_t.* = g_nmbz_m.*
   LET g_nmbz_m_o.* = g_nmbz_m.*
   
   IF g_nmbz_m.nmbzdocno IS NULL
   OR g_nmbz_m.nmbz001 IS NULL
   OR g_nmbz_m.nmbz002 IS NULL
   OR g_nmbz_m.nmbz003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
   LET g_nmbz001_t = g_nmbz_m.nmbz001
   LET g_nmbz002_t = g_nmbz_m.nmbz002
   LET g_nmbz003_t = g_nmbz_m.nmbz003
 
   CALL s_transaction_begin()
   
   OPEN anmt950_cl USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt950_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt950_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
       g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt, 
       g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT anmt950_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbz_m_mask_o.* =  g_nmbz_m.*
   CALL anmt950_nmbz_t_mask()
   LET g_nmbz_m_mask_n.* =  g_nmbz_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL anmt950_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
      LET g_nmbz001_t = g_nmbz_m.nmbz001
      LET g_nmbz002_t = g_nmbz_m.nmbz002
      LET g_nmbz003_t = g_nmbz_m.nmbz003
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmbz_m.nmbzmodid = g_user 
LET g_nmbz_m.nmbzmoddt = cl_get_current()
LET g_nmbz_m.nmbzmodid_desc = cl_get_username(g_nmbz_m.nmbzmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_nmbz_m.nmbzstus MATCHES "[DR]" THEN 
         LET g_nmbz_m.nmbzstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt950_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE nmbz_t SET (nmbzmodid,nmbzmoddt) = (g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt)
          WHERE nmbzent = g_enterprise AND nmbzdocno = g_nmbzdocno_t
            AND nmbz001 = g_nmbz001_t
            AND nmbz002 = g_nmbz002_t
            AND nmbz003 = g_nmbz003_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_nmbz_m.* = g_nmbz_m_t.*
            CALL anmt950_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_nmbz_m.nmbzdocno != g_nmbz_m_t.nmbzdocno
      OR g_nmbz_m.nmbz001 != g_nmbz_m_t.nmbz001
      OR g_nmbz_m.nmbz002 != g_nmbz_m_t.nmbz002
      OR g_nmbz_m.nmbz003 != g_nmbz_m_t.nmbz003
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE nmbp_t SET nmbpdocno = g_nmbz_m.nmbzdocno
                                       ,nmbp001 = g_nmbz_m.nmbz001
                                       ,nmbp002 = g_nmbz_m.nmbz002
                                       ,nmbp003 = g_nmbz_m.nmbz003
 
          WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbz_m_t.nmbzdocno
            AND nmbp001 = g_nmbz_m_t.nmbz001
            AND nmbp002 = g_nmbz_m_t.nmbz002
            AND nmbp003 = g_nmbz_m_t.nmbz003
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmbp_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt950_set_act_visible()   
   CALL anmt950_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmbzent = " ||g_enterprise|| " AND",
                      " nmbzdocno = '", g_nmbz_m.nmbzdocno, "' "
                      ," AND nmbz001 = '", g_nmbz_m.nmbz001, "' "
                      ," AND nmbz002 = '", g_nmbz_m.nmbz002, "' "
                      ," AND nmbz003 = '", g_nmbz_m.nmbz003, "' "
 
   #填到對應位置
   CALL anmt950_browser_fill("")
 
   CLOSE anmt950_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt950_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt950.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt950_input(p_cmd)
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
   DISPLAY BY NAME g_nmbz_m.nmbz001,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno, 
       g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzcrtdt, 
       g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfid_desc, 
       g_nmbz_m.nmbzcnfdt
   
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
   LET g_forupd_sql = "SELECT nmbpseq1,nmbp012,nmbp013,nmbp004,nmbp007,nmbpseq,nmbp014,nmbp006,nmbp005, 
       nmbp007,nmbpseq,nmbpseq1,nmbp014 FROM nmbp_t WHERE nmbpent=? AND nmbpdocno=? AND nmbp001=? AND  
       nmbp002=? AND nmbp003=? AND nmbpseq=? AND nmbpseq1=? AND nmbp014=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt950_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt950_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt950_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmbz_m.nmbzstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt950.input.head" >}
      #單頭段
      INPUT BY NAME g_nmbz_m.nmbzstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt950_cl USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt950_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt950_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt950_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL anmt950_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbzstus
            #add-point:BEFORE FIELD nmbzstus name="input.b.nmbzstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbzstus
            
            #add-point:AFTER FIELD nmbzstus name="input.a.nmbzstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbzstus
            #add-point:ON CHANGE nmbzstus name="input.g.nmbzstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbzstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbzstus
            #add-point:ON ACTION controlp INFIELD nmbzstus name="input.c.nmbzstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO nmbz_t (nmbzent,nmbz001,nmbz002,nmbz003,nmbzdocno,nmbzstus,nmbzownid,nmbzowndp, 
                   nmbzcrtid,nmbzcrtdp,nmbzcrtdt,nmbzmodid,nmbzmoddt,nmbzcnfid,nmbzcnfdt)
               VALUES (g_enterprise,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno, 
                   g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp, 
                   g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_nmbz_m:",SQLERRMESSAGE 
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
                  CALL anmt950_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt950_b_fill()
                  CALL anmt950_b_fill2('0')
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
               CALL anmt950_nmbz_t_mask_restore('restore_mask_o')
               
               UPDATE nmbz_t SET (nmbz001,nmbz002,nmbz003,nmbzdocno,nmbzstus,nmbzownid,nmbzowndp,nmbzcrtid, 
                   nmbzcrtdp,nmbzcrtdt,nmbzmodid,nmbzmoddt,nmbzcnfid,nmbzcnfdt) = (g_nmbz_m.nmbz001, 
                   g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid, 
                   g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid, 
                   g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt)
                WHERE nmbzent = g_enterprise AND nmbzdocno = g_nmbzdocno_t
                  AND nmbz001 = g_nmbz001_t
                  AND nmbz002 = g_nmbz002_t
                  AND nmbz003 = g_nmbz003_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmbz_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL anmt950_nmbz_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_nmbz_m_t)
               LET g_log2 = util.JSON.stringify(g_nmbz_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
            LET g_nmbz001_t = g_nmbz_m.nmbz001
            LET g_nmbz002_t = g_nmbz_m.nmbz002
            LET g_nmbz003_t = g_nmbz_m.nmbz003
 
            
      END INPUT
   
 
{</section>}
 
{<section id="anmt950.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmbp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt950_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmbp_d.getLength()
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
            OPEN anmt950_cl USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt950_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt950_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbp_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbp_d[l_ac].nmbpseq IS NOT NULL
               AND g_nmbp_d[l_ac].nmbpseq1 IS NOT NULL
               AND g_nmbp_d[l_ac].nmbp014 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmbp_d_t.* = g_nmbp_d[l_ac].*  #BACKUP
               LET g_nmbp_d_o.* = g_nmbp_d[l_ac].*  #BACKUP
               CALL anmt950_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt950_set_no_entry_b(l_cmd)
               IF NOT anmt950_lock_b("nmbp_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt950_bcl INTO g_nmbp_d[l_ac].nmbpseq1,g_nmbp_d[l_ac].nmbp012,g_nmbp_d[l_ac].nmbp013, 
                      g_nmbp_d[l_ac].nmbp004,g_nmbp_d[l_ac].nmbp007,g_nmbp_d[l_ac].nmbpseq,g_nmbp_d[l_ac].nmbp014, 
                      g_nmbp3_d[l_ac].nmbp006,g_nmbp3_d[l_ac].nmbp005,g_nmbp3_d[l_ac].nmbp007,g_nmbp3_d[l_ac].nmbpseq, 
                      g_nmbp3_d[l_ac].nmbpseq1,g_nmbp3_d[l_ac].nmbp014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbp_d_t.nmbpseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbp_d_mask_o[l_ac].* =  g_nmbp_d[l_ac].*
                  CALL anmt950_nmbp_t_mask()
                  LET g_nmbp_d_mask_n[l_ac].* =  g_nmbp_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt950_show()
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
            INITIALIZE g_nmbp_d[l_ac].* TO NULL 
            INITIALIZE g_nmbp_d_t.* TO NULL 
            INITIALIZE g_nmbp_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_nmbp_d_t.* = g_nmbp_d[l_ac].*     #新輸入資料
            LET g_nmbp_d_o.* = g_nmbp_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt950_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt950_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbp_d[li_reproduce_target].* = g_nmbp_d[li_reproduce].*
               LET g_nmbp3_d[li_reproduce_target].* = g_nmbp3_d[li_reproduce].*
 
               LET g_nmbp_d[li_reproduce_target].nmbpseq = NULL
               LET g_nmbp_d[li_reproduce_target].nmbpseq1 = NULL
               LET g_nmbp_d[li_reproduce_target].nmbp014 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM nmbp_t 
             WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbz_m.nmbzdocno
               AND nmbp001 = g_nmbz_m.nmbz001
               AND nmbp002 = g_nmbz_m.nmbz002
               AND nmbp003 = g_nmbz_m.nmbz003
 
               AND nmbpseq = g_nmbp_d[l_ac].nmbpseq
               AND nmbpseq1 = g_nmbp_d[l_ac].nmbpseq1
               AND nmbp014 = g_nmbp_d[l_ac].nmbp014
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbz_m.nmbzdocno
               LET gs_keys[2] = g_nmbz_m.nmbz001
               LET gs_keys[3] = g_nmbz_m.nmbz002
               LET gs_keys[4] = g_nmbz_m.nmbz003
               LET gs_keys[5] = g_nmbp_d[g_detail_idx].nmbpseq
               LET gs_keys[6] = g_nmbp_d[g_detail_idx].nmbpseq1
               LET gs_keys[7] = g_nmbp_d[g_detail_idx].nmbp014
               CALL anmt950_insert_b('nmbp_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_nmbp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt950_b_fill()
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
               LET gs_keys[01] = g_nmbz_m.nmbzdocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz001
               LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz002
               LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz003
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmbp_d_t.nmbpseq
               LET gs_keys[gs_keys.getLength()+1] = g_nmbp_d_t.nmbpseq1
               LET gs_keys[gs_keys.getLength()+1] = g_nmbp_d_t.nmbp014
 
            
               #刪除同層單身
               IF NOT anmt950_delete_b('nmbp_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt950_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt950_key_delete_b(gs_keys,'nmbp_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt950_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt950_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_nmbp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbp_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbp012
            #add-point:BEFORE FIELD nmbp012 name="input.b.page1.nmbp012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbp012
            
            #add-point:AFTER FIELD nmbp012 name="input.a.page1.nmbp012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbp012
            #add-point:ON CHANGE nmbp012 name="input.g.page1.nmbp012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmbp012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbp012
            #add-point:ON ACTION controlp INFIELD nmbp012 name="input.c.page1.nmbp012"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbp_d[l_ac].* = g_nmbp_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt950_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmbp_d[l_ac].nmbpseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_nmbp_d[l_ac].* = g_nmbp_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt950_nmbp_t_mask_restore('restore_mask_o')
      
               UPDATE nmbp_t SET (nmbpdocno,nmbp001,nmbp002,nmbp003,nmbpseq1,nmbp012,nmbp013,nmbp004, 
                   nmbp007,nmbpseq,nmbp014,nmbp006,nmbp005) = (g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002, 
                   g_nmbz_m.nmbz003,g_nmbp_d[l_ac].nmbpseq1,g_nmbp_d[l_ac].nmbp012,g_nmbp_d[l_ac].nmbp013, 
                   g_nmbp_d[l_ac].nmbp004,g_nmbp_d[l_ac].nmbp007,g_nmbp_d[l_ac].nmbpseq,g_nmbp_d[l_ac].nmbp014, 
                   g_nmbp3_d[l_ac].nmbp006,g_nmbp3_d[l_ac].nmbp005)
                WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbz_m.nmbzdocno 
                  AND nmbp001 = g_nmbz_m.nmbz001 
                  AND nmbp002 = g_nmbz_m.nmbz002 
                  AND nmbp003 = g_nmbz_m.nmbz003 
 
                  AND nmbpseq = g_nmbp_d_t.nmbpseq #項次   
                  AND nmbpseq1 = g_nmbp_d_t.nmbpseq1  
                  AND nmbp014 = g_nmbp_d_t.nmbp014  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbp_d[l_ac].* = g_nmbp_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbp_d[l_ac].* = g_nmbp_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbz_m.nmbzdocno
               LET gs_keys_bak[1] = g_nmbzdocno_t
               LET gs_keys[2] = g_nmbz_m.nmbz001
               LET gs_keys_bak[2] = g_nmbz001_t
               LET gs_keys[3] = g_nmbz_m.nmbz002
               LET gs_keys_bak[3] = g_nmbz002_t
               LET gs_keys[4] = g_nmbz_m.nmbz003
               LET gs_keys_bak[4] = g_nmbz003_t
               LET gs_keys[5] = g_nmbp_d[g_detail_idx].nmbpseq
               LET gs_keys_bak[5] = g_nmbp_d_t.nmbpseq
               LET gs_keys[6] = g_nmbp_d[g_detail_idx].nmbpseq1
               LET gs_keys_bak[6] = g_nmbp_d_t.nmbpseq1
               LET gs_keys[7] = g_nmbp_d[g_detail_idx].nmbp014
               LET gs_keys_bak[7] = g_nmbp_d_t.nmbp014
               CALL anmt950_update_b('nmbp_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt950_nmbp_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmbp_d[g_detail_idx].nmbpseq = g_nmbp_d_t.nmbpseq 
                  AND g_nmbp_d[g_detail_idx].nmbpseq1 = g_nmbp_d_t.nmbpseq1 
                  AND g_nmbp_d[g_detail_idx].nmbp014 = g_nmbp_d_t.nmbp014 
 
                  ) THEN
                  LET gs_keys[01] = g_nmbz_m.nmbzdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz002
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbp_d_t.nmbpseq
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbp_d_t.nmbpseq1
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbp_d_t.nmbp014
 
                  CALL anmt950_key_update_b(gs_keys,'nmbp_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbz_m),util.JSON.stringify(g_nmbp_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbz_m),util.JSON.stringify(g_nmbp_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL anmt950_unlock_b("nmbp_t","'1'")
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
               LET g_nmbp_d[li_reproduce_target].* = g_nmbp_d[li_reproduce].*
               LET g_nmbp3_d[li_reproduce_target].* = g_nmbp3_d[li_reproduce].*
 
               LET g_nmbp_d[li_reproduce_target].nmbpseq = NULL
               LET g_nmbp_d[li_reproduce_target].nmbpseq1 = NULL
               LET g_nmbp_d[li_reproduce_target].nmbp014 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbp_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbp_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_nmbp3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL anmt950_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_nmbp3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbp3_d[l_ac].* TO NULL 
            INITIALIZE g_nmbp3_d_t.* TO NULL 
            INITIALIZE g_nmbp3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_nmbp3_d_t.* = g_nmbp3_d[l_ac].*     #新輸入資料
            LET g_nmbp3_d_o.* = g_nmbp3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt950_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt950_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbp_d[li_reproduce_target].* = g_nmbp_d[li_reproduce].*
               LET g_nmbp3_d[li_reproduce_target].* = g_nmbp3_d[li_reproduce].*
 
               LET g_nmbp3_d[li_reproduce_target].nmbpseq = NULL
               LET g_nmbp3_d[li_reproduce_target].nmbpseq1 = NULL
               LET g_nmbp3_d[li_reproduce_target].nmbp014 = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
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
            OPEN anmt950_cl USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt950_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt950_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbp3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbp3_d[l_ac].nmbpseq IS NOT NULL
               AND g_nmbp3_d[l_ac].nmbpseq1 IS NOT NULL
               AND g_nmbp3_d[l_ac].nmbp014 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_nmbp3_d_t.* = g_nmbp3_d[l_ac].*  #BACKUP
               LET g_nmbp3_d_o.* = g_nmbp3_d[l_ac].*  #BACKUP
               CALL anmt950_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL anmt950_set_no_entry_b(l_cmd)
               IF NOT anmt950_lock_b("nmbp_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt950_bcl INTO g_nmbp_d[l_ac].nmbpseq1,g_nmbp_d[l_ac].nmbp012,g_nmbp_d[l_ac].nmbp013, 
                      g_nmbp_d[l_ac].nmbp004,g_nmbp_d[l_ac].nmbp007,g_nmbp_d[l_ac].nmbpseq,g_nmbp_d[l_ac].nmbp014, 
                      g_nmbp3_d[l_ac].nmbp006,g_nmbp3_d[l_ac].nmbp005,g_nmbp3_d[l_ac].nmbp007,g_nmbp3_d[l_ac].nmbpseq, 
                      g_nmbp3_d[l_ac].nmbpseq1,g_nmbp3_d[l_ac].nmbp014
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbp3_d_mask_o[l_ac].* =  g_nmbp3_d[l_ac].*
                  CALL anmt950_nmbp_t_mask()
                  LET g_nmbp3_d_mask_n[l_ac].* =  g_nmbp3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt950_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_nmbz_m.nmbzdocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz001
               LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz002
               LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz003
               LET gs_keys[gs_keys.getLength()+1] = g_nmbp3_d_t.nmbpseq
               LET gs_keys[gs_keys.getLength()+1] = g_nmbp3_d_t.nmbpseq1
               LET gs_keys[gs_keys.getLength()+1] = g_nmbp3_d_t.nmbp014
            
               #刪除同層單身
               IF NOT anmt950_delete_b('nmbp_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt950_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt950_key_delete_b(gs_keys,'nmbp_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt950_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt950_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_nmbp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbp3_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM nmbp_t 
             WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbz_m.nmbzdocno
               AND nmbp001 = g_nmbz_m.nmbz001
               AND nmbp002 = g_nmbz_m.nmbz002
               AND nmbp003 = g_nmbz_m.nmbz003
               AND nmbpseq = g_nmbp3_d[l_ac].nmbpseq
               AND nmbpseq1 = g_nmbp3_d[l_ac].nmbpseq1
               AND nmbp014 = g_nmbp3_d[l_ac].nmbp014
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbz_m.nmbzdocno
               LET gs_keys[2] = g_nmbz_m.nmbz001
               LET gs_keys[3] = g_nmbz_m.nmbz002
               LET gs_keys[4] = g_nmbz_m.nmbz003
               LET gs_keys[5] = g_nmbp3_d[g_detail_idx].nmbpseq
               LET gs_keys[6] = g_nmbp3_d[g_detail_idx].nmbpseq1
               LET gs_keys[7] = g_nmbp3_d[g_detail_idx].nmbp014
               CALL anmt950_insert_b('nmbp_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmbp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt950_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbp3_d[l_ac].* = g_nmbp3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt950_bcl
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
               LET g_nmbp3_d[l_ac].* = g_nmbp3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL anmt950_nmbp_t_mask_restore('restore_mask_o')
                              
               UPDATE nmbp_t SET (nmbpdocno,nmbp001,nmbp002,nmbp003,nmbpseq1,nmbp012,nmbp013,nmbp004, 
                   nmbp007,nmbpseq,nmbp014,nmbp006,nmbp005) = (g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002, 
                   g_nmbz_m.nmbz003,g_nmbp_d[l_ac].nmbpseq1,g_nmbp_d[l_ac].nmbp012,g_nmbp_d[l_ac].nmbp013, 
                   g_nmbp_d[l_ac].nmbp004,g_nmbp_d[l_ac].nmbp007,g_nmbp_d[l_ac].nmbpseq,g_nmbp_d[l_ac].nmbp014, 
                   g_nmbp3_d[l_ac].nmbp006,g_nmbp3_d[l_ac].nmbp005) #自訂欄位頁簽
                WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbz_m.nmbzdocno
                  AND nmbp001 = g_nmbz_m.nmbz001
                  AND nmbp002 = g_nmbz_m.nmbz002
                  AND nmbp003 = g_nmbz_m.nmbz003
                  AND nmbpseq = g_nmbp3_d_t.nmbpseq #項次 
                  AND nmbpseq1 = g_nmbp3_d_t.nmbpseq1
                  AND nmbp014 = g_nmbp3_d_t.nmbp014
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbp3_d[l_ac].* = g_nmbp3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbp3_d[l_ac].* = g_nmbp3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbz_m.nmbzdocno
               LET gs_keys_bak[1] = g_nmbzdocno_t
               LET gs_keys[2] = g_nmbz_m.nmbz001
               LET gs_keys_bak[2] = g_nmbz001_t
               LET gs_keys[3] = g_nmbz_m.nmbz002
               LET gs_keys_bak[3] = g_nmbz002_t
               LET gs_keys[4] = g_nmbz_m.nmbz003
               LET gs_keys_bak[4] = g_nmbz003_t
               LET gs_keys[5] = g_nmbp3_d[g_detail_idx].nmbpseq
               LET gs_keys_bak[5] = g_nmbp3_d_t.nmbpseq
               LET gs_keys[6] = g_nmbp3_d[g_detail_idx].nmbpseq1
               LET gs_keys_bak[6] = g_nmbp3_d_t.nmbpseq1
               LET gs_keys[7] = g_nmbp3_d[g_detail_idx].nmbp014
               LET gs_keys_bak[7] = g_nmbp3_d_t.nmbp014
               CALL anmt950_update_b('nmbp_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt950_nmbp_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_nmbp3_d[g_detail_idx].nmbpseq = g_nmbp3_d_t.nmbpseq 
                  AND g_nmbp3_d[g_detail_idx].nmbpseq1 = g_nmbp3_d_t.nmbpseq1 
                  AND g_nmbp3_d[g_detail_idx].nmbp014 = g_nmbp3_d_t.nmbp014 
                  ) THEN
                  LET gs_keys[01] = g_nmbz_m.nmbzdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz002
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbz_m.nmbz003
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbp3_d_t.nmbpseq
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbp3_d_t.nmbpseq1
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbp3_d_t.nmbp014
                  CALL anmt950_key_update_b(gs_keys,'nmbp_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbz_m),util.JSON.stringify(g_nmbp3_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbz_m),util.JSON.stringify(g_nmbp3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbp006
            #add-point:BEFORE FIELD nmbp006 name="input.b.page3.nmbp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbp006
            
            #add-point:AFTER FIELD nmbp006 name="input.a.page3.nmbp006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbp006
            #add-point:ON CHANGE nmbp006 name="input.g.page3.nmbp006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.nmbp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbp006
            #add-point:ON ACTION controlp INFIELD nmbp006 name="input.c.page3.nmbp006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbp3_d[l_ac].* = g_nmbp3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt950_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt950_unlock_b("nmbp_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmbp_d[li_reproduce_target].* = g_nmbp_d[li_reproduce].*
               LET g_nmbp3_d[li_reproduce_target].* = g_nmbp3_d[li_reproduce].*
 
               LET g_nmbp3_d[li_reproduce_target].nmbpseq = NULL
               LET g_nmbp3_d[li_reproduce_target].nmbpseq1 = NULL
               LET g_nmbp3_d[li_reproduce_target].nmbp014 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbp3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbp3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="anmt950.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         LET l_ac_b = 1
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD nmbzdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmbpseq1
               WHEN "s_detail3"
                  NEXT FIELD nmbp006
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt950_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt950_b_fill() #單身填充
      CALL anmt950_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt950_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_nmbz_m_mask_o.* =  g_nmbz_m.*
   CALL anmt950_nmbz_t_mask()
   LET g_nmbz_m_mask_n.* =  g_nmbz_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmbz_m.nmbz001,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno, 
       g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzcrtdt, 
       g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfid_desc, 
       g_nmbz_m.nmbzcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbz_m.nmbzstus 
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
   FOR l_ac = 1 TO g_nmbp_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmbp3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt950_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt950_detail_show()
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
 
{<section id="anmt950.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt950_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmbz_t.nmbzdocno 
   DEFINE l_oldno     LIKE nmbz_t.nmbzdocno 
   DEFINE l_newno02     LIKE nmbz_t.nmbz001 
   DEFINE l_oldno02     LIKE nmbz_t.nmbz001 
   DEFINE l_newno03     LIKE nmbz_t.nmbz002 
   DEFINE l_oldno03     LIKE nmbz_t.nmbz002 
   DEFINE l_newno04     LIKE nmbz_t.nmbz003 
   DEFINE l_oldno04     LIKE nmbz_t.nmbz003 
 
   DEFINE l_master    RECORD LIKE nmbz_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmbp_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
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
   
   IF g_nmbz_m.nmbzdocno IS NULL
   OR g_nmbz_m.nmbz001 IS NULL
   OR g_nmbz_m.nmbz002 IS NULL
   OR g_nmbz_m.nmbz003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
   LET g_nmbz001_t = g_nmbz_m.nmbz001
   LET g_nmbz002_t = g_nmbz_m.nmbz002
   LET g_nmbz003_t = g_nmbz_m.nmbz003
 
    
   LET g_nmbz_m.nmbzdocno = ""
   LET g_nmbz_m.nmbz001 = ""
   LET g_nmbz_m.nmbz002 = ""
   LET g_nmbz_m.nmbz003 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbz_m.nmbzownid = g_user
      LET g_nmbz_m.nmbzowndp = g_dept
      LET g_nmbz_m.nmbzcrtid = g_user
      LET g_nmbz_m.nmbzcrtdp = g_dept 
      LET g_nmbz_m.nmbzcrtdt = cl_get_current()
      LET g_nmbz_m.nmbzmodid = g_user
      LET g_nmbz_m.nmbzmoddt = cl_get_current()
      LET g_nmbz_m.nmbzstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbz_m.nmbzstus 
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
      LET g_nmbz_m.nmbz001_desc = ''
   DISPLAY BY NAME g_nmbz_m.nmbz001_desc
 
   
   CALL anmt950_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmbz_m.* TO NULL
      INITIALIZE g_nmbp_d TO NULL
      INITIALIZE g_nmbp3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt950_show()
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
   CALL anmt950_set_act_visible()   
   CALL anmt950_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
   LET g_nmbz001_t = g_nmbz_m.nmbz001
   LET g_nmbz002_t = g_nmbz_m.nmbz002
   LET g_nmbz003_t = g_nmbz_m.nmbz003
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbzent = " ||g_enterprise|| " AND",
                      " nmbzdocno = '", g_nmbz_m.nmbzdocno, "' "
                      ," AND nmbz001 = '", g_nmbz_m.nmbz001, "' "
                      ," AND nmbz002 = '", g_nmbz_m.nmbz002, "' "
                      ," AND nmbz003 = '", g_nmbz_m.nmbz003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt950_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL anmt950_idx_chk()
   
   LET g_data_owner = g_nmbz_m.nmbzownid      
   LET g_data_dept  = g_nmbz_m.nmbzowndp
   
   #功能已完成,通報訊息中心
   CALL anmt950_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt950_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmbp_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt950_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbp_t
    WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbzdocno_t
     AND nmbp001 = g_nmbz001_t
     AND nmbp002 = g_nmbz002_t
     AND nmbp003 = g_nmbz003_t
 
    INTO TEMP anmt950_detail
 
   #將key修正為調整後   
   UPDATE anmt950_detail 
      #更新key欄位
      SET nmbpdocno = g_nmbz_m.nmbzdocno
          , nmbp001 = g_nmbz_m.nmbz001
          , nmbp002 = g_nmbz_m.nmbz002
          , nmbp003 = g_nmbz_m.nmbz003
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmbp_t SELECT * FROM anmt950_detail
   
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
   DROP TABLE anmt950_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
   LET g_nmbz001_t = g_nmbz_m.nmbz001
   LET g_nmbz002_t = g_nmbz_m.nmbz002
   LET g_nmbz003_t = g_nmbz_m.nmbz003
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt950_delete()
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
   
   IF g_nmbz_m.nmbzdocno IS NULL
   OR g_nmbz_m.nmbz001 IS NULL
   OR g_nmbz_m.nmbz002 IS NULL
   OR g_nmbz_m.nmbz003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN anmt950_cl USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt950_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt950_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
       g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt, 
       g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT anmt950_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbz_m_mask_o.* =  g_nmbz_m.*
   CALL anmt950_nmbz_t_mask()
   LET g_nmbz_m_mask_n.* =  g_nmbz_m.*
   
   CALL anmt950_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt950_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_nmbzdocno_t = g_nmbz_m.nmbzdocno
      LET g_nmbz001_t = g_nmbz_m.nmbz001
      LET g_nmbz002_t = g_nmbz_m.nmbz002
      LET g_nmbz003_t = g_nmbz_m.nmbz003
 
 
      DELETE FROM nmbz_t
       WHERE nmbzent = g_enterprise AND nmbzdocno = g_nmbz_m.nmbzdocno
         AND nmbz001 = g_nmbz_m.nmbz001
         AND nmbz002 = g_nmbz_m.nmbz002
         AND nmbz003 = g_nmbz_m.nmbz003
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_nmbz_m.nmbzdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM nmbp_t
       WHERE nmbpent = g_enterprise AND nmbpdocno = g_nmbz_m.nmbzdocno
         AND nmbp001 = g_nmbz_m.nmbz001
         AND nmbp002 = g_nmbz_m.nmbz002
         AND nmbp003 = g_nmbz_m.nmbz003
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmbz_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt950_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmbp_d.clear() 
      CALL g_nmbp3_d.clear()       
 
     
      CALL anmt950_ui_browser_refresh()  
      #CALL anmt950_ui_headershow()  
      #CALL anmt950_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt950_browser_fill("")
         CALL anmt950_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt950_cl
 
   #功能已完成,通報訊息中心
   CALL anmt950_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt950.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt950_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_nmbp_d.clear()
   CALL g_nmbp3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF l_ac_b = 0 THEN LET l_ac_b = 1 END IF
   #end add-point
   
   #判斷是否填充
   IF anmt950_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmbpseq1,nmbp012,nmbp013,nmbp004,nmbp007,nmbpseq,nmbp014,nmbp006, 
             nmbp005,nmbp007,nmbpseq,nmbpseq1,nmbp014  FROM nmbp_t",   
                     " INNER JOIN nmbz_t ON nmbzent = " ||g_enterprise|| " AND nmbzdocno = nmbpdocno ",
                     " AND nmbz001 = nmbp001 ",
                     " AND nmbz002 = nmbp002 ",
                     " AND nmbz003 = nmbp003 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE nmbpent=? AND nmbpdocno=? AND nmbp001=? AND nmbp002=? AND nmbp003=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbp_t.nmbpseq,nmbp_t.nmbpseq1,nmbp_t.nmbp014"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt950_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt950_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbp_d[l_ac].nmbpseq1, 
          g_nmbp_d[l_ac].nmbp012,g_nmbp_d[l_ac].nmbp013,g_nmbp_d[l_ac].nmbp004,g_nmbp_d[l_ac].nmbp007, 
          g_nmbp_d[l_ac].nmbpseq,g_nmbp_d[l_ac].nmbp014,g_nmbp3_d[l_ac].nmbp006,g_nmbp3_d[l_ac].nmbp005, 
          g_nmbp3_d[l_ac].nmbp007,g_nmbp3_d[l_ac].nmbpseq,g_nmbp3_d[l_ac].nmbpseq1,g_nmbp3_d[l_ac].nmbp014  
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
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF 
            EXIT FOREACH
         END IF
      
         LET l_ac = l_ac + 1      
      END FOREACH
      #調撥單明細抓取
      CALL anmt950_ins_tmp()
      CALL g_nmbp_d.clear()
      CALL g_nmbp3_d.clear()

      LET g_sql = " SELECT nmbp006,nmbp005,nmbp007,nmbx103,nmbo008, ",
                  "        nmbp0116,nmbp0117,nmbp0118,nmbp0119,balance, ",
                  "        '','','' ",
                  "   FROM anmt950_tmp2 ",
                  "  ORDER BY nmbp006,nmbp005 "
      PREPARE anmt950_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR anmt950_pb1 
      
      LET g_cnt = l_ac
      LET l_ac = 1      
      
      FOREACH b_fill_cs1 INTO g_nmbp3_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF      
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF 
            EXIT FOREACH
         END IF
      
         LET l_ac = l_ac + 1
         
      END FOREACH
 

      LET g_sql = " SELECT nmbpseq1,nmbp012,nmbp013,nmbp004,nmbnl003, ",
                  "        nmbo012,nmbp007,nmbp0110,nmbp0111,nmbp0112, ",
                  "        nmbp0113,nmbp0114,nmbp0115,'','' ",
                  "   FROM anmt950_tmp1 ",
                  "  WHERE nmbp005 = '",g_nmbp3_d[l_ac_b].nmbp005,"' ",   #調撥單明細隨所選的內部帳戶資訊變動
                  "  ORDER BY nmbpseq1,nmbp012,nmbp013 "

      PREPARE anmt950_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR anmt950_pb2 
      
      LET g_cnt = l_ac
      LET l_ac = 1      
      
      FOREACH b_fill_cs2 INTO g_nmbp_d[l_ac].*
      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF      

      
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_nmbp_d.deleteElement(g_nmbp_d.getLength())
   CALL g_nmbp3_d.deleteElement(g_nmbp3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt950_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmbp_d.getLength()
      LET g_nmbp_d_mask_o[l_ac].* =  g_nmbp_d[l_ac].*
      CALL anmt950_nmbp_t_mask()
      LET g_nmbp_d_mask_n[l_ac].* =  g_nmbp_d[l_ac].*
   END FOR
   
   LET g_nmbp3_d_mask_o.* =  g_nmbp3_d.*
   FOR l_ac = 1 TO g_nmbp3_d.getLength()
      LET g_nmbp3_d_mask_o[l_ac].* =  g_nmbp3_d[l_ac].*
      CALL anmt950_nmbp_t_mask()
      LET g_nmbp3_d_mask_n[l_ac].* =  g_nmbp3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt950_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM nmbp_t
       WHERE nmbpent = g_enterprise AND
         nmbpdocno = ps_keys_bak[1] AND nmbp001 = ps_keys_bak[2] AND nmbp002 = ps_keys_bak[3] AND nmbp003 = ps_keys_bak[4] AND nmbpseq = ps_keys_bak[5] AND nmbpseq1 = ps_keys_bak[6] AND nmbp014 = ps_keys_bak[7]
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
         CALL g_nmbp_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_nmbp3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt950_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO nmbp_t
                  (nmbpent,
                   nmbpdocno,nmbp001,nmbp002,nmbp003,
                   nmbpseq,nmbpseq1,nmbp014
                   ,nmbp012,nmbp013,nmbp004,nmbp007,nmbp006,nmbp005,nmbp007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7]
                   ,g_nmbp_d[g_detail_idx].nmbp012,g_nmbp_d[g_detail_idx].nmbp013,g_nmbp_d[g_detail_idx].nmbp004, 
                       g_nmbp_d[g_detail_idx].nmbp007,g_nmbp3_d[g_detail_idx].nmbp006,g_nmbp3_d[g_detail_idx].nmbp005, 
                       g_nmbp_d[g_detail_idx].nmbp007)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_nmbp_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_nmbp3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt950_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmbp_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL anmt950_nmbp_t_mask_restore('restore_mask_o')
               
      UPDATE nmbp_t 
         SET (nmbpdocno,nmbp001,nmbp002,nmbp003,
              nmbpseq,nmbpseq1,nmbp014
              ,nmbp012,nmbp013,nmbp004,nmbp007,nmbp006,nmbp005,nmbp007) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7]
              ,g_nmbp_d[g_detail_idx].nmbp012,g_nmbp_d[g_detail_idx].nmbp013,g_nmbp_d[g_detail_idx].nmbp004, 
                  g_nmbp_d[g_detail_idx].nmbp007,g_nmbp3_d[g_detail_idx].nmbp006,g_nmbp3_d[g_detail_idx].nmbp005, 
                  g_nmbp_d[g_detail_idx].nmbp007) 
         WHERE nmbpent = g_enterprise AND nmbpdocno = ps_keys_bak[1] AND nmbp001 = ps_keys_bak[2] AND nmbp002 = ps_keys_bak[3] AND nmbp003 = ps_keys_bak[4] AND nmbpseq = ps_keys_bak[5] AND nmbpseq1 = ps_keys_bak[6] AND nmbp014 = ps_keys_bak[7]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbp_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbp_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt950_nmbp_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt950_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt950.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt950_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt950.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt950_lock_b(ps_table,ps_page)
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
   #CALL anmt950_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "nmbp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt950_bcl USING g_enterprise,
                                       g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003, 
                                           g_nmbp_d[g_detail_idx].nmbpseq,g_nmbp_d[g_detail_idx].nmbpseq1, 
                                           g_nmbp_d[g_detail_idx].nmbp014     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt950_bcl:",SQLERRMESSAGE 
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
 
{<section id="anmt950.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt950_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt950_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt950_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("nmbzdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmbzdocno,nmbz001,nmbz002,nmbz003",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt950_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmbzdocno,nmbz001,nmbz002,nmbz003",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("nmbzdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt950_set_entry_b(p_cmd)
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
 
{<section id="anmt950.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt950_set_no_entry_b(p_cmd)
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
 
{<section id="anmt950.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt950_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   #iluym 2014/11/27 add---str
   CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
   #----add----end

   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt950_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #iluym 2014/11/27 add---str
   IF g_nmbz_m.nmbzstus <> "N" THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF
   #----add----end
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_nmbz_m.nmbzstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt950_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
 
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt950_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt950_default_search()
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
      LET ls_wc = ls_wc, " nmbzdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmbz001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " nmbz002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " nmbz003 = '", g_argv[04], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "nmbz_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbp_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
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
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt950_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmbz_m.nmbzdocno IS NULL
      OR g_nmbz_m.nmbz001 IS NULL      OR g_nmbz_m.nmbz002 IS NULL      OR g_nmbz_m.nmbz003 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmt950_cl USING g_enterprise,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003
   IF STATUS THEN
      CLOSE anmt950_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt950_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
       g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzowndp, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt, 
       g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT anmt950_action_chk() THEN
      CLOSE anmt950_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbz_m.nmbz001,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno, 
       g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzowndp_desc, 
       g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzcrtdt, 
       g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfid_desc, 
       g_nmbz_m.nmbzcnfdt
 
   CASE g_nmbz_m.nmbzstus
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
         CASE g_nmbz_m.nmbzstus
            
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_nmbz_m.nmbzstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#7 add
            RETURN   #151013-00016#7 151102 by sakura add

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt950_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt950_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt950_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt950_cl
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
      g_nmbz_m.nmbzstus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmt950_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmbz_m.nmbzstus = 'N' THEN
         CALL s_anmt950_conf_chk(g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')           #150401-00001#13
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               CALL s_anmt950_conf_upd(g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) RETURNING g_sub_success
               CALL cl_err_collect_show()
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF  
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_anmt950_unconf_chk(g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt950_unconf_upd(g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF   
   
   #151125-00001#3 ---add (S)---
   IF lc_state = "X" THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #151125-00001#3 ---add (E)---
   #end add-point
   
   LET g_nmbz_m.nmbzmodid = g_user
   LET g_nmbz_m.nmbzmoddt = cl_get_current()
   LET g_nmbz_m.nmbzstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmbz_t 
      SET (nmbzstus,nmbzmodid,nmbzmoddt) 
        = (g_nmbz_m.nmbzstus,g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmoddt)     
    WHERE nmbzent = g_enterprise AND nmbzdocno = g_nmbz_m.nmbzdocno
      AND nmbz001 = g_nmbz_m.nmbz001      AND nmbz002 = g_nmbz_m.nmbz002      AND nmbz003 = g_nmbz_m.nmbz003
    
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
      EXECUTE anmt950_master_referesh USING g_nmbz_m.nmbzdocno,g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003 INTO g_nmbz_m.nmbz001, 
          g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno,g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid, 
          g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdt,g_nmbz_m.nmbzmodid, 
          g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfdt,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbzownid_desc, 
          g_nmbz_m.nmbzowndp_desc,g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzmodid_desc, 
          g_nmbz_m.nmbzcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmbz_m.nmbz001,g_nmbz_m.nmbz001_desc,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbzdocno, 
          g_nmbz_m.nmbzstus,g_nmbz_m.nmbzownid,g_nmbz_m.nmbzownid_desc,g_nmbz_m.nmbzowndp,g_nmbz_m.nmbzowndp_desc, 
          g_nmbz_m.nmbzcrtid,g_nmbz_m.nmbzcrtid_desc,g_nmbz_m.nmbzcrtdp,g_nmbz_m.nmbzcrtdp_desc,g_nmbz_m.nmbzcrtdt, 
          g_nmbz_m.nmbzmodid,g_nmbz_m.nmbzmodid_desc,g_nmbz_m.nmbzmoddt,g_nmbz_m.nmbzcnfid,g_nmbz_m.nmbzcnfid_desc, 
          g_nmbz_m.nmbzcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmt950_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt950_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt950.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt950_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_nmbp_d.getLength() THEN
         LET g_detail_idx = g_nmbp_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbp_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbp_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_nmbp3_d.getLength() THEN
         LET g_detail_idx = g_nmbp3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbp3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbp3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt950_b_fill2(pi_idx)
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
   
   CALL anmt950_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt950_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt950.status_show" >}
PRIVATE FUNCTION anmt950_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt950.mask_functions" >}
&include "erp/anm/anmt950_mask.4gl"
 
{</section>}
 
{<section id="anmt950.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt950_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL anmt950_show()
   CALL anmt950_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmbz_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmbp_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_nmbp3_d))
 
 
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
   #CALL anmt950_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt950_ui_headershow()
   CALL anmt950_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt950_draw_out()
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
   CALL anmt950_ui_headershow()  
   CALL anmt950_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt950.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt950_set_pk_array()
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
   LET g_pk_array[1].values = g_nmbz_m.nmbzdocno
   LET g_pk_array[1].column = 'nmbzdocno'
   LET g_pk_array[2].values = g_nmbz_m.nmbz001
   LET g_pk_array[2].column = 'nmbz001'
   LET g_pk_array[3].values = g_nmbz_m.nmbz002
   LET g_pk_array[3].column = 'nmbz002'
   LET g_pk_array[4].values = g_nmbz_m.nmbz003
   LET g_pk_array[4].column = 'nmbz003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt950.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt950.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt950_msgcentre_notify(lc_state)
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
   CALL anmt950_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmbz_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt950.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt950_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#24 add-S
   SELECT nmbzstus  INTO g_nmbz_m.nmbzstus
     FROM nmbz_t
    WHERE nmbzent = g_enterprise
      AND nmbzdocno = g_nmbz_m.nmbzdocno
      AND nmbz001 = g_nmbz_m.nmbz001
      AND nmbz002 = g_nmbz_m.nmbz002
      AND nmbz003 = g_nmbz_m.nmbz003

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_nmbz_m.nmbzstus
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
        LET g_errparam.extend = g_nmbz_m.nmbzdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL anmt950_set_act_visible()
        CALL anmt950_set_act_no_visible()
        CALL anmt950_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#24 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt950.other_function" readonly="Y" >}

PRIVATE FUNCTION anmt950_create_tmp()
   #調撥單明細資料TEMP TABLE
   DROP TABLE anmt950_tmp1
   CREATE TEMP TABLE anmt950_tmp1(
    nmbpseq1       INTEGER,
    nmbp012        VARCHAR(20),
    nmbp013        INTEGER,
    nmbp004        VARCHAR(10),
    nmbnl003       VARCHAR(500),
    nmbo012        DATE,    
    nmbp007        VARCHAR(10),       #anmt950_tmp2 key
    nmbp0110       DECIMAL(20,6),
    nmbp0111       DECIMAL(20,6),
    nmbp0112       DECIMAL(20,6),
    nmbp0113       DECIMAL(20,6),
    nmbp0114       DECIMAL(20,6),
    nmbp0115       DECIMAL(20,6),
    nmbp011        DECIMAL(20,6),
    nmbp006        VARCHAR(10),       #anmt950_tmp2 key
    nmbp005        VARCHAR(10)     #anmt950_tmp2 key
   );
   
   #內部帳戶資訊TEMP TABLE
   DROP TABLE anmt950_tmp2
   CREATE TEMP TABLE anmt950_tmp2(
    nmbp006        VARCHAR(10),
    nmbp005        VARCHAR(10),
    nmbp007        VARCHAR(10),    
    nmbx103        DECIMAL(20,6),
    nmbo008        DECIMAL(20,6),
    nmbp0116       DECIMAL(20,6),
    nmbp0117       DECIMAL(20,6),
    nmbp0118       DECIMAL(20,6),
    nmbp0119       DECIMAL(20,6),
    balance        DECIMAL(20,6)
   );   
END FUNCTION

################################################################################
# Descriptions...: 撈取符合條件之nmbp資料,並寫入TEMP TABLE
# Memo...........:
# Usage..........: anmt950_ins_tmp()
#         
# Date & Author..: 14/09/02 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt950_ins_tmp()
   DEFINE l_sql       STRING
   DEFINE l_bdate     LIKE type_t.dat     #年度月份起始日期
   DEFINE l_edate     LIKE type_t.dat     #年度月份結束日期 
   DEFINE l_sum1      LIKE nmbp_t.nmbp011 
   DEFINE l_sum2      LIKE nmbp_t.nmbp011
   DEFINE l_tmp1  RECORD
             nmbpseq1      LIKE nmbp_t.nmbpseq1,
             nmbp012       LIKE nmbp_t.nmbp012,
             nmbp013       LIKE nmbp_t.nmbp013,
             nmbp004       LIKE nmbp_t.nmbp004,
             nmbnl003      LIKE nmbnl_t.nmbnl003,
             nmbo012       LIKE nmbo_t.nmbo012,             
             nmbp007       LIKE nmbp_t.nmbp007,  #anmt950_tmp2 key
             nmbp0110      LIKE nmbp_t.nmbp011,
             nmbp0111      LIKE nmbp_t.nmbp011,
             nmbp0112      LIKE nmbp_t.nmbp011,
             nmbp0113      LIKE nmbp_t.nmbp011,
             nmbp0114      LIKE nmbp_t.nmbp011,
             nmbp0115      LIKE nmbp_t.nmbp011,
             nmbp011       LIKE nmbp_t.nmbp011,
             nmbp006       LIKE nmbp_t.nmbp006,  #anmt950_tmp2 key
             nmbp005       LIKE nmbp_t.nmbp005  #anmt950_tmp2 key           
             END RECORD
   DEFINE l_tmp2  RECORD
             nmbp006       LIKE nmbp_t.nmbp006,
             nmbp005       LIKE nmbp_t.nmbp005,
             nmbp007       LIKE nmbp_t.nmbp007,    
             nmbx103       LIKE nmbx_t.nmbx103,
             nmbo008       LIKE nmbo_t.nmbo008,
             nmbp0116      LIKE nmbp_t.nmbp011,
             nmbp0117      LIKE nmbp_t.nmbp011,
             nmbp0118      LIKE nmbp_t.nmbp011,
             nmbp0119      LIKE nmbp_t.nmbp011,
             balance       LIKE nmbp_t.nmbp011 
             END RECORD
   DEFINE    l_nmbx103     LIKE nmbx_t.nmbx103
   DEFINE    l_nmbx104     LIKE nmbx_t.nmbx104
   DEFINE l_glaald         LIKE glaa_t.glaald  #160328-00020#11 add
   DEFINE l_success        LIKE type_t.num5    #160328-00020#11 add

   DELETE FROM anmt950_tmp1          
   DELETE FROM anmt950_tmp2 
   CALL s_date_get_ymtodate(g_nmbz_m.nmbz002,g_nmbz_m.nmbz003,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) RETURNING l_bdate,l_edate
             
   LET l_sql =" SELECT DISTINCT nmbpseq1,nmbp012,nmbp013,nmbp004,'', ",
              "        '',nmbp007,0,0,0, ",
#              "        0,0,0,nmbp011,nmbp006,nmbp005 ", #160328-00020#11 mark
              "        0,0,0,nmbp016,nmbp006,nmbp005 ", #160328-00020#11 add
              "   FROM nmbp_t ", 
              "  WHERE nmbpent = '",g_enterprise,"' ",
              "    AND nmbp001 = '",g_nmbz_m.nmbz001,"' ",
              "    AND nmbp002 = '",g_nmbz_m.nmbz002,"' ",
              "    AND nmbp003 = '",g_nmbz_m.nmbz003,"' "
              
   PREPARE anmt950_sel_nmbp_p FROM l_sql
   DECLARE anmt950_sel_nmbp_c CURSOR FOR anmt950_sel_nmbp_p
   
   FOREACH anmt950_sel_nmbp_c INTO l_tmp1.*

      ###調度說明###
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_tmp1.nmbp004
      CALL ap_ref_array2(g_ref_fields,"SELECT nmbnl003 FROM nmbnl_t WHERE nmbnlent='"||g_enterprise||"' AND nmbnl001=? AND nmbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_tmp1.nmbnl003 = '', g_rtn_fields[1] , ''      
      ###出入帳日期###
      IF l_tmp1.nmbp011 < 0 THEN 
         SELECT nmbg012 INTO l_tmp1.nmbo012 FROM nmbg_t 
          WHERE nmbgent = g_enterprise 
            AND nmbgdocno = l_tmp1.nmbp012  #本筆調度單號
            AND nmbgseq = l_tmp1.nmbp013    #本筆調度項次
      ELSE 
         SELECT nmbo012 INTO l_tmp1.nmbo012 FROM nmbo_t 
          WHERE nmboent = g_enterprise
            AND nmbodocno = l_tmp1.nmbp012  #本筆調度單號
            AND nmboseq = l_tmp1.nmbp013    #本筆調度項次             
      END IF       
      ###前期利息小計###
#      SELECT SUM(nmbp011) INTO l_tmp1.nmbp0110 FROM nmbp_t #160328-00020#11 mark
      SELECT SUM(nmbp016) INTO l_tmp1.nmbp0110 FROM nmbp_t  #160328-00020#11 add
       WHERE nmbpent = g_enterprise
         AND (nmbp002 < g_nmbz_m.nmbz002 OR                                  #小於條件年月
             (nmbp002 = g_nmbz_m.nmbz002 AND nmbp003 < g_nmbz_m.nmbz003))    #(含條件年以前,及同年但月份比條件月份小的資料)
         AND nmbp012 = l_tmp1.nmbp012
         AND nmbp013 = l_tmp1.nmbp013 
         AND nmbpseq1= l_tmp1.nmbpseq1
         AND nmbp005= l_tmp1.nmbp005
      IF cl_null(l_tmp1.nmbp0110)THEN LET l_tmp1.nmbp0110 = 0 END IF
   
      LET l_sum1 = 0
      LET l_sum2 = 0
      #本筆調度單號+項次撈出的利息收入合計
#      SELECT SUM(nmbp011) INTO l_sum1 FROM nmbp_t  #160328-00020#11 mark
      SELECT SUM(nmbp016) INTO l_sum1 FROM nmbp_t   #160328-00020#11 add
       WHERE nmbpent = g_enterprise   #2015/04/02 by 02599 add
         AND nmbp012 = l_tmp1.nmbp012   
         AND nmbp013 = l_tmp1.nmbp013
#         AND nmbp011 > 0                   #表示利息收入 #160328-00020#11 mark
         AND nmbp016 > 0                   #表示利息收入  #160328-00020#11 add
         AND nmbp002 = g_nmbz_m.nmbz002
         AND nmbp003 = g_nmbz_m.nmbz003
         AND nmbpseq1= l_tmp1.nmbpseq1  
         AND nmbp005= l_tmp1.nmbp005
      IF cl_null(l_sum1) THEN LET l_sum1 = 0 END IF         
         
      #本筆調度單號+項次撈出的利息支出合計
#      SELECT SUM(nmbp011) INTO l_sum2 FROM nmbp_t #160328-00020#11 mark
      SELECT SUM(nmbp016) INTO l_sum2 FROM nmbp_t  #160328-00020#11 add 
       WHERE nmbpent = g_enterprise   #2015/04/02 by 02599 add
         AND nmbp012 = l_tmp1.nmbp012   
         AND nmbp013 = l_tmp1.nmbp013
#         AND nmbp011 < 0                   #表示利息支出 #160328-00020#11 mark 
         AND nmbp016 < 0                   #表示利息支出  #160328-00020#11 add
         AND nmbp002 = g_nmbz_m.nmbz002
         AND nmbp003 = g_nmbz_m.nmbz003
         AND nmbpseq1= l_tmp1.nmbpseq1  
         AND nmbp005= l_tmp1.nmbp005         
      IF cl_null(l_sum2) THEN LET l_sum2 = 0 END IF                  

      CASE 
         #出入帳日期年月 小於 條件年月區間==>屬於前期利息
         WHEN l_tmp1.nmbo012 < l_bdate
            LET l_tmp1.nmbp0111 = l_sum1
            ###前期利息收入###
            LET l_tmp1.nmbp0112 = l_sum2
            ###前期利息支出###      
         #出入帳日期年月 屬於 條件年月區間==>屬於本期利息
         WHEN l_tmp1.nmbo012 >= l_bdate AND l_tmp1.nmbo012 <= l_edate
            ###本期利息收入###
            LET l_tmp1.nmbp0113 = l_sum1  
            ###本期利息支出###
            LET l_tmp1.nmbp0114 = l_sum2            
      END CASE
      
      ###累積利息金額###
#      SELECT SUM(nmbp011) INTO l_tmp1.nmbp0115 FROM nmbp_t #160328-00020#11 mark
      SELECT SUM(nmbp016) INTO l_tmp1.nmbp0115 FROM nmbp_t  #160328-00020#11 add
       WHERE nmbpent = g_enterprise   #2015/04/02 by 02599 add
         AND nmbp012 = l_tmp1.nmbp012
         AND nmbp013 = l_tmp1.nmbp013
         AND nmbpseq1= l_tmp1.nmbpseq1
         AND nmbp005= l_tmp1.nmbp005
         
      INSERT INTO anmt950_tmp1 VALUES(l_tmp1.*)         
      
   END FOREACH
   
   LET l_sql =" SELECT DISTINCT nmbp006,nmbp005,nmbp007,0,0,0,0,0,0,0 ",
              "   FROM nmbp_t ", 
              "  WHERE nmbpent = '",g_enterprise,"' ",
              "    AND nmbp001 = '",g_nmbz_m.nmbz001,"' ",
              "    AND nmbp002 = '",g_nmbz_m.nmbz002,"' ",
              "    AND nmbp003 = '",g_nmbz_m.nmbz003,"' ",
              "    AND nmbp006 IN (SELECT nmbp006 FROM anmt950_tmp1) ",
              "    AND nmbp005 IN (SELECT nmbp005 FROM anmt950_tmp1) ",
              "  ORDER BY nmbp006,nmbp005 "
 
   PREPARE anmt950_sel_nmbp_p2 FROM l_sql
   DECLARE anmt950_sel_nmbp_c2 CURSOR FOR anmt950_sel_nmbp_p2

   FOREACH anmt950_sel_nmbp_c2 INTO l_tmp2.*
      ###期初餘額###
      #取上一期的帳戶月統計檔 
      LET l_nmbx103 = 0
      LET l_nmbx104 = 0
      SELECT SUM(nmbx103),SUM(nmbx104) INTO l_nmbx103,l_nmbx104 FROM nmbx_t 
       WHERE nmbxent = g_enterprise
         AND nmbx001 = g_nmbz_m.nmbz002
         AND nmbx002 < g_nmbz_m.nmbz003
         AND nmbx003 = l_tmp2.nmbp005   
      IF cl_null(l_nmbx103) THEN LET l_nmbx103 = 0 END IF
      IF cl_null(l_nmbx104) THEN LET l_nmbx104 = 0 END IF
      LET l_tmp2.nmbx103 = l_nmbx103 - l_nmbx104        
         
      ###本期新增存款###
      LET l_sum1 = 0
      LET l_sum2 = 0   
      SELECT SUM(nmbo008) INTO l_sum1 FROM nmbo_t 
       WHERE nmboent = g_enterprise   #2015/04/02 by 02599 add
         AND nmbo012 >= l_bdate
         AND nmbo012 <= l_edate    
         AND nmbo005 = l_tmp2.nmbp005
         AND nmboseq2 < 200           #160328-00020#11 add 排除费用金额
      IF cl_null(l_sum1) THEN LET l_sum1 = 0 END IF         
   
      SELECT SUM(nmbg008) INTO l_sum2 FROM nmbg_t 
       WHERE nmbgent = g_enterprise   #2015/04/02 by 02599 add
         AND nmbg012 >= l_bdate
         AND nmbg012 <= l_edate    
         AND nmbg005 = l_tmp2.nmbp005
      IF cl_null(l_sum2) THEN LET l_sum2 = 0 END IF             
   
      LET l_tmp2.nmbo008 = l_sum1 - l_sum2   
      ###前期單據利息收入、前期單據利息支出、本期單據利息收入、本期單據利息支出###
      SELECT SUM(nmbp0111),SUM(nmbp0112),SUM(nmbp0113),SUM(nmbp0114) 
        INTO l_tmp2.nmbp0116,l_tmp2.nmbp0117,l_tmp2.nmbp0118,l_tmp2.nmbp0119
        FROM anmt950_tmp1
       WHERE nmbp006 = l_tmp2.nmbp006
         AND nmbp005 = l_tmp2.nmbp005
         AND nmbp007 = l_tmp2.nmbp007
       
      IF cl_null(l_tmp2.nmbp0116) THEN LET l_tmp2.nmbp0116 = 0 END IF
      IF cl_null(l_tmp2.nmbp0117) THEN LET l_tmp2.nmbp0117 = 0 END IF
      IF cl_null(l_tmp2.nmbp0118) THEN LET l_tmp2.nmbp0118 = 0 END IF
      IF cl_null(l_tmp2.nmbp0119) THEN LET l_tmp2.nmbp0119 = 0 END IF
      
      #160328-00020#11--add--str--
      #由于抓取的利息金额是没有按照币别取位的，故此处要做取位操作
      SELECT glaald INTO l_glaald
        FROM glaa_t
       WHERE glaaent=g_enterprise AND glaa014='Y'
         AND glaacomp=(SELECT ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_tmp2.nmbp006) 
      CALL s_curr_round_ld('1',l_glaald,l_tmp2.nmbp007,l_tmp2.nmbp0116,2) RETURNING l_success,g_errno,l_tmp2.nmbp0116
      CALL s_curr_round_ld('1',l_glaald,l_tmp2.nmbp007,l_tmp2.nmbp0117,2) RETURNING l_success,g_errno,l_tmp2.nmbp0117
      CALL s_curr_round_ld('1',l_glaald,l_tmp2.nmbp007,l_tmp2.nmbp0118,2) RETURNING l_success,g_errno,l_tmp2.nmbp0118
      CALL s_curr_round_ld('1',l_glaald,l_tmp2.nmbp007,l_tmp2.nmbp0119,2) RETURNING l_success,g_errno,l_tmp2.nmbp0119
      #160328-00020#11--add--end
      
      ###期末餘額###
      #期末餘額 = 期初餘額 + 本期新增存款 + 前期單據利息收入 + 前期單據利息支出 + 本期單據利息收入 + 本期單據利息支出
      LET l_tmp2.balance = l_tmp2.nmbx103+l_tmp2.nmbo008+l_tmp2.nmbp0116+l_tmp2.nmbp0117+l_tmp2.nmbp0118+l_tmp2.nmbp0119
      
      INSERT INTO anmt950_tmp2 VALUES(l_tmp2.*)     
            
   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 编辑后立即审核
# Memo...........:
# Usage..........: CALL anmt950_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/08 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt950_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glaald          LIKE glaa_t.glaald
 
   SELECT glaald INTO l_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaacomp = g_nmbz_m.nmbz001
      AND glaa014 = 'Y'
   IF cl_null(l_glaald)           THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbz_m.nmbz001)   THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbz_m.nmbz002)   THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbz_m.nmbz003)   THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbz_m.nmbzdocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmbp_t WHERE nmbpent = g_enterprise
      AND nmbpdocno = g_nmbz_m.nmbzdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmbz_m.nmbzdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(l_glaald,g_nmbz_m.nmbz001,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
        
   IF NOT s_anmt950_conf_chk(g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_anmt950_conf_upd(g_nmbz_m.nmbz001,g_nmbz_m.nmbz002,g_nmbz_m.nmbz003) THEN
      LET l_doc_success = FALSE
   END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_nmbz_m.nmbzmoddt = cl_get_current()
   LET g_nmbz_m.nmbzcnfdt = cl_get_current()
   UPDATE nmbz_t SET nmbzstus = 'Y',
                     nmbzmodid= g_user,
                     nmbzmoddt= g_nmbz_m.nmbzmoddt,
                     nmbzcnfid= g_user,
                     nmbzcnfdt= g_nmbz_m.nmbzcnfdt
    WHERE nmbzent = g_enterprise 
      AND nmbzdocno = g_nmbz_m.nmbzdocno
      AND nmbz001 = g_nmbz_m.nmbz001
      AND nmbz002 = g_nmbz_m.nmbz002
      AND nmbz003 = g_nmbz_m.nmbz003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#3--e
END FUNCTION

 
{</section>}
 
