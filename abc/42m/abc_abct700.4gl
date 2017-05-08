#該程式未解開Section, 採用最新樣板產出!
{<section id="abct700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-11-21 10:17:39), PR版次:0005(2016-11-23 16:08:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: abct700
#+ Description: 條碼資訊異動作業
#+ Creator....: 05384(2015-05-28 13:59:04)
#+ Modifier...: 04543 -SD/PR- 04543
 
{</section>}
 
{<section id="abct700.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#18   2016/04/13 BY 07900    校验代码重复错误讯息的修改
#161019-00017#1    2016/10/19 By lixh     组织类型调整 q_ooef001 => q_ooef001_1
#161028-00045#2    2016/11/01 By earl     邏輯重整
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
PRIVATE type type_g_bcac_m        RECORD
       bcac000 LIKE bcac_t.bcac000, 
   bcaccomp LIKE bcac_t.bcaccomp, 
   bcaccomp_desc LIKE type_t.chr80, 
   bcacsite LIKE bcac_t.bcacsite, 
   bcacsite_desc LIKE type_t.chr80, 
   bcacdocno LIKE bcac_t.bcacdocno, 
   bcacdocno_desc LIKE type_t.chr80, 
   bcacdocdt LIKE bcac_t.bcacdocdt, 
   bcac013 LIKE bcac_t.bcac013, 
   bcac013_desc LIKE type_t.chr80, 
   bcac014 LIKE bcac_t.bcac014, 
   bcac014_desc LIKE type_t.chr80, 
   bcacstus LIKE bcac_t.bcacstus, 
   bcac011 LIKE bcac_t.bcac011, 
   bcac001 LIKE bcac_t.bcac001, 
   bcac009 LIKE bcac_t.bcac009, 
   bcac002 LIKE bcac_t.bcac002, 
   bcac002_desc LIKE type_t.chr80, 
   bcac002_desc_1 LIKE type_t.chr80, 
   bcac008 LIKE bcac_t.bcac008, 
   bcac008_desc LIKE type_t.chr80, 
   bcac012 LIKE bcac_t.bcac012, 
   bcac012_desc LIKE type_t.chr80, 
   bcac003 LIKE bcac_t.bcac003, 
   bcac004 LIKE bcac_t.bcac004, 
   bcac005 LIKE bcac_t.bcac005, 
   bcac006 LIKE bcac_t.bcac006, 
   bcac007 LIKE bcac_t.bcac007, 
   bcacownid LIKE bcac_t.bcacownid, 
   bcacownid_desc LIKE type_t.chr80, 
   bcacowndp LIKE bcac_t.bcacowndp, 
   bcacowndp_desc LIKE type_t.chr80, 
   bcaccrtid LIKE bcac_t.bcaccrtid, 
   bcaccrtid_desc LIKE type_t.chr80, 
   bcaccrtdp LIKE bcac_t.bcaccrtdp, 
   bcaccrtdp_desc LIKE type_t.chr80, 
   bcaccrtdt LIKE bcac_t.bcaccrtdt, 
   bcacmodid LIKE bcac_t.bcacmodid, 
   bcacmodid_desc LIKE type_t.chr80, 
   bcacmoddt LIKE bcac_t.bcacmoddt, 
   bcaccnfid LIKE bcac_t.bcaccnfid, 
   bcaccnfid_desc LIKE type_t.chr80, 
   bcaccnfdt LIKE bcac_t.bcaccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bcad_d        RECORD
       bcad000 LIKE bcad_t.bcad000, 
   bcadsite LIKE bcad_t.bcadsite, 
   bcad001 LIKE bcad_t.bcad001, 
   bcadseq LIKE bcad_t.bcadseq, 
   bcad002 LIKE bcad_t.bcad002, 
   bcad002_desc LIKE type_t.chr500, 
   bcad003 LIKE bcad_t.bcad003, 
   bcad003_desc LIKE type_t.chr500, 
   bcad004 LIKE bcad_t.bcad004, 
   bcad008 LIKE bcad_t.bcad008, 
   bcad005 LIKE bcad_t.bcad005, 
   bcad006 LIKE bcad_t.bcad006, 
   bcad007 LIKE bcad_t.bcad007
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bcacdocno LIKE bcac_t.bcacdocno,
      b_bcacdocdt LIKE bcac_t.bcacdocdt,
      b_bcac011 LIKE bcac_t.bcac011,
      b_bcac001 LIKE bcac_t.bcac001,
      b_bcac013 LIKE bcac_t.bcac013,
   b_bcac013_desc LIKE type_t.chr80,
      b_bcaccrtid LIKE bcac_t.bcaccrtid,
   b_bcaccrtid_desc LIKE type_t.chr80,
      b_bcaccrtdp LIKE bcac_t.bcaccrtdp,
   b_bcaccrtdp_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_bcac_m          type_g_bcac_m
DEFINE g_bcac_m_t        type_g_bcac_m
DEFINE g_bcac_m_o        type_g_bcac_m
DEFINE g_bcac_m_mask_o   type_g_bcac_m #轉換遮罩前資料
DEFINE g_bcac_m_mask_n   type_g_bcac_m #轉換遮罩後資料
 
   DEFINE g_bcacdocno_t LIKE bcac_t.bcacdocno
 
 
DEFINE g_bcad_d          DYNAMIC ARRAY OF type_g_bcad_d
DEFINE g_bcad_d_t        type_g_bcad_d
DEFINE g_bcad_d_o        type_g_bcad_d
DEFINE g_bcad_d_mask_o   DYNAMIC ARRAY OF type_g_bcad_d #轉換遮罩前資料
DEFINE g_bcad_d_mask_n   DYNAMIC ARRAY OF type_g_bcad_d #轉換遮罩後資料
 
 
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
DEFINE g_slip             LIKE oobal_t.oobal002
DEFINE g_slip_wc          STRING
#end add-point
 
{</section>}
 
{<section id="abct700.main" >}
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
   CALL cl_ap_init("abc","")
 
   #add-point:作業初始化 name="main.init"
   LET g_errshow = '1'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bcac000,bcaccomp,'',bcacsite,'',bcacdocno,'',bcacdocdt,bcac013,'',bcac014, 
       '',bcacstus,bcac011,bcac001,bcac009,bcac002,'','',bcac008,'',bcac012,'',bcac003,bcac004,bcac005, 
       bcac006,bcac007,bcacownid,'',bcacowndp,'',bcaccrtid,'',bcaccrtdp,'',bcaccrtdt,bcacmodid,'',bcacmoddt, 
       bcaccnfid,'',bcaccnfdt", 
                      " FROM bcac_t",
                      " WHERE bcacent= ? AND bcacdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abct700_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bcac000,t0.bcaccomp,t0.bcacsite,t0.bcacdocno,t0.bcacdocdt,t0.bcac013, 
       t0.bcac014,t0.bcacstus,t0.bcac011,t0.bcac001,t0.bcac009,t0.bcac002,t0.bcac008,t0.bcac012,t0.bcac003, 
       t0.bcac004,t0.bcac005,t0.bcac006,t0.bcac007,t0.bcacownid,t0.bcacowndp,t0.bcaccrtid,t0.bcaccrtdp, 
       t0.bcaccrtdt,t0.bcacmodid,t0.bcacmoddt,t0.bcaccnfid,t0.bcaccnfdt,t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 , 
       t4.ooefl003 ,t5.imaal003 ,t6.oocal003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 , 
       t12.ooag011",
               " FROM bcac_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.bcaccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bcacsite AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bcac013  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bcac014 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=t0.bcac002 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=t0.bcac012 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.bcacownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.bcacowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.bcaccrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.bcaccrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.bcacmodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.bcaccnfid  ",
 
               " WHERE t0.bcacent = " ||g_enterprise|| " AND t0.bcacdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abct700_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abct700 WITH FORM cl_ap_formpath("abc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abct700_init()   
 
      #進入選單 Menu (="N")
      CALL abct700_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abct700
      
   END IF 
   
   CLOSE abct700_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abct700.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abct700_init()
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
      CALL cl_set_combo_scc_part('bcacstus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi200_filter_slip('bcacdocno') RETURNING g_slip_wc
   #end add-point
   
   #初始化搜尋條件
   CALL abct700_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abct700.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abct700_ui_dialog()
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
            CALL abct700_insert()
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
         INITIALIZE g_bcac_m.* TO NULL
         CALL g_bcad_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abct700_init()
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
               
               CALL abct700_fetch('') # reload data
               LET l_ac = 1
               CALL abct700_ui_detailshow() #Setting the current row 
         
               CALL abct700_idx_chk()
               #NEXT FIELD bcadseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bcad_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abct700_idx_chk()
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
               CALL abct700_idx_chk()
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
            CALL abct700_browser_fill("")
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
               CALL abct700_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abct700_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abct700_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abct700_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abct700_set_act_visible()   
            CALL abct700_set_act_no_visible()
            IF NOT (g_bcac_m.bcacdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " bcacent = " ||g_enterprise|| " AND",
                                  " bcacdocno = '", g_bcac_m.bcacdocno, "' "
 
               #填到對應位置
               CALL abct700_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "bcac_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bcad_t" 
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
               CALL abct700_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bcac_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bcad_t" 
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
                  CALL abct700_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abct700_fetch("F")
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
               CALL abct700_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abct700_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abct700_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abct700_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abct700_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abct700_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abct700_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abct700_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abct700_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abct700_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abct700_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bcad_d)
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
               NEXT FIELD bcadseq
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
               CALL abct700_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abct700_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abct700_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abct700_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/abc/abct700_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/abc/abct700_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abct700_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abct700_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abct700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abct700_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abct700_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_bcac_m.bcacdocdt)
 
 
 
         
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
 
{<section id="abct700.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abct700_browser_fill(ps_page_action)
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
   
   IF NOT cl_null(g_slip_wc) THEN
      LET l_wc = l_wc," AND ",g_slip_wc
   END IF

   LET l_wc = l_wc," AND bcac000 = '1' AND bcacsite = '",g_site,"'"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT bcacdocno ",
                      " FROM bcac_t ",
                      " ",
                      " LEFT JOIN bcad_t ON bcadent = bcacent AND bcacdocno = bcaddocno ", "  ",
                      #add-point:browser_fill段sql(bcad_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE bcacent = " ||g_enterprise|| " AND bcadent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bcac_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bcacdocno ",
                      " FROM bcac_t ", 
                      "  ",
                      "  ",
                      " WHERE bcacent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bcac_t")
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
      INITIALIZE g_bcac_m.* TO NULL
      CALL g_bcad_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bcacdocno,t0.bcacdocdt,t0.bcac011,t0.bcac001,t0.bcac013,t0.bcaccrtid,t0.bcaccrtdp Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bcacstus,t0.bcacdocno,t0.bcacdocdt,t0.bcac011,t0.bcac001,t0.bcac013, 
          t0.bcaccrtid,t0.bcaccrtdp,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM bcac_t t0",
                  "  ",
                  "  LEFT JOIN bcad_t ON bcadent = bcacent AND bcacdocno = bcaddocno ", "  ", 
                  #add-point:browser_fill段sql(bcad_t1) name="browser_fill.join.bcad_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bcac013  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.bcaccrtid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.bcaccrtdp AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.bcacent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bcac_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bcacstus,t0.bcacdocno,t0.bcacdocdt,t0.bcac011,t0.bcac001,t0.bcac013, 
          t0.bcaccrtid,t0.bcaccrtdp,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM bcac_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bcac013  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.bcaccrtid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.bcaccrtdp AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.bcacent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("bcac_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bcacdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bcac_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bcacdocno,g_browser[g_cnt].b_bcacdocdt, 
          g_browser[g_cnt].b_bcac011,g_browser[g_cnt].b_bcac001,g_browser[g_cnt].b_bcac013,g_browser[g_cnt].b_bcaccrtid, 
          g_browser[g_cnt].b_bcaccrtdp,g_browser[g_cnt].b_bcac013_desc,g_browser[g_cnt].b_bcaccrtid_desc, 
          g_browser[g_cnt].b_bcaccrtdp_desc
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
         CALL abct700_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_bcacdocno) THEN
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
 
{<section id="abct700.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abct700_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bcac_m.bcacdocno = g_browser[g_current_idx].b_bcacdocno   
 
   EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
       g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus, 
       g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
       g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid, 
       g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid, 
       g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc,g_bcac_m.bcacownid_desc, 
       g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcacmodid_desc, 
       g_bcac_m.bcaccnfid_desc
   
   CALL abct700_bcac_t_mask()
   CALL abct700_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abct700.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abct700_ui_detailshow()
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
 
{<section id="abct700.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abct700_ui_browser_refresh()
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
      IF g_browser[l_i].b_bcacdocno = g_bcac_m.bcacdocno 
 
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
 
{<section id="abct700.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abct700_construct()
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
   INITIALIZE g_bcac_m.* TO NULL
   CALL g_bcad_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON bcac000,bcaccomp,bcacsite,bcacdocno,bcacdocdt,bcac013,bcac014,bcacstus, 
          bcac011,bcac001,bcac009,bcac002,bcac008,bcac012,bcac003,bcac004,bcac005,bcac006,bcac007,bcacownid, 
          bcacowndp,bcaccrtid,bcaccrtdp,bcaccrtdt,bcacmodid,bcacmoddt,bcaccnfid,bcaccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bcaccrtdt>>----
         AFTER FIELD bcaccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bcacmoddt>>----
         AFTER FIELD bcacmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bcaccnfdt>>----
         AFTER FIELD bcaccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bcacpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac000
            #add-point:BEFORE FIELD bcac000 name="construct.b.bcac000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac000
            
            #add-point:AFTER FIELD bcac000 name="construct.a.bcac000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac000
            #add-point:ON ACTION controlp INFIELD bcac000 name="construct.c.bcac000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcaccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcaccomp
            #add-point:ON ACTION controlp INFIELD bcaccomp name="construct.c.bcaccomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcaccomp  #顯示到畫面上
            NEXT FIELD bcaccomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccomp
            #add-point:BEFORE FIELD bcaccomp name="construct.b.bcaccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcaccomp
            
            #add-point:AFTER FIELD bcaccomp name="construct.a.bcaccomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcacsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacsite
            #add-point:ON ACTION controlp INFIELD bcacsite name="construct.c.bcacsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                       #呼叫開窗  #161019-00017#1 mark
            CALL q_ooef001_1()                     #161019-00017#1
            DISPLAY g_qryparam.return1 TO bcacsite  #顯示到畫面上
            NEXT FIELD bcacsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacsite
            #add-point:BEFORE FIELD bcacsite name="construct.b.bcacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacsite
            
            #add-point:AFTER FIELD bcacsite name="construct.a.bcacsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcacdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacdocno
            #add-point:ON ACTION controlp INFIELD bcacdocno name="construct.c.bcacdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            
            LET g_qryparam.where = ' 1=1 '
            
            IF NOT cl_null(g_slip_wc) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_slip_wc
            END IF
            
            CALL q_bcacdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcacdocno  #顯示到畫面上
            NEXT FIELD bcacdocno                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacdocno
            #add-point:BEFORE FIELD bcacdocno name="construct.b.bcacdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacdocno
            
            #add-point:AFTER FIELD bcacdocno name="construct.a.bcacdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacdocdt
            #add-point:BEFORE FIELD bcacdocdt name="construct.b.bcacdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacdocdt
            
            #add-point:AFTER FIELD bcacdocdt name="construct.a.bcacdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcacdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacdocdt
            #add-point:ON ACTION controlp INFIELD bcacdocdt name="construct.c.bcacdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcac013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac013
            #add-point:ON ACTION controlp INFIELD bcac013 name="construct.c.bcac013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcac013  #顯示到畫面上
            NEXT FIELD bcac013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac013
            #add-point:BEFORE FIELD bcac013 name="construct.b.bcac013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac013
            
            #add-point:AFTER FIELD bcac013 name="construct.a.bcac013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac014
            #add-point:ON ACTION controlp INFIELD bcac014 name="construct.c.bcac014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcac014  #顯示到畫面上
            NEXT FIELD bcac014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac014
            #add-point:BEFORE FIELD bcac014 name="construct.b.bcac014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac014
            
            #add-point:AFTER FIELD bcac014 name="construct.a.bcac014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacstus
            #add-point:BEFORE FIELD bcacstus name="construct.b.bcacstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacstus
            
            #add-point:AFTER FIELD bcacstus name="construct.a.bcacstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcacstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacstus
            #add-point:ON ACTION controlp INFIELD bcacstus name="construct.c.bcacstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcac011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac011
            #add-point:ON ACTION controlp INFIELD bcac011 name="construct.c.bcac011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            
            CALL q_bcac011()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcac011  #顯示到畫面上
            NEXT FIELD bcac011                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac011
            #add-point:BEFORE FIELD bcac011 name="construct.b.bcac011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac011
            
            #add-point:AFTER FIELD bcac011 name="construct.a.bcac011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac001
            #add-point:ON ACTION controlp INFIELD bcac001 name="construct.c.bcac001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = '1'
            
            CALL q_bcac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcac001  #顯示到畫面上
            NEXT FIELD bcac001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac001
            #add-point:BEFORE FIELD bcac001 name="construct.b.bcac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac001
            
            #add-point:AFTER FIELD bcac001 name="construct.a.bcac001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac009
            #add-point:BEFORE FIELD bcac009 name="construct.b.bcac009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac009
            
            #add-point:AFTER FIELD bcac009 name="construct.a.bcac009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac009
            #add-point:ON ACTION controlp INFIELD bcac009 name="construct.c.bcac009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac002
            #add-point:ON ACTION controlp INFIELD bcac002 name="construct.c.bcac002"
    
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcac002  #顯示到畫面上

            NEXT FIELD bcac002                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac002
            #add-point:BEFORE FIELD bcac002 name="construct.b.bcac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac002
            
            #add-point:AFTER FIELD bcac002 name="construct.a.bcac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac008
            #add-point:ON ACTION controlp INFIELD bcac008 name="construct.c.bcac008"
    
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inam002()                       #呼叫開窗
            DISPLAY g_qryparam.return2 TO bcac008  #顯示到畫面上

            NEXT FIELD bcac008                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac008
            #add-point:BEFORE FIELD bcac008 name="construct.b.bcac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac008
            
            #add-point:AFTER FIELD bcac008 name="construct.a.bcac008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac012
            #add-point:ON ACTION controlp INFIELD bcac012 name="construct.c.bcac012"

            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcac012  #顯示到畫面上

            NEXT FIELD bcac012                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac012
            #add-point:BEFORE FIELD bcac012 name="construct.b.bcac012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac012
            
            #add-point:AFTER FIELD bcac012 name="construct.a.bcac012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac003
            #add-point:BEFORE FIELD bcac003 name="construct.b.bcac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac003
            
            #add-point:AFTER FIELD bcac003 name="construct.a.bcac003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac003
            #add-point:ON ACTION controlp INFIELD bcac003 name="construct.c.bcac003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac004
            #add-point:BEFORE FIELD bcac004 name="construct.b.bcac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac004
            
            #add-point:AFTER FIELD bcac004 name="construct.a.bcac004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac004
            #add-point:ON ACTION controlp INFIELD bcac004 name="construct.c.bcac004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac005
            #add-point:BEFORE FIELD bcac005 name="construct.b.bcac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac005
            
            #add-point:AFTER FIELD bcac005 name="construct.a.bcac005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac005
            #add-point:ON ACTION controlp INFIELD bcac005 name="construct.c.bcac005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac006
            #add-point:BEFORE FIELD bcac006 name="construct.b.bcac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac006
            
            #add-point:AFTER FIELD bcac006 name="construct.a.bcac006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac006
            #add-point:ON ACTION controlp INFIELD bcac006 name="construct.c.bcac006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac007
            #add-point:BEFORE FIELD bcac007 name="construct.b.bcac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac007
            
            #add-point:AFTER FIELD bcac007 name="construct.a.bcac007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac007
            #add-point:ON ACTION controlp INFIELD bcac007 name="construct.c.bcac007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcacownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacownid
            #add-point:ON ACTION controlp INFIELD bcacownid name="construct.c.bcacownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcacownid  #顯示到畫面上
            NEXT FIELD bcacownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacownid
            #add-point:BEFORE FIELD bcacownid name="construct.b.bcacownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacownid
            
            #add-point:AFTER FIELD bcacownid name="construct.a.bcacownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcacowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacowndp
            #add-point:ON ACTION controlp INFIELD bcacowndp name="construct.c.bcacowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcacowndp  #顯示到畫面上
            NEXT FIELD bcacowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacowndp
            #add-point:BEFORE FIELD bcacowndp name="construct.b.bcacowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacowndp
            
            #add-point:AFTER FIELD bcacowndp name="construct.a.bcacowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcaccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcaccrtid
            #add-point:ON ACTION controlp INFIELD bcaccrtid name="construct.c.bcaccrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcaccrtid  #顯示到畫面上
            NEXT FIELD bcaccrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccrtid
            #add-point:BEFORE FIELD bcaccrtid name="construct.b.bcaccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcaccrtid
            
            #add-point:AFTER FIELD bcaccrtid name="construct.a.bcaccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bcaccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcaccrtdp
            #add-point:ON ACTION controlp INFIELD bcaccrtdp name="construct.c.bcaccrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcaccrtdp  #顯示到畫面上
            NEXT FIELD bcaccrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccrtdp
            #add-point:BEFORE FIELD bcaccrtdp name="construct.b.bcaccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcaccrtdp
            
            #add-point:AFTER FIELD bcaccrtdp name="construct.a.bcaccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccrtdt
            #add-point:BEFORE FIELD bcaccrtdt name="construct.b.bcaccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcacmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacmodid
            #add-point:ON ACTION controlp INFIELD bcacmodid name="construct.c.bcacmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcacmodid  #顯示到畫面上
            NEXT FIELD bcacmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacmodid
            #add-point:BEFORE FIELD bcacmodid name="construct.b.bcacmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacmodid
            
            #add-point:AFTER FIELD bcacmodid name="construct.a.bcacmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacmoddt
            #add-point:BEFORE FIELD bcacmoddt name="construct.b.bcacmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bcaccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcaccnfid
            #add-point:ON ACTION controlp INFIELD bcaccnfid name="construct.c.bcaccnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcaccnfid  #顯示到畫面上
            NEXT FIELD bcaccnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccnfid
            #add-point:BEFORE FIELD bcaccnfid name="construct.b.bcaccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcaccnfid
            
            #add-point:AFTER FIELD bcaccnfid name="construct.a.bcaccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccnfdt
            #add-point:BEFORE FIELD bcaccnfdt name="construct.b.bcaccnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bcad000,bcadsite,bcad001,bcadseq,bcad002,bcad003,bcad004,bcad008,bcad005, 
          bcad006,bcad007
           FROM s_detail1[1].bcad000,s_detail1[1].bcadsite,s_detail1[1].bcad001,s_detail1[1].bcadseq, 
               s_detail1[1].bcad002,s_detail1[1].bcad003,s_detail1[1].bcad004,s_detail1[1].bcad008,s_detail1[1].bcad005, 
               s_detail1[1].bcad006,s_detail1[1].bcad007
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad000
            #add-point:BEFORE FIELD bcad000 name="construct.b.page1.bcad000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad000
            
            #add-point:AFTER FIELD bcad000 name="construct.a.page1.bcad000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad000
            #add-point:ON ACTION controlp INFIELD bcad000 name="construct.c.page1.bcad000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcadsite
            #add-point:BEFORE FIELD bcadsite name="construct.b.page1.bcadsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcadsite
            
            #add-point:AFTER FIELD bcadsite name="construct.a.page1.bcadsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcadsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcadsite
            #add-point:ON ACTION controlp INFIELD bcadsite name="construct.c.page1.bcadsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad001
            #add-point:BEFORE FIELD bcad001 name="construct.b.page1.bcad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad001
            
            #add-point:AFTER FIELD bcad001 name="construct.a.page1.bcad001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad001
            #add-point:ON ACTION controlp INFIELD bcad001 name="construct.c.page1.bcad001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcadseq
            #add-point:BEFORE FIELD bcadseq name="construct.b.page1.bcadseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcadseq
            
            #add-point:AFTER FIELD bcadseq name="construct.a.page1.bcadseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcadseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcadseq
            #add-point:ON ACTION controlp INFIELD bcadseq name="construct.c.page1.bcadseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bcad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad002
            #add-point:ON ACTION controlp INFIELD bcad002 name="construct.c.page1.bcad002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
               
            #給予arg
            LET g_qryparam.arg1 = g_site
               
            CALL q_inaa001_4()                              #呼叫開窗
            DISPLAY g_qryparam.return1 TO bcad002  #顯示到畫面上

            NEXT FIELD bcad002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad002
            #add-point:BEFORE FIELD bcad002 name="construct.b.page1.bcad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad002
            
            #add-point:AFTER FIELD bcad002 name="construct.a.page1.bcad002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad003
            #add-point:ON ACTION controlp INFIELD bcad003 name="construct.c.page1.bcad003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE
               
            #給予arg
            LET g_qryparam.arg1 = g_site
               
            CALL q_inab002_8()                                #呼叫開窗
               
            DISPLAY g_qryparam.return1 TO bcad003  #顯示到畫面上
            
            NEXT FIELD bcad003                          #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad003
            #add-point:BEFORE FIELD bcad003 name="construct.b.page1.bcad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad003
            
            #add-point:AFTER FIELD bcad003 name="construct.a.page1.bcad003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad004
            #add-point:ON ACTION controlp INFIELD bcad004 name="construct.c.page1.bcad004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE              
              
            #給予arg
            LET g_qryparam.arg1 = g_site
              
            CALL q_inad003()                
               
            DISPLAY g_qryparam.return1 TO bcad004  #顯示到畫面上

            NEXT FIELD bcad004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad004
            #add-point:BEFORE FIELD bcad004 name="construct.b.page1.bcad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad004
            
            #add-point:AFTER FIELD bcad004 name="construct.a.page1.bcad004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad008
            #add-point:BEFORE FIELD bcad008 name="construct.b.page1.bcad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad008
            
            #add-point:AFTER FIELD bcad008 name="construct.a.page1.bcad008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad008
            #add-point:ON ACTION controlp INFIELD bcad008 name="construct.c.page1.bcad008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad005
            #add-point:BEFORE FIELD bcad005 name="construct.b.page1.bcad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad005
            
            #add-point:AFTER FIELD bcad005 name="construct.a.page1.bcad005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad005
            #add-point:ON ACTION controlp INFIELD bcad005 name="construct.c.page1.bcad005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad006
            #add-point:BEFORE FIELD bcad006 name="construct.b.page1.bcad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad006
            
            #add-point:AFTER FIELD bcad006 name="construct.a.page1.bcad006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad006
            #add-point:ON ACTION controlp INFIELD bcad006 name="construct.c.page1.bcad006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad007
            #add-point:BEFORE FIELD bcad007 name="construct.b.page1.bcad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad007
            
            #add-point:AFTER FIELD bcad007 name="construct.a.page1.bcad007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bcad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad007
            #add-point:ON ACTION controlp INFIELD bcad007 name="construct.c.page1.bcad007"
            
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
                  WHEN la_wc[li_idx].tableid = "bcac_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bcad_t" 
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
 
{<section id="abct700.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abct700_filter()
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
      CONSTRUCT g_wc_filter ON bcacdocno,bcacdocdt,bcac011,bcac001,bcac013,bcaccrtid,bcaccrtdp
                          FROM s_browse[1].b_bcacdocno,s_browse[1].b_bcacdocdt,s_browse[1].b_bcac011, 
                              s_browse[1].b_bcac001,s_browse[1].b_bcac013,s_browse[1].b_bcaccrtid,s_browse[1].b_bcaccrtdp 
 
 
         BEFORE CONSTRUCT
               DISPLAY abct700_filter_parser('bcacdocno') TO s_browse[1].b_bcacdocno
            DISPLAY abct700_filter_parser('bcacdocdt') TO s_browse[1].b_bcacdocdt
            DISPLAY abct700_filter_parser('bcac011') TO s_browse[1].b_bcac011
            DISPLAY abct700_filter_parser('bcac001') TO s_browse[1].b_bcac001
            DISPLAY abct700_filter_parser('bcac013') TO s_browse[1].b_bcac013
            DISPLAY abct700_filter_parser('bcaccrtid') TO s_browse[1].b_bcaccrtid
            DISPLAY abct700_filter_parser('bcaccrtdp') TO s_browse[1].b_bcaccrtdp
      
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
 
      CALL abct700_filter_show('bcacdocno')
   CALL abct700_filter_show('bcacdocdt')
   CALL abct700_filter_show('bcac011')
   CALL abct700_filter_show('bcac001')
   CALL abct700_filter_show('bcac013')
   CALL abct700_filter_show('bcaccrtid')
   CALL abct700_filter_show('bcaccrtdp')
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abct700_filter_parser(ps_field)
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
 
{<section id="abct700.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abct700_filter_show(ps_field)
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
   LET ls_condition = abct700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abct700_query()
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
   CALL g_bcad_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abct700_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abct700_browser_fill("")
      CALL abct700_fetch("")
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
      CALL abct700_filter_show('bcacdocno')
   CALL abct700_filter_show('bcacdocdt')
   CALL abct700_filter_show('bcac011')
   CALL abct700_filter_show('bcac001')
   CALL abct700_filter_show('bcac013')
   CALL abct700_filter_show('bcaccrtid')
   CALL abct700_filter_show('bcaccrtdp')
   CALL abct700_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abct700_fetch("F") 
      #顯示單身筆數
      CALL abct700_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abct700_fetch(p_flag)
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
   
   LET g_bcac_m.bcacdocno = g_browser[g_current_idx].b_bcacdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
       g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus, 
       g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
       g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid, 
       g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid, 
       g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc,g_bcac_m.bcacownid_desc, 
       g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcacmodid_desc, 
       g_bcac_m.bcaccnfid_desc
   
   #遮罩相關處理
   LET g_bcac_m_mask_o.* =  g_bcac_m.*
   CALL abct700_bcac_t_mask()
   LET g_bcac_m_mask_n.* =  g_bcac_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abct700_set_act_visible()   
   CALL abct700_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bcac_m_t.* = g_bcac_m.*
   LET g_bcac_m_o.* = g_bcac_m.*
   
   LET g_data_owner = g_bcac_m.bcacownid      
   LET g_data_dept  = g_bcac_m.bcacowndp
   
   #重新顯示   
   CALL abct700_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.insert" >}
#+ 資料新增
PRIVATE FUNCTION abct700_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bcad_d.clear()   
 
 
   INITIALIZE g_bcac_m.* TO NULL             #DEFAULT 設定
   
   LET g_bcacdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bcac_m.bcacownid = g_user
      LET g_bcac_m.bcacowndp = g_dept
      LET g_bcac_m.bcaccrtid = g_user
      LET g_bcac_m.bcaccrtdp = g_dept 
      LET g_bcac_m.bcaccrtdt = cl_get_current()
      LET g_bcac_m.bcacmodid = g_user
      LET g_bcac_m.bcacmoddt = cl_get_current()
      LET g_bcac_m.bcacstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bcac_m.bcac000 = "1"
      LET g_bcac_m.bcac009 = "0"
      LET g_bcac_m.bcac005 = "0"
      LET g_bcac_m.bcac006 = "0"
      LET g_bcac_m.bcac007 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_bcac_m.bcacsite = g_site
      LET g_bcac_m.bcac013  = g_user
      LET g_bcac_m.bcac014  = g_dept
      LET g_bcac_m.bcacdocdt = g_today

      CALL s_desc_get_person_desc(g_bcac_m.bcac013) RETURNING g_bcac_m.bcac013_desc
      CALL s_desc_get_department_desc(g_bcac_m.bcac014) RETURNING g_bcac_m.bcac014_desc
      DISPLAY BY NAME g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc

      SELECT ooef017 INTO g_bcac_m.bcaccomp 
        FROM ooef_t 
       WHERE ooefent = g_enterprise 
         AND ooef001 = g_site
      CALL s_desc_get_department_desc(g_bcac_m.bcaccomp) RETURNING g_bcac_m.bcaccomp_desc
      DISPLAY BY NAME g_bcac_m.bcaccomp_desc
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bcac_m_t.* = g_bcac_m.*
      LET g_bcac_m_o.* = g_bcac_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bcac_m.bcacstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL abct700_input("a")
      
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
         INITIALIZE g_bcac_m.* TO NULL
         INITIALIZE g_bcad_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abct700_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bcad_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abct700_set_act_visible()   
   CALL abct700_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bcacent = " ||g_enterprise|| " AND",
                      " bcacdocno = '", g_bcac_m.bcacdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abct700_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abct700_cl
   
   CALL abct700_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
       g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus, 
       g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
       g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid, 
       g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid, 
       g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc,g_bcac_m.bcacownid_desc, 
       g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcacmodid_desc, 
       g_bcac_m.bcaccnfid_desc
   
   
   #遮罩相關處理
   LET g_bcac_m_mask_o.* =  g_bcac_m.*
   CALL abct700_bcac_t_mask()
   LET g_bcac_m_mask_n.* =  g_bcac_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcacdocno,g_bcac_m.bcacdocno_desc,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac013_desc, 
       g_bcac_m.bcac014,g_bcac_m.bcac014_desc,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
       g_bcac_m.bcac002,g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1,g_bcac_m.bcac008,g_bcac_m.bcac008_desc, 
       g_bcac_m.bcac012,g_bcac_m.bcac012_desc,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006, 
       g_bcac_m.bcac007,g_bcac_m.bcacownid,g_bcac_m.bcacownid_desc,g_bcac_m.bcacowndp,g_bcac_m.bcacowndp_desc, 
       g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcaccrtdt, 
       g_bcac_m.bcacmodid,g_bcac_m.bcacmodid_desc,g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfid_desc, 
       g_bcac_m.bcaccnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bcac_m.bcacownid      
   LET g_data_dept  = g_bcac_m.bcacowndp
   
   #功能已完成,通報訊息中心
   CALL abct700_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.modify" >}
#+ 資料修改
PRIVATE FUNCTION abct700_modify()
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
   LET g_bcac_m_t.* = g_bcac_m.*
   LET g_bcac_m_o.* = g_bcac_m.*
   
   IF g_bcac_m.bcacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
   CALL s_transaction_begin()
   
   OPEN abct700_cl USING g_enterprise,g_bcac_m.bcacdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abct700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abct700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
       g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus, 
       g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
       g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid, 
       g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid, 
       g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc,g_bcac_m.bcacownid_desc, 
       g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcacmodid_desc, 
       g_bcac_m.bcaccnfid_desc
   
   #檢查是否允許此動作
   IF NOT abct700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bcac_m_mask_o.* =  g_bcac_m.*
   CALL abct700_bcac_t_mask()
   LET g_bcac_m_mask_n.* =  g_bcac_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL abct700_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bcac_m.bcacmodid = g_user 
LET g_bcac_m.bcacmoddt = cl_get_current()
LET g_bcac_m.bcacmodid_desc = cl_get_username(g_bcac_m.bcacmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abct700_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
 
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bcac_t SET (bcacmodid,bcacmoddt) = (g_bcac_m.bcacmodid,g_bcac_m.bcacmoddt)
          WHERE bcacent = g_enterprise AND bcacdocno = g_bcacdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bcac_m.* = g_bcac_m_t.*
            CALL abct700_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bcac_m.bcacdocno != g_bcac_m_t.bcacdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bcad_t SET bcaddocno = g_bcac_m.bcacdocno
 
          WHERE bcadent = g_enterprise AND bcaddocno = g_bcac_m_t.bcacdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bcad_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bcad_t:",SQLERRMESSAGE 
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
   CALL abct700_set_act_visible()   
   CALL abct700_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bcacent = " ||g_enterprise|| " AND",
                      " bcacdocno = '", g_bcac_m.bcacdocno, "' "
 
   #填到對應位置
   CALL abct700_browser_fill("")
 
   CLOSE abct700_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abct700_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abct700.input" >}
#+ 資料輸入
PRIVATE FUNCTION abct700_input(p_cmd)
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
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_imaa005             LIKE imaa_t.imaa005    #產品特徵
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_where               STRING
   DEFINE  l_imaf053             LIKE imaf_t.imaf053
   DEFINE  l_imaf177             LIKE imaf_t.imaf177
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"

   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'

   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcacdocno,g_bcac_m.bcacdocno_desc,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac013_desc, 
       g_bcac_m.bcac014,g_bcac_m.bcac014_desc,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
       g_bcac_m.bcac002,g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1,g_bcac_m.bcac008,g_bcac_m.bcac008_desc, 
       g_bcac_m.bcac012,g_bcac_m.bcac012_desc,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006, 
       g_bcac_m.bcac007,g_bcac_m.bcacownid,g_bcac_m.bcacownid_desc,g_bcac_m.bcacowndp,g_bcac_m.bcacowndp_desc, 
       g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcaccrtdt, 
       g_bcac_m.bcacmodid,g_bcac_m.bcacmodid_desc,g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfid_desc, 
       g_bcac_m.bcaccnfdt
   
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
   LET g_forupd_sql = "SELECT bcad000,bcadsite,bcad001,bcadseq,bcad002,bcad003,bcad004,bcad008,bcad005, 
       bcad006,bcad007 FROM bcad_t WHERE bcadent=? AND bcaddocno=? AND bcadseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abct700_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abct700_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abct700_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt, 
       g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
       g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005, 
       g_bcac_m.bcac006,g_bcac_m.bcac007
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abct700.input.head" >}
      #單頭段
      INPUT BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt, 
          g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
          g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005, 
          g_bcac_m.bcac006,g_bcac_m.bcac007 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abct700_cl USING g_enterprise,g_bcac_m.bcacdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abct700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abct700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abct700_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abct700_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac000
            #add-point:BEFORE FIELD bcac000 name="input.b.bcac000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac000
            
            #add-point:AFTER FIELD bcac000 name="input.a.bcac000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac000
            #add-point:ON CHANGE bcac000 name="input.g.bcac000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcaccomp
            
            #add-point:AFTER FIELD bcaccomp name="input.a.bcaccomp"
            LET g_bcac_m.bcaccomp_desc = ' '
            DISPLAY BY NAME g_bcac_m.bcaccomp_desc
            IF NOT cl_null(g_bcac_m.bcaccomp) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bcac_m.bcaccomp != g_bcac_m_o.bcaccomp OR g_bcac_m_o.bcaccomp IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'bcaccomp',g_bcac_m.bcaccomp,g_bcac_m.bcaccomp) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = l_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_bcac_m.bcaccomp = g_bcac_m_o.bcaccomp
                     CALL s_desc_get_department_desc(g_bcac_m.bcaccomp) RETURNING g_bcac_m.bcaccomp_desc
                     DISPLAY BY NAME g_bcac_m.bcaccomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bcac_m_o.bcaccomp = g_bcac_m.bcaccomp
            CALL s_desc_get_department_desc(g_bcac_m.bcaccomp) RETURNING g_bcac_m.bcaccomp_desc
            DISPLAY BY NAME g_bcac_m.bcaccomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcaccomp
            #add-point:BEFORE FIELD bcaccomp name="input.b.bcaccomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcaccomp
            #add-point:ON CHANGE bcaccomp name="input.g.bcaccomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacsite
            
            #add-point:AFTER FIELD bcacsite name="input.a.bcacsite"
            LET g_bcac_m.bcacsite_desc = ' '
            DISPLAY BY NAME g_bcac_m.bcacsite_desc
            IF NOT cl_null(g_bcac_m.bcacsite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bcac_m.bcacsite != g_bcac_m_o.bcacsite OR g_bcac_m_o.bcacsite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'bcacsite',g_bcac_m.bcacsite,g_bcac_m.bcacsite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = l_errno 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_bcac_m.bcacsite = g_bcac_m_o.bcacsite
                     CALL s_desc_get_department_desc(g_bcac_m.bcacsite) RETURNING g_bcac_m.bcacsite_desc
                     DISPLAY BY NAME g_bcac_m.bcacsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bcac_m_o.bcacsite = g_bcac_m.bcacsite
            CALL s_desc_get_department_desc(g_bcac_m.bcacsite) RETURNING g_bcac_m.bcacsite_desc
            DISPLAY BY NAME g_bcac_m.bcacsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacsite
            #add-point:BEFORE FIELD bcacsite name="input.b.bcacsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcacsite
            #add-point:ON CHANGE bcacsite name="input.g.bcacsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacdocno
            
            #add-point:AFTER FIELD bcacdocno name="input.a.bcacdocno"

            CALL s_aooi200_get_slip_desc(g_bcac_m.bcacdocno) RETURNING g_bcac_m.bcacdocno_desc
            DISPLAY BY NAME g_bcac_m.bcacdocno_desc
            
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF cl_null(g_bcac_m.bcacdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            ELSE
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bcac_m.bcacdocno != g_bcacdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bcac_t WHERE "||"bcacent = " ||g_enterprise|| " AND "||"bcacdocno = '"||g_bcac_m.bcacdocno ||"'",'std-00004',0) THEN 
                     LET g_bcac_m.bcacdocno = g_bcacdocno_t
                     CALL s_aooi200_get_slip_desc(g_bcac_m.bcacdocno) RETURNING g_bcac_m.bcacdocno_desc
                     DISPLAY BY NAME g_bcac_m.bcacdocno_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #檢查單別
               IF NOT s_aooi200_chk_slip(g_site,'',g_bcac_m.bcacdocno,g_prog) THEN
                  LET g_bcac_m.bcacdocno = g_bcacdocno_t
                  CALL s_aooi200_get_slip_desc(g_bcac_m.bcacdocno) RETURNING g_bcac_m.bcacdocno_desc
                  DISPLAY BY NAME g_bcac_m.bcacdocno_desc
                  NEXT FIELD CURRENT
               END IF

               #檢核輸入的單據別是否可以被key人員對應的控制組使用,'5' 為庫存控制組類型
               CALL s_control_chk_doc('1',g_bcac_m.bcacdocno,'5',g_user,g_dept,'','') RETURNING l_success,l_flag
               IF NOT l_success OR NOT l_flag THEN
                  LET g_bcac_m.bcacdocno = g_bcacdocno_t
                  CALL s_aooi200_get_slip_desc(g_bcac_m.bcacdocno) RETURNING g_bcac_m.bcacdocno_desc
                  DISPLAY BY NAME g_bcac_m.bcacdocno_desc
                  NEXT FIELD CURRENT
               END IF

               #預設欄位
               CALL abct700_deftult()
            END IF

            CALL abct700_set_entry(p_cmd)
            CALL abct700_set_no_entry(p_cmd)
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacdocno
            #add-point:BEFORE FIELD bcacdocno name="input.b.bcacdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcacdocno
            #add-point:ON CHANGE bcacdocno name="input.g.bcacdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacdocdt
            #add-point:BEFORE FIELD bcacdocdt name="input.b.bcacdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacdocdt
            
            #add-point:AFTER FIELD bcacdocdt name="input.a.bcacdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcacdocdt
            #add-point:ON CHANGE bcacdocdt name="input.g.bcacdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac013
            
            #add-point:AFTER FIELD bcac013 name="input.a.bcac013"
            CALL s_desc_get_person_desc(g_bcac_m.bcac013) RETURNING g_bcac_m.bcac013_desc
            DISPLAY BY NAME g_bcac_m.bcac013_desc

            IF NOT cl_null(g_bcac_m.bcac013) THEN
               IF g_bcac_m.bcac013 <> g_bcac_m_o.bcac013 OR cl_null(g_bcac_m_o.bcac013) THEN
               
                  IF NOT s_employee_chk(g_bcac_m.bcac013) THEN
                     LET g_bcac_m.bcac013 = g_bcac_m_o.bcac013

                     CALL s_desc_get_person_desc(g_bcac_m.bcac013) RETURNING g_bcac_m.bcac013_desc
                     DISPLAY BY NAME g_bcac_m.bcac013_desc

                     NEXT FIELD CURRENT
                  END IF            
               
                  #帶出歸屬部門ooag003
                  SELECT ooag003 INTO g_bcac_m.bcac014
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_bcac_m.bcac013
               
                  LET g_bcac_m_o.bcac014 = g_bcac_m.bcac014
                  DISPLAY BY NAME g_bcac_m.bcac014

                  CALL s_desc_get_department_desc(g_bcac_m.bcac014) RETURNING g_bcac_m.bcac014_desc
                  DISPLAY BY NAME g_bcac_m.bcac014_desc

               END IF
            END IF

            LET g_bcac_m_o.bcac013 = g_bcac_m.bcac013
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac013
            #add-point:BEFORE FIELD bcac013 name="input.b.bcac013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac013
            #add-point:ON CHANGE bcac013 name="input.g.bcac013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac014
            
            #add-point:AFTER FIELD bcac014 name="input.a.bcac014"
            CALL s_desc_get_department_desc(g_bcac_m.bcac014) RETURNING g_bcac_m.bcac014_desc
            DISPLAY BY NAME g_bcac_m.bcac014_desc

            IF NOT cl_null(g_bcac_m.bcac014) THEN 
               IF g_bcac_m.bcac014 <> g_bcac_m_o.bcac014 OR cl_null(g_bcac_m_o.bcac014) THEN

                  IF NOT s_department_chk(g_bcac_m.bcac014,g_bcac_m.bcacdocdt) THEN
                     LET g_bcac_m.bcac014 = g_bcac_m_o.bcac014

                     CALL s_desc_get_department_desc(g_bcac_m.bcac014) RETURNING g_bcac_m.bcac014_desc
                     DISPLAY BY NAME g_bcac_m.bcac014_desc

                     NEXT FIELD CURRENT
                  END IF               
               END IF
            END IF 

            LET g_bcac_m_o.bcac014 = g_bcac_m.bcac014
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac014
            #add-point:BEFORE FIELD bcac014 name="input.b.bcac014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac014
            #add-point:ON CHANGE bcac014 name="input.g.bcac014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcacstus
            #add-point:BEFORE FIELD bcacstus name="input.b.bcacstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcacstus
            
            #add-point:AFTER FIELD bcacstus name="input.a.bcacstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcacstus
            #add-point:ON CHANGE bcacstus name="input.g.bcacstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac011
            #add-point:BEFORE FIELD bcac011 name="input.b.bcac011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac011
            
            #add-point:AFTER FIELD bcac011 name="input.a.bcac011"
            IF NOT cl_null(g_bcac_m.bcac011) THEN 
               IF g_bcac_m.bcac011 <> g_bcac_m_o.bcac011 OR cl_null(g_bcac_m_o.bcac011) THEN
                  IF NOT s_abct700_barcode_chk(g_bcac_m.bcacdocno,g_bcac_m.bcac011) THEN
                     LET g_bcac_m.bcac011 = g_bcac_m_o.bcac011
                     NEXT FIELD CURRENT
                  END IF
                  
                  #依據輸入的條碼編號，帶出單頭欄位的值
                  IF NOT abct700_bcac011_bcac() THEN
                     LET g_bcac_m.bcac011 = g_bcac_m_o.bcac011
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF 
            
            LET g_bcac_m_o.bcac011 = g_bcac_m.bcac011
            
            CALL abct700_set_entry(l_cmd)
            CALL abct700_set_no_entry(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac011
            #add-point:ON CHANGE bcac011 name="input.g.bcac011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac001
            #add-point:BEFORE FIELD bcac001 name="input.b.bcac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac001
            
            #add-point:AFTER FIELD bcac001 name="input.a.bcac001"
            IF NOT cl_null(g_bcac_m.bcac001) THEN 
               IF g_bcac_m.bcac001 <> g_bcac_m_o.bcac001 OR cl_null(g_bcac_m_o.bcac001) THEN
                  IF g_bcac_m.bcac001 <> g_bcac_m.bcac011 THEN
                     IF NOT s_abct700_barcode_chk(g_bcac_m.bcacdocno,g_bcac_m.bcac001) THEN
                        LET g_bcac_m.bcac001 = g_bcac_m_o.bcac001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            LET g_bcac_m_o.bcac001 = g_bcac_m.bcac001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac001
            #add-point:ON CHANGE bcac001 name="input.g.bcac001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bcac_m.bcac009,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bcac009
            END IF 
 
 
 
            #add-point:AFTER FIELD bcac009 name="input.a.bcac009"
            IF NOT cl_null(g_bcac_m.bcac009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac009
            #add-point:BEFORE FIELD bcac009 name="input.b.bcac009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac009
            #add-point:ON CHANGE bcac009 name="input.g.bcac009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac002
            
            #add-point:AFTER FIELD bcac002 name="input.a.bcac002"
            CALL s_desc_get_item_desc(g_bcac_m.bcac002)RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
            DISPLAY BY NAME g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
            
            IF NOT cl_null(g_bcac_m.bcac002) THEN
               IF g_bcac_m.bcac002 <> g_bcac_m_o.bcac002 OR cl_null(g_bcac_m_o.bcac002) THEN

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL              
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bcac_m.bcac002
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_imaf001_14") THEN
                     LET g_bcac_m.bcac002 = g_bcac_m_o.bcac002
                     CALL s_desc_get_item_desc(g_bcac_m.bcac002)
                     RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                     DISPLAY BY NAME g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                     
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核輸入的料件的生命週期是否在單據別限制範圍內
                  CALL s_control_chk_doc('4',g_bcac_m.bcacdocno,g_bcac_m.bcac002,'','','','')
                  RETURNING l_success,l_flag
                  
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_bcac_m.bcac002 = g_bcac_m_o.bcac002
                     CALL s_desc_get_item_desc(g_bcac_m.bcac002)
                     RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                     DISPLAY BY NAME g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                     
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢核輸入的料件的產品分類是否在單據別限制範圍內
                  CALL s_control_chk_doc('5',g_bcac_m.bcacdocno,g_bcac_m.bcac002,'','','','')
                  RETURNING l_success,l_flag
                  
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_bcac_m.bcac002 = g_bcac_m_o.bcac002
                     CALL s_desc_get_item_desc(g_bcac_m.bcac002)
                     RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                     DISPLAY BY NAME g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                     
                     NEXT FIELD CURRENT
                  END IF
                  
                  #預帶單位，條碼管理
                  SELECT imaf053,imaf177 INTO l_imaf053,l_imaf177
                    FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = g_bcac_m.bcac002
                  
                  #不考慮條碼設定
                  #IF l_imaf177 = 'N' OR cl_null(l_imaf177) THEN
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = ""
                  #   LET g_errparam.code   = "abc-00014"    #料號未使用條碼管理，請重新輸入！
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   
                  #   LET g_bcac_m.bcac002 = g_bcac_m_o.bcac002
                  #   CALL s_desc_get_item_desc(g_bcac_m.bcac002)
                  #   RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                  #   DISPLAY BY NAME g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
                  #   
                  #   NEXT FIELD CURRENT                     
                  #END IF
                  
                  LET g_bcac_m.bcac012 = l_imaf053
                     
                  CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
                  LET g_bcac_m_o.bcac012 = g_bcac_m.bcac012
                  DISPLAY BY NAME g_bcac_m.bcac012,g_bcac_m.bcac012_desc
                  
                  #判斷料件是否存在產品特徵
                  CALL s_axmt500_get_imaa005(g_enterprise,g_bcac_m.bcac002) RETURNING l_imaa005
                  IF cl_null(l_imaa005) THEN
                     LET g_bcac_m.bcac008 = ' '
                  ELSE
                     LET g_bcac_m.bcac008 = ''
                  END IF
                  
                  CALL s_feature_description(g_bcac_m.bcac002,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
                  LET g_bcac_m_o.bcac008 = g_bcac_m.bcac008
                  DISPLAY BY NAME g_bcac_m.bcac008,g_bcac_m.bcac008_desc
                  
               END IF
            END IF

            LET g_bcac_m_o.bcac002 = g_bcac_m.bcac002

            CALL abct700_set_entry(p_cmd)
            CALL abct700_set_no_entry(p_cmd)
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac002
            #add-point:BEFORE FIELD bcac002 name="input.b.bcac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac002
            #add-point:ON CHANGE bcac002 name="input.g.bcac002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac008
            
            #add-point:AFTER FIELD bcac008 name="input.a.bcac008"

            CALL s_feature_description(g_bcac_m.bcac002 ,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
            DISPLAY BY NAME g_bcac_m.bcac008_desc
            
            #必須先輸入料號
            IF cl_null(g_bcac_m.bcac002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00229'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bcac_m.bcac008 = ''
               LET g_bcac_m_o.bcac008 = g_bcac_m.bcac008
               CALL s_feature_description(g_bcac_m.bcac002 ,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
               DISPLAY BY NAME g_bcac_m.bcac008,g_bcac_m.bcac008_desc
               
               NEXT FIELD CURRENT
            END IF

            #取得產品特徵
            CALL s_axmt500_get_imaa005(g_enterprise,g_bcac_m.bcac002) RETURNING l_imaa005
             
            IF NOT cl_null(l_imaa005) THEN
               #產品特徵檢查
               IF NOT cl_null(g_bcac_m.bcac008) THEN
                  IF NOT s_feature_check (g_bcac_m.bcac002,g_bcac_m.bcac008) THEN
                     LET g_bcac_m.bcac008 = ''
                     LET g_bcac_m_o.bcac008 = g_bcac_m.bcac008
                     CALL s_feature_description(g_bcac_m.bcac002 ,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
                     DISPLAY BY NAME g_bcac_m.bcac008,g_bcac_m.bcac008_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
             
            ELSE   #無使用產品特徵
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00121'
               LET g_errparam.extend = g_bcac_m.bcac002 
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET g_bcac_m.bcac008 = ' '
               LET g_bcac_m_o.bcac008 = g_bcac_m.bcac008
               CALL s_feature_description(g_bcac_m.bcac002 ,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
               DISPLAY BY NAME g_bcac_m.bcac008,g_bcac_m.bcac008_desc
               
               NEXT FIELD CURRENT
            END IF

            LET g_bcac_m_o.bcac008 = g_bcac_m.bcac008
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac008
            #add-point:BEFORE FIELD bcac008 name="input.b.bcac008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac008
            #add-point:ON CHANGE bcac008 name="input.g.bcac008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac012
            
            #add-point:AFTER FIELD bcac012 name="input.a.bcac012"

            CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
            DISPLAY BY NAME g_bcac_m.bcac012_desc

            #必須先輸入料號
            IF cl_null(g_bcac_m.bcac002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00229'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_bcac_m.bcac012 = ''
               LET g_bcac_m_o.bcac012 = g_bcac_m.bcac012
               CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
               DISPLAY BY NAME g_bcac_m.bcac012_desc
               
               NEXT FIELD CURRENT
            END IF

            IF NOT cl_null(g_bcac_m.bcac012) THEN
               IF g_bcac_m.bcac012 <> g_bcac_m_o.bcac012 OR cl_null(g_bcac_m_o.bcac012) THEN
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bcac_m.bcac002
                  LET g_chkparam.arg2 = g_bcac_m.bcac012
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_bcac_m.bcac012 = g_bcac_m_o.bcac012
                     CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
                     DISPLAY BY NAME g_bcac_m.bcac012_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
              
            END IF

            LET g_bcac_m_o.bcac012 = g_bcac_m.bcac012
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac012
            #add-point:BEFORE FIELD bcac012 name="input.b.bcac012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac012
            #add-point:ON CHANGE bcac012 name="input.g.bcac012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac003
            #add-point:BEFORE FIELD bcac003 name="input.b.bcac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac003
            
            #add-point:AFTER FIELD bcac003 name="input.a.bcac003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac003
            #add-point:ON CHANGE bcac003 name="input.g.bcac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac004
            #add-point:BEFORE FIELD bcac004 name="input.b.bcac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac004
            
            #add-point:AFTER FIELD bcac004 name="input.a.bcac004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac004
            #add-point:ON CHANGE bcac004 name="input.g.bcac004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac005
            #add-point:BEFORE FIELD bcac005 name="input.b.bcac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac005
            
            #add-point:AFTER FIELD bcac005 name="input.a.bcac005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac005
            #add-point:ON CHANGE bcac005 name="input.g.bcac005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac006
            #add-point:BEFORE FIELD bcac006 name="input.b.bcac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac006
            
            #add-point:AFTER FIELD bcac006 name="input.a.bcac006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac006
            #add-point:ON CHANGE bcac006 name="input.g.bcac006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcac007
            #add-point:BEFORE FIELD bcac007 name="input.b.bcac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcac007
            
            #add-point:AFTER FIELD bcac007 name="input.a.bcac007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcac007
            #add-point:ON CHANGE bcac007 name="input.g.bcac007"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bcac000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac000
            #add-point:ON ACTION controlp INFIELD bcac000 name="input.c.bcac000"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcaccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcaccomp
            #add-point:ON ACTION controlp INFIELD bcaccomp name="input.c.bcaccomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcacsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacsite
            #add-point:ON ACTION controlp INFIELD bcacsite name="input.c.bcacsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcacdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacdocno
            #add-point:ON ACTION controlp INFIELD bcacdocno name="input.c.bcacdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bcac_m.bcacdocno             #給予default值
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog

            CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_where
            IF NOT l_success THEN
               LET l_success = TRUE
               LET l_where = " 1=1 "
            END IF

            IF l_success THEN
               LET g_qryparam.where = l_where
               CALL q_ooba002_1()                                #呼叫開窗
               LET g_bcac_m.bcacdocno = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_bcac_m.bcacdocno TO bcacdocno              #顯示到畫面上
            END IF
            
            CALL s_aooi200_get_slip_desc(g_bcac_m.bcacdocno) RETURNING g_bcac_m.bcacdocno_desc
            DISPLAY BY NAME g_bcac_m.bcacdocno,g_bcac_m.bcacdocno_desc

            NEXT FIELD bcacdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bcacdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacdocdt
            #add-point:ON ACTION controlp INFIELD bcacdocdt name="input.c.bcacdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac013
            #add-point:ON ACTION controlp INFIELD bcac013 name="input.c.bcac013"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bcac_m.bcac013             #給予default值

            LET g_qryparam.where = " ooag004 ='",g_site,"'"

            CALL q_ooag001()                                #呼叫開窗

            LET g_bcac_m.bcac013 = g_qryparam.return1              

            DISPLAY g_bcac_m.bcac013 TO bcac013              #
            CALL s_desc_get_person_desc(g_bcac_m.bcac013) RETURNING g_bcac_m.bcac013_desc
            DISPLAY BY NAME g_bcac_m.bcac013_desc
            
            NEXT FIELD bcac013                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bcac014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac014
            #add-point:ON ACTION controlp INFIELD bcac014 name="input.c.bcac014"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bcac_m.bcac014             #給予default值
            
            #給予arg
            IF NOT cl_null(g_bcac_m.bcacdocdt) THEN
               LET g_qryparam.arg1 = g_bcac_m.bcacdocdt
            ELSE
               LET g_qryparam.arg1 = g_today
            END IF

            LET g_qryparam.where = " EXISTS (SELECT 1 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef001 ='",g_site,"' AND ooef017 = ooeg009 )"

            CALL q_ooeg001()                                #呼叫開窗

            LET g_bcac_m.bcac014 = g_qryparam.return1              
            DISPLAY g_bcac_m.bcac014 TO bcac014              #
            CALL s_desc_get_department_desc(g_bcac_m.bcac014) RETURNING g_bcac_m.bcac014_desc
            DISPLAY BY NAME g_bcac_m.bcac014_desc
            NEXT FIELD bcac014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bcacstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcacstus
            #add-point:ON ACTION controlp INFIELD bcacstus name="input.c.bcacstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac011
            #add-point:ON ACTION controlp INFIELD bcac011 name="input.c.bcac011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bcac_m.bcac011             #給予default值

            CALL q_bcaa001()                                #呼叫開窗

            LET g_bcac_m.bcac011 = g_qryparam.return1              
            DISPLAY g_bcac_m.bcac011 TO bcac011              #

            NEXT FIELD bcac011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bcac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac001
            #add-point:ON ACTION controlp INFIELD bcac001 name="input.c.bcac001"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
               
            LET g_qryparam.default1 = g_bcac_m.bcac001             #給予default值

            CALL q_bcaa001()                              #呼叫開窗
         
            LET g_bcac_m.bcac001 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_bcac_m.bcac001 TO bcac001
            
            NEXT FIELD bcac001 
            #END add-point
 
 
         #Ctrlp:input.c.bcac009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac009
            #add-point:ON ACTION controlp INFIELD bcac009 name="input.c.bcac009"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac002
            #add-point:ON ACTION controlp INFIELD bcac002 name="input.c.bcac002"

            #開窗i段                        
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bcac_m.bcac002             #給予default值
            
            #不考慮條碼設定
            #LET g_qryparam.where = " imaf177 = 'Y'"

            CALL s_control_get_doc_sql('imaf001',g_bcac_m.bcacdocno,'4') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_where
            END IF

            CALL s_control_get_doc_sql('imaf001',g_bcac_m.bcacdocno,'5') RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_where
            END IF

            CALL q_imaf001_15()                                #呼叫開窗

            LET g_bcac_m.bcac002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bcac_m.bcac002 TO bcac002              #顯示到畫面上

            CALL s_desc_get_item_desc(g_bcac_m.bcac002) RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
            DISPLAY BY NAME g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1

            NEXT FIELD bcac002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bcac008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac008
            #add-point:ON ACTION controlp INFIELD bcac008 name="input.c.bcac008"

            #開窗i段                                                                                                
            #必須先輸入料號            
            IF NOT cl_null(g_bcac_m.bcac002) THEN

               #取得產品特徵
               CALL s_axmt500_get_imaa005(g_enterprise,g_bcac_m.bcac002) RETURNING l_imaa005

               IF NOT cl_null(l_imaa005) THEN
                  CALL s_feature_single(g_bcac_m.bcac002 ,g_bcac_m.bcac008,g_site,g_bcac_m.bcacdocno)
                  RETURNING l_success,g_bcac_m.bcac008
                   
                  DISPLAY BY NAME g_bcac_m.bcac008

               ELSE   #無使用產品特徵
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00121'
                  LET g_errparam.extend = g_bcac_m.bcac002 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF

            ELSE      #未輸入料號
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00229'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF

            CALL s_feature_description(g_bcac_m.bcac002 ,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
            DISPLAY BY NAME g_bcac_m.bcac008

            NEXT FIELD bcac008                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bcac012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac012
            #add-point:ON ACTION controlp INFIELD bcac012 name="input.c.bcac012"

            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg1 = g_bcac_m.bcac002

            LET g_qryparam.default1 = g_bcac_m.bcac012             #給予default值

            CALL q_imao002()                                #呼叫開窗

            LET g_bcac_m.bcac012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_bcac_m.bcac012 TO bcac012              #顯示到畫面上

            CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
            DISPLAY BY NAME g_bcac_m.bcac012_desc

            NEXT FIELD bcac012                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bcac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac003
            #add-point:ON ACTION controlp INFIELD bcac003 name="input.c.bcac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac004
            #add-point:ON ACTION controlp INFIELD bcac004 name="input.c.bcac004"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac005
            #add-point:ON ACTION controlp INFIELD bcac005 name="input.c.bcac005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac006
            #add-point:ON ACTION controlp INFIELD bcac006 name="input.c.bcac006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bcac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcac007
            #add-point:ON ACTION controlp INFIELD bcac007 name="input.c.bcac007"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bcac_m.bcacdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #自動產生單號
               CALL s_aooi200_gen_docno(g_site,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_prog) RETURNING l_flag,g_bcac_m.bcacdocno
               IF NOT l_flag THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_bcac_m.bcacdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD bcacdocno
               END IF
               #end add-point
               
               INSERT INTO bcac_t (bcacent,bcac000,bcaccomp,bcacsite,bcacdocno,bcacdocdt,bcac013,bcac014, 
                   bcacstus,bcac011,bcac001,bcac009,bcac002,bcac008,bcac012,bcac003,bcac004,bcac005, 
                   bcac006,bcac007,bcacownid,bcacowndp,bcaccrtid,bcaccrtdp,bcaccrtdt,bcacmodid,bcacmoddt, 
                   bcaccnfid,bcaccnfdt)
               VALUES (g_enterprise,g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcacsite,g_bcac_m.bcacdocno, 
                   g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus,g_bcac_m.bcac011, 
                   g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
                   g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007, 
                   g_bcac_m.bcacownid,g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt, 
                   g_bcac_m.bcacmodid,g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bcac_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"

               #依據輸入的條碼編號，帶出單身欄位的值
               IF NOT abct700_bcac011_bcad() THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF

               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abct700_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abct700_b_fill()
                  CALL abct700_b_fill2('0')
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
               CALL abct700_bcac_t_mask_restore('restore_mask_o')
               
               UPDATE bcac_t SET (bcac000,bcaccomp,bcacsite,bcacdocno,bcacdocdt,bcac013,bcac014,bcacstus, 
                   bcac011,bcac001,bcac009,bcac002,bcac008,bcac012,bcac003,bcac004,bcac005,bcac006,bcac007, 
                   bcacownid,bcacowndp,bcaccrtid,bcaccrtdp,bcaccrtdt,bcacmodid,bcacmoddt,bcaccnfid,bcaccnfdt) = (g_bcac_m.bcac000, 
                   g_bcac_m.bcaccomp,g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013, 
                   g_bcac_m.bcac014,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
                   g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012,g_bcac_m.bcac003,g_bcac_m.bcac004, 
                   g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid,g_bcac_m.bcacowndp, 
                   g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid,g_bcac_m.bcacmoddt, 
                   g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt)
                WHERE bcacent = g_enterprise AND bcacdocno = g_bcacdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bcac_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
 
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abct700_bcac_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bcac_m_t)
               LET g_log2 = util.JSON.stringify(g_bcac_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abct700.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bcad_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bcad_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abct700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bcad_d.getLength()
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
            OPEN abct700_cl USING g_enterprise,g_bcac_m.bcacdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abct700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abct700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bcad_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bcad_d[l_ac].bcadseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bcad_d_t.* = g_bcad_d[l_ac].*  #BACKUP
               LET g_bcad_d_o.* = g_bcad_d[l_ac].*  #BACKUP
               CALL abct700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abct700_set_no_entry_b(l_cmd)
               IF NOT abct700_lock_b("bcad_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abct700_bcl INTO g_bcad_d[l_ac].bcad000,g_bcad_d[l_ac].bcadsite,g_bcad_d[l_ac].bcad001, 
                      g_bcad_d[l_ac].bcadseq,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003,g_bcad_d[l_ac].bcad004, 
                      g_bcad_d[l_ac].bcad008,g_bcad_d[l_ac].bcad005,g_bcad_d[l_ac].bcad006,g_bcad_d[l_ac].bcad007 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bcad_d_t.bcadseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bcad_d_mask_o[l_ac].* =  g_bcad_d[l_ac].*
                  CALL abct700_bcad_t_mask()
                  LET g_bcad_d_mask_n[l_ac].* =  g_bcad_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abct700_show()
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
            INITIALIZE g_bcad_d[l_ac].* TO NULL 
            INITIALIZE g_bcad_d_t.* TO NULL 
            INITIALIZE g_bcad_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_bcad_d[l_ac].bcad000 = "1"
      LET g_bcad_d[l_ac].bcadseq = "0"
      LET g_bcad_d[l_ac].bcad007 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(bcadseq)+1
              INTO g_bcad_d[l_ac].bcadseq
              FROM bcad_t
             WHERE bcadent = g_enterprise
               AND bcaddocno = g_bcac_m.bcacdocno
               
            IF cl_null(g_bcad_d[l_ac].bcadseq) THEN
               LET g_bcad_d[l_ac].bcadseq = 1
            END IF
            
            LET g_bcad_d[l_ac].bcadsite = g_bcac_m.bcacsite
            LET g_bcad_d[l_ac].bcad001 = g_bcac_m.bcac011
            LET g_bcad_d[l_ac].bcad007 = g_bcac_m.bcac009
            
            IF NOT cl_null(g_bcac_m.bcac011) THEN
               SELECT bcaa013
                 INTO g_bcad_d[l_ac].bcad004
                 FROM bcaa_t
                WHERE bcaaent = g_enterprise
                  AND bcaasite = g_site
                  AND bcaa001 = g_bcac_m.bcac011
                  AND bcaastus = 'Y'
            END IF
            
            #end add-point
            LET g_bcad_d_t.* = g_bcad_d[l_ac].*     #新輸入資料
            LET g_bcad_d_o.* = g_bcad_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abct700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abct700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bcad_d[li_reproduce_target].* = g_bcad_d[li_reproduce].*
 
               LET g_bcad_d[li_reproduce_target].bcadseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bcad_t 
             WHERE bcadent = g_enterprise AND bcaddocno = g_bcac_m.bcacdocno
 
               AND bcadseq = g_bcad_d[l_ac].bcadseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_bcad_d[g_detail_idx].bcad003) THEN
                  LET g_bcad_d[g_detail_idx].bcad003 = ' '
               END IF
               
               IF cl_null(g_bcad_d[g_detail_idx].bcad004) THEN
                  LET g_bcad_d[g_detail_idx].bcad004 = ' '
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bcac_m.bcacdocno
               LET gs_keys[2] = g_bcad_d[g_detail_idx].bcadseq
               CALL abct700_insert_b('bcad_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bcad_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bcad_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abct700_b_fill()
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

               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt
                 FROM bcab_t
                WHERE bcabent = g_enterprise
                  AND bcab000 = g_bcad_d[g_detail_idx].bcad000
                  AND bcab001 = g_bcad_d[g_detail_idx].bcad001
                  AND bcab002 = COALESCE(g_bcad_d[g_detail_idx].bcad002,' ')
                  AND bcab003 = COALESCE(g_bcad_d[g_detail_idx].bcad003,' ')
                  AND bcab004 = COALESCE(g_bcad_d[g_detail_idx].bcad004,' ')
                  AND bcab008 = COALESCE(g_bcad_d[g_detail_idx].bcad008,' ')
                  AND bcab007 <> 0
                  
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'abc-00016'  #該條碼庫存數量不為零，不可刪除！
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE                  
               END IF
                  
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
               LET gs_keys[01] = g_bcac_m.bcacdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_bcad_d_t.bcadseq
 
            
               #刪除同層單身
               IF NOT abct700_delete_b('bcad_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abct700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abct700_key_delete_b(gs_keys,'bcad_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abct700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abct700_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bcad_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bcad_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad000
            #add-point:BEFORE FIELD bcad000 name="input.b.page1.bcad000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad000
            
            #add-point:AFTER FIELD bcad000 name="input.a.page1.bcad000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad000
            #add-point:ON CHANGE bcad000 name="input.g.page1.bcad000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcadsite
            #add-point:BEFORE FIELD bcadsite name="input.b.page1.bcadsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcadsite
            
            #add-point:AFTER FIELD bcadsite name="input.a.page1.bcadsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcadsite
            #add-point:ON CHANGE bcadsite name="input.g.page1.bcadsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad001
            #add-point:BEFORE FIELD bcad001 name="input.b.page1.bcad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad001
            
            #add-point:AFTER FIELD bcad001 name="input.a.page1.bcad001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad001
            #add-point:ON CHANGE bcad001 name="input.g.page1.bcad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcadseq
            #add-point:BEFORE FIELD bcadseq name="input.b.page1.bcadseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcadseq
            
            #add-point:AFTER FIELD bcadseq name="input.a.page1.bcadseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_bcac_m.bcacdocno IS NOT NULL AND g_bcad_d[g_detail_idx].bcadseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bcac_m.bcacdocno != g_bcacdocno_t OR g_bcad_d[g_detail_idx].bcadseq != g_bcad_d_t.bcadseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bcad_t WHERE "||"bcadent = '" ||g_enterprise|| "' AND "||"bcaddocno = '"||g_bcac_m.bcacdocno ||"' AND "|| "bcadseq = '"||g_bcad_d[g_detail_idx].bcadseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcadseq
            #add-point:ON CHANGE bcadseq name="input.g.page1.bcadseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad002
            
            #add-point:AFTER FIELD bcad002 name="input.a.page1.bcad002"
            IF NOT cl_null(g_bcad_d[l_ac].bcad002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bcad_d[l_ac].bcad002 != g_bcad_d_o.bcad002 OR g_bcad_d_o.bcad002 IS NULL)) THEN 
   #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
   
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bcad_d[l_ac].bcadsite
                  LET g_chkparam.arg2 = g_bcad_d[l_ac].bcad002
                  #160318-00025#18  by 07900 --add-str                 
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#18  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_bcad_d[l_ac].bcad002 = g_bcad_d_o.bcad002
                     CALL s_desc_get_stock_desc(g_bcad_d[l_ac].bcadsite,g_bcad_d[l_ac].bcad002) RETURNING g_bcad_d[l_ac].bcad002_desc
                     DISPLAY BY NAME g_bcad_d[l_ac].bcad002_desc
                     NEXT FIELD CURRENT
                  END IF                  
                  
                  #檢查儲位
                  IF NOT abct700_bcad003_chk() THEN
                     LET g_bcad_d[l_ac].bcad002 = g_bcad_d_o.bcad002
                     CALL s_desc_get_stock_desc(g_bcad_d[l_ac].bcadsite,g_bcad_d[l_ac].bcad002) RETURNING g_bcad_d[l_ac].bcad002_desc
                     DISPLAY BY NAME g_bcad_d[l_ac].bcad002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_bcad_d_o.bcad002 = g_bcad_d[l_ac].bcad002
            CALL s_desc_get_stock_desc(g_bcad_d[l_ac].bcadsite,g_bcad_d[l_ac].bcad002) RETURNING g_bcad_d[l_ac].bcad002_desc
            DISPLAY BY NAME g_bcad_d[l_ac].bcad002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad002
            #add-point:BEFORE FIELD bcad002 name="input.b.page1.bcad002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad002
            #add-point:ON CHANGE bcad002 name="input.g.page1.bcad002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad003
            
            #add-point:AFTER FIELD bcad003 name="input.a.page1.bcad003"
            IF NOT cl_null(g_bcad_d[l_ac].bcad003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bcad_d[l_ac].bcad003 != g_bcad_d_o.bcad003 OR g_bcad_d_o.bcad003 IS NULL)) THEN 
   #應用 a17 樣板自動產生(Version:2)
                  IF NOT abct700_bcad003_chk() THEN
                     LET g_bcad_d[l_ac].bcad003 = g_bcad_d_o.bcad003                  
                     CALL s_desc_get_locator_desc(g_bcad_d[l_ac].bcadsite,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003) RETURNING g_bcad_d[l_ac].bcad003_desc                  
                     NEXT FIELD bcad003
                  END IF                
               END IF
            END IF 
            LET g_bcad_d_o.bcad003 = g_bcad_d[l_ac].bcad003
            CALL s_desc_get_locator_desc(g_bcad_d[l_ac].bcadsite,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003) RETURNING g_bcad_d[l_ac].bcad003_desc
            DISPLAY BY NAME g_bcad_d[l_ac].bcad003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad003
            #add-point:BEFORE FIELD bcad003 name="input.b.page1.bcad003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad003
            #add-point:ON CHANGE bcad003 name="input.g.page1.bcad003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad004
            #add-point:BEFORE FIELD bcad004 name="input.b.page1.bcad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad004
            
            #add-point:AFTER FIELD bcad004 name="input.a.page1.bcad004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad004
            #add-point:ON CHANGE bcad004 name="input.g.page1.bcad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad008
            #add-point:BEFORE FIELD bcad008 name="input.b.page1.bcad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad008
            
            #add-point:AFTER FIELD bcad008 name="input.a.page1.bcad008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad008
            #add-point:ON CHANGE bcad008 name="input.g.page1.bcad008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad005
            #add-point:BEFORE FIELD bcad005 name="input.b.page1.bcad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad005
            
            #add-point:AFTER FIELD bcad005 name="input.a.page1.bcad005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad005
            #add-point:ON CHANGE bcad005 name="input.g.page1.bcad005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad006
            #add-point:BEFORE FIELD bcad006 name="input.b.page1.bcad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad006
            
            #add-point:AFTER FIELD bcad006 name="input.a.page1.bcad006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad006
            #add-point:ON CHANGE bcad006 name="input.g.page1.bcad006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bcad007
            #add-point:BEFORE FIELD bcad007 name="input.b.page1.bcad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bcad007
            
            #add-point:AFTER FIELD bcad007 name="input.a.page1.bcad007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bcad007
            #add-point:ON CHANGE bcad007 name="input.g.page1.bcad007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bcad000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad000
            #add-point:ON ACTION controlp INFIELD bcad000 name="input.c.page1.bcad000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcadsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcadsite
            #add-point:ON ACTION controlp INFIELD bcadsite name="input.c.page1.bcadsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad001
            #add-point:ON ACTION controlp INFIELD bcad001 name="input.c.page1.bcad001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcadseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcadseq
            #add-point:ON ACTION controlp INFIELD bcadseq name="input.c.page1.bcadseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad002
            #add-point:ON ACTION controlp INFIELD bcad002 name="input.c.page1.bcad002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
               
            LET g_qryparam.default1 = g_bcad_d[l_ac].bcad002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_bcac_m.bcacsite

         
            CALL q_inaa001_4()                              #呼叫開窗
         
            LET g_bcad_d[l_ac].bcad002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_bcad_d[l_ac].bcad002 TO bcad002
            
            CALL s_desc_get_stock_desc(g_bcac_m.bcacsite,g_bcad_d[l_ac].bcad002) RETURNING g_bcad_d[l_ac].bcad002_desc
            CALL s_desc_get_locator_desc(g_bcac_m.bcacsite,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003) RETURNING g_bcad_d[l_ac].bcad003_desc
            NEXT FIELD bcad002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad003
            #add-point:ON ACTION controlp INFIELD bcad003 name="input.c.page1.bcad003"
            IF cl_null(g_bcad_d[l_ac].bcad002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00126'   #庫位不可為空
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD xmdl014
            END IF
            
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
               
            LET g_qryparam.default1 = g_bcad_d[l_ac].bcad003  #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_bcac_m.bcacsite
            LET g_qryparam.arg2 = g_bcad_d[l_ac].bcad002
               
            CALL q_inab002_8()                                #呼叫開窗
               
            LET g_bcad_d[l_ac].bcad003 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_bcad_d[l_ac].bcad003 TO bcad003
            
            CALL s_desc_get_locator_desc(g_bcac_m.bcacsite,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003) RETURNING g_bcad_d[l_ac].bcad003_desc
            NEXT FIELD bcad003 
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad004
            #add-point:ON ACTION controlp INFIELD bcad004 name="input.c.page1.bcad004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
              
            LET g_qryparam.default1 = g_bcad_d[l_ac].bcad004             #給予default值
              
            #給予arg
            LET g_qryparam.arg1 = g_bcac_m.bcacsite
            LET g_qryparam.arg2 = g_bcac_m.bcac002
            LET g_qryparam.arg3 = g_bcac_m.bcac008
              
            CALL q_inad003()                                #呼叫開窗

            LET g_bcad_d[l_ac].bcad004 = g_qryparam.return1              

            DISPLAY g_bcad_d[l_ac].bcad004 TO bcad004              #

            NEXT FIELD bcad004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad008
            #add-point:ON ACTION controlp INFIELD bcad008 name="input.c.page1.bcad008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad005
            #add-point:ON ACTION controlp INFIELD bcad005 name="input.c.page1.bcad005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad006
            #add-point:ON ACTION controlp INFIELD bcad006 name="input.c.page1.bcad006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bcad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bcad007
            #add-point:ON ACTION controlp INFIELD bcad007 name="input.c.page1.bcad007"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bcad_d[l_ac].* = g_bcad_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abct700_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bcad_d[l_ac].bcadseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bcad_d[l_ac].* = g_bcad_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abct700_bcad_t_mask_restore('restore_mask_o')
      
               UPDATE bcad_t SET (bcaddocno,bcad000,bcadsite,bcad001,bcadseq,bcad002,bcad003,bcad004, 
                   bcad008,bcad005,bcad006,bcad007) = (g_bcac_m.bcacdocno,g_bcad_d[l_ac].bcad000,g_bcad_d[l_ac].bcadsite, 
                   g_bcad_d[l_ac].bcad001,g_bcad_d[l_ac].bcadseq,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003, 
                   g_bcad_d[l_ac].bcad004,g_bcad_d[l_ac].bcad008,g_bcad_d[l_ac].bcad005,g_bcad_d[l_ac].bcad006, 
                   g_bcad_d[l_ac].bcad007)
                WHERE bcadent = g_enterprise AND bcaddocno = g_bcac_m.bcacdocno 
 
                  AND bcadseq = g_bcad_d_t.bcadseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bcad_d[l_ac].* = g_bcad_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bcad_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bcad_d[l_ac].* = g_bcad_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bcad_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bcac_m.bcacdocno
               LET gs_keys_bak[1] = g_bcacdocno_t
               LET gs_keys[2] = g_bcad_d[g_detail_idx].bcadseq
               LET gs_keys_bak[2] = g_bcad_d_t.bcadseq
               CALL abct700_update_b('bcad_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abct700_bcad_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bcad_d[g_detail_idx].bcadseq = g_bcad_d_t.bcadseq 
 
                  ) THEN
                  LET gs_keys[01] = g_bcac_m.bcacdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bcad_d_t.bcadseq
 
                  CALL abct700_key_update_b(gs_keys,'bcad_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bcac_m),util.JSON.stringify(g_bcad_d_t)
               LET g_log2 = util.JSON.stringify(g_bcac_m),util.JSON.stringify(g_bcad_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abct700_unlock_b("bcad_t","'1'")
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
               LET g_bcad_d[li_reproduce_target].* = g_bcad_d[li_reproduce].*
 
               LET g_bcad_d[li_reproduce_target].bcadseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bcad_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bcad_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="abct700.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD bcacdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bcad000
 
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
 
{<section id="abct700.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abct700_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abct700_b_fill() #單身填充
      CALL abct700_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abct700_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_bcac_m_mask_o.* =  g_bcac_m.*
   CALL abct700_bcac_t_mask()
   LET g_bcac_m_mask_n.* =  g_bcac_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcacdocno,g_bcac_m.bcacdocno_desc,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac013_desc, 
       g_bcac_m.bcac014,g_bcac_m.bcac014_desc,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
       g_bcac_m.bcac002,g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1,g_bcac_m.bcac008,g_bcac_m.bcac008_desc, 
       g_bcac_m.bcac012,g_bcac_m.bcac012_desc,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006, 
       g_bcac_m.bcac007,g_bcac_m.bcacownid,g_bcac_m.bcacownid_desc,g_bcac_m.bcacowndp,g_bcac_m.bcacowndp_desc, 
       g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcaccrtdt, 
       g_bcac_m.bcacmodid,g_bcac_m.bcacmodid_desc,g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfid_desc, 
       g_bcac_m.bcaccnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bcac_m.bcacstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bcad_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abct700_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abct700_detail_show()
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
 
{<section id="abct700.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abct700_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bcac_t.bcacdocno 
   DEFINE l_oldno     LIKE bcac_t.bcacdocno 
 
   DEFINE l_master    RECORD LIKE bcac_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bcad_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_bcac_m.bcacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
    
   LET g_bcac_m.bcacdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bcac_m.bcacownid = g_user
      LET g_bcac_m.bcacowndp = g_dept
      LET g_bcac_m.bcaccrtid = g_user
      LET g_bcac_m.bcaccrtdp = g_dept 
      LET g_bcac_m.bcaccrtdt = cl_get_current()
      LET g_bcac_m.bcacmodid = g_user
      LET g_bcac_m.bcacmoddt = cl_get_current()
      LET g_bcac_m.bcacstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bcac_m.bcacstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_bcac_m.bcacdocno_desc = ''
   DISPLAY BY NAME g_bcac_m.bcacdocno_desc
 
   
   CALL abct700_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bcac_m.* TO NULL
      INITIALIZE g_bcad_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abct700_show()
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
   CALL abct700_set_act_visible()   
   CALL abct700_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bcacent = " ||g_enterprise|| " AND",
                      " bcacdocno = '", g_bcac_m.bcacdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abct700_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abct700_idx_chk()
   
   LET g_data_owner = g_bcac_m.bcacownid      
   LET g_data_dept  = g_bcac_m.bcacowndp
   
   #功能已完成,通報訊息中心
   CALL abct700_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abct700_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bcad_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abct700_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bcad_t
    WHERE bcadent = g_enterprise AND bcaddocno = g_bcacdocno_t
 
    INTO TEMP abct700_detail
 
   #將key修正為調整後   
   UPDATE abct700_detail 
      #更新key欄位
      SET bcaddocno = g_bcac_m.bcacdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bcad_t SELECT * FROM abct700_detail
   
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
   DROP TABLE abct700_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abct700_delete()
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
   
   IF g_bcac_m.bcacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abct700_cl USING g_enterprise,g_bcac_m.bcacdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abct700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abct700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
       g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus, 
       g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
       g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid, 
       g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid, 
       g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc,g_bcac_m.bcacownid_desc, 
       g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcacmodid_desc, 
       g_bcac_m.bcaccnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abct700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bcac_m_mask_o.* =  g_bcac_m.*
   CALL abct700_bcac_t_mask()
   LET g_bcac_m_mask_n.* =  g_bcac_m.*
   
   CALL abct700_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abct700_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bcacdocno_t = g_bcac_m.bcacdocno
 
 
      DELETE FROM bcac_t
       WHERE bcacent = g_enterprise AND bcacdocno = g_bcac_m.bcacdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bcac_m.bcacdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bcad_t
       WHERE bcadent = g_enterprise AND bcaddocno = g_bcac_m.bcacdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bcad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bcac_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abct700_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bcad_d.clear() 
 
     
      CALL abct700_ui_browser_refresh()  
      #CALL abct700_ui_headershow()  
      #CALL abct700_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abct700_browser_fill("")
         CALL abct700_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abct700_cl
 
   #功能已完成,通報訊息中心
   CALL abct700_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abct700.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abct700_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bcad_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abct700_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bcad000,bcadsite,bcad001,bcadseq,bcad002,bcad003,bcad004,bcad008, 
             bcad005,bcad006,bcad007 ,t1.inayl003 ,t2.inab003 FROM bcad_t",   
                     " INNER JOIN bcac_t ON bcacent = " ||g_enterprise|| " AND bcacdocno = bcaddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=bcad002 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t2 ON t2.inabent="||g_enterprise||" AND t2.inabsite=bcadsite AND t2.inab001=bcad002 AND t2.inab002=bcad003  ",
 
                     " WHERE bcadent=? AND bcaddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bcad_t.bcadseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abct700_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abct700_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bcac_m.bcacdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bcac_m.bcacdocno INTO g_bcad_d[l_ac].bcad000,g_bcad_d[l_ac].bcadsite, 
          g_bcad_d[l_ac].bcad001,g_bcad_d[l_ac].bcadseq,g_bcad_d[l_ac].bcad002,g_bcad_d[l_ac].bcad003, 
          g_bcad_d[l_ac].bcad004,g_bcad_d[l_ac].bcad008,g_bcad_d[l_ac].bcad005,g_bcad_d[l_ac].bcad006, 
          g_bcad_d[l_ac].bcad007,g_bcad_d[l_ac].bcad002_desc,g_bcad_d[l_ac].bcad003_desc   #(ver:78) 
 
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
   
   CALL g_bcad_d.deleteElement(g_bcad_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abct700_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bcad_d.getLength()
      LET g_bcad_d_mask_o[l_ac].* =  g_bcad_d[l_ac].*
      CALL abct700_bcad_t_mask()
      LET g_bcad_d_mask_n[l_ac].* =  g_bcad_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abct700_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bcad_t
       WHERE bcadent = g_enterprise AND
         bcaddocno = ps_keys_bak[1] AND bcadseq = ps_keys_bak[2]
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
         CALL g_bcad_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abct700_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO bcad_t
                  (bcadent,
                   bcaddocno,
                   bcadseq
                   ,bcad000,bcadsite,bcad001,bcad002,bcad003,bcad004,bcad008,bcad005,bcad006,bcad007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_bcad_d[g_detail_idx].bcad000,g_bcad_d[g_detail_idx].bcadsite,g_bcad_d[g_detail_idx].bcad001, 
                       g_bcad_d[g_detail_idx].bcad002,g_bcad_d[g_detail_idx].bcad003,g_bcad_d[g_detail_idx].bcad004, 
                       g_bcad_d[g_detail_idx].bcad008,g_bcad_d[g_detail_idx].bcad005,g_bcad_d[g_detail_idx].bcad006, 
                       g_bcad_d[g_detail_idx].bcad007)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bcad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bcad_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abct700_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bcad_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abct700_bcad_t_mask_restore('restore_mask_o')
               
      UPDATE bcad_t 
         SET (bcaddocno,
              bcadseq
              ,bcad000,bcadsite,bcad001,bcad002,bcad003,bcad004,bcad008,bcad005,bcad006,bcad007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_bcad_d[g_detail_idx].bcad000,g_bcad_d[g_detail_idx].bcadsite,g_bcad_d[g_detail_idx].bcad001, 
                  g_bcad_d[g_detail_idx].bcad002,g_bcad_d[g_detail_idx].bcad003,g_bcad_d[g_detail_idx].bcad004, 
                  g_bcad_d[g_detail_idx].bcad008,g_bcad_d[g_detail_idx].bcad005,g_bcad_d[g_detail_idx].bcad006, 
                  g_bcad_d[g_detail_idx].bcad007) 
         WHERE bcadent = g_enterprise AND bcaddocno = ps_keys_bak[1] AND bcadseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bcad_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bcad_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abct700_bcad_t_mask_restore('restore_mask_n')
               
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
 
{<section id="abct700.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abct700_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="abct700.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abct700_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abct700.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abct700_lock_b(ps_table,ps_page)
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
   #CALL abct700_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bcad_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abct700_bcl USING g_enterprise,
                                       g_bcac_m.bcacdocno,g_bcad_d[g_detail_idx].bcadseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abct700_bcl:",SQLERRMESSAGE 
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
 
{<section id="abct700.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abct700_unlock_b(ps_table,ps_page)
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
      CLOSE abct700_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abct700_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("bcacdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bcacdocno",TRUE)
      CALL cl_set_comp_entry("bcacdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("bcac011",TRUE)
   CALL cl_set_comp_entry("bcac008",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abct700_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_fields      STRING
   DEFINE l_imaa005     LIKE imaa_t.imaa005
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bcacdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("bcacdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("bcacdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_bcac_m.bcac011) THEN
      CALL cl_set_comp_entry("bcac011",FALSE)
   END IF
   
   IF NOT cl_null(g_bcac_m.bcacdocno) THEN
      #aooi200預設不可更改
      LET l_fields = ''
      CALL s_aooi200_get_doc_fields(g_site,'1',g_bcac_m.bcacdocno) RETURNING l_fields
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF
   
   IF NOT cl_null(g_bcac_m.bcac002) THEN
      #判斷料件是否存在產品特徵
      CALL s_axmt500_get_imaa005(g_enterprise,g_bcac_m.bcac002) RETURNING l_imaa005
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry('bcac008',FALSE)
      END IF
   ELSE
      CALL cl_set_comp_entry('bcac008',FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abct700.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abct700_set_entry_b(p_cmd)
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
 
{<section id="abct700.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abct700_set_no_entry_b(p_cmd)
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
 
{<section id="abct700.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abct700_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("insert", TRUE)

   IF NOT cl_null(g_bcac_m.bcacdocno) THEN
      #基礎ACTION權限開啟
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
      CALL cl_set_act_visible("statechange,reproduce", TRUE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abct700.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abct700_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.num5
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_bcac_m.bcacstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   #判斷當下的營運據點是否在控制組限制的營運據點範圍內，若不在限制內則不允許新增、修改
   CALL s_control_chk_group('5','5',g_user,g_dept,g_site,'','','','') RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN    #處理狀態為FALSE 或 不在控制組範圍內
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      CALL cl_set_act_visible("insert,statechange,reproduce", FALSE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abct700.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abct700_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abct700.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abct700_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abct700.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abct700_default_search()
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
      LET ls_wc = ls_wc, " bcacdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "bcac_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bcad_t" 
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
 
{<section id="abct700.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abct700_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_bcac_m.bcacstus MATCHES '[XY]' THEN
      RETURN
   END IF   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bcac_m.bcacdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abct700_cl USING g_enterprise,g_bcac_m.bcacdocno
   IF STATUS THEN
      CLOSE abct700_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abct700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
       g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014,g_bcac_m.bcacstus, 
       g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008,g_bcac_m.bcac012, 
       g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid, 
       g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid, 
       g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc,g_bcac_m.bcacownid_desc, 
       g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcacmodid_desc, 
       g_bcac_m.bcaccnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abct700_action_chk() THEN
      CLOSE abct700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite,g_bcac_m.bcacsite_desc, 
       g_bcac_m.bcacdocno,g_bcac_m.bcacdocno_desc,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac013_desc, 
       g_bcac_m.bcac014,g_bcac_m.bcac014_desc,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009, 
       g_bcac_m.bcac002,g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1,g_bcac_m.bcac008,g_bcac_m.bcac008_desc, 
       g_bcac_m.bcac012,g_bcac_m.bcac012_desc,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006, 
       g_bcac_m.bcac007,g_bcac_m.bcacownid,g_bcac_m.bcacownid_desc,g_bcac_m.bcacowndp,g_bcac_m.bcacowndp_desc, 
       g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcaccrtdt, 
       g_bcac_m.bcacmodid,g_bcac_m.bcacmodid_desc,g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfid_desc, 
       g_bcac_m.bcaccnfdt
 
   CASE g_bcac_m.bcacstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bcac_m.bcacstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CASE g_bcac_m.bcacstus
         WHEN "N"
            HIDE OPTION "unconfirmed"
         WHEN "Y"
            HIDE OPTION "confirmed"
            HIDE OPTION "invalid"
            HIDE OPTION "unconfirmed"
            CLOSE abct700_cl
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "X"
            HIDE OPTION "invalid"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            CLOSE abct700_cl
            CALL s_transaction_end('N','0')
            RETURN
      END CASE
      
      #end add-point
      
      
	  
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
            CALL cl_err_collect_init()
            CALL s_abct700_conf_chk(g_bcac_m.bcacdocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE abct700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               IF cl_ask_confirm('aim-00108') THEN
                  CALL s_abct700_conf_upd(g_bcac_m.bcacdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CLOSE abct700_cl
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               END IF
            END IF
            CALL cl_err_collect_show()

            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            CALL cl_err_collect_init()
            CALL s_abct700_invalid_chk(g_bcac_m.bcacdocno) RETURNING l_success
            IF NOT l_success THEN
               CLOSE abct700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               IF cl_ask_confirm('aim-00109') THEN
                  CALL s_abct700_invalid_upd(g_bcac_m.bcacdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CLOSE abct700_cl
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  END IF
               ELSE
                  CLOSE abct700_cl
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               END IF
            END IF
            CALL cl_err_collect_show()
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_bcac_m.bcacstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abct700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
 
   #end add-point
   
   LET g_bcac_m.bcacmodid = g_user
   LET g_bcac_m.bcacmoddt = cl_get_current()
   LET g_bcac_m.bcacstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bcac_t 
      SET (bcacstus,bcacmodid,bcacmoddt) 
        = (g_bcac_m.bcacstus,g_bcac_m.bcacmodid,g_bcac_m.bcacmoddt)     
    WHERE bcacent = g_enterprise AND bcacdocno = g_bcac_m.bcacdocno
 
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abct700_master_referesh USING g_bcac_m.bcacdocno INTO g_bcac_m.bcac000,g_bcac_m.bcaccomp, 
          g_bcac_m.bcacsite,g_bcac_m.bcacdocno,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac014, 
          g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001,g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac008, 
          g_bcac_m.bcac012,g_bcac_m.bcac003,g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007, 
          g_bcac_m.bcacownid,g_bcac_m.bcacowndp,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtdp,g_bcac_m.bcaccrtdt, 
          g_bcac_m.bcacmodid,g_bcac_m.bcacmoddt,g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfdt,g_bcac_m.bcaccomp_desc, 
          g_bcac_m.bcacsite_desc,g_bcac_m.bcac013_desc,g_bcac_m.bcac014_desc,g_bcac_m.bcac002_desc,g_bcac_m.bcac012_desc, 
          g_bcac_m.bcacownid_desc,g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp_desc, 
          g_bcac_m.bcacmodid_desc,g_bcac_m.bcaccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bcac_m.bcac000,g_bcac_m.bcaccomp,g_bcac_m.bcaccomp_desc,g_bcac_m.bcacsite,g_bcac_m.bcacsite_desc, 
          g_bcac_m.bcacdocno,g_bcac_m.bcacdocno_desc,g_bcac_m.bcacdocdt,g_bcac_m.bcac013,g_bcac_m.bcac013_desc, 
          g_bcac_m.bcac014,g_bcac_m.bcac014_desc,g_bcac_m.bcacstus,g_bcac_m.bcac011,g_bcac_m.bcac001, 
          g_bcac_m.bcac009,g_bcac_m.bcac002,g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1,g_bcac_m.bcac008, 
          g_bcac_m.bcac008_desc,g_bcac_m.bcac012,g_bcac_m.bcac012_desc,g_bcac_m.bcac003,g_bcac_m.bcac004, 
          g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,g_bcac_m.bcacownid,g_bcac_m.bcacownid_desc, 
          g_bcac_m.bcacowndp,g_bcac_m.bcacowndp_desc,g_bcac_m.bcaccrtid,g_bcac_m.bcaccrtid_desc,g_bcac_m.bcaccrtdp, 
          g_bcac_m.bcaccrtdp_desc,g_bcac_m.bcaccrtdt,g_bcac_m.bcacmodid,g_bcac_m.bcacmodid_desc,g_bcac_m.bcacmoddt, 
          g_bcac_m.bcaccnfid,g_bcac_m.bcaccnfid_desc,g_bcac_m.bcaccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abct700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abct700_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abct700.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abct700_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bcad_d.getLength() THEN
         LET g_detail_idx = g_bcad_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bcad_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bcad_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abct700_b_fill2(pi_idx)
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
   
   CALL abct700_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abct700_fill_chk(ps_idx)
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
 
{<section id="abct700.status_show" >}
PRIVATE FUNCTION abct700_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abct700.mask_functions" >}
&include "erp/abc/abct700_mask.4gl"
 
{</section>}
 
{<section id="abct700.signature" >}
   
 
{</section>}
 
{<section id="abct700.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abct700_set_pk_array()
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
   LET g_pk_array[1].values = g_bcac_m.bcacdocno
   LET g_pk_array[1].column = 'bcacdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abct700.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abct700.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abct700_msgcentre_notify(lc_state)
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
   CALL abct700_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bcac_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abct700.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abct700_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abct700.other_function" readonly="Y" >}

################################################################################
# Descriptions...: #依據輸入的條碼編號，帶出單頭欄位的值
# Memo...........:
# Usage..........: CALL abct700_bcac011_bcac()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   成功否
# Date & Author..: 2015/05/22 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION abct700_bcac011_bcac()
   DEFINE  l_success    LIKE type_t.num5
   DEFINE  r_success    LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT bcaa001,bcaa002,bcaa003,
          bcaa004,bcaa005,bcaa006,bcaa007,
          bcaa008,bcaa009,bcaa012
     INTO g_bcac_m.bcac001,g_bcac_m.bcac002,g_bcac_m.bcac003,
          g_bcac_m.bcac004,g_bcac_m.bcac005,g_bcac_m.bcac006,g_bcac_m.bcac007,
          g_bcac_m.bcac008,g_bcac_m.bcac009,g_bcac_m.bcac012
     FROM bcaa_t
    WHERE bcaaent = g_enterprise
      AND bcaasite = g_site
      AND bcaa001 = g_bcac_m.bcac011
      AND bcaastus = 'Y'
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel bcaa_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
   CALL s_desc_get_item_desc(g_bcac_m.bcac002)RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
   CALL s_feature_description(g_bcac_m.bcac002,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
   
   LET g_bcac_m_o.* = g_bcac_m.*
   
   DISPLAY BY NAME g_bcac_m.*
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: #依據輸入的條碼編號，帶出單身欄位的值
# Memo...........:
# Usage..........: CALL abct700_bcac011_bcad()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   成功否
# Date & Author..: 2015/05/22 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION abct700_bcac011_bcad()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_i          LIKE type_t.num10
   DEFINE l_bcab       RECORD
      bcab000       LIKE bcab_t.bcab000,
      bcab001       LIKE bcab_t.bcab001,
      bcab002       LIKE bcab_t.bcab002,
      bcab003       LIKE bcab_t.bcab003,
      bcab004       LIKE bcab_t.bcab004,
      bcab005       LIKE bcab_t.bcab005,
      bcab006       LIKE bcab_t.bcab006,
      bcab007       LIKE bcab_t.bcab007,
      bcab008       LIKE bcab_t.bcab008
                        END RECORD
   
   LET r_success = TRUE
   
   IF cl_null(g_bcac_m.bcac011) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sub-00278'  #傳入的條碼為空！
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sql = "SELECT bcab000,",
               "       bcab001,bcab002,bcab003,bcab004,bcab005,",
               "       bcab006,bcab007,bcab008",
               "  FROM bcab_t",
               " WHERE bcabent  =  ",g_enterprise,
               "   AND bcabsite = '",g_bcac_m.bcacsite,"'",
               "   AND bcab001  = '",g_bcac_m.bcac011,"'",
               "   AND bcab007  <> 0 "
               
   PREPARE sel_bcab_pre FROM l_sql
   DECLARE sel_bcab_cur CURSOR FOR sel_bcab_pre

   LET l_i = 1
   INITIALIZE l_bcab.* TO NULL
   FOREACH sel_bcab_cur INTO l_bcab.bcab000,
                             l_bcab.bcab001,l_bcab.bcab002,l_bcab.bcab003,l_bcab.bcab004,l_bcab.bcab005,
                             l_bcab.bcab006,l_bcab.bcab007,l_bcab.bcab008
                                   
      #INSERT
      INSERT INTO bcad_t (bcadent,bcadsite,
                          bcaddocno,bcadseq,bcad000,
                          bcad001,bcad002,bcad003,bcad004,bcad005,
                          bcad006,bcad007,bcad008)
           VALUES (g_enterprise,g_bcac_m.bcacsite,
                   g_bcac_m.bcacdocno,l_i,l_bcab.bcab000,
                   l_bcab.bcab001,l_bcab.bcab002,l_bcab.bcab003,l_bcab.bcab004,l_bcab.bcab005,
                   l_bcab.bcab006,l_bcab.bcab007,l_bcab.bcab008)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT INTO bcad_t'
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_i = l_i + 1
   END FOREACH

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION abct700_bcad003_chk()
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_bcad_d[l_ac].bcad003) THEN   
      IF cl_null(g_bcad_d[l_ac].bcad002) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00126'    #庫位不可為空
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #欄位存在檢查
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
         
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_bcac_m.bcacsite
      LET g_chkparam.arg2 = g_bcad_d[l_ac].bcad002
      LET g_chkparam.arg3 = g_bcad_d[l_ac].bcad003
      #160318-00025#18  by 07900 --add-str                 
      LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
      #160318-00025#18  by 07900 --add-end                  
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inab002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF  

   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION abct700_deftult()
   DEFINE  l_success    LIKE type_t.num5
   DEFINE  l_slip       LIKE oobal_t.oobal002

   #抓取單據別
   LET l_slip = ''
   CALL s_aooi200_get_slip(g_bcac_m.bcacdocno) RETURNING l_success,l_slip
   IF NOT l_success THEN
      RETURN
   END IF

   LET g_bcac_m.bcac013 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac013',g_bcac_m.bcac013)
   LET g_bcac_m.bcac014 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac014',g_bcac_m.bcac014)
   LET g_bcac_m.bcac011 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac011',g_bcac_m.bcac011)
   LET g_bcac_m.bcac001 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac001',g_bcac_m.bcac001)
   LET g_bcac_m.bcac009 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac009',g_bcac_m.bcac009)
   LET g_bcac_m.bcac002 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac002',g_bcac_m.bcac002)
   LET g_bcac_m.bcac008 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac008',g_bcac_m.bcac008)
   LET g_bcac_m.bcac012 = s_aooi200_get_doc_default(g_site,'1',l_slip,'bcac012',g_bcac_m.bcac012)
   
   CALL s_desc_get_person_desc(g_bcac_m.bcac013) RETURNING g_bcac_m.bcac013_desc
   CALL s_desc_get_department_desc(g_bcac_m.bcac014) RETURNING g_bcac_m.bcac014_desc
   CALL s_desc_get_item_desc(g_bcac_m.bcac002)RETURNING g_bcac_m.bcac002_desc,g_bcac_m.bcac002_desc_1
   CALL s_feature_description(g_bcac_m.bcac002,g_bcac_m.bcac008) RETURNING l_success,g_bcac_m.bcac008_desc
   CALL s_desc_get_unit_desc(g_bcac_m.bcac012) RETURNING g_bcac_m.bcac012_desc
   
   LET g_bcac_m_o.* = g_bcac_m.*
   DISPLAY BY NAME g_bcac_m.*
END FUNCTION

 
{</section>}
 