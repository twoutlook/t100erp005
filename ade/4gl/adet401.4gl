#該程式未解開Section, 採用最新樣板產出!
{<section id="adet401.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-05-15 18:21:07), PR版次:0004(2016-08-26 10:35:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: adet401
#+ Description: 營業款轉備用金維護作業
#+ Creator....: 02159(2015-05-14 18:53:28)
#+ Modifier...: 02159 -SD/PR- 08172
 
{</section>}
 
{<section id="adet401.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160122-00001#16   2016/02/14 By yangtt 添加交易帳戶編號用戶權限空管
#160318-00025#26   2016/04/28 BY 07900  校验代码重复错误讯息的修改
#160818-00017#7     2016/08/24    by 08172  修改删除时重新检查状态
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
PRIVATE type type_g_deab_m        RECORD
       deabsite LIKE deab_t.deabsite, 
   deabsite_desc LIKE type_t.chr80, 
   deabdocdt LIKE deab_t.deabdocdt, 
   deabdocno LIKE deab_t.deabdocno, 
   deab001 LIKE deab_t.deab001, 
   deab002 LIKE deab_t.deab002, 
   deab002_desc LIKE type_t.chr80, 
   deabunit LIKE type_t.chr10, 
   deabstus LIKE deab_t.deabstus, 
   deabownid LIKE deab_t.deabownid, 
   deabownid_desc LIKE type_t.chr80, 
   deabowndp LIKE deab_t.deabowndp, 
   deabowndp_desc LIKE type_t.chr80, 
   deabcrtid LIKE deab_t.deabcrtid, 
   deabcrtid_desc LIKE type_t.chr80, 
   deabcrtdp LIKE deab_t.deabcrtdp, 
   deabcrtdp_desc LIKE type_t.chr80, 
   deabcrtdt LIKE deab_t.deabcrtdt, 
   deabmodid LIKE deab_t.deabmodid, 
   deabmodid_desc LIKE type_t.chr80, 
   deabmoddt LIKE deab_t.deabmoddt, 
   deabcnfid LIKE deab_t.deabcnfid, 
   deabcnfid_desc LIKE type_t.chr80, 
   deabcnfdt LIKE deab_t.deabcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_deac_d        RECORD
       deacseq LIKE deac_t.deacseq, 
   deac005 LIKE deac_t.deac005, 
   deac006 LIKE deac_t.deac006, 
   deac006_desc LIKE type_t.chr500, 
   deac007 LIKE deac_t.deac007, 
   deac002 LIKE deac_t.deac002, 
   deac004 LIKE deac_t.deac004, 
   deac002_desc LIKE type_t.chr500, 
   deac008 LIKE deac_t.deac008, 
   deacsite LIKE deac_t.deacsite, 
   deacunit LIKE deac_t.deacunit, 
   deac001 LIKE deac_t.deac001
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_deabsite LIKE deab_t.deabsite,
      b_deabdocdt LIKE deab_t.deabdocdt,
      b_deabdocno LIKE deab_t.deabdocno,
      b_deab001 LIKE deab_t.deab001,
      b_deab002 LIKE deab_t.deab002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
DEFINE g_sql_bank            STRING #160122-00001#16 add by07675
#end add-point
       
#模組變數(Module Variables)
DEFINE g_deab_m          type_g_deab_m
DEFINE g_deab_m_t        type_g_deab_m
DEFINE g_deab_m_o        type_g_deab_m
DEFINE g_deab_m_mask_o   type_g_deab_m #轉換遮罩前資料
DEFINE g_deab_m_mask_n   type_g_deab_m #轉換遮罩後資料
 
   DEFINE g_deabdocno_t LIKE deab_t.deabdocno
 
 
DEFINE g_deac_d          DYNAMIC ARRAY OF type_g_deac_d
DEFINE g_deac_d_t        type_g_deac_d
DEFINE g_deac_d_o        type_g_deac_d
DEFINE g_deac_d_mask_o   DYNAMIC ARRAY OF type_g_deac_d #轉換遮罩前資料
DEFINE g_deac_d_mask_n   DYNAMIC ARRAY OF type_g_deac_d #轉換遮罩後資料
 
 
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
 
{<section id="adet401.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
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
   LET g_forupd_sql = " SELECT deabsite,'',deabdocdt,deabdocno,deab001,deab002,'','',deabstus,deabownid, 
       '',deabowndp,'',deabcrtid,'',deabcrtdp,'',deabcrtdt,deabmodid,'',deabmoddt,deabcnfid,'',deabcnfdt", 
        
                      " FROM deab_t",
                      " WHERE deabent= ? AND deabdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet401_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.deabsite,t0.deabdocdt,t0.deabdocno,t0.deab001,t0.deab002,t0.deabunit, 
       t0.deabstus,t0.deabownid,t0.deabowndp,t0.deabcrtid,t0.deabcrtdp,t0.deabcrtdt,t0.deabmodid,t0.deabmoddt, 
       t0.deabcnfid,t0.deabcnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooag011",
               " FROM deab_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deabsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.deab002  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.deabownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.deabowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.deabcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.deabcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.deabmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.deabcnfid  ",
 
               " WHERE t0.deabent = " ||g_enterprise|| " AND t0.deabdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adet401_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adet401 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adet401_init()   
 
      #進入選單 Menu (="N")
      CALL adet401_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adet401
      
   END IF 
   
   CLOSE adet401_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adet401.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adet401_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('deabstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('deac005','8310','10')
   LET g_errshow = 1
   CALL s_aooi500_create_temp() RETURNING l_success
    #160122-00001#16--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#16 --add--end
   #end add-point
   
   #初始化搜尋條件
   CALL adet401_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adet401.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adet401_ui_dialog()
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
            CALL adet401_insert()
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
         INITIALIZE g_deab_m.* TO NULL
         CALL g_deac_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adet401_init()
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
               
               CALL adet401_fetch('') # reload data
               LET l_ac = 1
               CALL adet401_ui_detailshow() #Setting the current row 
         
               CALL adet401_idx_chk()
               #NEXT FIELD deacseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_deac_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet401_idx_chk()
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
               CALL adet401_idx_chk()
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
            CALL adet401_browser_fill("")
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
               CALL adet401_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adet401_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adet401_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adet401_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adet401_set_act_visible()   
            CALL adet401_set_act_no_visible()
            IF NOT (g_deab_m.deabdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " deabent = " ||g_enterprise|| " AND",
                                  " deabdocno = '", g_deab_m.deabdocno, "' "
 
               #填到對應位置
               CALL adet401_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "deab_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deac_t" 
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
               CALL adet401_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "deab_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deac_t" 
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
                  CALL adet401_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adet401_fetch("F")
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
               CALL adet401_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adet401_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet401_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adet401_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet401_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adet401_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet401_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adet401_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet401_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adet401_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet401_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_deac_d)
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
               NEXT FIELD deacseq
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
               CALL adet401_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#7 -s by 08172
               CALL adet401_set_act_visible()   
               CALL adet401_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adet401_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#7 -s by 08172
               CALL adet401_set_act_visible()   
               CALL adet401_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adet401_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#7 -s by 08172
               CALL adet401_set_act_visible()   
               CALL adet401_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adet401_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ade/adet401_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ade/adet401_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adet401_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adet401_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adet401_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adet401_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adet401_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_deab_m.deabdocdt)
 
 
 
         
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
 
{<section id="adet401.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adet401_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'deabsite') RETURNING l_where
   LET l_wc = l_wc," AND ",l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT deabdocno ",
                      " FROM deab_t ",
                      " ",
                      " LEFT JOIN deac_t ON deacent = deabent AND deabdocno = deacdocno ", "  ",
                      #add-point:browser_fill段sql(deac_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE deabent = " ||g_enterprise|| " AND deacent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deab_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deabdocno ",
                      " FROM deab_t ", 
                      "  ",
                      "  ",
                      " WHERE deabent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("deab_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #160122-00001#16--add---str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT deabdocno ",
                      " FROM deab_t ",
                      " LEFT JOIN deac_t ON deacent = deabent AND deabdocno = deacdocno ", "  ",
                      " WHERE deabent = '" ||g_enterprise|| "' AND deacent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(deac002) IS NULL ",
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deab_t"),
                      " UNION ",
                      " SELECT DISTINCT deabdocno ",
                      " FROM deab_t,deac_t ",
                      " WHERE deacent = deabent AND deabdocno = deacdocno",
                      "   AND deabent = '" ||g_enterprise|| "' AND deacent = '" ||g_enterprise|| "' ",
#                      "   AND deac002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') ",
                      "   AND deac002 IN(",g_sql_bank,")",   #160122-00001#16 mod by 07675
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deab_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deabdocno ",
                      " FROM deab_t ", 
                      " LEFT JOIN deac_t ON deacent = deabent AND deabdocno = deacdocno ", "  ",
                      " WHERE deabent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(deac002) IS NULL ",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("deab_t"),
                      " UNION ",
                      " SELECT DISTINCT deabdocno ",
                      " FROM deab_t,deac_t ",
                      " WHERE deacent = deabent AND deabdocno = deacdocno ",
                      "   AND deabent = '" ||g_enterprise|| "' ",
#                      "   AND deac002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"') ",
                      "   AND deac002 IN(",g_sql_bank,")",   #160122-00001#16 mod by 07675
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("deab_t")
   END IF
   #160122-00001#16--add---end
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
      INITIALIZE g_deab_m.* TO NULL
      CALL g_deac_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.deabsite,t0.deabdocdt,t0.deabdocno,t0.deab001,t0.deab002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deabstus,t0.deabsite,t0.deabdocdt,t0.deabdocno,t0.deab001,t0.deab002 ", 
 
                  " FROM deab_t t0",
                  "  ",
                  "  LEFT JOIN deac_t ON deacent = deabent AND deabdocno = deacdocno ", "  ", 
                  #add-point:browser_fill段sql(deac_t1) name="browser_fill.join.deac_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.deabent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deab_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deabstus,t0.deabsite,t0.deabdocdt,t0.deabdocno,t0.deab001,t0.deab002 ", 
 
                  " FROM deab_t t0",
                  "  ",
                  
                  " WHERE t0.deabent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("deab_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #160122-00001#16--add---str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deabstus,t0.deabsite,t0.deabdocdt,t0.deabdocno,t0.deab001,t0.deab002 ", 

                  " FROM deab_t t0",
                  "  LEFT JOIN deac_t ON deacent = deabent AND deabdocno = deacdocno ", "  ", 
                  " WHERE t0.deabent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(deac002) IS NULL ",
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deab_t"),
                  " UNION ",
                  " SELECT DISTINCT t1.deabstus,t1.deabsite,t1.deabdocdt,t1.deabdocno,t1.deab001,t1.deab002 ", 

                  " FROM deab_t t1,deac_t",
                  " WHERE deacent = deabent AND deabdocno = deacdocno ",
                  "   AND t1.deabent = '" ||g_enterprise|| "' ",
#                  "   AND deac002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  "   AND deac002 IN(",g_sql_bank,")",   #160122-00001#16 mod by 07675
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deab_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deabstus,t0.deabsite,t0.deabdocdt,t0.deabdocno,t0.deab001,t0.deab002 ", 

                  " FROM deab_t t0",
                  "  LEFT JOIN deac_t ON deacent = deabent AND deabdocno = deacdocno ",
                  " WHERE t0.deabent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(deac002) IS NULL ",
                  "   AND ",l_wc, cl_sql_add_filter("deab_t"),
                  " UNION ",
                  " SELECT DISTINCT t1.deabstus,t1.deabsite,t1.deabdocdt,t1.deabdocno,t1.deab001,t1.deab002 ", 

                  " FROM deab_t t1,deac_t",
                  " WHERE deacent = deabent AND deabdocno = deacdocno ",
                  "   AND t1.deabent = '" ||g_enterprise|| "' ",
#                  "   AND deac002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  "   AND deac002 IN(",g_sql_bank,")",   #160122-00001#16 mod by 07675
                  "   AND ",l_wc, cl_sql_add_filter("deab_t")
   END IF
   #160122-00001#16--add---end
   #end add-point
   LET g_sql = g_sql, " ORDER BY deabdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"deab_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_deabsite,g_browser[g_cnt].b_deabdocdt, 
          g_browser[g_cnt].b_deabdocno,g_browser[g_cnt].b_deab001,g_browser[g_cnt].b_deab002
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
         CALL adet401_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_deabdocno) THEN
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
 
{<section id="adet401.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adet401_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_deab_m.deabdocno = g_browser[g_current_idx].b_deabdocno   
 
   EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
       g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
       g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
   
   CALL adet401_deab_t_mask()
   CALL adet401_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adet401.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adet401_ui_detailshow()
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
 
{<section id="adet401.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adet401_ui_browser_refresh()
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
      IF g_browser[l_i].b_deabdocno = g_deab_m.deabdocno 
 
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
 
{<section id="adet401.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adet401_construct()
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
   INITIALIZE g_deab_m.* TO NULL
   CALL g_deac_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON deabsite,deabdocdt,deabdocno,deab001,deab002,deabunit,deabstus,deabownid, 
          deabowndp,deabcrtid,deabcrtdp,deabcrtdt,deabmodid,deabmoddt,deabcnfid,deabcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<deabcrtdt>>----
         AFTER FIELD deabcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<deabmoddt>>----
         AFTER FIELD deabmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deabcnfdt>>----
         AFTER FIELD deabcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deabpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.deabsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabsite
            #add-point:ON ACTION controlp INFIELD deabsite name="construct.c.deabsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deabsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabsite  #顯示到畫面上
            NEXT FIELD deabsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabsite
            #add-point:BEFORE FIELD deabsite name="construct.b.deabsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabsite
            
            #add-point:AFTER FIELD deabsite name="construct.a.deabsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabdocdt
            #add-point:BEFORE FIELD deabdocdt name="construct.b.deabdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabdocdt
            
            #add-point:AFTER FIELD deabdocdt name="construct.a.deabdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deabdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabdocdt
            #add-point:ON ACTION controlp INFIELD deabdocdt name="construct.c.deabdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deabdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabdocno
            #add-point:ON ACTION controlp INFIELD deabdocno name="construct.c.deabdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_deabdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabdocno  #顯示到畫面上
            NEXT FIELD deabdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabdocno
            #add-point:BEFORE FIELD deabdocno name="construct.b.deabdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabdocno
            
            #add-point:AFTER FIELD deabdocno name="construct.a.deabdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deab001
            #add-point:BEFORE FIELD deab001 name="construct.b.deab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deab001
            
            #add-point:AFTER FIELD deab001 name="construct.a.deab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deab001
            #add-point:ON ACTION controlp INFIELD deab001 name="construct.c.deab001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deab002
            #add-point:ON ACTION controlp INFIELD deab002 name="construct.c.deab002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooag001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deab002  #顯示到畫面上
            CALL s_desc_get_person_desc(g_deab_m.deab002) RETURNING g_deab_m.deab002_desc
            DISPLAY BY NAME g_deab_m.deab002_desc
            NEXT FIELD deab002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deab002
            #add-point:BEFORE FIELD deab002 name="construct.b.deab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deab002
            
            #add-point:AFTER FIELD deab002 name="construct.a.deab002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabunit
            #add-point:BEFORE FIELD deabunit name="construct.b.deabunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabunit
            
            #add-point:AFTER FIELD deabunit name="construct.a.deabunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deabunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabunit
            #add-point:ON ACTION controlp INFIELD deabunit name="construct.c.deabunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabstus
            #add-point:BEFORE FIELD deabstus name="construct.b.deabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabstus
            
            #add-point:AFTER FIELD deabstus name="construct.a.deabstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabstus
            #add-point:ON ACTION controlp INFIELD deabstus name="construct.c.deabstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deabownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabownid
            #add-point:ON ACTION controlp INFIELD deabownid name="construct.c.deabownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabownid  #顯示到畫面上
            NEXT FIELD deabownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabownid
            #add-point:BEFORE FIELD deabownid name="construct.b.deabownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabownid
            
            #add-point:AFTER FIELD deabownid name="construct.a.deabownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deabowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabowndp
            #add-point:ON ACTION controlp INFIELD deabowndp name="construct.c.deabowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabowndp  #顯示到畫面上
            NEXT FIELD deabowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabowndp
            #add-point:BEFORE FIELD deabowndp name="construct.b.deabowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabowndp
            
            #add-point:AFTER FIELD deabowndp name="construct.a.deabowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deabcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabcrtid
            #add-point:ON ACTION controlp INFIELD deabcrtid name="construct.c.deabcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabcrtid  #顯示到畫面上
            NEXT FIELD deabcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabcrtid
            #add-point:BEFORE FIELD deabcrtid name="construct.b.deabcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabcrtid
            
            #add-point:AFTER FIELD deabcrtid name="construct.a.deabcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deabcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabcrtdp
            #add-point:ON ACTION controlp INFIELD deabcrtdp name="construct.c.deabcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabcrtdp  #顯示到畫面上
            NEXT FIELD deabcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabcrtdp
            #add-point:BEFORE FIELD deabcrtdp name="construct.b.deabcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabcrtdp
            
            #add-point:AFTER FIELD deabcrtdp name="construct.a.deabcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabcrtdt
            #add-point:BEFORE FIELD deabcrtdt name="construct.b.deabcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deabmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabmodid
            #add-point:ON ACTION controlp INFIELD deabmodid name="construct.c.deabmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabmodid  #顯示到畫面上
            NEXT FIELD deabmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabmodid
            #add-point:BEFORE FIELD deabmodid name="construct.b.deabmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabmodid
            
            #add-point:AFTER FIELD deabmodid name="construct.a.deabmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabmoddt
            #add-point:BEFORE FIELD deabmoddt name="construct.b.deabmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deabcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabcnfid
            #add-point:ON ACTION controlp INFIELD deabcnfid name="construct.c.deabcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deabcnfid  #顯示到畫面上
            NEXT FIELD deabcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabcnfid
            #add-point:BEFORE FIELD deabcnfid name="construct.b.deabcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabcnfid
            
            #add-point:AFTER FIELD deabcnfid name="construct.a.deabcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabcnfdt
            #add-point:BEFORE FIELD deabcnfdt name="construct.b.deabcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON deacseq,deac005,deac006,deac007,deac002,deac004,deac008,deacsite,deacunit, 
          deac001
           FROM s_detail1[1].deacseq,s_detail1[1].deac005,s_detail1[1].deac006,s_detail1[1].deac007, 
               s_detail1[1].deac002,s_detail1[1].deac004,s_detail1[1].deac008,s_detail1[1].deacsite, 
               s_detail1[1].deacunit,s_detail1[1].deac001
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deacseq
            #add-point:BEFORE FIELD deacseq name="construct.b.page1.deacseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deacseq
            
            #add-point:AFTER FIELD deacseq name="construct.a.page1.deacseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deacseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deacseq
            #add-point:ON ACTION controlp INFIELD deacseq name="construct.c.page1.deacseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac005
            #add-point:BEFORE FIELD deac005 name="construct.b.page1.deac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac005
            
            #add-point:AFTER FIELD deac005 name="construct.a.page1.deac005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac005
            #add-point:ON ACTION controlp INFIELD deac005 name="construct.c.page1.deac005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deac006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac006
            #add-point:ON ACTION controlp INFIELD deac006 name="construct.c.page1.deac006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooie001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deac006  #顯示到畫面上
            NEXT FIELD deac006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac006
            #add-point:BEFORE FIELD deac006 name="construct.b.page1.deac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac006
            
            #add-point:AFTER FIELD deac006 name="construct.a.page1.deac006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac007
            #add-point:BEFORE FIELD deac007 name="construct.b.page1.deac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac007
            
            #add-point:AFTER FIELD deac007 name="construct.a.page1.deac007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac007
            #add-point:ON ACTION controlp INFIELD deac007 name="construct.c.page1.deac007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac002
            #add-point:ON ACTION controlp INFIELD deac002 name="construct.c.page1.deac002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            #160122-00001#16--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
             LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")" #160122-00001#16 mod by 07675
            #160122-00001#16--add---end
            CALL q_nmas002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deac002  #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#1
            NEXT FIELD deac002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac002
            #add-point:BEFORE FIELD deac002 name="construct.b.page1.deac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac002
            
            #add-point:AFTER FIELD deac002 name="construct.a.page1.deac002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac004
            #add-point:BEFORE FIELD deac004 name="construct.b.page1.deac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac004
            
            #add-point:AFTER FIELD deac004 name="construct.a.page1.deac004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac004
            #add-point:ON ACTION controlp INFIELD deac004 name="construct.c.page1.deac004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac008
            #add-point:BEFORE FIELD deac008 name="construct.b.page1.deac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac008
            
            #add-point:AFTER FIELD deac008 name="construct.a.page1.deac008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac008
            #add-point:ON ACTION controlp INFIELD deac008 name="construct.c.page1.deac008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deacsite
            #add-point:BEFORE FIELD deacsite name="construct.b.page1.deacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deacsite
            
            #add-point:AFTER FIELD deacsite name="construct.a.page1.deacsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deacsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deacsite
            #add-point:ON ACTION controlp INFIELD deacsite name="construct.c.page1.deacsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deacunit
            #add-point:BEFORE FIELD deacunit name="construct.b.page1.deacunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deacunit
            
            #add-point:AFTER FIELD deacunit name="construct.a.page1.deacunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deacunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deacunit
            #add-point:ON ACTION controlp INFIELD deacunit name="construct.c.page1.deacunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac001
            #add-point:BEFORE FIELD deac001 name="construct.b.page1.deac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac001
            
            #add-point:AFTER FIELD deac001 name="construct.a.page1.deac001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac001
            #add-point:ON ACTION controlp INFIELD deac001 name="construct.c.page1.deac001"
            
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
                  WHEN la_wc[li_idx].tableid = "deab_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "deac_t" 
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
 
{<section id="adet401.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adet401_filter()
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
      CONSTRUCT g_wc_filter ON deabsite,deabdocdt,deabdocno,deab001,deab002
                          FROM s_browse[1].b_deabsite,s_browse[1].b_deabdocdt,s_browse[1].b_deabdocno, 
                              s_browse[1].b_deab001,s_browse[1].b_deab002
 
         BEFORE CONSTRUCT
               DISPLAY adet401_filter_parser('deabsite') TO s_browse[1].b_deabsite
            DISPLAY adet401_filter_parser('deabdocdt') TO s_browse[1].b_deabdocdt
            DISPLAY adet401_filter_parser('deabdocno') TO s_browse[1].b_deabdocno
            DISPLAY adet401_filter_parser('deab001') TO s_browse[1].b_deab001
            DISPLAY adet401_filter_parser('deab002') TO s_browse[1].b_deab002
      
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
 
      CALL adet401_filter_show('deabsite')
   CALL adet401_filter_show('deabdocdt')
   CALL adet401_filter_show('deabdocno')
   CALL adet401_filter_show('deab001')
   CALL adet401_filter_show('deab002')
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adet401_filter_parser(ps_field)
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
 
{<section id="adet401.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adet401_filter_show(ps_field)
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
   LET ls_condition = adet401_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adet401_query()
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
   CALL g_deac_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adet401_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adet401_browser_fill("")
      CALL adet401_fetch("")
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
      CALL adet401_filter_show('deabsite')
   CALL adet401_filter_show('deabdocdt')
   CALL adet401_filter_show('deabdocno')
   CALL adet401_filter_show('deab001')
   CALL adet401_filter_show('deab002')
   CALL adet401_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adet401_fetch("F") 
      #顯示單身筆數
      CALL adet401_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adet401_fetch(p_flag)
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
   
   LET g_deab_m.deabdocno = g_browser[g_current_idx].b_deabdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
       g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
       g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
   
   #遮罩相關處理
   LET g_deab_m_mask_o.* =  g_deab_m.*
   CALL adet401_deab_t_mask()
   LET g_deab_m_mask_n.* =  g_deab_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet401_set_act_visible()   
   CALL adet401_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_deab_m_t.* = g_deab_m.*
   LET g_deab_m_o.* = g_deab_m.*
   
   LET g_data_owner = g_deab_m.deabownid      
   LET g_data_dept  = g_deab_m.deabowndp
   
   #重新顯示   
   CALL adet401_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.insert" >}
#+ 資料新增
PRIVATE FUNCTION adet401_insert()
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
   CALL g_deac_d.clear()   
 
 
   INITIALIZE g_deab_m.* TO NULL             #DEFAULT 設定
   
   LET g_deabdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deab_m.deabownid = g_user
      LET g_deab_m.deabowndp = g_dept
      LET g_deab_m.deabcrtid = g_user
      LET g_deab_m.deabcrtdp = g_dept 
      LET g_deab_m.deabcrtdt = cl_get_current()
      LET g_deab_m.deabmodid = g_user
      LET g_deab_m.deabmoddt = cl_get_current()
      LET g_deab_m.deabstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_site_flag = FALSE
      #aooi500控卡
      CALL s_aooi500_default(g_prog,'deabsite',g_deab_m.deabsite)
         RETURNING l_insert,g_deab_m.deabsite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
      DISPLAY BY NAME g_deab_m.deabsite_desc
      #單據日期
      LET g_deab_m.deabdocdt = g_today
      #營業日期
      IF NOT adet401_deab001_chk(g_today,'1') THEN
         LET g_deab_m.deab001 = ''
      ELSE
         LET g_deab_m.deab001 = g_today
      END IF
      #存款人員
      LET g_deab_m.deab002 = g_user
      CALL s_desc_get_person_desc(g_deab_m.deab002) RETURNING g_deab_m.deab002_desc
      DISPLAY BY NAME g_deab_m.deab002_desc
      #預設單據的單別
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_deab_m.deabsite,g_prog,'1') 
         RETURNING l_success,l_doctype
      LET g_deab_m.deabdocno = l_doctype
      
      LET g_deab_m_t.* = g_deab_m.*
      LET g_deab_m_o.* = g_deab_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_deab_m_t.* = g_deab_m.*
      LET g_deab_m_o.* = g_deab_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deab_m.deabstus 
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
 
 
 
    
      CALL adet401_input("a")
      
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
         INITIALIZE g_deab_m.* TO NULL
         INITIALIZE g_deac_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adet401_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_deac_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet401_set_act_visible()   
   CALL adet401_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deabdocno_t = g_deab_m.deabdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deabent = " ||g_enterprise|| " AND",
                      " deabdocno = '", g_deab_m.deabdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet401_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adet401_cl
   
   CALL adet401_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
       g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
       g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
   
   
   #遮罩相關處理
   LET g_deab_m_mask_o.* =  g_deab_m.*
   CALL adet401_deab_t_mask()
   LET g_deab_m_mask_n.* =  g_deab_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deab_m.deabsite,g_deab_m.deabsite_desc,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001, 
       g_deab_m.deab002,g_deab_m.deab002_desc,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid,g_deab_m.deabcrtid_desc, 
       g_deab_m.deabcrtdp,g_deab_m.deabcrtdp_desc,g_deab_m.deabcrtdt,g_deab_m.deabmodid,g_deab_m.deabmodid_desc, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfid_desc,g_deab_m.deabcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_deab_m.deabownid      
   LET g_data_dept  = g_deab_m.deabowndp
   
   #功能已完成,通報訊息中心
   CALL adet401_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.modify" >}
#+ 資料修改
PRIVATE FUNCTION adet401_modify()
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
   LET g_deab_m_t.* = g_deab_m.*
   LET g_deab_m_o.* = g_deab_m.*
   
   IF g_deab_m.deabdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_deabdocno_t = g_deab_m.deabdocno
 
   CALL s_transaction_begin()
   
   OPEN adet401_cl USING g_enterprise,g_deab_m.deabdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet401_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet401_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
       g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
       g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
   
   #檢查是否允許此動作
   IF NOT adet401_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deab_m_mask_o.* =  g_deab_m.*
   CALL adet401_deab_t_mask()
   LET g_deab_m_mask_n.* =  g_deab_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adet401_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_deabdocno_t = g_deab_m.deabdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_deab_m.deabmodid = g_user 
LET g_deab_m.deabmoddt = cl_get_current()
LET g_deab_m.deabmodid_desc = cl_get_username(g_deab_m.deabmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adet401_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE deab_t SET (deabmodid,deabmoddt) = (g_deab_m.deabmodid,g_deab_m.deabmoddt)
          WHERE deabent = g_enterprise AND deabdocno = g_deabdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_deab_m.* = g_deab_m_t.*
            CALL adet401_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_deab_m.deabdocno != g_deab_m_t.deabdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE deac_t SET deacdocno = g_deab_m.deabdocno
 
          WHERE deacent = g_enterprise AND deacdocno = g_deab_m_t.deabdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "deac_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deac_t:",SQLERRMESSAGE 
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
   CALL adet401_set_act_visible()   
   CALL adet401_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " deabent = " ||g_enterprise|| " AND",
                      " deabdocno = '", g_deab_m.deabdocno, "' "
 
   #填到對應位置
   CALL adet401_browser_fill("")
 
   CLOSE adet401_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet401_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adet401.input" >}
#+ 資料輸入
PRIVATE FUNCTION adet401_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_where               STRING
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_ooef016             LIKE ooef_t.ooef016
   DEFINE  l_ooia002             LIKE ooia_t.ooia002  
   DEFINE  l_prog                LIKE type_t.chr10     
   DEFINE  l_ooie002             LIKE ooie_t.ooie002   
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
   DISPLAY BY NAME g_deab_m.deabsite,g_deab_m.deabsite_desc,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001, 
       g_deab_m.deab002,g_deab_m.deab002_desc,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid,g_deab_m.deabcrtid_desc, 
       g_deab_m.deabcrtdp,g_deab_m.deabcrtdp_desc,g_deab_m.deabcrtdt,g_deab_m.deabmodid,g_deab_m.deabmodid_desc, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfid_desc,g_deab_m.deabcnfdt
   
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
   LET g_forupd_sql = "SELECT deacseq,deac005,deac006,deac007,deac002,deac004,deac008,deacsite,deacunit, 
       deac001 FROM deac_t WHERE deacent=? AND deacdocno=? AND deacseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet401_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adet401_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adet401_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_deab_m.deabsite,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002, 
       g_deab_m.deabunit,g_deab_m.deabstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adet401.input.head" >}
      #單頭段
      INPUT BY NAME g_deab_m.deabsite,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002, 
          g_deab_m.deabunit,g_deab_m.deabstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adet401_cl USING g_enterprise,g_deab_m.deabdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adet401_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL adet401_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabsite
            
            #add-point:AFTER FIELD deabsite name="input.a.deabsite"
            DISPLAY BY NAME g_deab_m.deabsite_desc
            IF NOT cl_null(g_deab_m.deabsite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deab_m.deabsite != g_deab_m_t.deabsite OR g_deab_m_t.deabsite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'deabsite',g_deab_m.deabsite,g_deab_m.deabsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_deab_m.deabsite = g_deab_m_t.deabsite
                     CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
                     DISPLAY BY NAME g_deab_m.deabsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_deab_m.deabdocdt) AND NOT cl_null(g_deab_m.deabsite) THEN
                  IF NOT s_settledate_chk(g_deab_m.deabsite,g_deab_m.deabdocdt) THEN
                     LET g_deab_m.deabsite = g_deab_m_t.deabsite
                     CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
                     DISPLAY BY NAME g_deab_m.deabsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               LET g_deab_m.deabsite = g_deab_m_t.deabsite
               CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
               DISPLAY BY NAME g_deab_m.deabsite_desc
               NEXT FIELD CURRENT              
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
            DISPLAY BY NAME g_deab_m.deabsite_desc
            CALL adet401_set_entry(p_cmd)
            CALL adet401_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabsite
            #add-point:BEFORE FIELD deabsite name="input.b.deabsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deabsite
            #add-point:ON CHANGE deabsite name="input.g.deabsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabdocdt
            #add-point:BEFORE FIELD deabdocdt name="input.b.deabdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabdocdt
            
            #add-point:AFTER FIELD deabdocdt name="input.a.deabdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deabdocdt
            #add-point:ON CHANGE deabdocdt name="input.g.deabdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabdocno
            #add-point:BEFORE FIELD deabdocno name="input.b.deabdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabdocno
            
            #add-point:AFTER FIELD deabdocno name="input.a.deabdocno"
            #應用 a05 樣板自動產生(Version:2)
            IF p_cmd = 'a' AND NOT cl_null(g_deab_m.deabdocno) THEN
               IF NOT s_aooi200_chk_slip(g_deab_m.deabsite,'',g_deab_m.deabdocno,g_prog) THEN
                  LET g_deab_m.deabdocno = g_deab_m_t.deabdocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deabdocno
            #add-point:ON CHANGE deabdocno name="input.g.deabdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deab001
            #add-point:BEFORE FIELD deab001 name="input.b.deab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deab001
            
            #add-point:AFTER FIELD deab001 name="input.a.deab001"
            IF NOT cl_null(g_deab_m.deab001) THEN
               IF g_deab_m.deab001 != g_deab_m_o.deab001 OR cl_null(g_deab_m_o.deab001) THEN
                  #營業日期(deab001)不可大於單據日期(deabdocdt)
                  IF g_deab_m.deab001 > g_deab_m.deabdocdt THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ade-00011"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_deab_m.deab001 = g_deab_m_o.deab001
                     NEXT FIELD CURRENT
                  END IF
                  #檢查一個營業日期(deab001)只能存在於一張單據中
                  IF NOT adet401_deab001_chk(g_deab_m.deab001,'2') THEN
                     LET g_deab_m.deab001 = g_deab_m_o.deab001
                     NEXT FIELD CURRENT                  
                  END IF
               END IF                  
            END IF
            LET g_deab_m_o.deab001 = g_deab_m.deab001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deab001
            #add-point:ON CHANGE deab001 name="input.g.deab001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deab002
            
            #add-point:AFTER FIELD deab002 name="input.a.deab002"
            LET g_deab_m.deab002_desc = ' '
            DISPLAY BY NAME g_deab_m.deab002_desc
            IF NOT cl_null(g_deab_m.deab002) THEN
               IF g_deab_m.deab002 != g_deab_m_o.deab002 OR cl_null(g_deab_m_o.deab002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_deab_m.deab002
                  LET g_chkparam.arg2 = g_deab_m.deabsite
                  #160318-00025#26  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#26  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooag001_2") THEN
                     LET g_deab_m.deab002 = g_deab_m_o.deab002
                     CALL s_desc_get_person_desc(g_deab_m.deab002) RETURNING g_deab_m.deab002_desc
                     DISPLAY BY NAME g_deab_m.deab002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_deab_m_o.deab002 = g_deab_m.deab002
            CALL s_desc_get_person_desc(g_deab_m.deab002) RETURNING g_deab_m.deab002_desc
            DISPLAY BY NAME g_deab_m.deab002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deab002
            #add-point:BEFORE FIELD deab002 name="input.b.deab002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deab002
            #add-point:ON CHANGE deab002 name="input.g.deab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabunit
            #add-point:BEFORE FIELD deabunit name="input.b.deabunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabunit
            
            #add-point:AFTER FIELD deabunit name="input.a.deabunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deabunit
            #add-point:ON CHANGE deabunit name="input.g.deabunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deabstus
            #add-point:BEFORE FIELD deabstus name="input.b.deabstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deabstus
            
            #add-point:AFTER FIELD deabstus name="input.a.deabstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deabstus
            #add-point:ON CHANGE deabstus name="input.g.deabstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deabsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabsite
            #add-point:ON ACTION controlp INFIELD deabsite name="input.c.deabsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deab_m.deabsite             #給予default值
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deabsite','','i')
            CALL q_ooef001_24()                                #呼叫開窗
            LET g_deab_m.deabsite = g_qryparam.return1              
            DISPLAY g_deab_m.deabsite TO deabsite
            CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
            DISPLAY BY NAME g_deab_m.deabsite_desc            
            NEXT FIELD deabsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.deabdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabdocdt
            #add-point:ON ACTION controlp INFIELD deabdocdt name="input.c.deabdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.deabdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabdocno
            #add-point:ON ACTION controlp INFIELD deabdocno name="input.c.deabdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deab_m.deabdocno
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_deab_m.deabsite            
            LET g_qryparam.arg1 = l_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog    #單據性質
            CALL q_ooba002_1()
            LET g_deab_m.deabdocno = g_qryparam.return1              
            DISPLAY g_deab_m.deabdocno TO deabdocno
            NEXT FIELD deabdocno
            #END add-point
 
 
         #Ctrlp:input.c.deab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deab001
            #add-point:ON ACTION controlp INFIELD deab001 name="input.c.deab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.deab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deab002
            #add-point:ON ACTION controlp INFIELD deab002 name="input.c.deab002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deab_m.deab002
            LET g_qryparam.arg1 = g_deab_m.deabsite
            CALL q_ooag001_5()
            LET g_deab_m.deab002 = g_qryparam.return1              
            DISPLAY g_deab_m.deab002 TO deab002
            CALL s_desc_get_person_desc(g_deab_m.deab002) RETURNING g_deab_m.deab002_desc
            DISPLAY BY NAME g_deab_m.deab002_desc            
            NEXT FIELD deab002
            #END add-point
 
 
         #Ctrlp:input.c.deabunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabunit
            #add-point:ON ACTION controlp INFIELD deabunit name="input.c.deabunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.deabstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deabstus
            #add-point:ON ACTION controlp INFIELD deabstus name="input.c.deabstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_deab_m.deabdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #預設單頭deabunit值
               LET g_deab_m.deabunit = g_deab_m.deabsite
               #自動產生單號
               CALL s_aooi200_gen_docno(g_deab_m.deabsite,g_deab_m.deabdocno,g_deab_m.deabdocdt,g_prog) RETURNING l_success,g_deab_m.deabdocno
               IF NOT l_success THEN
                  NEXT FIELD deabdocno
               END IF
               #end add-point
               
               INSERT INTO deab_t (deabent,deabsite,deabdocdt,deabdocno,deab001,deab002,deabunit,deabstus, 
                   deabownid,deabowndp,deabcrtid,deabcrtdp,deabcrtdt,deabmodid,deabmoddt,deabcnfid,deabcnfdt) 
 
               VALUES (g_enterprise,g_deab_m.deabsite,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001, 
                   g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid,g_deab_m.deabowndp, 
                   g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid,g_deab_m.deabmoddt, 
                   g_deab_m.deabcnfid,g_deab_m.deabcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_deab_m:",SQLERRMESSAGE 
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
                  CALL adet401_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adet401_b_fill()
                  CALL adet401_b_fill2('0')
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
               CALL adet401_deab_t_mask_restore('restore_mask_o')
               
               UPDATE deab_t SET (deabsite,deabdocdt,deabdocno,deab001,deab002,deabunit,deabstus,deabownid, 
                   deabowndp,deabcrtid,deabcrtdp,deabcrtdt,deabmodid,deabmoddt,deabcnfid,deabcnfdt) = (g_deab_m.deabsite, 
                   g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit, 
                   g_deab_m.deabstus,g_deab_m.deabownid,g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp, 
                   g_deab_m.deabcrtdt,g_deab_m.deabmodid,g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt) 
 
                WHERE deabent = g_enterprise AND deabdocno = g_deabdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "deab_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adet401_deab_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_deab_m_t)
               LET g_log2 = util.JSON.stringify(g_deab_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_deabdocno_t = g_deab_m.deabdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adet401.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_deac_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_deac_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adet401_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_deac_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL adet401_set_entry(p_cmd)
            CALL adet401_set_no_entry(p_cmd)
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
            OPEN adet401_cl USING g_enterprise,g_deab_m.deabdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet401_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet401_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_deac_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_deac_d[l_ac].deacseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_deac_d_t.* = g_deac_d[l_ac].*  #BACKUP
               LET g_deac_d_o.* = g_deac_d[l_ac].*  #BACKUP
               CALL adet401_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adet401_set_no_entry_b(l_cmd)
               IF NOT adet401_lock_b("deac_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adet401_bcl INTO g_deac_d[l_ac].deacseq,g_deac_d[l_ac].deac005,g_deac_d[l_ac].deac006, 
                      g_deac_d[l_ac].deac007,g_deac_d[l_ac].deac002,g_deac_d[l_ac].deac004,g_deac_d[l_ac].deac008, 
                      g_deac_d[l_ac].deacsite,g_deac_d[l_ac].deacunit,g_deac_d[l_ac].deac001
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deac_d_t.deacseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_deac_d_mask_o[l_ac].* =  g_deac_d[l_ac].*
                  CALL adet401_deac_t_mask()
                  LET g_deac_d_mask_n[l_ac].* =  g_deac_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adet401_show()
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
            INITIALIZE g_deac_d[l_ac].* TO NULL 
            INITIALIZE g_deac_d_t.* TO NULL 
            INITIALIZE g_deac_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_deac_d[l_ac].deac007 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #預設項次
            IF cl_null(g_deac_d[l_ac].deacseq) THEN
               SELECT MAX(deacseq)+1 INTO g_deac_d[l_ac].deacseq 
                 FROM deac_t 
                WHERE deacent = g_enterprise
                  AND deacdocno = g_deab_m.deabdocno
               IF cl_null(g_deac_d[l_ac].deacseq) THEN
                  LET g_deac_d[l_ac].deacseq = 1
               END IF
            END IF
            #預設site
            LET g_deac_d[l_ac].deacsite = g_deab_m.deabsite
            #預設unit
            LET g_deac_d[l_ac].deacunit = g_deab_m.deabsite            
            #預設營業日期(deac001)
            LET g_deac_d[l_ac].deac001 = g_deab_m.deab001
            #預設款別分類 預設10現金
            LET g_deac_d[l_ac].deac005 = '10'
            #預設款別編號
            CALL adet401_deac006_init()
            #抓取主幣別編號
            SELECT ooef016 INTO l_ooef016
              FROM ooef_t
               WHERE ooefent = g_enterprise
                 AND ooef001 = g_deab_m.deabsite
            LET g_deac_d[l_ac].deac004 = l_ooef016
            #end add-point
            LET g_deac_d_t.* = g_deac_d[l_ac].*     #新輸入資料
            LET g_deac_d_o.* = g_deac_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adet401_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adet401_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_deac_d[li_reproduce_target].* = g_deac_d[li_reproduce].*
 
               LET g_deac_d[li_reproduce_target].deacseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM deac_t 
             WHERE deacent = g_enterprise AND deacdocno = g_deab_m.deabdocno
 
               AND deacseq = g_deac_d[l_ac].deacseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deab_m.deabdocno
               LET gs_keys[2] = g_deac_d[g_detail_idx].deacseq
               CALL adet401_insert_b('deac_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_deac_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deac_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adet401_b_fill()
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
               LET gs_keys[01] = g_deab_m.deabdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_deac_d_t.deacseq
 
            
               #刪除同層單身
               IF NOT adet401_delete_b('deac_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet401_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adet401_key_delete_b(gs_keys,'deac_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet401_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adet401_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_deac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_deac_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deacseq
            #add-point:BEFORE FIELD deacseq name="input.b.page1.deacseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deacseq
            
            #add-point:AFTER FIELD deacseq name="input.a.page1.deacseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_deab_m.deabdocno IS NOT NULL AND g_deac_d[g_detail_idx].deacseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_deab_m.deabdocno != g_deabdocno_t OR g_deac_d[g_detail_idx].deacseq != g_deac_d_t.deacseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deac_t WHERE "||"deacent = '" ||g_enterprise|| "' AND "||"deacdocno = '"||g_deab_m.deabdocno ||"' AND "|| "deacseq = '"||g_deac_d[g_detail_idx].deacseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deacseq
            #add-point:ON CHANGE deacseq name="input.g.page1.deacseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac005
            #add-point:BEFORE FIELD deac005 name="input.b.page1.deac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac005
            
            #add-point:AFTER FIELD deac005 name="input.a.page1.deac005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac005
            #add-point:ON CHANGE deac005 name="input.g.page1.deac005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac006
            
            #add-point:AFTER FIELD deac006 name="input.a.page1.deac006"
            LET g_deac_d[l_ac].deac006_desc = ' '
            IF NOT cl_null(g_deac_d[l_ac].deac006) THEN
			      IF g_deac_d[l_ac].deac006 != g_deac_d_o.deac006 OR cl_null(g_deac_d_o.deac006) THEN
                  #款别检查
                  CALL s_money_chk('1',g_deab_m.deabsite,g_deac_d[l_ac].deac006) RETURNING l_success,g_errno,l_prog,l_ooia002
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_deac_d[l_ac].deac006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_deac_d[l_ac].deac006 = g_deac_d_o.deac006
                     CALL s_desc_get_ooial_desc(g_deac_d[l_ac].deac006) RETURNING g_deac_d[l_ac].deac006_desc
                     DISPLAY BY NAME g_deac_d[l_ac].deac006_desc
                     NEXT FIELD CURRENT
                  END IF 
                  IF l_ooia002 != g_deac_d[l_ac].deac005 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'ade-00068' #該款別對應款別性質與當前款別性質不一致！
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()     
                     LET g_deac_d[l_ac].deac006 = g_deac_d_o.deac006
                     CALL s_desc_get_ooial_desc(g_deac_d[l_ac].deac006) RETURNING g_deac_d[l_ac].deac006_desc
                     DISPLAY BY NAME g_deac_d[l_ac].deac006_desc
                     NEXT FIELD CURRENT
                  END IF
			      END IF
			      #deac004(幣別)抓取aooi100中的ooef016(主幣別編號)
               IF NOT cl_null(g_deac_d[l_ac].deac004) THEN 
                  CALL s_money_ooie_get('','ooie002',g_deab_m.deabsite,g_deac_d[l_ac].deac006) RETURNING l_ooie002
                  IF l_ooie002 != g_deac_d[l_ac].deac004 OR cl_null(l_ooie002) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ade-00012' #款別的幣別不等於帳戶幣別！
                     LET g_errparam.extend = g_deac_d[l_ac].deac006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_deac_d[l_ac].deac006 = g_deac_d_o.deac006
                     CALL s_desc_get_ooial_desc(g_deac_d[l_ac].deac006) RETURNING g_deac_d[l_ac].deac006_desc
                     DISPLAY BY NAME g_deac_d[l_ac].deac006_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF 
            END IF
            LET g_deac_d_o.deac006 = g_deac_d[l_ac].deac006
            CALL s_desc_get_ooial_desc(g_deac_d[l_ac].deac006) RETURNING g_deac_d[l_ac].deac006_desc
            DISPLAY BY NAME g_deac_d[l_ac].deac006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac006
            #add-point:BEFORE FIELD deac006 name="input.b.page1.deac006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac006
            #add-point:ON CHANGE deac006 name="input.g.page1.deac006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_deac_d[l_ac].deac007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD deac007
            END IF 
 
 
 
            #add-point:AFTER FIELD deac007 name="input.a.page1.deac007"
            IF NOT cl_null(g_deac_d[l_ac].deac007) THEN 
               IF g_deac_d[l_ac].deac007 != g_deac_d_o.deac007 OR cl_null(g_deac_d_o.deac007) THEN
                  IF NOT adet401_deac007_chk() THEN
                     LET g_deac_d[l_ac].deac007 = g_deac_d_o.deac007
                     NEXT FIELD CURRENT
                  END IF
               END IF                              
            END IF
            LET g_deac_d_o.deac007 = g_deac_d[l_ac].deac007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac007
            #add-point:BEFORE FIELD deac007 name="input.b.page1.deac007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac007
            #add-point:ON CHANGE deac007 name="input.g.page1.deac007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac002
            
            #add-point:AFTER FIELD deac002 name="input.a.page1.deac002"
            IF NOT cl_null(g_deac_d[l_ac].deac002) THEN
               IF g_deac_d[l_ac].deac002 != g_deac_d_o.deac002 OR cl_null(g_deac_d_o.deac002) THEN           
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_deac_d[l_ac].deac002
                  IF NOT cl_chk_exist("v_nmas002_3") THEN
                     LET g_deac_d[l_ac].deac002 = g_deac_d_o.deac002
                     CALL s_desc_get_nmas002_desc(g_deac_d[l_ac].deac002) RETURNING g_deac_d[l_ac].deac002_desc 
                     DISPLAY BY NAME g_deac_d[l_ac].deac002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#16--add---str
                  IF NOT s_anmi120_nmll002_chk(g_deac_d[l_ac].deac002,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deac_d[l_ac].deac002
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_deac_d[l_ac].deac002 = g_deac_d_o.deac002
                     CALL s_desc_get_nmas002_desc(g_deac_d[l_ac].deac002) RETURNING g_deac_d[l_ac].deac002_desc 
                     DISPLAY BY NAME g_deac_d[l_ac].deac002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#16--add---end
               END IF
            END IF
            LET g_deac_d_o.deac002 = g_deac_d[l_ac].deac002            
            CALL s_desc_get_nmas002_desc(g_deac_d[l_ac].deac002) RETURNING g_deac_d[l_ac].deac002_desc 
            DISPLAY BY NAME g_deac_d[l_ac].deac002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac002
            #add-point:BEFORE FIELD deac002 name="input.b.page1.deac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac002
            #add-point:ON CHANGE deac002 name="input.g.page1.deac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac004
            #add-point:BEFORE FIELD deac004 name="input.b.page1.deac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac004
            
            #add-point:AFTER FIELD deac004 name="input.a.page1.deac004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac004
            #add-point:ON CHANGE deac004 name="input.g.page1.deac004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac008
            #add-point:BEFORE FIELD deac008 name="input.b.page1.deac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac008
            
            #add-point:AFTER FIELD deac008 name="input.a.page1.deac008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac008
            #add-point:ON CHANGE deac008 name="input.g.page1.deac008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deacsite
            #add-point:BEFORE FIELD deacsite name="input.b.page1.deacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deacsite
            
            #add-point:AFTER FIELD deacsite name="input.a.page1.deacsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deacsite
            #add-point:ON CHANGE deacsite name="input.g.page1.deacsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deacunit
            #add-point:BEFORE FIELD deacunit name="input.b.page1.deacunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deacunit
            
            #add-point:AFTER FIELD deacunit name="input.a.page1.deacunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deacunit
            #add-point:ON CHANGE deacunit name="input.g.page1.deacunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deac001
            #add-point:BEFORE FIELD deac001 name="input.b.page1.deac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deac001
            
            #add-point:AFTER FIELD deac001 name="input.a.page1.deac001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deac001
            #add-point:ON CHANGE deac001 name="input.g.page1.deac001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.deacseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deacseq
            #add-point:ON ACTION controlp INFIELD deacseq name="input.c.page1.deacseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac005
            #add-point:ON ACTION controlp INFIELD deac005 name="input.c.page1.deac005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac006
            #add-point:ON ACTION controlp INFIELD deac006 name="input.c.page1.deac006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deac_d[l_ac].deac006             #給予default值
            LET g_qryparam.arg1 = g_deac_d[l_ac].deac005
            LET g_qryparam.arg2 = g_deab_m.deabsite
            CALL q_ooie001_4()                                #呼叫開窗
            LET g_deac_d[l_ac].deac006 = g_qryparam.return1              
            DISPLAY g_deac_d[l_ac].deac006 TO deac006
            CALL s_desc_get_ooial_desc(g_deac_d[l_ac].deac006) RETURNING g_deac_d[l_ac].deac006_desc
            DISPLAY BY NAME g_deac_d[l_ac].deac006_desc
            NEXT FIELD deac006
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac007
            #add-point:ON ACTION controlp INFIELD deac007 name="input.c.page1.deac007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac002
            #add-point:ON ACTION controlp INFIELD deac002 name="input.c.page1.deac002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deac_d[l_ac].deac002             #給予default值
            LET g_qryparam.arg1 = g_deab_m.deabsite
            #160122-00001#16--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")" #160122-00001#16 mod by 07675
            #160122-00001#16--add---end
            CALL q_nmas002()
            LET g_deac_d[l_ac].deac002 = g_qryparam.return1              
            DISPLAY g_deac_d[l_ac].deac002 TO deac002
            CALL s_desc_get_nmas002_desc(g_deac_d[l_ac].deac002) RETURNING g_deac_d[l_ac].deac002_desc 
            DISPLAY BY NAME g_deac_d[l_ac].deac002_desc      
            LET g_qryparam.where = " "             #160122-00001#16            
            NEXT FIELD deac002
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac004
            #add-point:ON ACTION controlp INFIELD deac004 name="input.c.page1.deac004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac008
            #add-point:ON ACTION controlp INFIELD deac008 name="input.c.page1.deac008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deacsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deacsite
            #add-point:ON ACTION controlp INFIELD deacsite name="input.c.page1.deacsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deacunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deacunit
            #add-point:ON ACTION controlp INFIELD deacunit name="input.c.page1.deacunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deac001
            #add-point:ON ACTION controlp INFIELD deac001 name="input.c.page1.deac001"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_deac_d[l_ac].* = g_deac_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adet401_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_deac_d[l_ac].deacseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_deac_d[l_ac].* = g_deac_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adet401_deac_t_mask_restore('restore_mask_o')
      
               UPDATE deac_t SET (deacdocno,deacseq,deac005,deac006,deac007,deac002,deac004,deac008, 
                   deacsite,deacunit,deac001) = (g_deab_m.deabdocno,g_deac_d[l_ac].deacseq,g_deac_d[l_ac].deac005, 
                   g_deac_d[l_ac].deac006,g_deac_d[l_ac].deac007,g_deac_d[l_ac].deac002,g_deac_d[l_ac].deac004, 
                   g_deac_d[l_ac].deac008,g_deac_d[l_ac].deacsite,g_deac_d[l_ac].deacunit,g_deac_d[l_ac].deac001) 
 
                WHERE deacent = g_enterprise AND deacdocno = g_deab_m.deabdocno 
 
                  AND deacseq = g_deac_d_t.deacseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_deac_d[l_ac].* = g_deac_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deac_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_deac_d[l_ac].* = g_deac_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deac_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deab_m.deabdocno
               LET gs_keys_bak[1] = g_deabdocno_t
               LET gs_keys[2] = g_deac_d[g_detail_idx].deacseq
               LET gs_keys_bak[2] = g_deac_d_t.deacseq
               CALL adet401_update_b('deac_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adet401_deac_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_deac_d[g_detail_idx].deacseq = g_deac_d_t.deacseq 
 
                  ) THEN
                  LET gs_keys[01] = g_deab_m.deabdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_deac_d_t.deacseq
 
                  CALL adet401_key_update_b(gs_keys,'deac_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_deab_m),util.JSON.stringify(g_deac_d_t)
               LET g_log2 = util.JSON.stringify(g_deab_m),util.JSON.stringify(g_deac_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL adet401_unlock_b("deac_t","'1'")
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
               LET g_deac_d[li_reproduce_target].* = g_deac_d[li_reproduce].*
 
               LET g_deac_d[li_reproduce_target].deacseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_deac_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_deac_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="adet401.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD deabsite
            #end add-point  
            NEXT FIELD deabdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD deacseq
 
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
 
{<section id="adet401.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adet401_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adet401_b_fill() #單身填充
      CALL adet401_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adet401_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_deab_m_mask_o.* =  g_deab_m.*
   CALL adet401_deab_t_mask()
   LET g_deab_m_mask_n.* =  g_deab_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_deab_m.deabsite,g_deab_m.deabsite_desc,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001, 
       g_deab_m.deab002,g_deab_m.deab002_desc,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid,g_deab_m.deabcrtid_desc, 
       g_deab_m.deabcrtdp,g_deab_m.deabcrtdp_desc,g_deab_m.deabcrtdt,g_deab_m.deabmodid,g_deab_m.deabmodid_desc, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfid_desc,g_deab_m.deabcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deab_m.deabstus 
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
   FOR l_ac = 1 TO g_deac_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adet401_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adet401_detail_show()
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
 
{<section id="adet401.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adet401_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE deab_t.deabdocno 
   DEFINE l_oldno     LIKE deab_t.deabdocno 
 
   DEFINE l_master    RECORD LIKE deab_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE deac_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_deab_m.deabdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_deabdocno_t = g_deab_m.deabdocno
 
    
   LET g_deab_m.deabdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deab_m.deabownid = g_user
      LET g_deab_m.deabowndp = g_dept
      LET g_deab_m.deabcrtid = g_user
      LET g_deab_m.deabcrtdp = g_dept 
      LET g_deab_m.deabcrtdt = cl_get_current()
      LET g_deab_m.deabmodid = g_user
      LET g_deab_m.deabmoddt = cl_get_current()
      LET g_deab_m.deabstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_deab_m.deabcnfid = ""
   LET g_deab_m.deabcnfdt = ""
   CALL s_aooi500_default(g_prog,'deabsite',g_deab_m.deabsite)
      RETURNING l_insert,g_deab_m.deabsite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_deab_m.deabsite) RETURNING g_deab_m.deabsite_desc
   DISPLAY BY NAME g_deab_m.deabsite_desc
   #單據日期
   LET g_deab_m.deabdocdt = g_today
   #營業日期
   LET g_deab_m.deab001 = g_today
   #存款人員
   LET g_deab_m.deab002 = g_user
   CALL s_desc_get_person_desc(g_deab_m.deab002) RETURNING g_deab_m.deab002_desc
   DISPLAY BY NAME g_deab_m.deab002_desc
   
   #預設單據的單別
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_deab_m.deabsite,g_prog,'1') 
      RETURNING l_success,l_doctype
   LET g_deab_m.deabdocno = l_doctype
   
   LET g_site_flag = FALSE
   LET g_deab_m_t.* = g_deab_m.*
   LET g_deab_m_o.* = g_deab_m.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deab_m.deabstus 
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
   
   
   CALL adet401_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_deab_m.* TO NULL
      INITIALIZE g_deac_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adet401_show()
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
   CALL adet401_set_act_visible()   
   CALL adet401_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deabdocno_t = g_deab_m.deabdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deabent = " ||g_enterprise|| " AND",
                      " deabdocno = '", g_deab_m.deabdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet401_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adet401_idx_chk()
   
   LET g_data_owner = g_deab_m.deabownid      
   LET g_data_dept  = g_deab_m.deabowndp
   
   #功能已完成,通報訊息中心
   CALL adet401_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adet401_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE deac_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adet401_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM deac_t
    WHERE deacent = g_enterprise AND deacdocno = g_deabdocno_t
 
    INTO TEMP adet401_detail
 
   #將key修正為調整後   
   UPDATE adet401_detail 
      #更新key欄位
      SET deacdocno = g_deab_m.deabdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO deac_t SELECT * FROM adet401_detail
   
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
   DROP TABLE adet401_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_deabdocno_t = g_deab_m.deabdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adet401_delete()
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
   
   IF g_deab_m.deabdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adet401_cl USING g_enterprise,g_deab_m.deabdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet401_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet401_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
       g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
       g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT adet401_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deab_m_mask_o.* =  g_deab_m.*
   CALL adet401_deab_t_mask()
   LET g_deab_m_mask_n.* =  g_deab_m.*
   
   CALL adet401_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adet401_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160126-00010#16---add---str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM deac_t
       WHERE deacent = g_enterprise AND deacdocno = g_deab_m.deabdocno
         AND deac002 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
         #160122-00001#16 add by07675
         AND deac002 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(deac002) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE adet401_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
     #160122-00001#16  add by07675
     # IF l_n = 0 THEN
      #160126-00010#16---add---end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_deabdocno_t = g_deab_m.deabdocno
 
 
      DELETE FROM deab_t
       WHERE deabent = g_enterprise AND deabdocno = g_deab_m.deabdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_deab_m.deabdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_deab_m.deabdocno,g_deab_m.deabdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
     # END IF    #160126-00010#16
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM deac_t
       WHERE deacent = g_enterprise AND deacdocno = g_deab_m.deabdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
#      #160126-00010#16---add---str
#          AND (deac002 IN ( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
#           OR deac002 IS NULL)
#      #160126-00010#16---add---end
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_deab_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adet401_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_deac_d.clear() 
 
     
      CALL adet401_ui_browser_refresh()  
      #CALL adet401_ui_headershow()  
      #CALL adet401_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adet401_browser_fill("")
         CALL adet401_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adet401_cl
 
   #功能已完成,通報訊息中心
   CALL adet401_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adet401.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adet401_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_deac_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adet401_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT deacseq,deac005,deac006,deac007,deac002,deac004,deac008,deacsite, 
             deacunit,deac001 ,t1.ooial003 ,t2.nmaal003 FROM deac_t",   
                     " INNER JOIN deab_t ON deabent = " ||g_enterprise|| " AND deabdocno = deacdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=deac006 AND t1.ooial002='"||g_dlang||"' ",
               " LEFT JOIN nmaal_t t2 ON t2.nmaalent="||g_enterprise||" AND t2.nmaal001=deac002 AND t2.nmaal002='"||g_dlang||"' ",
 
                     " WHERE deacent=? AND deacdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
#         LET g_sql = g_sql CLIPPED," AND (deac002 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')
#                                      OR deac002 IS NULL)"  #160122-00001#16
         LET g_sql = g_sql CLIPPED," AND (deac002 IN(",g_sql_bank,") OR TRIM(deac002) IS NULL)"      #160122-00001#16 mod by 07675
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  #160122-00001#16
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY deac_t.deacseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet401_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adet401_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_deab_m.deabdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_deab_m.deabdocno INTO g_deac_d[l_ac].deacseq,g_deac_d[l_ac].deac005, 
          g_deac_d[l_ac].deac006,g_deac_d[l_ac].deac007,g_deac_d[l_ac].deac002,g_deac_d[l_ac].deac004, 
          g_deac_d[l_ac].deac008,g_deac_d[l_ac].deacsite,g_deac_d[l_ac].deacunit,g_deac_d[l_ac].deac001, 
          g_deac_d[l_ac].deac006_desc,g_deac_d[l_ac].deac002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL s_desc_get_nmas002_desc(g_deac_d[l_ac].deac002) RETURNING g_deac_d[l_ac].deac002_desc 
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
   
   CALL g_deac_d.deleteElement(g_deac_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adet401_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_deac_d.getLength()
      LET g_deac_d_mask_o[l_ac].* =  g_deac_d[l_ac].*
      CALL adet401_deac_t_mask()
      LET g_deac_d_mask_n[l_ac].* =  g_deac_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adet401_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM deac_t
       WHERE deacent = g_enterprise AND
         deacdocno = ps_keys_bak[1] AND deacseq = ps_keys_bak[2]
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
         CALL g_deac_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adet401_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO deac_t
                  (deacent,
                   deacdocno,
                   deacseq
                   ,deac005,deac006,deac007,deac002,deac004,deac008,deacsite,deacunit,deac001) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_deac_d[g_detail_idx].deac005,g_deac_d[g_detail_idx].deac006,g_deac_d[g_detail_idx].deac007, 
                       g_deac_d[g_detail_idx].deac002,g_deac_d[g_detail_idx].deac004,g_deac_d[g_detail_idx].deac008, 
                       g_deac_d[g_detail_idx].deacsite,g_deac_d[g_detail_idx].deacunit,g_deac_d[g_detail_idx].deac001) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_deac_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adet401_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "deac_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adet401_deac_t_mask_restore('restore_mask_o')
               
      UPDATE deac_t 
         SET (deacdocno,
              deacseq
              ,deac005,deac006,deac007,deac002,deac004,deac008,deacsite,deacunit,deac001) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_deac_d[g_detail_idx].deac005,g_deac_d[g_detail_idx].deac006,g_deac_d[g_detail_idx].deac007, 
                  g_deac_d[g_detail_idx].deac002,g_deac_d[g_detail_idx].deac004,g_deac_d[g_detail_idx].deac008, 
                  g_deac_d[g_detail_idx].deacsite,g_deac_d[g_detail_idx].deacunit,g_deac_d[g_detail_idx].deac001)  
 
         WHERE deacent = g_enterprise AND deacdocno = ps_keys_bak[1] AND deacseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deac_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deac_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet401_deac_t_mask_restore('restore_mask_n')
               
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
 
{<section id="adet401.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adet401_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adet401.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adet401_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adet401.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adet401_lock_b(ps_table,ps_page)
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
   #CALL adet401_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "deac_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adet401_bcl USING g_enterprise,
                                       g_deab_m.deabdocno,g_deac_d[g_detail_idx].deacseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet401_bcl:",SQLERRMESSAGE 
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
 
{<section id="adet401.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adet401_unlock_b(ps_table,ps_page)
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
      CLOSE adet401_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adet401_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("deabdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("deabdocno",TRUE)
      CALL cl_set_comp_entry("deabdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("deabsite,deabdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adet401_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("deabdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("deabsite,deabdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("deabdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("deabdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #aooi500設定的欄位控卡
   IF NOT s_aooi500_comp_entry(g_prog,'deabsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("deabsite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet401.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adet401_set_entry_b(p_cmd)
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
 
{<section id="adet401.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adet401_set_no_entry_b(p_cmd)
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
 
{<section id="adet401.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adet401_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet401.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adet401_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_deab_m.deabstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet401.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adet401_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet401.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adet401_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet401.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adet401_default_search()
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
      LET ls_wc = ls_wc, " deabdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "deab_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "deac_t" 
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
 
{<section id="adet401.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adet401_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_deab_m.deabstus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_deab_m.deabdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adet401_cl USING g_enterprise,g_deab_m.deabdocno
   IF STATUS THEN
      CLOSE adet401_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet401_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
       g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
       g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT adet401_action_chk() THEN
      CLOSE adet401_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deab_m.deabsite,g_deab_m.deabsite_desc,g_deab_m.deabdocdt,g_deab_m.deabdocno,g_deab_m.deab001, 
       g_deab_m.deab002,g_deab_m.deab002_desc,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
       g_deab_m.deabownid_desc,g_deab_m.deabowndp,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid,g_deab_m.deabcrtid_desc, 
       g_deab_m.deabcrtdp,g_deab_m.deabcrtdp_desc,g_deab_m.deabcrtdt,g_deab_m.deabmodid,g_deab_m.deabmodid_desc, 
       g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfid_desc,g_deab_m.deabcnfdt
 
   CASE g_deab_m.deabstus
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
         CASE g_deab_m.deabstus
            
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
      
      CASE g_deab_m.deabstus 
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
            IF NOT adet401_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet401_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT adet401_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet401_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt 
              FROM nmbt_t
             WHERE nmbtent = g_enterprise
               AND nmbt001 = '9'
               AND nmbt002 = g_deab_m.deabdocno
            IF l_cnt > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ade-00107'
               LET g_errparam.extend = g_deab_m.deabdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               RETURN               
            END IF
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
      g_deab_m.deabstus = lc_state OR cl_null(lc_state) THEN
      CLOSE adet401_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      CALL s_adet401_conf_chk(g_deab_m.deabdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_adet401_conf_upd(g_deab_m.deabdocno) RETURNING l_success
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
      CALL s_adet401_unconf_chk(g_deab_m.deabdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            RETURN
         ELSE
            CALL s_adet401_unconf_upd(g_deab_m.deabdocno) RETURNING l_success
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
      CALL s_adet401_invalid_chk(g_deab_m.deabdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_adet401_invalid_upd(g_deab_m.deabdocno) RETURNING l_success
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
   
   LET g_deab_m.deabmodid = g_user
   LET g_deab_m.deabmoddt = cl_get_current()
   LET g_deab_m.deabstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE deab_t 
      SET (deabstus,deabmodid,deabmoddt) 
        = (g_deab_m.deabstus,g_deab_m.deabmodid,g_deab_m.deabmoddt)     
    WHERE deabent = g_enterprise AND deabdocno = g_deab_m.deabdocno
 
    
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
      EXECUTE adet401_master_referesh USING g_deab_m.deabdocno INTO g_deab_m.deabsite,g_deab_m.deabdocdt, 
          g_deab_m.deabdocno,g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deabunit,g_deab_m.deabstus,g_deab_m.deabownid, 
          g_deab_m.deabowndp,g_deab_m.deabcrtid,g_deab_m.deabcrtdp,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
          g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfdt,g_deab_m.deabsite_desc,g_deab_m.deab002_desc, 
          g_deab_m.deabownid_desc,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp_desc, 
          g_deab_m.deabmodid_desc,g_deab_m.deabcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_deab_m.deabsite,g_deab_m.deabsite_desc,g_deab_m.deabdocdt,g_deab_m.deabdocno, 
          g_deab_m.deab001,g_deab_m.deab002,g_deab_m.deab002_desc,g_deab_m.deabunit,g_deab_m.deabstus, 
          g_deab_m.deabownid,g_deab_m.deabownid_desc,g_deab_m.deabowndp,g_deab_m.deabowndp_desc,g_deab_m.deabcrtid, 
          g_deab_m.deabcrtid_desc,g_deab_m.deabcrtdp,g_deab_m.deabcrtdp_desc,g_deab_m.deabcrtdt,g_deab_m.deabmodid, 
          g_deab_m.deabmodid_desc,g_deab_m.deabmoddt,g_deab_m.deabcnfid,g_deab_m.deabcnfid_desc,g_deab_m.deabcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adet401_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet401_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet401.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adet401_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_deac_d.getLength() THEN
         LET g_detail_idx = g_deac_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_deac_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_deac_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adet401_b_fill2(pi_idx)
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
   
   CALL adet401_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adet401_fill_chk(ps_idx)
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
 
{<section id="adet401.status_show" >}
PRIVATE FUNCTION adet401_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adet401.mask_functions" >}
&include "erp/ade/adet401_mask.4gl"
 
{</section>}
 
{<section id="adet401.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION adet401_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL adet401_show()
   CALL adet401_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_deab_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_deac_d))
 
 
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
   #CALL adet401_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adet401_ui_headershow()
   CALL adet401_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION adet401_draw_out()
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
   CALL adet401_ui_headershow()  
   CALL adet401_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="adet401.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adet401_set_pk_array()
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
   LET g_pk_array[1].values = g_deab_m.deabdocno
   LET g_pk_array[1].column = 'deabdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet401.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adet401.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adet401_msgcentre_notify(lc_state)
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
   CALL adet401_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_deab_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet401.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adet401_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#7 -s by 08172
   SELECT deabstus  INTO g_deab_m.deabstus
     FROM deab_t
    WHERE deabent = g_enterprise
      AND deabdocno = g_deab_m.deabdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_deab_m.deabstus
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
        LET g_errparam.extend = g_deab_m.deabdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adet401_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#7 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet401.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 款別分類的預設款別編號
# Memo...........:
# Usage..........: CALL adet401_deac006_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/15 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adet401_deac006_init()
DEFINE l_cnt          LIKE type_t.num5

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ooie_t
    WHERE ooieent = g_enterprise
      AND ooiesite = g_deab_m.deabsite
      
      IF l_cnt >= 1 THEN 
	     #帶出aooi901預設值
         SELECT ooie001,ooial003
           INTO g_deac_d[l_ac].deac006,g_deac_d[l_ac].deac006_desc
           FROM ooia_t,ooie_t 
	        LEFT JOIN ooial_t ON ooieent = ooialent
	                         AND ooie001 = ooial001 
	                         AND ooial002 = g_dlang
          WHERE ooieent = g_enterprise 
            AND ooiesite = g_deab_m.deabsite
            AND ooiaent = ooieent 
            AND ooia001 = ooie001 
            AND ooia002 =  g_deac_d[l_ac].deac005
            AND ooie008 = 'Y'
      END IF
   
END FUNCTION

################################################################################
# Descriptions...: 控卡不可大於收銀繳款金額（adet402對應款別的實收金額欄位)
# Memo...........:
# Usage..........: CALL adet401_deac007_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2015/05/15 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adet401_deac007_chk()
DEFINE r_success         LIKE type_t.num5
DEFINE l_sum             LIKE deaf_t.deaf006
DEFINE l_sql             STRING

   LET r_success = TRUE
   LET l_sum = 0
   
   #控卡不可大於收銀繳款金額
   LET l_sql = "SELECT SUM(deaf006)",
               "  FROM deag_t ",
               "  LEFT JOIN deaf_t ON deagent = deafent AND deagdocno = deafdocno",
               " WHERE deagent = ",g_enterprise,
               "   AND deagsite = '",g_deab_m.deabsite,"'",       #營運組織
               "   AND deagdocdt = '",g_deab_m.deab001,"'",       #營業日期
               "   AND deaf012 = '",g_deac_d[l_ac].deac005,"'",   #款別分類
               "   AND deaf005 = '",g_deac_d[l_ac].deac006,"'",   #款別
               "   AND deagstus <> 'X'"                           #單據不等於X:作廢
   PREPARE adet401_deac007_chk FROM l_sql
   EXECUTE adet401_deac007_chk INTO l_sum   
   
   IF g_deac_d[l_ac].deac007 > l_sum THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00085'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success   
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查一個營業日期(deab001)只能存在於一張單據中
# Memo...........:
# Usage..........: CALL adet401_deab001_chk(p_type)
#                  RETURNING r_success
# Input parameter: p_deab001     日期
# Input parameter: p_type        判斷狀態:1.預設值2.重複值
# Return code....: r_success     True/False
# Date & Author..: 2015/05/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adet401_deab001_chk(p_deab001,p_type)
DEFINE p_deab001   LIKE deab_t.deab001
DEFINE p_type      LIKE type_t.chr1
DEFINE r_success   LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(deab001) INTO l_cnt
     FROM deab_t
    WHERE deabent  = g_enterprise
	   AND deabsite = g_deab_m.deabsite
      AND deab001  = p_deab001
   
   IF l_cnt >= 1 THEN
      IF p_type = '2' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ade-00092'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_deab_m.deab001
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET r_success = FALSE
         RETURN r_success
      END IF         
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
