#該程式未解開Section, 採用最新樣板產出!
{<section id="adet403.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-03-30 11:42:44), PR版次:0011(2016-10-07 16:17:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000579
#+ Filename...: adet403
#+ Description: 營業款銀行存繳維護作業
#+ Creator....: 04226(2014-02-05 15:57:35)
#+ Modifier...: 02291 -SD/PR- 06137
 
{</section>}
 
{<section id="adet403.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160122-00001#16   2016/02/14 By yangtt 添加交易帳戶編號用戶權限空管
#160322-00010#1    2016/03/23 By 02599  修改交易帐号可录，受银行账户deal002的管控，检核也一样
#160816-00068#4    2016/08/16 By earl   調整transaction
#160818-00017#7    2016/08/24    by 08172  修改删除时重新检查状态
#160824-00007#68   2016/10/07 by 06137     修正舊值備份寫法
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
PRIVATE type type_g_deak_m        RECORD
       deaksite LIKE deak_t.deaksite, 
   deaksite_desc LIKE type_t.chr80, 
   deakdocdt LIKE deak_t.deakdocdt, 
   deakdocno LIKE deak_t.deakdocno, 
   deak001 LIKE deak_t.deak001, 
   deak001_desc LIKE type_t.chr80, 
   deak002 LIKE deak_t.deak002, 
   deak002_desc LIKE type_t.chr80, 
   deakunit LIKE deak_t.deakunit, 
   deakstus LIKE deak_t.deakstus, 
   deakownid LIKE deak_t.deakownid, 
   deakownid_desc LIKE type_t.chr80, 
   deakowndp LIKE deak_t.deakowndp, 
   deakowndp_desc LIKE type_t.chr80, 
   deakcrtid LIKE deak_t.deakcrtid, 
   deakcrtid_desc LIKE type_t.chr80, 
   deakcrtdp LIKE deak_t.deakcrtdp, 
   deakcrtdp_desc LIKE type_t.chr80, 
   deakcrtdt LIKE deak_t.deakcrtdt, 
   deakmodid LIKE deak_t.deakmodid, 
   deakmodid_desc LIKE type_t.chr80, 
   deakmoddt LIKE deak_t.deakmoddt, 
   deakcnfid LIKE deak_t.deakcnfid, 
   deakcnfid_desc LIKE type_t.chr80, 
   deakcnfdt LIKE deak_t.deakcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_deal_d        RECORD
       dealseq LIKE deal_t.dealseq, 
   deal001 LIKE deal_t.deal001, 
   deal012 LIKE deal_t.deal012, 
   deal012_desc LIKE type_t.chr500, 
   deal002 LIKE deal_t.deal002, 
   deal002_desc LIKE type_t.chr500, 
   deal003 LIKE deal_t.deal003, 
   deal004 LIKE deal_t.deal004, 
   deal004_desc LIKE type_t.chr500, 
   deal005 LIKE deal_t.deal005, 
   deal006 LIKE deal_t.deal006, 
   deal006_desc LIKE type_t.chr500, 
   deal007 LIKE deal_t.deal007, 
   deal008 LIKE deal_t.deal008, 
   deal009 LIKE deal_t.deal009, 
   deal010 LIKE deal_t.deal010, 
   deal011 LIKE deal_t.deal011, 
   dealsite LIKE deal_t.dealsite, 
   dealunit LIKE deal_t.dealunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_deaksite LIKE deak_t.deaksite,
   b_deaksite_desc LIKE type_t.chr80,
      b_deakdocdt LIKE deak_t.deakdocdt,
      b_deakdocno LIKE deak_t.deakdocno,
      b_deak001 LIKE deak_t.deak001,
   b_deak001_desc LIKE type_t.chr80,
      b_deak002 LIKE deak_t.deak002,
   b_deak002_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
DEFINE g_sql_bank            STRING #160122-00001#16 add by07675
#end add-point
       
#模組變數(Module Variables)
DEFINE g_deak_m          type_g_deak_m
DEFINE g_deak_m_t        type_g_deak_m
DEFINE g_deak_m_o        type_g_deak_m
DEFINE g_deak_m_mask_o   type_g_deak_m #轉換遮罩前資料
DEFINE g_deak_m_mask_n   type_g_deak_m #轉換遮罩後資料
 
   DEFINE g_deakdocno_t LIKE deak_t.deakdocno
 
 
DEFINE g_deal_d          DYNAMIC ARRAY OF type_g_deal_d
DEFINE g_deal_d_t        type_g_deal_d
DEFINE g_deal_d_o        type_g_deal_d
DEFINE g_deal_d_mask_o   DYNAMIC ARRAY OF type_g_deal_d #轉換遮罩前資料
DEFINE g_deal_d_mask_n   DYNAMIC ARRAY OF type_g_deal_d #轉換遮罩後資料
 
 
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
 
{<section id="adet403.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT deaksite,'',deakdocdt,deakdocno,deak001,'',deak002,'',deakunit,deakstus, 
       deakownid,'',deakowndp,'',deakcrtid,'',deakcrtdp,'',deakcrtdt,deakmodid,'',deakmoddt,deakcnfid, 
       '',deakcnfdt", 
                      " FROM deak_t",
                      " WHERE deakent= ? AND deakdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet403_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.deaksite,t0.deakdocdt,t0.deakdocno,t0.deak001,t0.deak002,t0.deakunit, 
       t0.deakstus,t0.deakownid,t0.deakowndp,t0.deakcrtid,t0.deakcrtdp,t0.deakcrtdt,t0.deakmodid,t0.deakmoddt, 
       t0.deakcnfid,t0.deakcnfdt,t1.ooefl003 ,t2.nmabl003 ,t3.ooag011 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 , 
       t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM deak_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t2 ON t2.nmablent="||g_enterprise||" AND t2.nmabl001=t0.deak001 AND t2.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.deak002  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.deakownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.deakowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.deakcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.deakcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.deakmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.deakcnfid  ",
 
               " WHERE t0.deakent = " ||g_enterprise|| " AND t0.deakdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adet403_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adet403 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adet403_init()   
 
      #進入選單 Menu (="N")
      CALL adet403_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adet403
      
   END IF 
   
   CLOSE adet403_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   CALL adet403_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adet403.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adet403_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
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
      CALL cl_set_combo_scc_part('deakstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('deal005','8310','10,30')
   LET g_errshow = 1
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   CALL adet403_create_tmp() RETURNING l_success
    #160122-00001#16--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#16 --add--end
   #end add-point
   
   #初始化搜尋條件
   CALL adet403_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adet403.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adet403_ui_dialog()
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
            CALL adet403_insert()
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
         INITIALIZE g_deak_m.* TO NULL
         CALL g_deal_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adet403_init()
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
               
               CALL adet403_fetch('') # reload data
               LET l_ac = 1
               CALL adet403_ui_detailshow() #Setting the current row 
         
               CALL adet403_idx_chk()
               #NEXT FIELD dealseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_deal_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet403_idx_chk()
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
               CALL adet403_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL adet403_browser_fill("")
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
               CALL adet403_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adet403_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adet403_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adet403_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adet403_set_act_visible()   
            CALL adet403_set_act_no_visible()
            IF NOT (g_deak_m.deakdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " deakent = " ||g_enterprise|| " AND",
                                  " deakdocno = '", g_deak_m.deakdocno, "' "
 
               #填到對應位置
               CALL adet403_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "deak_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deal_t" 
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
               CALL adet403_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "deak_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deal_t" 
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
                  CALL adet403_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adet403_fetch("F")
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
               CALL adet403_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adet403_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet403_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adet403_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet403_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adet403_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet403_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adet403_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet403_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adet403_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet403_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_deal_d)
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
               NEXT FIELD dealseq
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
               CALL adet403_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#7 -s by 08172
               CALL adet403_set_act_visible()   
               CALL adet403_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adet403_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#7 -s by 08172
               CALL adet403_set_act_visible()   
               CALL adet403_set_act_no_visible()
               #160818-00017#7 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adet403_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#7 -s by 08172
               CALL adet403_set_act_visible()   
               CALL adet403_set_act_no_visible()
               #160818-00017#7 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adet403_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ade/adet403_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ade/adet403_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adet403_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adet403_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adet403_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adet403_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adet403_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_deak_m.deakdocdt)
 
 
 
         
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
 
{<section id="adet403.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adet403_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'deaksite') RETURNING l_where
   LET l_wc = l_wc," AND ",l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT deakdocno ",
                      " FROM deak_t ",
                      " ",
                      " LEFT JOIN deal_t ON dealent = deakent AND deakdocno = dealdocno ", "  ",
                      #add-point:browser_fill段sql(deal_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE deakent = " ||g_enterprise|| " AND dealent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deak_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deakdocno ",
                      " FROM deak_t ", 
                      "  ",
                      "  ",
                      " WHERE deakent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("deak_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #160122-00001#16----add--str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT deakdocno ",
                      " FROM deak_t,deal_t ",
                      " WHERE dealent = deakent AND deakdocno = dealdocno ",
                      "   AND deakent = '" ||g_enterprise|| "' AND dealent = '" ||g_enterprise|| "'",
#                      "   AND deal002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') ",
                      "   AND deal002 IN(",g_sql_bank,") ",#160122-00001#16 mod by 07675
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deak_t"),
                      " UNION ",
                      " SELECT DISTINCT deakdocno ",
                      " FROM deak_t ",
                      " LEFT JOIN deal_t ON dealent = deakent AND deakdocno = dealdocno ", "  ",
                      " WHERE deakent = '" ||g_enterprise|| "' AND dealent = '" ||g_enterprise|| "'",
                      "   AND TRIM(deal002) IS NULL",
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deak_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deakdocno ",
                      " FROM deak_t,deal_t ", 
                      " WHERE dealent = deakent AND deakdocno = dealdocno ",
                      "   AND deakent = '" ||g_enterprise|| "' ",
#                      "   AND deal002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') ",
                      "   AND deal002 IN(",g_sql_bank,") ",#160122-00001#16 mod by 07675
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("deak_t"),
                      " UNION ",
                      " SELECT DISTINCT deakdocno ",
                      " FROM deak_t ", 
                      " LEFT JOIN deal_t ON dealent = deakent AND deakdocno = dealdocno ", "  ",
                      " WHERE deakent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(deal002) IS NULL",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("deak_t")
                      
   END IF
   #160122-00001#16----add--end
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
      INITIALIZE g_deak_m.* TO NULL
      CALL g_deal_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.deaksite,t0.deakdocdt,t0.deakdocno,t0.deak001,t0.deak002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deakstus,t0.deaksite,t0.deakdocdt,t0.deakdocno,t0.deak001,t0.deak002, 
          t1.ooefl003 ,t2.nmabl003 ,t3.ooag011 ",
                  " FROM deak_t t0",
                  "  ",
                  "  LEFT JOIN deal_t ON dealent = deakent AND deakdocno = dealdocno ", "  ", 
                  #add-point:browser_fill段sql(deal_t1) name="browser_fill.join.deal_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t2 ON t2.nmablent="||g_enterprise||" AND t2.nmabl001=t0.deak001 AND t2.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.deak002  ",
 
                  " WHERE t0.deakent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deak_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deakstus,t0.deaksite,t0.deakdocdt,t0.deakdocno,t0.deak001,t0.deak002, 
          t1.ooefl003 ,t2.nmabl003 ,t3.ooag011 ",
                  " FROM deak_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t2 ON t2.nmablent="||g_enterprise||" AND t2.nmabl001=t0.deak001 AND t2.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.deak002  ",
 
                  " WHERE t0.deakent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("deak_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #160122-00001#16----add--str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deakstus,t0.deaksite,t0.deakdocdt,t0.deakdocno,t0.deak001,t0.deak002, 
          t1.ooefl003 ,t2.nmabl003 ,t3.ooag011 ",
                  " FROM deak_t t0",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.deaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t2 ON t2.nmablent='"||g_enterprise||"' AND t2.nmabl001=t0.deak001 AND t2.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.deak002  ",
 
                  "  ,deal_t ",
                  " WHERE dealent = deakent AND deakdocno = dealdocno ",
                  "   AND t0.deakent = '" ||g_enterprise|| "' ",
#                  "   AND deal002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') ",
                  "   AND deal002 IN(",g_sql_bank,") ",#160122-00001#16 mod by 07675
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deak_t"),
                  " UNION ",
                  " SELECT DISTINCT t4.deakstus,t4.deaksite,t4.deakdocdt,t4.deakdocno,t4.deak001,t4.deak002, 
          t5.ooefl003 ,t6.nmabl003 ,t7.ooag011 ",
                  " FROM deak_t t4",
                  "  ",
                  "  LEFT JOIN deal_t ON dealent = deakent AND deakdocno = dealdocno ", "  ", 
 
                  "  ",
                                 " LEFT JOIN ooefl_t t5 ON t1.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t4.deaksite AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t6 ON t6.nmablent='"||g_enterprise||"' AND t6.nmabl001=t4.deak001 AND t6.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t4.deak002  ",
 
                  " WHERE t4.deakent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(deal002) IS NULL",
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deak_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deakstus,t0.deaksite,t0.deakdocdt,t0.deakdocno,t0.deak001,t0.deak002, 
          t1.ooefl003 ,t2.nmabl003 ,t3.ooag011 ",
                  " FROM deak_t t0",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.deaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t2 ON t2.nmablent='"||g_enterprise||"' AND t2.nmabl001=t0.deak001 AND t2.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.deak002  ",
 
                  "  ,deal_t ",
                  " WHERE dealent = t0.deakent AND t0.deakdocno = dealdocno",
                  "   AND t0.deakent = '" ||g_enterprise|| "' ",
#                  "   AND deal002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') ",
                  "   AND deal002 IN(",g_sql_bank,") ",#160122-00001#16 mod by 07675
                  "   AND ",l_wc, cl_sql_add_filter("deak_t"),
                  " UNION ",
                  " SELECT DISTINCT t4.deakstus,t4.deaksite,t4.deakdocdt,t4.deakdocno,t4.deak001,t4.deak002, 
          t5.ooefl003 ,t6.nmabl003 ,t7.ooag011 ",
                  " FROM deak_t t4",
                  "  LEFT JOIN deal_t ON dealent = t4.deakent AND t4.deakdocno = dealdocno ",
                  " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t4.deaksite AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t6 ON t6.nmablent='"||g_enterprise||"' AND t6.nmabl001=t4.deak001 AND t6.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t4.deak002  ",
 
                  " WHERE t4.deakent = '" ||g_enterprise|| "' ",
                  "   AND  TRIM(deal002) IS NULL",
                  "   AND ",l_wc, cl_sql_add_filter("deak_t")
                  
   END IF
   #160122-00001#16----add--end
   #end add-point
   LET g_sql = g_sql, " ORDER BY deakdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"deak_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_deaksite,g_browser[g_cnt].b_deakdocdt, 
          g_browser[g_cnt].b_deakdocno,g_browser[g_cnt].b_deak001,g_browser[g_cnt].b_deak002,g_browser[g_cnt].b_deaksite_desc, 
          g_browser[g_cnt].b_deak001_desc,g_browser[g_cnt].b_deak002_desc
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
         CALL adet403_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_deakdocno) THEN
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
 
{<section id="adet403.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adet403_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_deak_m.deakdocno = g_browser[g_current_idx].b_deakdocno   
 
   EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
       g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
       g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
       g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
       g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
   
   CALL adet403_deak_t_mask()
   CALL adet403_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adet403.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adet403_ui_detailshow()
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
 
{<section id="adet403.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adet403_ui_browser_refresh()
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
      IF g_browser[l_i].b_deakdocno = g_deak_m.deakdocno 
 
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
 
{<section id="adet403.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adet403_construct()
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
   INITIALIZE g_deak_m.* TO NULL
   CALL g_deal_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON deaksite,deakdocdt,deakdocno,deak001,deak002,deakunit,deakstus,deakownid, 
          deakowndp,deakcrtid,deakcrtdp,deakcrtdt,deakmodid,deakmoddt,deakcnfid,deakcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<deakcrtdt>>----
         AFTER FIELD deakcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<deakmoddt>>----
         AFTER FIELD deakmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deakcnfdt>>----
         AFTER FIELD deakcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deakpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.deaksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaksite
            #add-point:ON ACTION controlp INFIELD deaksite name="construct.c.deaksite"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaksite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaksite  #顯示到畫面上

            NEXT FIELD deaksite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaksite
            #add-point:BEFORE FIELD deaksite name="construct.b.deaksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaksite
            
            #add-point:AFTER FIELD deaksite name="construct.a.deaksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakdocdt
            #add-point:BEFORE FIELD deakdocdt name="construct.b.deakdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakdocdt
            
            #add-point:AFTER FIELD deakdocdt name="construct.a.deakdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deakdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakdocdt
            #add-point:ON ACTION controlp INFIELD deakdocdt name="construct.c.deakdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deakdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakdocno
            #add-point:ON ACTION controlp INFIELD deakdocno name="construct.c.deakdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			
            CALL q_deakdocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakdocno  #顯示到畫面上

            NEXT FIELD deakdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakdocno
            #add-point:BEFORE FIELD deakdocno name="construct.b.deakdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakdocno
            
            #add-point:AFTER FIELD deakdocno name="construct.a.deakdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deak001
            #add-point:ON ACTION controlp INFIELD deak001 name="construct.c.deak001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #160322-00010#1--add--str--
            LET g_qryparam.where = " nmab001 IN (SELECT DISTINCT nmaa004 FROM nmaa_t,nmas_t ",
                                   "              WHERE nmaaent=nmasent AND nmaa001=nmas001 ",
                                   "                AND nmaaent=",g_enterprise," AND nmaastus='Y'",
                                   "                AND nmas002 IN (",g_sql_bank,")",
                                   "             )"
            #160322-00010#1--add--end
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deak001  #顯示到畫面上

            NEXT FIELD deak001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deak001
            #add-point:BEFORE FIELD deak001 name="construct.b.deak001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deak001
            
            #add-point:AFTER FIELD deak001 name="construct.a.deak001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deak002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deak002
            #add-point:ON ACTION controlp INFIELD deak002 name="construct.c.deak002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_site
            CALL q_ooag001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deak002  #顯示到畫面上

            NEXT FIELD deak002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deak002
            #add-point:BEFORE FIELD deak002 name="construct.b.deak002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deak002
            
            #add-point:AFTER FIELD deak002 name="construct.a.deak002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakunit
            #add-point:BEFORE FIELD deakunit name="construct.b.deakunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakunit
            
            #add-point:AFTER FIELD deakunit name="construct.a.deakunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deakunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakunit
            #add-point:ON ACTION controlp INFIELD deakunit name="construct.c.deakunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakstus
            #add-point:BEFORE FIELD deakstus name="construct.b.deakstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakstus
            
            #add-point:AFTER FIELD deakstus name="construct.a.deakstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakstus
            #add-point:ON ACTION controlp INFIELD deakstus name="construct.c.deakstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deakownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakownid
            #add-point:ON ACTION controlp INFIELD deakownid name="construct.c.deakownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakownid  #顯示到畫面上

            NEXT FIELD deakownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakownid
            #add-point:BEFORE FIELD deakownid name="construct.b.deakownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakownid
            
            #add-point:AFTER FIELD deakownid name="construct.a.deakownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deakowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakowndp
            #add-point:ON ACTION controlp INFIELD deakowndp name="construct.c.deakowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakowndp  #顯示到畫面上

            NEXT FIELD deakowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakowndp
            #add-point:BEFORE FIELD deakowndp name="construct.b.deakowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakowndp
            
            #add-point:AFTER FIELD deakowndp name="construct.a.deakowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deakcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakcrtid
            #add-point:ON ACTION controlp INFIELD deakcrtid name="construct.c.deakcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakcrtid  #顯示到畫面上

            NEXT FIELD deakcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakcrtid
            #add-point:BEFORE FIELD deakcrtid name="construct.b.deakcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakcrtid
            
            #add-point:AFTER FIELD deakcrtid name="construct.a.deakcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deakcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakcrtdp
            #add-point:ON ACTION controlp INFIELD deakcrtdp name="construct.c.deakcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakcrtdp  #顯示到畫面上

            NEXT FIELD deakcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakcrtdp
            #add-point:BEFORE FIELD deakcrtdp name="construct.b.deakcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakcrtdp
            
            #add-point:AFTER FIELD deakcrtdp name="construct.a.deakcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakcrtdt
            #add-point:BEFORE FIELD deakcrtdt name="construct.b.deakcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deakmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakmodid
            #add-point:ON ACTION controlp INFIELD deakmodid name="construct.c.deakmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakmodid  #顯示到畫面上

            NEXT FIELD deakmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakmodid
            #add-point:BEFORE FIELD deakmodid name="construct.b.deakmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakmodid
            
            #add-point:AFTER FIELD deakmodid name="construct.a.deakmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakmoddt
            #add-point:BEFORE FIELD deakmoddt name="construct.b.deakmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deakcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakcnfid
            #add-point:ON ACTION controlp INFIELD deakcnfid name="construct.c.deakcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deakcnfid  #顯示到畫面上

            NEXT FIELD deakcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakcnfid
            #add-point:BEFORE FIELD deakcnfid name="construct.b.deakcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakcnfid
            
            #add-point:AFTER FIELD deakcnfid name="construct.a.deakcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakcnfdt
            #add-point:BEFORE FIELD deakcnfdt name="construct.b.deakcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON dealseq,deal001,deal012,deal002,deal003,deal004,deal005,deal006,deal007, 
          deal008,deal009,deal010,deal011,dealsite,dealunit
           FROM s_detail1[1].dealseq,s_detail1[1].deal001,s_detail1[1].deal012,s_detail1[1].deal002, 
               s_detail1[1].deal003,s_detail1[1].deal004,s_detail1[1].deal005,s_detail1[1].deal006,s_detail1[1].deal007, 
               s_detail1[1].deal008,s_detail1[1].deal009,s_detail1[1].deal010,s_detail1[1].deal011,s_detail1[1].dealsite, 
               s_detail1[1].dealunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dealseq
            #add-point:BEFORE FIELD dealseq name="construct.b.page1.dealseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dealseq
            
            #add-point:AFTER FIELD dealseq name="construct.a.page1.dealseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dealseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dealseq
            #add-point:ON ACTION controlp INFIELD dealseq name="construct.c.page1.dealseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal001
            #add-point:BEFORE FIELD deal001 name="construct.b.page1.deal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal001
            
            #add-point:AFTER FIELD deal001 name="construct.a.page1.deal001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal001
            #add-point:ON ACTION controlp INFIELD deal001 name="construct.c.page1.deal001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deal012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal012
            #add-point:ON ACTION controlp INFIELD deal012 name="construct.c.page1.deal012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160322-00010#1--add--str--
            LET g_qryparam.where = " nmab001 IN (SELECT DISTINCT nmaa004 FROM nmaa_t,nmas_t ",
                                   "              WHERE nmaaent=nmasent AND nmaa001=nmas001 ",
                                   "                AND nmaaent=",g_enterprise," AND nmaastus='Y'",
                                   "                AND nmas002 IN (",g_sql_bank,")",
                                   "             )"
            #160322-00010#1--add--end
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deal012  #顯示到畫面上
            NEXT FIELD deal012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal012
            #add-point:BEFORE FIELD deal012 name="construct.b.page1.deal012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal012
            
            #add-point:AFTER FIELD deal012 name="construct.a.page1.deal012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal002
            #add-point:ON ACTION controlp INFIELD deal002 name="construct.c.page1.deal002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
			   #160322-00010#1--mod--str--
			   #160122-00001#16--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
#             LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"#160122-00001#16 mod by 07675
            #160122-00001#16--add---end
#            CALL q_nmas002()                     #呼叫開窗
            LET g_qryparam.where = " nmaastus = 'Y'",
                                   " AND nmaa001 IN (SELECT DISTINCT nmas001 FROM nmas_t ",
                                   "                  WHERE nmasent=",g_enterprise,
                                   "                    AND nmas002 IN (",g_sql_bank,")",
                                   "                 )"
            CALL q_nmaa001()
            #160322-00010#1--mod--end
            DISPLAY g_qryparam.return1 TO deal002  #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#16

            NEXT FIELD deal002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal002
            #add-point:BEFORE FIELD deal002 name="construct.b.page1.deal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal002
            
            #add-point:AFTER FIELD deal002 name="construct.a.page1.deal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal003
            #add-point:ON ACTION controlp INFIELD deal003 name="construct.c.page1.deal003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160322-00010#1--add--str--
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deal003  #顯示到畫面上
            NEXT FIELD deal003                     #返回原欄位
            #160322-00010#1--add--end



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal003
            #add-point:BEFORE FIELD deal003 name="construct.b.page1.deal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal003
            
            #add-point:AFTER FIELD deal003 name="construct.a.page1.deal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal004
            #add-point:ON ACTION controlp INFIELD deal004 name="construct.c.page1.deal004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deal004  #顯示到畫面上

            NEXT FIELD deal004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal004
            #add-point:BEFORE FIELD deal004 name="construct.b.page1.deal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal004
            
            #add-point:AFTER FIELD deal004 name="construct.a.page1.deal004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal005
            #add-point:BEFORE FIELD deal005 name="construct.b.page1.deal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal005
            
            #add-point:AFTER FIELD deal005 name="construct.a.page1.deal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal005
            #add-point:ON ACTION controlp INFIELD deal005 name="construct.c.page1.deal005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deal006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal006
            #add-point:ON ACTION controlp INFIELD deal006 name="construct.c.page1.deal006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deal006  #顯示到畫面上

            NEXT FIELD deal006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal006
            #add-point:BEFORE FIELD deal006 name="construct.b.page1.deal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal006
            
            #add-point:AFTER FIELD deal006 name="construct.a.page1.deal006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal007
            #add-point:BEFORE FIELD deal007 name="construct.b.page1.deal007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal007
            
            #add-point:AFTER FIELD deal007 name="construct.a.page1.deal007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal007
            #add-point:ON ACTION controlp INFIELD deal007 name="construct.c.page1.deal007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deal008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal008
            #add-point:ON ACTION controlp INFIELD deal008 name="construct.c.page1.deal008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_deal008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deal008  #顯示到畫面上

            NEXT FIELD deal008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal008
            #add-point:BEFORE FIELD deal008 name="construct.b.page1.deal008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal008
            
            #add-point:AFTER FIELD deal008 name="construct.a.page1.deal008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal009
            #add-point:ON ACTION controlp INFIELD deal009 name="construct.c.page1.deal009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_deabdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deal009  #顯示到畫面上
            NEXT FIELD deal009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal009
            #add-point:BEFORE FIELD deal009 name="construct.b.page1.deal009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal009
            
            #add-point:AFTER FIELD deal009 name="construct.a.page1.deal009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal010
            #add-point:BEFORE FIELD deal010 name="construct.b.page1.deal010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal010
            
            #add-point:AFTER FIELD deal010 name="construct.a.page1.deal010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal010
            #add-point:ON ACTION controlp INFIELD deal010 name="construct.c.page1.deal010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal011
            #add-point:BEFORE FIELD deal011 name="construct.b.page1.deal011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal011
            
            #add-point:AFTER FIELD deal011 name="construct.a.page1.deal011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deal011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal011
            #add-point:ON ACTION controlp INFIELD deal011 name="construct.c.page1.deal011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dealsite
            #add-point:BEFORE FIELD dealsite name="construct.b.page1.dealsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dealsite
            
            #add-point:AFTER FIELD dealsite name="construct.a.page1.dealsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dealsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dealsite
            #add-point:ON ACTION controlp INFIELD dealsite name="construct.c.page1.dealsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dealunit
            #add-point:BEFORE FIELD dealunit name="construct.b.page1.dealunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dealunit
            
            #add-point:AFTER FIELD dealunit name="construct.a.page1.dealunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dealunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dealunit
            #add-point:ON ACTION controlp INFIELD dealunit name="construct.c.page1.dealunit"
            
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
                  WHEN la_wc[li_idx].tableid = "deak_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "deal_t" 
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
 
{<section id="adet403.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adet403_filter()
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
      CONSTRUCT g_wc_filter ON deaksite,deakdocdt,deakdocno,deak001,deak002
                          FROM s_browse[1].b_deaksite,s_browse[1].b_deakdocdt,s_browse[1].b_deakdocno, 
                              s_browse[1].b_deak001,s_browse[1].b_deak002
 
         BEFORE CONSTRUCT
               DISPLAY adet403_filter_parser('deaksite') TO s_browse[1].b_deaksite
            DISPLAY adet403_filter_parser('deakdocdt') TO s_browse[1].b_deakdocdt
            DISPLAY adet403_filter_parser('deakdocno') TO s_browse[1].b_deakdocno
            DISPLAY adet403_filter_parser('deak001') TO s_browse[1].b_deak001
            DISPLAY adet403_filter_parser('deak002') TO s_browse[1].b_deak002
      
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
 
      CALL adet403_filter_show('deaksite')
   CALL adet403_filter_show('deakdocdt')
   CALL adet403_filter_show('deakdocno')
   CALL adet403_filter_show('deak001')
   CALL adet403_filter_show('deak002')
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adet403_filter_parser(ps_field)
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
 
{<section id="adet403.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adet403_filter_show(ps_field)
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
   LET ls_condition = adet403_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adet403_query()
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
   CALL g_deal_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adet403_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adet403_browser_fill("")
      CALL adet403_fetch("")
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
      CALL adet403_filter_show('deaksite')
   CALL adet403_filter_show('deakdocdt')
   CALL adet403_filter_show('deakdocno')
   CALL adet403_filter_show('deak001')
   CALL adet403_filter_show('deak002')
   CALL adet403_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adet403_fetch("F") 
      #顯示單身筆數
      CALL adet403_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adet403_fetch(p_flag)
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
   
   LET g_deak_m.deakdocno = g_browser[g_current_idx].b_deakdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
       g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
       g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
       g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
       g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
   
   #遮罩相關處理
   LET g_deak_m_mask_o.* =  g_deak_m.*
   CALL adet403_deak_t_mask()
   LET g_deak_m_mask_n.* =  g_deak_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet403_set_act_visible()   
   CALL adet403_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #IF g_deak_m.deakstus = 'N' THEN
   IF g_deak_m.deakstus MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF

   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_deak_m_t.* = g_deak_m.*
   LET g_deak_m_o.* = g_deak_m.*
   
   LET g_data_owner = g_deak_m.deakownid      
   LET g_data_dept  = g_deak_m.deakowndp
   
   #重新顯示   
   CALL adet403_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.insert" >}
#+ 資料新增
PRIVATE FUNCTION adet403_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004
   DEFINE l_insert        LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_deal_d.clear()   
 
 
   INITIALIZE g_deak_m.* TO NULL             #DEFAULT 設定
   
   LET g_deakdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deak_m.deakownid = g_user
      LET g_deak_m.deakowndp = g_dept
      LET g_deak_m.deakcrtid = g_user
      LET g_deak_m.deakcrtdp = g_dept 
      LET g_deak_m.deakcrtdt = cl_get_current()
      LET g_deak_m.deakmodid = g_user
      LET g_deak_m.deakmoddt = cl_get_current()
      LET g_deak_m.deakstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_deak_m.deak002 = g_user
      LET g_deak_m.deakstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'deaksite',g_deak_m.deaksite)
         RETURNING l_insert,g_deak_m.deaksite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL s_aooi500_default(g_prog,'deakunit',g_deak_m.deaksite)
         RETURNING l_insert,g_deak_m.deakunit
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
      DISPLAY BY NAME g_deak_m.deaksite_desc
      LET g_deak_m.deakdocdt = g_today
      LET g_deak_m.deak002 = g_user
      CALL s_desc_get_person_desc(g_deak_m.deak002) RETURNING g_deak_m.deak002_desc
      DISPLAY BY NAME g_deak_m.deak002_desc
      
      #預設單據的單別
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_deak_m.deaksite,g_prog,'1') 
         RETURNING l_success,l_doctype
      LET g_deak_m.deakdocno = l_doctype
      LET g_deak_m_t.* = g_deak_m.*
      LET g_deak_m_o.* = g_deak_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_deak_m_t.* = g_deak_m.*
      LET g_deak_m_o.* = g_deak_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deak_m.deakstus 
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
 
 
 
    
      CALL adet403_input("a")
      
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
         INITIALIZE g_deak_m.* TO NULL
         INITIALIZE g_deal_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adet403_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_deal_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet403_set_act_visible()   
   CALL adet403_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deakdocno_t = g_deak_m.deakdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deakent = " ||g_enterprise|| " AND",
                      " deakdocno = '", g_deak_m.deakdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet403_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adet403_cl
   
   CALL adet403_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
       g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
       g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
       g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
       g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
   
   
   #遮罩相關處理
   LET g_deak_m_mask_o.* =  g_deak_m.*
   CALL adet403_deak_t_mask()
   LET g_deak_m_mask_n.* =  g_deak_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deak_m.deaksite,g_deak_m.deaksite_desc,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001, 
       g_deak_m.deak001_desc,g_deak_m.deak002,g_deak_m.deak002_desc,g_deak_m.deakunit,g_deak_m.deakstus, 
       g_deak_m.deakownid,g_deak_m.deakownid_desc,g_deak_m.deakowndp,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid, 
       g_deak_m.deakcrtid_desc,g_deak_m.deakcrtdp,g_deak_m.deakcrtdp_desc,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmodid_desc,g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfid_desc,g_deak_m.deakcnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_deak_m.deakownid      
   LET g_data_dept  = g_deak_m.deakowndp
   
   #功能已完成,通報訊息中心
   CALL adet403_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.modify" >}
#+ 資料修改
PRIVATE FUNCTION adet403_modify()
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
   LET g_deak_m_t.* = g_deak_m.*
   LET g_deak_m_o.* = g_deak_m.*
   
   IF g_deak_m.deakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_deakdocno_t = g_deak_m.deakdocno
 
   CALL s_transaction_begin()
   
   OPEN adet403_cl USING g_enterprise,g_deak_m.deakdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet403_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet403_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
       g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
       g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
       g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
       g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
   
   #檢查是否允許此動作
   IF NOT adet403_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deak_m_mask_o.* =  g_deak_m.*
   CALL adet403_deak_t_mask()
   LET g_deak_m_mask_n.* =  g_deak_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adet403_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_deakdocno_t = g_deak_m.deakdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_deak_m.deakmodid = g_user 
LET g_deak_m.deakmoddt = cl_get_current()
LET g_deak_m.deakmodid_desc = cl_get_username(g_deak_m.deakmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_deak_m.deakstus MATCHES "[DR]" THEN 
         LET g_deak_m.deakstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adet403_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE deak_t SET (deakmodid,deakmoddt) = (g_deak_m.deakmodid,g_deak_m.deakmoddt)
          WHERE deakent = g_enterprise AND deakdocno = g_deakdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_deak_m.* = g_deak_m_t.*
            CALL adet403_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_deak_m.deakdocno != g_deak_m_t.deakdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE deal_t SET dealdocno = g_deak_m.deakdocno
 
          WHERE dealent = g_enterprise AND dealdocno = g_deak_m_t.deakdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "deal_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deal_t:",SQLERRMESSAGE 
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
   CALL adet403_set_act_visible()   
   CALL adet403_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " deakent = " ||g_enterprise|| " AND",
                      " deakdocno = '", g_deak_m.deakdocno, "' "
 
   #填到對應位置
   CALL adet403_browser_fill("")
 
   CLOSE adet403_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet403_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adet403.input" >}
#+ 資料輸入
PRIVATE FUNCTION adet403_input(p_cmd)
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
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_arg1                LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_where               STRING
   DEFINE  l_ooia002             LIKE ooia_t.ooia002  
   DEFINE  l_prog                LIKE type_t.chr10     
   DEFINE  l_ooie002             LIKE ooie_t.ooie002
   DEFINE  l_str                 STRING    
   DEFINE  l_dealdocno           LIKE deal_t.dealdocno #150630-00007#1 Add By Ken 150704
   DEFINE  l_deal001             LIKE deal_t.deal001   #150630-00007#1 Add By Ken 150704  
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
   DISPLAY BY NAME g_deak_m.deaksite,g_deak_m.deaksite_desc,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001, 
       g_deak_m.deak001_desc,g_deak_m.deak002,g_deak_m.deak002_desc,g_deak_m.deakunit,g_deak_m.deakstus, 
       g_deak_m.deakownid,g_deak_m.deakownid_desc,g_deak_m.deakowndp,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid, 
       g_deak_m.deakcrtid_desc,g_deak_m.deakcrtdp,g_deak_m.deakcrtdp_desc,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmodid_desc,g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfid_desc,g_deak_m.deakcnfdt 
 
   
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
   LET g_forupd_sql = "SELECT dealseq,deal001,deal012,deal002,deal003,deal004,deal005,deal006,deal007, 
       deal008,deal009,deal010,deal011,dealsite,dealunit FROM deal_t WHERE dealent=? AND dealdocno=?  
       AND dealseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet403_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adet403_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adet403_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_deak_m.deaksite,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002, 
       g_deak_m.deakunit,g_deak_m.deakstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adet403.input.head" >}
      #單頭段
      INPUT BY NAME g_deak_m.deaksite,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002, 
          g_deak_m.deakunit,g_deak_m.deakstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adet403_cl USING g_enterprise,g_deak_m.deakdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet403_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet403_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adet403_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL adet403_set_entry(p_cmd)
            CALL adet403_set_no_entry(p_cmd)
            #end add-point
            CALL adet403_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaksite
            
            #add-point:AFTER FIELD deaksite name="input.a.deaksite"
            #存繳營運組織(deaksite)
            LET g_deak_m.deak001_desc = ' '
            DISPLAY BY NAME g_deak_m.deaksite_desc
            IF NOT cl_null(g_deak_m.deaksite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deak_m.deaksite != g_deak_m_t.deaksite OR g_deak_m_t.deaksite IS NULL )) THEN
                  
                  CALL s_aooi500_chk(g_prog,'deaksite',g_deak_m.deaksite,g_deak_m.deaksite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_deak_m.deaksite = g_deak_m_t.deaksite
                     CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
                     DISPLAY BY NAME g_deak_m.deaksite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_deak_m.deakdocdt) AND NOT cl_null(g_deak_m.deaksite) THEN
                  IF NOT s_settledate_chk(g_deak_m.deaksite,g_deak_m.deakdocdt) THEN
                     LET g_deak_m.deaksite = g_deak_m_t.deaksite
                     CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
                     DISPLAY BY NAME g_deak_m.deaksite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            #150427-00016#3 150511 by sakura add---STR
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               LET g_deak_m.deaksite = g_deak_m_t.deaksite
               CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
               DISPLAY BY NAME g_deak_m.deaksite_desc
               NEXT FIELD CURRENT               
            #150427-00016#3 150511 by sakura add---END               
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
            DISPLAY BY NAME g_deak_m.deaksite_desc
            CALL adet403_set_entry(p_cmd)
            CALL adet403_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaksite
            #add-point:BEFORE FIELD deaksite name="input.b.deaksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaksite
            #add-point:ON CHANGE deaksite name="input.g.deaksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakdocdt
            #add-point:BEFORE FIELD deakdocdt name="input.b.deakdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakdocdt
            
            #add-point:AFTER FIELD deakdocdt name="input.a.deakdocdt"
           IF NOT cl_null(g_deak_m.deakdocdt) AND NOT cl_null(g_deak_m.deaksite) THEN
               IF NOT s_settledate_chk(g_deak_m.deaksite,g_deak_m.deakdocdt) THEN
                   LET g_deak_m.deakdocdt = g_deak_m_t.deakdocdt
                   DISPLAY BY NAME g_deak_m.deakdocdt
                   NEXT FIELD CURRENT
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deakdocdt
            #add-point:ON CHANGE deakdocdt name="input.g.deakdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakdocno
            #add-point:BEFORE FIELD deakdocno name="input.b.deakdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakdocno
            
            #add-point:AFTER FIELD deakdocno name="input.a.deakdocno"
            IF p_cmd = 'a' AND NOT cl_null(g_deak_m.deakdocno) THEN
               IF NOT s_aooi200_chk_slip(g_site,'',g_deak_m.deakdocno,g_prog) THEN
                  LET g_deak_m.deakdocno = g_deak_m_t.deakdocno
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deakdocno
            #add-point:ON CHANGE deakdocno name="input.g.deakdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deak001
            
            #add-point:AFTER FIELD deak001 name="input.a.deak001"
            #銀行編號 deak001
            LET g_deak_m.deak001_desc = ' '
            DISPLAY BY NAME g_deak_m.deak001_desc
            IF NOT cl_null(g_deak_m.deak001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deak_m.deak001 != g_deak_m_t.deak001 OR g_deak_m_t.deak001 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_deak_m.deak001
                  IF NOT cl_chk_exist("v_nmab001") THEN
                     LET g_deak_m.deak001 = g_deak_m_t.deak001
                     CALL adet403_deak001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL adet403_deak001_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deak001
            #add-point:BEFORE FIELD deak001 name="input.b.deak001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deak001
            #add-point:ON CHANGE deak001 name="input.g.deak001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deak002
            
            #add-point:AFTER FIELD deak002 name="input.a.deak002"
            #存繳人員 deak002
            LET g_deak_m.deak002_desc = ' '
            DISPLAY BY NAME g_deak_m.deak002_desc
            IF NOT cl_null(g_deak_m.deak002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deak_m.deak002 != g_deak_m_t.deak002 OR g_deak_m_t.deak002 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_deak_m.deak002
                  LET g_chkparam.arg2 = g_deak_m.deaksite
                  IF NOT cl_chk_exist("v_ooag001_2") THEN
                     LET g_deak_m.deak002 = g_deak_m_t.deak002
                     CALL s_desc_get_person_desc(g_deak_m.deak002) RETURNING g_deak_m.deak002_desc
                     DISPLAY BY NAME g_deak_m.deak002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_deak_m.deak002) RETURNING g_deak_m.deak002_desc
            DISPLAY BY NAME g_deak_m.deak002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deak002
            #add-point:BEFORE FIELD deak002 name="input.b.deak002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deak002
            #add-point:ON CHANGE deak002 name="input.g.deak002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakunit
            #add-point:BEFORE FIELD deakunit name="input.b.deakunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakunit
            
            #add-point:AFTER FIELD deakunit name="input.a.deakunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deakunit
            #add-point:ON CHANGE deakunit name="input.g.deakunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deakstus
            #add-point:BEFORE FIELD deakstus name="input.b.deakstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deakstus
            
            #add-point:AFTER FIELD deakstus name="input.a.deakstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deakstus
            #add-point:ON CHANGE deakstus name="input.g.deakstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deaksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaksite
            #add-point:ON ACTION controlp INFIELD deaksite name="input.c.deaksite"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deak_m.deaksite             #給予default值

             #給予arg
            CALL s_aooi500_q_where(g_prog,'deaksite','','i') RETURNING l_where #150308-00001#2  By sakura add 'i'
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()

            LET g_deak_m.deaksite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deak_m.deaksite TO deaksite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
            DISPLAY BY NAME g_deak_m.deaksite_desc
            NEXT FIELD deaksite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deakdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakdocdt
            #add-point:ON ACTION controlp INFIELD deakdocdt name="input.c.deakdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.deakdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakdocno
            #add-point:ON ACTION controlp INFIELD deakdocno name="input.c.deakdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deak_m.deakdocno             #給予default值

            #給予arg
            LET l_arg1 = ''
            SELECT ooef004 INTO l_arg1
              FROM ooef_t
             WHERE ooef001 = g_site
               AND ooefent = g_enterprise
            LET g_qryparam.arg1 = l_arg1    #參照表編號
            LET g_qryparam.arg2 = g_prog    #單據性質

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_deak_m.deakdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deak_m.deakdocno TO deakdocno              #顯示到畫面上

            NEXT FIELD deakdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deak001
            #add-point:ON ACTION controlp INFIELD deak001 name="input.c.deak001"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deak_m.deak001             #給予default值
            #160322-00010#1--add--str--
            LET g_qryparam.where = " nmab001 IN (SELECT DISTINCT nmaa004 FROM nmaa_t,nmas_t ",
                                   "              WHERE nmaaent=nmasent AND nmaa001=nmas001 ",
                                   "                AND nmaaent=",g_enterprise," AND nmaastus='Y'",
                                   "                AND nmas002 IN (",g_sql_bank,")"
            IF NOT cl_null(g_deak_m.deaksite) THEN
               LET g_qryparam.where = g_qryparam.where," AND nmaa002='",g_deak_m.deaksite,"'",
                                                       ")"
            ELSE
               LET g_qryparam.where = g_qryparam.where,")"
            END IF
            #160322-00010#1--add--end
            #給予arg

            CALL q_nmab001()                                #呼叫開窗

            LET g_deak_m.deak001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deak_m.deak001 TO deak001              #顯示到畫面上
            CALL adet403_deak001_ref()
            NEXT FIELD deak001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deak002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deak002
            #add-point:ON ACTION controlp INFIELD deak002 name="input.c.deak002"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deak_m.deak002             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_deak_m.deaksite
            CALL q_ooag001_5()                                #呼叫開窗

            LET g_deak_m.deak002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deak_m.deak002 TO deak002              #顯示到畫面上
            CALL s_desc_get_person_desc(g_deak_m.deak002) RETURNING g_deak_m.deak002_desc
            DISPLAY BY NAME g_deak_m.deak002_desc
            NEXT FIELD deak002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deakunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakunit
            #add-point:ON ACTION controlp INFIELD deakunit name="input.c.deakunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.deakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deakstus
            #add-point:ON ACTION controlp INFIELD deakstus name="input.c.deakstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_deak_m.deakdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               LET g_deak_m.deakunit = g_deak_m.deaksite
               CALL s_aooi200_gen_docno(g_deak_m.deaksite,g_deak_m.deakdocno,g_deak_m.deakdocdt,g_prog) RETURNING l_flag,g_deak_m.deakdocno
               IF NOT l_flag THEN
                  NEXT FIELD deakdocno
               END IF
               #end add-point
               
               INSERT INTO deak_t (deakent,deaksite,deakdocdt,deakdocno,deak001,deak002,deakunit,deakstus, 
                   deakownid,deakowndp,deakcrtid,deakcrtdp,deakcrtdt,deakmodid,deakmoddt,deakcnfid,deakcnfdt) 
 
               VALUES (g_enterprise,g_deak_m.deaksite,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001, 
                   g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid,g_deak_m.deakowndp, 
                   g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid,g_deak_m.deakmoddt, 
                   g_deak_m.deakcnfid,g_deak_m.deakcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_deak_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               CALL adet403_01(g_deak_m.deaksite,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deakunit,g_deak_m.deak001) #150630-00007#1 Add By Ken 150701
               CALL adet403_b_fill()
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adet403_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adet403_b_fill()
                  CALL adet403_b_fill2('0')
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
               CALL adet403_deak_t_mask_restore('restore_mask_o')
               
               UPDATE deak_t SET (deaksite,deakdocdt,deakdocno,deak001,deak002,deakunit,deakstus,deakownid, 
                   deakowndp,deakcrtid,deakcrtdp,deakcrtdt,deakmodid,deakmoddt,deakcnfid,deakcnfdt) = (g_deak_m.deaksite, 
                   g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit, 
                   g_deak_m.deakstus,g_deak_m.deakownid,g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp, 
                   g_deak_m.deakcrtdt,g_deak_m.deakmodid,g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt) 
 
                WHERE deakent = g_enterprise AND deakdocno = g_deakdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "deak_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adet403_deak_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_deak_m_t)
               LET g_log2 = util.JSON.stringify(g_deak_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               IF adet403_deal_chk(g_deak_m.deakdocno) THEN
                  CALL adet403_01(g_deak_m.deaksite,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deakunit,g_deak_m.deak001) #150630-00007#1 Add By Ken 150701
                  CALL adet403_b_fill()
               END IF
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_deakdocno_t = g_deak_m.deakdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adet403.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_deal_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_deal_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adet403_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_deal_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL adet403_set_entry(p_cmd)
            CALL adet403_set_no_entry(p_cmd)
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
            OPEN adet403_cl USING g_enterprise,g_deak_m.deakdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet403_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet403_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_deal_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_deal_d[l_ac].dealseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_deal_d_t.* = g_deal_d[l_ac].*  #BACKUP
               LET g_deal_d_o.* = g_deal_d[l_ac].*  #BACKUP
               CALL adet403_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               LET g_deal_d_o.* = g_deal_d[l_ac].*
               #end add-point  
               CALL adet403_set_no_entry_b(l_cmd)
               IF NOT adet403_lock_b("deal_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adet403_bcl INTO g_deal_d[l_ac].dealseq,g_deal_d[l_ac].deal001,g_deal_d[l_ac].deal012, 
                      g_deal_d[l_ac].deal002,g_deal_d[l_ac].deal003,g_deal_d[l_ac].deal004,g_deal_d[l_ac].deal005, 
                      g_deal_d[l_ac].deal006,g_deal_d[l_ac].deal007,g_deal_d[l_ac].deal008,g_deal_d[l_ac].deal009, 
                      g_deal_d[l_ac].deal010,g_deal_d[l_ac].deal011,g_deal_d[l_ac].dealsite,g_deal_d[l_ac].dealunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deal_d_t.dealseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_deal_d_mask_o[l_ac].* =  g_deal_d[l_ac].*
                  CALL adet403_deal_t_mask()
                  LET g_deal_d_mask_n[l_ac].* =  g_deal_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adet403_show()
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
            INITIALIZE g_deal_d[l_ac].* TO NULL 
            INITIALIZE g_deal_d_t.* TO NULL 
            INITIALIZE g_deal_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_deal_d[l_ac].deal011 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_deal_d_t.* = g_deal_d[l_ac].*     #新輸入資料
            LET g_deal_d_o.* = g_deal_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adet403_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            IF cl_null(g_deal_d[l_ac].dealseq) THEN
               SELECT MAX(dealseq)+1 INTO g_deal_d[l_ac].dealseq FROM deal_t 
                WHERE dealent = g_enterprise
                  AND dealdocno = g_deak_m.deakdocno
               IF cl_null(g_deal_d[l_ac].dealseq) THEN
                  LET g_deal_d[l_ac].dealseq = 1
               END IF
            END IF
            LET g_deal_d[l_ac].dealsite = g_deak_m.deaksite
            LET g_deal_d[l_ac].dealunit = g_deak_m.deakunit
            LET g_deal_d[l_ac].deal001 = g_deak_m.deakdocdt
            LET g_deal_d[l_ac].deal005 = '10'      #款別分類 預設10現金
            
            #150630-00007#1 Add By Ken 150701(S)
            #單頭銀行編號(deak001)非空白時，單身銀行編號 Default = deak001，且不可修改
            IF NOT cl_null(g_deak_m.deak001) THEN
               LET g_deal_d[l_ac].deal012 = g_deak_m.deak001
               CALL adet403_deal012_ref()
            END IF            
            SELECT COUNT(*) INTO l_cnt
              FROM deal_t
             WHERE dealent = g_enterprise
               AND dealdocno = g_deak_m.deakdocno
            IF l_cnt > 0 THEN
               SELECT DISTINCT deal001 INTO l_deal001
                 FROM deal_t
                WHERE dealent = g_enterprise
                  AND dealdocno = g_deak_m.deakdocno
               LET g_deal_d[l_ac].deal001 = l_deal001
            END IF
            #150630-00007#1 Add By Ken 150701(E)
            LET g_deal_d_t.* = g_deal_d[l_ac].* 
            LET g_deal_d_o.* = g_deal_d[l_ac].* 
            CALL adet403_deal006_init()
            CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
            #end add-point
            CALL adet403_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_deal_d[li_reproduce_target].* = g_deal_d[li_reproduce].*
 
               LET g_deal_d[li_reproduce_target].dealseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM deal_t 
             WHERE dealent = g_enterprise AND dealdocno = g_deak_m.deakdocno
 
               AND dealseq = g_deal_d[l_ac].dealseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deak_m.deakdocno
               LET gs_keys[2] = g_deal_d[g_detail_idx].dealseq
               CALL adet403_insert_b('deal_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_deal_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deal_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adet403_b_fill()
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
               LET gs_keys[01] = g_deak_m.deakdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_deal_d_t.dealseq
 
            
               #刪除同層單身
               IF NOT adet403_delete_b('deal_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet403_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adet403_key_delete_b(gs_keys,'deal_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet403_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adet403_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
 
               #end add-point
               LET l_count = g_deal_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_deal_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dealseq
            #add-point:BEFORE FIELD dealseq name="input.b.page1.dealseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dealseq
            
            #add-point:AFTER FIELD dealseq name="input.a.page1.dealseq"
            #此段落由子樣板a05產生
            IF  g_deak_m.deakdocno IS NOT NULL AND g_deal_d[g_detail_idx].dealseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_deak_m.deakdocno != g_deakdocno_t OR g_deal_d[g_detail_idx].dealseq != g_deal_d_t.dealseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deal_t WHERE "||"dealent = '" ||g_enterprise|| "' AND "||"dealdocno = '"||g_deak_m.deakdocno ||"' AND "|| "dealseq = '"||g_deal_d[g_detail_idx].dealseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dealseq
            #add-point:ON CHANGE dealseq name="input.g.page1.dealseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal001
            #add-point:BEFORE FIELD deal001 name="input.b.page1.deal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal001
            
            #add-point:AFTER FIELD deal001 name="input.a.page1.deal001"
            #營業日期(deal001)不可以大於單頭票據日期(deakdocdt)
            IF NOT cl_null(g_deal_d[l_ac].deal001) THEN
               IF g_deal_d[l_ac].deal001 > g_deak_m.deakdocdt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ade-00011"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_deal_d[l_ac].deal001 = g_deal_d_t.deal001
                  NEXT FIELD CURRENT
               END IF
               
               #150630-00007# Add By Ken 150704(S)
               SELECT COUNT(*) INTO l_cnt
                 FROM deal_t
                WHERE dealent = g_enterprise
                  AND dealdocno = g_deak_m.deakdocno
               IF l_cnt > 0   THEN
                  SELECT DISTINCT deal001 INTO l_deal001
                    FROM deal_t
                   WHERE dealent = g_enterprise
                     AND dealdocno = g_deak_m.deakdocno
                   IF (l_deal001 <> g_deal_d[l_ac].deal001 AND l_ac >1 ) 
                     OR (l_ac = 1 AND l_cnt > 1 AND l_deal001 <> g_deal_d[l_ac].deal001) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "ade-00133"
                      LET g_errparam.extend = ""
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      
                      LET g_deal_d[l_ac].deal001 = g_deal_d_t.deal001
                      NEXT FIELD CURRENT                         
                   END IF
               END IF               
               
               CALL adet403_deal001_chk() RETURNING l_success,l_dealdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ade-00132"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = g_deal_d[l_ac].deal001
                  LET g_errparam.replace[2] = l_dealdocno
                  CALL cl_err()

                  LET g_deal_d[l_ac].deal001 = g_deal_d_t.deal001
                  NEXT FIELD CURRENT               
               END IF
               #150630-00007# Add By Ken 150704(E)
               
               IF NOT cl_null(g_deak_m.deaksite) THEN
                  IF NOT s_settledate_chk(g_deak_m.deaksite,g_deal_d[l_ac].deal001) THEN
                     LET g_deal_d[l_ac].deal001 = g_deal_d_t.deal001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal001
            #add-point:ON CHANGE deal001 name="input.g.page1.deal001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal012
            
            #add-point:AFTER FIELD deal012 name="input.a.page1.deal012"
            #150630-00007#1 Add By Ken 150701(S)
            #銀行編號 deal012
            LET g_deal_d[l_ac].deal012_desc = ' '
            IF NOT cl_null(g_deal_d[l_ac].deal012) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deal_d[l_ac].deal012 != g_deal_d_t.deal012 OR g_deal_d_t.deal012 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_deal_d[l_ac].deal012
                  IF NOT cl_chk_exist("v_nmab001") THEN
                     LET g_deal_d[l_ac].deal012 = g_deal_d_t.deal012
                     CALL adet403_deal012_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #160322-00010#1--add--str--
                  #检查开户银行+银行账户+交易账户是否是相关联的
                  IF NOT cl_null(g_deal_d[l_ac].deal002) AND NOT cl_null(g_deal_d[l_ac].deal002) THEN
                     LET l_cnt=0
                     SELECT COUNT(*) INTO l_cnt FROM nmaa_t,nmas_t
                      WHERE nmaaent=nmasent AND nmaa001=nmas001
                        AND nmaa002=g_deak_m.deaksite
                        AND nmaa001=g_deal_d[l_ac].deal002
                        AND nmaa004=g_deal_d[l_ac].deal012
                        AND nmas002=g_deal_d[l_ac].deal003
                     IF l_cnt=0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_deal_d[l_ac].deal012
                        LET g_errparam.code   = 'anm-00398' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_deal_d[l_ac].deal012 = g_deal_d_t.deal012
                        CALL adet403_deal012_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #160322-00010#1--add--end
               END IF
            END IF
            CALL adet403_deal012_ref()
            #150630-00007#1 Add By Ken 150701(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal012
            #add-point:BEFORE FIELD deal012 name="input.b.page1.deal012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal012
            #add-point:ON CHANGE deal012 name="input.g.page1.deal012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal002
            
            #add-point:AFTER FIELD deal002 name="input.a.page1.deal002"
            
            #帳戶編號(deal002)帶出交易帳號(nmaa005),幣別(nmas003),幣別名稱(nmaal003)
#160322-00010#1--mark--str--
#            LET g_deal_d[l_ac].deal003 = ' '
#            LET g_deal_d[l_ac].deal004 = ' '
#            LET g_deal_d[l_ac].deal004_desc = ' '
#160322-00010#1--mark--end
            IF NOT cl_null(g_deal_d[l_ac].deal002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND 
                  (g_deal_d[l_ac].deal002 != g_deal_d_t.deal002 OR 
                  g_deal_d_t.deal002 IS NULL )) THEN
               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_deal_d[l_ac].deal002
#                  LET g_chkparam.arg2 = g_deak_m.deak001        #160322-00010#1 mark
                   LET g_chkparam.arg2 = g_deal_d[l_ac].deal012  #160322-00010#1 add
#                  IF NOT cl_chk_exist("v_nmas002") THEN         #160322-00010#1 mark
                  IF NOT cl_chk_exist("v_nmaa001") THEN          #160322-00010#1 add 
                     LET g_deal_d[l_ac].deal002 = g_deal_d_t.deal002
                     CALL adet403_deal002_ref()
                     NEXT FIELD CURRENT
                  END IF
#160322-00010#1--mark--str--                
#                  #160122-00001#16--add---str
#                  IF NOT s_anmi120_nmll002_chk(g_deal_d[l_ac].deal002,g_user) THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_deal_d[l_ac].deal002
#                     LET g_errparam.code   = 'anm-00574' 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET g_deal_d[l_ac].deal002 = g_deal_d_t.deal002
#                     CALL adet403_deal002_ref()
#                     NEXT FIELD CURRENT
#                  END IF
#                  #160122-00001#16--add---end
#160322-00010#1--mark--end
                  #160322-00010#1--add--str--
                  #检查开户银行+银行账户+交易账户是否是相关联的
                  IF NOT cl_null(g_deal_d[l_ac].deal003) AND NOT cl_null(g_deal_d[l_ac].deal002) THEN
                     LET l_cnt=0
                     SELECT COUNT(*) INTO l_cnt FROM nmaa_t,nmas_t
                      WHERE nmaaent=nmasent AND nmaa001=nmas001
                        AND nmaa002=g_deak_m.deaksite
                        AND nmaa001=g_deal_d[l_ac].deal002
                        AND nmaa004=g_deal_d[l_ac].deal012
                        AND nmas002=g_deal_d[l_ac].deal003
                     IF l_cnt=0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_deal_d[l_ac].deal002
                        LET g_errparam.code   = 'anm-00398' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_deal_d[l_ac].deal002 = g_deal_d_t.deal002
                        CALL adet403_deal002_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #160322-00010#1--add--end
               END IF
            END IF
            CALL adet403_deal002_ref()
#160322-00010#1--mark--str--            
#            IF NOT cl_null(g_deal_d[l_ac].deal002) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND 
#                  (g_deal_d[l_ac].deal002 != g_deal_d_t.deal002 OR 
#                  g_deal_d_t.deal002 IS NULL )) THEN
##                   LET l_n = 0
##                  SELECT COUNT(*) INTO l_n
##                    FROM ooie_t,ooia_t
##                   WHERE ooie001 = g_deal_d[l_ac].deal006
##                     AND ooieent = g_enterprise
##                     AND ooia002 = g_deal_d[l_ac].deal005
##                     AND ooiesite = g_deak_m.deaksite
##                     AND ooiaent = ooieent 
##                     AND ooia001 = ooie001
##                     AND ooie002 = g_deal_d[l_ac].deal004
##                  IF l_n = 0 THEN
##                     LET g_deal_d[l_ac].deal006 = ''
##                     LET g_deal_d[l_ac].deal006_desc = ''
##                     LET g_deal_d_t.deal006 = ''
##                  END IF
#                  CALL s_money_ooie_get('','ooie002',g_deak_m.deaksite,g_deal_d[l_ac].deal006) RETURNING l_ooie002
#                  IF l_ooie002 != g_deal_d[l_ac].deal004 THEN 
#                     LET g_deal_d[l_ac].deal006 = ''
#                     LET g_deal_d[l_ac].deal006_desc = ''
#                     LET g_deal_d_t.deal006 = ''
#                  END IF 
#               END IF
#            END IF
#160322-00010#1--mark--end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal002
            #add-point:BEFORE FIELD deal002 name="input.b.page1.deal002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal002
            #add-point:ON CHANGE deal002 name="input.g.page1.deal002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal003
            
            #add-point:AFTER FIELD deal003 name="input.a.page1.deal003"
            #160322-00010#1--add--str--
            IF NOT cl_null(g_deal_d[l_ac].deal003) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_deal_d[l_ac].deal003 != g_deal_d_t.deal003 OR g_deal_d_t.deal003 IS NULL )) THEN  #160824-00007#68 Mark By Ken 161007
               IF (g_deal_d[l_ac].deal003 != g_deal_d_o.deal003 OR g_deal_d_o.deal003 IS NULL ) THEN      #160824-00007#68 Add By Ken 161007
                  LET g_chkparam.arg1 = g_deal_d[l_ac].deal003
                  LET g_chkparam.arg2 = g_deak_m.deaksite
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_nmas002_3") THEN
                     #檢查成功時後續處理
                  ELSE
                     #LET g_deal_d[l_ac].deal003 = g_deal_d_t.deal003   #160824-00007#68 Mark By Ken 161007
                     LET g_deal_d[l_ac].deal003 = g_deal_d_o.deal003    #160824-00007#68 Add By Ken 161007
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
                  #检查当前用户是否有权限使用此交易账户
                  IF NOT s_anmi120_nmll002_chk(g_deal_d[l_ac].deal003,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deal_d[l_ac].deal003
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_deal_d[l_ac].deal003 = g_deal_d_t.deal003   #160824-00007#68 Mark By Ken 161007
                     LET g_deal_d[l_ac].deal003 = g_deal_d_o.deal003    #160824-00007#68 Add By Ken 161007
                     NEXT FIELD CURRENT
                  END IF
                  #检查开户银行+银行账户+交易账户是否是相关联的
                  IF NOT cl_null(g_deal_d[l_ac].deal002) AND NOT cl_null(g_deal_d[l_ac].deal002) THEN
                     LET l_cnt=0
                     SELECT COUNT(*) INTO l_cnt FROM nmaa_t,nmas_t
                      WHERE nmaaent=nmasent AND nmaa001=nmas001
                        AND nmaa002=g_deak_m.deaksite
                        AND nmaa001=g_deal_d[l_ac].deal002
                        AND nmaa004=g_deal_d[l_ac].deal012
                        AND nmas002=g_deal_d[l_ac].deal003
                     IF l_cnt=0 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_deal_d[l_ac].deal003
                        LET g_errparam.code   = 'anm-00398' 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        #LET g_deal_d[l_ac].deal003 = g_deal_d_t.deal003   #160824-00007#68 Mark By Ken 161007
                        LET g_deal_d[l_ac].deal003 = g_deal_d_o.deal003    #160824-00007#68 Add By Ken 161007
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #抓取币别
                  SELECT nmas003 INTO g_deal_d[l_ac].deal004
                    FROM nmas_t
                   WHERE nmasent = g_enterprise
                     AND nmas002 = g_deal_d[l_ac].deal002
                  CALL s_desc_get_currency_desc(g_deal_d[l_ac].deal004) RETURNING g_deal_d[l_ac].deal004_desc
                  DISPLAY BY NAME g_deal_d[l_ac].deal004_desc
                  #判断款别对应币别是否等于币别，如果不等，情况款别资料，重新录入
                  CALL s_money_ooie_get('','ooie002',g_deak_m.deaksite,g_deal_d[l_ac].deal006) RETURNING l_ooie002
                  IF l_ooie002 != g_deal_d[l_ac].deal004 THEN 
                     LET g_deal_d[l_ac].deal006 = ''
                     LET g_deal_d[l_ac].deal006_desc = ''
                     LET g_deal_d_t.deal006 = ''
                  END IF 
               END IF
            END IF 
            #160322-00010#1--add--end
            LET g_deal_d_o.* = g_deal_d[l_ac].*    #160824-00007#68 Add By Ken 161007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal003
            #add-point:BEFORE FIELD deal003 name="input.b.page1.deal003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal003
            #add-point:ON CHANGE deal003 name="input.g.page1.deal003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal004
            
            #add-point:AFTER FIELD deal004 name="input.a.page1.deal004"
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal004
            #add-point:BEFORE FIELD deal004 name="input.b.page1.deal004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal004
            #add-point:ON CHANGE deal004 name="input.g.page1.deal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal005
            #add-point:BEFORE FIELD deal005 name="input.b.page1.deal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal005
            
            #add-point:AFTER FIELD deal005 name="input.a.page1.deal005"
            IF NOT cl_null(g_deal_d[l_ac].deal005) THEN
             # IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deal_d[l_ac].deal005 != g_deal_d_o.deal005 OR g_deal_d_o.deal005 IS NULL )) THEN   #150427-00012#1 2015/05/05 by s983961---mark 
                IF g_deal_d[l_ac].deal005 != g_deal_d_o.deal005 OR cl_null(g_deal_d_o.deal005) THEN    #150427-00012#1 2015/06/03 by s983961---add 
                  LET g_deal_d[l_ac].deal006 = ''
                  CALL adet403_deal006_init()
                  CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
                  DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
               END IF
            END IF
            
            #當款別分類=10現金時，支票號碼(deal008)清空，並不可輸入
            IF g_deal_d[l_ac].deal005 = '10' THEN
               LET g_deal_d[l_ac].deal008 = ''
            END IF
            CALL adet403_set_entry_b(l_cmd)
            CALL adet403_set_no_entry_b(l_cmd)
            LET g_deal_d_o.deal005 = g_deal_d[l_ac].deal005
            LET g_deal_d_o.deal006 = g_deal_d[l_ac].deal006
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal005
            #add-point:ON CHANGE deal005 name="input.g.page1.deal005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal006
            
            #add-point:AFTER FIELD deal006 name="input.a.page1.deal006"
            #款別 deal006
            LET g_deal_d[l_ac].deal006_desc = ' '
            IF NOT cl_null(g_deal_d[l_ac].deal006) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deal_d[l_ac].deal006 != g_deal_d_t.deal006 OR g_deal_d_t.deal006 IS NULL )) THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_deal_d[l_ac].deal006
#                  LET g_chkparam.arg2 = g_deal_d[l_ac].deal005
#                  LET g_chkparam.arg3 = g_deal_d[l_ac].deal004
#                  LET g_chkparam.arg4 = g_deak_m.deaksite
#                  LET g_chkparam.err_str[1] = "sub-00354|",g_deal_d[l_ac].deal005
#                  LET g_chkparam.err_str[2] = "sub-00355|",g_deal_d[l_ac].deal005
#                  IF NOT cl_chk_exist("v_ooie001_2") THEN
#                     LET g_deal_d[l_ac].deal006 = g_deal_d_t.deal006
#                     CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
#                     DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_money_chk('1',g_deak_m.deaksite,g_deal_d[l_ac].deal006) RETURNING l_success,g_errno,l_prog,l_ooia002
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_deal_d[l_ac].deal006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_deal_d[l_ac].deal006 = g_deal_d_t.deal006
                     CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
                     DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
                     NEXT FIELD CURRENT
                  END IF 
                  IF l_ooia002 != g_deal_d[l_ac].deal005 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'ade-00068'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()     
                     LET g_deal_d[l_ac].deal006 = g_deal_d_t.deal006
                     CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
                     DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
                     NEXT FIELD CURRENT
                  END IF 
#               END IF
               IF NOT cl_null(g_deal_d[l_ac].deal004) THEN 
                  CALL s_money_ooie_get('','ooie002',g_deak_m.deaksite,g_deal_d[l_ac].deal006) RETURNING l_ooie002
                  IF l_ooie002 != g_deal_d[l_ac].deal004 OR cl_null(l_ooie002) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ade-00012'
                     LET g_errparam.extend = g_deal_d[l_ac].deal006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_deal_d[l_ac].deal006 = g_deal_d_t.deal006
                     CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
                     DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF 
               CALL adet403_deal006_ref() #150630-00007#1 Add By Ken 150705 帶出未轉存款單的收銀餘額
            END IF
            CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal006
            #add-point:BEFORE FIELD deal006 name="input.b.page1.deal006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal006
            #add-point:ON CHANGE deal006 name="input.g.page1.deal006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_deal_d[l_ac].deal007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD deal007
            END IF 
 
 
 
            #add-point:AFTER FIELD deal007 name="input.a.page1.deal007"
            IF NOT cl_null(g_deal_d[l_ac].deal007) THEN
               IF g_deal_d[l_ac].deal007 != g_deal_d_o.deal007 OR cl_null(g_deal_d_o.deal007) THEN
                  IF NOT adet403_deal007_chk() THEN
                     LET g_deal_d[l_ac].deal007 = g_deal_d_o.deal007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_deal_d_o.deal007 = g_deal_d[l_ac].deal007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal007
            #add-point:BEFORE FIELD deal007 name="input.b.page1.deal007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal007
            #add-point:ON CHANGE deal007 name="input.g.page1.deal007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal008
            #add-point:BEFORE FIELD deal008 name="input.b.page1.deal008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal008
            
            #add-point:AFTER FIELD deal008 name="input.a.page1.deal008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal008
            #add-point:ON CHANGE deal008 name="input.g.page1.deal008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal009
            #add-point:BEFORE FIELD deal009 name="input.b.page1.deal009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal009
            
            #add-point:AFTER FIELD deal009 name="input.a.page1.deal009"
            LET g_deal_d[l_ac].deal011 = ''
            IF NOT cl_null(g_deal_d[l_ac].deal009) THEN
               IF g_deal_d[l_ac].deal009 != g_deal_d_o.deal009 OR cl_null(g_deal_d_o.deal009) THEN
                  IF NOT adet403_deal009_chk() THEN
                     LET g_deal_d[l_ac].deal009 = g_deal_d_o.deal009
                     LET g_deal_d[l_ac].deal010 = g_deal_d_o.deal010
                     LET g_deal_d[l_ac].deal011 = g_deal_d_o.deal011
                     NEXT FIELD deal009
                  END IF
                  CALL adet403_get_deal011()
               END IF
            END IF
            CALL adet403_get_deal011()
            LET g_deal_d_o.deal009 = g_deal_d[l_ac].deal009
            LET g_deal_d_o.deal010 = g_deal_d[l_ac].deal010
            LET g_deal_d_o.deal011 = g_deal_d[l_ac].deal011
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal009
            #add-point:ON CHANGE deal009 name="input.g.page1.deal009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deal010
            #add-point:BEFORE FIELD deal010 name="input.b.page1.deal010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deal010
            
            #add-point:AFTER FIELD deal010 name="input.a.page1.deal010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deal010
            #add-point:ON CHANGE deal010 name="input.g.page1.deal010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dealsite
            #add-point:BEFORE FIELD dealsite name="input.b.page1.dealsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dealsite
            
            #add-point:AFTER FIELD dealsite name="input.a.page1.dealsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dealsite
            #add-point:ON CHANGE dealsite name="input.g.page1.dealsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dealunit
            #add-point:BEFORE FIELD dealunit name="input.b.page1.dealunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dealunit
            
            #add-point:AFTER FIELD dealunit name="input.a.page1.dealunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dealunit
            #add-point:ON CHANGE dealunit name="input.g.page1.dealunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dealseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dealseq
            #add-point:ON ACTION controlp INFIELD dealseq name="input.c.page1.dealseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deal001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal001
            #add-point:ON ACTION controlp INFIELD deal001 name="input.c.page1.deal001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deal012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal012
            #add-point:ON ACTION controlp INFIELD deal012 name="input.c.page1.deal012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deal_d[l_ac].deal012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #160322-00010#1--add--str--
            LET g_qryparam.where = " nmab001 IN (SELECT DISTINCT nmaa004 FROM nmaa_t,nmas_t ",
                                   "              WHERE nmaaent=nmasent AND nmaa001=nmas001 ",
                                   "                AND nmaaent=",g_enterprise," AND nmaastus='Y'",
                                   "                AND nmaa002='",g_deak_m.deaksite,"'",
                                   "                AND nmas002 IN (",g_sql_bank,")",
                                   "             )"
            #160322-00010#1--add--end

            CALL q_nmab001()                                #呼叫開窗

            LET g_deal_d[l_ac].deal012 = g_qryparam.return1              

            DISPLAY g_deal_d[l_ac].deal012 TO deal012              #
            CALL adet403_deal012_ref()
            NEXT FIELD deal012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.deal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal002
            #add-point:ON ACTION controlp INFIELD deal002 name="input.c.page1.deal002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deal_d[l_ac].deal002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_deak_m.deaksite
            LET g_qryparam.arg2 = g_deal_d[l_ac].deal012  #150630-00007#1 Add By Ken 150701            
            #LET g_qryparam.arg2 = g_deak_m.deak001 #150630-00007#1 Mark By Ken 150701 
            #160322-00010#1--mod--str--
#            #160122-00001#16--add---str
##            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
##                                   " AND nmll002 = '",g_user,"')"
#            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"  #160122-00001#16 mod by 07675
#            #160122-00001#16--add---end
#
#            CALL q_nmas002_1()                                #呼叫開窗
            LET g_qryparam.where = " nmaastus = 'Y'",
                                   " AND nmaa002='",g_deak_m.deaksite,"'",
                                   " AND nmaa001 IN (SELECT DISTINCT nmas001 FROM nmas_t ",
                                   "                  WHERE nmasent=",g_enterprise,
                                   "                    AND nmas002 IN (",g_sql_bank,")",
                                   "                 )"
            IF NOT cl_null(g_deal_d[l_ac].deal012) THEN
               LET g_qryparam.where = g_qryparam.where," AND nmaa004='",g_deal_d[l_ac].deal012,"'"
            END IF
            CALL q_nmaa001()
            #160322-00010#1--mod--end
            LET g_deal_d[l_ac].deal002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deal_d[l_ac].deal002 TO deal002              #顯示到畫面上
            CALL adet403_deal002_ref()
            LET g_qryparam.where = " "             #160122-00001#16
            NEXT FIELD deal002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.deal003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal003
            #add-point:ON ACTION controlp INFIELD deal003 name="input.c.page1.deal003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_deal_d[l_ac].deal003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            #160322-00010#1--add--str--
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")",
                                   " AND nmaa002='",g_deak_m.deaksite,"'"
            IF NOT cl_null(g_deal_d[l_ac].deal012) THEN
               LET g_qryparam.where = g_qryparam.where," AND nmaa004='",g_deal_d[l_ac].deal012,"'"
            END IF
            IF NOT cl_null(g_deal_d[l_ac].deal002) THEN
               LET g_qryparam.where = g_qryparam.where," AND nmaa001='",g_deal_d[l_ac].deal002,"'"
            END IF
            #160322-00010#1--add--end
            CALL q_nmas_01()                                #呼叫開窗
 
            LET g_deal_d[l_ac].deal003 = g_qryparam.return1              

            DISPLAY g_deal_d[l_ac].deal003 TO deal003              #

            NEXT FIELD deal003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.deal004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal004
            #add-point:ON ACTION controlp INFIELD deal004 name="input.c.page1.deal004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deal_d[l_ac].deal004             #給予default值

            #給予arg

            CALL q_aooi001_1()                                #呼叫開窗

            LET g_deal_d[l_ac].deal004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deal_d[l_ac].deal004 TO deal004              #顯示到畫面上
            CALL s_desc_get_currency_desc(g_deal_d[l_ac].deal004) RETURNING g_deal_d[l_ac].deal004_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal004_desc
            NEXT FIELD deal004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.deal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal005
            #add-point:ON ACTION controlp INFIELD deal005 name="input.c.page1.deal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deal006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal006
            #add-point:ON ACTION controlp INFIELD deal006 name="input.c.page1.deal006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deal_d[l_ac].deal006             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_deal_d[l_ac].deal005
#            LET g_qryparam.arg2 = g_deal_d[l_ac].deal004
#            LET g_qryparam.arg3 = g_deak_m.deaksite
            CALL s_money_where(g_deak_m.deaksite) RETURNING l_str
            IF NOT cl_null(g_deal_d[l_ac].deal005) THEN 
               LET g_qryparam.where = l_str," AND ooia002 = '",g_deal_d[l_ac].deal005,"' "   
            ELSE
               LET g_qryparam.where = l_str
            END IF 
            CALL q_ooia001()                                #呼叫開窗

            LET g_deal_d[l_ac].deal006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_deal_d[l_ac].deal006 TO deal006              #顯示到畫面上
            CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal006_desc
            NEXT FIELD deal006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.deal007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal007
            #add-point:ON ACTION controlp INFIELD deal007 name="input.c.page1.deal007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deal008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal008
            #add-point:ON ACTION controlp INFIELD deal008 name="input.c.page1.deal008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deal009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal009
            #add-point:ON ACTION controlp INFIELD deal009 name="input.c.page1.deal009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deal_d[l_ac].deal009
            LET g_qryparam.default2 = g_deal_d[l_ac].deal010
            LET g_qryparam.arg1 = g_deal_d[l_ac].deal001
            LET g_qryparam.arg2 = g_deal_d[l_ac].deal005
            LET g_qryparam.arg3 = g_deal_d[l_ac].deal006
            LET g_qryparam.where = "NOT EXISTS (SELECT 1 ",
                                                " FROM deal_t ",
                                                "WHERE dealent = deacent ",
                                                "  AND deal009 = deacdocno ",
                                                "  AND deal010 = deacseq)"
            CALL q_deabdocno_1()
            LET g_deal_d[l_ac].deal009 = g_qryparam.return1              
            LET g_deal_d[l_ac].deal010 = g_qryparam.return2
            DISPLAY g_deal_d[l_ac].deal009 TO deal009
            DISPLAY g_deal_d[l_ac].deal010 TO deal010
            CALL adet403_get_deal011()
            NEXT FIELD deal009                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.deal010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deal010
            #add-point:ON ACTION controlp INFIELD deal010 name="input.c.page1.deal010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dealsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dealsite
            #add-point:ON ACTION controlp INFIELD dealsite name="input.c.page1.dealsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dealunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dealunit
            #add-point:ON ACTION controlp INFIELD dealunit name="input.c.page1.dealunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_deal_d[l_ac].* = g_deal_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adet403_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_deal_d[l_ac].dealseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_deal_d[l_ac].* = g_deal_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adet403_deal_t_mask_restore('restore_mask_o')
      
               UPDATE deal_t SET (dealdocno,dealseq,deal001,deal012,deal002,deal003,deal004,deal005, 
                   deal006,deal007,deal008,deal009,deal010,deal011,dealsite,dealunit) = (g_deak_m.deakdocno, 
                   g_deal_d[l_ac].dealseq,g_deal_d[l_ac].deal001,g_deal_d[l_ac].deal012,g_deal_d[l_ac].deal002, 
                   g_deal_d[l_ac].deal003,g_deal_d[l_ac].deal004,g_deal_d[l_ac].deal005,g_deal_d[l_ac].deal006, 
                   g_deal_d[l_ac].deal007,g_deal_d[l_ac].deal008,g_deal_d[l_ac].deal009,g_deal_d[l_ac].deal010, 
                   g_deal_d[l_ac].deal011,g_deal_d[l_ac].dealsite,g_deal_d[l_ac].dealunit)
                WHERE dealent = g_enterprise AND dealdocno = g_deak_m.deakdocno 
 
                  AND dealseq = g_deal_d_t.dealseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_deal_d[l_ac].* = g_deal_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deal_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_deal_d[l_ac].* = g_deal_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deal_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deak_m.deakdocno
               LET gs_keys_bak[1] = g_deakdocno_t
               LET gs_keys[2] = g_deal_d[g_detail_idx].dealseq
               LET gs_keys_bak[2] = g_deal_d_t.dealseq
               CALL adet403_update_b('deal_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adet403_deal_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_deal_d[g_detail_idx].dealseq = g_deal_d_t.dealseq 
 
                  ) THEN
                  LET gs_keys[01] = g_deak_m.deakdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_deal_d_t.dealseq
 
                  CALL adet403_key_update_b(gs_keys,'deal_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_deak_m),util.JSON.stringify(g_deal_d_t)
               LET g_log2 = util.JSON.stringify(g_deak_m),util.JSON.stringify(g_deal_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL adet403_unlock_b("deal_t","'1'")
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
               LET g_deal_d[li_reproduce_target].* = g_deal_d[li_reproduce].*
 
               LET g_deal_d[li_reproduce_target].dealseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_deal_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_deal_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="adet403.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD deaksite
         ELSE
            CASE DIALOG.getCurrentItem()
               WHEN "s_detail1"
                  RETURN "dealseq"
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD deakdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dealseq
 
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
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adet403_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adet403_b_fill() #單身填充
      CALL adet403_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adet403_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            #存繳營運組織 deaksite
            CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
            DISPLAY BY NAME g_deak_m.deaksite_desc

            #銀行編號 deak001
            CALL adet403_deak001_ref()
            
            #存繳人員 deak002
            CALL s_desc_get_person_desc(g_deak_m.deak002) RETURNING g_deak_m.deak002_desc
            DISPLAY BY NAME g_deak_m.deak002_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deak_m.deakownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deak_m.deakownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deak_m.deakownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deak_m.deakowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_deak_m.deakowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deak_m.deakowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deak_m.deakcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deak_m.deakcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deak_m.deakcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deak_m.deakcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_deak_m.deakcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deak_m.deakcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deak_m.deakmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deak_m.deakmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deak_m.deakmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deak_m.deakcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deak_m.deakcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deak_m.deakcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_deak_m_mask_o.* =  g_deak_m.*
   CALL adet403_deak_t_mask()
   LET g_deak_m_mask_n.* =  g_deak_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_deak_m.deaksite,g_deak_m.deaksite_desc,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001, 
       g_deak_m.deak001_desc,g_deak_m.deak002,g_deak_m.deak002_desc,g_deak_m.deakunit,g_deak_m.deakstus, 
       g_deak_m.deakownid,g_deak_m.deakownid_desc,g_deak_m.deakowndp,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid, 
       g_deak_m.deakcrtid_desc,g_deak_m.deakcrtdp,g_deak_m.deakcrtdp_desc,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmodid_desc,g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfid_desc,g_deak_m.deakcnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deak_m.deakstus 
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
   FOR l_ac = 1 TO g_deal_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            #幣別 deal004
            CALL s_desc_get_currency_desc(g_deal_d[l_ac].deal004) RETURNING g_deal_d[l_ac].deal004_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal004_desc

            #款別分類 deal006
            CALL s_desc_get_ooial_desc(g_deal_d[l_ac].deal006) RETURNING g_deal_d[l_ac].deal006_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal006_desc

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adet403_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adet403_detail_show()
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
 
{<section id="adet403.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adet403_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE deak_t.deakdocno 
   DEFINE l_oldno     LIKE deak_t.deakdocno 
 
   DEFINE l_master    RECORD LIKE deak_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE deal_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004
   DEFINE l_insert        LIKE type_t.num5
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
   
   IF g_deak_m.deakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_deakdocno_t = g_deak_m.deakdocno
 
    
   LET g_deak_m.deakdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deak_m.deakownid = g_user
      LET g_deak_m.deakowndp = g_dept
      LET g_deak_m.deakcrtid = g_user
      LET g_deak_m.deakcrtdp = g_dept 
      LET g_deak_m.deakcrtdt = cl_get_current()
      LET g_deak_m.deakmodid = g_user
      LET g_deak_m.deakmoddt = cl_get_current()
      LET g_deak_m.deakstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_deak_m.deakcnfid = ""
   LET g_deak_m.deakcnfdt = ""
   CALL s_aooi500_default(g_prog,'deaksite',g_deak_m.deaksite)
      RETURNING l_insert,g_deak_m.deaksite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL s_aooi500_default(g_prog,'deakunit',g_deak_m.deaksite)
      RETURNING l_insert,g_deak_m.deakunit
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_deak_m.deaksite) RETURNING g_deak_m.deaksite_desc
   DISPLAY BY NAME g_deak_m.deaksite_desc
   LET g_deak_m.deakdocdt = g_today
   LET g_deak_m.deak002 = g_user
   CALL s_desc_get_person_desc(g_deak_m.deak002) RETURNING g_deak_m.deak002_desc
   DISPLAY BY NAME g_deak_m.deak002_desc
   
   #預設單據的單別
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_deak_m.deaksite,g_prog,'1') 
      RETURNING l_success,l_doctype
   LET g_deak_m.deakdocno = l_doctype
   
   LET g_site_flag = FALSE
   LET g_deak_m_t.* = g_deak_m.*
   LET g_deak_m_o.* = g_deak_m.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deak_m.deakstus 
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
   
   
   CALL adet403_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_deak_m.* TO NULL
      INITIALIZE g_deal_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adet403_show()
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
   CALL adet403_set_act_visible()   
   CALL adet403_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deakdocno_t = g_deak_m.deakdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deakent = " ||g_enterprise|| " AND",
                      " deakdocno = '", g_deak_m.deakdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet403_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adet403_idx_chk()
   
   LET g_data_owner = g_deak_m.deakownid      
   LET g_data_dept  = g_deak_m.deakowndp
   
   #功能已完成,通報訊息中心
   CALL adet403_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adet403_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE deal_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adet403_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM deal_t
    WHERE dealent = g_enterprise AND dealdocno = g_deakdocno_t
 
    INTO TEMP adet403_detail
 
   #將key修正為調整後   
   UPDATE adet403_detail 
      #更新key欄位
      SET dealdocno = g_deak_m.deakdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO deal_t SELECT * FROM adet403_detail
   
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
   DROP TABLE adet403_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_deakdocno_t = g_deak_m.deakdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adet403_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num5    #160122-00001#16
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_deak_m.deakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adet403_cl USING g_enterprise,g_deak_m.deakdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet403_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet403_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
       g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
       g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
       g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
       g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT adet403_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deak_m_mask_o.* =  g_deak_m.*
   CALL adet403_deak_t_mask()
   LET g_deak_m_mask_n.* =  g_deak_m.*
   
   CALL adet403_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adet403_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160126-00010#16---add---str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM deal_t
       WHERE dealent = g_enterprise AND dealdocno = g_deak_m.deakdocno
         AND deal002 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
         #160122-00001#16 add by07675
         AND deal002 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(deal002) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE adet403_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#16 add by07675
      #IF l_n = 0 THEN
      #160126-00010#16---add---end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_deakdocno_t = g_deak_m.deakdocno
 
 
      DELETE FROM deak_t
       WHERE deakent = g_enterprise AND deakdocno = g_deak_m.deakdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_deak_m.deakdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_deak_m.deakdocno,g_deak_m.deakdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
     # END IF    #160126-00010#16
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM deal_t
       WHERE dealent = g_enterprise AND dealdocno = g_deak_m.deakdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
#      #160126-00010#16---add---str
#          AND (deal002 IN ( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
#              OR deal002 IS NULL)
#      #160126-00010#16---add---end
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_deak_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adet403_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_deal_d.clear() 
 
     
      CALL adet403_ui_browser_refresh()  
      #CALL adet403_ui_headershow()  
      #CALL adet403_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adet403_browser_fill("")
         CALL adet403_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adet403_cl
 
   #功能已完成,通報訊息中心
   CALL adet403_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adet403.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adet403_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_deal_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adet403_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT dealseq,deal001,deal012,deal002,deal003,deal004,deal005,deal006, 
             deal007,deal008,deal009,deal010,deal011,dealsite,dealunit ,t1.nmabl003 ,t2.nmaal003 ,t3.ooail003 , 
             t4.ooial003 FROM deal_t",   
                     " INNER JOIN deak_t ON deakent = " ||g_enterprise|| " AND deakdocno = dealdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN nmabl_t t1 ON t1.nmablent="||g_enterprise||" AND t1.nmabl001=deal012 AND t1.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN nmaal_t t2 ON t2.nmaalent="||g_enterprise||" AND t2.nmaal001=deal002 AND t2.nmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=deal004 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooial_t t4 ON t4.ooialent="||g_enterprise||" AND t4.ooial001=deal006 AND t4.ooial002='"||g_dlang||"' ",
 
                     " WHERE dealent=? AND dealdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
#         LET g_sql = g_sql CLIPPED," AND (deal002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')
#                                      OR deal002 IS NULL)"  #160122-00001#16
         LET g_sql = g_sql CLIPPED," AND (deal002 IN(",g_sql_bank,") OR TRIM(deal002) IS NULL)"  #160122-00001#16 mod by 07675
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  #160122-00001#16
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY deal_t.dealseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet403_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adet403_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_deak_m.deakdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_deak_m.deakdocno INTO g_deal_d[l_ac].dealseq,g_deal_d[l_ac].deal001, 
          g_deal_d[l_ac].deal012,g_deal_d[l_ac].deal002,g_deal_d[l_ac].deal003,g_deal_d[l_ac].deal004, 
          g_deal_d[l_ac].deal005,g_deal_d[l_ac].deal006,g_deal_d[l_ac].deal007,g_deal_d[l_ac].deal008, 
          g_deal_d[l_ac].deal009,g_deal_d[l_ac].deal010,g_deal_d[l_ac].deal011,g_deal_d[l_ac].dealsite, 
          g_deal_d[l_ac].dealunit,g_deal_d[l_ac].deal012_desc,g_deal_d[l_ac].deal002_desc,g_deal_d[l_ac].deal004_desc, 
          g_deal_d[l_ac].deal006_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #幣別(deal004)不為空值時，帶出幣別名稱
         IF NOT cl_null(g_deal_d[l_ac].deal004) THEN
            CALL s_desc_get_currency_desc(g_deal_d[l_ac].deal004) RETURNING g_deal_d[l_ac].deal004_desc
            DISPLAY BY NAME g_deal_d[l_ac].deal004_desc
         END IF
         
         CALL adet403_deal012_ref() #150630-00007#1 Add By Ken 150701
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
   
   CALL g_deal_d.deleteElement(g_deal_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adet403_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_deal_d.getLength()
      LET g_deal_d_mask_o[l_ac].* =  g_deal_d[l_ac].*
      CALL adet403_deal_t_mask()
      LET g_deal_d_mask_n[l_ac].* =  g_deal_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adet403_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM deal_t
       WHERE dealent = g_enterprise AND
         dealdocno = ps_keys_bak[1] AND dealseq = ps_keys_bak[2]
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
         CALL g_deal_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adet403_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO deal_t
                  (dealent,
                   dealdocno,
                   dealseq
                   ,deal001,deal012,deal002,deal003,deal004,deal005,deal006,deal007,deal008,deal009,deal010,deal011,dealsite,dealunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_deal_d[g_detail_idx].deal001,g_deal_d[g_detail_idx].deal012,g_deal_d[g_detail_idx].deal002, 
                       g_deal_d[g_detail_idx].deal003,g_deal_d[g_detail_idx].deal004,g_deal_d[g_detail_idx].deal005, 
                       g_deal_d[g_detail_idx].deal006,g_deal_d[g_detail_idx].deal007,g_deal_d[g_detail_idx].deal008, 
                       g_deal_d[g_detail_idx].deal009,g_deal_d[g_detail_idx].deal010,g_deal_d[g_detail_idx].deal011, 
                       g_deal_d[g_detail_idx].dealsite,g_deal_d[g_detail_idx].dealunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deal_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_deal_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adet403_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "deal_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adet403_deal_t_mask_restore('restore_mask_o')
               
      UPDATE deal_t 
         SET (dealdocno,
              dealseq
              ,deal001,deal012,deal002,deal003,deal004,deal005,deal006,deal007,deal008,deal009,deal010,deal011,dealsite,dealunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_deal_d[g_detail_idx].deal001,g_deal_d[g_detail_idx].deal012,g_deal_d[g_detail_idx].deal002, 
                  g_deal_d[g_detail_idx].deal003,g_deal_d[g_detail_idx].deal004,g_deal_d[g_detail_idx].deal005, 
                  g_deal_d[g_detail_idx].deal006,g_deal_d[g_detail_idx].deal007,g_deal_d[g_detail_idx].deal008, 
                  g_deal_d[g_detail_idx].deal009,g_deal_d[g_detail_idx].deal010,g_deal_d[g_detail_idx].deal011, 
                  g_deal_d[g_detail_idx].dealsite,g_deal_d[g_detail_idx].dealunit) 
         WHERE dealent = g_enterprise AND dealdocno = ps_keys_bak[1] AND dealseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deal_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deal_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet403_deal_t_mask_restore('restore_mask_n')
               
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
 
{<section id="adet403.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adet403_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adet403.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adet403_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adet403.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adet403_lock_b(ps_table,ps_page)
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
   #CALL adet403_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "deal_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adet403_bcl USING g_enterprise,
                                       g_deak_m.deakdocno,g_deal_d[g_detail_idx].dealseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet403_bcl:",SQLERRMESSAGE 
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
 
{<section id="adet403.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adet403_unlock_b(ps_table,ps_page)
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
      CLOSE adet403_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adet403_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("deakdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("deakdocno",TRUE)
      CALL cl_set_comp_entry("deakdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("deaksite,deakdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("deak001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adet403_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("deakdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("deaksite,deakdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("deakdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("deakdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM deal_t
    WHERE dealent = g_enterprise
      AND dealdocno = g_deak_m.deakdocno
   #150604-00005#1 150604 by sakura modify---STR
   #adet402門店收銀繳款單拋過來的單據為null需開放修改
   IF l_n >= 1 AND (g_deak_m.deak001 IS NOT NULL) THEN
      CALL cl_set_comp_entry("deak001",FALSE)
   END IF
   #150604-00005#1 150604 by sakura modify---END
   
   #aooi500設定的欄位控卡
   IF NOT s_aooi500_comp_entry(g_prog,'deaksite') OR g_site_flag THEN
      CALL cl_set_comp_entry("deaksite",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'deakunit') THEN
      CALL cl_set_comp_entry("deakunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adet403_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("deal008",TRUE)
   CALL cl_set_comp_entry("deal009,deal010",TRUE) #150427-00016#3 150511 by sakura add
   CALL cl_set_comp_entry("deal012",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adet403_set_no_entry_b(p_cmd)
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
   #當款別分類(deal005)=10現金，支票號碼(deal008)不可以輸入
   IF g_deal_d[l_ac].deal005 = '10' THEN
      CALL cl_set_comp_entry("deal008",FALSE)
   END IF
   #150427-00016#3 150511 by sakura add---STR
   #當款別分類(deal005)=30票據類型時，轉撥備用金單號(deal009),轉撥項次(deal010)不可以輸入
   IF g_deal_d[l_ac].deal005 = '30' THEN
      CALL cl_set_comp_entry("deal009,deal010",FALSE)
   END IF   
   #150427-00016#3 150511 by sakura add---END
   
   #150630-00007#1 Add By Ken 150701(S) 當單頭銀行編號不為空白時，單身銀行編號預設單頭並不可輸入
   IF NOT cl_null(g_deak_m.deak001) THEN
      CALL cl_set_comp_entry("deal012",FALSE)
   END IF
   #150630-00007#1 Add By Ken 150701(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adet403_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adet403_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_deak_m.deakstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adet403_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet403.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adet403_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet403.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adet403_default_search()
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
      LET ls_wc = ls_wc, " deakdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "deak_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "deal_t" 
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="adet403.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adet403_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_deak_m.deakstus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_deak_m.deakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adet403_cl USING g_enterprise,g_deak_m.deakdocno
   IF STATUS THEN
      CLOSE adet403_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet403_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
       g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
       g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
       g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
       g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT adet403_action_chk() THEN
      CLOSE adet403_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deak_m.deaksite,g_deak_m.deaksite_desc,g_deak_m.deakdocdt,g_deak_m.deakdocno,g_deak_m.deak001, 
       g_deak_m.deak001_desc,g_deak_m.deak002,g_deak_m.deak002_desc,g_deak_m.deakunit,g_deak_m.deakstus, 
       g_deak_m.deakownid,g_deak_m.deakownid_desc,g_deak_m.deakowndp,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid, 
       g_deak_m.deakcrtid_desc,g_deak_m.deakcrtdp,g_deak_m.deakcrtdp_desc,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
       g_deak_m.deakmodid_desc,g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfid_desc,g_deak_m.deakcnfdt 
 
 
   CASE g_deak_m.deakstus
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
         CASE g_deak_m.deakstus
            
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
      #open皆改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      
      CASE g_deak_m.deakstus 
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF 
            
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"     
            CALL cl_set_act_visible("confirmed ",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            
        #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"   
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
            
         WHEN "D"  
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
            
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"   
            CALL cl_set_act_visible("withdraw",TRUE)  
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT adet403_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet403_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT adet403_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet403_cl
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
      g_deak_m.deakstus = lc_state OR cl_null(lc_state) THEN
      CLOSE adet403_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      CALL s_adet403_conf_chk(g_deak_m.deakdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_adet403_conf_upd(g_deak_m.deakdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'N' THEN
      CALL s_adet403_unconf_chk(g_deak_m.deakdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN
         ELSE
            CALL s_adet403_unconf_upd(g_deak_m.deakdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'X' THEN
      CALL s_adet403_invalid_chk(g_deak_m.deakdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_adet403_invalid_upd(g_deak_m.deakdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_deak_m.deakmodid = g_user
   LET g_deak_m.deakmoddt = cl_get_current()
   LET g_deak_m.deakstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE deak_t 
      SET (deakstus,deakmodid,deakmoddt) 
        = (g_deak_m.deakstus,g_deak_m.deakmodid,g_deak_m.deakmoddt)     
    WHERE deakent = g_enterprise AND deakdocno = g_deak_m.deakdocno
 
    
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
      EXECUTE adet403_master_referesh USING g_deak_m.deakdocno INTO g_deak_m.deaksite,g_deak_m.deakdocdt, 
          g_deak_m.deakdocno,g_deak_m.deak001,g_deak_m.deak002,g_deak_m.deakunit,g_deak_m.deakstus,g_deak_m.deakownid, 
          g_deak_m.deakowndp,g_deak_m.deakcrtid,g_deak_m.deakcrtdp,g_deak_m.deakcrtdt,g_deak_m.deakmodid, 
          g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfdt,g_deak_m.deaksite_desc,g_deak_m.deak001_desc, 
          g_deak_m.deak002_desc,g_deak_m.deakownid_desc,g_deak_m.deakowndp_desc,g_deak_m.deakcrtid_desc, 
          g_deak_m.deakcrtdp_desc,g_deak_m.deakmodid_desc,g_deak_m.deakcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_deak_m.deaksite,g_deak_m.deaksite_desc,g_deak_m.deakdocdt,g_deak_m.deakdocno, 
          g_deak_m.deak001,g_deak_m.deak001_desc,g_deak_m.deak002,g_deak_m.deak002_desc,g_deak_m.deakunit, 
          g_deak_m.deakstus,g_deak_m.deakownid,g_deak_m.deakownid_desc,g_deak_m.deakowndp,g_deak_m.deakowndp_desc, 
          g_deak_m.deakcrtid,g_deak_m.deakcrtid_desc,g_deak_m.deakcrtdp,g_deak_m.deakcrtdp_desc,g_deak_m.deakcrtdt, 
          g_deak_m.deakmodid,g_deak_m.deakmodid_desc,g_deak_m.deakmoddt,g_deak_m.deakcnfid,g_deak_m.deakcnfid_desc, 
          g_deak_m.deakcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adet403_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet403_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet403.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adet403_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_deal_d.getLength() THEN
         LET g_detail_idx = g_deal_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_deal_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_deal_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adet403_b_fill2(pi_idx)
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
   
   CALL adet403_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adet403_fill_chk(ps_idx)
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
 
{<section id="adet403.status_show" >}
PRIVATE FUNCTION adet403_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adet403.mask_functions" >}
&include "erp/ade/adet403_mask.4gl"
 
{</section>}
 
{<section id="adet403.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION adet403_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL adet403_show()
   CALL adet403_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_adet403_conf_chk(g_deak_m.deakdocno) THEN
      CLOSE adet403_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_deak_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_deal_d))
 
 
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
   #CALL adet403_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adet403_ui_headershow()
   CALL adet403_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION adet403_draw_out()
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
   CALL adet403_ui_headershow()  
   CALL adet403_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="adet403.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adet403_set_pk_array()
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
   LET g_pk_array[1].values = g_deak_m.deakdocno
   LET g_pk_array[1].column = 'deakdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet403.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adet403.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adet403_msgcentre_notify(lc_state)
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
   CALL adet403_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_deak_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet403.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adet403_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#7 -s by 08172
   SELECT deakstus  INTO g_deak_m.deakstus
     FROM deak_t
    WHERE deakent = g_enterprise
      AND deakdocno = g_deak_m.deakdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_deak_m.deakstus
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
        LET g_errparam.extend = g_deak_m.deakdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adet403_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#7 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet403.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 銀行編號(deak001)帶出銀行簡稱
# Memo...........:
# Usage..........: CALL adet403_deak001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/06 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet403_deak001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_deak_m.deak001
   CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_deak_m.deak001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_deak_m.deak001_desc
   
END FUNCTION
################################################################################
# Descriptions...: 款別分類的預設款別編號
# Memo...........:
# Usage..........: CALL adet403_deal006_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/14 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet403_deal006_init()
   DEFINE l_n   LIKE type_t.num5
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooie_t
    WHERE ooieent = g_enterprise
      AND ooiesite = g_deak_m.deaksite
   IF l_n > 0 THEN 
      #带出aooi901预设值
      SELECT ooie001,ooial003 INTO g_deal_d[l_ac].deal006,g_deal_d[l_ac].deal006_desc
        FROM ooia_t,ooie_t LEFT JOIN ooial_t ON ooieent = ooialent AND ooie001 = ooial001 AND ooial002 = g_dlang
       WHERE ooieent = g_enterprise AND ooiesite = g_deak_m.deaksite
         AND ooiaent = ooieent AND ooia001 = ooie001 
         AND ooia002 =  g_deal_d[l_ac].deal005
         AND ooie008 = 'Y'
      DISPLAY BY NAME g_deal_d[l_ac].deal006,g_deal_d[l_ac].deal006_desc
      RETURN 
   END IF     
   #huangrh add rtak_t ----20150603
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n
     FROM ooif_t
    WHERE ooifent = g_enterprise
      AND ooif000 IN (SELECT rtaa001 FROM rtaa_t,rtab_t,rtak_t 
                       WHERE rtaaent = rtabent 
                         AND rtaa001 = rtab001 
                         AND rtakent=rtaaent
                         AND rtak001=rtaa001
                         AND rtak002='5'
                         AND rtak003='Y' 
                         AND rtab002 = g_deak_m.deaksite)
   IF l_n > 0 THEN 
      #huangrh add rtak_t ----20150603
      SELECT ooif001,ooial003 INTO g_deal_d[l_ac].deal006,g_deal_d[l_ac].deal006_desc
        FROM ooia_t,ooif_t LEFT JOIN ooial_t ON ooifent = ooialent AND ooif001 = ooial001 AND ooial002 = g_dlang
       WHERE ooifent = g_enterprise 
         AND ooif000 IN (SELECT rtaa001 FROM rtaa_t,rtab_t,rtak_t 
                          WHERE rtaaent = rtabent 
                            AND rtaa001 = rtab001 
                            AND rtakent=rtaaent
                            AND rtak001=rtaa001
                            AND rtak002='5'
                            AND rtak003='Y'   
                            AND rtab002 = g_deak_m.deaksite)
         AND ooiaent = ooifent 
         AND ooia001 = ooif001 
         AND ooia002 = g_deal_d[l_ac].deal005
         AND ooif008 = 'Y'
   END IF    
END FUNCTION
################################################################################
# Descriptions...: 帳戶編號(deal002)帶出交易帳號(nmaa005),幣別(nmas003),幣別名稱(nmaal003)
# Memo...........:
# Usage..........: CALL adet403_deal002_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/07 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet403_deal002_ref()
#160322-00010#1--add--str--
#   IF NOT cl_null(g_deal_d[l_ac].deal002) THEN
#      SELECT nmaa005,nmas003 INTO g_deal_d[l_ac].deal003,g_deal_d[l_ac].deal004
#        FROM nmaa_t,nmas_t
#       WHERE nmas002 = g_deal_d[l_ac].deal002
#         AND nmasent = nmaaent
#         AND nmas001 = nmaa001
#      IF NOT cl_null(g_deal_d[l_ac].deal004) THEN
#         CALL s_desc_get_currency_desc(g_deal_d[l_ac].deal004) RETURNING g_deal_d[l_ac].deal004_desc
#         DISPLAY BY NAME g_deal_d[l_ac].deal004_desc
#      END IF
#   END IF
   
   SELECT nmaal003 INTO g_deal_d[l_ac].deal002_desc
     FROM nmaal_t
    WHERE nmaalent = g_enterprise
      AND nmaal001 = g_deal_d[l_ac].deal002
      AND nmaal002 = g_dlang
   DISPLAY BY NAME g_deal_d[l_ac].deal002_desc
#160322-00010#1--add--end
END FUNCTION

################################################################################
# Descriptions...: 取得轉撥金額
# Memo...........:
# Usage..........: CALL adet403_get_deal011()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/15 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_get_deal011()

   SELECT deac007 INTO g_deal_d[l_ac].deal011
     FROM deac_t
    WHERE deacent = g_enterprise
      AND deacdocno = g_deal_d[l_ac].deal009
      AND deacseq = g_deal_d[l_ac].deal010
END FUNCTION

################################################################################
# Descriptions...: 檢查單號+項次重複性
# Memo...........:
# Usage..........: CALL adet403_deal009_chk()
#                  RETURNING r_success
# Input parameter: 無 
# Return code....: r_success     True/False
# Date & Author..: 2015/05/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_deal009_chk()
DEFINE r_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(deal009) INTO l_cnt 
     FROM deal_t
    WHERE dealent = g_enterprise
      AND deal009 = g_deal_d[l_ac].deal009
      AND deal010 = g_deal_d[l_ac].deal010
   
   IF l_cnt >= 1 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00093'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 控卡不可大於(收銀繳款金額-轉撥備用金額)
# Memo...........:
# Usage..........: CALL adet403_deal007_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2015/05/25 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_deal007_chk()
DEFINE r_success         LIKE type_t.num5
DEFINE l_deaf006         LIKE deaf_t.deaf006 #收銀繳款金額
DEFINE l_deac007         LIKE deac_t.deac007 #轉撥備用金額

   LET r_success = TRUE
   LET l_deaf006 = 0
   LET l_deac007 = 0
   
   #取收銀繳款金額
   SELECT SUM(deaf006) INTO l_deaf006
     FROM deag_t 
     LEFT JOIN deaf_t ON deagent = deafent AND deagdocno = deafdocno
    WHERE deagent = g_enterprise
      AND deagsite = g_deak_m.deaksite       #營運組織
      AND deagdocdt = g_deal_d[l_ac].deal001 #營業日期
      AND deaf012 = g_deal_d[l_ac].deal005   #款別分類
      AND deaf005 = g_deal_d[l_ac].deal006   #款別
      AND deagstus <> 'X'                    #單據不等於X:作廢
	
   #取轉撥備用金額
   SELECT SUM(deac007) INTO l_deac007
     FROM deab_t
     LEFT JOIN deac_t ON deabent = deacent AND deabdocno = deacdocno
    WHERE deabent = g_enterprise 
      AND deabsite = g_deak_m.deaksite      #營運組織
      AND deab001 = g_deal_d[l_ac].deal001  #營業日期
	   AND deac005 = g_deal_d[l_ac].deal005  #款別分類
	   AND deac006 = g_deal_d[l_ac].deal006  #款別分類
	   AND deac006 = g_deal_d[l_ac].deal006  #款別分類
	   AND deabstus <> 'X'                   #單據不等於X:作廢 
   
   IF g_deal_d[l_ac].deal007 > (l_deaf006-l_deac007) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00102'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success   
   END IF

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 單身銀行編號(deal012)帶出銀行簡稱
# Memo...........:
# Usage..........: CALL adet403_deal012_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/07/01 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_deal012_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_deal_d[l_ac].deal012
   CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_deal_d[l_ac].deal012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_deal_d[l_ac].deal012_desc
END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL adet403_create_tmp()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2015/07/01 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_create_tmp()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   CALL adet403_drop_tmp()
   
   CREATE TEMP TABLE adet403_tmp(
      dealent   LIKE deal_t.dealent,
      dealsite  LIKE deal_t.dealsite,
      deal001   LIKE deal_t.deal001,   
      deal005   LIKE deal_t.deal005,  
      deal006   LIKE deal_t.deal006,
      deaf006   LIKE deaf_t.deaf006,
      deal007   LIKE deal_t.deal007,
      deal011   LIKE deal_t.deal011
   )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table adet403_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table
# Memo...........:
# Usage..........: CALL adet403_drop_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/07/01 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_drop_tmp()
   DROP TABLE adet403_tmp
END FUNCTION

################################################################################
# Descriptions...: 檢查單身有無資料
# Memo...........:
# Usage..........: CALL adet403_deal_chk(p_deakdocno)
#                  RETURNING r_success
# Input parameter: p_deakdocno    存款單號
# Return code....: r_success
# Date & Author..: 2015/07/02 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_deal_chk(p_deakdocno)
DEFINE p_deakdocno     LIKE deak_t.deakdocno
DEFINE l_cnt           LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM deal_t
    WHERE dealent = g_enterprise
      AND dealdocno = p_deakdocno
      
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
    
   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 檢查營業日期是否有存在其他未確認時單據
# Memo...........:
# Usage..........: CALL adet403_deal001_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TURE/FALSE
#                : r_dealdocno    存款單號
# Date & Author..: 2015/07/04 By Ken #150630-00007#1
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_deal001_chk()
DEFINE l_dealdocno          LIKE deal_t.dealdocno
DEFINE r_success            LIKE type_t.num5
DEFINE r_dealdocno          LIKE deal_t.dealdocno

   LET l_dealdocno = ''
   LET r_success = TRUE
   LET r_dealdocno = ''
   
   SELECT DISTINCT dealdocno INTO l_dealdocno
     FROM deak_t,deal_t
    WHERE deakent = dealent
      AND deakdocno = dealdocno
      AND deakent = g_enterprise
      AND deaksite = g_deak_m.deaksite
      AND deakstus = 'N'
      AND deakdocno != g_deak_m.deakdocno
      AND deal001 = g_deal_d[l_ac].deal001
      
   IF NOT cl_null(l_dealdocno) THEN
      LET r_success = FALSE
      LET r_dealdocno = l_dealdocno
   END IF
   
   RETURN r_success,r_dealdocno
END FUNCTION

################################################################################
# Descriptions...: 帶出未轉存款單的收銀繳款餘額
# Memo...........:
# Usage..........: CALL adet403_deal006_ref()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/07/05 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adet403_deal006_ref()
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_deaf006      LIKE deaf_t.deaf006
DEFINE l_deal007      LIKE deal_t.deal007
DEFINE l_deal011      LIKE deal_t.deal011

   SELECT COALESCE(SUM(COALESCE(deaf006,0)),0) INTO l_deaf006
     FROM deag_t,deaf_t 
    WHERE deagent = deafent 
      AND deagdocno = deafdocno 
      AND deagent = g_enterprise
      AND deagsite = g_deak_m.deaksite      
      #AND deaf013 = g_deal_d[l_ac].deal004
      AND deaf012 = g_deal_d[l_ac].deal005
      AND deaf005 = g_deal_d[l_ac].deal006
      AND deag005 IS NULL 
      AND deagstus = 'Y' 
      AND deagdocdt =  g_deal_d[l_ac].deal001

      #IF SQLCA.sqlcode THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = SQLCA.sqlcode
      #   LET g_errparam.extend = "Ins l_deaf006"
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #   LET l_success = FALSE
      #END IF
      
      #取已存在存款單且未確認的存款金額+轉備用金
       SELECT COALESCE(SUM(COALESCE(deal007,0)),0) ,COALESCE(SUM(COALESCE(deal011,0)),0) INTO l_deal007,l_deal011
         FROM deak_t,deal_t 
        WHERE deakent = dealent 
          AND deakdocno = dealdocno             
          AND deakent = g_enterprise
          AND deaksite = g_deak_m.deaksite
          AND deal001 = g_deal_d[l_ac].deal001
          #AND deal004 = g_deal_d[l_ac].deal004
          AND deal005 = g_deal_d[l_ac].deal005
          AND deal006 = g_deal_d[l_ac].deal006
          AND dealseq != g_deal_d[l_ac].dealseq
          AND deakstus = 'N'           


       LET g_deal_d[l_ac].deal007 = l_deaf006 - (l_deal007 + l_deal011)

END FUNCTION

 
{</section>}
 
