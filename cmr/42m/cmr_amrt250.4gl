#該程式未解開Section, 採用最新樣板產出!
{<section id="amrt250.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-05-04 14:08:52), PR版次:0002(2017-01-24 10:28:13)
#+ Customerized Version.: SD版次:0002(2017-04-06 11:38:31), PR版次:0002(2017-04-06 13:12:10)
#+ Build......: 000074
#+ Filename...: amrt250
#+ Description: 資源歸還作業
#+ Creator....: 05384(2014-09-17 09:29:40)
#+ Modifier...: 02040 -SD/PR- 08992
 
{</section>}
 
{<section id="amrt250.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#24   2016/04/25   BY 07900   校验代码重复错误讯息的修改
#160818-00017#24  2016-08-22  By 08734     删除修改未重新判断状态码
#160909-00080#1   2016/09/13  By 02097     修改開窗
#161013-00051#1   2016/10/18  By shiun     整批調整據點組織開窗
#170120-00045#1   2017/01/23  By 08992     查詢[性質]欄位只顯示6:歸還其他的隱藏
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
PRIVATE type type_g_mrdf_m        RECORD
       mrdfdocno LIKE mrdf_t.mrdfdocno, 
   mrdfdocno_desc LIKE type_t.chr80, 
   mrdfdocdt LIKE mrdf_t.mrdfdocdt, 
   mrdf001 LIKE mrdf_t.mrdf001, 
   mrdf002 LIKE mrdf_t.mrdf002, 
   mrdf002_desc LIKE type_t.chr80, 
   mrdf003 LIKE mrdf_t.mrdf003, 
   mrdf003_desc LIKE type_t.chr80, 
   mrdfstus LIKE mrdf_t.mrdfstus, 
   mrdf004 LIKE mrdf_t.mrdf004, 
   mrdfsite LIKE mrdf_t.mrdfsite, 
   mrdf005 LIKE mrdf_t.mrdf005, 
   mrdf005_desc LIKE type_t.chr80, 
   mrdf006 LIKE mrdf_t.mrdf006, 
   mrdfownid LIKE mrdf_t.mrdfownid, 
   mrdfownid_desc LIKE type_t.chr80, 
   mrdfowndp LIKE mrdf_t.mrdfowndp, 
   mrdfowndp_desc LIKE type_t.chr80, 
   mrdfcrtid LIKE mrdf_t.mrdfcrtid, 
   mrdfcrtid_desc LIKE type_t.chr80, 
   mrdfcrtdp LIKE mrdf_t.mrdfcrtdp, 
   mrdfcrtdp_desc LIKE type_t.chr80, 
   mrdfcrtdt LIKE mrdf_t.mrdfcrtdt, 
   mrdfmodid LIKE mrdf_t.mrdfmodid, 
   mrdfmodid_desc LIKE type_t.chr80, 
   mrdfmoddt LIKE mrdf_t.mrdfmoddt, 
   mrdfcnfid LIKE mrdf_t.mrdfcnfid, 
   mrdfcnfid_desc LIKE type_t.chr80, 
   mrdfcnfdt LIKE mrdf_t.mrdfcnfdt, 
   mrdfpstid LIKE mrdf_t.mrdfpstid, 
   mrdfpstid_desc LIKE type_t.chr80, 
   mrdfpstdt LIKE mrdf_t.mrdfpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrdg_d        RECORD
       mrdgseq LIKE mrdg_t.mrdgseq, 
   mrdg001 LIKE mrdg_t.mrdg001, 
   mrdg002 LIKE mrdg_t.mrdg002, 
   mrdg003 LIKE mrdg_t.mrdg003, 
   mrdg003_desc LIKE type_t.chr500, 
   mrba008 LIKE type_t.chr500, 
   mrba009 LIKE type_t.chr500, 
   mrdg004 LIKE mrdg_t.mrdg004, 
   mrdg005 LIKE mrdg_t.mrdg005, 
   mrdg006 LIKE mrdg_t.mrdg006, 
   mrdg006_desc LIKE type_t.chr500, 
   mrdg007 LIKE mrdg_t.mrdg007, 
   mrdg007_desc LIKE type_t.chr500, 
   mrdg008 LIKE mrdg_t.mrdg008, 
   mrdg009 LIKE mrdg_t.mrdg009, 
   mrdg010 LIKE mrdg_t.mrdg010, 
   mrdg011 LIKE mrdg_t.mrdg011, 
   mrdg011_desc LIKE type_t.chr500, 
   mrdg012 LIKE mrdg_t.mrdg012, 
   mrdg014 LIKE mrdg_t.mrdg014, 
   mrdg014_desc LIKE type_t.chr500, 
   mrdg013 LIKE mrdg_t.mrdg013, 
   mrdgsite LIKE mrdg_t.mrdgsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mrdfdocno LIKE mrdf_t.mrdfdocno,
      b_mrdfdocdt LIKE mrdf_t.mrdfdocdt,
      b_mrdf001 LIKE mrdf_t.mrdf001,
      b_mrdf002 LIKE mrdf_t.mrdf002,
   b_mrdf002_desc LIKE type_t.chr80,
      b_mrdf003 LIKE mrdf_t.mrdf003,
   b_mrdf003_desc LIKE type_t.chr80,
      b_mrdfcrtid LIKE mrdf_t.mrdfcrtid,
   b_mrdfcrtid_desc LIKE type_t.chr80,
      b_mrdfcrtdt LIKE mrdf_t.mrdfcrtdt,
      b_mrdfmodid LIKE mrdf_t.mrdfmodid,
   b_mrdfmodid_desc LIKE type_t.chr80,
      b_mrdfmoddt LIKE mrdf_t.mrdfmoddt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrdf_m          type_g_mrdf_m
DEFINE g_mrdf_m_t        type_g_mrdf_m
DEFINE g_mrdf_m_o        type_g_mrdf_m
DEFINE g_mrdf_m_mask_o   type_g_mrdf_m #轉換遮罩前資料
DEFINE g_mrdf_m_mask_n   type_g_mrdf_m #轉換遮罩後資料
 
   DEFINE g_mrdfdocno_t LIKE mrdf_t.mrdfdocno
 
 
DEFINE g_mrdg_d          DYNAMIC ARRAY OF type_g_mrdg_d
DEFINE g_mrdg_d_t        type_g_mrdg_d
DEFINE g_mrdg_d_o        type_g_mrdg_d
DEFINE g_mrdg_d_mask_o   DYNAMIC ARRAY OF type_g_mrdg_d #轉換遮罩前資料
DEFINE g_mrdg_d_mask_n   DYNAMIC ARRAY OF type_g_mrdg_d #轉換遮罩後資料
 
 
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
 
{<section id="amrt250.main" >}
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
   CALL cl_ap_init("cmr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_errshow = 1
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrdfdocno,'',mrdfdocdt,mrdf001,mrdf002,'',mrdf003,'',mrdfstus,mrdf004, 
       mrdfsite,mrdf005,'',mrdf006,mrdfownid,'',mrdfowndp,'',mrdfcrtid,'',mrdfcrtdp,'',mrdfcrtdt,mrdfmodid, 
       '',mrdfmoddt,mrdfcnfid,'',mrdfcnfdt,mrdfpstid,'',mrdfpstdt", 
                      " FROM mrdf_t",
                      " WHERE mrdfent= ? AND mrdfdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt250_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrdfdocno,t0.mrdfdocdt,t0.mrdf001,t0.mrdf002,t0.mrdf003,t0.mrdfstus, 
       t0.mrdf004,t0.mrdfsite,t0.mrdf005,t0.mrdf006,t0.mrdfownid,t0.mrdfowndp,t0.mrdfcrtid,t0.mrdfcrtdp, 
       t0.mrdfcrtdt,t0.mrdfmodid,t0.mrdfmoddt,t0.mrdfcnfid,t0.mrdfcnfdt,t0.mrdfpstid,t0.mrdfpstdt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011 ,t9.ooag011", 
 
               " FROM mrdf_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdf002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdf003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdfownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.mrdfowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mrdfcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.mrdfcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mrdfmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mrdfcnfid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mrdfpstid  ",
 
               " WHERE t0.mrdfent = " ||g_enterprise|| " AND t0.mrdfdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrt250_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrt250 WITH FORM cl_ap_formpath("cmr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrt250_init()   
 
      #進入選單 Menu (="N")
      CALL amrt250_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrt250
      
   END IF 
   
   CLOSE amrt250_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrt250.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrt250_init()
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
      CALL cl_set_combo_scc_part('mrdfstus','13','N,Y,X')
 
      CALL cl_set_combo_scc('mrdf001','5211') 
   CALL cl_set_combo_scc('mrdf004','5212') 
   CALL cl_set_combo_scc('mrdg010','5442') 
   CALL cl_set_combo_scc('mrdg011','5214') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('mrdf001','5211','6')  #170120-00045#1 add

   #end add-point
   
   #初始化搜尋條件
   CALL amrt250_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrt250.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrt250_ui_dialog()
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
            CALL amrt250_insert()
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
         INITIALIZE g_mrdf_m.* TO NULL
         CALL g_mrdg_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrt250_init()
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
               
               CALL amrt250_fetch('') # reload data
               LET l_ac = 1
               CALL amrt250_ui_detailshow() #Setting the current row 
         
               CALL amrt250_idx_chk()
               #NEXT FIELD mrdgseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mrdg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt250_idx_chk()
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
               CALL amrt250_idx_chk()
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
            CALL amrt250_browser_fill("")
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
               CALL amrt250_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrt250_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrt250_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrt250_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrt250_set_act_visible()   
            CALL amrt250_set_act_no_visible()
            IF NOT (g_mrdf_m.mrdfdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mrdfent = " ||g_enterprise|| " AND",
                                  " mrdfdocno = '", g_mrdf_m.mrdfdocno, "' "
 
               #填到對應位置
               CALL amrt250_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mrdf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdg_t" 
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
               CALL amrt250_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mrdf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdg_t" 
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
                  CALL amrt250_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrt250_fetch("F")
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
               CALL amrt250_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrt250_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt250_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrt250_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt250_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrt250_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt250_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrt250_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt250_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrt250_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt250_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrdg_d)
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
               NEXT FIELD mrdgseq
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
               CALL amrt250_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrt250_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amrt250_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrt250_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amr/amrt250_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amr/amrt250_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amrt250_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrt250_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrt250_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrt250_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrt250_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mrdf_m.mrdfdocdt)
 
 
 
         
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
 
{<section id="amrt250.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrt250_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " mrdfsite = '",g_site,"' " 
   ELSE
      LET g_wc = g_wc," AND mrdfsite = '",g_site,"' "
   END IF
   LET l_wc  = g_wc.trim()   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mrdfdocno ",
                      " FROM mrdf_t ",
                      " ",
                      " LEFT JOIN mrdg_t ON mrdgent = mrdfent AND mrdfdocno = mrdgdocno ", "  ",
                      #add-point:browser_fill段sql(mrdg_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mrdfent = " ||g_enterprise|| " AND mrdgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrdf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrdfdocno ",
                      " FROM mrdf_t ", 
                      "  ",
                      "  ",
                      " WHERE mrdfent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrdf_t")
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
      INITIALIZE g_mrdf_m.* TO NULL
      CALL g_mrdg_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrdfdocno,t0.mrdfdocdt,t0.mrdf001,t0.mrdf002,t0.mrdf003,t0.mrdfcrtid,t0.mrdfcrtdt,t0.mrdfmodid,t0.mrdfmoddt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdfstus,t0.mrdfdocno,t0.mrdfdocdt,t0.mrdf001,t0.mrdf002,t0.mrdf003, 
          t0.mrdfcrtid,t0.mrdfcrtdt,t0.mrdfmodid,t0.mrdfmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooag011 ", 
 
                  " FROM mrdf_t t0",
                  "  ",
                  "  LEFT JOIN mrdg_t ON mrdgent = mrdfent AND mrdfdocno = mrdgdocno ", "  ", 
                  #add-point:browser_fill段sql(mrdg_t1) name="browser_fill.join.mrdg_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdf002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdf003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdfcrtid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdfmodid  ",
 
                  " WHERE t0.mrdfent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrdf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdfstus,t0.mrdfdocno,t0.mrdfdocdt,t0.mrdf001,t0.mrdf002,t0.mrdf003, 
          t0.mrdfcrtid,t0.mrdfcrtdt,t0.mrdfmodid,t0.mrdfmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooag011 ", 
 
                  " FROM mrdf_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdf002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdf003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdfcrtid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdfmodid  ",
 
                  " WHERE t0.mrdfent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mrdf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mrdfdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrdf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mrdfdocno,g_browser[g_cnt].b_mrdfdocdt, 
          g_browser[g_cnt].b_mrdf001,g_browser[g_cnt].b_mrdf002,g_browser[g_cnt].b_mrdf003,g_browser[g_cnt].b_mrdfcrtid, 
          g_browser[g_cnt].b_mrdfcrtdt,g_browser[g_cnt].b_mrdfmodid,g_browser[g_cnt].b_mrdfmoddt,g_browser[g_cnt].b_mrdf002_desc, 
          g_browser[g_cnt].b_mrdf003_desc,g_browser[g_cnt].b_mrdfcrtid_desc,g_browser[g_cnt].b_mrdfmodid_desc 
 
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
         CALL amrt250_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_mrdfdocno) THEN
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
 
{<section id="amrt250.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrt250_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrdf_m.mrdfdocno = g_browser[g_current_idx].b_mrdfdocno   
 
   EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
       g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
       g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
       g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
       g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfownid_desc, 
       g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
   
   CALL amrt250_mrdf_t_mask()
   CALL amrt250_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrt250.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrt250_ui_detailshow()
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
 
{<section id="amrt250.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrt250_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrdfdocno = g_mrdf_m.mrdfdocno 
 
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
 
{<section id="amrt250.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrt250_construct()
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
   INITIALIZE g_mrdf_m.* TO NULL
   CALL g_mrdg_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mrdfdocno,mrdfdocno_desc,mrdfdocdt,mrdf001,mrdf002,mrdf003,mrdfstus, 
          mrdf004,mrdfsite,mrdf005,mrdf006,mrdfownid,mrdfowndp,mrdfcrtid,mrdfcrtdp,mrdfcrtdt,mrdfmodid, 
          mrdfmoddt,mrdfcnfid,mrdfcnfdt,mrdfpstid,mrdfpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrdfcrtdt>>----
         AFTER FIELD mrdfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrdfmoddt>>----
         AFTER FIELD mrdfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdfcnfdt>>----
         AFTER FIELD mrdfcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdfpstdt>>----
         AFTER FIELD mrdfpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mrdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfdocno
            #add-point:ON ACTION controlp INFIELD mrdfdocno name="construct.c.mrdfdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdfdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfdocno  #顯示到畫面上
            NEXT FIELD mrdfdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfdocno
            #add-point:BEFORE FIELD mrdfdocno name="construct.b.mrdfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfdocno
            
            #add-point:AFTER FIELD mrdfdocno name="construct.a.mrdfdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfdocno_desc
            #add-point:BEFORE FIELD mrdfdocno_desc name="construct.b.mrdfdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfdocno_desc
            
            #add-point:AFTER FIELD mrdfdocno_desc name="construct.a.mrdfdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfdocno_desc
            #add-point:ON ACTION controlp INFIELD mrdfdocno_desc name="construct.c.mrdfdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfdocdt
            #add-point:BEFORE FIELD mrdfdocdt name="construct.b.mrdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfdocdt
            
            #add-point:AFTER FIELD mrdfdocdt name="construct.a.mrdfdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfdocdt
            #add-point:ON ACTION controlp INFIELD mrdfdocdt name="construct.c.mrdfdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf001
            #add-point:BEFORE FIELD mrdf001 name="construct.b.mrdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf001
            
            #add-point:AFTER FIELD mrdf001 name="construct.a.mrdf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf001
            #add-point:ON ACTION controlp INFIELD mrdf001 name="construct.c.mrdf001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf002
            #add-point:ON ACTION controlp INFIELD mrdf002 name="construct.c.mrdf002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdf002  #顯示到畫面上
            NEXT FIELD mrdf002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf002
            #add-point:BEFORE FIELD mrdf002 name="construct.b.mrdf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf002
            
            #add-point:AFTER FIELD mrdf002 name="construct.a.mrdf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf003
            #add-point:ON ACTION controlp INFIELD mrdf003 name="construct.c.mrdf003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdf003  #顯示到畫面上
            NEXT FIELD mrdf003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf003
            #add-point:BEFORE FIELD mrdf003 name="construct.b.mrdf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf003
            
            #add-point:AFTER FIELD mrdf003 name="construct.a.mrdf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfstus
            #add-point:BEFORE FIELD mrdfstus name="construct.b.mrdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfstus
            
            #add-point:AFTER FIELD mrdfstus name="construct.a.mrdfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfstus
            #add-point:ON ACTION controlp INFIELD mrdfstus name="construct.c.mrdfstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf004
            #add-point:BEFORE FIELD mrdf004 name="construct.b.mrdf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf004
            
            #add-point:AFTER FIELD mrdf004 name="construct.a.mrdf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf004
            #add-point:ON ACTION controlp INFIELD mrdf004 name="construct.c.mrdf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfsite
            #add-point:BEFORE FIELD mrdfsite name="construct.b.mrdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfsite
            
            #add-point:AFTER FIELD mrdfsite name="construct.a.mrdfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfsite
            #add-point:ON ACTION controlp INFIELD mrdfsite name="construct.c.mrdfsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf005
            #add-point:ON ACTION controlp INFIELD mrdf005 name="construct.c.mrdf005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdf005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdf005  #顯示到畫面上
            NEXT FIELD mrdf005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf005
            #add-point:BEFORE FIELD mrdf005 name="construct.b.mrdf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf005
            
            #add-point:AFTER FIELD mrdf005 name="construct.a.mrdf005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf006
            #add-point:BEFORE FIELD mrdf006 name="construct.b.mrdf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf006
            
            #add-point:AFTER FIELD mrdf006 name="construct.a.mrdf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf006
            #add-point:ON ACTION controlp INFIELD mrdf006 name="construct.c.mrdf006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfownid
            #add-point:ON ACTION controlp INFIELD mrdfownid name="construct.c.mrdfownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfownid  #顯示到畫面上
            NEXT FIELD mrdfownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfownid
            #add-point:BEFORE FIELD mrdfownid name="construct.b.mrdfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfownid
            
            #add-point:AFTER FIELD mrdfownid name="construct.a.mrdfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfowndp
            #add-point:ON ACTION controlp INFIELD mrdfowndp name="construct.c.mrdfowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfowndp  #顯示到畫面上
            NEXT FIELD mrdfowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfowndp
            #add-point:BEFORE FIELD mrdfowndp name="construct.b.mrdfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfowndp
            
            #add-point:AFTER FIELD mrdfowndp name="construct.a.mrdfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfcrtid
            #add-point:ON ACTION controlp INFIELD mrdfcrtid name="construct.c.mrdfcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfcrtid  #顯示到畫面上
            NEXT FIELD mrdfcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfcrtid
            #add-point:BEFORE FIELD mrdfcrtid name="construct.b.mrdfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfcrtid
            
            #add-point:AFTER FIELD mrdfcrtid name="construct.a.mrdfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfcrtdp
            #add-point:ON ACTION controlp INFIELD mrdfcrtdp name="construct.c.mrdfcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfcrtdp  #顯示到畫面上
            NEXT FIELD mrdfcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfcrtdp
            #add-point:BEFORE FIELD mrdfcrtdp name="construct.b.mrdfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfcrtdp
            
            #add-point:AFTER FIELD mrdfcrtdp name="construct.a.mrdfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfcrtdt
            #add-point:BEFORE FIELD mrdfcrtdt name="construct.b.mrdfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfmodid
            #add-point:ON ACTION controlp INFIELD mrdfmodid name="construct.c.mrdfmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfmodid  #顯示到畫面上
            NEXT FIELD mrdfmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfmodid
            #add-point:BEFORE FIELD mrdfmodid name="construct.b.mrdfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfmodid
            
            #add-point:AFTER FIELD mrdfmodid name="construct.a.mrdfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfmoddt
            #add-point:BEFORE FIELD mrdfmoddt name="construct.b.mrdfmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdfcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfcnfid
            #add-point:ON ACTION controlp INFIELD mrdfcnfid name="construct.c.mrdfcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfcnfid  #顯示到畫面上
            NEXT FIELD mrdfcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfcnfid
            #add-point:BEFORE FIELD mrdfcnfid name="construct.b.mrdfcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfcnfid
            
            #add-point:AFTER FIELD mrdfcnfid name="construct.a.mrdfcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfcnfdt
            #add-point:BEFORE FIELD mrdfcnfdt name="construct.b.mrdfcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdfpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfpstid
            #add-point:ON ACTION controlp INFIELD mrdfpstid name="construct.c.mrdfpstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdfpstid  #顯示到畫面上
            NEXT FIELD mrdfpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfpstid
            #add-point:BEFORE FIELD mrdfpstid name="construct.b.mrdfpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfpstid
            
            #add-point:AFTER FIELD mrdfpstid name="construct.a.mrdfpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfpstdt
            #add-point:BEFORE FIELD mrdfpstdt name="construct.b.mrdfpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrdgseq,mrdg001,mrdg002,mrdg003,mrdg004,mrdg005,mrdg006,mrdg007,mrdg008, 
          mrdg009,mrdg010,mrdg011,mrdg012,mrdg014,mrdg013,mrdgsite
           FROM s_detail1[1].mrdgseq,s_detail1[1].mrdg001,s_detail1[1].mrdg002,s_detail1[1].mrdg003, 
               s_detail1[1].mrdg004,s_detail1[1].mrdg005,s_detail1[1].mrdg006,s_detail1[1].mrdg007,s_detail1[1].mrdg008, 
               s_detail1[1].mrdg009,s_detail1[1].mrdg010,s_detail1[1].mrdg011,s_detail1[1].mrdg012,s_detail1[1].mrdg014, 
               s_detail1[1].mrdg013,s_detail1[1].mrdgsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdgseq
            #add-point:BEFORE FIELD mrdgseq name="construct.b.page1.mrdgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdgseq
            
            #add-point:AFTER FIELD mrdgseq name="construct.a.page1.mrdgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdgseq
            #add-point:ON ACTION controlp INFIELD mrdgseq name="construct.c.page1.mrdgseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg001
            #add-point:ON ACTION controlp INFIELD mrdg001 name="construct.c.page1.mrdg001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdcdocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdg001  #顯示到畫面上
            NEXT FIELD mrdg001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg001
            #add-point:BEFORE FIELD mrdg001 name="construct.b.page1.mrdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg001
            
            #add-point:AFTER FIELD mrdg001 name="construct.a.page1.mrdg001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg002
            #add-point:BEFORE FIELD mrdg002 name="construct.b.page1.mrdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg002
            
            #add-point:AFTER FIELD mrdg002 name="construct.a.page1.mrdg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg002
            #add-point:ON ACTION controlp INFIELD mrdg002 name="construct.c.page1.mrdg002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg003
            #add-point:ON ACTION controlp INFIELD mrdg003 name="construct.c.page1.mrdg003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdg003  #顯示到畫面上
            NEXT FIELD mrdg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg003
            #add-point:BEFORE FIELD mrdg003 name="construct.b.page1.mrdg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg003
            
            #add-point:AFTER FIELD mrdg003 name="construct.a.page1.mrdg003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg004
            #add-point:BEFORE FIELD mrdg004 name="construct.b.page1.mrdg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg004
            
            #add-point:AFTER FIELD mrdg004 name="construct.a.page1.mrdg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg004
            #add-point:ON ACTION controlp INFIELD mrdg004 name="construct.c.page1.mrdg004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg005
            #add-point:BEFORE FIELD mrdg005 name="construct.b.page1.mrdg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg005
            
            #add-point:AFTER FIELD mrdg005 name="construct.a.page1.mrdg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg005
            #add-point:ON ACTION controlp INFIELD mrdg005 name="construct.c.page1.mrdg005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg006
            #add-point:ON ACTION controlp INFIELD mrdg006 name="construct.c.page1.mrdg006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdg006  #顯示到畫面上
            NEXT FIELD mrdg006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg006
            #add-point:BEFORE FIELD mrdg006 name="construct.b.page1.mrdg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg006
            
            #add-point:AFTER FIELD mrdg006 name="construct.a.page1.mrdg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg007
            #add-point:ON ACTION controlp INFIELD mrdg007 name="construct.c.page1.mrdg007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdg007  #顯示到畫面上
            NEXT FIELD mrdg007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg007
            #add-point:BEFORE FIELD mrdg007 name="construct.b.page1.mrdg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg007
            
            #add-point:AFTER FIELD mrdg007 name="construct.a.page1.mrdg007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg008
            #add-point:BEFORE FIELD mrdg008 name="construct.b.page1.mrdg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg008
            
            #add-point:AFTER FIELD mrdg008 name="construct.a.page1.mrdg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg008
            #add-point:ON ACTION controlp INFIELD mrdg008 name="construct.c.page1.mrdg008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg009
            #add-point:BEFORE FIELD mrdg009 name="construct.b.page1.mrdg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg009
            
            #add-point:AFTER FIELD mrdg009 name="construct.a.page1.mrdg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg009
            #add-point:ON ACTION controlp INFIELD mrdg009 name="construct.c.page1.mrdg009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg010
            #add-point:BEFORE FIELD mrdg010 name="construct.b.page1.mrdg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg010
            
            #add-point:AFTER FIELD mrdg010 name="construct.a.page1.mrdg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg010
            #add-point:ON ACTION controlp INFIELD mrdg010 name="construct.c.page1.mrdg010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg011
            #add-point:ON ACTION controlp INFIELD mrdg011 name="construct.c.page1.mrdg011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL cq_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdg011  #顯示到畫面上
            NEXT FIELD mrdg011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg011
            #add-point:BEFORE FIELD mrdg011 name="construct.b.page1.mrdg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg011
            
            #add-point:AFTER FIELD mrdg011 name="construct.a.page1.mrdg011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg012
            #add-point:BEFORE FIELD mrdg012 name="construct.b.page1.mrdg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg012
            
            #add-point:AFTER FIELD mrdg012 name="construct.a.page1.mrdg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg012
            #add-point:ON ACTION controlp INFIELD mrdg012 name="construct.c.page1.mrdg012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg014
            #add-point:ON ACTION controlp INFIELD mrdg014 name="construct.c.page1.mrdg014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdg014  #顯示到畫面上
            NEXT FIELD mrdg014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg014
            #add-point:BEFORE FIELD mrdg014 name="construct.b.page1.mrdg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg014
            
            #add-point:AFTER FIELD mrdg014 name="construct.a.page1.mrdg014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg013
            #add-point:BEFORE FIELD mrdg013 name="construct.b.page1.mrdg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg013
            
            #add-point:AFTER FIELD mrdg013 name="construct.a.page1.mrdg013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg013
            #add-point:ON ACTION controlp INFIELD mrdg013 name="construct.c.page1.mrdg013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdgsite
            #add-point:BEFORE FIELD mrdgsite name="construct.b.page1.mrdgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdgsite
            
            #add-point:AFTER FIELD mrdgsite name="construct.a.page1.mrdgsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdgsite
            #add-point:ON ACTION controlp INFIELD mrdgsite name="construct.c.page1.mrdgsite"
            
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
                  WHEN la_wc[li_idx].tableid = "mrdf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrdg_t" 
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
 
{<section id="amrt250.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrt250_filter()
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
      CONSTRUCT g_wc_filter ON mrdfdocno,mrdfdocdt,mrdf001,mrdf002,mrdf003,mrdfcrtid,mrdfcrtdt,mrdfmodid, 
          mrdfmoddt
                          FROM s_browse[1].b_mrdfdocno,s_browse[1].b_mrdfdocdt,s_browse[1].b_mrdf001, 
                              s_browse[1].b_mrdf002,s_browse[1].b_mrdf003,s_browse[1].b_mrdfcrtid,s_browse[1].b_mrdfcrtdt, 
                              s_browse[1].b_mrdfmodid,s_browse[1].b_mrdfmoddt
 
         BEFORE CONSTRUCT
               DISPLAY amrt250_filter_parser('mrdfdocno') TO s_browse[1].b_mrdfdocno
            DISPLAY amrt250_filter_parser('mrdfdocdt') TO s_browse[1].b_mrdfdocdt
            DISPLAY amrt250_filter_parser('mrdf001') TO s_browse[1].b_mrdf001
            DISPLAY amrt250_filter_parser('mrdf002') TO s_browse[1].b_mrdf002
            DISPLAY amrt250_filter_parser('mrdf003') TO s_browse[1].b_mrdf003
            DISPLAY amrt250_filter_parser('mrdfcrtid') TO s_browse[1].b_mrdfcrtid
            DISPLAY amrt250_filter_parser('mrdfcrtdt') TO s_browse[1].b_mrdfcrtdt
            DISPLAY amrt250_filter_parser('mrdfmodid') TO s_browse[1].b_mrdfmodid
            DISPLAY amrt250_filter_parser('mrdfmoddt') TO s_browse[1].b_mrdfmoddt
      
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
 
      CALL amrt250_filter_show('mrdfdocno')
   CALL amrt250_filter_show('mrdfdocdt')
   CALL amrt250_filter_show('mrdf001')
   CALL amrt250_filter_show('mrdf002')
   CALL amrt250_filter_show('mrdf003')
   CALL amrt250_filter_show('mrdfcrtid')
   CALL amrt250_filter_show('mrdfcrtdt')
   CALL amrt250_filter_show('mrdfmodid')
   CALL amrt250_filter_show('mrdfmoddt')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrt250_filter_parser(ps_field)
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
 
{<section id="amrt250.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrt250_filter_show(ps_field)
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
   LET ls_condition = amrt250_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrt250_query()
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
   CALL g_mrdg_d.clear()
 
   
   #add-point:query段other name="query.other"
 
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrt250_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrt250_browser_fill("")
      CALL amrt250_fetch("")
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
      CALL amrt250_filter_show('mrdfdocno')
   CALL amrt250_filter_show('mrdfdocdt')
   CALL amrt250_filter_show('mrdf001')
   CALL amrt250_filter_show('mrdf002')
   CALL amrt250_filter_show('mrdf003')
   CALL amrt250_filter_show('mrdfcrtid')
   CALL amrt250_filter_show('mrdfcrtdt')
   CALL amrt250_filter_show('mrdfmodid')
   CALL amrt250_filter_show('mrdfmoddt')
   CALL amrt250_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrt250_fetch("F") 
      #顯示單身筆數
      CALL amrt250_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrt250_fetch(p_flag)
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
   
   LET g_mrdf_m.mrdfdocno = g_browser[g_current_idx].b_mrdfdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
       g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
       g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
       g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
       g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfownid_desc, 
       g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
   
   #遮罩相關處理
   LET g_mrdf_m_mask_o.* =  g_mrdf_m.*
   CALL amrt250_mrdf_t_mask()
   LET g_mrdf_m_mask_n.* =  g_mrdf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt250_set_act_visible()   
   CALL amrt250_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL amrt250_set_act_visible()
   CALL amrt250_set_act_no_visible()
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrdf_m_t.* = g_mrdf_m.*
   LET g_mrdf_m_o.* = g_mrdf_m.*
   
   LET g_data_owner = g_mrdf_m.mrdfownid      
   LET g_data_dept  = g_mrdf_m.mrdfowndp
   
   #重新顯示   
   CALL amrt250_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrt250_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mrdg_d.clear()   
 
 
   INITIALIZE g_mrdf_m.* TO NULL             #DEFAULT 設定
   
   LET g_mrdfdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdf_m.mrdfownid = g_user
      LET g_mrdf_m.mrdfowndp = g_dept
      LET g_mrdf_m.mrdfcrtid = g_user
      LET g_mrdf_m.mrdfcrtdp = g_dept 
      LET g_mrdf_m.mrdfcrtdt = cl_get_current()
      LET g_mrdf_m.mrdfmodid = g_user
      LET g_mrdf_m.mrdfmoddt = cl_get_current()
      LET g_mrdf_m.mrdfstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mrdf_m.mrdf001 = "6"
      LET g_mrdf_m.mrdf004 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mrdf_m.mrdfsite = g_site
      LET g_mrdf_m.mrdfdocdt = g_today
      LET g_mrdf_m.mrdf002 = g_user
      LET g_mrdf_m.mrdf003 = g_dept
      CALL s_desc_get_person_desc(g_mrdf_m.mrdf002) RETURNING g_mrdf_m.mrdf002_desc
      CALL s_desc_get_department_desc(g_mrdf_m.mrdf003) RETURNING g_mrdf_m.mrdf003_desc
      DISPLAY BY NAME g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc
#      LET g_mrdf_m_t.* = g_mrdf_m.*
#      LET g_mrdf_m_o.* = g_mrdf_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrdf_m_t.* = g_mrdf_m.*
      LET g_mrdf_m_o.* = g_mrdf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdf_m.mrdfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL amrt250_input("a")
      
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
         INITIALIZE g_mrdf_m.* TO NULL
         INITIALIZE g_mrdg_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrt250_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mrdg_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt250_set_act_visible()   
   CALL amrt250_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdfent = " ||g_enterprise|| " AND",
                      " mrdfdocno = '", g_mrdf_m.mrdfdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt250_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrt250_cl
   
   CALL amrt250_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
       g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
       g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
       g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
       g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfownid_desc, 
       g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
   
   
   #遮罩相關處理
   LET g_mrdf_m_mask_o.* =  g_mrdf_m.*
   CALL amrt250_mrdf_t_mask()
   LET g_mrdf_m_mask_n.* =  g_mrdf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002, 
       g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004, 
       g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf005_desc,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid, 
       g_mrdf_m.mrdfownid_desc,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtid_desc, 
       g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfcnfdt,g_mrdf_m.mrdfpstid, 
       g_mrdf_m.mrdfpstid_desc,g_mrdf_m.mrdfpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mrdf_m.mrdfownid      
   LET g_data_dept  = g_mrdf_m.mrdfowndp
   
   #功能已完成,通報訊息中心
   CALL amrt250_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrt250_modify()
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
   LET g_mrdf_m_t.* = g_mrdf_m.*
   LET g_mrdf_m_o.* = g_mrdf_m.*
   
   IF g_mrdf_m.mrdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
   CALL s_transaction_begin()
   
   OPEN amrt250_cl USING g_enterprise,g_mrdf_m.mrdfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt250_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt250_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
       g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
       g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
       g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
       g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfownid_desc, 
       g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
   
   #檢查是否允許此動作
   IF NOT amrt250_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdf_m_mask_o.* =  g_mrdf_m.*
   CALL amrt250_mrdf_t_mask()
   LET g_mrdf_m_mask_n.* =  g_mrdf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL amrt250_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mrdf_m.mrdfmodid = g_user 
LET g_mrdf_m.mrdfmoddt = cl_get_current()
LET g_mrdf_m.mrdfmodid_desc = cl_get_username(g_mrdf_m.mrdfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrt250_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mrdf_t SET (mrdfmodid,mrdfmoddt) = (g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt)
          WHERE mrdfent = g_enterprise AND mrdfdocno = g_mrdfdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrdf_m.* = g_mrdf_m_t.*
            CALL amrt250_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrdf_m.mrdfdocno != g_mrdf_m_t.mrdfdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mrdg_t SET mrdgdocno = g_mrdf_m.mrdfdocno
 
          WHERE mrdgent = g_enterprise AND mrdgdocno = g_mrdf_m_t.mrdfdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrdg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdg_t:",SQLERRMESSAGE 
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
   CALL amrt250_set_act_visible()   
   CALL amrt250_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrdfent = " ||g_enterprise|| " AND",
                      " mrdfdocno = '", g_mrdf_m.mrdfdocno, "' "
 
   #填到對應位置
   CALL amrt250_browser_fill("")
 
   CLOSE amrt250_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt250_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrt250.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrt250_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
DEFINE l_tt LIKE type_t.num10 #add by yangxb 170406
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
   DEFINE l_count_1              LIKE type_t.num5
   DEFINE l_ooef004              LIKE ooef_t.ooef004
   DEFINE l_flag                 LIKE type_t.num5
   DEFINE l_mrdd001              LIKE mrdd_t.mrdd001
   DEFINE l_mrdd002              LIKE mrdd_t.mrdd002
   DEFINE l_mrdg004              LIKE mrdg_t.mrdg004
   DEFINE l_mrba004              LIKE mrba_t.mrba004
   DEFINE l_mrba008              LIKE mrba_t.mrba008
   DEFINE l_mrba009              LIKE mrba_t.mrba009
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_where                STRING  #160204-00004#5 20160222 s983961--add
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
   DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002, 
       g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004, 
       g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf005_desc,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid, 
       g_mrdf_m.mrdfownid_desc,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtid_desc, 
       g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfcnfdt,g_mrdf_m.mrdfpstid, 
       g_mrdf_m.mrdfpstid_desc,g_mrdf_m.mrdfpstdt
   
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
   LET g_forupd_sql = "SELECT mrdgseq,mrdg001,mrdg002,mrdg003,mrdg004,mrdg005,mrdg006,mrdg007,mrdg008, 
       mrdg009,mrdg010,mrdg011,mrdg012,mrdg014,mrdg013,mrdgsite FROM mrdg_t WHERE mrdgent=? AND mrdgdocno=?  
       AND mrdgseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt250_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrt250_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amrt250_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003, 
       g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf006
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrt250.input.head" >}
      #單頭段
      INPUT BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003, 
          g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf006 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrt250_cl USING g_enterprise,g_mrdf_m.mrdfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt250_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt250_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrt250_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amrt250_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfdocno
            
            #add-point:AFTER FIELD mrdfdocno name="input.a.mrdfdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
            DISPLAY BY NAME g_mrdf_m.mrdfdocno_desc
            IF cl_null(g_mrdf_m.mrdfdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'   #單號欄位不可為空！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            ELSE
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrdf_m.mrdfdocno != g_mrdfdocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdf_t WHERE "||"mrdfent = '" ||g_enterprise|| "' AND "||"mrdfdocno = '"||g_mrdf_m.mrdfdocno ||"'",'std-00004',0) THEN 
                     LET g_mrdf_m.mrdfdocno = g_mrdfdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
                     DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_mrdf_m.mrdfdocno,g_prog) THEN
                     LET g_mrdf_m.mrdfdocno = g_mrdfdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
                     DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
                  DISPLAY BY NAME g_mrdf_m.mrdfdocno_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfdocno
            #add-point:BEFORE FIELD mrdfdocno name="input.b.mrdfdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdfdocno
            #add-point:ON CHANGE mrdfdocno name="input.g.mrdfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfdocdt
            #add-point:BEFORE FIELD mrdfdocdt name="input.b.mrdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfdocdt
            
            #add-point:AFTER FIELD mrdfdocdt name="input.a.mrdfdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdfdocdt
            #add-point:ON CHANGE mrdfdocdt name="input.g.mrdfdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf001
            #add-point:BEFORE FIELD mrdf001 name="input.b.mrdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf001
            
            #add-point:AFTER FIELD mrdf001 name="input.a.mrdf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdf001
            #add-point:ON CHANGE mrdf001 name="input.g.mrdf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf002
            
            #add-point:AFTER FIELD mrdf002 name="input.a.mrdf002"
            CALL s_desc_get_person_desc(g_mrdf_m.mrdf002) RETURNING g_mrdf_m.mrdf002_desc
            DISPLAY BY NAME g_mrdf_m.mrdf002_desc
            IF NOT cl_null(g_mrdf_m.mrdf002) THEN 
               IF g_mrdf_m.mrdf002 <> g_mrdf_m_o.mrdf002 OR cl_null(g_mrdf_m_o.mrdf002) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdf_m.mrdf002
                  
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                  #抓取業務人員對應的部門預設到xmdg003
                     SELECT ooag003 INTO g_mrdf_m.mrdf003 FROM ooag_t
                      WHERE ooagent = g_enterprise AND ooag001 = g_mrdf_m.mrdf002
                     CALL s_desc_get_department_desc(g_mrdf_m.mrdf003) RETURNING g_mrdf_m.mrdf003_desc
                     DISPLAY BY NAME g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc
                  ELSE
                     LET g_mrdf_m.mrdf002 = g_mrdf_m_o.mrdf002
                     CALL s_desc_get_person_desc(g_mrdf_m.mrdf002) RETURNING g_mrdf_m.mrdf002_desc
                     DISPLAY BY NAME g_mrdf_m.mrdf002,g_mrdf_m.mrdf002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 
            
            LET g_mrdf_m_o.mrdf002 = g_mrdf_m.mrdf002

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf002
            #add-point:BEFORE FIELD mrdf002 name="input.b.mrdf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdf002
            #add-point:ON CHANGE mrdf002 name="input.g.mrdf002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf003
            
            #add-point:AFTER FIELD mrdf003 name="input.a.mrdf003"
            IF NOT cl_null(g_mrdf_m.mrdf003) THEN 
               IF g_mrdf_m.mrdf003 <> g_mrdf_m_o.mrdf003 OR cl_null(g_mrdf_m_o.mrdf003) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdf_m.mrdf003
                  LET g_chkparam.arg2 = g_mrdf_m.mrdfdocdt
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mrdf_m.mrdf003 = g_mrdf_m_o.mrdf003 
                     CALL s_desc_get_department_desc(g_mrdf_m.mrdf003) RETURNING g_mrdf_m.mrdf003_desc
                     DISPLAY BY NAME g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdf_m.mrdf003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdf_m.mrdf003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdf_m.mrdf003_desc
            LET g_mrdf_m_o.mrdf003 = g_mrdf_m.mrdf003

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf003
            #add-point:BEFORE FIELD mrdf003 name="input.b.mrdf003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdf003
            #add-point:ON CHANGE mrdf003 name="input.g.mrdf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfstus
            #add-point:BEFORE FIELD mrdfstus name="input.b.mrdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfstus
            
            #add-point:AFTER FIELD mrdfstus name="input.a.mrdfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdfstus
            #add-point:ON CHANGE mrdfstus name="input.g.mrdfstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf004
            #add-point:BEFORE FIELD mrdf004 name="input.b.mrdf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf004
            
            #add-point:AFTER FIELD mrdf004 name="input.a.mrdf004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdf004
            #add-point:ON CHANGE mrdf004 name="input.g.mrdf004"
            LET g_mrdf_m.mrdf005 = ''
            LET g_mrdf_m.mrdf005 = ''
            DISPLAY BY NAME g_mrdf_m.mrdf005,g_mrdf_m.mrdf005_desc
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdfsite
            #add-point:BEFORE FIELD mrdfsite name="input.b.mrdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdfsite
            
            #add-point:AFTER FIELD mrdfsite name="input.a.mrdfsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdfsite
            #add-point:ON CHANGE mrdfsite name="input.g.mrdfsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf005
            
            #add-point:AFTER FIELD mrdf005 name="input.a.mrdf005"
            LET g_mrdf_m.mrdf005_desc = ''
            DISPLAY BY NAME g_mrdf_m.mrdf005_desc
            IF NOT cl_null(g_mrdf_m.mrdf005) THEN
               IF g_mrdf_m.mrdf005 <> g_mrdf_m_o.mrdf005 OR cl_null(g_mrdf_m_o.mrdf005) THEN
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdf_m.mrdf005 != g_mrdf_m_t.mrdf005 OR g_mrdf_m_t.mrdf005 IS NULL )) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     CASE g_mrdf_m.mrdf004
                        WHEN '1'    #部門
                           LET g_chkparam.arg1 = g_mrdf_m.mrdf005
                           LET g_chkparam.arg2 = g_mrdf_m.mrdfdocdt
                           #160318-00025#24  by 07900 --add-str
                           LET g_errshow = TRUE #是否開窗                   
                           LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                           #160318-00025#24  by 07900 --add-end  
                           IF NOT cl_chk_exist("v_ooeg001") THEN
                              IF g_mrdf_m.mrdf004 = g_mrdf_m_t.mrdf004 THEN
                                 LET g_mrdf_m.mrdf005 = g_mrdf_m_t.mrdf005
                              ELSE
                                 LET g_mrdf_m.mrdf005 = ''
                              END IF
                              CALL amrt250_mrdf005_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '2'    #據點
                           LET g_chkparam.arg1 = g_mrdf_m.mrdf005
                           #160318-00025#24  by 07900 --add-str
                           LET g_errshow = TRUE #是否開窗                   
                           LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                          #160318-00025#24  by 07900 --add-end
                           IF NOT cl_chk_exist("v_ooef001") THEN
                              IF g_mrdf_m.mrdf004 = g_mrdf_m_t.mrdf004 THEN
                                 LET g_mrdf_m.mrdf005 = g_mrdf_m_t.mrdf005
                              ELSE
                                 LET g_mrdf_m.mrdf005 = ''
                              END IF
                              CALL amrt250_mrdf005_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '3'    #廠商
                           LET g_chkparam.arg1 = g_mrdf_m.mrdf005
                           IF NOT cl_chk_exist("v_pmaa001_1") THEN
                              IF g_mrdf_m.mrdf004 = g_mrdf_m_t.mrdf004 THEN
                                 LET g_mrdf_m.mrdf005 = g_mrdf_m_t.mrdf005
                              ELSE
                                 LET g_mrdf_m.mrdf005 = ''
                              END IF
                              CALL amrt250_mrdf005_ref()
                              NEXT FIELD CURRENT
                           END IF
                        WHEN '4'    #客戶
                           LET g_chkparam.arg1 = g_mrdf_m.mrdf005
                           LET g_chkparam.arg2 = g_site
                           #160318-00025#24  by 07900 --add-str
                           LET g_errshow = TRUE #是否開窗                   
                           LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                           #160318-00025#24  by 07900 --add-end
                           IF NOT cl_chk_exist("v_pmaa001_3") THEN
                              IF g_mrdf_m.mrdf004 = g_mrdf_m_t.mrdf004 THEN
                                 LET g_mrdf_m.mrdf005 = g_mrdf_m_t.mrdf005
                              ELSE
                                 LET g_mrdf_m.mrdf005 = ''
                              END IF
                              CALL amrt250_mrdf005_ref()
                              NEXT FIELD CURRENT
                           END IF
                     END CASE
                  END IF
               END IF
            END IF
            CALL amrt250_mrdf005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf005
            #add-point:BEFORE FIELD mrdf005 name="input.b.mrdf005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdf005
            #add-point:ON CHANGE mrdf005 name="input.g.mrdf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdf006
            #add-point:BEFORE FIELD mrdf006 name="input.b.mrdf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdf006
            
            #add-point:AFTER FIELD mrdf006 name="input.a.mrdf006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdf006
            #add-point:ON CHANGE mrdf006 name="input.g.mrdf006"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfdocno
            #add-point:ON ACTION controlp INFIELD mrdfdocno name="input.c.mrdfdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               AND ooefstus = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdf_m.mrdfdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #

            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mrdf_m.mrdfdocno = g_qryparam.return1              
            CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
            DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc
            DISPLAY g_mrdf_m.mrdfdocno TO mrdfdocno              #

            NEXT FIELD mrdfdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrdfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfdocdt
            #add-point:ON ACTION controlp INFIELD mrdfdocdt name="input.c.mrdfdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf001
            #add-point:ON ACTION controlp INFIELD mrdf001 name="input.c.mrdf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf002
            #add-point:ON ACTION controlp INFIELD mrdf002 name="input.c.mrdf002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdf_m.mrdf002             #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_mrdf_m.mrdf002 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_mrdf_m.mrdf002) RETURNING g_mrdf_m.mrdf002_desc
#            SELECT ooag003 INTO g_mrdf_m.mrdf003 FROM ooag_t
#             WHERE ooagent = g_enterprise AND ooag001 = g_mrdf_m.mrdf002
#            CALL s_desc_get_department_desc(g_mrdf_m.mrdf003) RETURNING g_mrdf_m.mrdf003_desc
            DISPLAY BY NAME g_mrdf_m.mrdf002_desc#,g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc
            DISPLAY g_mrdf_m.mrdf002 TO mrdf002              #
            NEXT FIELD mrdf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrdf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf003
            #add-point:ON ACTION controlp INFIELD mrdf003 name="input.c.mrdf003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdf_m.mrdf003             #給予default值
            #給予arg            
            LET g_qryparam.arg1 = g_mrdf_m.mrdfdocdt
            CALL q_ooeg001()                                #呼叫開窗
            LET g_mrdf_m.mrdf003 = g_qryparam.return1
            CALL s_desc_get_department_desc(g_mrdf_m.mrdf003) RETURNING g_mrdf_m.mrdf003_desc
            DISPLAY BY NAME g_mrdf_m.mrdf003_desc
            DISPLAY g_mrdf_m.mrdf003 TO mrdf003
            NEXT FIELD mrdf003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfstus
            #add-point:ON ACTION controlp INFIELD mrdfstus name="input.c.mrdfstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf004
            #add-point:ON ACTION controlp INFIELD mrdf004 name="input.c.mrdf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdfsite
            #add-point:ON ACTION controlp INFIELD mrdfsite name="input.c.mrdfsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf005
            #add-point:ON ACTION controlp INFIELD mrdf005 name="input.c.mrdf005"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdf_m.mrdf005             #給予default值
            
            CASE g_mrdf_m.mrdf004
               WHEN '1'    #部門
                  LET g_qryparam.arg1 = g_mrdf_m.mrdfdocdt
                  CALL q_ooeg001()
               WHEN '2'    #據點
                  #mod--161013-00051#1 By shiun--(S)
#                  CALL q_ooef001()
                  CALL q_ooef001_1()
                  #mod--161013-00051#1 By shiun--(E)
               WHEN '3'    #廠商
                 #LET g_qryparam.where = " (pmaa002='1' OR pmaa002 = '3')"    #160909-00080#1 mark
                 #CALL q_pmaa001_8()         #160909-00080#1 mark
                 CALL q_pmaa001_10()         #160909-00080#1
               WHEN '4'    #客戶
                 #LET g_qryparam.where = " (pmaa002='2' OR pmaa002 = '3')"    #160909-00080#1 mark
                 #CALL q_pmaa001_8()         #160909-00080#1 mark
                 CALL q_pmaa001_13()         #160909-00080#1
            END CASE
            LET g_mrdf_m.mrdf005 = g_qryparam.return1    
            DISPLAY g_mrdf_m.mrdf005 TO mrdf005
            CALL amrt250_mrdf005_ref()
            NEXT FIELD mrdf005 
            #END add-point
 
 
         #Ctrlp:input.c.mrdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdf006
            #add-point:ON ACTION controlp INFIELD mrdf006 name="input.c.mrdf006"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrdf_m.mrdfdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF NOT s_aooi200_chk_slip(g_site,'',g_mrdf_m.mrdfdocno,g_prog) THEN
                  LET g_mrdf_m.mrdfdocno = ''
                  NEXT FIELD mrdfdocno
               END IF

               CALL s_aooi200_gen_docno(g_site,g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt,g_prog) RETURNING l_flag,g_mrdf_m.mrdfdocno
               IF NOT l_flag THEN
                  NEXT FIELD mrdfdocno
               END IF
               #end add-point
               
               INSERT INTO mrdf_t (mrdfent,mrdfdocno,mrdfdocdt,mrdf001,mrdf002,mrdf003,mrdfstus,mrdf004, 
                   mrdfsite,mrdf005,mrdf006,mrdfownid,mrdfowndp,mrdfcrtid,mrdfcrtdp,mrdfcrtdt,mrdfmodid, 
                   mrdfmoddt,mrdfcnfid,mrdfcnfdt,mrdfpstid,mrdfpstdt)
               VALUES (g_enterprise,g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002, 
                   g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005, 
                   g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
                   g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
                   g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrdf_m:",SQLERRMESSAGE 
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
                  CALL amrt250_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrt250_b_fill()
                  CALL amrt250_b_fill2('0')
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
               CALL amrt250_mrdf_t_mask_restore('restore_mask_o')
               
               UPDATE mrdf_t SET (mrdfdocno,mrdfdocdt,mrdf001,mrdf002,mrdf003,mrdfstus,mrdf004,mrdfsite, 
                   mrdf005,mrdf006,mrdfownid,mrdfowndp,mrdfcrtid,mrdfcrtdp,mrdfcrtdt,mrdfmodid,mrdfmoddt, 
                   mrdfcnfid,mrdfcnfdt,mrdfpstid,mrdfpstdt) = (g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
                   g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004, 
                   g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp, 
                   g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt, 
                   g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt,g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt)
                WHERE mrdfent = g_enterprise AND mrdfdocno = g_mrdfdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrdf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrt250_mrdf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrdf_m_t)
               LET g_log2 = util.JSON.stringify(g_mrdf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrt250.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrdg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrt250_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mrdg_d.getLength()
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
            OPEN amrt250_cl USING g_enterprise,g_mrdf_m.mrdfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt250_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt250_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdg_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdg_d[l_ac].mrdgseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrdg_d_t.* = g_mrdg_d[l_ac].*  #BACKUP
               LET g_mrdg_d_o.* = g_mrdg_d[l_ac].*  #BACKUP
               CALL amrt250_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amrt250_set_no_entry_b(l_cmd)
               IF NOT amrt250_lock_b("mrdg_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt250_bcl INTO g_mrdg_d[l_ac].mrdgseq,g_mrdg_d[l_ac].mrdg001,g_mrdg_d[l_ac].mrdg002, 
                      g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006, 
                      g_mrdg_d[l_ac].mrdg007,g_mrdg_d[l_ac].mrdg008,g_mrdg_d[l_ac].mrdg009,g_mrdg_d[l_ac].mrdg010, 
                      g_mrdg_d[l_ac].mrdg011,g_mrdg_d[l_ac].mrdg012,g_mrdg_d[l_ac].mrdg014,g_mrdg_d[l_ac].mrdg013, 
                      g_mrdg_d[l_ac].mrdgsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mrdg_d_t.mrdgseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdg_d_mask_o[l_ac].* =  g_mrdg_d[l_ac].*
                  CALL amrt250_mrdg_t_mask()
                  LET g_mrdg_d_mask_n[l_ac].* =  g_mrdg_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt250_show()
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
            INITIALIZE g_mrdg_d[l_ac].* TO NULL 
            INITIALIZE g_mrdg_d_t.* TO NULL 
            INITIALIZE g_mrdg_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mrdg_d[l_ac].mrdg004 = "0"
      LET g_mrdg_d[l_ac].mrdg011 = "1"
      LET g_mrdg_d[l_ac].mrdg012 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(mrdgseq) INTO g_mrdg_d[l_ac].mrdgseq
              FROM mrdg_t
             WHERE mrdgent = g_enterprise
               AND mrdgdocno = g_mrdf_m.mrdfdocno
            IF cl_null(g_mrdg_d[l_ac].mrdgseq) THEN
               LET g_mrdg_d[l_ac].mrdgseq = 1
            ELSE
               LET g_mrdg_d[l_ac].mrdgseq = g_mrdg_d[l_ac].mrdgseq + 1
            END IF
            
            LET g_mrdg_d[l_ac].mrdg011 = ""#add by yangxb 170406
            #end add-point
            LET g_mrdg_d_t.* = g_mrdg_d[l_ac].*     #新輸入資料
            LET g_mrdg_d_o.* = g_mrdg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt250_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amrt250_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdg_d[li_reproduce_target].* = g_mrdg_d[li_reproduce].*
 
               LET g_mrdg_d[li_reproduce_target].mrdgseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_mrdg_d[g_mrdg_d.getLength()].mrdgsite = g_site
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
            SELECT COUNT(1) INTO l_count FROM mrdg_t 
             WHERE mrdgent = g_enterprise AND mrdgdocno = g_mrdf_m.mrdfdocno
 
               AND mrdgseq = g_mrdg_d[l_ac].mrdgseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdf_m.mrdfdocno
               LET gs_keys[2] = g_mrdg_d[g_detail_idx].mrdgseq
               CALL amrt250_insert_b('mrdg_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mrdg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt250_b_fill()
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
               LET gs_keys[01] = g_mrdf_m.mrdfdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mrdg_d_t.mrdgseq
 
            
               #刪除同層單身
               IF NOT amrt250_delete_b('mrdg_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt250_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrt250_key_delete_b(gs_keys,'mrdg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt250_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt250_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mrdg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdgseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdg_d[l_ac].mrdgseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdgseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdgseq name="input.a.page1.mrdgseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_mrdf_m.mrdfdocno IS NOT NULL AND g_mrdg_d[g_detail_idx].mrdgseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdf_m.mrdfdocno != g_mrdfdocno_t OR g_mrdg_d[g_detail_idx].mrdgseq != g_mrdg_d_t.mrdgseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdg_t WHERE "||"mrdgent = '" ||g_enterprise|| "' AND "||"mrdgdocno = '"||g_mrdf_m.mrdfdocno ||"' AND "|| "mrdgseq = '"||g_mrdg_d[g_detail_idx].mrdgseq ||"'",'std-00004',0) THEN 
                     LET g_mrdg_d[g_detail_idx].mrdgseq = g_mrdg_d_t.mrdgseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdgseq
            #add-point:BEFORE FIELD mrdgseq name="input.b.page1.mrdgseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdgseq
            #add-point:ON CHANGE mrdgseq name="input.g.page1.mrdgseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg001
            
            #add-point:AFTER FIELD mrdg001 name="input.a.page1.mrdg001"
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg001) THEN                           
               IF g_mrdg_d[l_ac].mrdg001 <> g_mrdg_d_o.mrdg001 OR cl_null(g_mrdg_d_o.mrdg001) THEN                  
                  #160204-00004#5 20160223 s983961--add(s)         
                  IF NOT s_aooi210_check_doc(g_site,'',g_mrdg_d[l_ac].mrdg001, g_mrdf_m.mrdfdocno ,'4','') THEN
                     LET g_mrdg_d[l_ac].mrdg001 = g_mrdg_d_o.mrdg001
                     DISPLAY BY NAME g_mrdg_d[l_ac].mrdg001                        
                     NEXT FIELD CURRENT               
                  END IF
                  #160204-00004#5 20160223 s983961--add(e)   
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdg_d[l_ac].mrdg001
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_mrdcdocno") THEN
                     IF NOT (cl_null(g_mrdg_d[l_ac].mrdg002) OR cl_null(g_mrdg_d[l_ac].mrdg001)) THEN 
                        INITIALIZE g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007 TO NULL
                        LET l_count_1 = 0
                        LET l_mrdd002 = 0
                        LET l_mrdg004 = 0
                        CALL amrt250_count() RETURNING l_count_1
                        IF NOT l_count_1 THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = "amr-00095" 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           NEXT FIELD mrdg001
                        END IF
                        CALL amrt250_mrdd002_mrdg004_count() RETURNING l_mrdd001,l_mrdd002,l_mrdg004
                        IF l_mrdg004 >= l_mrdd002 THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "" 
                           LET g_errparam.code   = "amr-00096" 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           NEXT FIELD mrdg001
                        END IF
                        CALL amrt250_mrdg001_mrdg002_ref(l_mrdd001,l_mrdd002,l_mrdg004)
                     END IF 
                     
                  ELSE
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF   
            END IF 
            LET g_mrdg_d_o.mrdg001 = g_mrdg_d[l_ac].mrdg001
            CALL amrt250_set_entry_b(l_cmd)
            CALL amrt250_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg001
            #add-point:BEFORE FIELD mrdg001 name="input.b.page1.mrdg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg001
            #add-point:ON CHANGE mrdg001 name="input.g.page1.mrdg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg002
            #add-point:BEFORE FIELD mrdg002 name="input.b.page1.mrdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg002
            
            #add-point:AFTER FIELD mrdg002 name="input.a.page1.mrdg002"
            #shiun a
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg002) THEN
               IF g_mrdg_d[l_ac].mrdg002 <> g_mrdg_d_o.mrdg002 OR cl_null(g_mrdg_d_o.mrdg002) THEN
                  IF NOT (cl_null(g_mrdg_d[l_ac].mrdg002) OR cl_null(g_mrdg_d[l_ac].mrdg001)) THEN 
                     INITIALIZE g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007 TO NULL
                     LET l_count_1 = 0
                     LET l_mrdd002 = 0
                     LET l_mrdg004 = 0
                     CALL amrt250_count() RETURNING l_count_1
                     IF NOT l_count_1 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "amr-00095" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD mrdg002
                     END IF
                     CALL amrt250_mrdd002_mrdg004_count() RETURNING l_mrdd001,l_mrdd002,l_mrdg004
                     IF l_mrdg004 >= l_mrdd002 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "amr-00096" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD mrdg002
                     END IF
                     CALL amrt250_mrdg001_mrdg002_ref(l_mrdd001,l_mrdd002,l_mrdg004)
                  END IF
               END IF
            END IF
            LET g_mrdg_d_o.mrdg002 = g_mrdg_d[l_ac].mrdg002
            CALL amrt250_set_entry_b(l_cmd)
            CALL amrt250_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg002
            #add-point:ON CHANGE mrdg002 name="input.g.page1.mrdg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg003
            
            #add-point:AFTER FIELD mrdg003 name="input.a.page1.mrdg003"
            LET g_mrdg_d[l_ac].mrdg003_desc = ' '
            LET g_mrdg_d[l_ac].mrba008 = ' '
            LET g_mrdg_d[l_ac].mrba009 = ' '
            DISPLAY BY NAME g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdg_d[l_ac].mrdg003 != g_mrdg_d_t.mrdg003 OR g_mrdg_d_t.mrdg003 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdg_d[l_ac].mrdg003
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#24  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_mrba001_5") THEN
                     LET g_mrdg_d[l_ac].mrdg003 = g_mrdg_d_t.mrdg003
                     CALL amrt250_mrdg003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               CALL amrt250_mrdg003_ref()
            END IF
            LET g_mrdg_d_o.mrdg003 = g_mrdg_d[l_ac].mrdg003
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg003
            #add-point:BEFORE FIELD mrdg003 name="input.b.page1.mrdg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg003
            #add-point:ON CHANGE mrdg003 name="input.g.page1.mrdg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdg_d[l_ac].mrdg004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdg004
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdg004 name="input.a.page1.mrdg004"
            #shiun
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg004) THEN
#               IF g_mrdg_d[l_ac].mrdg004 <> g_mrdg_d_o.mrdg004 OR cl_null(g_mrdg_d_o.mrdg004) THEN

#                  IF NOT(cl_null(g_mrdg_d[l_ac].mrdg001) OR cl_null(g_mrdg_d[l_ac].mrdg002)) THEN
                     LET l_success = TRUE
                     CALL s_amrt250_mrdg004_chk(g_mrdf_m.mrdfdocno,g_mrdg_d[l_ac].mrdgseq,g_mrdg_d[l_ac].mrdg001,g_mrdg_d[l_ac].mrdg002,g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg004)
                     RETURNING l_success
#                     LET l_mrdd002 = 0
#                     LET l_mrdg004 = 0
#                     SELECT mrdd001,mrdd002 INTO l_mrdd001,l_mrdd002
#                       FROM mrdd_t
#                      WHERE mrddent = g_enterprise
#                        AND mrddsite = g_site
#                        AND mrdddocno = g_mrdg_d[l_ac].mrdg001
#                        AND mrddseq = g_mrdg_d[l_ac].mrdg002
#                     SELECT COALESCE(SUM(mrdg004),0) INTO l_mrdg004
#                       FROM mrdg_t,mrdf_t
#                      WHERE mrdfent = mrdgent
#                        AND mrdfdocno = mrdgdocno
#                        AND mrdgent = g_enterprise
#                        AND mrdgsite = g_site
#                        AND mrdfstus != 'X'
#                        AND mrdg001 = g_mrdg_d[l_ac].mrdg001
#                        AND mrdg002 = g_mrdg_d[l_ac].mrdg002
#                        AND mrdgseq != g_mrdg_d[l_ac].mrdgseq
#                        AND mrdg003 = l_mrdd001
                     
                     IF NOT l_success THEN
                        NEXT FIELD mrdg004
                     END IF
#                  END IF
#               END IF
            END IF
            LET g_mrdg_d_o.mrdg004 = g_mrdg_d[l_ac].mrdg004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg004
            #add-point:BEFORE FIELD mrdg004 name="input.b.page1.mrdg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg004
            #add-point:ON CHANGE mrdg004 name="input.g.page1.mrdg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg005
            #add-point:BEFORE FIELD mrdg005 name="input.b.page1.mrdg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg005
            
            #add-point:AFTER FIELD mrdg005 name="input.a.page1.mrdg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg005
            #add-point:ON CHANGE mrdg005 name="input.g.page1.mrdg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg006
            
            #add-point:AFTER FIELD mrdg006 name="input.a.page1.mrdg006"
            LET g_mrdg_d[l_ac].mrdg006_desc = ''
            DISPLAY BY NAME g_mrdg_d[l_ac].mrdg006_desc
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg006) THEN
               IF g_mrdg_d[l_ac].mrdg006 <> g_mrdg_d_o.mrdg006 OR cl_null(g_mrdg_d_o.mrdg006) THEN
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdg_d[l_ac].mrdg006 != g_mrdg_d_t.mrdg006 OR g_mrdg_d_t.mrdg006 IS NULL )) THEN
                     IF NOT s_azzi650_chk_exist('221',g_mrdg_d[l_ac].mrdg006) THEN
                        LET g_mrdg_d[l_ac].mrdg006 = g_mrdg_d_t.mrdg006
                        CALL amrt250_mrdg006_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL amrt250_mrdg006_ref()
            LET g_mrdg_d_o.mrdg006 = g_mrdg_d[l_ac].mrdg006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg006
            #add-point:BEFORE FIELD mrdg006 name="input.b.page1.mrdg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg006
            #add-point:ON CHANGE mrdg006 name="input.g.page1.mrdg006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg007
            
            #add-point:AFTER FIELD mrdg007 name="input.a.page1.mrdg007"
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg007) THEN 
               IF g_mrdg_d[l_ac].mrdg007 <> g_mrdg_d_o.mrdg007 OR cl_null(g_mrdg_d_o.mrdg007) THEN
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mrdg_d[l_ac].mrdg007
                  
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_mrba001_7") THEN
                     INITIALIZE g_mrdg_d[l_ac].mrdg007,g_mrdg_d[l_ac].mrdg007_desc TO NULL
                     DISPLAY BY NAME g_mrdg_d[l_ac].mrdg007,g_mrdg_d[l_ac].mrdg007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL amrt250_mrdg007_ref()
            LET g_mrdg_d_o.mrdg007 = g_mrdg_d[l_ac].mrdg007

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg007
            #add-point:BEFORE FIELD mrdg007 name="input.b.page1.mrdg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg007
            #add-point:ON CHANGE mrdg007 name="input.g.page1.mrdg007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdg_d[l_ac].mrdg008,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdg008
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdg008 name="input.a.page1.mrdg008"
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg008
            #add-point:BEFORE FIELD mrdg008 name="input.b.page1.mrdg008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg008
            #add-point:ON CHANGE mrdg008 name="input.g.page1.mrdg008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdg_d[l_ac].mrdg009,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdg009
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdg009 name="input.a.page1.mrdg009"
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg009) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg009
            #add-point:BEFORE FIELD mrdg009 name="input.b.page1.mrdg009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg009
            #add-point:ON CHANGE mrdg009 name="input.g.page1.mrdg009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg010
            #add-point:BEFORE FIELD mrdg010 name="input.b.page1.mrdg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg010
            
            #add-point:AFTER FIELD mrdg010 name="input.a.page1.mrdg010"
            CALL amrt250_set_entry_b(l_cmd)
            CALL amrt250_set_no_entry_b(l_cmd)
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg010) THEN 
               IF g_mrdg_d[l_ac].mrdg010 <> g_mrdg_d_o.mrdg010 OR cl_null(g_mrdg_d_o.mrdg010) THEN
                  IF g_mrdg_d[l_ac].mrdg010 = '2' THEN
                     #預設幣別
                     SELECT ooef016 INTO g_mrdg_d[l_ac].mrdg014
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_site
                     CALL amrt250_mrdg014_ref()
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg010
            #add-point:ON CHANGE mrdg010 name="input.g.page1.mrdg010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg011
            
            #add-point:AFTER FIELD mrdg011 name="input.a.page1.mrdg011"
 #add by yangxb 170406 start###################3
        IF NOT cl_null(g_mrdg_d[l_ac].mrdg011) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrdg_d[l_ac].mrdg011

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("cv_mrba018") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_mrdg_d[l_ac].mrdg011 = g_mrdg_d_o.mrdg011
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg011
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='9001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mrdg_d[l_ac].mrdg011_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_mrdg_d[l_ac].mrdg011_desc
                  NEXT FIELD CURRENT
               END IF
               LET l_tt = 0
               SELECT count(1) INTO l_tt FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '9001' AND oocq002 = g_mrdg_d[l_ac].mrdg011 AND oocq039 IN ('0','1','2')
               IF l_tt = 0 THEN 
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = g_mrdg_d[l_ac].mrdg011
                 LET g_errparam.code = 'cmr-00001'
                 LET g_errparam.popup = TRUE 
                 CALL cl_err()
                 LET g_mrdg_d[l_ac].mrdg011 = g_mrdg_d_o.mrdg011
                 INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg011
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='9001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_mrdg_d[l_ac].mrdg011_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_mrdg_d[l_ac].mrdg011_desc
                 NEXT FIELD CURRENT
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='9001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdg_d[l_ac].mrdg011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdg_d[l_ac].mrdg011_desc
#add by yangxb 170406  end ######################

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg011
            #add-point:BEFORE FIELD mrdg011 name="input.b.page1.mrdg011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg011
            #add-point:ON CHANGE mrdg011 name="input.g.page1.mrdg011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdg_d[l_ac].mrdg012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdg012
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdg012 name="input.a.page1.mrdg012"
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg012
            #add-point:BEFORE FIELD mrdg012 name="input.b.page1.mrdg012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg012
            #add-point:ON CHANGE mrdg012 name="input.g.page1.mrdg012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg014
            
            #add-point:AFTER FIELD mrdg014 name="input.a.page1.mrdg014"
            IF NOT cl_null(g_mrdg_d[l_ac].mrdg014) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_mrdg_d[l_ac].mrdg014
               #160318-00025#24  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#24  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooaj002") THEN
                  LET g_mrdg_d[l_ac].mrdg014 = g_mrdg_d_o.mrdg014
                  CALL amrt250_mrdg014_ref()
                  NEXT FIELD CURRENT
               END IF
               
               LET g_mrdg_d_o.mrdg014 = g_mrdg_d[l_ac].mrdg014
               CALL amrt250_mrdg014_ref()

            END IF 
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg014
            #add-point:BEFORE FIELD mrdg014 name="input.b.page1.mrdg014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg014
            #add-point:ON CHANGE mrdg014 name="input.g.page1.mrdg014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdg013
            #add-point:BEFORE FIELD mrdg013 name="input.b.page1.mrdg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdg013
            
            #add-point:AFTER FIELD mrdg013 name="input.a.page1.mrdg013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdg013
            #add-point:ON CHANGE mrdg013 name="input.g.page1.mrdg013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdgsite
            #add-point:BEFORE FIELD mrdgsite name="input.b.page1.mrdgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdgsite
            
            #add-point:AFTER FIELD mrdgsite name="input.a.page1.mrdgsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdgsite
            #add-point:ON CHANGE mrdgsite name="input.g.page1.mrdgsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrdgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdgseq
            #add-point:ON ACTION controlp INFIELD mrdgseq name="input.c.page1.mrdgseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg001
            #add-point:ON ACTION controlp INFIELD mrdg001 name="input.c.page1.mrdg001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdg_d[l_ac].mrdg001             #給予default值
            LET g_qryparam.default2 = g_mrdg_d[l_ac].mrdg002 #項次
            #160204-00004#5 20160223 s983961--add(s)
            LET l_success = ''
            LET l_where = ''
            CALL s_aooi210_get_check_sql(g_site,'', g_mrdf_m.mrdfdocno ,'4','','mrdcdocno') RETURNING l_success,l_where
            IF l_success AND NOT cl_null(l_where) THEN
               LET g_qryparam.where = l_where
               CALL q_mrdcdocno_1()
            END IF
            #160204-00004#5 20160223 s983961--add(e)
            #CALL q_mrdcdocno_1()                                #呼叫開窗  #160204-00004#5 20160222 s983961-mark

            LET g_mrdg_d[l_ac].mrdg001 = g_qryparam.return1              
            LET g_mrdg_d[l_ac].mrdg002 = g_qryparam.return2
            INITIALIZE g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007 TO NULL
            CALL amrt250_mrdd002_mrdg004_count() RETURNING l_mrdd001,l_mrdd002,l_mrdg004
            CALL amrt250_mrdg001_mrdg002_ref(l_mrdd001,l_mrdd002,l_mrdg004)            
            DISPLAY g_mrdg_d[l_ac].mrdg001 TO mrdg001              #
            DISPLAY g_mrdg_d[l_ac].mrdg002 TO mrdg002 #項次
            NEXT FIELD mrdg001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg002
            #add-point:ON ACTION controlp INFIELD mrdg002 name="input.c.page1.mrdg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg003
            #add-point:ON ACTION controlp INFIELD mrdg003 name="input.c.page1.mrdg003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdg_d[l_ac].mrdg003             #給予default值

            #給予arg
            CALL q_mrba001_4()                                #呼叫開窗
            LET g_mrdg_d[l_ac].mrdg003 = g_qryparam.return1              
            DISPLAY g_mrdg_d[l_ac].mrdg003 TO mrdg003              #
            CALL amrt250_mrdg003_ref()
            NEXT FIELD mrdg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg004
            #add-point:ON ACTION controlp INFIELD mrdg004 name="input.c.page1.mrdg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg005
            #add-point:ON ACTION controlp INFIELD mrdg005 name="input.c.page1.mrdg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg006
            #add-point:ON ACTION controlp INFIELD mrdg006 name="input.c.page1.mrdg006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdg_d[l_ac].mrdg006             #給予default值
            LET g_qryparam.default2 = "" #g_mrdg_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "221" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_mrdg_d[l_ac].mrdg006 = g_qryparam.return1
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdg_d[l_ac].mrdg006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdg_d[l_ac].mrdg006_desc 
            DISPLAY g_mrdg_d[l_ac].mrdg006 TO mrdg006              #
            NEXT FIELD mrdg006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg007
            #add-point:ON ACTION controlp INFIELD mrdg007 name="input.c.page1.mrdg007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrdg_d[l_ac].mrdg007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_mrba001_6()                                #呼叫開窗

            LET g_mrdg_d[l_ac].mrdg007 = g_qryparam.return1              
            CALL amrt250_mrdg007_ref()

            NEXT FIELD mrdg007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg008
            #add-point:ON ACTION controlp INFIELD mrdg008 name="input.c.page1.mrdg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg009
            #add-point:ON ACTION controlp INFIELD mrdg009 name="input.c.page1.mrdg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg010
            #add-point:ON ACTION controlp INFIELD mrdg010 name="input.c.page1.mrdg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg011
            #add-point:ON ACTION controlp INFIELD mrdg011 name="input.c.page1.mrdg011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mrdg_d[l_ac].mrdg011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where ="  oocq039 IN ('0','1','2')"

 
            CALL cq_oocq002()                                #呼叫開窗
 
            LET g_mrdg_d[l_ac].mrdg011 = g_qryparam.return1              

            DISPLAY g_mrdg_d[l_ac].mrdg011 TO mrdg011              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='9001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdg_d[l_ac].mrdg011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdg_d[l_ac].mrdg011_desc

            NEXT FIELD mrdg011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg012
            #add-point:ON ACTION controlp INFIELD mrdg012 name="input.c.page1.mrdg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg014
            #add-point:ON ACTION controlp INFIELD mrdg014 name="input.c.page1.mrdg014"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdg_d[l_ac].mrdg014             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                                #呼叫開窗
            LET g_mrdg_d[l_ac].mrdg014 = g_qryparam.return1
            DISPLAY g_mrdg_d[l_ac].mrdg014 TO mrdg014              #
            CALL amrt250_mrdg014_ref()
            NEXT FIELD mrdg014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdg013
            #add-point:ON ACTION controlp INFIELD mrdg013 name="input.c.page1.mrdg013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdgsite
            #add-point:ON ACTION controlp INFIELD mrdgsite name="input.c.page1.mrdgsite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdg_d[l_ac].* = g_mrdg_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt250_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mrdg_d[l_ac].mrdgseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdg_d[l_ac].* = g_mrdg_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amrt250_mrdg_t_mask_restore('restore_mask_o')
      
               UPDATE mrdg_t SET (mrdgdocno,mrdgseq,mrdg001,mrdg002,mrdg003,mrdg004,mrdg005,mrdg006, 
                   mrdg007,mrdg008,mrdg009,mrdg010,mrdg011,mrdg012,mrdg014,mrdg013,mrdgsite) = (g_mrdf_m.mrdfdocno, 
                   g_mrdg_d[l_ac].mrdgseq,g_mrdg_d[l_ac].mrdg001,g_mrdg_d[l_ac].mrdg002,g_mrdg_d[l_ac].mrdg003, 
                   g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007, 
                   g_mrdg_d[l_ac].mrdg008,g_mrdg_d[l_ac].mrdg009,g_mrdg_d[l_ac].mrdg010,g_mrdg_d[l_ac].mrdg011, 
                   g_mrdg_d[l_ac].mrdg012,g_mrdg_d[l_ac].mrdg014,g_mrdg_d[l_ac].mrdg013,g_mrdg_d[l_ac].mrdgsite) 
 
                WHERE mrdgent = g_enterprise AND mrdgdocno = g_mrdf_m.mrdfdocno 
 
                  AND mrdgseq = g_mrdg_d_t.mrdgseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdg_d[l_ac].* = g_mrdg_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdg_d[l_ac].* = g_mrdg_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdf_m.mrdfdocno
               LET gs_keys_bak[1] = g_mrdfdocno_t
               LET gs_keys[2] = g_mrdg_d[g_detail_idx].mrdgseq
               LET gs_keys_bak[2] = g_mrdg_d_t.mrdgseq
               CALL amrt250_update_b('mrdg_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrt250_mrdg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mrdg_d[g_detail_idx].mrdgseq = g_mrdg_d_t.mrdgseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mrdf_m.mrdfdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrdg_d_t.mrdgseq
 
                  CALL amrt250_key_update_b(gs_keys,'mrdg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrdf_m),util.JSON.stringify(g_mrdg_d_t)
               LET g_log2 = util.JSON.stringify(g_mrdf_m),util.JSON.stringify(g_mrdg_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrt250_unlock_b("mrdg_t","'1'")
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
               LET g_mrdg_d[li_reproduce_target].* = g_mrdg_d[li_reproduce].*
 
               LET g_mrdg_d[li_reproduce_target].mrdgseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdg_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="amrt250.input.other" >}
      
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
            NEXT FIELD mrdfdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrdgseq
 
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
 
{<section id="amrt250.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrt250_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrt250_b_fill() #單身填充
      CALL amrt250_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrt250_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL amrt250_mrdf005_ref()
   CALL amrt250_mrdg006_ref()
   CALL amrt250_mrdg007_ref()
   CALL amrt250_mrdg003_ref()
   CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
   #end add-point
   
   #遮罩相關處理
   LET g_mrdf_m_mask_o.* =  g_mrdf_m.*
   CALL amrt250_mrdf_t_mask()
   LET g_mrdf_m_mask_n.* =  g_mrdf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002, 
       g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004, 
       g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf005_desc,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid, 
       g_mrdf_m.mrdfownid_desc,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtid_desc, 
       g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfcnfdt,g_mrdf_m.mrdfpstid, 
       g_mrdf_m.mrdfpstid_desc,g_mrdf_m.mrdfpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdf_m.mrdfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mrdg_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL amrt250_mrdg003_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrt250_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrt250_detail_show()
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
 
{<section id="amrt250.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrt250_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrdf_t.mrdfdocno 
   DEFINE l_oldno     LIKE mrdf_t.mrdfdocno 
 
   DEFINE l_master    RECORD LIKE mrdf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrdg_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_mrdf_m.mrdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
    
   LET g_mrdf_m.mrdfdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdf_m.mrdfownid = g_user
      LET g_mrdf_m.mrdfowndp = g_dept
      LET g_mrdf_m.mrdfcrtid = g_user
      LET g_mrdf_m.mrdfcrtdp = g_dept 
      LET g_mrdf_m.mrdfcrtdt = cl_get_current()
      LET g_mrdf_m.mrdfmodid = g_user
      LET g_mrdf_m.mrdfmoddt = cl_get_current()
      LET g_mrdf_m.mrdfstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mrdf_m.mrdfdocdt = g_today
   LET g_mrdf_m.mrdf002 = g_user
   LET g_mrdf_m.mrdf003 = g_dept
   LET g_mrdf_m.mrdfdocno_desc = ''
   CALL s_desc_get_department_desc(g_mrdf_m.mrdf003) RETURNING g_mrdf_m.mrdf003_desc
   CALL s_desc_get_person_desc(g_mrdf_m.mrdf002) RETURNING g_mrdf_m.mrdf002_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdf_m.mrdfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_mrdf_m.mrdfdocno_desc = ''
   DISPLAY BY NAME g_mrdf_m.mrdfdocno_desc
 
   
   CALL amrt250_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrdf_m.* TO NULL
      INITIALIZE g_mrdg_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrt250_show()
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
   CALL amrt250_set_act_visible()   
   CALL amrt250_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdfent = " ||g_enterprise|| " AND",
                      " mrdfdocno = '", g_mrdf_m.mrdfdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt250_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   CALL s_aooi200_get_slip_desc(g_mrdf_m.mrdfdocno) RETURNING g_mrdf_m.mrdfdocno_desc
   DISPLAY BY NAME g_mrdf_m.mrdfdocno_desc
   #end add-point
   
   CALL amrt250_idx_chk()
   
   LET g_data_owner = g_mrdf_m.mrdfownid      
   LET g_data_dept  = g_mrdf_m.mrdfowndp
   
   #功能已完成,通報訊息中心
   CALL amrt250_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrt250_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrdg_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrt250_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdg_t
    WHERE mrdgent = g_enterprise AND mrdgdocno = g_mrdfdocno_t
 
    INTO TEMP amrt250_detail
 
   #將key修正為調整後   
   UPDATE amrt250_detail 
      #更新key欄位
      SET mrdgdocno = g_mrdf_m.mrdfdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mrdg_t SELECT * FROM amrt250_detail
   
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
   DROP TABLE amrt250_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrt250_delete()
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
   
   IF g_mrdf_m.mrdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrt250_cl USING g_enterprise,g_mrdf_m.mrdfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt250_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt250_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
       g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
       g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
       g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
       g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfownid_desc, 
       g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
   
   
   #檢查是否允許此動作
   IF NOT amrt250_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdf_m_mask_o.* =  g_mrdf_m.*
   CALL amrt250_mrdf_t_mask()
   LET g_mrdf_m_mask_n.* =  g_mrdf_m.*
   
   CALL amrt250_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrt250_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mrdfdocno_t = g_mrdf_m.mrdfdocno
 
 
      DELETE FROM mrdf_t
       WHERE mrdfent = g_enterprise AND mrdfdocno = g_mrdf_m.mrdfdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrdf_m.mrdfdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM mrdg_t
       WHERE mrdgent = g_enterprise AND mrdgdocno = g_mrdf_m.mrdfdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrdf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrt250_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mrdg_d.clear() 
 
     
      CALL amrt250_ui_browser_refresh()  
      #CALL amrt250_ui_headershow()  
      #CALL amrt250_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrt250_browser_fill("")
         CALL amrt250_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrt250_cl
 
   #功能已完成,通報訊息中心
   CALL amrt250_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrt250.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrt250_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mrdg_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrt250_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrdgseq,mrdg001,mrdg002,mrdg003,mrdg004,mrdg005,mrdg006,mrdg007, 
             mrdg008,mrdg009,mrdg010,mrdg011,mrdg012,mrdg014,mrdg013,mrdgsite ,t1.mrba004 ,t2.oocql004 , 
             t3.mrba004 ,t4.oocql004 ,t5.ooail003 FROM mrdg_t",   
                     " INNER JOIN mrdf_t ON mrdfent = " ||g_enterprise|| " AND mrdfdocno = mrdgdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN mrba_t t1 ON t1.mrbaent="||g_enterprise||" AND t1.mrbasite=mrdgsite AND t1.mrba001=mrdg003  ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='221' AND t2.oocql002=mrdg006 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN mrba_t t3 ON t3.mrbaent="||g_enterprise||" AND t3.mrbasite=mrdgsite AND t3.mrba001=mrdg007  ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='9001' AND t4.oocql002=mrdg011 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t5 ON t5.ooailent="||g_enterprise||" AND t5.ooail001=mrdg014 AND t5.ooail002='"||g_dlang||"' ",
 
                     " WHERE mrdgent=? AND mrdgdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrdg_t.mrdgseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt250_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrt250_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrdf_m.mrdfdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrdf_m.mrdfdocno INTO g_mrdg_d[l_ac].mrdgseq,g_mrdg_d[l_ac].mrdg001, 
          g_mrdg_d[l_ac].mrdg002,g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005, 
          g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007,g_mrdg_d[l_ac].mrdg008,g_mrdg_d[l_ac].mrdg009, 
          g_mrdg_d[l_ac].mrdg010,g_mrdg_d[l_ac].mrdg011,g_mrdg_d[l_ac].mrdg012,g_mrdg_d[l_ac].mrdg014, 
          g_mrdg_d[l_ac].mrdg013,g_mrdg_d[l_ac].mrdgsite,g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrdg006_desc, 
          g_mrdg_d[l_ac].mrdg007_desc,g_mrdg_d[l_ac].mrdg011_desc,g_mrdg_d[l_ac].mrdg014_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL amrt250_mrdg003_ref()
         CALL amrt250_mrdg006_ref()
         CALL amrt250_mrdg007_ref()
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
   
   CALL g_mrdg_d.deleteElement(g_mrdg_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrt250_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrdg_d.getLength()
      LET g_mrdg_d_mask_o[l_ac].* =  g_mrdg_d[l_ac].*
      CALL amrt250_mrdg_t_mask()
      LET g_mrdg_d_mask_n[l_ac].* =  g_mrdg_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrt250_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mrdg_t
       WHERE mrdgent = g_enterprise AND
         mrdgdocno = ps_keys_bak[1] AND mrdgseq = ps_keys_bak[2]
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
         CALL g_mrdg_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrt250_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mrdg_t
                  (mrdgent,
                   mrdgdocno,
                   mrdgseq
                   ,mrdg001,mrdg002,mrdg003,mrdg004,mrdg005,mrdg006,mrdg007,mrdg008,mrdg009,mrdg010,mrdg011,mrdg012,mrdg014,mrdg013,mrdgsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mrdg_d[g_detail_idx].mrdg001,g_mrdg_d[g_detail_idx].mrdg002,g_mrdg_d[g_detail_idx].mrdg003, 
                       g_mrdg_d[g_detail_idx].mrdg004,g_mrdg_d[g_detail_idx].mrdg005,g_mrdg_d[g_detail_idx].mrdg006, 
                       g_mrdg_d[g_detail_idx].mrdg007,g_mrdg_d[g_detail_idx].mrdg008,g_mrdg_d[g_detail_idx].mrdg009, 
                       g_mrdg_d[g_detail_idx].mrdg010,g_mrdg_d[g_detail_idx].mrdg011,g_mrdg_d[g_detail_idx].mrdg012, 
                       g_mrdg_d[g_detail_idx].mrdg014,g_mrdg_d[g_detail_idx].mrdg013,g_mrdg_d[g_detail_idx].mrdgsite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mrdg_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrt250_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrt250_mrdg_t_mask_restore('restore_mask_o')
               
      UPDATE mrdg_t 
         SET (mrdgdocno,
              mrdgseq
              ,mrdg001,mrdg002,mrdg003,mrdg004,mrdg005,mrdg006,mrdg007,mrdg008,mrdg009,mrdg010,mrdg011,mrdg012,mrdg014,mrdg013,mrdgsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrdg_d[g_detail_idx].mrdg001,g_mrdg_d[g_detail_idx].mrdg002,g_mrdg_d[g_detail_idx].mrdg003, 
                  g_mrdg_d[g_detail_idx].mrdg004,g_mrdg_d[g_detail_idx].mrdg005,g_mrdg_d[g_detail_idx].mrdg006, 
                  g_mrdg_d[g_detail_idx].mrdg007,g_mrdg_d[g_detail_idx].mrdg008,g_mrdg_d[g_detail_idx].mrdg009, 
                  g_mrdg_d[g_detail_idx].mrdg010,g_mrdg_d[g_detail_idx].mrdg011,g_mrdg_d[g_detail_idx].mrdg012, 
                  g_mrdg_d[g_detail_idx].mrdg014,g_mrdg_d[g_detail_idx].mrdg013,g_mrdg_d[g_detail_idx].mrdgsite)  
 
         WHERE mrdgent = g_enterprise AND mrdgdocno = ps_keys_bak[1] AND mrdgseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt250_mrdg_t_mask_restore('restore_mask_n')
               
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
 
{<section id="amrt250.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrt250_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt250.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrt250_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt250.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrt250_lock_b(ps_table,ps_page)
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
   #CALL amrt250_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mrdg_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrt250_bcl USING g_enterprise,
                                       g_mrdf_m.mrdfdocno,g_mrdg_d[g_detail_idx].mrdgseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt250_bcl:",SQLERRMESSAGE 
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
 
{<section id="amrt250.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrt250_unlock_b(ps_table,ps_page)
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
      CLOSE amrt250_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrt250_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mrdfdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrdfdocno",TRUE)
      CALL cl_set_comp_entry("mrdfdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mrdfdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrt250_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrdfdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mrdfdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mrdfdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mrdfdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrt250_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mrdg002,mrdg003,mrdg012,mrdg014",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrt250_set_no_entry_b(p_cmd)
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
   IF cl_null(g_mrdg_d[l_ac].mrdg001) THEN
      LET g_mrdg_d[l_ac].mrdg002 = ''
      CALL cl_set_comp_entry("mrdg002",FALSE)
   END IF
   IF NOT (cl_null(g_mrdg_d[l_ac].mrdg001) OR cl_null(g_mrdg_d[l_ac].mrdg002)) THEN
      CALL cl_set_comp_entry("mrdg003",FALSE)
   END IF
   IF g_mrdg_d[l_ac].mrdg010 = '1' OR cl_null(g_mrdg_d[l_ac].mrdg010) THEN
      CALL cl_set_comp_entry("mrdg012,mrdg014",FALSE)
      LET g_mrdg_d[l_ac].mrdg014 = ''
      CALL amrt250_mrdg014_ref()
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrt250_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrt250_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_mrdf_m.mrdfstus NOT MATCHES '[NDR]' THEN  # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrt250_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrt250_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrt250_default_search()
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
      LET ls_wc = ls_wc, " mrdfdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mrdf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrdg_t" 
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_wc = g_wc," mrdfsite = '", g_argv[1], "' "
   ELSE
      LET g_wc = " 1=1"
   END IF
   #正常運行時，先顯示查詢方案
   IF NOT cl_null(g_argv[02]) THEN
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt250.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrt250_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mrdf_m.mrdfstus MATCHES '[XCH]' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrdf_m.mrdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrt250_cl USING g_enterprise,g_mrdf_m.mrdfdocno
   IF STATUS THEN
      CLOSE amrt250_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt250_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
       g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
       g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtdp, 
       g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfdt, 
       g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfownid_desc, 
       g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
   
 
   #檢查是否允許此動作
   IF NOT amrt250_action_chk() THEN
      CLOSE amrt250_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001,g_mrdf_m.mrdf002, 
       g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004, 
       g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf005_desc,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid, 
       g_mrdf_m.mrdfownid_desc,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid,g_mrdf_m.mrdfcrtid_desc, 
       g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmodid_desc, 
       g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfcnfdt,g_mrdf_m.mrdfpstid, 
       g_mrdf_m.mrdfpstid_desc,g_mrdf_m.mrdfpstdt
 
   CASE g_mrdf_m.mrdfstus
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
         CASE g_mrdf_m.mrdfstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)      
      CASE g_mrdf_m.mrdfstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
            
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
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
            
            #end add-point
         END IF
         EXIT MENU
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
      AND lc_state <> "X"
      ) OR 
      g_mrdf_m.mrdfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrt250_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN amrt250_cl USING g_enterprise,g_mrdf_m.mrdfdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN amrt250_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE amrt250_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CALL cl_err_collect_init() 
   
   #未確認改確認(N->Y)
   IF lc_state = 'Y' AND g_mrdf_m.mrdfstus = 'N' THEN
      CALL s_amrt250_conf_chk(g_mrdf_m.mrdfdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00108') THEN
            CALL s_amrt250_conf_upd(g_mrdf_m.mrdfdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   #確認改未確認(Y->N)
   IF lc_state = 'N' AND g_mrdf_m.mrdfstus = 'Y' THEN
      CALL s_amrt250_unconf_chk(g_mrdf_m.mrdfdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00110') THEN
            CALL s_amrt250_unconf_upd(g_mrdf_m.mrdfdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   #未確認改作廢(N->X)
   IF lc_state = 'X' AND g_mrdf_m.mrdfstus = 'N' THEN
      CALL s_amrt250_invalid_chk(g_mrdf_m.mrdfdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00109') THEN
            CALL s_amrt250_invalid_upd(g_mrdf_m.mrdfdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mrdf_m.mrdfmodid = g_user
   LET g_mrdf_m.mrdfmoddt = cl_get_current()
   LET g_mrdf_m.mrdfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrdf_t 
      SET (mrdfstus,mrdfmodid,mrdfmoddt) 
        = (g_mrdf_m.mrdfstus,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt)     
    WHERE mrdfent = g_enterprise AND mrdfdocno = g_mrdf_m.mrdfdocno
 
    
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
      EXECUTE amrt250_master_referesh USING g_mrdf_m.mrdfdocno INTO g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocdt, 
          g_mrdf_m.mrdf001,g_mrdf_m.mrdf002,g_mrdf_m.mrdf003,g_mrdf_m.mrdfstus,g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite, 
          g_mrdf_m.mrdf005,g_mrdf_m.mrdf006,g_mrdf_m.mrdfownid,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfcrtid, 
          g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid, 
          g_mrdf_m.mrdfcnfdt,g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstdt,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003_desc, 
          g_mrdf_m.mrdfownid_desc,g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp_desc, 
          g_mrdf_m.mrdfmodid_desc,g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrdf_m.mrdfdocno,g_mrdf_m.mrdfdocno_desc,g_mrdf_m.mrdfdocdt,g_mrdf_m.mrdf001, 
          g_mrdf_m.mrdf002,g_mrdf_m.mrdf002_desc,g_mrdf_m.mrdf003,g_mrdf_m.mrdf003_desc,g_mrdf_m.mrdfstus, 
          g_mrdf_m.mrdf004,g_mrdf_m.mrdfsite,g_mrdf_m.mrdf005,g_mrdf_m.mrdf005_desc,g_mrdf_m.mrdf006, 
          g_mrdf_m.mrdfownid,g_mrdf_m.mrdfownid_desc,g_mrdf_m.mrdfowndp,g_mrdf_m.mrdfowndp_desc,g_mrdf_m.mrdfcrtid, 
          g_mrdf_m.mrdfcrtid_desc,g_mrdf_m.mrdfcrtdp,g_mrdf_m.mrdfcrtdp_desc,g_mrdf_m.mrdfcrtdt,g_mrdf_m.mrdfmodid, 
          g_mrdf_m.mrdfmodid_desc,g_mrdf_m.mrdfmoddt,g_mrdf_m.mrdfcnfid,g_mrdf_m.mrdfcnfid_desc,g_mrdf_m.mrdfcnfdt, 
          g_mrdf_m.mrdfpstid,g_mrdf_m.mrdfpstid_desc,g_mrdf_m.mrdfpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrt250_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt250_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt250.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrt250_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mrdg_d.getLength() THEN
         LET g_detail_idx = g_mrdg_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrdg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrdg_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrt250_b_fill2(pi_idx)
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
   
   CALL amrt250_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrt250_fill_chk(ps_idx)
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
 
{<section id="amrt250.status_show" >}
PRIVATE FUNCTION amrt250_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrt250.mask_functions" >}
&include "erp/cmr/amrt250_mask.4gl"
 
{</section>}
 
{<section id="amrt250.signature" >}
   
 
{</section>}
 
{<section id="amrt250.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrt250_set_pk_array()
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
   LET g_pk_array[1].values = g_mrdf_m.mrdfdocno
   LET g_pk_array[1].column = 'mrdfdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt250.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrt250.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrt250_msgcentre_notify(lc_state)
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
   CALL amrt250_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrdf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt250.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrt250_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#24 add-S
   SELECT mrdfstus  INTO g_mrdf_m.mrdfstus
     FROM mrdf_t
    WHERE mrdfent = g_enterprise
      AND mrdfdocno = g_mrdf_m.mrdfdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mrdf_m.mrdfstus
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
        LET g_errparam.extend = g_mrdf_m.mrdfdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrt250_set_act_visible()
        CALL amrt250_set_act_no_visible()
        CALL amrt250_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#24 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt250.other_function" readonly="Y" >}

PRIVATE FUNCTION amrt250_mrdf005_ref()
   CASE g_mrdf_m.mrdf004
      WHEN "1"   #1.部門
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdf_m.mrdf005
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdf_m.mrdf005_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdf_m.mrdf005_desc
      WHEN "2"   #2.據點
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdf_m.mrdf005
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdf_m.mrdf005_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdf_m.mrdf005_desc
      WHEN "3"   #3.廠商
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdf_m.mrdf005
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdf_m.mrdf005_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdf_m.mrdf005_desc
      WHEN "4"   #4.客戶
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdf_m.mrdf005
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdf_m.mrdf005_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdf_m.mrdf005_desc
   END CASE
END FUNCTION

PRIVATE FUNCTION amrt250_mrdg006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdg_d[l_ac].mrdg006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdg_d[l_ac].mrdg006_desc
END FUNCTION

PRIVATE FUNCTION amrt250_mrdg007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg007
   LET g_ref_fields[2] = g_site
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrba001=? AND mrbasite =?","") RETURNING g_rtn_fields
   LET g_mrdg_d[l_ac].mrdg007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdg_d[l_ac].mrdg007_desc
END FUNCTION

PRIVATE FUNCTION amrt250_mrdg003_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_mrdf_m.mrdfsite
   LET g_ref_fields[2] = g_mrdg_d[l_ac].mrdg003
   CALL ap_ref_array2(g_ref_fields," SELECT mrba004,mrba008,mrba009 FROM mrba_t WHERE mrbaent = '"||g_enterprise||"' AND mrbasite = ? AND mrba001 = ? ","") RETURNING g_rtn_fields 
   LET g_mrdg_d[l_ac].mrdg003_desc = g_rtn_fields[1] 
   LET g_mrdg_d[l_ac].mrba008 = g_rtn_fields[2] 
   LET g_mrdg_d[l_ac].mrba009 = g_rtn_fields[3] 
   DISPLAY BY NAME g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009
END FUNCTION

PRIVATE FUNCTION amrt250_mrdg001_mrdg002_ref(p_mrdd001,p_mrdd002,p_mrdg004)
   DEFINE p_mrdd001  LIKE mrdd_t.mrdd001
   DEFINE p_mrdd002  LIKE mrdd_t.mrdd002
   DEFINE p_mrdg004  LIKE mrdg_t.mrdg004
   INITIALIZE g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007 TO NULL
   SELECT mrba004,mrba008,mrba009 INTO g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrbasite = g_site
      AND mrba001 = p_mrdd001
   LET g_mrdg_d[l_ac].mrdg003 = p_mrdd001
   LET g_mrdg_d[l_ac].mrdg004 = p_mrdd002 - p_mrdg004
   SELECT mrdd003,mrdd004,mrdd005 INTO g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007
     FROM mrdd_t
    WHERE mrddent = g_enterprise
      AND mrddsite = g_site
      AND mrdddocno = g_mrdg_d[l_ac].mrdg001
      AND mrddseq = g_mrdg_d[l_ac].mrdg002
   DISPLAY BY NAME g_mrdg_d[l_ac].mrdg003,g_mrdg_d[l_ac].mrdg003_desc,g_mrdg_d[l_ac].mrba008,g_mrdg_d[l_ac].mrba009,g_mrdg_d[l_ac].mrdg004,g_mrdg_d[l_ac].mrdg005,g_mrdg_d[l_ac].mrdg006,g_mrdg_d[l_ac].mrdg007
   CALL amrt250_mrdg006_ref()
   CALL amrt250_mrdg007_ref()
END FUNCTION

PRIVATE FUNCTION amrt250_mrdd002_mrdg004_count()
   DEFINE r_mrdd001  LIKE mrdd_t.mrdd001
   DEFINE r_mrdd002  LIKE mrdd_t.mrdd002
   DEFINE r_mrdg004  LIKE mrdg_t.mrdg004
   SELECT mrdd001,mrdd002 INTO r_mrdd001,r_mrdd002
     FROM mrdd_t,mrdc_t
    WHERE mrdcent = mrddent
      AND mrdcsite = mrddsite
      AND mrdcdocno = mrdddocno
      AND mrdcstus = 'Y'
      AND mrddent = g_enterprise
      AND mrddsite = g_site
      AND mrdddocno = g_mrdg_d[l_ac].mrdg001
      AND mrddseq = g_mrdg_d[l_ac].mrdg002
   SELECT COALESCE(SUM(mrdg004),0) INTO r_mrdg004
     FROM mrdg_t
     LEFT OUTER JOIN mrdf_t ON mrdgent = mrdfent AND mrdgdocno = mrdfdocno
    WHERE mrdgent = g_enterprise
      AND mrdgsite = g_site
      AND mrdg001 = g_mrdg_d[l_ac].mrdg001
      AND mrdg002 = g_mrdg_d[l_ac].mrdg002
      AND mrdg003 = r_mrdd001
      AND mrdfstus = 'Y'
   RETURN r_mrdd001,r_mrdd002,r_mrdg004
END FUNCTION

PRIVATE FUNCTION amrt250_count()
   DEFINE l_count   LIKE type_t.num5
   SELECT COUNT(*) INTO l_count
     FROM mrdd_t
     LEFT OUTER JOIN mrdc_t ON mrddent = mrdcent AND mrdddocno = mrdcdocno
    WHERE mrddent = g_enterprise
      AND mrdddocno = g_mrdg_d[l_ac].mrdg001
      AND mrddseq = g_mrdg_d[l_ac].mrdg002
      AND mrdcstus = 'Y'
   RETURN l_count
END FUNCTION

PRIVATE FUNCTION amrt250_mrdg014_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdg_d[l_ac].mrdg014
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdg_d[l_ac].mrdg014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdg_d[l_ac].mrdg014_desc
END FUNCTION

 
{</section>}
 
