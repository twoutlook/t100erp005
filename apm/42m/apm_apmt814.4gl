#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt814.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-07-24 10:18:07), PR版次:0012(2016-09-21 12:10:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000413
#+ Filename...: apmt814
#+ Description: 供應商績效評核綜合得分調整作業
#+ Creator....: 01752(2013-07-01 00:00:00)
#+ Modifier...: 02159 -SD/PR- 06814
 
{</section>}
 
{<section id="apmt814.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#37 2016/03/29 By 07900   重复错误讯息修改
#160308-00010#19 2016/06/08 By Jessica    修正 需先按抽單/拒絕才能修改/刪除
#160812-00017#8  2016/08/16 By 06137      在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#28 2016/08/29 By 08742      删除修改未重新判断状态码
#160824-00007#16 2016/09/14 By 06814      舊值備份處理
#160905-00014#1  2016/09/21 By lixiang 传入单号时，开启画面自动显示该单号的资料
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
PRIVATE type type_g_pmcl_m        RECORD
       pmcldocno LIKE pmcl_t.pmcldocno, 
   pmcldocdt LIKE pmcl_t.pmcldocdt, 
   pmcl001 LIKE pmcl_t.pmcl001, 
   pmcl001_desc LIKE type_t.chr80, 
   pmcl002 LIKE pmcl_t.pmcl002, 
   pmcl002_desc LIKE type_t.chr80, 
   pmclstus LIKE pmcl_t.pmclstus, 
   pmclownid LIKE pmcl_t.pmclownid, 
   pmclownid_desc LIKE type_t.chr80, 
   pmclowndp LIKE pmcl_t.pmclowndp, 
   pmclowndp_desc LIKE type_t.chr80, 
   pmclcrtid LIKE pmcl_t.pmclcrtid, 
   pmclcrtid_desc LIKE type_t.chr80, 
   pmclcrtdp LIKE pmcl_t.pmclcrtdp, 
   pmclcrtdp_desc LIKE type_t.chr80, 
   pmclcrtdt LIKE pmcl_t.pmclcrtdt, 
   pmclmodid LIKE pmcl_t.pmclmodid, 
   pmclmodid_desc LIKE type_t.chr80, 
   pmclmoddt LIKE pmcl_t.pmclmoddt, 
   pmclcnfid LIKE pmcl_t.pmclcnfid, 
   pmclcnfid_desc LIKE type_t.chr80, 
   pmclcnfdt LIKE pmcl_t.pmclcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmcm_d        RECORD
       pmcmseq LIKE pmcm_t.pmcmseq, 
   pmcm001 LIKE pmcm_t.pmcm001, 
   pmcm001_desc LIKE type_t.chr500, 
   pmcm002 LIKE pmcm_t.pmcm002, 
   pmcm003 LIKE pmcm_t.pmcm003, 
   pmcm003_desc LIKE type_t.chr500, 
   pmcm004 LIKE pmcm_t.pmcm004, 
   pmcm005 LIKE pmcm_t.pmcm005, 
   pmcf003 LIKE type_t.chr500, 
   pmcf003_desc LIKE type_t.chr500, 
   pmcm007 LIKE pmcm_t.pmcm007, 
   pmcm006 LIKE pmcm_t.pmcm006, 
   pmcm008 LIKE pmcm_t.pmcm008, 
   pmcm008_desc LIKE type_t.chr500, 
   pmcm009 LIKE pmcm_t.pmcm009, 
   pmcm009_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmcldocno LIKE pmcl_t.pmcldocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag                LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmcl_m          type_g_pmcl_m
DEFINE g_pmcl_m_t        type_g_pmcl_m
DEFINE g_pmcl_m_o        type_g_pmcl_m
DEFINE g_pmcl_m_mask_o   type_g_pmcl_m #轉換遮罩前資料
DEFINE g_pmcl_m_mask_n   type_g_pmcl_m #轉換遮罩後資料
 
   DEFINE g_pmcldocno_t LIKE pmcl_t.pmcldocno
 
 
DEFINE g_pmcm_d          DYNAMIC ARRAY OF type_g_pmcm_d
DEFINE g_pmcm_d_t        type_g_pmcm_d
DEFINE g_pmcm_d_o        type_g_pmcm_d
DEFINE g_pmcm_d_mask_o   DYNAMIC ARRAY OF type_g_pmcm_d #轉換遮罩前資料
DEFINE g_pmcm_d_mask_n   DYNAMIC ARRAY OF type_g_pmcm_d #轉換遮罩後資料
 
 
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
 
{<section id="apmt814.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_flag = FALSE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmcldocno,pmcldocdt,pmcl001,'',pmcl002,'',pmclstus,pmclownid,'',pmclowndp, 
       '',pmclcrtid,'',pmclcrtdp,'',pmclcrtdt,pmclmodid,'',pmclmoddt,pmclcnfid,'',pmclcnfdt", 
                      " FROM pmcl_t",
                      " WHERE pmclent= ? AND pmcldocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt814_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmcldocno,t0.pmcldocdt,t0.pmcl001,t0.pmcl002,t0.pmclstus,t0.pmclownid, 
       t0.pmclowndp,t0.pmclcrtid,t0.pmclcrtdp,t0.pmclcrtdt,t0.pmclmodid,t0.pmclmoddt,t0.pmclcnfid,t0.pmclcnfdt, 
       t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011", 
 
               " FROM pmcl_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmcl001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmcl002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.pmclownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.pmclowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.pmclcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmclcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.pmclmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.pmclcnfid  ",
 
               " WHERE t0.pmclent = " ||g_enterprise|| " AND t0.pmcldocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt814_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt814 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt814_init()   
 
      #進入選單 Menu (="N")
      CALL apmt814_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt814
      
   END IF 
   
   CLOSE apmt814_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt814.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt814_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('pmclstus','13','Y,N,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL apmt814_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt814.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt814_ui_dialog()
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL apmt814_insert()
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
         INITIALIZE g_pmcl_m.* TO NULL
         CALL g_pmcm_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt814_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_pmcm_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt814_idx_chk()
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
               CALL apmt814_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmm800
                  LET g_action_choice="prog_apmm800"
                  IF cl_auth_chk_act("prog_apmm800") THEN
                     
                     #add-point:ON ACTION prog_apmm800 name="menu.detail_show.page1_sub.prog_apmm800"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmm800'
               LET la_param.param[1] = g_pmcm_d[l_ac].pmcm001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmi810
                  LET g_action_choice="prog_apmi810"
                  IF cl_auth_chk_act("prog_apmi810") THEN
                     
                     #add-point:ON ACTION prog_apmi810 name="menu.detail_show.page1_sub.prog_apmi810"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmi810'
               LET la_param.param[1] = g_pmcm_d[l_ac].pmcm002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_arti202
                  LET g_action_choice="prog_arti202"
                  IF cl_auth_chk_act("prog_arti202") THEN
                     
                     #add-point:ON ACTION prog_arti202 name="menu.detail_show.page1_sub.prog_arti202"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'arti202'
               LET la_param.param[1] = g_pmcm_d[l_ac].pmcm003

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
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmt814_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL apmt814_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt814_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt814_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt814_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt814_set_act_visible()   
            CALL apmt814_set_act_no_visible()
            IF NOT (g_pmcl_m.pmcldocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmclent = " ||g_enterprise|| " AND",
                                  " pmcldocno = '", g_pmcl_m.pmcldocno, "' "
 
               #填到對應位置
               CALL apmt814_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pmcl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmcm_t" 
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
               CALL apmt814_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmcl_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmcm_t" 
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
                  CALL apmt814_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt814_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt814_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt814_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt814_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt814_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt814_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt814_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt814_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt814_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt814_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt814_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmcm_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               CALL apmt814_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt814_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt814_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt814_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apm/apmt814_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apm/apmt814_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt814_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmcl001
            LET g_action_choice="prog_pmcl001"
            IF cl_auth_chk_act("prog_pmcl001") THEN
               
               #add-point:ON ACTION prog_pmcl001 name="menu.prog_pmcl001"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_pmcl_m.pmcl001)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt814_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt814_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt814_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_pmcl_m.pmcldocdt)
 
 
 
         
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
 
{<section id="apmt814.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt814_browser_fill(ps_page_action)
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmcldocno ",
                      " FROM pmcl_t ",
                      " ",
                      " LEFT JOIN pmcm_t ON pmcment = pmclent AND pmcldocno = pmcmdocno ", "  ",
                      #add-point:browser_fill段sql(pmcm_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE pmclent = " ||g_enterprise|| " AND pmcment = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmcl_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmcldocno ",
                      " FROM pmcl_t ", 
                      "  ",
                      "  ",
                      " WHERE pmclent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmcl_t")
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
      INITIALIZE g_pmcl_m.* TO NULL
      CALL g_pmcm_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmcldocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmclstus,t0.pmcldocno ",
                  " FROM pmcl_t t0",
                  "  ",
                  "  LEFT JOIN pmcm_t ON pmcment = pmclent AND pmcldocno = pmcmdocno ", "  ", 
                  #add-point:browser_fill段sql(pmcm_t1) name="browser_fill.join.pmcm_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.pmclent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmcl_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmclstus,t0.pmcldocno ",
                  " FROM pmcl_t t0",
                  "  ",
                  
                  " WHERE t0.pmclent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmcl_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmcldocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmcl_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmcldocno
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
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_pmcldocno) THEN
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
 
{<section id="apmt814.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt814_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmcl_m.pmcldocno = g_browser[g_current_idx].b_pmcldocno   
 
   EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
       g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid, 
       g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp_desc, 
       g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclcnfid_desc 
 
   
   CALL apmt814_pmcl_t_mask()
   CALL apmt814_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt814.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt814_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt814_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmcldocno = g_pmcl_m.pmcldocno 
 
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
 
{<section id="apmt814.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt814_construct()
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
   INITIALIZE g_pmcl_m.* TO NULL
   CALL g_pmcm_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON pmcldocno,pmcldocdt,pmcl001,pmcl002,pmclstus,pmclownid,pmclowndp,pmclcrtid, 
          pmclcrtdp,pmclcrtdt,pmclmodid,pmclmoddt,pmclcnfid,pmclcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmclcrtdt>>----
         AFTER FIELD pmclcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmclmoddt>>----
         AFTER FIELD pmclmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmclcnfdt>>----
         AFTER FIELD pmclcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmclpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmcldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcldocno
            #add-point:ON ACTION controlp INFIELD pmcldocno name="construct.c.pmcldocno"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_pmcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcldocno  #顯示到畫面上

            NEXT FIELD pmcldocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcldocno
            #add-point:BEFORE FIELD pmcldocno name="construct.b.pmcldocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcldocno
            
            #add-point:AFTER FIELD pmcldocno name="construct.a.pmcldocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcldocdt
            #add-point:BEFORE FIELD pmcldocdt name="construct.b.pmcldocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcldocdt
            
            #add-point:AFTER FIELD pmcldocdt name="construct.a.pmcldocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcldocdt
            #add-point:ON ACTION controlp INFIELD pmcldocdt name="construct.c.pmcldocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmcl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcl001
            #add-point:ON ACTION controlp INFIELD pmcl001 name="construct.c.pmcl001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #CALL q_ooag001_2()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            CALL q_ooag001_4()                           #呼叫開窗    #151228-00009#1 20151230 add by beckxie
            DISPLAY g_qryparam.return1 TO pmcl001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD pmcl001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcl001
            #add-point:BEFORE FIELD pmcl001 name="construct.b.pmcl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcl001
            
            #add-point:AFTER FIELD pmcl001 name="construct.a.pmcl001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcl002
            #add-point:ON ACTION controlp INFIELD pmcl002 name="construct.c.pmcl002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcl002  #顯示到畫面上

            NEXT FIELD pmcl002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcl002
            #add-point:BEFORE FIELD pmcl002 name="construct.b.pmcl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcl002
            
            #add-point:AFTER FIELD pmcl002 name="construct.a.pmcl002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclstus
            #add-point:BEFORE FIELD pmclstus name="construct.b.pmclstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclstus
            
            #add-point:AFTER FIELD pmclstus name="construct.a.pmclstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmclstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclstus
            #add-point:ON ACTION controlp INFIELD pmclstus name="construct.c.pmclstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmclownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclownid
            #add-point:ON ACTION controlp INFIELD pmclownid name="construct.c.pmclownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmclownid  #顯示到畫面上

            NEXT FIELD pmclownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclownid
            #add-point:BEFORE FIELD pmclownid name="construct.b.pmclownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclownid
            
            #add-point:AFTER FIELD pmclownid name="construct.a.pmclownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmclowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclowndp
            #add-point:ON ACTION controlp INFIELD pmclowndp name="construct.c.pmclowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmclowndp  #顯示到畫面上

            NEXT FIELD pmclowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclowndp
            #add-point:BEFORE FIELD pmclowndp name="construct.b.pmclowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclowndp
            
            #add-point:AFTER FIELD pmclowndp name="construct.a.pmclowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmclcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclcrtid
            #add-point:ON ACTION controlp INFIELD pmclcrtid name="construct.c.pmclcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmclcrtid  #顯示到畫面上

            NEXT FIELD pmclcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclcrtid
            #add-point:BEFORE FIELD pmclcrtid name="construct.b.pmclcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclcrtid
            
            #add-point:AFTER FIELD pmclcrtid name="construct.a.pmclcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmclcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclcrtdp
            #add-point:ON ACTION controlp INFIELD pmclcrtdp name="construct.c.pmclcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmclcrtdp  #顯示到畫面上

            NEXT FIELD pmclcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclcrtdp
            #add-point:BEFORE FIELD pmclcrtdp name="construct.b.pmclcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclcrtdp
            
            #add-point:AFTER FIELD pmclcrtdp name="construct.a.pmclcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclcrtdt
            #add-point:BEFORE FIELD pmclcrtdt name="construct.b.pmclcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmclmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclmodid
            #add-point:ON ACTION controlp INFIELD pmclmodid name="construct.c.pmclmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmclmodid  #顯示到畫面上

            NEXT FIELD pmclmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclmodid
            #add-point:BEFORE FIELD pmclmodid name="construct.b.pmclmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclmodid
            
            #add-point:AFTER FIELD pmclmodid name="construct.a.pmclmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclmoddt
            #add-point:BEFORE FIELD pmclmoddt name="construct.b.pmclmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmclcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclcnfid
            #add-point:ON ACTION controlp INFIELD pmclcnfid name="construct.c.pmclcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmclcnfid  #顯示到畫面上

            NEXT FIELD pmclcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclcnfid
            #add-point:BEFORE FIELD pmclcnfid name="construct.b.pmclcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclcnfid
            
            #add-point:AFTER FIELD pmclcnfid name="construct.a.pmclcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclcnfdt
            #add-point:BEFORE FIELD pmclcnfdt name="construct.b.pmclcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmcmseq,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm007,pmcm006,pmcm008, 
          pmcm009
           FROM s_detail1[1].pmcmseq,s_detail1[1].pmcm001,s_detail1[1].pmcm002,s_detail1[1].pmcm003, 
               s_detail1[1].pmcm004,s_detail1[1].pmcm005,s_detail1[1].pmcm007,s_detail1[1].pmcm006,s_detail1[1].pmcm008, 
               s_detail1[1].pmcm009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcmseq
            #add-point:BEFORE FIELD pmcmseq name="construct.b.page1.pmcmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcmseq
            
            #add-point:AFTER FIELD pmcmseq name="construct.a.page1.pmcmseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcmseq
            #add-point:ON ACTION controlp INFIELD pmcmseq name="construct.c.page1.pmcmseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmcm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm001
            #add-point:ON ACTION controlp INFIELD pmcm001 name="construct.c.page1.pmcm001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_pmck003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcm001  #顯示到畫面上


            NEXT FIELD pmcm001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm001
            #add-point:BEFORE FIELD pmcm001 name="construct.b.page1.pmcm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm001
            
            #add-point:AFTER FIELD pmcm001 name="construct.a.page1.pmcm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm002
            #add-point:ON ACTION controlp INFIELD pmcm002 name="construct.c.page1.pmcm002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_pmck001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcm002  #顯示到畫面上


            NEXT FIELD pmcm002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm002
            #add-point:BEFORE FIELD pmcm002 name="construct.b.page1.pmcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm002
            
            #add-point:AFTER FIELD pmcm002 name="construct.a.page1.pmcm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm003
            #add-point:ON ACTION controlp INFIELD pmcm003 name="construct.c.page1.pmcm003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_pmck002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcm003  #顯示到畫面上

            NEXT FIELD pmcm003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm003
            #add-point:BEFORE FIELD pmcm003 name="construct.b.page1.pmcm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm003
            
            #add-point:AFTER FIELD pmcm003 name="construct.a.page1.pmcm003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm004
            #add-point:BEFORE FIELD pmcm004 name="construct.b.page1.pmcm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm004
            
            #add-point:AFTER FIELD pmcm004 name="construct.a.page1.pmcm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm004
            #add-point:ON ACTION controlp INFIELD pmcm004 name="construct.c.page1.pmcm004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm005
            #add-point:BEFORE FIELD pmcm005 name="construct.b.page1.pmcm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm005
            
            #add-point:AFTER FIELD pmcm005 name="construct.a.page1.pmcm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm005
            #add-point:ON ACTION controlp INFIELD pmcm005 name="construct.c.page1.pmcm005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm007
            #add-point:BEFORE FIELD pmcm007 name="construct.b.page1.pmcm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm007
            
            #add-point:AFTER FIELD pmcm007 name="construct.a.page1.pmcm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm007
            #add-point:ON ACTION controlp INFIELD pmcm007 name="construct.c.page1.pmcm007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm006
            #add-point:BEFORE FIELD pmcm006 name="construct.b.page1.pmcm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm006
            
            #add-point:AFTER FIELD pmcm006 name="construct.a.page1.pmcm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm006
            #add-point:ON ACTION controlp INFIELD pmcm006 name="construct.c.page1.pmcm006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmcm008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm008
            #add-point:ON ACTION controlp INFIELD pmcm008 name="construct.c.page1.pmcm008"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2053'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcm008  #顯示到畫面上

            NEXT FIELD pmcm008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm008
            #add-point:BEFORE FIELD pmcm008 name="construct.b.page1.pmcm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm008
            
            #add-point:AFTER FIELD pmcm008 name="construct.a.page1.pmcm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcm009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm009
            #add-point:ON ACTION controlp INFIELD pmcm009 name="construct.c.page1.pmcm009"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2054'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcm009  #顯示到畫面上

            NEXT FIELD pmcm009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm009
            #add-point:BEFORE FIELD pmcm009 name="construct.b.page1.pmcm009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm009
            
            #add-point:AFTER FIELD pmcm009 name="construct.a.page1.pmcm009"
            
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "pmcl_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmcm_t" 
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
 
{<section id="apmt814.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt814_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_pmcm_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt814_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt814_browser_fill("")
      CALL apmt814_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL apmt814_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt814_fetch("F") 
      #顯示單身筆數
      CALL apmt814_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt814_fetch(p_flag)
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_pmcl_m.pmcldocno = g_browser[g_current_idx].b_pmcldocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
       g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid, 
       g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp_desc, 
       g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclcnfid_desc 
 
   
   #遮罩相關處理
   LET g_pmcl_m_mask_o.* =  g_pmcl_m.*
   CALL apmt814_pmcl_t_mask()
   LET g_pmcl_m_mask_n.* =  g_pmcl_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt814_set_act_visible()   
   CALL apmt814_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
  #160308-00010#19-S
  #IF g_pmcl_m.pmclstus = 'N' THEN                 
  #   CALL cl_set_act_visible("modify,delete",TRUE)
  #ELSE
  #160308-00010#19-E 
   IF g_pmcl_m.pmclstus NOT MATCHES "[NDR]" THEN      #160308-00010#19 add
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmcl_m_t.* = g_pmcl_m.*
   LET g_pmcl_m_o.* = g_pmcl_m.*
   
   LET g_data_owner = g_pmcl_m.pmclownid      
   LET g_data_dept  = g_pmcl_m.pmclowndp
   
   #重新顯示   
   CALL apmt814_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt814_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   #ken---add---e
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmcm_d.clear()   
 
 
   INITIALIZE g_pmcl_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmcldocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmcl_m.pmclownid = g_user
      LET g_pmcl_m.pmclowndp = g_dept
      LET g_pmcl_m.pmclcrtid = g_user
      LET g_pmcl_m.pmclcrtdp = g_dept 
      LET g_pmcl_m.pmclcrtdt = cl_get_current()
      LET g_pmcl_m.pmclmodid = g_user
      LET g_pmcl_m.pmclmoddt = cl_get_current()
      LET g_pmcl_m.pmclstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmcl_m.pmclstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_pmcl_m.pmcldocdt = g_today
      LET g_pmcl_m.pmcl001 = g_user
      SELECT ooag003 INTO g_pmcl_m.pmcl002 FROM ooag_t
       WHERE ooag001 = g_pmcl_m.pmcl001 AND ooagent = g_enterprise

      CALL apmt814_pmcl001_desc()
      #ken---add---s 需求單號：141125-00002 項次：4
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_pmcl_m.pmcldocno = l_doctype      
      #ken---add---e
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmcl_m_t.* = g_pmcl_m.*
      LET g_pmcl_m_o.* = g_pmcl_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmcl_m.pmclstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
 
 
 
    
      CALL apmt814_input("a")
      
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
         INITIALIZE g_pmcl_m.* TO NULL
         INITIALIZE g_pmcm_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt814_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmcm_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt814_set_act_visible()   
   CALL apmt814_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmclent = " ||g_enterprise|| " AND",
                      " pmcldocno = '", g_pmcl_m.pmcldocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt814_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt814_cl
   
   CALL apmt814_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
       g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid, 
       g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp_desc, 
       g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_pmcl_m_mask_o.* =  g_pmcl_m.*
   CALL apmt814_pmcl_t_mask()
   LET g_pmcl_m_mask_n.* =  g_pmcl_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002, 
       g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp, 
       g_pmcl_m.pmclowndp_desc,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdp_desc, 
       g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfid_desc,g_pmcl_m.pmclcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmcl_m.pmclownid      
   LET g_data_dept  = g_pmcl_m.pmclowndp
   
   #功能已完成,通報訊息中心
   CALL apmt814_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt814_modify()
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
   LET g_pmcl_m_t.* = g_pmcl_m.*
   LET g_pmcl_m_o.* = g_pmcl_m.*
   
   IF g_pmcl_m.pmcldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
   CALL s_transaction_begin()
   
   OPEN apmt814_cl USING g_enterprise,g_pmcl_m.pmcldocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt814_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt814_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
       g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid, 
       g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp_desc, 
       g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT apmt814_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmcl_m_mask_o.* =  g_pmcl_m.*
   CALL apmt814_pmcl_t_mask()
   LET g_pmcl_m_mask_n.* =  g_pmcl_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apmt814_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmcl_m.pmclmodid = g_user 
LET g_pmcl_m.pmclmoddt = cl_get_current()
LET g_pmcl_m.pmclmodid_desc = cl_get_username(g_pmcl_m.pmclmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_pmcl_m.pmclstus MATCHES "[DR]" THEN 
         LET g_pmcl_m.pmclstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt814_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmcl_t SET (pmclmodid,pmclmoddt) = (g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt)
          WHERE pmclent = g_enterprise AND pmcldocno = g_pmcldocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmcl_m.* = g_pmcl_m_t.*
            CALL apmt814_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmcl_m.pmcldocno != g_pmcl_m_t.pmcldocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pmcm_t SET pmcmdocno = g_pmcl_m.pmcldocno
 
          WHERE pmcment = g_enterprise AND pmcmdocno = g_pmcl_m_t.pmcldocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmcm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcm_t:",SQLERRMESSAGE 
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
   CALL apmt814_set_act_visible()   
   CALL apmt814_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmclent = " ||g_enterprise|| " AND",
                      " pmcldocno = '", g_pmcl_m.pmcldocno, "' "
 
   #填到對應位置
   CALL apmt814_browser_fill("")
 
   CLOSE apmt814_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt814_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt814.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt814_input(p_cmd)
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
   DEFINE l_arg1           LIKE ooef_t.ooef004
   DEFINE l_success        LIKE type_t.chr1
   DEFINE l_sql            STRING
   DEFINE l_state          LIKE type_t.chr1
   DEFINE l_controlp_count LIKE type_t.num5
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
   DISPLAY BY NAME g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002, 
       g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp, 
       g_pmcl_m.pmclowndp_desc,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdp_desc, 
       g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfid_desc,g_pmcl_m.pmclcnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pmcmseq,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm007,pmcm006,pmcm008, 
       pmcm009 FROM pmcm_t WHERE pmcment=? AND pmcmdocno=? AND pmcmseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt814_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt814_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmt814_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt814.input.head" >}
      #單頭段
      INPUT BY NAME g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt814_cl USING g_enterprise,g_pmcl_m.pmcldocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt814_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt814_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt814_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL apmt814_set_entry(p_cmd)
            CALL apmt814_set_no_entry(p_cmd)

   #end add-point
            #end add-point
            CALL apmt814_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcl001
            
            #add-point:AFTER FIELD pmcl001 name="input.a.pmcl001"
            CALL apmt814_pmcl001_desc()
            IF NOT cl_null(g_pmcl_m.pmcl001) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_pmcl_m.pmcl001
                  
               IF l_n = 0 THEN
                  LET g_pmcl_m.pmcl001 = g_pmcl_m_t.pmcl001
                  LET g_pmcl_m.pmcl001_desc = g_pmcl_m_t.pmcl001_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00069'
                  LET g_errparam.extend = g_pmcl_m.pmcl001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooagstus= 'Y'
                  AND ooag001 = g_pmcl_m.pmcl001
               IF l_n = 0 THEN
                  LET g_pmcl_m.pmcl001 = g_pmcl_m_t.pmcl001
                  LET g_pmcl_m.pmcl001_desc = g_pmcl_m_t.pmcl001_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302'  #aim-00070   #160318-00005#37  By 07900--mod
                  LET g_errparam.extend = g_pmcl_m.pmcl001
                   #160318-00005#317  By 07900 --add-str
                   LET g_errparam.replace[1] ='aooi130'
                   LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                   LET g_errparam.exeprog ='aooi130'
                   #160318-00005#37  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               SELECT ooag003 INTO g_pmcl_m.pmcl002 FROM ooag_t
                WHERE ooag001 = g_pmcl_m.pmcl001 AND ooagent = g_enterprise
               IF cl_null(g_pmcl_m.pmcl002) THEN
                  LET g_pmcl_m.pmcl002 = g_pmcl_m_t.pmcl002
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00170'
                  LET g_errparam.extend = g_pmcl_m.pmcl002
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME g_pmcl_m.pmcl002
            END IF
           
            CALL apmt814_pmcl001_desc()
           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcl001
            #add-point:BEFORE FIELD pmcl001 name="input.b.pmcl001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcl001
            #add-point:ON CHANGE pmcl001 name="input.g.pmcl001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcl002
            
            #add-point:AFTER FIELD pmcl002 name="input.a.pmcl002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcl_m.pmcl002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag003 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmcl_m.pmcl002_desc = '(', g_rtn_fields[1] , ')'
            DISPLAY BY NAME g_pmcl_m.pmcl002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcl002
            #add-point:BEFORE FIELD pmcl002 name="input.b.pmcl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcl002
            #add-point:ON CHANGE pmcl002 name="input.g.pmcl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmclstus
            #add-point:BEFORE FIELD pmclstus name="input.b.pmclstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmclstus
            
            #add-point:AFTER FIELD pmclstus name="input.a.pmclstus"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmclstus
            #add-point:ON CHANGE pmclstus name="input.g.pmclstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmcl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcl001
            #add-point:ON ACTION controlp INFIELD pmcl001 name="input.c.pmcl001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcl_m.pmcl001             #給予default值
            LET g_qryparam.default2 = "" #g_pmcl_m.oofa011 #全名

            #給予arg

            #CALL q_ooag001_2()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            CALL q_ooag001_4()                           #呼叫開窗    #151228-00009#1 20151230 add by beckxie

            LET g_pmcl_m.pmcl001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            SELECT ooag003 INTO g_pmcl_m.pmcl002 FROM ooag_t
                WHERE ooag001 = g_pmcl_m.pmcl001 AND ooagent = g_enterprise
            CALL apmt814_pmcl001_desc()
           
            DISPLAY g_pmcl_m.pmcl001 TO pmcl001              #顯示到畫面上
            #DISPLAY g_pmcl_m.oofa011 TO oofa011 #全名

            NEXT FIELD pmcl001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmcl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcl002
            #add-point:ON ACTION controlp INFIELD pmcl002 name="input.c.pmcl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmclstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmclstus
            #add-point:ON ACTION controlp INFIELD pmclstus name="input.c.pmclstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmcl_m.pmcldocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_gen_docno(g_site,g_pmcl_m.pmcldocno,g_today,g_prog) RETURNING l_success,g_pmcl_m.pmcldocno
                  LET g_pmcldocno_t = g_pmcl_m.pmcldocno
                  DISPLAY BY NAME g_pmcl_m.pmcldocno #150623-00038 15/06/29 s983961--add 到單身時沒有顯示 流水編號
               #end add-point
               
               INSERT INTO pmcl_t (pmclent,pmcldocno,pmcldocdt,pmcl001,pmcl002,pmclstus,pmclownid,pmclowndp, 
                   pmclcrtid,pmclcrtdp,pmclcrtdt,pmclmodid,pmclmoddt,pmclcnfid,pmclcnfdt)
               VALUES (g_enterprise,g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl002, 
                   g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtdp, 
                   g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid,g_pmcl_m.pmclcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmcl_m:",SQLERRMESSAGE 
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
                  CALL apmt814_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt814_b_fill()
                  CALL apmt814_b_fill2('0')
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
               CALL apmt814_pmcl_t_mask_restore('restore_mask_o')
               
               UPDATE pmcl_t SET (pmcldocno,pmcldocdt,pmcl001,pmcl002,pmclstus,pmclownid,pmclowndp,pmclcrtid, 
                   pmclcrtdp,pmclcrtdt,pmclmodid,pmclmoddt,pmclcnfid,pmclcnfdt) = (g_pmcl_m.pmcldocno, 
                   g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid, 
                   g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid, 
                   g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid,g_pmcl_m.pmclcnfdt)
                WHERE pmclent = g_enterprise AND pmcldocno = g_pmcldocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmcl_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt814_pmcl_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmcl_m_t)
               LET g_log2 = util.JSON.stringify(g_pmcl_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmt814.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmcm_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmcm_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt814_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmcm_d.getLength()
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
            OPEN apmt814_cl USING g_enterprise,g_pmcl_m.pmcldocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt814_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt814_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmcm_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmcm_d[l_ac].pmcmseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmcm_d_t.* = g_pmcm_d[l_ac].*  #BACKUP
               LET g_pmcm_d_o.* = g_pmcm_d[l_ac].*  #BACKUP
               CALL apmt814_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL apmt814_set_no_entry_b(l_cmd)
               IF NOT apmt814_lock_b("pmcm_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt814_bcl INTO g_pmcm_d[l_ac].pmcmseq,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002, 
                      g_pmcm_d[l_ac].pmcm003,g_pmcm_d[l_ac].pmcm004,g_pmcm_d[l_ac].pmcm005,g_pmcm_d[l_ac].pmcm007, 
                      g_pmcm_d[l_ac].pmcm006,g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmcm_d_t.pmcmseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmcm_d_mask_o[l_ac].* =  g_pmcm_d[l_ac].*
                  CALL apmt814_pmcm_t_mask()
                  LET g_pmcm_d_mask_n[l_ac].* =  g_pmcm_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt814_show()
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
            INITIALIZE g_pmcm_d[l_ac].* TO NULL 
            INITIALIZE g_pmcm_d_t.* TO NULL 
            INITIALIZE g_pmcm_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmcm_d_t.* = g_pmcm_d[l_ac].*     #新輸入資料
            LET g_pmcm_d_o.* = g_pmcm_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt814_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL apmt814_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmcm_d[li_reproduce_target].* = g_pmcm_d[li_reproduce].*
 
               LET g_pmcm_d[li_reproduce_target].pmcmseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(pmcmseq) INTO g_pmcm_d[l_ac].pmcmseq 
              FROM pmcm_t WHERE pmcmdocno = g_pmcl_m.pmcldocno
               AND pmcment = g_enterprise
            IF cl_null(g_pmcm_d[l_ac].pmcmseq) THEN LET g_pmcm_d[l_ac].pmcmseq  = 0 END IF
            LET g_pmcm_d[l_ac].pmcmseq = g_pmcm_d[l_ac].pmcmseq + 1  
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
            SELECT COUNT(1) INTO l_count FROM pmcm_t 
             WHERE pmcment = g_enterprise AND pmcmdocno = g_pmcl_m.pmcldocno
 
               AND pmcmseq = g_pmcm_d[l_ac].pmcmseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcl_m.pmcldocno
               LET gs_keys[2] = g_pmcm_d[g_detail_idx].pmcmseq
               CALL apmt814_insert_b('pmcm_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmcm_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt814_b_fill()
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
               LET gs_keys[01] = g_pmcl_m.pmcldocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmcm_d_t.pmcmseq
 
            
               #刪除同層單身
               IF NOT apmt814_delete_b('pmcm_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt814_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt814_key_delete_b(gs_keys,'pmcm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt814_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt814_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_pmcm_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmcm_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm001
            
            #add-point:AFTER FIELD pmcm001 name="input.a.page1.pmcm001"
            CALL apmt814_pmcm001_desc()
            CALL apmt814_pmcm003_desc()
            IF NOT cl_null(g_pmcm_d[l_ac].pmcm001) THEN          
               IF NOT ap_chk_isExist(g_pmcm_d[l_ac].pmcm001,"SELECT COUNT(*) FROM pmck_t WHERE pmck003 = ? AND pmckent = "||g_enterprise,'apm-00189',1) THEN
                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm001
                  NEXT FIELD CURRENT
               END IF
               
            
               IF NOT apmt814_pmcm001_chk(l_cmd,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00002'
                  LET g_errparam.extend = g_pmcm_d[l_ac].pmcm001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm001
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT apmt814_pmck_chk(l_cmd,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00190'
                  LET g_errparam.extend = g_pmcm_d[l_ac].pmcm001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  NEXT FIELD CURRENT
               ELSE
                  CALL apmt814_score_desc(l_cmd) 
               END IF
               
            END IF
            LET g_pmcm_d_o.pmcm001 = g_pmcm_d[l_ac].pmcm001    #160824-00007#16 20160914 add by beckxie
            LET g_pmcm_d_o.pmcm002 = g_pmcm_d[l_ac].pmcm002    #160824-00007#16 20160914 add by beckxie
            LET g_pmcm_d_o.pmcm003 = g_pmcm_d[l_ac].pmcm003    #160824-00007#16 20160914 add by beckxie


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm001
            #add-point:BEFORE FIELD pmcm001 name="input.b.page1.pmcm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcm001
            #add-point:ON CHANGE pmcm001 name="input.g.page1.pmcm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm002
            #add-point:BEFORE FIELD pmcm002 name="input.b.page1.pmcm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm002
            
            #add-point:AFTER FIELD pmcm002 name="input.a.page1.pmcm002"
            IF NOT cl_null(g_pmcm_d[l_ac].pmcm002) THEN
               IF NOT ap_chk_isExist(g_pmcm_d[l_ac].pmcm002,"SELECT COUNT(*) FROM pmck_t WHERE pmck001 = ? AND pmckent = "||g_enterprise,'apm-00189',1) THEN
                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm002
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  NEXT FIELD CURRENT
               END IF

               IF NOT apmt814_pmcm001_chk(l_cmd,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00002'
                  LET g_errparam.extend = g_pmcm_d[l_ac].pmcm002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm002
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT apmt814_pmck_chk(l_cmd,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00190'
                  LET g_errparam.extend = g_pmcm_d[l_ac].pmcm002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  NEXT FIELD CURRENT
               ELSE
                  CALL apmt814_score_desc(l_cmd) 
               END IF
            END IF
            LET g_pmcm_d_o.pmcm001 = g_pmcm_d[l_ac].pmcm001    #160824-00007#16 20160914 add by beckxie
            LET g_pmcm_d_o.pmcm002 = g_pmcm_d[l_ac].pmcm002    #160824-00007#16 20160914 add by beckxie
            LET g_pmcm_d_o.pmcm003 = g_pmcm_d[l_ac].pmcm003    #160824-00007#16 20160914 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcm002
            #add-point:ON CHANGE pmcm002 name="input.g.page1.pmcm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm003
            
            #add-point:AFTER FIELD pmcm003 name="input.a.page1.pmcm003"
            CALL apmt814_pmcm001_desc()
            CALL apmt814_pmcm003_desc()
            IF NOT cl_null(g_pmcm_d[l_ac].pmcm003) THEN
               IF NOT ap_chk_isExist(g_pmcm_d[l_ac].pmcm003,"SELECT COUNT(*) FROM pmck_t WHERE pmck002 = ? AND pmckent = "||g_enterprise,'apm-00189',1) THEN
                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm003
                  NEXT FIELD CURRENT
               END IF

               IF NOT apmt814_pmcm001_chk(l_cmd,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00002'
                  LET g_errparam.extend = g_pmcm_d[l_ac].pmcm003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm003
                  NEXT FIELD CURRENT
               END IF

               IF NOT apmt814_pmck_chk(l_cmd,g_pmcm_d[l_ac].pmcm001,g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00190'
                  LET g_errparam.extend = g_pmcm_d[l_ac].pmcm003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_t.pmcm001   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_t.pmcm002   #160824-00007#16 20160914 mark by beckxie
                  #LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_t.pmcm003   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm001 = g_pmcm_d_o.pmcm001    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm002 = g_pmcm_d_o.pmcm002    #160824-00007#16 20160914 add by beckxie
                  LET g_pmcm_d[l_ac].pmcm003 = g_pmcm_d_o.pmcm003    #160824-00007#16 20160914 add by beckxie
                  CALL apmt814_pmcm001_desc()
                  CALL apmt814_pmcm003_desc()
                  NEXT FIELD CURRENT
               ELSE
                  CALL apmt814_score_desc(l_cmd) 
               END IF
            END IF
            LET g_pmcm_d_o.pmcm001 = g_pmcm_d[l_ac].pmcm001    #160824-00007#16 20160914 add by beckxie
            LET g_pmcm_d_o.pmcm002 = g_pmcm_d[l_ac].pmcm002    #160824-00007#16 20160914 add by beckxie
            LET g_pmcm_d_o.pmcm003 = g_pmcm_d[l_ac].pmcm003    #160824-00007#16 20160914 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm003
            #add-point:BEFORE FIELD pmcm003 name="input.b.page1.pmcm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcm003
            #add-point:ON CHANGE pmcm003 name="input.g.page1.pmcm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcm006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmcm_d[l_ac].pmcm006,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD pmcm006
            END IF 
 
 
 
            #add-point:AFTER FIELD pmcm006 name="input.a.page1.pmcm006"
            IF NOT cl_null(g_pmcm_d[l_ac].pmcm006) THEN
               IF NOT apmt814_pmcm006_chk() THEN
                  #LET g_pmcm_d[l_ac].pmcm006 = g_pmcm_d_t.pmcm006   #160824-00007#16 20160914 mark by beckxie
                  LET g_pmcm_d[l_ac].pmcm006 = g_pmcm_d_o.pmcm006   #160824-00007#16 20160914 add by beckxie
                  DISPLAY BY NAME g_pmcm_d[l_ac].pmcm006 
               END IF
            END IF
            LET g_pmcm_d_o.pmcm006 = g_pmcm_d[l_ac].pmcm006   #160824-00007#16 20160914 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcm006
            #add-point:BEFORE FIELD pmcm006 name="input.b.page1.pmcm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcm006
            #add-point:ON CHANGE pmcm006 name="input.g.page1.pmcm006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmcm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm001
            #add-point:ON ACTION controlp INFIELD pmcm001 name="input.c.page1.pmcm001"
#此段落由子樣板a07產生            
            #開窗i段
            LET l_state =  g_qryparam.state
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = "m"
            END IF
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcm_d[l_ac].pmcm002             #給予default值
            LET g_qryparam.default2 = g_pmcm_d[l_ac].pmcm003 
            LET g_qryparam.default3 = g_pmcm_d[l_ac].pmcm001 
            #給予arg

            CALL q_pmck001()                                #呼叫開窗
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  CALL apmt814_controlp_chk(g_qryparam.str_array) RETURNING l_controlp_count
                  INITIALIZE g_qryparam.str_array TO NULL
                  LET g_qryparam.state = l_state
                  IF l_controlp_count = 1 THEN
                     LET g_flag = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00222'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     CALL apmt814_show()
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
               
            ELSE
               LET g_pmcm_d[l_ac].pmcm002  = g_qryparam.return1
               LET g_pmcm_d[l_ac].pmcm003  = g_qryparam.return2
               LET g_pmcm_d[l_ac].pmcm001  = g_qryparam.return3
               DISPLAY g_pmcm_d[l_ac].pmcm002 TO pmcm002
               DISPLAY g_pmcm_d[l_ac].pmcm003 TO pmcm003
               DISPLAY g_pmcm_d[l_ac].pmcm001 TO pmcm001
            END IF
            NEXT FIELD pmcm001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm002
            #add-point:ON ACTION controlp INFIELD pmcm002 name="input.c.page1.pmcm002"
#此段落由子樣板a07產生            
            #開窗i段
            LET l_state =  g_qryparam.state
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = "m"
            END IF
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcm_d[l_ac].pmcm002             #給予default值
            LET g_qryparam.default2 = g_pmcm_d[l_ac].pmcm003 
            LET g_qryparam.default3 = g_pmcm_d[l_ac].pmcm001

            #給予arg

            CALL q_pmck001()                                #呼叫開窗
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  CALL apmt814_controlp_chk(g_qryparam.str_array) RETURNING l_controlp_count
                  INITIALIZE g_qryparam.str_array TO NULL
                  LET g_qryparam.state = l_state
                  IF l_controlp_count = 1 THEN
                     LET g_flag = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00222'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     CALL apmt814_show()
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               LET g_pmcm_d[l_ac].pmcm002  = g_qryparam.return1
               LET g_pmcm_d[l_ac].pmcm003  = g_qryparam.return2
               LET g_pmcm_d[l_ac].pmcm001  = g_qryparam.return3
               DISPLAY g_pmcm_d[l_ac].pmcm002 TO pmcm002
               DISPLAY g_pmcm_d[l_ac].pmcm003 TO pmcm003
               DISPLAY g_pmcm_d[l_ac].pmcm001 TO pmcm001
            END IF
            NEXT FIELD pmcm002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm003
            #add-point:ON ACTION controlp INFIELD pmcm003 name="input.c.page1.pmcm003"
#此段落由子樣板a07產生            
            #開窗i段
            LET l_state =  g_qryparam.state
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = "m"
            END IF
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcm_d[l_ac].pmcm002             #給予default值
            LET g_qryparam.default2 = g_pmcm_d[l_ac].pmcm003 
            LET g_qryparam.default3 = g_pmcm_d[l_ac].pmcm001

            #給予arg

            CALL q_pmck001()                                #呼叫開窗
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  CALL apmt814_controlp_chk(g_qryparam.str_array) RETURNING l_controlp_count
                  INITIALIZE g_qryparam.str_array TO NULL
                  LET g_qryparam.state = l_state
                  IF l_controlp_count = 1 THEN
                     LET g_flag = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00222'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     CALL apmt814_show()
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               LET g_pmcm_d[l_ac].pmcm002  = g_qryparam.return1
               LET g_pmcm_d[l_ac].pmcm003  = g_qryparam.return2
               LET g_pmcm_d[l_ac].pmcm001  = g_qryparam.return3
               DISPLAY g_pmcm_d[l_ac].pmcm002 TO pmcm002
               DISPLAY g_pmcm_d[l_ac].pmcm003 TO pmcm003
               DISPLAY g_pmcm_d[l_ac].pmcm001 TO pmcm001
            END IF
            NEXT FIELD pmcm003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcm006
            #add-point:ON ACTION controlp INFIELD pmcm006 name="input.c.page1.pmcm006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmcm_d[l_ac].* = g_pmcm_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt814_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmcm_d[l_ac].pmcmseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmcm_d[l_ac].* = g_pmcm_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt814_pmcm_t_mask_restore('restore_mask_o')
      
               UPDATE pmcm_t SET (pmcmdocno,pmcmseq,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm007, 
                   pmcm006,pmcm008,pmcm009) = (g_pmcl_m.pmcldocno,g_pmcm_d[l_ac].pmcmseq,g_pmcm_d[l_ac].pmcm001, 
                   g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003,g_pmcm_d[l_ac].pmcm004,g_pmcm_d[l_ac].pmcm005, 
                   g_pmcm_d[l_ac].pmcm007,g_pmcm_d[l_ac].pmcm006,g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009) 
 
                WHERE pmcment = g_enterprise AND pmcmdocno = g_pmcl_m.pmcldocno 
 
                  AND pmcmseq = g_pmcm_d_t.pmcmseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmcm_d[l_ac].* = g_pmcm_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmcm_d[l_ac].* = g_pmcm_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmcl_m.pmcldocno
               LET gs_keys_bak[1] = g_pmcldocno_t
               LET gs_keys[2] = g_pmcm_d[g_detail_idx].pmcmseq
               LET gs_keys_bak[2] = g_pmcm_d_t.pmcmseq
               CALL apmt814_update_b('pmcm_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt814_pmcm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmcm_d[g_detail_idx].pmcmseq = g_pmcm_d_t.pmcmseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmcl_m.pmcldocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcm_d_t.pmcmseq
 
                  CALL apmt814_key_update_b(gs_keys,'pmcm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmcl_m),util.JSON.stringify(g_pmcm_d_t)
               LET g_log2 = util.JSON.stringify(g_pmcl_m),util.JSON.stringify(g_pmcm_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL apmt814_unlock_b("pmcm_t","'1'")
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
               LET g_pmcm_d[li_reproduce_target].* = g_pmcm_d[li_reproduce].*
 
               LET g_pmcm_d[li_reproduce_target].pmcmseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmcm_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmcm_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="apmt814.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD pmcmseq
         END IF 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD pmcl001 #150623-00038 15/06/29 s983961--add pmcldocno 已經被set no entry   但是內建還是要跳進去就會卡住
            #end add-point  
            NEXT FIELD pmcldocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmcmseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF g_flag THEN
      CALL apmt814_input('u')
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
   END IF  
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt814_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt814_b_fill() #單身填充
      CALL apmt814_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt814_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmclmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmclmodid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmclmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmclownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmclownid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmclownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmclowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmclowndp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmclowndp_desc
#
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmclcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmclcrtdp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmclcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmclcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmclcrtid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmclcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmclcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmclcnfid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmclcnfid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmcl001
#            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM ooag_t LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = "||g_enterprise||" WHERE ooagent="||g_enterprise||" AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmcl001_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmcl001_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcl_m.pmcl002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooefl001 =? AND ooeflent = "||g_enterprise||" AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcl_m.pmcl002_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcl_m.pmcl002_desc

   #end add-point
   
   #遮罩相關處理
   LET g_pmcl_m_mask_o.* =  g_pmcl_m.*
   CALL apmt814_pmcl_t_mask()
   LET g_pmcl_m_mask_n.* =  g_pmcl_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002, 
       g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp, 
       g_pmcl_m.pmclowndp_desc,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdp_desc, 
       g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfid_desc,g_pmcl_m.pmclcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmcl_m.pmclstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
   FOR l_ac = 1 TO g_pmcm_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            
#            CALL apmt814_pmcm001_desc()
#            CALL apmt814_pmcm003_desc()
            CALL apmt814_pmcf003_desc(g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003,g_pmcm_d[l_ac].pmcm005) RETURNING g_pmcm_d[l_ac].pmcf003,g_pmcm_d[l_ac].pmcf003_desc
            DISPLAY BY NAME g_pmcm_d[l_ac].pmcf003,g_pmcm_d[l_ac].pmcf003_desc
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcm_d[l_ac].pmcm009
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2054' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcm_d[l_ac].pmcm009_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcm_d[l_ac].pmcm009_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcm_d[l_ac].pmcm008
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcm_d[l_ac].pmcm008_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcm_d[l_ac].pmcm008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcm_d[l_ac].pmcf003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmcm_d[l_ac].pmcf003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmcm_d[l_ac].pmcf003_desc

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt814_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt814_detail_show()
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
 
{<section id="apmt814.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt814_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmcl_t.pmcldocno 
   DEFINE l_oldno     LIKE pmcl_t.pmcldocno 
 
   DEFINE l_master    RECORD LIKE pmcl_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmcm_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_arg1      LIKE ooef_t.ooef004
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_pmcl_m.pmcldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
    
   LET g_pmcl_m.pmcldocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmcl_m.pmclownid = g_user
      LET g_pmcl_m.pmclowndp = g_dept
      LET g_pmcl_m.pmclcrtid = g_user
      LET g_pmcl_m.pmclcrtdp = g_dept 
      LET g_pmcl_m.pmclcrtdt = cl_get_current()
      LET g_pmcl_m.pmclmodid = g_user
      LET g_pmcl_m.pmclmoddt = cl_get_current()
      LET g_pmcl_m.pmclstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmcl_m.pmclstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
   
   
   CALL apmt814_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmcl_m.* TO NULL
      INITIALIZE g_pmcm_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt814_show()
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
   CALL apmt814_set_act_visible()   
   CALL apmt814_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmclent = " ||g_enterprise|| " AND",
                      " pmcldocno = '", g_pmcl_m.pmcldocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt814_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmt814_idx_chk()
   
   LET g_data_owner = g_pmcl_m.pmclownid      
   LET g_data_dept  = g_pmcl_m.pmclowndp
   
   #功能已完成,通報訊息中心
   CALL apmt814_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt814_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmcm_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt814_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmcm_t
    WHERE pmcment = g_enterprise AND pmcmdocno = g_pmcldocno_t
 
    INTO TEMP apmt814_detail
 
   #將key修正為調整後   
   UPDATE apmt814_detail 
      #更新key欄位
      SET pmcmdocno = g_pmcl_m.pmcldocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmcm_t SELECT * FROM apmt814_detail
   
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
   DROP TABLE apmt814_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt814_delete()
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
   
   IF g_pmcl_m.pmcldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmt814_cl USING g_enterprise,g_pmcl_m.pmcldocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt814_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt814_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
       g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid, 
       g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp_desc, 
       g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT apmt814_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmcl_m_mask_o.* =  g_pmcl_m.*
   CALL apmt814_pmcl_t_mask()
   LET g_pmcl_m_mask_n.* =  g_pmcl_m.*
   
   CALL apmt814_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt814_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmcldocno_t = g_pmcl_m.pmcldocno
 
 
      DELETE FROM pmcl_t
       WHERE pmclent = g_enterprise AND pmcldocno = g_pmcl_m.pmcldocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmcl_m.pmcldocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM pmcm_t
       WHERE pmcment = g_enterprise AND pmcmdocno = g_pmcl_m.pmcldocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmcl_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt814_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmcm_d.clear() 
 
     
      CALL apmt814_ui_browser_refresh()  
      #CALL apmt814_ui_headershow()  
      #CALL apmt814_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt814_browser_fill("")
         CALL apmt814_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt814_cl
 
   #功能已完成,通報訊息中心
   CALL apmt814_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt814.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt814_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmcm_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apmt814_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmcmseq,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm007,pmcm006, 
             pmcm008,pmcm009 ,t1.pmaal004 ,t2.rtaxl003 ,t4.oocql004 ,t5.oocql004 FROM pmcm_t",   
                     " INNER JOIN pmcl_t ON pmclent = " ||g_enterprise|| " AND pmcldocno = pmcmdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=pmcm001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=pmcm003 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2053' AND t4.oocql002=pmcm008 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2054' AND t5.oocql002=pmcm009 AND t5.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmcment=? AND pmcmdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmcm_t.pmcmseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt814_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt814_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmcl_m.pmcldocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmcl_m.pmcldocno INTO g_pmcm_d[l_ac].pmcmseq,g_pmcm_d[l_ac].pmcm001, 
          g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003,g_pmcm_d[l_ac].pmcm004,g_pmcm_d[l_ac].pmcm005, 
          g_pmcm_d[l_ac].pmcm007,g_pmcm_d[l_ac].pmcm006,g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009, 
          g_pmcm_d[l_ac].pmcm001_desc,g_pmcm_d[l_ac].pmcm003_desc,g_pmcm_d[l_ac].pmcm008_desc,g_pmcm_d[l_ac].pmcm009_desc  
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
         CALL apmt814_pmcf003_desc(g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003,g_pmcm_d[l_ac].pmcm005) RETURNING g_pmcm_d[l_ac].pmcf003,g_pmcm_d[l_ac].pmcf003_desc
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
   
   CALL g_pmcm_d.deleteElement(g_pmcm_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt814_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmcm_d.getLength()
      LET g_pmcm_d_mask_o[l_ac].* =  g_pmcm_d[l_ac].*
      CALL apmt814_pmcm_t_mask()
      LET g_pmcm_d_mask_n[l_ac].* =  g_pmcm_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt814_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmcm_t
       WHERE pmcment = g_enterprise AND
         pmcmdocno = ps_keys_bak[1] AND pmcmseq = ps_keys_bak[2]
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
         CALL g_pmcm_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt814_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmcm_t
                  (pmcment,
                   pmcmdocno,
                   pmcmseq
                   ,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm007,pmcm006,pmcm008,pmcm009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmcm_d[g_detail_idx].pmcm001,g_pmcm_d[g_detail_idx].pmcm002,g_pmcm_d[g_detail_idx].pmcm003, 
                       g_pmcm_d[g_detail_idx].pmcm004,g_pmcm_d[g_detail_idx].pmcm005,g_pmcm_d[g_detail_idx].pmcm007, 
                       g_pmcm_d[g_detail_idx].pmcm006,g_pmcm_d[g_detail_idx].pmcm008,g_pmcm_d[g_detail_idx].pmcm009) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmcm_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt814_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmcm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt814_pmcm_t_mask_restore('restore_mask_o')
               
      UPDATE pmcm_t 
         SET (pmcmdocno,
              pmcmseq
              ,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm007,pmcm006,pmcm008,pmcm009) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmcm_d[g_detail_idx].pmcm001,g_pmcm_d[g_detail_idx].pmcm002,g_pmcm_d[g_detail_idx].pmcm003, 
                  g_pmcm_d[g_detail_idx].pmcm004,g_pmcm_d[g_detail_idx].pmcm005,g_pmcm_d[g_detail_idx].pmcm007, 
                  g_pmcm_d[g_detail_idx].pmcm006,g_pmcm_d[g_detail_idx].pmcm008,g_pmcm_d[g_detail_idx].pmcm009)  
 
         WHERE pmcment = g_enterprise AND pmcmdocno = ps_keys_bak[1] AND pmcmseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt814_pmcm_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt814.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt814_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt814.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt814_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt814.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt814_lock_b(ps_table,ps_page)
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
   #CALL apmt814_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmcm_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt814_bcl USING g_enterprise,
                                       g_pmcl_m.pmcldocno,g_pmcm_d[g_detail_idx].pmcmseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt814_bcl:",SQLERRMESSAGE 
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
 
{<section id="apmt814.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt814_unlock_b(ps_table,ps_page)
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
      CLOSE apmt814_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt814_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("pmcldocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmcldocno",TRUE)
      CALL cl_set_comp_entry("pmcldocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("pmcldocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt814_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmcldocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("pmcldocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("pmcldocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("pmcldocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt814_set_entry_b(p_cmd)
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
 
{<section id="apmt814.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt814_set_no_entry_b(p_cmd)
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
 
{<section id="apmt814.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt814_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt814_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_pmcl_m.pmclstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt814_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt814_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt814_default_search()
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
      LET ls_wc = ls_wc, " pmcldocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "pmcl_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmcm_t" 
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
   #LET ls_wc = ''    #160905-00014#1
   IF NOT cl_null(g_argv[2]) THEN
      LET ls_wc = ls_wc, " pmcm001 = '", g_argv[2], "' AND "
   END IF
   IF NOT cl_null(g_argv[3]) THEN
      LET ls_wc = ls_wc, " pmcm002 = '", g_argv[3], "' AND "
   END IF
   IF NOT cl_null(g_argv[4]) THEN
      LET ls_wc = ls_wc, " pmcm003 = '", g_argv[4], "' AND "
   END IF
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc2 = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt814.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt814_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_errno   LIKE type_t.chr10
   DEFINE l_detail_cnt LIKE type_t.num5
   DEFINE l_pmcm007_max   LIKE pmcm_t.pmcm007
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_pmcl_m.pmclstus  = 'X' THEN
      RETURN
   END IF 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmcl_m.pmcldocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmt814_cl USING g_enterprise,g_pmcl_m.pmcldocno
   IF STATUS THEN
      CLOSE apmt814_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt814_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
       g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp,g_pmcl_m.pmclcrtid, 
       g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp_desc, 
       g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT apmt814_action_chk() THEN
      CLOSE apmt814_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002, 
       g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp, 
       g_pmcl_m.pmclowndp_desc,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdp_desc, 
       g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
       g_pmcl_m.pmclcnfid_desc,g_pmcl_m.pmclcnfdt
 
   CASE g_pmcl_m.pmclstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
         CASE g_pmcl_m.pmclstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
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
      IF g_pmcl_m.pmclstus  = 'Y' THEN
         CALL cl_set_act_visible("invalid",FALSE)
      ELSE
         CALL cl_set_act_visible("invalid",TRUE)
      END IF
      
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_pmcl_m.pmclstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
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

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      
      
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt814_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt814_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt814_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt814_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
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
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_pmcl_m.pmclstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmt814_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CASE WHEN lc_state = 'Y'
           IF NOT cl_ask_confirm('aim-00108') THEN
              CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
              RETURN
           END IF
        WHEN lc_state = 'N'
           IF NOT cl_ask_confirm('aim-00110') THEN
              CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
              RETURN
           END IF
        WHEN lc_state = 'X'
           IF NOT cl_ask_confirm('aim-00109') THEN
              CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
              RETURN
           END IF
   END CASE
   IF lc_state = 'N' THEN
      FOR l_detail_cnt = 1 TO g_pmcm_d.getLength()
         IF NOT apmt814_pmcm001_chk('a',g_pmcm_d[l_detail_cnt].pmcm001,g_pmcm_d[l_detail_cnt].pmcm002,g_pmcm_d[l_detail_cnt].pmcm003) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00223'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
            RETURN 
         END IF
         IF NOT cl_null(g_pmcm_d[l_detail_cnt].pmcm007) THEN
            CALL apmt814_pmcm007_max_chk(g_pmcm_d[l_detail_cnt].pmcm001,g_pmcm_d[l_detail_cnt].pmcm002,g_pmcm_d[l_detail_cnt].pmcm003) RETURNING l_pmcm007_max
            IF g_pmcm_d[l_detail_cnt].pmcm007 != l_pmcm007_max THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00259'
               LET g_errparam.extend = g_pmcm_d[l_detail_cnt].pmcm001||"+"||g_pmcm_d[l_detail_cnt].pmcm002||"+"||g_pmcm_d[l_detail_cnt].pmcm003||":"||g_pmcm_d[l_detail_cnt].pmcm007||"<>"||l_pmcm007_max
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
               RETURN 
            END IF
         END IF
      END FOR
   END IF
   
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'
         CALL s_apmt814_conf_chk(g_pmcl_m.pmcldocno,g_pmcl_m.pmclstus) RETURNING l_success,l_errno
         IF l_success THEN
        #   IF cl_ask_confirm('apm-00174') THEN
               CALL s_transaction_begin()
               CALL s_apmt814_conf_upd(g_pmcl_m.pmcldocno) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmcl_m.pmcldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','1')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
        #   ELSE
        #      RETURN
        #   END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmcl_m.pmcldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
            RETURN
         END IF
      WHEN 'N'
         CALL s_apmt814_unconf_chk(g_pmcl_m.pmcldocno,g_pmcl_m.pmclstus) RETURNING l_success,l_errno
         IF l_success THEN
#            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_apmt814_unconf_upd(g_pmcl_m.pmcldocno) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmcl_m.pmcldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','1')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
#            ELSE
#               RETURN
#            END IF
         ELSE         
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmcl_m.pmcldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
            RETURN
         END IF
      WHEN 'X'
         CALL s_apmt814_void_chk(g_pmcl_m.pmcldocno,g_pmcl_m.pmclstus) RETURNING l_success,l_errno
         IF l_success THEN
#            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_apmt814_void_upd(g_pmcl_m.pmcldocno) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmcl_m.pmcldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','1')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
#            ELSE
#               RETURN
#            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmcl_m.pmcldocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
            RETURN 
         END IF
   END CASE
   #end add-point
   
   LET g_pmcl_m.pmclmodid = g_user
   LET g_pmcl_m.pmclmoddt = cl_get_current()
   LET g_pmcl_m.pmclstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmcl_t 
      SET (pmclstus,pmclmodid,pmclmoddt) 
        = (g_pmcl_m.pmclstus,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt)     
    WHERE pmclent = g_enterprise AND pmcldocno = g_pmcl_m.pmcldocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
      EXECUTE apmt814_master_referesh USING g_pmcl_m.pmcldocno INTO g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt, 
          g_pmcl_m.pmcl001,g_pmcl_m.pmcl002,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclowndp, 
          g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmoddt, 
          g_pmcl_m.pmclcnfid,g_pmcl_m.pmclcnfdt,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclownid_desc, 
          g_pmcl_m.pmclowndp_desc,g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp_desc,g_pmcl_m.pmclmodid_desc, 
          g_pmcl_m.pmclcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmcl_m.pmcldocno,g_pmcl_m.pmcldocdt,g_pmcl_m.pmcl001,g_pmcl_m.pmcl001_desc,g_pmcl_m.pmcl002, 
          g_pmcl_m.pmcl002_desc,g_pmcl_m.pmclstus,g_pmcl_m.pmclownid,g_pmcl_m.pmclownid_desc,g_pmcl_m.pmclowndp, 
          g_pmcl_m.pmclowndp_desc,g_pmcl_m.pmclcrtid,g_pmcl_m.pmclcrtid_desc,g_pmcl_m.pmclcrtdp,g_pmcl_m.pmclcrtdp_desc, 
          g_pmcl_m.pmclcrtdt,g_pmcl_m.pmclmodid,g_pmcl_m.pmclmodid_desc,g_pmcl_m.pmclmoddt,g_pmcl_m.pmclcnfid, 
          g_pmcl_m.pmclcnfid_desc,g_pmcl_m.pmclcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmt814_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt814_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt814.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt814_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmcm_d.getLength() THEN
         LET g_detail_idx = g_pmcm_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmcm_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmcm_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt814_b_fill2(pi_idx)
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
   
   CALL apmt814_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt814_fill_chk(ps_idx)
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
 
{<section id="apmt814.status_show" >}
PRIVATE FUNCTION apmt814_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt814.mask_functions" >}
&include "erp/apm/apmt814_mask.4gl"
 
{</section>}
 
{<section id="apmt814.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt814_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_errno   LIKE type_t.chr10
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apmt814_show()
   CALL apmt814_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_apmt814_conf_chk(g_pmcl_m.pmcldocno,g_pmcl_m.pmclstus) RETURNING l_success,l_errno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = g_pmcl_m.pmcldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmcl_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_pmcm_d))
 
 
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
   #CALL apmt814_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt814_ui_headershow()
   CALL apmt814_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt814_draw_out()
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
   CALL apmt814_ui_headershow()  
   CALL apmt814_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt814.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt814_set_pk_array()
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
   LET g_pk_array[1].values = g_pmcl_m.pmcldocno
   LET g_pk_array[1].column = 'pmcldocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt814.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt814.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt814_msgcentre_notify(lc_state)
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
   CALL apmt814_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmcl_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt814.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt814_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#28 add-S
   SELECT pmclstus  INTO g_pmcl_m.pmclstus
     FROM pmcl_t
    WHERE pmclent = g_enterprise
      AND pmcldocno = g_pmcl_m.pmcldocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_pmcl_m.pmclstus
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
        LET g_errparam.extend = g_pmcl_m.pmcldocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apmt814_set_act_visible()
        CALL apmt814_set_act_no_visible()
        CALL apmt814_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#28 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt814.other_function" readonly="Y" >}
#+ 多選開窗完控管
PRIVATE FUNCTION apmt814_controlp_chk(p_str_array)
DEFINE  p_str_array    DYNAMIC ARRAY OF STRING
DEFINE  l_i            LIKE type_t.num5
DEFINE  l_cnt          LIKE type_t.num5
DEFINE  tok            base.StringTokenizer
DEFINE  l_str1         LIKE type_t.chr100
DEFINE  l_str2         LIKE type_t.chr100
DEFINE  l_str3         LIKE type_t.chr100
DEFINE  l_num          LIKE type_t.num5
DEFINE  l_i1           LIKE type_t.num5

#   LET l_num = l_ac
   LET l_i1 = 1
   FOR l_i = 1 TO p_str_array.getLength()
      
      LET tok = base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
      LET l_cnt = 0
      WHILE tok.hasMoreTokens()
         LET l_cnt = l_cnt + 1
         CASE l_cnt
            WHEN "1"
               LET l_str1 = tok.nextToken()
            WHEN "2"
               LET l_str2 = tok.nextToken()
            WHEN "3"
               LET l_str3 = tok.nextToken()
            OTHERWISE
               EXIT WHILE
         END CASE
      END WHILE
      IF NOT apmt814_pmcm001_chk('a',l_str3,l_str1,l_str2) OR NOT apmt814_pmck_chk('a',l_str3,l_str1,l_str2) THEN
         CONTINUE FOR
      END IF
#      IF NOT apmt814_pmck_chk('a',l_str3,l_str1,l_str2) THEN
#         CONTINUE FOR
#      END IF
#      CALL apmt814_score_insert(l_str3,l_str1,l_str2,l_num,l_i1)
      CALL apmt814_score_insert(l_str3,l_str1,l_str2)
#      LET l_num = l_num + 1
      LET l_i1 = l_i1 + 1
   END FOR
   RETURN l_i1
END FUNCTION
# pmcldocno欄位控管
PRIVATE FUNCTION apmt814_pmcldocno_chk(p_pmcldocno)
DEFINE l_n          LIKE type_t.num5
DEFINE p_pmcldocno  LIKE pmcl_t.pmcldocno
   IF NOT ap_chk_notDup(p_pmcldocno,"SELECT COUNT(*) FROM pmcl_t WHERE "||"pmclent = " ||g_enterprise|| " AND "||"pmcldocno = '"||p_pmcldocno ||"'",'std-00004',0) THEN 
      RETURN FALSE
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM ooba_t,ooef_t,oobl_t
    WHERE ooba001 = ooef004 AND ooef001 = g_site
      AND oobaent = ooefent AND oobaent = g_enterprise
      AND ooba002 = p_pmcldocno AND ooblent = g_enterprise
      AND oobl001 = ooba001 AND oobl002 = ooba002
      AND oobl003 = 'apmt814'
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00001'
      LET g_errparam.extend = p_pmcldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF   
      
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM ooba_t,ooef_t,oobl_t
    WHERE ooba001 = ooef004 AND ooef001 = g_site
      AND oobaent = ooefent AND oobaent = g_enterprise
      AND ooba002 = p_pmcldocno AND ooblent = g_enterprise
      AND oobl001 = ooba001 AND oobl002 = ooba002
      AND oobl003 = 'apmt814'
      AND oobastus= 'Y'
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00114'
      LET g_errparam.extend = p_pmcldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
# pmcm001欄位控管
PRIVATE FUNCTION apmt814_pmcm001_chk(p_cmd,p_pmcm001,p_pmcm002,p_pmcm003)
DEFINE l_n       LIKE type_t.num5
DEFINE p_cmd     LIKE type_t.chr1
DEFINE p_pmcm001 LIKE pmcm_t.pmcm001
DEFINE p_pmcm002 LIKE pmcm_t.pmcm002
DEFINE p_pmcm003 LIKE pmcm_t.pmcm003
   IF NOT cl_null(p_pmcm001) AND NOT cl_null(p_pmcm002) AND NOT cl_null(p_pmcm003) THEN
      #IF p_cmd = 'a' OR (p_cmd='u' AND (g_pmcm_d_t.pmcm001 !=p_pmcm001 OR g_pmcm_d_t.pmcm002 !=p_pmcm002 OR g_pmcm_d_t.pmcm003 !=p_pmcm003)) THEN   #160824-00007#16 20160914 mark by beckxie
      IF g_pmcm_d_o.pmcm001 !=p_pmcm001 OR g_pmcm_d_o.pmcm002 !=p_pmcm002 OR g_pmcm_d_o.pmcm003 !=p_pmcm003 THEN   #160824-00007#16 20160914 add by beckxie
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM pmcm_t,pmcl_t 
          WHERE pmcm001 = p_pmcm001
            AND pmcm002 = p_pmcm002
            AND pmcm003 = p_pmcm003
            AND pmclstus = 'N'
            AND pmcmdocno = pmcldocno
            AND pmclent = g_enterprise AND pmclent = pmcment
         IF l_n > 0 THEN
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#+
PRIVATE FUNCTION apmt814_score_insert(p_pmcm001,p_pmcm002,p_pmcm003)
DEFINE p_pmcm001  LIKE pmcm_t.pmcm001
DEFINE p_pmcm002  LIKE pmcm_t.pmcm002
DEFINE p_pmcm003  LIKE pmcm_t.pmcm003
DEFINE l_pmcm     type_g_pmcm_d
DEFINE p_num      LIKE type_t.num5
DEFINE p_i        LIKE type_t.num5
   INITIALIZE l_pmcm.* TO NULL
   LET l_pmcm.pmcm001 = p_pmcm001
   LET l_pmcm.pmcm002 = p_pmcm002
   LET l_pmcm.pmcm003 = p_pmcm003
   IF NOT cl_null(l_pmcm.pmcm001) AND NOT cl_null(l_pmcm.pmcm002) AND NOT cl_null(l_pmcm.pmcm003) THEN    
      SELECT NVL(pmck004,0),NVL(pmck005,0),NVL(pmck006,0),NVL(pmck007,''),pmaal004,rtaxl003,oocql004 INTO
          l_pmcm.pmcm004,l_pmcm.pmcm005,l_pmcm.pmcm008,l_pmcm.pmcm009,l_pmcm.pmcm001_desc,l_pmcm.pmcm003_desc,l_pmcm.pmcm009_desc
        FROM pmck_t LEFT OUTER JOIN pmaal_t ON pmaalent = g_enterprise AND pmaal001=pmck003 AND pmaal002=g_dlang
                    LEFT OUTER JOIN rtaxl_t ON rtaxlent = g_enterprise AND rtaxl001=pmck002 AND rtaxl002=g_dlang
                    LEFT OUTER JOIN oocql_t ON oocqlent = g_enterprise AND oocql001= '2054' AND oocql002=pmck007 AND oocql003 = g_dlang
       WHERE pmckent = g_enterprise 
         AND pmck001 = l_pmcm.pmcm002
         AND pmck002 = l_pmcm.pmcm003
         AND pmck003 = l_pmcm.pmcm001
      SELECT oocql004 INTO l_pmcm.pmcm008_desc FROM oocql_t WHERE oocqlent=g_enterprise AND oocql001='2053' AND oocql002=l_pmcm.pmcm008 AND oocql003=g_dlang 
      CALL apmt814_pmcf003_desc(l_pmcm.pmcm002,l_pmcm.pmcm003,l_pmcm.pmcm005)  RETURNING l_pmcm.pmcf003,l_pmcm.pmcf003_desc     
      LET l_pmcm.pmcm006 = l_pmcm.pmcm005
      SELECT NVL(MAX(pmcm007),0) INTO l_pmcm.pmcm007 FROM pmcm_t,pmcl_t 
       WHERE pmcm001 = l_pmcm.pmcm001
         AND pmcm002 = l_pmcm.pmcm002
         AND pmcm003 = l_pmcm.pmcm003
         AND pmcment = g_enterprise 
         AND pmclent = pmcment 
         AND pmcldocno = pmcmdocno
         AND pmclstus <> 'X'
      LET l_pmcm.pmcm007 = l_pmcm.pmcm007 + 1
      SELECT MAX(pmcmseq)+1 into l_pmcm.pmcmseq FROM pmcm_t WHERE pmcment = g_enterprise AND pmcmdocno = g_pmcl_m.pmcldocno
      IF cl_null(l_pmcm.pmcmseq) THEN LET l_pmcm.pmcmseq = 1 END IF
#      IF p_i = 2 THEN
#         LET l_pmcm.pmcmseq = l_pmcm.pmcmseq + 1
#      END IF
#      LET g_pmcm_d[p_num].* = l_pmcm.*
#      DISPLAY BY NAME g_pmcm_d[p_num].*
#      IF p_i > 1 THEN
         INSERT INTO pmcm_t(pmcment,pmcmdocno,pmcmseq,pmcm001,pmcm002,pmcm003,pmcm004,pmcm005,pmcm006,pmcm007,pmcm008,pmcm009) 
                     VALUES(g_enterprise,g_pmcl_m.pmcldocno,l_pmcm.pmcmseq,l_pmcm.pmcm001,l_pmcm.pmcm002,l_pmcm.pmcm003,l_pmcm.pmcm004,
                            l_pmcm.pmcm005,l_pmcm.pmcm006,l_pmcm.pmcm007,l_pmcm.pmcm008,l_pmcm.pmcm009)
#      END IF
   END IF
END FUNCTION
# 显示得分
PRIVATE FUNCTION apmt814_score_desc(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1 
   IF NOT cl_null(g_pmcm_d[l_ac].pmcm001) AND NOT cl_null(g_pmcm_d[l_ac].pmcm002) AND NOT cl_null(g_pmcm_d[l_ac].pmcm003) THEN    
      #IF p_cmd = 'a' OR (p_cmd='u' AND (g_pmcm_d_t.pmcm001 !=g_pmcm_d[l_ac].pmcm001 OR g_pmcm_d_t.pmcm002 !=g_pmcm_d[l_ac].pmcm002 OR g_pmcm_d_t.pmcm003 !=g_pmcm_d[l_ac].pmcm003)) THEN   #160824-00007#16 20160914 mark by beckxie
      IF g_pmcm_d_o.pmcm001 !=g_pmcm_d[l_ac].pmcm001 OR g_pmcm_d_o.pmcm002 !=g_pmcm_d[l_ac].pmcm002 OR g_pmcm_d_o.pmcm003 !=g_pmcm_d[l_ac].pmcm003 THEN   #160824-00007#16 20160914 add by beckxie
         SELECT NVL(pmck004,0),NVL(pmck005,0),NVL(pmck006,0),NVL(pmck007,''),oocql004 
           INTO g_pmcm_d[l_ac].pmcm004,g_pmcm_d[l_ac].pmcm005,
                g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009,g_pmcm_d[l_ac].pmcm009_desc
           FROM pmck_t LEFT OUTER JOIN oocql_t ON oocqlent = g_enterprise AND oocql001 = '2054' AND oocql002 = pmck007 AND oocql003 = g_dlang
          WHERE pmckent = g_enterprise 
            AND pmck001 = g_pmcm_d[l_ac].pmcm002
            AND pmck002 = g_pmcm_d[l_ac].pmcm003
            AND pmck003 = g_pmcm_d[l_ac].pmcm001
         CALL apmt814_pmcf003_desc(g_pmcm_d[l_ac].pmcm002,g_pmcm_d[l_ac].pmcm003,g_pmcm_d[l_ac].pmcm005) RETURNING g_pmcm_d[l_ac].pmcf003,g_pmcm_d[l_ac].pmcf003_desc
         LET g_pmcm_d[l_ac].pmcm006 = g_pmcm_d[l_ac].pmcm005
         SELECT NVL(MAX(pmcm007),0) INTO g_pmcm_d[l_ac].pmcm007 FROM pmcm_t,pmcl_t 
          WHERE pmcm001 = g_pmcm_d[l_ac].pmcm001
            AND pmcm002 = g_pmcm_d[l_ac].pmcm002
            AND pmcm003 = g_pmcm_d[l_ac].pmcm003
            AND pmcment = g_enterprise 
            AND pmclent = pmcment 
            AND pmcldocno = pmcmdocno
            AND pmclstus <> 'X'
         LET g_pmcm_d[l_ac].pmcm007 = g_pmcm_d[l_ac].pmcm007 + 1
         DISPLAY BY NAME g_pmcm_d[l_ac].pmcm004,g_pmcm_d[l_ac].pmcm005,g_pmcm_d[l_ac].pmcm006,
                         g_pmcm_d[l_ac].pmcm007,g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009,g_pmcm_d[l_ac].pmcm009_desc
         CALL apmt814_pmcm001_desc()
         CALL apmt814_pmcm003_desc()         
      END IF
  END IF
END FUNCTION

PRIVATE FUNCTION apmt814_pmcm006_chk()
   IF g_pmcm_d[l_ac].pmcm006 < 1 OR g_pmcm_d[l_ac].pmcm006 > 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = g_pmcm_d[l_ac].pmcm006
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      SELECT pmcf003,pmcf006,oocql004 INTO g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009,g_pmcm_d[l_ac].pmcm009_desc
        FROM pmcf_t LEFT OUTER JOIN oocql_t ON oocqlent = g_enterprise AND oocql001 = '2054' AND oocql002 = pmcf006 AND oocql003 = g_dlang
       WHERE pmcfent = g_enterprise 
         AND pmcf001 = g_pmcm_d[l_ac].pmcm002
         AND pmcf002 = g_pmcm_d[l_ac].pmcm003
         AND pmcf004 <= g_pmcm_d[l_ac].pmcm006  
         AND pmcf005 >= g_pmcm_d[l_ac].pmcm006 
      DISPLAY BY NAME g_pmcm_d[l_ac].pmcm008,g_pmcm_d[l_ac].pmcm009,g_pmcm_d[l_ac].pmcm009_desc
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmcm_d[l_ac].pmcm008
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmcm_d[l_ac].pmcm008_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmcm_d[l_ac].pmcm008_desc
      RETURN TRUE
   END IF
END FUNCTION
#+
PRIVATE FUNCTION apmt814_pmcl001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcl_m.pmcl001
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM ooag_t LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = "||g_enterprise||" WHERE ooagent="||g_enterprise||" AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pmcl_m.pmcl001_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcl_m.pmcl001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcl_m.pmcl002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooefl001 =? AND ooeflent = "||g_enterprise||" AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcl_m.pmcl002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcl_m.pmcl002_desc
END FUNCTION
#+
PRIVATE FUNCTION apmt814_pmck_chk(p_cmd,p_pmcm001,p_pmcm002,p_pmcm003)
DEFINE l_n        LIKE type_t.num5
DEFINE p_cmd      LIKE type_t.chr1
DEFINE p_pmcm001  LIKE pmcm_t.pmcm001
DEFINE p_pmcm002  LIKE pmcm_t.pmcm002
DEFINE p_pmcm003  LIKE pmcm_t.pmcm003
   IF NOT cl_null(p_pmcm001) AND NOT cl_null(p_pmcm002) AND NOT cl_null(p_pmcm003) THEN
      #IF p_cmd = 'a' OR (p_cmd='u' AND (g_pmcm_d_t.pmcm001 !=p_pmcm001 OR g_pmcm_d_t.pmcm002 !=p_pmcm002 OR g_pmcm_d_t.pmcm003 !=p_pmcm003)) THEN   #160824-00007#16 20160914 mark by beckxie
      IF g_pmcm_d_o.pmcm001 !=p_pmcm001 OR g_pmcm_d_o.pmcm002 !=p_pmcm002 OR g_pmcm_d_o.pmcm003 !=p_pmcm003 THEN   #160824-00007#16 20160914 add by beckxie
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM pmck_t
          WHERE pmck003 = p_pmcm001
            AND pmck001 = p_pmcm002
            AND pmck002 = p_pmcm003
            AND pmckent = g_enterprise
         IF l_n = 0 THEN
           RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apmt814_pmcm001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcm_d[l_ac].pmcm001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcm_d[l_ac].pmcm001_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcm_d[l_ac].pmcm001_desc
END FUNCTION

PRIVATE FUNCTION apmt814_pmcm003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcm_d[l_ac].pmcm003
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcm_d[l_ac].pmcm003_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcm_d[l_ac].pmcm003_desc
END FUNCTION

PRIVATE FUNCTION apmt814_pmcf003_desc(p_pmcm002,p_pmcm003,p_pmcm005)
DEFINE r_pmcf003       LIKE pmcf_t.pmcf003
DEFINE r_pmcf003_desc  LIKE oocql_t.oocql004
DEFINE p_pmcm002       LIKE pmcm_t.pmcm002
DEFINE p_pmcm003       LIKE pmcm_t.pmcm003
DEFINE p_pmcm005       LIKE pmcm_t.pmcm005
   IF NOT cl_null(p_pmcm005) THEN
      SELECT pmcf003,oocql004 INTO r_pmcf003,r_pmcf003_desc
        FROM pmcf_t LEFT OUTER JOIN oocql_t ON oocqlent = g_enterprise AND oocql001 = '2053' AND oocql002 = pmcf006 AND oocql003 = g_dlang
       WHERE pmcfent = g_enterprise 
         AND pmcf001 = p_pmcm002
         AND pmcf002 = p_pmcm003
         AND pmcf004 <= p_pmcm005  
         AND pmcf005 >= p_pmcm005 
   END IF
   RETURN r_pmcf003,r_pmcf003_desc
END FUNCTION

PRIVATE FUNCTION apmt814_pmcm007_max_chk(p_pmcm001,p_pmcm002,p_pmcm003)
DEFINE p_pmcm001   LIKE pmcm_t.pmcm001
DEFINE p_pmcm002   LIKE pmcm_t.pmcm002
DEFINE p_pmcm003   LIKE pmcm_t.pmcm003
DEFINE r_pmcm007   LIKE pmcm_t.pmcm007
   SELECT NVL(MAX(pmcm007),0) INTO r_pmcm007 FROM pmcm_t,pmcl_t 
          WHERE pmcm001 = p_pmcm001
            AND pmcm002 = p_pmcm002
            AND pmcm003 = p_pmcm003
            AND pmcment = g_enterprise 
            AND pmclent = pmcment 
            AND pmcldocno = pmcmdocno
            AND pmclstus <> 'X'
   RETURN r_pmcm007
END FUNCTION

 
{</section>}
 
