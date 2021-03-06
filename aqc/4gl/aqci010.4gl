#該程式未解開Section, 採用最新樣板產出!
{<section id="aqci010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-05-19 17:58:58), PR版次:0008(2016-10-26 11:17:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000276
#+ Filename...: aqci010
#+ Description: 品質檢驗標準設定作業
#+ Creator....: 01996(2013-10-28 09:59:35)
#+ Modifier...: 02294 -SD/PR- 01534
 
{</section>}
 
{<section id="aqci010.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160107-00014#1   2016/01/11  By Ann_huang 品管分群(qcam002)需排除ALL的部分
#160519-00045#1   2016/05/19  By lixiang 指定儀器開窗依資源類型開窗相符之mrba_t資料
#161018-00003#1   2016/10/26  By lixh    單身每次維護完後，檢驗規格頁籤的檢驗項目說明就會顯示不出來
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
PRIVATE type type_g_qcam_m        RECORD
       qcam001 LIKE qcam_t.qcam001, 
   qcam001_desc LIKE type_t.chr80, 
   qcam002 LIKE qcam_t.qcam002, 
   qcam002_desc LIKE type_t.chr80, 
   qcam003 LIKE qcam_t.qcam003, 
   qcam003_desc LIKE type_t.chr80, 
   qcam004 LIKE qcam_t.qcam004, 
   qcam005 LIKE qcam_t.qcam005, 
   qcam005_desc LIKE type_t.chr80, 
   qcam006 LIKE qcam_t.qcam006, 
   qcam007 LIKE qcam_t.qcam007, 
   qcam008 LIKE qcam_t.qcam008, 
   qcam008_desc LIKE type_t.chr80, 
   qcam009 LIKE qcam_t.qcam009, 
   qcam010 LIKE qcam_t.qcam010, 
   qcamstus LIKE qcam_t.qcamstus, 
   qcamownid LIKE qcam_t.qcamownid, 
   qcamownid_desc LIKE type_t.chr80, 
   qcamowndp LIKE qcam_t.qcamowndp, 
   qcamowndp_desc LIKE type_t.chr80, 
   qcamcrtid LIKE qcam_t.qcamcrtid, 
   qcamcrtid_desc LIKE type_t.chr80, 
   qcamcrtdp LIKE qcam_t.qcamcrtdp, 
   qcamcrtdp_desc LIKE type_t.chr80, 
   qcamcrtdt LIKE qcam_t.qcamcrtdt, 
   qcammodid LIKE qcam_t.qcammodid, 
   qcammodid_desc LIKE type_t.chr80, 
   qcammoddt LIKE qcam_t.qcammoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_qcan_d        RECORD
       qcan009 LIKE qcan_t.qcan009, 
   qcan010 LIKE qcan_t.qcan010, 
   qcan010_desc LIKE type_t.chr500, 
   qcan011 LIKE qcan_t.qcan011, 
   qcan012 LIKE qcan_t.qcan012, 
   qcan013 LIKE qcan_t.qcan013, 
   qcan014 LIKE qcan_t.qcan014, 
   qcan015 LIKE qcan_t.qcan015, 
   qcan016 LIKE qcan_t.qcan016, 
   qcan016_desc LIKE type_t.chr500, 
   qcan017 LIKE qcan_t.qcan017, 
   qcan018 LIKE qcan_t.qcan018
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_qcam001 LIKE qcam_t.qcam001,
   b_qcam001_desc LIKE type_t.chr80,
      b_qcam002 LIKE qcam_t.qcam002,
   b_qcam002_desc LIKE type_t.chr80,
      b_qcam003 LIKE qcam_t.qcam003,
   b_qcam003_desc LIKE type_t.chr80,
   b_qcam003_desc_desc LIKE type_t.chr80,
      b_qcam004 LIKE qcam_t.qcam004,
      b_qcam005 LIKE qcam_t.qcam005,
   b_qcam005_desc LIKE type_t.chr80,
      b_qcam006 LIKE qcam_t.qcam006,
      b_qcam007 LIKE qcam_t.qcam007,
      b_qcam008 LIKE qcam_t.qcam008,
   b_qcam008_desc LIKE type_t.chr80,
      b_qcam009 LIKE qcam_t.qcam009
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_qcan2_d RECORD
                    qcan009_1   LIKE qcan_t.qcan009,
                    qcan010_1   LIKE qcan_t.qcan010,
                    qcan010_1_desc LIKE type_t.chr80,
                    qcan011_1   LIKE qcan_t.qcan011,
                    qcan013_1   LIKE qcan_t.qcan013,
                    qcan019   LIKE qcan_t.qcan019,
                    qcan020   LIKE qcan_t.qcan020,
                    qcan021   LIKE qcan_t.qcan021,
                    qcan022   LIKE qcan_t.qcan022,
                    qcan023   LIKE qcan_t.qcan023,
                    qcan024   LIKE qcan_t.qcan024,
                    qcan025   LIKE qcan_t.qcan025,
                    qcan026   LIKE qcan_t.qcan026
                          END RECORD
DEFINE g_qcan2_d          DYNAMIC ARRAY OF type_g_qcan2_d
DEFINE g_qcan2_d_t        type_g_qcan2_d
DEFINE g_wc2_table2          STRING         
DEFINE l_ac2                  LIKE type_t.num5   
DEFINE g_forupd_sql2          STRING
DEFINE g_cnt2             LIKE type_t.num5
DEFINE g_qcam001          LIKE qcam_t.qcam001
#end add-point
       
#模組變數(Module Variables)
DEFINE g_qcam_m          type_g_qcam_m
DEFINE g_qcam_m_t        type_g_qcam_m
DEFINE g_qcam_m_o        type_g_qcam_m
DEFINE g_qcam_m_mask_o   type_g_qcam_m #轉換遮罩前資料
DEFINE g_qcam_m_mask_n   type_g_qcam_m #轉換遮罩後資料
 
   DEFINE g_qcam001_t LIKE qcam_t.qcam001
DEFINE g_qcam002_t LIKE qcam_t.qcam002
DEFINE g_qcam003_t LIKE qcam_t.qcam003
DEFINE g_qcam004_t LIKE qcam_t.qcam004
DEFINE g_qcam005_t LIKE qcam_t.qcam005
DEFINE g_qcam006_t LIKE qcam_t.qcam006
DEFINE g_qcam008_t LIKE qcam_t.qcam008
DEFINE g_qcam009_t LIKE qcam_t.qcam009
 
 
DEFINE g_qcan_d          DYNAMIC ARRAY OF type_g_qcan_d
DEFINE g_qcan_d_t        type_g_qcan_d
DEFINE g_qcan_d_o        type_g_qcan_d
DEFINE g_qcan_d_mask_o   DYNAMIC ARRAY OF type_g_qcan_d #轉換遮罩前資料
DEFINE g_qcan_d_mask_n   DYNAMIC ARRAY OF type_g_qcan_d #轉換遮罩後資料
 
 
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
 
{<section id="aqci010.main" >}
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
   CALL cl_ap_init("aqc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT qcam001,'',qcam002,'',qcam003,'',qcam004,qcam005,'',qcam006,qcam007,qcam008, 
       '',qcam009,qcam010,qcamstus,qcamownid,'',qcamowndp,'',qcamcrtid,'',qcamcrtdp,'',qcamcrtdt,qcammodid, 
       '',qcammoddt", 
                      " FROM qcam_t",
                      " WHERE qcament= ? AND qcam001=? AND qcam002=? AND qcam003=? AND qcam004=? AND  
                          qcam005=? AND qcam006=? AND qcam008=? AND qcam009=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqci010_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.qcam001,t0.qcam002,t0.qcam003,t0.qcam004,t0.qcam005,t0.qcam006,t0.qcam007, 
       t0.qcam008,t0.qcam009,t0.qcam010,t0.qcamstus,t0.qcamownid,t0.qcamowndp,t0.qcamcrtid,t0.qcamcrtdp, 
       t0.qcamcrtdt,t0.qcammodid,t0.qcammoddt,t1.ooall004 ,t2.oocql004 ,t3.imaal003 ,t4.oocql004 ,t5.pmaal004 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011",
               " FROM qcam_t t0",
                              " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='5' AND t1.ooall002=t0.qcam001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.qcam002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.qcam003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='221' AND t4.oocql002=t0.qcam005 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.qcam008 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.qcamownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.qcamowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.qcamcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.qcamcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.qcammodid  ",
 
               " WHERE t0.qcament = " ||g_enterprise|| " AND t0.qcam001 = ? AND t0.qcam002 = ? AND t0.qcam003 = ? AND t0.qcam004 = ? AND t0.qcam005 = ? AND t0.qcam006 = ? AND t0.qcam008 = ? AND t0.qcam009 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aqci010_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqci010 WITH FORM cl_ap_formpath("aqc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aqci010_init()   
 
      #進入選單 Menu (="N")
      CALL aqci010_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aqci010
      
   END IF 
   
   CLOSE aqci010_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aqci010.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aqci010_init()
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
      CALL cl_set_combo_scc_part('qcamstus','17','N,Y')
 
      CALL cl_set_combo_scc('qcam007','5055') 
   CALL cl_set_combo_scc('qcam009','5056') 
   CALL cl_set_combo_scc('qcan012','5057') 
   CALL cl_set_combo_scc('qcan013','5058') 
   CALL cl_set_combo_scc('qcan015','5059') 
   CALL cl_set_combo_scc('qcan017','5202') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('qcan013_1','5058') 
   CALL cl_set_combo_scc('b_qcam009','5056') 
   CALL cl_get_para(g_enterprise,g_site,'S-MFG-0046') RETURNING g_qcam001  #add by lixh 20150703 150702-00006#10
   #end add-point
   
   #初始化搜尋條件
   CALL aqci010_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aqci010.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aqci010_ui_dialog()
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
            CALL aqci010_insert()
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
         INITIALIZE g_qcam_m.* TO NULL
         CALL g_qcan_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aqci010_init()
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
               
               CALL aqci010_fetch('') # reload data
               LET l_ac = 1
               CALL aqci010_ui_detailshow() #Setting the current row 
         
               CALL aqci010_idx_chk()
               #NEXT FIELD qcan009
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_qcan_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aqci010_idx_chk()
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
               CALL aqci010_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_qcan2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page2  
    
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac2
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
              
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aqci010_browser_fill("")
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
               CALL aqci010_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aqci010_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aqci010_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aqci010_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aqci010_set_act_visible()   
            CALL aqci010_set_act_no_visible()
            IF NOT (g_qcam_m.qcam001 IS NULL
              OR g_qcam_m.qcam002 IS NULL
              OR g_qcam_m.qcam003 IS NULL
              OR g_qcam_m.qcam004 IS NULL
              OR g_qcam_m.qcam005 IS NULL
              OR g_qcam_m.qcam006 IS NULL
              OR g_qcam_m.qcam008 IS NULL
              OR g_qcam_m.qcam009 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " qcament = " ||g_enterprise|| " AND",
                                  " qcam001 = '", g_qcam_m.qcam001, "' "
                                  ," AND qcam002 = '", g_qcam_m.qcam002, "' "
                                  ," AND qcam003 = '", g_qcam_m.qcam003, "' "
                                  ," AND qcam004 = '", g_qcam_m.qcam004, "' "
                                  ," AND qcam005 = '", g_qcam_m.qcam005, "' "
                                  ," AND qcam006 = '", g_qcam_m.qcam006, "' "
                                  ," AND qcam008 = '", g_qcam_m.qcam008, "' "
                                  ," AND qcam009 = '", g_qcam_m.qcam009, "' "
 
               #填到對應位置
               CALL aqci010_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "qcam_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "qcan_t" 
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
               CALL aqci010_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "qcam_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "qcan_t" 
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
                  CALL aqci010_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aqci010_fetch("F")
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
               CALL aqci010_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aqci010_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aqci010_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aqci010_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aqci010_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aqci010_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aqci010_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aqci010_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aqci010_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aqci010_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aqci010_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_qcan_d)
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
               NEXT FIELD qcan009
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
               CALL aqci010_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aqci010_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aqci010_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aqci010_insert()
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aqci010_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aqci010_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aqci010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aqci010_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aqci010_set_pk_array()
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
 
{<section id="aqci010.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aqci010_browser_fill(ps_page_action)
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
   #add by lixh 20150703 150702-00006#10
   IF cl_null(g_wc) THEN
      LET g_wc = " qcam001 = '",g_qcam001,"'"
   ELSE
      LET g_wc = g_wc," AND qcam001 = '",g_qcam001,"'"  
   END IF
   #add by lixh 20150703 150702-00006#10
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
      LET l_sub_sql = " SELECT DISTINCT qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009 ", 
 
                      " FROM qcam_t ",
                      " ",
                      " LEFT JOIN qcan_t ON qcanent = qcament AND qcam001 = qcan001 AND qcam002 = qcan002 AND qcam003 = qcan003 AND qcam004 = qcan004 AND qcam005 = qcan005 AND qcam006 = qcan006 AND qcam008 = qcan007 AND qcam009 = qcan008 ", "  ",
                      #add-point:browser_fill段sql(qcan_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE qcament = " ||g_enterprise|| " AND qcanent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("qcam_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009 ", 
 
                      " FROM qcam_t ", 
                      "  ",
                      "  ",
                      " WHERE qcament = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("qcam_t")
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
      INITIALIZE g_qcam_m.* TO NULL
      CALL g_qcan_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.qcam001,t0.qcam002,t0.qcam003,t0.qcam004,t0.qcam005,t0.qcam006,t0.qcam007,t0.qcam008,t0.qcam009 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.qcamstus,t0.qcam001,t0.qcam002,t0.qcam003,t0.qcam004,t0.qcam005, 
          t0.qcam006,t0.qcam007,t0.qcam008,t0.qcam009,t1.ooall004 ,t2.oocql004 ,t3.imaal003 ,t4.imaal004 , 
          t5.oocql004 ,t6.pmaal004 ",
                  " FROM qcam_t t0",
                  "  ",
                  "  LEFT JOIN qcan_t ON qcanent = qcament AND qcam001 = qcan001 AND qcam002 = qcan002 AND qcam003 = qcan003 AND qcam004 = qcan004 AND qcam005 = qcan005 AND qcam006 = qcan006 AND qcam008 = qcan007 AND qcam009 = qcan008 ", "  ", 
                  #add-point:browser_fill段sql(qcan_t1) name="browser_fill.join.qcan_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='5' AND t1.ooall002=t0.qcam001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.qcam002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.qcam003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.qcam003 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=t0.qcam005 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.qcam008 AND t6.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.qcament = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("qcam_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.qcamstus,t0.qcam001,t0.qcam002,t0.qcam003,t0.qcam004,t0.qcam005, 
          t0.qcam006,t0.qcam007,t0.qcam008,t0.qcam009,t1.ooall004 ,t2.oocql004 ,t3.imaal003 ,t4.imaal004 , 
          t5.oocql004 ,t6.pmaal004 ",
                  " FROM qcam_t t0",
                  "  ",
                                 " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='5' AND t1.ooall002=t0.qcam001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.qcam002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.qcam003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.qcam003 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=t0.qcam005 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.qcam008 AND t6.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.qcament = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("qcam_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"qcam_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_qcam001,g_browser[g_cnt].b_qcam002, 
          g_browser[g_cnt].b_qcam003,g_browser[g_cnt].b_qcam004,g_browser[g_cnt].b_qcam005,g_browser[g_cnt].b_qcam006, 
          g_browser[g_cnt].b_qcam007,g_browser[g_cnt].b_qcam008,g_browser[g_cnt].b_qcam009,g_browser[g_cnt].b_qcam001_desc, 
          g_browser[g_cnt].b_qcam002_desc,g_browser[g_cnt].b_qcam003_desc,g_browser[g_cnt].b_qcam003_desc_desc, 
          g_browser[g_cnt].b_qcam005_desc,g_browser[g_cnt].b_qcam008_desc
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
         CALL aqci010_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_qcam001) THEN
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
 
{<section id="aqci010.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aqci010_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_qcam_m.qcam001 = g_browser[g_current_idx].b_qcam001   
   LET g_qcam_m.qcam002 = g_browser[g_current_idx].b_qcam002   
   LET g_qcam_m.qcam003 = g_browser[g_current_idx].b_qcam003   
   LET g_qcam_m.qcam004 = g_browser[g_current_idx].b_qcam004   
   LET g_qcam_m.qcam005 = g_browser[g_current_idx].b_qcam005   
   LET g_qcam_m.qcam006 = g_browser[g_current_idx].b_qcam006   
   LET g_qcam_m.qcam008 = g_browser[g_current_idx].b_qcam008   
   LET g_qcam_m.qcam009 = g_browser[g_current_idx].b_qcam009   
 
   EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
       g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001,g_qcam_m.qcam002, 
       g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008, 
       g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt,g_qcam_m.qcam001_desc, 
       g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc,g_qcam_m.qcamownid_desc, 
       g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcammodid_desc 
 
   
   CALL aqci010_qcam_t_mask()
   CALL aqci010_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aqci010.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aqci010_ui_detailshow()
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
 
{<section id="aqci010.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aqci010_ui_browser_refresh()
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
      IF g_browser[l_i].b_qcam001 = g_qcam_m.qcam001 
         AND g_browser[l_i].b_qcam002 = g_qcam_m.qcam002 
         AND g_browser[l_i].b_qcam003 = g_qcam_m.qcam003 
         AND g_browser[l_i].b_qcam004 = g_qcam_m.qcam004 
         AND g_browser[l_i].b_qcam005 = g_qcam_m.qcam005 
         AND g_browser[l_i].b_qcam006 = g_qcam_m.qcam006 
         AND g_browser[l_i].b_qcam008 = g_qcam_m.qcam008 
         AND g_browser[l_i].b_qcam009 = g_qcam_m.qcam009 
 
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
 
{<section id="aqci010.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aqci010_construct()
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
   INITIALIZE g_qcam_m.* TO NULL
   CALL g_qcan_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   INITIALIZE g_wc2_table2 TO NULL
   CALL g_qcan2_d.clear()
   #add by lixh 20150703 150702-00006#10
   LET g_qcam_m.qcam001 = g_qcam001
   CALL aqci010_qcam001_desc(g_qcam_m.qcam001)  
   DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc
   #add by lixh 20150703 150702-00006#10   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON qcam002,qcam003,qcam004,qcam005,qcam006,qcam007,qcam008,qcam009,qcam010, 
          qcamstus,qcamownid,qcamowndp,qcamcrtid,qcamcrtdp,qcamcrtdt,qcammodid,qcammoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<qcamcrtdt>>----
         AFTER FIELD qcamcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<qcammoddt>>----
         AFTER FIELD qcammoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<qcamcnfdt>>----
         
         #----<<qcampstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.qcam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam002
            #add-point:ON ACTION controlp INFIELD qcam002 name="construct.c.qcam002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#150527 by whitney modify start
#            CALL q_imcg111()                           #呼叫開窗
            LET g_qryparam.arg1 = "205" 
            CALL q_oocq002()                       #呼叫開窗
#150527 by whitney modify end
            DISPLAY g_qryparam.return1 TO qcam002  #顯示到畫面上

            NEXT FIELD qcam002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam002
            #add-point:BEFORE FIELD qcam002 name="construct.b.qcam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam002
            
            #add-point:AFTER FIELD qcam002 name="construct.a.qcam002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcam003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam003
            #add-point:ON ACTION controlp INFIELD qcam003 name="construct.c.qcam003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcam003  #顯示到畫面上

            NEXT FIELD qcam003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam003
            #add-point:BEFORE FIELD qcam003 name="construct.b.qcam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam003
            
            #add-point:AFTER FIELD qcam003 name="construct.a.qcam003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam004
            #add-point:BEFORE FIELD qcam004 name="construct.b.qcam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam004
            
            #add-point:AFTER FIELD qcam004 name="construct.a.qcam004"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcam004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam004
            #add-point:ON ACTION controlp INFIELD qcam004 name="construct.c.qcam004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_qcam004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcam004  #顯示到畫面上

            NEXT FIELD qcam004
            #END add-point
 
 
         #Ctrlp:construct.c.qcam005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam005
            #add-point:ON ACTION controlp INFIELD qcam005 name="construct.c.qcam005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcam005  #顯示到畫面上

            NEXT FIELD qcam005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam005
            #add-point:BEFORE FIELD qcam005 name="construct.b.qcam005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam005
            
            #add-point:AFTER FIELD qcam005 name="construct.a.qcam005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam006
            #add-point:BEFORE FIELD qcam006 name="construct.b.qcam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam006
            
            #add-point:AFTER FIELD qcam006 name="construct.a.qcam006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam006
            #add-point:ON ACTION controlp INFIELD qcam006 name="construct.c.qcam006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam007
            #add-point:BEFORE FIELD qcam007 name="construct.b.qcam007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam007
            
            #add-point:AFTER FIELD qcam007 name="construct.a.qcam007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam007
            #add-point:ON ACTION controlp INFIELD qcam007 name="construct.c.qcam007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam008
            #add-point:ON ACTION controlp INFIELD qcam008 name="construct.c.qcam008"
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = "('1','2','3')"
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcam008  #顯示到畫面上

            NEXT FIELD qcam008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam008
            #add-point:BEFORE FIELD qcam008 name="construct.b.qcam008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam008
            
            #add-point:AFTER FIELD qcam008 name="construct.a.qcam008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam009
            #add-point:BEFORE FIELD qcam009 name="construct.b.qcam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam009
            
            #add-point:AFTER FIELD qcam009 name="construct.a.qcam009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam009
            #add-point:ON ACTION controlp INFIELD qcam009 name="construct.c.qcam009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam010
            #add-point:BEFORE FIELD qcam010 name="construct.b.qcam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam010
            
            #add-point:AFTER FIELD qcam010 name="construct.a.qcam010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam010
            #add-point:ON ACTION controlp INFIELD qcam010 name="construct.c.qcam010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamstus
            #add-point:BEFORE FIELD qcamstus name="construct.b.qcamstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamstus
            
            #add-point:AFTER FIELD qcamstus name="construct.a.qcamstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamstus
            #add-point:ON ACTION controlp INFIELD qcamstus name="construct.c.qcamstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcamownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamownid
            #add-point:ON ACTION controlp INFIELD qcamownid name="construct.c.qcamownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamownid  #顯示到畫面上

            NEXT FIELD qcamownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamownid
            #add-point:BEFORE FIELD qcamownid name="construct.b.qcamownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamownid
            
            #add-point:AFTER FIELD qcamownid name="construct.a.qcamownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamowndp
            #add-point:ON ACTION controlp INFIELD qcamowndp name="construct.c.qcamowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamowndp  #顯示到畫面上

            NEXT FIELD qcamowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamowndp
            #add-point:BEFORE FIELD qcamowndp name="construct.b.qcamowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamowndp
            
            #add-point:AFTER FIELD qcamowndp name="construct.a.qcamowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamcrtid
            #add-point:ON ACTION controlp INFIELD qcamcrtid name="construct.c.qcamcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamcrtid  #顯示到畫面上

            NEXT FIELD qcamcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamcrtid
            #add-point:BEFORE FIELD qcamcrtid name="construct.b.qcamcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamcrtid
            
            #add-point:AFTER FIELD qcamcrtid name="construct.a.qcamcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamcrtdp
            #add-point:ON ACTION controlp INFIELD qcamcrtdp name="construct.c.qcamcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamcrtdp  #顯示到畫面上

            NEXT FIELD qcamcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamcrtdp
            #add-point:BEFORE FIELD qcamcrtdp name="construct.b.qcamcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamcrtdp
            
            #add-point:AFTER FIELD qcamcrtdp name="construct.a.qcamcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamcrtdt
            #add-point:BEFORE FIELD qcamcrtdt name="construct.b.qcamcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcammodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcammodid
            #add-point:ON ACTION controlp INFIELD qcammodid name="construct.c.qcammodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcammodid  #顯示到畫面上

            NEXT FIELD qcammodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcammodid
            #add-point:BEFORE FIELD qcammodid name="construct.b.qcammodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcammodid
            
            #add-point:AFTER FIELD qcammodid name="construct.a.qcammodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcammoddt
            #add-point:BEFORE FIELD qcammoddt name="construct.b.qcammoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON qcan009,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017, 
          qcan018
           FROM s_detail1[1].qcan009,s_detail1[1].qcan010,s_detail1[1].qcan011,s_detail1[1].qcan012, 
               s_detail1[1].qcan013,s_detail1[1].qcan014,s_detail1[1].qcan015,s_detail1[1].qcan016,s_detail1[1].qcan017, 
               s_detail1[1].qcan018
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan009
            #add-point:BEFORE FIELD qcan009 name="construct.b.page1.qcan009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan009
            
            #add-point:AFTER FIELD qcan009 name="construct.a.page1.qcan009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan009
            #add-point:ON ACTION controlp INFIELD qcan009 name="construct.c.page1.qcan009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.qcan010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan010
            #add-point:ON ACTION controlp INFIELD qcan010 name="construct.c.page1.qcan010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1051'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcan010  #顯示到畫面上

            NEXT FIELD qcan010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan010
            #add-point:BEFORE FIELD qcan010 name="construct.b.page1.qcan010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan010
            
            #add-point:AFTER FIELD qcan010 name="construct.a.page1.qcan010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan011
            #add-point:BEFORE FIELD qcan011 name="construct.b.page1.qcan011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan011
            
            #add-point:AFTER FIELD qcan011 name="construct.a.page1.qcan011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan011
            #add-point:ON ACTION controlp INFIELD qcan011 name="construct.c.page1.qcan011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan012
            #add-point:BEFORE FIELD qcan012 name="construct.b.page1.qcan012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan012
            
            #add-point:AFTER FIELD qcan012 name="construct.a.page1.qcan012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan012
            #add-point:ON ACTION controlp INFIELD qcan012 name="construct.c.page1.qcan012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan013
            #add-point:BEFORE FIELD qcan013 name="construct.b.page1.qcan013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan013
            
            #add-point:AFTER FIELD qcan013 name="construct.a.page1.qcan013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan013
            #add-point:ON ACTION controlp INFIELD qcan013 name="construct.c.page1.qcan013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan014
            #add-point:BEFORE FIELD qcan014 name="construct.b.page1.qcan014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan014
            
            #add-point:AFTER FIELD qcan014 name="construct.a.page1.qcan014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan014
            #add-point:ON ACTION controlp INFIELD qcan014 name="construct.c.page1.qcan014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan015
            #add-point:BEFORE FIELD qcan015 name="construct.b.page1.qcan015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan015
            
            #add-point:AFTER FIELD qcan015 name="construct.a.page1.qcan015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan015
            #add-point:ON ACTION controlp INFIELD qcan015 name="construct.c.page1.qcan015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.qcan016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan016
            #add-point:ON ACTION controlp INFIELD qcan016 name="construct.c.page1.qcan016"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1052'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcan016  #顯示到畫面上

            NEXT FIELD qcan016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan016
            #add-point:BEFORE FIELD qcan016 name="construct.b.page1.qcan016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan016
            
            #add-point:AFTER FIELD qcan016 name="construct.a.page1.qcan016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan017
            #add-point:BEFORE FIELD qcan017 name="construct.b.page1.qcan017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan017
            
            #add-point:AFTER FIELD qcan017 name="construct.a.page1.qcan017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcan017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan017
            #add-point:ON ACTION controlp INFIELD qcan017 name="construct.c.page1.qcan017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.qcan018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan018
            #add-point:ON ACTION controlp INFIELD qcan018 name="construct.c.page1.qcan018"
            #160519-00045#1--s
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcan018  #顯示到畫面上
            NEXT FIELD qcan018                     #返回原欄位
            #160519-00045#1--e



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan018
            #add-point:BEFORE FIELD qcan018 name="construct.b.page1.qcan018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan018
            
            #add-point:AFTER FIELD qcan018 name="construct.a.page1.qcan018"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
       CONSTRUCT g_wc2_table2 ON qcan019,qcan020,qcan021,qcan022,qcan023,qcan024,qcan025,qcan026
           FROM s_detail2[1].qcan019,s_detail2[1].qcan020,s_detail2[1].qcan021,s_detail2[1].qcan022,
                s_detail2[1].qcan023,s_detail2[1].qcan024,s_detail2[1].qcan025,s_detail2[1].qcan026
                      
        
       
       END CONSTRUCT
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
                  WHEN la_wc[li_idx].tableid = "qcam_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "qcan_t" 
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
   LET g_wc2 = g_wc2_table1," AND ",g_wc2_table2
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aqci010_filter()
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
      CONSTRUCT g_wc_filter ON qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam007,qcam008,qcam009 
 
                          FROM s_browse[1].b_qcam001,s_browse[1].b_qcam002,s_browse[1].b_qcam003,s_browse[1].b_qcam004, 
                              s_browse[1].b_qcam005,s_browse[1].b_qcam006,s_browse[1].b_qcam007,s_browse[1].b_qcam008, 
                              s_browse[1].b_qcam009
 
         BEFORE CONSTRUCT
               DISPLAY aqci010_filter_parser('qcam001') TO s_browse[1].b_qcam001
            DISPLAY aqci010_filter_parser('qcam002') TO s_browse[1].b_qcam002
            DISPLAY aqci010_filter_parser('qcam003') TO s_browse[1].b_qcam003
            DISPLAY aqci010_filter_parser('qcam004') TO s_browse[1].b_qcam004
            DISPLAY aqci010_filter_parser('qcam005') TO s_browse[1].b_qcam005
            DISPLAY aqci010_filter_parser('qcam006') TO s_browse[1].b_qcam006
            DISPLAY aqci010_filter_parser('qcam007') TO s_browse[1].b_qcam007
            DISPLAY aqci010_filter_parser('qcam008') TO s_browse[1].b_qcam008
            DISPLAY aqci010_filter_parser('qcam009') TO s_browse[1].b_qcam009
      
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
 
      CALL aqci010_filter_show('qcam001')
   CALL aqci010_filter_show('qcam002')
   CALL aqci010_filter_show('qcam003')
   CALL aqci010_filter_show('qcam004')
   CALL aqci010_filter_show('qcam005')
   CALL aqci010_filter_show('qcam006')
   CALL aqci010_filter_show('qcam007')
   CALL aqci010_filter_show('qcam008')
   CALL aqci010_filter_show('qcam009')
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aqci010_filter_parser(ps_field)
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
 
{<section id="aqci010.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aqci010_filter_show(ps_field)
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
   LET ls_condition = aqci010_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aqci010_query()
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
   CALL g_qcan_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aqci010_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aqci010_browser_fill("")
      CALL aqci010_fetch("")
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
      CALL aqci010_filter_show('qcam001')
   CALL aqci010_filter_show('qcam002')
   CALL aqci010_filter_show('qcam003')
   CALL aqci010_filter_show('qcam004')
   CALL aqci010_filter_show('qcam005')
   CALL aqci010_filter_show('qcam006')
   CALL aqci010_filter_show('qcam007')
   CALL aqci010_filter_show('qcam008')
   CALL aqci010_filter_show('qcam009')
   CALL aqci010_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aqci010_fetch("F") 
      #顯示單身筆數
      CALL aqci010_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aqci010_fetch(p_flag)
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
   
   LET g_qcam_m.qcam001 = g_browser[g_current_idx].b_qcam001
   LET g_qcam_m.qcam002 = g_browser[g_current_idx].b_qcam002
   LET g_qcam_m.qcam003 = g_browser[g_current_idx].b_qcam003
   LET g_qcam_m.qcam004 = g_browser[g_current_idx].b_qcam004
   LET g_qcam_m.qcam005 = g_browser[g_current_idx].b_qcam005
   LET g_qcam_m.qcam006 = g_browser[g_current_idx].b_qcam006
   LET g_qcam_m.qcam008 = g_browser[g_current_idx].b_qcam008
   LET g_qcam_m.qcam009 = g_browser[g_current_idx].b_qcam009
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
       g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001,g_qcam_m.qcam002, 
       g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008, 
       g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt,g_qcam_m.qcam001_desc, 
       g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc,g_qcam_m.qcamownid_desc, 
       g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcammodid_desc 
 
   
   #遮罩相關處理
   LET g_qcam_m_mask_o.* =  g_qcam_m.*
   CALL aqci010_qcam_t_mask()
   LET g_qcam_m_mask_n.* =  g_qcam_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aqci010_set_act_visible()   
   CALL aqci010_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_qcam_m_t.* = g_qcam_m.*
   LET g_qcam_m_o.* = g_qcam_m.*
   
   LET g_data_owner = g_qcam_m.qcamownid      
   LET g_data_dept  = g_qcam_m.qcamowndp
   
   #重新顯示   
   CALL aqci010_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.insert" >}
#+ 資料新增
PRIVATE FUNCTION aqci010_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_qcan_d.clear()   
 
 
   INITIALIZE g_qcam_m.* TO NULL             #DEFAULT 設定
   
   LET g_qcam001_t = NULL
   LET g_qcam002_t = NULL
   LET g_qcam003_t = NULL
   LET g_qcam004_t = NULL
   LET g_qcam005_t = NULL
   LET g_qcam006_t = NULL
   LET g_qcam008_t = NULL
   LET g_qcam009_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_qcam_m.qcamownid = g_user
      LET g_qcam_m.qcamowndp = g_dept
      LET g_qcam_m.qcamcrtid = g_user
      LET g_qcam_m.qcamcrtdp = g_dept 
      LET g_qcam_m.qcamcrtdt = cl_get_current()
      LET g_qcam_m.qcammodid = g_user
      LET g_qcam_m.qcammoddt = cl_get_current()
      LET g_qcam_m.qcamstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_qcam_m.qcam007 = "0"
      LET g_qcam_m.qcam009 = "0"
      LET g_qcam_m.qcamstus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_qcam_m.qcam004 = 'ALL'
      LET g_qcam_m.qcam008 = 'ALL'
      LET g_qcam008_t = g_qcam_m.qcam008
      LET g_qcam004_t = g_qcam_m.qcam004
      LET g_qcam_m.qcam006 = 0
      LET g_qcam006_t = g_qcam_m.qcam006
      #add by lixh 20150703 150702-00006#10
      LET g_qcam_m.qcam001 = g_qcam001
      CALL aqci010_qcam001_desc(g_qcam_m.qcam001)  
      DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc
      #add by lixh 20150703 150702-00006#10      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_qcam_m_t.* = g_qcam_m.*
      LET g_qcam_m_o.* = g_qcam_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_qcam_m.qcamstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL aqci010_input("a")
      
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
         INITIALIZE g_qcam_m.* TO NULL
         INITIALIZE g_qcan_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aqci010_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_qcan_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aqci010_set_act_visible()   
   CALL aqci010_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_qcam001_t = g_qcam_m.qcam001
   LET g_qcam002_t = g_qcam_m.qcam002
   LET g_qcam003_t = g_qcam_m.qcam003
   LET g_qcam004_t = g_qcam_m.qcam004
   LET g_qcam005_t = g_qcam_m.qcam005
   LET g_qcam006_t = g_qcam_m.qcam006
   LET g_qcam008_t = g_qcam_m.qcam008
   LET g_qcam009_t = g_qcam_m.qcam009
 
   
   #組合新增資料的條件
   LET g_add_browse = " qcament = " ||g_enterprise|| " AND",
                      " qcam001 = '", g_qcam_m.qcam001, "' "
                      ," AND qcam002 = '", g_qcam_m.qcam002, "' "
                      ," AND qcam003 = '", g_qcam_m.qcam003, "' "
                      ," AND qcam004 = '", g_qcam_m.qcam004, "' "
                      ," AND qcam005 = '", g_qcam_m.qcam005, "' "
                      ," AND qcam006 = '", g_qcam_m.qcam006, "' "
                      ," AND qcam008 = '", g_qcam_m.qcam008, "' "
                      ," AND qcam009 = '", g_qcam_m.qcam009, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aqci010_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aqci010_cl
   
   CALL aqci010_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
       g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001,g_qcam_m.qcam002, 
       g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008, 
       g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt,g_qcam_m.qcam001_desc, 
       g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc,g_qcam_m.qcamownid_desc, 
       g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcammodid_desc 
 
   
   
   #遮罩相關處理
   LET g_qcam_m_mask_o.* =  g_qcam_m.*
   CALL aqci010_qcam_t_mask()
   LET g_qcam_m_mask_n.* =  g_qcam_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc,g_qcam_m.qcam002,g_qcam_m.qcam002_desc,g_qcam_m.qcam003, 
       g_qcam_m.qcam003_desc,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam005_desc,g_qcam_m.qcam006, 
       g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam008_desc,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus, 
       g_qcam_m.qcamownid,g_qcam_m.qcamownid_desc,g_qcam_m.qcamowndp,g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid, 
       g_qcam_m.qcammodid_desc,g_qcam_m.qcammoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_qcam_m.qcamownid      
   LET g_data_dept  = g_qcam_m.qcamowndp
   
   #功能已完成,通報訊息中心
   CALL aqci010_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.modify" >}
#+ 資料修改
PRIVATE FUNCTION aqci010_modify()
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
   LET g_qcam_m_t.* = g_qcam_m.*
   LET g_qcam_m_o.* = g_qcam_m.*
   
   IF g_qcam_m.qcam001 IS NULL
   OR g_qcam_m.qcam002 IS NULL
   OR g_qcam_m.qcam003 IS NULL
   OR g_qcam_m.qcam004 IS NULL
   OR g_qcam_m.qcam005 IS NULL
   OR g_qcam_m.qcam006 IS NULL
   OR g_qcam_m.qcam008 IS NULL
   OR g_qcam_m.qcam009 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_qcam001_t = g_qcam_m.qcam001
   LET g_qcam002_t = g_qcam_m.qcam002
   LET g_qcam003_t = g_qcam_m.qcam003
   LET g_qcam004_t = g_qcam_m.qcam004
   LET g_qcam005_t = g_qcam_m.qcam005
   LET g_qcam006_t = g_qcam_m.qcam006
   LET g_qcam008_t = g_qcam_m.qcam008
   LET g_qcam009_t = g_qcam_m.qcam009
 
   CALL s_transaction_begin()
   
   OPEN aqci010_cl USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aqci010_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aqci010_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
       g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001,g_qcam_m.qcam002, 
       g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008, 
       g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt,g_qcam_m.qcam001_desc, 
       g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc,g_qcam_m.qcamownid_desc, 
       g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcammodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aqci010_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_qcam_m_mask_o.* =  g_qcam_m.*
   CALL aqci010_qcam_t_mask()
   LET g_qcam_m_mask_n.* =  g_qcam_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aqci010_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_qcam001_t = g_qcam_m.qcam001
      LET g_qcam002_t = g_qcam_m.qcam002
      LET g_qcam003_t = g_qcam_m.qcam003
      LET g_qcam004_t = g_qcam_m.qcam004
      LET g_qcam005_t = g_qcam_m.qcam005
      LET g_qcam006_t = g_qcam_m.qcam006
      LET g_qcam008_t = g_qcam_m.qcam008
      LET g_qcam009_t = g_qcam_m.qcam009
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_qcam_m.qcammodid = g_user 
LET g_qcam_m.qcammoddt = cl_get_current()
LET g_qcam_m.qcammodid_desc = cl_get_username(g_qcam_m.qcammodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aqci010_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE qcam_t SET (qcammodid,qcammoddt) = (g_qcam_m.qcammodid,g_qcam_m.qcammoddt)
          WHERE qcament = g_enterprise AND qcam001 = g_qcam001_t
            AND qcam002 = g_qcam002_t
            AND qcam003 = g_qcam003_t
            AND qcam004 = g_qcam004_t
            AND qcam005 = g_qcam005_t
            AND qcam006 = g_qcam006_t
            AND qcam008 = g_qcam008_t
            AND qcam009 = g_qcam009_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_qcam_m.* = g_qcam_m_t.*
            CALL aqci010_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_qcam_m.qcam001 != g_qcam_m_t.qcam001
      OR g_qcam_m.qcam002 != g_qcam_m_t.qcam002
      OR g_qcam_m.qcam003 != g_qcam_m_t.qcam003
      OR g_qcam_m.qcam004 != g_qcam_m_t.qcam004
      OR g_qcam_m.qcam005 != g_qcam_m_t.qcam005
      OR g_qcam_m.qcam006 != g_qcam_m_t.qcam006
      OR g_qcam_m.qcam008 != g_qcam_m_t.qcam008
      OR g_qcam_m.qcam009 != g_qcam_m_t.qcam009
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE qcan_t SET qcan001 = g_qcam_m.qcam001
                                       ,qcan002 = g_qcam_m.qcam002
                                       ,qcan003 = g_qcam_m.qcam003
                                       ,qcan004 = g_qcam_m.qcam004
                                       ,qcan005 = g_qcam_m.qcam005
                                       ,qcan006 = g_qcam_m.qcam006
                                       ,qcan007 = g_qcam_m.qcam008
                                       ,qcan008 = g_qcam_m.qcam009
 
          WHERE qcanent = g_enterprise AND qcan001 = g_qcam_m_t.qcam001
            AND qcan002 = g_qcam_m_t.qcam002
            AND qcan003 = g_qcam_m_t.qcam003
            AND qcan004 = g_qcam_m_t.qcam004
            AND qcan005 = g_qcam_m_t.qcam005
            AND qcan006 = g_qcam_m_t.qcam006
            AND qcan007 = g_qcam_m_t.qcam008
            AND qcan008 = g_qcam_m_t.qcam009
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "qcan_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "qcan_t:",SQLERRMESSAGE 
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
   CALL aqci010_set_act_visible()   
   CALL aqci010_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " qcament = " ||g_enterprise|| " AND",
                      " qcam001 = '", g_qcam_m.qcam001, "' "
                      ," AND qcam002 = '", g_qcam_m.qcam002, "' "
                      ," AND qcam003 = '", g_qcam_m.qcam003, "' "
                      ," AND qcam004 = '", g_qcam_m.qcam004, "' "
                      ," AND qcam005 = '", g_qcam_m.qcam005, "' "
                      ," AND qcam006 = '", g_qcam_m.qcam006, "' "
                      ," AND qcam008 = '", g_qcam_m.qcam008, "' "
                      ," AND qcam009 = '", g_qcam_m.qcam009, "' "
 
   #填到對應位置
   CALL aqci010_browser_fill("")
 
   CLOSE aqci010_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aqci010_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aqci010.input" >}
#+ 資料輸入
PRIVATE FUNCTION aqci010_input(p_cmd)
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
   DEFINE l_sql            STRING
   DEFINE l_qcam010        LIKE qcam_t.qcam010
   DEFINE l_success        LIKE type_t.num5
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
   DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc,g_qcam_m.qcam002,g_qcam_m.qcam002_desc,g_qcam_m.qcam003, 
       g_qcam_m.qcam003_desc,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam005_desc,g_qcam_m.qcam006, 
       g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam008_desc,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus, 
       g_qcam_m.qcamownid,g_qcam_m.qcamownid_desc,g_qcam_m.qcamowndp,g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid, 
       g_qcam_m.qcammodid_desc,g_qcam_m.qcammoddt
   
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
   LET g_forupd_sql = "SELECT qcan009,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017, 
       qcan018 FROM qcan_t WHERE qcanent=? AND qcan001=? AND qcan002=? AND qcan003=? AND qcan004=? AND  
       qcan005=? AND qcan006=? AND qcan007=? AND qcan008=? AND qcan009=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql2 = "SELECT qcan009,qcan010,'',qcan011,qcan013,qcan019,qcan020,qcan021,qcan022,qcan023,qcan024,qcan025,qcan026 FROM qcan_t WHERE qcanent=? AND qcan001=? AND qcan002=? AND qcan003=? AND qcan004=? AND qcan005=? AND qcan006=? AND qcan007=? AND qcan008=? AND qcan009=? FOR UPDATE"
   LET g_forupd_sql2 = cl_sql_forupd(g_forupd_sql2)
   DECLARE aqci010_bcl2 CURSOR FROM g_forupd_sql2
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aqci010_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aqci010_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aqci010_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005, 
       g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_error_show = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aqci010.input.head" >}
      #單頭段
      INPUT BY NAME g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005, 
          g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aqci010_cl USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aqci010_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aqci010_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aqci010_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aqci010_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam001
            
            #add-point:AFTER FIELD qcam001 name="input.a.qcam001"
            #此段落由子樣板a05產生
            LET g_qcam_m.qcam001_desc = ''
            DISPLAY BY NAME g_qcam_m.qcam001_desc
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcam_m.qcam001,"SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT aqci010_qcam001_chk(g_qcam_m.qcam001) THEN
               LET g_qcam_m.qcam001 = g_qcam001_t
               NEXT FIELD CURRENT
            END IF
            
        
            CALL aqci010_qcam001_desc(g_qcam_m.qcam001)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam001
            #add-point:BEFORE FIELD qcam001 name="input.b.qcam001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam001
            #add-point:ON CHANGE qcam001 name="input.g.qcam001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam002
            
            #add-point:AFTER FIELD qcam002 name="input.a.qcam002"
            #此段落由子樣板a05產生
            LET g_qcam_m.qcam002_desc = ''
            DISPLAY BY NAME g_qcam_m.qcam002_desc
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT aqci010_qcam002_chk(g_qcam_m.qcam002) THEN
               LET g_qcam_m.qcam002 = g_qcam002_t   
               NEXT FIELD CURRENT               
            END IF
 
            IF aqci010_qcam002_qcam003_default(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
               LET g_qcam_m.qcam002 = 'ALL'          
            END IF

            IF NOT aqci010_qcam002_qcam003_chk(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00015'
               LET g_errparam.extend = g_qcam_m.qcam002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcam_m.qcam002 = g_qcam002_t
               NEXT FIELD CURRENT
            END IF

            CALL aqci010_qcam002_desc(g_qcam_m.qcam002)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam002
            #add-point:BEFORE FIELD qcam002 name="input.b.qcam002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam002
            #add-point:ON CHANGE qcam002 name="input.g.qcam002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam003
            
            #add-point:AFTER FIELD qcam003 name="input.a.qcam003"
            #此段落由子樣板a05產生
            LET g_qcam_m.qcam003_desc = ''
            DISPLAY BY NAME g_qcam_m.qcam003_desc
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT aqci010_qcam003_chk(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
               LET g_qcam_m.qcam003 = g_qcam003_t
               NEXT FIELD CURRENT
            END IF

            IF aqci010_qcam002_qcam003_default(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
               LET g_qcam_m.qcam003 = 'ALL'          
            END IF

            IF NOT aqci010_qcam002_qcam003_chk(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00015'
               LET g_errparam.extend = g_qcam_m.qcam003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcam_m.qcam003 = g_qcam003_t
               NEXT FIELD CURRENT
            END IF

            IF aqci010_qcam004_entry(g_qcam_m.qcam003) THEN
               LET g_qcam_m.qcam004 = 'ALL'
               DISPLAY BY NAME g_qcam_m.qcam004
            END IF

            CALL aqci010_qcam003_desc(g_qcam_m.qcam003)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam003
            #add-point:BEFORE FIELD qcam003 name="input.b.qcam003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam003
            #add-point:ON CHANGE qcam003 name="input.g.qcam003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam004
            #add-point:BEFORE FIELD qcam004 name="input.b.qcam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam004
            
            #add-point:AFTER FIELD qcam004 name="input.a.qcam004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam004
            #add-point:ON CHANGE qcam004 name="input.g.qcam004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam005
            
            #add-point:AFTER FIELD qcam005 name="input.a.qcam005"
            #此段落由子樣板a05產生
            LET g_qcam_m.qcam005_desc = ''
            DISPLAY BY NAME g_qcam_m.qcam005_desc
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
       
            IF NOT aqci010_qcam005_chk(g_qcam_m.qcam005) THEN
               LET g_qcam_m.qcam005 = g_qcam005_t
               NEXT FIELD CURRENT
            END IF
            
            IF cl_null(g_qcam_m.qcam005) THEN
               LET g_qcam_m.qcam005 = 'ALL'
               DISPLAY BY NAME g_qcam_m.qcam005
            END IF

            CALL aqci010_qcam005_desc(g_qcam_m.qcam005)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam005
            #add-point:BEFORE FIELD qcam005 name="input.b.qcam005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam005
            #add-point:ON CHANGE qcam005 name="input.g.qcam005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam006
            #add-point:BEFORE FIELD qcam006 name="input.b.qcam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam006
            
            #add-point:AFTER FIELD qcam006 name="input.a.qcam006"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF cl_null(g_qcam_m.qcam006) THEN LET g_qcam_m.qcam006 = 0 END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam006
            #add-point:ON CHANGE qcam006 name="input.g.qcam006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam007
            #add-point:BEFORE FIELD qcam007 name="input.b.qcam007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam007
            
            #add-point:AFTER FIELD qcam007 name="input.a.qcam007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam007
            #add-point:ON CHANGE qcam007 name="input.g.qcam007"
            IF g_qcam_m.qcam007 = '0' THEN LET g_qcam_m.qcam008 = 'ALL' END IF
            DISPLAY BY NAME g_qcam_m.qcam008
            IF NOT aqci010_qcam008_chk(g_qcam_m.qcam007,g_qcam_m.qcam008) THEN
               NEXT FIELD qcam008
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam008
            
            #add-point:AFTER FIELD qcam008 name="input.a.qcam008"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT aqci010_qcam008_chk(g_qcam_m.qcam007,g_qcam_m.qcam008) THEN
               LET g_qcam_m.qcam008 = g_qcam008_t
               NEXT FIELD qcam008
            END IF

            CALL aqci010_qcam008_desc(g_qcam_m.qcam008)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam008
            #add-point:BEFORE FIELD qcam008 name="input.b.qcam008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam008
            #add-point:ON CHANGE qcam008 name="input.g.qcam008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam009
            #add-point:BEFORE FIELD qcam009 name="input.b.qcam009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam009
            
            #add-point:AFTER FIELD qcam009 name="input.a.qcam009"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t  OR g_qcam_m.qcam002 != g_qcam002_t  OR g_qcam_m.qcam003 != g_qcam003_t  OR g_qcam_m.qcam004 != g_qcam004_t  OR g_qcam_m.qcam005 != g_qcam005_t  OR g_qcam_m.qcam006 != g_qcam006_t  OR g_qcam_m.qcam008 != g_qcam008_t  OR g_qcam_m.qcam009 != g_qcam009_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcam_t WHERE "||"qcament = '" ||g_enterprise|| "' AND "||"qcam001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcam002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcam003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcam004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcam005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcam006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcam008 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcam009 = '"||g_qcam_m.qcam009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam009
            #add-point:ON CHANGE qcam009 name="input.g.qcam009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcam010
            #add-point:BEFORE FIELD qcam010 name="input.b.qcam010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcam010
            
            #add-point:AFTER FIELD qcam010 name="input.a.qcam010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcam010
            #add-point:ON CHANGE qcam010 name="input.g.qcam010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamstus
            #add-point:BEFORE FIELD qcamstus name="input.b.qcamstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamstus
            
            #add-point:AFTER FIELD qcamstus name="input.a.qcamstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamstus
            #add-point:ON CHANGE qcamstus name="input.g.qcamstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.qcam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam001
            #add-point:ON ACTION controlp INFIELD qcam001 name="input.c.qcam001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcam_m.qcam001             #給予default值

            #給予arg

            CALL q_ooal002_4()                                #呼叫開窗

            LET g_qcam_m.qcam001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcam_m.qcam001 TO qcam001              #顯示到畫面上
            CALL aqci010_qcam001_desc(g_qcam_m.qcam001)
            NEXT FIELD qcam001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.qcam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam002
            #add-point:ON ACTION controlp INFIELD qcam002 name="input.c.qcam002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcam_m.qcam002             #給予default值

            #給予arg

#150527 by whitney modify start
#            CALL q_imcg111()                                #呼叫開窗
            LET g_qryparam.arg1 = "205" 
            CALL q_oocq002()                       #呼叫開窗
#150527 by whitney modify end

            LET g_qcam_m.qcam002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcam_m.qcam002 TO qcam002              #顯示到畫面上
            CALL aqci010_qcam002_desc(g_qcam_m.qcam002)
            NEXT FIELD qcam002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.qcam003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam003
            #add-point:ON ACTION controlp INFIELD qcam003 name="input.c.qcam003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcam_m.qcam003             #給予default值

            #給予arg
            IF NOT cl_null(g_qcam_m.qcam002) AND g_qcam_m.qcam002 != 'ALL' THEN
               LET g_qryparam.where = " imae111 = '",g_qcam_m.qcam002,"'"
            END IF
            CALL q_imaa001_8()                                #呼叫開窗

            LET g_qcam_m.qcam003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcam_m.qcam003 TO qcam003              #顯示到畫面上
            CALL aqci010_qcam003_desc(g_qcam_m.qcam003)
            NEXT FIELD qcam003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.qcam004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam004
            #add-point:ON ACTION controlp INFIELD qcam004 name="input.c.qcam004"
            IF NOT cl_null(g_qcam_m.qcam003) THEN
               CALL aimm200_02(g_qcam_m.qcam003) RETURNING g_qcam_m.qcam004
               DISPLAY g_qcam_m.qcam004 TO qcam004
               NEXT FIELD qcam004
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.qcam005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam005
            #add-point:ON ACTION controlp INFIELD qcam005 name="input.c.qcam005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcam_m.qcam005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = 221 #

            CALL q_oocq002()                                #呼叫開窗

            LET g_qcam_m.qcam005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcam_m.qcam005 TO qcam005              #顯示到畫面上
            CALL aqci010_qcam005_desc(g_qcam_m.qcam005)
            NEXT FIELD qcam005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.qcam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam006
            #add-point:ON ACTION controlp INFIELD qcam006 name="input.c.qcam006"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam007
            #add-point:ON ACTION controlp INFIELD qcam007 name="input.c.qcam007"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam008
            #add-point:ON ACTION controlp INFIELD qcam008 name="input.c.qcam008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcam_m.qcam008             #給予default值

            #給予arg
            CASE 
               WHEN g_qcam_m.qcam007 = '0'
                  LET g_qryparam.arg1 = "('1','2','3')"
               WHEN g_qcam_m.qcam007 = '1'
                  LET g_qryparam.arg1 = "('2','3')"
               WHEN g_qcam_m.qcam007 = '2'
                  LET g_qryparam.arg1 = "('1','3')"
            END CASE
            

            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_qcam_m.qcam008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcam_m.qcam008 TO qcam008              #顯示到畫面上
            CALL aqci010_qcam008_desc(g_qcam_m.qcam008)
            NEXT FIELD qcam008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.qcam009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam009
            #add-point:ON ACTION controlp INFIELD qcam009 name="input.c.qcam009"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcam010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcam010
            #add-point:ON ACTION controlp INFIELD qcam010 name="input.c.qcam010"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcamstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamstus
            #add-point:ON ACTION controlp INFIELD qcamstus name="input.c.qcamstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005, 
                g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  IF NOT aqci010_imae111_chk(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
                     NEXT FIELD qcam003
                  END IF
                  
                  CALL s_aooi350_get_idno("qcam010","qcam_t","") RETURNING g_success,g_qcam_m.qcam010
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aqc-00033'
                     LET g_errparam.extend = g_qcam_m.qcam010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF
               #end add-point
               
               INSERT INTO qcam_t (qcament,qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam007,qcam008, 
                   qcam009,qcam010,qcamstus,qcamownid,qcamowndp,qcamcrtid,qcamcrtdp,qcamcrtdt,qcammodid, 
                   qcammoddt)
               VALUES (g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
                   g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam009, 
                   g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
                   g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_qcam_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
#                  CALL s_aooi350_get_idno('qcam010','qcam_t','') RETURNING l_success,l_qcam010
#                  UPDATE qcam_t SET qcam010 = l_qcam010
#                  WHERE qcament = g_enterprise 
#                  AND qcam001 = g_qcam_m.qcam001
#                  AND qcam002 = g_qcam_m.qcam002
#
#                  AND qcam003 = g_qcam_m.qcam003
#
#                  AND qcam004 = g_qcam_m.qcam004
#
#                  AND qcam005 = g_qcam_m.qcam005
#
#                  AND qcam006 = g_qcam_m.qcam006
#
#                  AND qcam008 = g_qcam_m.qcam008
#
#                  AND qcam009 = g_qcam_m.qcam009
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aqci010_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aqci010_b_fill()
                  CALL aqci010_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF NOT aqci010_imae111_chk(g_qcam_m.qcam002,g_qcam_m.qcam003) THEN
                  NEXT FIELD qcam003
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL aqci010_qcam_t_mask_restore('restore_mask_o')
               
               UPDATE qcam_t SET (qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam007,qcam008,qcam009, 
                   qcam010,qcamstus,qcamownid,qcamowndp,qcamcrtid,qcamcrtdp,qcamcrtdt,qcammodid,qcammoddt) = (g_qcam_m.qcam001, 
                   g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006, 
                   g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus, 
                   g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt, 
                   g_qcam_m.qcammodid,g_qcam_m.qcammoddt)
                WHERE qcament = g_enterprise AND qcam001 = g_qcam001_t
                  AND qcam002 = g_qcam002_t
                  AND qcam003 = g_qcam003_t
                  AND qcam004 = g_qcam004_t
                  AND qcam005 = g_qcam005_t
                  AND qcam006 = g_qcam006_t
                  AND qcam008 = g_qcam008_t
                  AND qcam009 = g_qcam009_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "qcam_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aqci010_qcam_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_qcam_m_t)
               LET g_log2 = util.JSON.stringify(g_qcam_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_qcam001_t = g_qcam_m.qcam001
            LET g_qcam002_t = g_qcam_m.qcam002
            LET g_qcam003_t = g_qcam_m.qcam003
            LET g_qcam004_t = g_qcam_m.qcam004
            LET g_qcam005_t = g_qcam_m.qcam005
            LET g_qcam006_t = g_qcam_m.qcam006
            LET g_qcam008_t = g_qcam_m.qcam008
            LET g_qcam009_t = g_qcam_m.qcam009
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aqci010.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_qcan_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_qcan_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aqci010_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_qcan_d.getLength()
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
            OPEN aqci010_cl USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aqci010_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aqci010_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_qcan_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_qcan_d[l_ac].qcan009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_qcan_d_t.* = g_qcan_d[l_ac].*  #BACKUP
               LET g_qcan_d_o.* = g_qcan_d[l_ac].*  #BACKUP
               CALL aqci010_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aqci010_set_no_entry_b(l_cmd)
               IF NOT aqci010_lock_b("qcan_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aqci010_bcl INTO g_qcan_d[l_ac].qcan009,g_qcan_d[l_ac].qcan010,g_qcan_d[l_ac].qcan011, 
                      g_qcan_d[l_ac].qcan012,g_qcan_d[l_ac].qcan013,g_qcan_d[l_ac].qcan014,g_qcan_d[l_ac].qcan015, 
                      g_qcan_d[l_ac].qcan016,g_qcan_d[l_ac].qcan017,g_qcan_d[l_ac].qcan018
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_qcan_d_t.qcan009,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_qcan_d_mask_o[l_ac].* =  g_qcan_d[l_ac].*
                  CALL aqci010_qcan_t_mask()
                  LET g_qcan_d_mask_n[l_ac].* =  g_qcan_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aqci010_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aqci010_qcan016_required(g_qcan_d[l_ac].qcan015)
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
            INITIALIZE g_qcan_d[l_ac].* TO NULL 
            INITIALIZE g_qcan_d_t.* TO NULL 
            INITIALIZE g_qcan_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_qcan_d_t.* = g_qcan_d[l_ac].*     #新輸入資料
            LET g_qcan_d_o.* = g_qcan_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aqci010_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aqci010_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_qcan_d[li_reproduce_target].* = g_qcan_d[li_reproduce].*
 
               LET g_qcan_d[li_reproduce_target].qcan009 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(qcan009)+1 INTO g_qcan_d[l_ac].qcan009 FROM qcan_t WHERE qcan001 = g_qcam_m.qcam001
               AND qcan002 = g_qcam_m.qcam002 AND qcan003 = g_qcam_m.qcam003 AND qcan004 = g_qcam_m.qcam004
               AND qcan005 = g_qcam_m.qcam005 AND qcan006 = g_qcam_m.qcam006 AND qcan007 = g_qcam_m.qcam008
               AND qcan008 = g_qcam_m.qcam009 AND qcanent = g_enterprise
            IF cl_null(g_qcan_d[l_ac].qcan009) THEN LET g_qcan_d[l_ac].qcan009 = 1 END IF
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
            SELECT COUNT(1) INTO l_count FROM qcan_t 
             WHERE qcanent = g_enterprise AND qcan001 = g_qcam_m.qcam001
               AND qcan002 = g_qcam_m.qcam002
               AND qcan003 = g_qcam_m.qcam003
               AND qcan004 = g_qcam_m.qcam004
               AND qcan005 = g_qcam_m.qcam005
               AND qcan006 = g_qcam_m.qcam006
               AND qcan007 = g_qcam_m.qcam008
               AND qcan008 = g_qcam_m.qcam009
 
               AND qcan009 = g_qcan_d[l_ac].qcan009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_qcam_m.qcam001
               LET gs_keys[2] = g_qcam_m.qcam002
               LET gs_keys[3] = g_qcam_m.qcam003
               LET gs_keys[4] = g_qcam_m.qcam004
               LET gs_keys[5] = g_qcam_m.qcam005
               LET gs_keys[6] = g_qcam_m.qcam006
               LET gs_keys[7] = g_qcam_m.qcam008
               LET gs_keys[8] = g_qcam_m.qcam009
               LET gs_keys[9] = g_qcan_d[g_detail_idx].qcan009
               CALL aqci010_insert_b('qcan_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_qcan_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "qcan_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aqci010_b_fill()
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
               LET gs_keys[01] = g_qcam_m.qcam001
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam002
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam003
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam004
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam005
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam006
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam008
               LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam009
 
               LET gs_keys[gs_keys.getLength()+1] = g_qcan_d_t.qcan009
 
            
               #刪除同層單身
               IF NOT aqci010_delete_b('qcan_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aqci010_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aqci010_key_delete_b(gs_keys,'qcan_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aqci010_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aqci010_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_qcan_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_qcan_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_qcan_d[l_ac].qcan009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD qcan009
            END IF 
 
 
 
            #add-point:AFTER FIELD qcan009 name="input.a.page1.qcan009"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_qcam_m.qcam001) AND NOT cl_null(g_qcam_m.qcam002) AND NOT cl_null(g_qcam_m.qcam003) AND NOT cl_null(g_qcam_m.qcam004) AND NOT cl_null(g_qcam_m.qcam005) AND NOT cl_null(g_qcam_m.qcam006) AND NOT cl_null(g_qcam_m.qcam008) AND NOT cl_null(g_qcam_m.qcam009) AND NOT cl_null(g_qcan_d[g_detail_idx].qcan009) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_qcam_m.qcam001 != g_qcam001_t OR g_qcam_m.qcam002 != g_qcam002_t OR g_qcam_m.qcam003 != g_qcam003_t OR g_qcam_m.qcam004 != g_qcam004_t OR g_qcam_m.qcam005 != g_qcam005_t OR g_qcam_m.qcam006 != g_qcam006_t OR g_qcam_m.qcam008 != g_qcam008_t OR g_qcam_m.qcam009 != g_qcam009_t OR g_qcan_d[g_detail_idx].qcan009 != g_qcan_d_t.qcan009))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcan_t WHERE "||"qcanent = '" ||g_enterprise|| "' AND "||"qcan001 = '"||g_qcam_m.qcam001 ||"' AND "|| "qcan002 = '"||g_qcam_m.qcam002 ||"' AND "|| "qcan003 = '"||g_qcam_m.qcam003 ||"' AND "|| "qcan004 = '"||g_qcam_m.qcam004 ||"' AND "|| "qcan005 = '"||g_qcam_m.qcam005 ||"' AND "|| "qcan006 = '"||g_qcam_m.qcam006 ||"' AND "|| "qcan007 = '"||g_qcam_m.qcam008 ||"' AND "|| "qcan008 = '"||g_qcam_m.qcam009 ||"' AND "|| "qcan009 = '"||g_qcan_d[g_detail_idx].qcan009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan009
            #add-point:BEFORE FIELD qcan009 name="input.b.page1.qcan009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan009
            #add-point:ON CHANGE qcan009 name="input.g.page1.qcan009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan010
            
            #add-point:AFTER FIELD qcan010 name="input.a.page1.qcan010"
            LET g_qcan_d[l_ac].qcan010_desc = ''
            DISPLAY BY NAME g_qcan_d[l_ac].qcan010_desc
            
            IF NOT cl_null(g_qcan_d[l_ac].qcan010) THEN
               LET l_sql = "SELECT COUNT(*) FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '1051' AND oocq002 = ?"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan010,l_sql,'aqc-00019',1) THEN    #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan010,l_sql,'sub-01303','aqci008') THEN     #160318-00005#42  add
                  LET g_qcan_d[l_ac].qcan010 = g_qcan_d_t.qcan010
                  NEXT FIELD CURRENT
               END IF
               LET l_sql = l_sql," AND oocqstus = 'Y'"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan010,l_sql,'aqc-00020',1) THEN     #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan010,l_sql,'sub-01302','aqci008') THEN     #160318-00005#42  add
                  LET g_qcan_d[l_ac].qcan010 = g_qcan_d_t.qcan010
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcan_d[l_ac].qcan010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcan_d[l_ac].qcan010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcan_d[l_ac].qcan010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan010
            #add-point:BEFORE FIELD qcan010 name="input.b.page1.qcan010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan010
            #add-point:ON CHANGE qcan010 name="input.g.page1.qcan010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan011
            #add-point:BEFORE FIELD qcan011 name="input.b.page1.qcan011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan011
            
            #add-point:AFTER FIELD qcan011 name="input.a.page1.qcan011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan011
            #add-point:ON CHANGE qcan011 name="input.g.page1.qcan011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan012
            #add-point:BEFORE FIELD qcan012 name="input.b.page1.qcan012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan012
            
            #add-point:AFTER FIELD qcan012 name="input.a.page1.qcan012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan012
            #add-point:ON CHANGE qcan012 name="input.g.page1.qcan012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan013
            #add-point:BEFORE FIELD qcan013 name="input.b.page1.qcan013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan013
            
            #add-point:AFTER FIELD qcan013 name="input.a.page1.qcan013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan013
            #add-point:ON CHANGE qcan013 name="input.g.page1.qcan013"
            IF g_qcan_d[l_ac].qcan013 MATCHES '[1256]' THEN
               IF NOT aqci010_qcan014_chk() THEN
                  NEXT FIELD qcan014
               END IF
            END IF
            CALL aqci010_set_entry_b(l_cmd)
            CALL aqci010_set_no_entry_b(l_cmd)
            IF g_qcan_d[l_ac].qcan013 = '4' THEN
               LET g_qcan_d[l_ac].qcan015 = '3' 
               IF cl_null(g_qcan2_d[l_ac].qcan019) THEN
                  NEXT FIELD qcan019
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan014
            #add-point:BEFORE FIELD qcan014 name="input.b.page1.qcan014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan014
            
            #add-point:AFTER FIELD qcan014 name="input.a.page1.qcan014"
            IF NOT aqci010_qcan014_chk() THEN
               LET g_qcan_d[l_ac].qcan014 = g_qcan_d_t.qcan014
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan014
            #add-point:ON CHANGE qcan014 name="input.g.page1.qcan014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan015
            #add-point:BEFORE FIELD qcan015 name="input.b.page1.qcan015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan015
            
            #add-point:AFTER FIELD qcan015 name="input.a.page1.qcan015"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan015
            #add-point:ON CHANGE qcan015 name="input.g.page1.qcan015"
            CALL aqci010_qcan016_required(g_qcan_d[l_ac].qcan015)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan016
            
            #add-point:AFTER FIELD qcan016 name="input.a.page1.qcan016"
            LET g_qcan_d[l_ac].qcan016_desc = ''
            DISPLAY BY NAME g_qcan_d[l_ac].qcan016_desc
            IF NOT cl_null(g_qcan_d[l_ac].qcan016) THEN
               LET l_sql = "SELECT COUNT(*) FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '1052' AND oocq002 = ?"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan016,l_sql,'aqc-00025',1) THEN     #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan016,l_sql,'sub-01303','aqci009') THEN
                  LET g_qcan_d[l_ac].qcan016 = g_qcan_d_t.qcan016
                  NEXT FIELD CURRENT
               END IF
               LET l_sql = l_sql," AND oocqstus = 'Y'"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan016,l_sql,'aqc-00026',1) THEN     #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan016,l_sql,'sub-01302','aqci009') THEN     #160318-00005#42  add
                  LET g_qcan_d[l_ac].qcan016 = g_qcan_d_t.qcan016
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcan_d[l_ac].qcan016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcan_d[l_ac].qcan016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcan_d[l_ac].qcan016_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan016
            #add-point:BEFORE FIELD qcan016 name="input.b.page1.qcan016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan016
            #add-point:ON CHANGE qcan016 name="input.g.page1.qcan016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan017
            #add-point:BEFORE FIELD qcan017 name="input.b.page1.qcan017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan017
            
            #add-point:AFTER FIELD qcan017 name="input.a.page1.qcan017"
            #160519-00045#1--s
            IF (NOT cl_null(g_qcan_d[l_ac].qcan017)) AND (NOT cl_null(g_qcan_d[l_ac].qcan018)) THEN 
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_qcan_d[l_ac].qcan018

               LET g_chkparam.where = " mrba000 = '",g_qcan_d[l_ac].qcan017,"' "
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mrba001_5") THEN
                  LET g_qcan_d[l_ac].qcan018 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #160519-00045#1--e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan017
            #add-point:ON CHANGE qcan017 name="input.g.page1.qcan017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan018
            
            #add-point:AFTER FIELD qcan018 name="input.a.page1.qcan018"
            #160519-00045#1--s
            IF NOT cl_null(g_qcan_d[l_ac].qcan018) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_qcan_d[l_ac].qcan018
               
               IF NOT cl_null(g_qcan_d[l_ac].qcan017) THEN 
                  LET g_chkparam.where = " mrba000 = '",g_qcan_d[l_ac].qcan017,"' "
               END IF
               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mrba001_5") THEN
                  LET g_qcan_d[l_ac].qcan018 = g_qcan_d_t.qcan018
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #160519-00045#1--e

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan018
            #add-point:BEFORE FIELD qcan018 name="input.b.page1.qcan018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcan018
            #add-point:ON CHANGE qcan018 name="input.g.page1.qcan018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.qcan009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan009
            #add-point:ON ACTION controlp INFIELD qcan009 name="input.c.page1.qcan009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan010
            #add-point:ON ACTION controlp INFIELD qcan010 name="input.c.page1.qcan010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcan_d[l_ac].qcan010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1051" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_qcan_d[l_ac].qcan010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcan_d[l_ac].qcan010 TO qcan010              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcan_d[l_ac].qcan010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcan_d[l_ac].qcan010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcan_d[l_ac].qcan010_desc
            NEXT FIELD qcan010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan011
            #add-point:ON ACTION controlp INFIELD qcan011 name="input.c.page1.qcan011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan012
            #add-point:ON ACTION controlp INFIELD qcan012 name="input.c.page1.qcan012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan013
            #add-point:ON ACTION controlp INFIELD qcan013 name="input.c.page1.qcan013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan014
            #add-point:ON ACTION controlp INFIELD qcan014 name="input.c.page1.qcan014"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcan_d[l_ac].qcan014             #給予default值
            CASE WHEN g_qcan_d[l_ac].qcan013 = '1' 
                    CALL q_qcac002()
                 WHEN g_qcan_d[l_ac].qcan013 = '2'
                    CALL q_qcag003()
                 WHEN g_qcan_d[l_ac].qcan013 = '6'
                    LET g_qryparam.where = " qcah001 = '",g_qcam_m.qcam001,"'"
                    CALL q_qcah002()
            END CASE
      

            LET g_qcan_d[l_ac].qcan014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcan_d[l_ac].qcan014 TO qcan014              #顯示到畫面上

            NEXT FIELD qcan014                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan015
            #add-point:ON ACTION controlp INFIELD qcan015 name="input.c.page1.qcan015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan016
            #add-point:ON ACTION controlp INFIELD qcan016 name="input.c.page1.qcan016"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcan_d[l_ac].qcan016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1052" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_qcan_d[l_ac].qcan016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcan_d[l_ac].qcan016 TO qcan016              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcan_d[l_ac].qcan016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcan_d[l_ac].qcan016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcan_d[l_ac].qcan016_desc
            NEXT FIELD qcan016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan017
            #add-point:ON ACTION controlp INFIELD qcan017 name="input.c.page1.qcan017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcan018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcan018
            #add-point:ON ACTION controlp INFIELD qcan018 name="input.c.page1.qcan018"
            #160519-00045#1--s
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcan_d[l_ac].qcan018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
         
            LET g_qryparam.where = " mrba100 = '1' "
            
            IF NOT cl_null(g_qcan_d[l_ac].qcan017) THEN 
               LET g_qryparam.where = g_qryparam.where , " AND mrba000 = '",g_qcan_d[l_ac].qcan017,"' "
            END IF
 
            CALL q_mrba001()                                #呼叫開窗
 
            LET g_qcan_d[l_ac].qcan018 = g_qryparam.return1              

            DISPLAY g_qcan_d[l_ac].qcan018 TO qcan018              #

            NEXT FIELD qcan018                          #返回原欄位
            #160519-00045#1--e


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_qcan_d[l_ac].* = g_qcan_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aqci010_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_qcan_d[l_ac].qcan009 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_qcan_d[l_ac].* = g_qcan_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aqci010_qcan_t_mask_restore('restore_mask_o')
      
               UPDATE qcan_t SET (qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,qcan009, 
                   qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017,qcan018) = (g_qcam_m.qcam001, 
                   g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006, 
                   g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcan_d[l_ac].qcan009,g_qcan_d[l_ac].qcan010,g_qcan_d[l_ac].qcan011, 
                   g_qcan_d[l_ac].qcan012,g_qcan_d[l_ac].qcan013,g_qcan_d[l_ac].qcan014,g_qcan_d[l_ac].qcan015, 
                   g_qcan_d[l_ac].qcan016,g_qcan_d[l_ac].qcan017,g_qcan_d[l_ac].qcan018)
                WHERE qcanent = g_enterprise AND qcan001 = g_qcam_m.qcam001 
                  AND qcan002 = g_qcam_m.qcam002 
                  AND qcan003 = g_qcam_m.qcam003 
                  AND qcan004 = g_qcam_m.qcam004 
                  AND qcan005 = g_qcam_m.qcam005 
                  AND qcan006 = g_qcam_m.qcam006 
                  AND qcan007 = g_qcam_m.qcam008 
                  AND qcan008 = g_qcam_m.qcam009 
 
                  AND qcan009 = g_qcan_d_t.qcan009 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_qcan_d[l_ac].* = g_qcan_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "qcan_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_qcan_d[l_ac].* = g_qcan_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "qcan_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_qcam_m.qcam001
               LET gs_keys_bak[1] = g_qcam001_t
               LET gs_keys[2] = g_qcam_m.qcam002
               LET gs_keys_bak[2] = g_qcam002_t
               LET gs_keys[3] = g_qcam_m.qcam003
               LET gs_keys_bak[3] = g_qcam003_t
               LET gs_keys[4] = g_qcam_m.qcam004
               LET gs_keys_bak[4] = g_qcam004_t
               LET gs_keys[5] = g_qcam_m.qcam005
               LET gs_keys_bak[5] = g_qcam005_t
               LET gs_keys[6] = g_qcam_m.qcam006
               LET gs_keys_bak[6] = g_qcam006_t
               LET gs_keys[7] = g_qcam_m.qcam008
               LET gs_keys_bak[7] = g_qcam008_t
               LET gs_keys[8] = g_qcam_m.qcam009
               LET gs_keys_bak[8] = g_qcam009_t
               LET gs_keys[9] = g_qcan_d[g_detail_idx].qcan009
               LET gs_keys_bak[9] = g_qcan_d_t.qcan009
               CALL aqci010_update_b('qcan_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aqci010_qcan_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_qcan_d[g_detail_idx].qcan009 = g_qcan_d_t.qcan009 
 
                  ) THEN
                  LET gs_keys[01] = g_qcam_m.qcam001
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam002
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam003
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam004
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam005
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam006
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam008
                  LET gs_keys[gs_keys.getLength()+1] = g_qcam_m.qcam009
 
                  LET gs_keys[gs_keys.getLength()+1] = g_qcan_d_t.qcan009
 
                  CALL aqci010_key_update_b(gs_keys,'qcan_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_qcam_m),util.JSON.stringify(g_qcan_d_t)
               LET g_log2 = util.JSON.stringify(g_qcam_m),util.JSON.stringify(g_qcan_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aqci010_unlock_b("qcan_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL aqci010_b_fill2('0')
            DISPLAY ARRAY g_qcan2_d TO s_detail2.*
               BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_qcan_d[li_reproduce_target].* = g_qcan_d[li_reproduce].*
 
               LET g_qcan_d[li_reproduce_target].qcan009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_qcan_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_qcan_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aqci010.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_qcan2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
          BEFORE INPUT
           LET l_ac2 = l_ac
           CALL FGL_SET_ARR_CURR(l_ac2) 
          

            CALL aqci010_b_fill2('0')
            LET g_rec_b = g_qcan2_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx2 = l_ac2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aqci010_cl USING g_enterprise,g_qcam_m.qcam001
                                                                ,g_qcam_m.qcam002

                                                                ,g_qcam_m.qcam003

                                                                ,g_qcam_m.qcam004

                                                                ,g_qcam_m.qcam005

                                                                ,g_qcam_m.qcam006

                                                                ,g_qcam_m.qcam008

                                                                ,g_qcam_m.qcam009


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aqci010_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aqci010_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
                   
            
            LET g_rec_b = g_qcan2_d.getLength()
            
            IF g_rec_b >= l_ac2 
               AND NOT cl_null(g_qcan2_d[l_ac].qcan009_1) 

            THEN
               LET l_cmd='u'
               LET g_qcan2_d_t.* = g_qcan2_d[l_ac2].*  #BACKUP
               CALL aqci010_set_entry_b2(l_cmd)
               CALL aqci010_set_no_entry_b2(l_cmd)
               IF NOT aqci010_lock_b2("qcan_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aqci010_bcl2 INTO g_qcan2_d[l_ac2].qcan009_1,g_qcan2_d[l_ac2].qcan010_1,g_qcan2_d[l_ac2].qcan010_1_desc,g_qcan2_d[l_ac2].qcan011_1,g_qcan2_d[l_ac2].qcan013_1,
                              g_qcan2_d[l_ac2].qcan019,g_qcan2_d[l_ac2].qcan020,g_qcan2_d[l_ac2].qcan021,g_qcan2_d[l_ac2].qcan022,g_qcan2_d[l_ac2].qcan023,
                              g_qcan2_d[l_ac2].qcan024,g_qcan2_d[l_ac2].qcan025,g_qcan2_d[l_ac2].qcan026    
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_qcan2_d_t.qcan009_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aqci010_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            IF g_qcan2_d[l_ac2].qcan013_1 = '4' THEN
               CALL cl_set_comp_required("qcan019",TRUE)
            ELSE
               CALL cl_set_comp_required("qcan019",FALSE)
            END IF
         AFTER ROW
            #add-point:單身after_row
            IF g_qcan_d[l_ac].qcan013 = '4' THEN
               IF cl_null(g_qcan2_d[l_ac].qcan019) AND cl_null(g_qcan2_d[l_ac].qcan023) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "qcan_t" 
                  LET g_errparam.code   = "aqc-00106"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               IF cl_null(g_qcan2_d[l_ac].qcan020) AND cl_null(g_qcan2_d[l_ac].qcan022) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "qcan_t" 
                  LET g_errparam.code   = "aqc-00107"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #end add-point
            CALL aqci010_unlock_b2("qcan_t","'2'")
            CALL s_transaction_end('Y','0')
         AFTER FIELD qcan019
            IF NOT aqci010_qcan019_qcan023_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00027'
               LET g_errparam.extend = g_qcan2_d[l_ac2].qcan019
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcan2_d[l_ac2].qcan019 = g_qcan2_d_t.qcan019
               NEXT FIELD CURRENT
            END IF
         AFTER FIELD qcan020
            IF NOT aqci010_qcan020_qcan022_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00028'
               LET g_errparam.extend = g_qcan2_d[l_ac2].qcan020
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcan2_d[l_ac2].qcan020 = g_qcan2_d_t.qcan020
               NEXT FIELD CURRENT
            END IF
         
         AFTER FIELD qcan022
            IF NOT aqci010_qcan020_qcan022_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00028'
               LET g_errparam.extend = g_qcan2_d[l_ac2].qcan022
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcan2_d[l_ac2].qcan022 = g_qcan2_d_t.qcan022
               NEXT FIELD CURRENT
            END IF
         AFTER FIELD qcan023
            IF NOT aqci010_qcan019_qcan023_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00027'
               LET g_errparam.extend = g_qcan2_d[l_ac2].qcan023
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcan2_d[l_ac2].qcan023 = g_qcan2_d_t.qcan023
               NEXT FIELD CURRENT
            END IF
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_qcan2_d[l_ac2].* = g_qcan2_d_t.*
               CLOSE aqci010_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_qcan2_d[l_ac2].qcan009_1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcan2_d[l_ac2].* = g_qcan2_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE qcan_t SET (qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,qcan009,qcan019,qcan020,qcan021,qcan022,qcan023,qcan024,qcan025,qcan026) = 
                                 (g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcan2_d[l_ac2].qcan009_1,g_qcan2_d[l_ac2].qcan019,g_qcan2_d[l_ac2].qcan020,g_qcan2_d[l_ac2].qcan021,g_qcan2_d[l_ac2].qcan022,g_qcan2_d[l_ac2].qcan023,g_qcan2_d[l_ac2].qcan024,g_qcan2_d[l_ac2].qcan025,g_qcan2_d[l_ac2].qcan026)
                WHERE qcanent = g_enterprise AND qcan001 = g_qcam_m.qcam001 
                  AND qcan002 = g_qcam_m.qcam002 

                  AND qcan003 = g_qcam_m.qcam003 

                  AND qcan004 = g_qcam_m.qcam004 

                  AND qcan005 = g_qcam_m.qcam005 

                  AND qcan006 = g_qcam_m.qcam006 

                  AND qcan007 = g_qcam_m.qcam008 

                  AND qcan008 = g_qcam_m.qcam009 


                  AND qcan009 = g_qcan2_d_t.qcan009_1 #項次   

                  
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "qcan_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_qcan2_d[l_ac].* = g_qcan2_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_qcam_m.qcam001
               LET gs_keys_bak[1] = g_qcam001_t
               LET gs_keys[2] = g_qcam_m.qcam002
               LET gs_keys_bak[2] = g_qcam002_t
               LET gs_keys[3] = g_qcam_m.qcam003
               LET gs_keys_bak[3] = g_qcam003_t
               LET gs_keys[4] = g_qcam_m.qcam004
               LET gs_keys_bak[4] = g_qcam004_t
               LET gs_keys[5] = g_qcam_m.qcam005
               LET gs_keys_bak[5] = g_qcam005_t
               LET gs_keys[6] = g_qcam_m.qcam006
               LET gs_keys_bak[6] = g_qcam006_t
               LET gs_keys[7] = g_qcam_m.qcam008
               LET gs_keys_bak[7] = g_qcam008_t
               LET gs_keys[8] = g_qcam_m.qcam009
               LET gs_keys_bak[8] = g_qcam009_t
               LET gs_keys[9] = g_qcan2_d[g_detail_idx].qcan009_1
               LET gs_keys_bak[9] = g_qcan2_d_t.qcan009_1
               CALL aqci010_update_b2('qcan_t',gs_keys,gs_keys_bak,"'2'")
                  #資料多語言用-增/改
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF   
      
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #add by lixh 20150703 150702-00006#10
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field

            #end add-point  
            NEXT FIELD qcam002
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD qcan009
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
         #add by lixh 20150703 150702-00006#10
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD qcam001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD qcan009
 
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
 
{<section id="aqci010.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aqci010_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aqci010_b_fill() #單身填充
      CALL aqci010_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aqci010_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcam001
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='5' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcam001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcam001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcam002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcam002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcam002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcam003
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcam003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcam003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcam005
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcam005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcam005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcam008
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcam008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcam008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcamownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcamownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcamownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcamowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcamowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcamowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcamcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcamcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcamcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcamcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcamcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcamcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcam_m.qcammodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_qcam_m.qcammodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcam_m.qcammodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_qcam_m_mask_o.* =  g_qcam_m.*
   CALL aqci010_qcam_t_mask()
   LET g_qcam_m_mask_n.* =  g_qcam_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc,g_qcam_m.qcam002,g_qcam_m.qcam002_desc,g_qcam_m.qcam003, 
       g_qcam_m.qcam003_desc,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam005_desc,g_qcam_m.qcam006, 
       g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam008_desc,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus, 
       g_qcam_m.qcamownid,g_qcam_m.qcamownid_desc,g_qcam_m.qcamowndp,g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid, 
       g_qcam_m.qcammodid_desc,g_qcam_m.qcammoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_qcam_m.qcamstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_qcan_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcan_d[l_ac].qcan010
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcan_d[l_ac].qcan010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcan_d[l_ac].qcan010_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcan_d[l_ac].qcan016
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcan_d[l_ac].qcan016_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcan_d[l_ac].qcan016_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcan2_d[l_ac].qcan010_1
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcan2_d[l_ac].qcan010_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcan2_d[l_ac].qcan010_1_desc

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aqci010_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aqci010_detail_show()
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
 
{<section id="aqci010.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aqci010_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE qcam_t.qcam001 
   DEFINE l_oldno     LIKE qcam_t.qcam001 
   DEFINE l_newno02     LIKE qcam_t.qcam002 
   DEFINE l_oldno02     LIKE qcam_t.qcam002 
   DEFINE l_newno03     LIKE qcam_t.qcam003 
   DEFINE l_oldno03     LIKE qcam_t.qcam003 
   DEFINE l_newno04     LIKE qcam_t.qcam004 
   DEFINE l_oldno04     LIKE qcam_t.qcam004 
   DEFINE l_newno05     LIKE qcam_t.qcam005 
   DEFINE l_oldno05     LIKE qcam_t.qcam005 
   DEFINE l_newno06     LIKE qcam_t.qcam006 
   DEFINE l_oldno06     LIKE qcam_t.qcam006 
   DEFINE l_newno07     LIKE qcam_t.qcam008 
   DEFINE l_oldno07     LIKE qcam_t.qcam008 
   DEFINE l_newno08     LIKE qcam_t.qcam009 
   DEFINE l_oldno08     LIKE qcam_t.qcam009 
 
   DEFINE l_master    RECORD LIKE qcam_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE qcan_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_qcam_m.qcam001 IS NULL
   OR g_qcam_m.qcam002 IS NULL
   OR g_qcam_m.qcam003 IS NULL
   OR g_qcam_m.qcam004 IS NULL
   OR g_qcam_m.qcam005 IS NULL
   OR g_qcam_m.qcam006 IS NULL
   OR g_qcam_m.qcam008 IS NULL
   OR g_qcam_m.qcam009 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_qcam001_t = g_qcam_m.qcam001
   LET g_qcam002_t = g_qcam_m.qcam002
   LET g_qcam003_t = g_qcam_m.qcam003
   LET g_qcam004_t = g_qcam_m.qcam004
   LET g_qcam005_t = g_qcam_m.qcam005
   LET g_qcam006_t = g_qcam_m.qcam006
   LET g_qcam008_t = g_qcam_m.qcam008
   LET g_qcam009_t = g_qcam_m.qcam009
 
    
   LET g_qcam_m.qcam001 = ""
   LET g_qcam_m.qcam002 = ""
   LET g_qcam_m.qcam003 = ""
   LET g_qcam_m.qcam004 = ""
   LET g_qcam_m.qcam005 = ""
   LET g_qcam_m.qcam006 = ""
   LET g_qcam_m.qcam008 = ""
   LET g_qcam_m.qcam009 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_qcam_m.qcamownid = g_user
      LET g_qcam_m.qcamowndp = g_dept
      LET g_qcam_m.qcamcrtid = g_user
      LET g_qcam_m.qcamcrtdp = g_dept 
      LET g_qcam_m.qcamcrtdt = cl_get_current()
      LET g_qcam_m.qcammodid = g_user
      LET g_qcam_m.qcammoddt = cl_get_current()
      LET g_qcam_m.qcamstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_qcam_m.qcamstus = "Y"
   LET g_qcam_m.qcam004 = 'ALL'
   LET g_qcam_m.qcam008 = 'ALL'
   LET g_qcam008_t = g_qcam_m.qcam008
   LET g_qcam004_t = g_qcam_m.qcam004
   LET g_qcam_m.qcam006 = 0
   LET g_qcam006_t = g_qcam_m.qcam006
   LET g_qcam_m.qcam001 = g_qcam001   #add by xujing 20151022
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_qcam_m.qcamstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_qcam_m.qcam001_desc = ''
   DISPLAY BY NAME g_qcam_m.qcam001_desc
   LET g_qcam_m.qcam002_desc = ''
   DISPLAY BY NAME g_qcam_m.qcam002_desc
   LET g_qcam_m.qcam003_desc = ''
   DISPLAY BY NAME g_qcam_m.qcam003_desc
   LET g_qcam_m.qcam005_desc = ''
   DISPLAY BY NAME g_qcam_m.qcam005_desc
   LET g_qcam_m.qcam008_desc = ''
   DISPLAY BY NAME g_qcam_m.qcam008_desc
 
   
   CALL aqci010_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_qcam_m.* TO NULL
      INITIALIZE g_qcan_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aqci010_show()
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
   CALL aqci010_set_act_visible()   
   CALL aqci010_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_qcam001_t = g_qcam_m.qcam001
   LET g_qcam002_t = g_qcam_m.qcam002
   LET g_qcam003_t = g_qcam_m.qcam003
   LET g_qcam004_t = g_qcam_m.qcam004
   LET g_qcam005_t = g_qcam_m.qcam005
   LET g_qcam006_t = g_qcam_m.qcam006
   LET g_qcam008_t = g_qcam_m.qcam008
   LET g_qcam009_t = g_qcam_m.qcam009
 
   
   #組合新增資料的條件
   LET g_add_browse = " qcament = " ||g_enterprise|| " AND",
                      " qcam001 = '", g_qcam_m.qcam001, "' "
                      ," AND qcam002 = '", g_qcam_m.qcam002, "' "
                      ," AND qcam003 = '", g_qcam_m.qcam003, "' "
                      ," AND qcam004 = '", g_qcam_m.qcam004, "' "
                      ," AND qcam005 = '", g_qcam_m.qcam005, "' "
                      ," AND qcam006 = '", g_qcam_m.qcam006, "' "
                      ," AND qcam008 = '", g_qcam_m.qcam008, "' "
                      ," AND qcam009 = '", g_qcam_m.qcam009, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aqci010_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aqci010_idx_chk()
   
   LET g_data_owner = g_qcam_m.qcamownid      
   LET g_data_dept  = g_qcam_m.qcamowndp
   
   #功能已完成,通報訊息中心
   CALL aqci010_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aqci010_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE qcan_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aqci010_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM qcan_t
    WHERE qcanent = g_enterprise AND qcan001 = g_qcam001_t
     AND qcan002 = g_qcam002_t
     AND qcan003 = g_qcam003_t
     AND qcan004 = g_qcam004_t
     AND qcan005 = g_qcam005_t
     AND qcan006 = g_qcam006_t
     AND qcan007 = g_qcam008_t
     AND qcan008 = g_qcam009_t
 
    INTO TEMP aqci010_detail
 
   #將key修正為調整後   
   UPDATE aqci010_detail 
      #更新key欄位
      SET qcan001 = g_qcam_m.qcam001
          , qcan002 = g_qcam_m.qcam002
          , qcan003 = g_qcam_m.qcam003
          , qcan004 = g_qcam_m.qcam004
          , qcan005 = g_qcam_m.qcam005
          , qcan006 = g_qcam_m.qcam006
          , qcan007 = g_qcam_m.qcam008
          , qcan008 = g_qcam_m.qcam009
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO qcan_t SELECT * FROM aqci010_detail
   
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
   DROP TABLE aqci010_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_qcam001_t = g_qcam_m.qcam001
   LET g_qcam002_t = g_qcam_m.qcam002
   LET g_qcam003_t = g_qcam_m.qcam003
   LET g_qcam004_t = g_qcam_m.qcam004
   LET g_qcam005_t = g_qcam_m.qcam005
   LET g_qcam006_t = g_qcam_m.qcam006
   LET g_qcam008_t = g_qcam_m.qcam008
   LET g_qcam009_t = g_qcam_m.qcam009
 
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aqci010_delete()
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
   
   IF g_qcam_m.qcam001 IS NULL
   OR g_qcam_m.qcam002 IS NULL
   OR g_qcam_m.qcam003 IS NULL
   OR g_qcam_m.qcam004 IS NULL
   OR g_qcam_m.qcam005 IS NULL
   OR g_qcam_m.qcam006 IS NULL
   OR g_qcam_m.qcam008 IS NULL
   OR g_qcam_m.qcam009 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aqci010_cl USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aqci010_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aqci010_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
       g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001,g_qcam_m.qcam002, 
       g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008, 
       g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt,g_qcam_m.qcam001_desc, 
       g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc,g_qcam_m.qcamownid_desc, 
       g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcammodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aqci010_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_qcam_m_mask_o.* =  g_qcam_m.*
   CALL aqci010_qcam_t_mask()
   LET g_qcam_m_mask_n.* =  g_qcam_m.*
   
   CALL aqci010_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aqci010_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_qcam001_t = g_qcam_m.qcam001
      LET g_qcam002_t = g_qcam_m.qcam002
      LET g_qcam003_t = g_qcam_m.qcam003
      LET g_qcam004_t = g_qcam_m.qcam004
      LET g_qcam005_t = g_qcam_m.qcam005
      LET g_qcam006_t = g_qcam_m.qcam006
      LET g_qcam008_t = g_qcam_m.qcam008
      LET g_qcam009_t = g_qcam_m.qcam009
 
 
      DELETE FROM qcam_t
       WHERE qcament = g_enterprise AND qcam001 = g_qcam_m.qcam001
         AND qcam002 = g_qcam_m.qcam002
         AND qcam003 = g_qcam_m.qcam003
         AND qcam004 = g_qcam_m.qcam004
         AND qcam005 = g_qcam_m.qcam005
         AND qcam006 = g_qcam_m.qcam006
         AND qcam008 = g_qcam_m.qcam008
         AND qcam009 = g_qcam_m.qcam009
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_qcam_m.qcam001,":",SQLERRMESSAGE  
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
      
      DELETE FROM qcan_t
       WHERE qcanent = g_enterprise AND qcan001 = g_qcam_m.qcam001
         AND qcan002 = g_qcam_m.qcam002
         AND qcan003 = g_qcam_m.qcam003
         AND qcan004 = g_qcam_m.qcam004
         AND qcan005 = g_qcam_m.qcam005
         AND qcan006 = g_qcam_m.qcam006
         AND qcan007 = g_qcam_m.qcam008
         AND qcan008 = g_qcam_m.qcam009
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "qcan_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_qcam_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aqci010_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_qcan_d.clear() 
 
     
      CALL aqci010_ui_browser_refresh()  
      #CALL aqci010_ui_headershow()  
      #CALL aqci010_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aqci010_browser_fill("")
         CALL aqci010_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aqci010_cl
 
   #功能已完成,通報訊息中心
   CALL aqci010_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aqci010.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aqci010_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_qcan_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aqci010_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT qcan009,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016, 
             qcan017,qcan018 ,t1.oocql004 ,t2.oocql004 FROM qcan_t",   
                     " INNER JOIN qcam_t ON qcament = " ||g_enterprise|| " AND qcam001 = qcan001 ",
                     " AND qcam002 = qcan002 ",
                     " AND qcam003 = qcan003 ",
                     " AND qcam004 = qcan004 ",
                     " AND qcam005 = qcan005 ",
                     " AND qcam006 = qcan006 ",
                     " AND qcam008 = qcan007 ",
                     " AND qcam009 = qcan008 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1051' AND t1.oocql002=qcan010 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1052' AND t2.oocql002=qcan016 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE qcanent=? AND qcan001=? AND qcan002=? AND qcan003=? AND qcan004=? AND qcan005=? AND qcan006=? AND qcan007=? AND qcan008=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY qcan_t.qcan009"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aqci010_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aqci010_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
          g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcan_d[l_ac].qcan009, 
          g_qcan_d[l_ac].qcan010,g_qcan_d[l_ac].qcan011,g_qcan_d[l_ac].qcan012,g_qcan_d[l_ac].qcan013, 
          g_qcan_d[l_ac].qcan014,g_qcan_d[l_ac].qcan015,g_qcan_d[l_ac].qcan016,g_qcan_d[l_ac].qcan017, 
          g_qcan_d[l_ac].qcan018,g_qcan_d[l_ac].qcan010_desc,g_qcan_d[l_ac].qcan016_desc   #(ver:78) 
 
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_qcan_d.deleteElement(g_qcan_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aqci010_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_qcan_d.getLength()
      LET g_qcan_d_mask_o[l_ac].* =  g_qcan_d[l_ac].*
      CALL aqci010_qcan_t_mask()
      LET g_qcan_d_mask_n[l_ac].* =  g_qcan_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aqci010_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM qcan_t
       WHERE qcanent = g_enterprise AND
         qcan001 = ps_keys_bak[1] AND qcan002 = ps_keys_bak[2] AND qcan003 = ps_keys_bak[3] AND qcan004 = ps_keys_bak[4] AND qcan005 = ps_keys_bak[5] AND qcan006 = ps_keys_bak[6] AND qcan007 = ps_keys_bak[7] AND qcan008 = ps_keys_bak[8] AND qcan009 = ps_keys_bak[9]
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
         CALL g_qcan_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aqci010_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO qcan_t
                  (qcanent,
                   qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,
                   qcan009
                   ,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017,qcan018) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
                   ,g_qcan_d[g_detail_idx].qcan010,g_qcan_d[g_detail_idx].qcan011,g_qcan_d[g_detail_idx].qcan012, 
                       g_qcan_d[g_detail_idx].qcan013,g_qcan_d[g_detail_idx].qcan014,g_qcan_d[g_detail_idx].qcan015, 
                       g_qcan_d[g_detail_idx].qcan016,g_qcan_d[g_detail_idx].qcan017,g_qcan_d[g_detail_idx].qcan018) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "qcan_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_qcan_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aqci010_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "qcan_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aqci010_qcan_t_mask_restore('restore_mask_o')
               
      UPDATE qcan_t 
         SET (qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,
              qcan009
              ,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017,qcan018) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
              ,g_qcan_d[g_detail_idx].qcan010,g_qcan_d[g_detail_idx].qcan011,g_qcan_d[g_detail_idx].qcan012, 
                  g_qcan_d[g_detail_idx].qcan013,g_qcan_d[g_detail_idx].qcan014,g_qcan_d[g_detail_idx].qcan015, 
                  g_qcan_d[g_detail_idx].qcan016,g_qcan_d[g_detail_idx].qcan017,g_qcan_d[g_detail_idx].qcan018)  
 
         WHERE qcanent = g_enterprise AND qcan001 = ps_keys_bak[1] AND qcan002 = ps_keys_bak[2] AND qcan003 = ps_keys_bak[3] AND qcan004 = ps_keys_bak[4] AND qcan005 = ps_keys_bak[5] AND qcan006 = ps_keys_bak[6] AND qcan007 = ps_keys_bak[7] AND qcan008 = ps_keys_bak[8] AND qcan009 = ps_keys_bak[9]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "qcan_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "qcan_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aqci010_qcan_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aqci010.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aqci010_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aqci010.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aqci010_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aqci010.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aqci010_lock_b(ps_table,ps_page)
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
   #CALL aqci010_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "qcan_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aqci010_bcl USING g_enterprise,
                                       g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
                                           g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009, 
                                           g_qcan_d[g_detail_idx].qcan009     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aqci010_bcl:",SQLERRMESSAGE 
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
 
{<section id="aqci010.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aqci010_unlock_b(ps_table,ps_page)
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
      CLOSE aqci010_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aqci010_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("qcam007",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aqci010_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("qcam001,qcam002,qcam003,qcam004,qcam005,qcam006,qcam008,qcam009",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("qcam007",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("qcam004",FALSE)
   CALL cl_set_comp_entry("qcam001",FALSE)   #add by lixh 20150703 150702-00006#10
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aqci010_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("qcan014,qcan015",TRUE)
#   CALL cl_set_comp_required("qcan019,qcan020,qcan022,qcan023",FALSE)
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aqci010_set_no_entry_b(p_cmd)
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
   IF g_qcan_d[l_ac].qcan013 NOT MATCHES '[1256]' THEN
      INITIALIZE g_qcan_d[l_ac].qcan014 TO NULL
      CALL cl_set_comp_entry("qcan014",FALSE)
   END IF
   
   IF g_qcan_d[l_ac].qcan013 = '4' THEN
#      CALL cl_set_comp_required("qcan019,qcan020,qcan022,qcan023",TRUE)
      CALL cl_set_comp_entry("qcan015",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aqci010_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aqci010_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aqci010_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aqci010_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aqci010_default_search()
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
      LET ls_wc = ls_wc, " qcam001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " qcam002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " qcam003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " qcam004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " qcam005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " qcam006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " qcam008 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " qcam009 = '", g_argv[08], "' AND "
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
               WHEN la_wc[li_idx].tableid = "qcam_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "qcan_t" 
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
 
{<section id="aqci010.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aqci010_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_qcam_m.qcam001 IS NULL
      OR g_qcam_m.qcam002 IS NULL      OR g_qcam_m.qcam003 IS NULL      OR g_qcam_m.qcam004 IS NULL      OR g_qcam_m.qcam005 IS NULL      OR g_qcam_m.qcam006 IS NULL      OR g_qcam_m.qcam008 IS NULL      OR g_qcam_m.qcam009 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aqci010_cl USING g_enterprise,g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009
   IF STATUS THEN
      CLOSE aqci010_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aqci010_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
       g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001,g_qcam_m.qcam002, 
       g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008, 
       g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt,g_qcam_m.qcam001_desc, 
       g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc,g_qcam_m.qcamownid_desc, 
       g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcammodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aqci010_action_chk() THEN
      CLOSE aqci010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc,g_qcam_m.qcam002,g_qcam_m.qcam002_desc,g_qcam_m.qcam003, 
       g_qcam_m.qcam003_desc,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam005_desc,g_qcam_m.qcam006, 
       g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam008_desc,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus, 
       g_qcam_m.qcamownid,g_qcam_m.qcamownid_desc,g_qcam_m.qcamowndp,g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid, 
       g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdp_desc,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid, 
       g_qcam_m.qcammodid_desc,g_qcam_m.qcammoddt
 
   CASE g_qcam_m.qcamstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_qcam_m.qcamstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_qcam_m.qcamstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aqci010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_qcam_m.qcammodid = g_user
   LET g_qcam_m.qcammoddt = cl_get_current()
   LET g_qcam_m.qcamstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE qcam_t 
      SET (qcamstus,qcammodid,qcammoddt) 
        = (g_qcam_m.qcamstus,g_qcam_m.qcammodid,g_qcam_m.qcammoddt)     
    WHERE qcament = g_enterprise AND qcam001 = g_qcam_m.qcam001
      AND qcam002 = g_qcam_m.qcam002      AND qcam003 = g_qcam_m.qcam003      AND qcam004 = g_qcam_m.qcam004      AND qcam005 = g_qcam_m.qcam005      AND qcam006 = g_qcam_m.qcam006      AND qcam008 = g_qcam_m.qcam008      AND qcam009 = g_qcam_m.qcam009
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aqci010_master_referesh USING g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004, 
          g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009 INTO g_qcam_m.qcam001, 
          g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam007, 
          g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamowndp, 
          g_qcam_m.qcamcrtid,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammoddt, 
          g_qcam_m.qcam001_desc,g_qcam_m.qcam002_desc,g_qcam_m.qcam003_desc,g_qcam_m.qcam005_desc,g_qcam_m.qcam008_desc, 
          g_qcam_m.qcamownid_desc,g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp_desc, 
          g_qcam_m.qcammodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_qcam_m.qcam001,g_qcam_m.qcam001_desc,g_qcam_m.qcam002,g_qcam_m.qcam002_desc, 
          g_qcam_m.qcam003,g_qcam_m.qcam003_desc,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam005_desc, 
          g_qcam_m.qcam006,g_qcam_m.qcam007,g_qcam_m.qcam008,g_qcam_m.qcam008_desc,g_qcam_m.qcam009, 
          g_qcam_m.qcam010,g_qcam_m.qcamstus,g_qcam_m.qcamownid,g_qcam_m.qcamownid_desc,g_qcam_m.qcamowndp, 
          g_qcam_m.qcamowndp_desc,g_qcam_m.qcamcrtid,g_qcam_m.qcamcrtid_desc,g_qcam_m.qcamcrtdp,g_qcam_m.qcamcrtdp_desc, 
          g_qcam_m.qcamcrtdt,g_qcam_m.qcammodid,g_qcam_m.qcammodid_desc,g_qcam_m.qcammoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aqci010_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aqci010_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aqci010.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aqci010_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_qcan_d.getLength() THEN
         LET g_detail_idx = g_qcan_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_qcan_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_qcan_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aqci010_b_fill2(pi_idx)
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
   CALL g_qcan2_d.clear()    #g_qcan2_d 單頭及單身 

 
   #add-point:b_fill段sql_before

   #end add-point
   
   #判斷是否填充
   IF aqci010_fill2_chk(1) THEN
   
      LET g_sql = "SELECT qcan009,qcan010,'',qcan011,qcan013,qcan019,qcan020,qcan021,qcan022,qcan023,qcan024,qcan025,qcan026",
                        " FROM qcan_t " ,
                  " INNER JOIN qcam_t ON qcam001 = qcan001 ",
                  " AND qcam002 = qcan002 ",

                  " AND qcam003 = qcan003 ",

                  " AND qcam004 = qcan004 ",

                  " AND qcam005 = qcan005 ",

                  " AND qcam006 = qcan006 ",

                  " AND qcam008 = qcan007 ",

                  " AND qcam009 = qcan008 ",


                  "",
                  
                  " WHERE qcanent=? AND qcan001=? AND qcan002=? AND qcan003=? AND qcan004=? AND qcan005=? AND qcan006=? AND qcan007=? AND qcan008=?"
      
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY qcan_t.qcan009"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aqci010_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR aqci010_pb2
      
      LET g_cnt2 = l_ac2
      LET l_ac2 = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_qcam_m.qcam001
                                               ,g_qcam_m.qcam002

                                               ,g_qcam_m.qcam003

                                               ,g_qcam_m.qcam004

                                               ,g_qcam_m.qcam005

                                               ,g_qcam_m.qcam006

                                               ,g_qcam_m.qcam008

                                               ,g_qcam_m.qcam009


                                               
      FOREACH b_fill_cs2 INTO g_qcan2_d[l_ac2].qcan009_1,g_qcan2_d[l_ac2].qcan010_1,g_qcan2_d[l_ac2].qcan010_1_desc,g_qcan2_d[l_ac2].qcan011_1,g_qcan2_d[l_ac2].qcan013_1,
                              g_qcan2_d[l_ac2].qcan019,g_qcan2_d[l_ac2].qcan020,g_qcan2_d[l_ac2].qcan021,g_qcan2_d[l_ac2].qcan022,g_qcan2_d[l_ac2].qcan023,
                              g_qcan2_d[l_ac2].qcan024,g_qcan2_d[l_ac2].qcan025,g_qcan2_d[l_ac2].qcan026
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL s_desc_get_acc_desc('1051',g_qcan2_d[l_ac2].qcan010_1) RETURNING g_qcan2_d[l_ac2].qcan010_1_desc   #161018-00003#1
         #end add-point
      
         LET l_ac2 = l_ac2 + 1
         IF l_ac2 > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   

   
   CALL g_qcan2_d.deleteElement(g_qcan2_d.getLength())

   

   LET l_ac2 = g_cnt2
   LET g_cnt2 = 0  
   
   FREE aqci010_pb2
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aqci010_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aqci010_fill_chk(ps_idx)
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
 
{<section id="aqci010.status_show" >}
PRIVATE FUNCTION aqci010_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aqci010.mask_functions" >}
&include "erp/aqc/aqci010_mask.4gl"
 
{</section>}
 
{<section id="aqci010.signature" >}
   
 
{</section>}
 
{<section id="aqci010.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aqci010_set_pk_array()
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
   LET g_pk_array[1].values = g_qcam_m.qcam001
   LET g_pk_array[1].column = 'qcam001'
   LET g_pk_array[2].values = g_qcam_m.qcam002
   LET g_pk_array[2].column = 'qcam002'
   LET g_pk_array[3].values = g_qcam_m.qcam003
   LET g_pk_array[3].column = 'qcam003'
   LET g_pk_array[4].values = g_qcam_m.qcam004
   LET g_pk_array[4].column = 'qcam004'
   LET g_pk_array[5].values = g_qcam_m.qcam005
   LET g_pk_array[5].column = 'qcam005'
   LET g_pk_array[6].values = g_qcam_m.qcam006
   LET g_pk_array[6].column = 'qcam006'
   LET g_pk_array[7].values = g_qcam_m.qcam008
   LET g_pk_array[7].column = 'qcam008'
   LET g_pk_array[8].values = g_qcam_m.qcam009
   LET g_pk_array[8].column = 'qcam009'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aqci010.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aqci010.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aqci010_msgcentre_notify(lc_state)
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
   CALL aqci010_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_qcam_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aqci010.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aqci010_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aqci010.other_function" readonly="Y" >}

PRIVATE FUNCTION aqci010_qcam001_chk(p_qcam001)
DEFINE p_qcam001  LIKE qcam_t.qcam001
DEFINE l_n        LIKE type_t.num5
   IF NOT cl_null(p_qcam001) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM ooal_t
       WHERE ooalent = g_enterprise
         AND ooal002 = p_qcam001
         AND ooal001 = 5
      IF l_n = 0 THEN
         IF cl_ask_confirm('aoo-00076') THEN
            IF NOT s_aooi070_ins(5,p_qcam001) THEN
               RETURN FALSE
            END IF
         ELSE
            RETURN FALSE
         END IF
      END IF
      IF NOT s_aooi070_chk_exist(5,p_qcam001) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam002_chk(p_qcam002)
DEFINE p_qcam002   LIKE qcam_t.qcam002
#150527 by whitney modify start
#   IF NOT cl_null(p_qcam002) AND p_qcam002 != 'ALL' THEN
#      IF NOT ap_chk_isExist(p_qcam002,"SELECT COUNT(*) FROM imcg_t WHERE imcgent = "||g_enterprise||" AND imcgsite = '"||g_site||"'  AND imcg111 = ?",'aim-00042',1) THEN
#         LET g_qcam_m.qcam002 = g_qcam002_t
#         RETURN FALSE
#      END IF
#      IF NOT ap_chk_isExist(p_qcam002,"SELECT COUNT(*) FROM imcg_t WHERE imcgent = "||g_enterprise||" AND imcgsite = '"||g_site||"'  AND imcg111 = ? AND imcgstus = 'Y'",'aim-00042',1) THEN
#         RETURN FALSE
#      END IF
#   END IF
    IF NOT cl_null(p_qcam002) AND p_qcam002 != 'ALL' THEN   #160107-00014#1 add
       IF NOT s_azzi650_chk_exist('205',p_qcam002) THEN
          RETURN FALSE
       END IF
    END IF  #160107-00014#1 add
#150527 by whitney modify end
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam002_qcam003_default(p_qcam002,p_qcam003)
DEFINE p_qcam002  LIKE qcam_t.qcam002
DEFINE p_qcam003  LIKE qcam_t.qcam003
   IF cl_null(p_qcam002) AND cl_null(p_qcam003) THEN
      RETURN TRUE 
   END IF
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam002_qcam003_chk(p_qcam002,p_qcam003)
DEFINE p_qcam002  LIKE qcam_t.qcam002
DEFINE p_qcam003  LIKE qcam_t.qcam003
   IF p_qcam002 = 'ALL' AND p_qcam003 = 'ALL' THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam003_chk(p_qcam002,p_qcam003)
DEFINE p_qcam003    LIKE qcam_t.qcam003
DEFINE p_qcam002    LIKE qcam_t.qcam002
DEFINE l_sql        STRING
   IF NOT cl_null(p_qcam003) AND p_qcam003 != 'ALL' THEN
      LET l_sql = "SELECT COUNT(*) FROM imaa_t  WHERE imaaent=",g_enterprise," AND imaa001=?"
      IF NOT ap_chk_isExist(p_qcam003,l_sql,'aim-00001',1) THEN
         RETURN FALSE
      END IF
      LET l_sql = l_sql," AND imaastus = 'Y'"
#      IF NOT ap_chk_isExist(p_qcam003,l_sql,'aim-00002',1) THEN     #160318-00005#42  mark
      IF NOT ap_chk_isExist(p_qcam003,l_sql,'sub-01302','aimm200') THEN      #160318-00005#42  add
         RETURN FALSE
      END IF  
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_imae111_chk(p_qcam002,p_qcam003)
DEFINE p_qcam003    LIKE qcam_t.qcam003
DEFINE p_qcam002    LIKE qcam_t.qcam002
DEFINE l_sql        STRING
   IF NOT cl_null(p_qcam003) AND NOT cl_null(p_qcam002) AND p_qcam002 != 'ALL' AND p_qcam003 != 'ALL' THEN
      LET l_sql = "SELECT COUNT(*) FROM imaa_t LEFT JOIN imae_t ON imaaent=imaeent AND imaa001=imae001 AND imaesite='",g_site,"'", 
                  " WHERE imaaent=",g_enterprise," AND imaa001=? AND imae111='",p_qcam002 CLIPPED,"' AND imaastus = 'Y'"
      IF NOT ap_chk_isExist(p_qcam003,l_sql,'aim-00157',1) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam004_entry(p_qcam003)
DEFINE l_n   LIKE type_t.num5
DEFINE p_qcam003 LIKE qcam_t.qcam003
   IF NOT cl_null(p_qcam003) AND p_qcam003 != 'ALL' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM imaa_t WHERE imaa001 = p_qcam003
         AND imaaent = g_enterprise AND imaa005 IS NOT NULL
      IF l_n = 0 THEN
         CALL cl_set_comp_entry("qcam004",FALSE)
         RETURN FALSE
      ELSE
         CALL cl_set_comp_entry("qcam004",TRUE)
         RETURN TRUE
      END IF             
   END IF
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam005_chk(p_qcam005)
DEFINE l_sql    STRING
DEFINE p_qcam005 LIKE qcam_t.qcam005
   IF NOT cl_null(p_qcam005) AND p_qcam005 !='ALL' THEN
      LET l_sql = "SELECT COUNT(*) FROM oocq_t WHERE oocqent = ",g_enterprise,
                  " AND oocq001 = '221' AND oocq002 = ?"
#      IF NOT ap_chk_isExist(p_qcam005,l_sql,'aqc-00016',1) THEN      #160318-00005#42  mark
      IF NOT ap_chk_isExist(p_qcam005,l_sql,'sub-01303','aeci004') THEN      #160318-00005#42  add
         RETURN FALSE
      END IF
      
      LET l_sql = l_sql," AND oocqstus='Y'"
#      IF NOT ap_chk_isExist(p_qcam005,l_sql,'aqc-00017',1) THEN   #160318-00005#42  mark
      IF NOT ap_chk_isExist(p_qcam005,l_sql,'sub-01302','aeci004') THEN   #160318-00005#42  add
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam008_chk(p_qcam007,p_qcam008)
DEFINE p_qcam007     LIKE qcam_t.qcam007
DEFINE p_qcam008     LIKE qcam_t.qcam008
DEFINE l_sql         STRING
   IF NOT cl_null(p_qcam007) AND NOT cl_null(p_qcam008) THEN
      LET l_sql = "SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = ",g_enterprise,
                  " AND pmaa001 = ?"
      IF p_qcam007 = '0' AND p_qcam008 != 'ALL' THEN
         IF NOT ap_chk_isExist(p_qcam008,l_sql,'ais-00019',1) THEN
            RETURN FALSE
         END IF
         LET l_sql = l_sql," AND pmaastus = 'Y'"
         IF NOT ap_chk_isExist(p_qcam008,l_sql,'ais-00020',1) THEN
            RETURN FALSE
         END IF
      END IF
      IF p_qcam007 = '1' THEN
         LET l_sql = l_sql," AND pmaa002 IN ('2','3')"
         IF NOT ap_chk_isExist(p_qcam008,l_sql,'abm-00034',1) THEN
            RETURN FALSE
         END IF
         
         LET l_sql = l_sql," AND pmaastus = 'Y'"
#         IF NOT ap_chk_isExist(p_qcam008,l_sql,'abm-00035',1) THEN      #160318-00005#42  mark
         IF NOT ap_chk_isExist(p_qcam008,l_sql,'sub-01302','apmm100') THEN       #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
      IF p_qcam007 = '2' THEN
         LET l_sql = l_sql," AND pmaa002 IN ('1','3')"
         IF NOT ap_chk_isExist(p_qcam008,l_sql,'aqc-00018',1) THEN
            RETURN FALSE
         END IF
         
         LET l_sql = l_sql," AND pmaastus = 'Y'"
#         IF NOT ap_chk_isExist(p_qcam008,l_sql,'abm-00035',1) THEN     #160318-00005#42  mark
         IF NOT ap_chk_isExist(p_qcam008,l_sql,'sub-01302','apmm100') THEN      #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcan014_chk()
DEFINE l_sql      STRING
DEFINE l_n        LIKE type_t.num5
   IF NOT cl_null(g_qcan_d[l_ac].qcan013) AND NOT cl_null(g_qcan_d[l_ac].qcan014) THEN
      IF g_qcan_d[l_ac].qcan013 = '1' THEN
         LET l_sql = "SELECT COUNT(*) FROM qcac_t WHERE qcacent=",g_enterprise," AND qcac002=?"
         IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan014,l_sql,'aqc-00021',1) THEN
            RETURN FALSE
         END IF
         LET l_sql = l_sql," AND qcacstus='Y'"
#         IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan014,l_sql,'aqc-00022',1) THEN     #160318-00005#42  mark
         IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan014,l_sql,'sub-01302','aqci003') THEN     #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
      IF g_qcan_d[l_ac].qcan013 = '2' THEN
         LET l_sql = "SELECT COUNT(*) FROM qcag_t WHERE qcagent=",g_enterprise," AND qcag003=?"
         IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan014,l_sql,'aqc-00023',1) THEN
            RETURN FALSE
         END IF
         LET l_sql = l_sql," AND qcagstus='Y'"
#         IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan014,l_sql,'aqc-00024',1) THEN     #160318-00005#42  mark
         IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan014,l_sql,'sub-01302','aqci007') THEN     #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
      IF g_qcan_d[l_ac].qcan013 = '5' THEN 
         IF g_qcan_d[l_ac].qcan014 < 0 OR g_qcan_d[l_ac].qcan014 > 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aqc-00057'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
      IF g_qcan_d[l_ac].qcan013 = '6' THEN 
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM qcah_t 
          WHERE qcahent = g_enterprise AND qcah001 = g_qcam_m.qcam001
            AND qcah002 =  g_qcan_d[l_ac].qcan014
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00058'
             LET g_errparam.extend = g_qcan_d[l_ac].qcan014
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF
          
          LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM qcah_t 
          WHERE qcahent = g_enterprise AND qcah001 = g_qcam_m.qcam001
            AND qcah002 =  g_qcan_d[l_ac].qcan014 AND qcahstus = 'Y'
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = 'aqc-00059'     #160318-00005#42  mark
             LET g_errparam.code = 'sub-01302'     #160318-00005#42  add
             LET g_errparam.extend = g_qcan_d[l_ac].qcan014
             #160318-00005#42 --s add
             LET g_errparam.replace[1] = 'aqci011'
             LET g_errparam.replace[2] = cl_get_progname('aqci011',g_lang,"2")
             LET g_errparam.exeprog = 'aqci011'
             #160318-00005#42 --e add
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_fill2_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充


   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION aqci010_lock_b2(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL aqci010_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "qcan_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aqci010_bcl2 USING g_enterprise,
                                       g_qcam_m.qcam001,g_qcam_m.qcam002,g_qcam_m.qcam003,g_qcam_m.qcam004,g_qcam_m.qcam005,g_qcam_m.qcam006,g_qcam_m.qcam008,g_qcam_m.qcam009,g_qcan2_d[g_detail_idx2].qcan009_1
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aqci010_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
                                    

   

   
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_set_entry_b2(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   

END FUNCTION

PRIVATE FUNCTION aqci010_set_no_entry_b2(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("qcan009_1,qcan010_1,qcan011_1,qcan013_1",FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION aqci010_unlock_b2(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define

   #end add-point  
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,2) THEN
      CLOSE aqci010_bcl2
   END IF
END FUNCTION

PRIVATE FUNCTION aqci010_update_b2(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define

   #end add-point     
   
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
   LET ls_group = "'2',"
   IF ls_group.getIndexOf(ps_page,2) > 0 THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE qcan_t 
         SET (qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,
              qcan009
              ,qcan019,qcan020,qcan021,qcan022,qcan023,qcan024,qcan025,qcan026) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
              ,g_qcan2_d[g_detail_idx2].qcan019,g_qcan2_d[g_detail_idx2].qcan020,g_qcan2_d[g_detail_idx2].qcan021,g_qcan2_d[g_detail_idx2].qcan022,g_qcan2_d[g_detail_idx2].qcan023,g_qcan2_d[g_detail_idx2].qcan024,g_qcan2_d[g_detail_idx2].qcan025,g_qcan2_d[g_detail_idx2].qcan026) 
         WHERE qcanent = g_enterprise AND qcan001 = ps_keys_bak[1] AND qcan002 = ps_keys_bak[2] AND qcan003 = ps_keys_bak[3] AND qcan004 = ps_keys_bak[4] AND qcan005 = ps_keys_bak[5] AND qcan006 = ps_keys_bak[6] AND qcan007 = ps_keys_bak[7] AND qcan008 = ps_keys_bak[8] AND qcan009 = ps_keys_bak[9]
      #add-point:update_b段修改中

      #end add-point   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
         
      END IF
      #add-point:update_b段修改後

      #end add-point  
   END IF
END FUNCTION

PRIVATE FUNCTION aqci010_qcan019_qcan023_chk()
   IF NOT cl_null(g_qcan2_d[l_ac2].qcan019) AND NOT cl_null(g_qcan2_d[l_ac2].qcan023) THEN
      IF g_qcan2_d[l_ac2].qcan019 < g_qcan2_d[l_ac2].qcan023 THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcan020_qcan022_chk()
   IF NOT cl_null(g_qcan2_d[l_ac2].qcan020) AND NOT cl_null(g_qcan2_d[l_ac2].qcan022) THEN
      IF g_qcan2_d[l_ac2].qcan020 < g_qcan2_d[l_ac2].qcan022 THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aqci010_qcam001_desc(p_qcam001)
DEFINE p_qcam001   LIKE qcam_t.qcam001
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcam001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='5' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcam_m.qcam001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcam_m.qcam001_desc
END FUNCTION

PRIVATE FUNCTION aqci010_qcam002_desc(p_qcam002)
DEFINE p_qcam002   LIKE qcam_t.qcam002
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcam002 
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcam_m.qcam002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcam_m.qcam002_desc
END FUNCTION

PRIVATE FUNCTION aqci010_qcam003_desc(p_qcam003)
DEFINE p_qcam003   LIKE qcam_t.qcam003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcam003
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcam_m.qcam003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcam_m.qcam003_desc
END FUNCTION

PRIVATE FUNCTION aqci010_qcam005_desc(p_qcam005)
DEFINE p_qcam005    LIKE qcam_t.qcam005
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcam005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcam_m.qcam005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcam_m.qcam005_desc
END FUNCTION

PRIVATE FUNCTION aqci010_qcam008_desc(p_qcam008)
DEFINE p_qcam008 LIKE qcam_t.qcam008
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcam008
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcam_m.qcam008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcam_m.qcam008_desc
END FUNCTION

PRIVATE FUNCTION aqci010_qcan016_required(p_qcan015)
DEFINE p_qcan015     LIKE qcan_t.qcan015
   IF p_qcan015 != '1' THEN
      CALL cl_set_comp_required("qcan016",TRUE)
   ELSE
      CALL cl_set_comp_required("qcan016",FALSE)
   END IF
END FUNCTION

 
{</section>}
 
