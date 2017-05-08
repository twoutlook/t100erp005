#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2015-03-09 12:45:07), PR版次:0013(2016-11-01 15:12:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000271
#+ Filename...: aprt501
#+ Description: 客戶組申請作業
#+ Creator....: 02296(2014-03-21 16:29:57)
#+ Modifier...: 02749 -SD/PR- 06814
 
{</section>}
 
{<section id="aprt501.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...:   No.160318-00025#32  2016/04/12  By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#  Modify.....:   NO.160816-00068#12  2016/08/17  By 08209     調整transaction
# Modify......:   NO.160818-00017#31  2016/08/30  By 08742     删除修改未重新判断状态码
#160905-00007#13  20160905 by geza           sql加上ent条件
#160824-00007#148 20161101 by 06814          新舊值處理    
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
PRIVATE type type_g_prfa_m        RECORD
       prfasite LIKE prfa_t.prfasite, 
   prfasite_desc LIKE type_t.chr80, 
   prfadocdt LIKE prfa_t.prfadocdt, 
   prfadocno LIKE prfa_t.prfadocno, 
   prfa001 LIKE prfa_t.prfa001, 
   prfa002 LIKE prfa_t.prfa002, 
   prfa003 LIKE prfa_t.prfa003, 
   prfaacti LIKE prfa_t.prfaacti, 
   prfal002 LIKE prfal_t.prfal002, 
   prfal003 LIKE prfal_t.prfal003, 
   prfa004 LIKE prfa_t.prfa004, 
   prfa004_desc LIKE type_t.chr80, 
   prfa005 LIKE prfa_t.prfa005, 
   prfa005_desc LIKE type_t.chr80, 
   prfaunit LIKE prfa_t.prfaunit, 
   prfastus LIKE prfa_t.prfastus, 
   prfaownid LIKE prfa_t.prfaownid, 
   prfaownid_desc LIKE type_t.chr80, 
   prfaowndp LIKE prfa_t.prfaowndp, 
   prfaowndp_desc LIKE type_t.chr80, 
   prfacrtid LIKE prfa_t.prfacrtid, 
   prfacrtid_desc LIKE type_t.chr80, 
   prfacrtdp LIKE prfa_t.prfacrtdp, 
   prfacrtdp_desc LIKE type_t.chr80, 
   prfacrtdt LIKE prfa_t.prfacrtdt, 
   prfamodid LIKE prfa_t.prfamodid, 
   prfamodid_desc LIKE type_t.chr80, 
   prfamoddt LIKE prfa_t.prfamoddt, 
   prfacnfid LIKE prfa_t.prfacnfid, 
   prfacnfid_desc LIKE type_t.chr80, 
   prfacnfdt LIKE prfa_t.prfacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prfb_d        RECORD
       prfbacti LIKE prfb_t.prfbacti, 
   prfb001 LIKE prfb_t.prfb001, 
   prfb002 LIKE prfb_t.prfb002, 
   prfb003 LIKE prfb_t.prfb003, 
   prfb003_desc LIKE type_t.chr500, 
   prfbsite LIKE prfb_t.prfbsite, 
   prfbunit LIKE prfb_t.prfbunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prfasite LIKE prfa_t.prfasite,
   b_prfasite_desc LIKE type_t.chr80,
      b_prfadocdt LIKE prfa_t.prfadocdt,
      b_prfadocno LIKE prfa_t.prfadocno,
      b_prfa001 LIKE prfa_t.prfa001,
      b_prfa002 LIKE prfa_t.prfa002,
      b_prfa003 LIKE prfa_t.prfa003,
      b_prfa004 LIKE prfa_t.prfa004,
   b_prfa004_desc LIKE type_t.chr80,
      b_prfa005 LIKE prfa_t.prfa005,
   b_prfa005_desc LIKE type_t.chr80,
      b_prfaacti LIKE prfa_t.prfaacti
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_pmaa_d       DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         pmaa001       like pmaa_t.pmaa001,
         pmaal004      like pmaal_t.pmaal004,
         pmaal003      like pmaal_t.pmaal003,
         pmaal005      like pmaal_t.pmaal005
      END RECORD
DEFINE g_site_flag     LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prfa_m          type_g_prfa_m
DEFINE g_prfa_m_t        type_g_prfa_m
DEFINE g_prfa_m_o        type_g_prfa_m
DEFINE g_prfa_m_mask_o   type_g_prfa_m #轉換遮罩前資料
DEFINE g_prfa_m_mask_n   type_g_prfa_m #轉換遮罩後資料
 
   DEFINE g_prfadocno_t LIKE prfa_t.prfadocno
 
 
DEFINE g_prfb_d          DYNAMIC ARRAY OF type_g_prfb_d
DEFINE g_prfb_d_t        type_g_prfb_d
DEFINE g_prfb_d_o        type_g_prfb_d
DEFINE g_prfb_d_mask_o   DYNAMIC ARRAY OF type_g_prfb_d #轉換遮罩前資料
DEFINE g_prfb_d_mask_n   DYNAMIC ARRAY OF type_g_prfb_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      prfaldocno LIKE prfal_t.prfaldocno,
      prfal002 LIKE prfal_t.prfal002,
      prfal003 LIKE prfal_t.prfal003
      END RECORD
 
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
 
{<section id="aprt501.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prfasite,'',prfadocdt,prfadocno,prfa001,prfa002,prfa003,prfaacti,'','', 
       prfa004,'',prfa005,'',prfaunit,prfastus,prfaownid,'',prfaowndp,'',prfacrtid,'',prfacrtdp,'',prfacrtdt, 
       prfamodid,'',prfamoddt,prfacnfid,'',prfacnfdt", 
                      " FROM prfa_t",
                      " WHERE prfaent= ? AND prfadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt501_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prfasite,t0.prfadocdt,t0.prfadocno,t0.prfa001,t0.prfa002,t0.prfa003, 
       t0.prfaacti,t0.prfa004,t0.prfa005,t0.prfaunit,t0.prfastus,t0.prfaownid,t0.prfaowndp,t0.prfacrtid, 
       t0.prfacrtdp,t0.prfacrtdt,t0.prfamodid,t0.prfamoddt,t0.prfacnfid,t0.prfacnfdt,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM prfa_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.prfa004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prfa005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prfaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prfaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.prfacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.prfacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prfamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prfacnfid  ",
 
               " WHERE t0.prfaent = " ||g_enterprise|| " AND t0.prfadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt501_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt501 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt501_init()   
 
      #進入選單 Menu (="N")
      CALL aprt501_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt501
      
   END IF 
   
   CLOSE aprt501_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt501.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt501_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
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
      CALL cl_set_combo_scc_part('prfastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prfa001','32') 
   CALL cl_set_combo_scc('prfb002','6035') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   
   CALL cl_set_combo_scc('b_prfa001','32')
   #end add-point
   
   #初始化搜尋條件
   CALL aprt501_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt501.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt501_ui_dialog()
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
            CALL aprt501_insert()
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
         INITIALIZE g_prfa_m.* TO NULL
         CALL g_prfb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt501_init()
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
               
               CALL aprt501_fetch('') # reload data
               LET l_ac = 1
               CALL aprt501_ui_detailshow() #Setting the current row 
         
               CALL aprt501_idx_chk()
               #NEXT FIELD prfb001
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prfb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt501_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
#               IF cl_null(l_ac) OR  l_ac=0 THEN
#                  LET l_ac=1
#               END IF
#               IF NOT cl_null(l_ac) AND l_ac<>0 THEN
#                  
#                  CALL aprt501_fill()
#               END IF
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
               CALL aprt501_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_pmaa_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 1
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprt501_browser_fill("")
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
               CALL aprt501_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt501_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt501_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt501_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt501_set_act_visible()   
            CALL aprt501_set_act_no_visible()
            IF NOT (g_prfa_m.prfadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prfaent = " ||g_enterprise|| " AND",
                                  " prfadocno = '", g_prfa_m.prfadocno, "' "
 
               #填到對應位置
               CALL aprt501_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prfb_t" 
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
               CALL aprt501_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prfb_t" 
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
                  CALL aprt501_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt501_fetch("F")
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
               CALL aprt501_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt501_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt501_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt501_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt501_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt501_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt501_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt501_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt501_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt501_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt501_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prfb_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #ken---add---s 需求單號：150107-00009 項次：11
                  LET g_export_node[2] = base.typeInfo.create(g_pmaa_d)
                  LET g_export_id[2]   = "s_detail2"
                  #ken---add---e
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
               NEXT FIELD prfb001
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
               CALL aprt501_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt501_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt501_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt501_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt501_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt501_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt501_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt501_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt501_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt501_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prfa_m.prfadocdt)
 
 
 
         
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
 
{<section id="aprt501.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt501_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prfasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prfadocno ",
                      " FROM prfa_t ",
                      " LEFT JOIN pmaa_t ON pmaaent = prfaent AND prfadocno = pmaa001 ",
                      " LEFT JOIN prfb_t ON prfbent = prfaent AND prfadocno = prfbdocno ", "  ",
                      #add-point:browser_fill段sql(prfb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN prfal_t ON prfalent = "||g_enterprise||" AND prfadocno = prfaldocno AND prfal001 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE prfaent = " ||g_enterprise|| " AND prfbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prfa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prfadocno ",
                      " FROM prfa_t ", 
                      "  LEFT JOIN pmaa_t ON pmaaent = prfaent AND prfadocno = pmaa001 ",
                      "  LEFT JOIN prfal_t ON prfalent = "||g_enterprise||" AND prfadocno = prfaldocno AND prfal001 = '",g_dlang,"' ",
                      " WHERE prfaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prfa_t")
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
      INITIALIZE g_prfa_m.* TO NULL
      CALL g_prfb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prfasite,t0.prfadocdt,t0.prfadocno,t0.prfa001,t0.prfa002,t0.prfa003,t0.prfa004,t0.prfa005,t0.prfaacti Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prfastus,t0.prfasite,t0.prfadocdt,t0.prfadocno,t0.prfa001,t0.prfa002, 
          t0.prfa003,t0.prfa004,t0.prfa005,t0.prfaacti,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM prfa_t t0",
                  "  LEFT JOIN pmaa_t ON pmaaent = prfaent AND prfadocno = pmaa001 ",
                  "  LEFT JOIN prfb_t ON prfbent = prfaent AND prfadocno = prfbdocno ", "  ", 
                  #add-point:browser_fill段sql(prfb_t1) name="browser_fill.join.prfb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.prfa004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prfa005 AND t3.ooefl002='"||g_dlang||"' ",
 
               " LEFT JOIN prfal_t ON prfalent = "||g_enterprise||" AND prfadocno = prfaldocno AND prfal001 = '",g_dlang,"' ",
                  " WHERE t0.prfaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prfa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prfastus,t0.prfasite,t0.prfadocdt,t0.prfadocno,t0.prfa001,t0.prfa002, 
          t0.prfa003,t0.prfa004,t0.prfa005,t0.prfaacti,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM prfa_t t0",
                  "  LEFT JOIN pmaa_t ON pmaaent = prfaent AND prfadocno = pmaa001 ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.prfa004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prfa005 AND t3.ooefl002='"||g_dlang||"' ",
 
               " LEFT JOIN prfal_t ON prfalent = "||g_enterprise||" AND prfadocno = prfaldocno AND prfal001 = '",g_dlang,"' ",
                  " WHERE t0.prfaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prfa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prfadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prfa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prfasite,g_browser[g_cnt].b_prfadocdt, 
          g_browser[g_cnt].b_prfadocno,g_browser[g_cnt].b_prfa001,g_browser[g_cnt].b_prfa002,g_browser[g_cnt].b_prfa003, 
          g_browser[g_cnt].b_prfa004,g_browser[g_cnt].b_prfa005,g_browser[g_cnt].b_prfaacti,g_browser[g_cnt].b_prfasite_desc, 
          g_browser[g_cnt].b_prfa004_desc,g_browser[g_cnt].b_prfa005_desc
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
         CALL aprt501_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prfadocno) THEN
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
 
{<section id="aprt501.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt501_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prfa_m.prfadocno = g_browser[g_current_idx].b_prfadocno   
 
   EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
       g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
       g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
       g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc,g_prfa_m.prfaownid_desc, 
       g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfamodid_desc, 
       g_prfa_m.prfacnfid_desc
                  CALL aprt501_pmaa_t('s')
   CALL aprt501_prfa_t_mask()
   CALL aprt501_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt501.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt501_ui_detailshow()
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
 
{<section id="aprt501.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt501_ui_browser_refresh()
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
      IF g_browser[l_i].b_prfadocno = g_prfa_m.prfadocno 
 
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
 
{<section id="aprt501.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt501_construct()
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
   INITIALIZE g_prfa_m.* TO NULL
   CALL g_prfb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON prfasite,prfadocdt,prfadocno,prfa001,prfa002,prfa003,prfaacti,prfal002, 
          prfal003,prfa004,prfa005,prfaunit,prfastus,prfaownid,prfaowndp,prfacrtid,prfacrtdp,prfacrtdt, 
          prfamodid,prfamoddt,prfacnfid,prfacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prfacrtdt>>----
         AFTER FIELD prfacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prfamoddt>>----
         AFTER FIELD prfamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prfacnfdt>>----
         AFTER FIELD prfacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prfapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfasite
            #add-point:ON ACTION controlp INFIELD prfasite name="construct.c.prfasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfasite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prfasite  #顯示到畫面上
            NEXT FIELD prfasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfasite
            #add-point:BEFORE FIELD prfasite name="construct.b.prfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfasite
            
            #add-point:AFTER FIELD prfasite name="construct.a.prfasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfadocdt
            #add-point:BEFORE FIELD prfadocdt name="construct.b.prfadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfadocdt
            
            #add-point:AFTER FIELD prfadocdt name="construct.a.prfadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfadocdt
            #add-point:ON ACTION controlp INFIELD prfadocdt name="construct.c.prfadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfadocno
            #add-point:ON ACTION controlp INFIELD prfadocno name="construct.c.prfadocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_prfadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfadocno  #顯示到畫面上

            NEXT FIELD prfadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfadocno
            #add-point:BEFORE FIELD prfadocno name="construct.b.prfadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfadocno
            
            #add-point:AFTER FIELD prfadocno name="construct.a.prfadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa001
            #add-point:BEFORE FIELD prfa001 name="construct.b.prfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa001
            
            #add-point:AFTER FIELD prfa001 name="construct.a.prfa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa001
            #add-point:ON ACTION controlp INFIELD prfa001 name="construct.c.prfa001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa002
            #add-point:ON ACTION controlp INFIELD prfa002 name="construct.c.prfa002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_prfa002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfa002  #顯示到畫面上

            NEXT FIELD prfa002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa002
            #add-point:BEFORE FIELD prfa002 name="construct.b.prfa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa002
            
            #add-point:AFTER FIELD prfa002 name="construct.a.prfa002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa003
            #add-point:BEFORE FIELD prfa003 name="construct.b.prfa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa003
            
            #add-point:AFTER FIELD prfa003 name="construct.a.prfa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa003
            #add-point:ON ACTION controlp INFIELD prfa003 name="construct.c.prfa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfaacti
            #add-point:BEFORE FIELD prfaacti name="construct.b.prfaacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfaacti
            
            #add-point:AFTER FIELD prfaacti name="construct.a.prfaacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfaacti
            #add-point:ON ACTION controlp INFIELD prfaacti name="construct.c.prfaacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfal002
            #add-point:BEFORE FIELD prfal002 name="construct.b.prfal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfal002
            
            #add-point:AFTER FIELD prfal002 name="construct.a.prfal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfal002
            #add-point:ON ACTION controlp INFIELD prfal002 name="construct.c.prfal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfal003
            #add-point:BEFORE FIELD prfal003 name="construct.b.prfal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfal003
            
            #add-point:AFTER FIELD prfal003 name="construct.a.prfal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfal003
            #add-point:ON ACTION controlp INFIELD prfal003 name="construct.c.prfal003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa004
            #add-point:ON ACTION controlp INFIELD prfa004 name="construct.c.prfa004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfa004  #顯示到畫面上

            NEXT FIELD prfa004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa004
            #add-point:BEFORE FIELD prfa004 name="construct.b.prfa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa004
            
            #add-point:AFTER FIELD prfa004 name="construct.a.prfa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa005
            #add-point:ON ACTION controlp INFIELD prfa005 name="construct.c.prfa005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfa005  #顯示到畫面上

            NEXT FIELD prfa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa005
            #add-point:BEFORE FIELD prfa005 name="construct.b.prfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa005
            
            #add-point:AFTER FIELD prfa005 name="construct.a.prfa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfaunit
            #add-point:ON ACTION controlp INFIELD prfaunit name="construct.c.prfaunit"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfaunit  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD prfaunit                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfaunit
            #add-point:BEFORE FIELD prfaunit name="construct.b.prfaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfaunit
            
            #add-point:AFTER FIELD prfaunit name="construct.a.prfaunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfastus
            #add-point:BEFORE FIELD prfastus name="construct.b.prfastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfastus
            
            #add-point:AFTER FIELD prfastus name="construct.a.prfastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfastus
            #add-point:ON ACTION controlp INFIELD prfastus name="construct.c.prfastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfaownid
            #add-point:ON ACTION controlp INFIELD prfaownid name="construct.c.prfaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfaownid  #顯示到畫面上

            NEXT FIELD prfaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfaownid
            #add-point:BEFORE FIELD prfaownid name="construct.b.prfaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfaownid
            
            #add-point:AFTER FIELD prfaownid name="construct.a.prfaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfaowndp
            #add-point:ON ACTION controlp INFIELD prfaowndp name="construct.c.prfaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfaowndp  #顯示到畫面上

            NEXT FIELD prfaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfaowndp
            #add-point:BEFORE FIELD prfaowndp name="construct.b.prfaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfaowndp
            
            #add-point:AFTER FIELD prfaowndp name="construct.a.prfaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfacrtid
            #add-point:ON ACTION controlp INFIELD prfacrtid name="construct.c.prfacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfacrtid  #顯示到畫面上

            NEXT FIELD prfacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfacrtid
            #add-point:BEFORE FIELD prfacrtid name="construct.b.prfacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfacrtid
            
            #add-point:AFTER FIELD prfacrtid name="construct.a.prfacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfacrtdp
            #add-point:ON ACTION controlp INFIELD prfacrtdp name="construct.c.prfacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfacrtdp  #顯示到畫面上

            NEXT FIELD prfacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfacrtdp
            #add-point:BEFORE FIELD prfacrtdp name="construct.b.prfacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfacrtdp
            
            #add-point:AFTER FIELD prfacrtdp name="construct.a.prfacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfacrtdt
            #add-point:BEFORE FIELD prfacrtdt name="construct.b.prfacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfamodid
            #add-point:ON ACTION controlp INFIELD prfamodid name="construct.c.prfamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfamodid  #顯示到畫面上

            NEXT FIELD prfamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfamodid
            #add-point:BEFORE FIELD prfamodid name="construct.b.prfamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfamodid
            
            #add-point:AFTER FIELD prfamodid name="construct.a.prfamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfamoddt
            #add-point:BEFORE FIELD prfamoddt name="construct.b.prfamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfacnfid
            #add-point:ON ACTION controlp INFIELD prfacnfid name="construct.c.prfacnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfacnfid  #顯示到畫面上

            NEXT FIELD prfacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfacnfid
            #add-point:BEFORE FIELD prfacnfid name="construct.b.prfacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfacnfid
            
            #add-point:AFTER FIELD prfacnfid name="construct.a.prfacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfacnfdt
            #add-point:BEFORE FIELD prfacnfdt name="construct.b.prfacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prfbacti,prfb001,prfb002,prfb003,prfbsite,prfbunit
           FROM s_detail1[1].prfbacti,s_detail1[1].prfb001,s_detail1[1].prfb002,s_detail1[1].prfb003, 
               s_detail1[1].prfbsite,s_detail1[1].prfbunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfbacti
            #add-point:BEFORE FIELD prfbacti name="construct.b.page1.prfbacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfbacti
            
            #add-point:AFTER FIELD prfbacti name="construct.a.page1.prfbacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfbacti
            #add-point:ON ACTION controlp INFIELD prfbacti name="construct.c.page1.prfbacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfb001
            #add-point:BEFORE FIELD prfb001 name="construct.b.page1.prfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfb001
            
            #add-point:AFTER FIELD prfb001 name="construct.a.page1.prfb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfb001
            #add-point:ON ACTION controlp INFIELD prfb001 name="construct.c.page1.prfb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfb002
            #add-point:BEFORE FIELD prfb002 name="construct.b.page1.prfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfb002
            
            #add-point:AFTER FIELD prfb002 name="construct.a.page1.prfb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfb002
            #add-point:ON ACTION controlp INFIELD prfb002 name="construct.c.page1.prfb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfb003
            #add-point:BEFORE FIELD prfb003 name="construct.b.page1.prfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfb003
            
            #add-point:AFTER FIELD prfb003 name="construct.a.page1.prfb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfb003
            #add-point:ON ACTION controlp INFIELD prfb003 name="construct.c.page1.prfb003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_prfb003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfb003  #顯示到畫面上

            NEXT FIELD prfb003                    #返回原欄位 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfbsite
            #add-point:BEFORE FIELD prfbsite name="construct.b.page1.prfbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfbsite
            
            #add-point:AFTER FIELD prfbsite name="construct.a.page1.prfbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfbsite
            #add-point:ON ACTION controlp INFIELD prfbsite name="construct.c.page1.prfbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfbunit
            #add-point:BEFORE FIELD prfbunit name="construct.b.page1.prfbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfbunit
            
            #add-point:AFTER FIELD prfbunit name="construct.a.page1.prfbunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfbunit
            #add-point:ON ACTION controlp INFIELD prfbunit name="construct.c.page1.prfbunit"
            
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
                  WHEN la_wc[li_idx].tableid = "prfa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prfb_t" 
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
 
{<section id="aprt501.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt501_filter()
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
      CONSTRUCT g_wc_filter ON prfasite,prfadocdt,prfadocno,prfa001,prfa002,prfa003,prfa004,prfa005, 
          prfaacti
                          FROM s_browse[1].b_prfasite,s_browse[1].b_prfadocdt,s_browse[1].b_prfadocno, 
                              s_browse[1].b_prfa001,s_browse[1].b_prfa002,s_browse[1].b_prfa003,s_browse[1].b_prfa004, 
                              s_browse[1].b_prfa005,s_browse[1].b_prfaacti
 
         BEFORE CONSTRUCT
               DISPLAY aprt501_filter_parser('prfasite') TO s_browse[1].b_prfasite
            DISPLAY aprt501_filter_parser('prfadocdt') TO s_browse[1].b_prfadocdt
            DISPLAY aprt501_filter_parser('prfadocno') TO s_browse[1].b_prfadocno
            DISPLAY aprt501_filter_parser('prfa001') TO s_browse[1].b_prfa001
            DISPLAY aprt501_filter_parser('prfa002') TO s_browse[1].b_prfa002
            DISPLAY aprt501_filter_parser('prfa003') TO s_browse[1].b_prfa003
            DISPLAY aprt501_filter_parser('prfa004') TO s_browse[1].b_prfa004
            DISPLAY aprt501_filter_parser('prfa005') TO s_browse[1].b_prfa005
            DISPLAY aprt501_filter_parser('prfaacti') TO s_browse[1].b_prfaacti
      
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
 
      CALL aprt501_filter_show('prfasite')
   CALL aprt501_filter_show('prfadocdt')
   CALL aprt501_filter_show('prfadocno')
   CALL aprt501_filter_show('prfa001')
   CALL aprt501_filter_show('prfa002')
   CALL aprt501_filter_show('prfa003')
   CALL aprt501_filter_show('prfa004')
   CALL aprt501_filter_show('prfa005')
   CALL aprt501_filter_show('prfaacti')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt501_filter_parser(ps_field)
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
 
{<section id="aprt501.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt501_filter_show(ps_field)
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
   LET ls_condition = aprt501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt501_query()
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
   CALL g_prfb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt501_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt501_browser_fill("")
      CALL aprt501_fetch("")
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
      CALL aprt501_filter_show('prfasite')
   CALL aprt501_filter_show('prfadocdt')
   CALL aprt501_filter_show('prfadocno')
   CALL aprt501_filter_show('prfa001')
   CALL aprt501_filter_show('prfa002')
   CALL aprt501_filter_show('prfa003')
   CALL aprt501_filter_show('prfa004')
   CALL aprt501_filter_show('prfa005')
   CALL aprt501_filter_show('prfaacti')
   CALL aprt501_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt501_fetch("F") 
      #顯示單身筆數
      CALL aprt501_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt501_fetch(p_flag)
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
   
   LET g_prfa_m.prfadocno = g_browser[g_current_idx].b_prfadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
       g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
       g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
       g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc,g_prfa_m.prfaownid_desc, 
       g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfamodid_desc, 
       g_prfa_m.prfacnfid_desc
   
   #遮罩相關處理
   LET g_prfa_m_mask_o.* =  g_prfa_m.*
   CALL aprt501_prfa_t_mask()
   LET g_prfa_m_mask_n.* =  g_prfa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt501_set_act_visible()   
   CALL aprt501_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_prfa_m.prfastus='N' THEN
#      CALL cl_set_act_visible("modify,delete",true)
#   ELSE
#      CALL cl_set_act_visible("modify,delete",false)
#   END IF
   IF g_prfa_m.prfastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
                  CALL aprt501_pmaa_t('s')
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prfa_m_t.* = g_prfa_m.*
   LET g_prfa_m_o.* = g_prfa_m.*
   
   LET g_data_owner = g_prfa_m.prfaownid      
   LET g_data_dept  = g_prfa_m.prfaowndp
   
   #重新顯示   
   CALL aprt501_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt501_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prfb_d.clear()   
 
 
   INITIALIZE g_prfa_m.* TO NULL             #DEFAULT 設定
   
   LET g_prfadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prfa_m.prfaownid = g_user
      LET g_prfa_m.prfaowndp = g_dept
      LET g_prfa_m.prfacrtid = g_user
      LET g_prfa_m.prfacrtdp = g_dept 
      LET g_prfa_m.prfacrtdt = cl_get_current()
      LET g_prfa_m.prfamodid = g_user
      LET g_prfa_m.prfamoddt = cl_get_current()
      LET g_prfa_m.prfastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prfa_m.prfa001 = "I"
      LET g_prfa_m.prfaacti = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prfa_m.prfastus = "N"
      CALL g_pmaa_d.clear()
#      LET g_prfa_m.prfasite = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prfasite',g_prfa_m.prfasite)
         RETURNING l_insert,g_prfa_m.prfasite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prfa_m.prfaunit = g_prfa_m.prfasite
      CALL aprt501_prfasite_ref()
      LET g_prfa_m.prfadocdt = g_today
      LET g_prfa_m.prfa004 = g_user
      CALL aprt501_prfa004_ref()
      CALL aprt501_prfa004_display()
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prfa_m.prfasite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prfa_m.prfadocno = r_doctype
      #dongsz--add--end---
      
      LET g_prfa_m_t.* = g_prfa_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prfa_m_t.* = g_prfa_m.*
      LET g_prfa_m_o.* = g_prfa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfa_m.prfastus 
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
 
 
 
    
      CALL aprt501_input("a")
      
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
         INITIALIZE g_prfa_m.* TO NULL
         INITIALIZE g_prfb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt501_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prfb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt501_set_act_visible()   
   CALL aprt501_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prfadocno_t = g_prfa_m.prfadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prfaent = " ||g_enterprise|| " AND",
                      " prfadocno = '", g_prfa_m.prfadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt501_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt501_cl
   
   CALL aprt501_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
       g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
       g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
       g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc,g_prfa_m.prfaownid_desc, 
       g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfamodid_desc, 
       g_prfa_m.prfacnfid_desc
                  CALL aprt501_pmaa_t('s')
   
   #遮罩相關處理
   LET g_prfa_m_mask_o.* =  g_prfa_m.*
   CALL aprt501_prfa_t_mask()
   LET g_prfa_m_mask_n.* =  g_prfa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001, 
       g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003,g_prfa_m.prfa004, 
       g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc,g_prfa_m.prfaunit,g_prfa_m.prfastus, 
       g_prfa_m.prfaownid,g_prfa_m.prfaownid_desc,g_prfa_m.prfaowndp,g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid, 
       g_prfa_m.prfamodid_desc,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid,g_prfa_m.prfacnfid_desc,g_prfa_m.prfacnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prfa_m.prfaownid      
   LET g_data_dept  = g_prfa_m.prfaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt501_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt501_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_prfa_m.prfastus MATCHES "[DR]" THEN 
      LET g_prfa_m.prfastus = "N"
   END IF
   IF g_prfa_m.prfastus<>'N' THEN
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prfa_m_t.* = g_prfa_m.*
   LET g_prfa_m_o.* = g_prfa_m.*
   
   IF g_prfa_m.prfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prfadocno_t = g_prfa_m.prfadocno
 
   CALL s_transaction_begin()
   
   OPEN aprt501_cl USING g_enterprise,g_prfa_m.prfadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt501_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt501_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
       g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
       g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
       g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc,g_prfa_m.prfaownid_desc, 
       g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfamodid_desc, 
       g_prfa_m.prfacnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt501_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prfa_m_mask_o.* =  g_prfa_m.*
   CALL aprt501_prfa_t_mask()
   LET g_prfa_m_mask_n.* =  g_prfa_m.*
   
                  CALL aprt501_pmaa_t('s')
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aprt501_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_prfadocno_t = g_prfa_m.prfadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prfa_m.prfamodid = g_user 
LET g_prfa_m.prfamoddt = cl_get_current()
LET g_prfa_m.prfamodid_desc = cl_get_username(g_prfa_m.prfamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_prfa_m.prfastus MATCHES "[DR]" THEN 
         LET g_prfa_m.prfastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt501_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prfa_t SET (prfamodid,prfamoddt) = (g_prfa_m.prfamodid,g_prfa_m.prfamoddt)
          WHERE prfaent = g_enterprise AND prfadocno = g_prfadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prfa_m.* = g_prfa_m_t.*
            CALL aprt501_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prfa_m.prfadocno != g_prfa_m_t.prfadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prfb_t SET prfbdocno = g_prfa_m.prfadocno
 
          WHERE prfbent = g_enterprise AND prfbdocno = g_prfa_m_t.prfadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prfb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prfb_t:",SQLERRMESSAGE 
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
   CALL aprt501_set_act_visible()   
   CALL aprt501_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prfaent = " ||g_enterprise|| " AND",
                      " prfadocno = '", g_prfa_m.prfadocno, "' "
 
   #填到對應位置
   CALL aprt501_browser_fill("")
 
   CLOSE aprt501_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt501_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt501.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt501_input(p_cmd)
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
   DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001, 
       g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003,g_prfa_m.prfa004, 
       g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc,g_prfa_m.prfaunit,g_prfa_m.prfastus, 
       g_prfa_m.prfaownid,g_prfa_m.prfaownid_desc,g_prfa_m.prfaowndp,g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid, 
       g_prfa_m.prfamodid_desc,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid,g_prfa_m.prfacnfid_desc,g_prfa_m.prfacnfdt 
 
   
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
   LET g_forupd_sql = "SELECT prfbacti,prfb001,prfb002,prfb003,prfbsite,prfbunit FROM prfb_t WHERE prfbent=?  
       AND prfbdocno=? AND prfb001=? AND prfb002=? AND prfb003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt501_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt501_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt501_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002, 
       g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003,g_prfa_m.prfa004,g_prfa_m.prfa005, 
       g_prfa_m.prfaunit,g_prfa_m.prfastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow=1
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt501.input.head" >}
      #單頭段
      INPUT BY NAME g_prfa_m.prfasite,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002, 
          g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003,g_prfa_m.prfa004,g_prfa_m.prfa005, 
          g_prfa_m.prfaunit,g_prfa_m.prfastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
            IF NOT cl_null(g_prfa_m.prfadocno) THEN
               CALL n_prfal(g_prfa_m.prfadocno)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prfa_m.prfadocno
               #CALL ap_ref_array2(g_ref_fields," SELECT prfal002,prfal003 FROM prfal_t WHERE prfaldocno = ? AND prfal001 = '"||g_lang||"'","") RETURNING g_rtn_fields #mark by geza 20160905 #160905-00007#13
               CALL ap_ref_array2(g_ref_fields," SELECT prfal002,prfal003 FROM prfal_t WHERE prfalent = '"||g_enterprise||"' AND prfaldocno = ? AND prfal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields  #add by geza 20160905 #160905-00007#13
               LET g_prfa_m.prfal002 = g_rtn_fields[1]
               LET g_prfa_m.prfal003 = g_rtn_fields[2]
               DISPLAY BY NAME g_prfa_m.prfal002
               DISPLAY BY NAME g_prfa_m.prfal003
            END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt501_cl USING g_enterprise,g_prfa_m.prfadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt501_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt501_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.prfaldocno = g_prfa_m.prfadocno
LET g_master_multi_table_t.prfal002 = g_prfa_m.prfal002
LET g_master_multi_table_t.prfal003 = g_prfa_m.prfal003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prfaldocno = ''
LET g_master_multi_table_t.prfal002 = ''
LET g_master_multi_table_t.prfal003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt501_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
             CALL aprt501_set_entry(p_cmd)
             CALL aprt501_set_no_entry(p_cmd)
            #end add-point
            CALL aprt501_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfasite
            
            #add-point:AFTER FIELD prfasite name="input.a.prfasite"
            IF NOT cl_null(g_prfa_m.prfasite) THEN
               CALL s_aooi500_chk(g_prog,'prfasite',g_prfa_m.prfasite,g_prfa_m.prfasite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prfa_m.prfasite = g_prfa_m_t.prfasite
                  CALL aprt501_prfasite_ref()
                  DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc
                  NEXT FIELD CURRENT
               END IF
            #sakura---add--str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               LET g_prfa_m.prfasite = g_prfa_m_t.prfasite
               CALL aprt501_prfasite_ref()
               DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc
               NEXT FIELD CURRENT               
            #sakura---add--end		               
            END IF
            LET g_site_flag = TRUE            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfa_m.prfasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfasite_desc
            CALL aprt501_set_entry(p_cmd)
            CALL aprt501_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfasite
            #add-point:BEFORE FIELD prfasite name="input.b.prfasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfasite
            #add-point:ON CHANGE prfasite name="input.g.prfasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfadocdt
            #add-point:BEFORE FIELD prfadocdt name="input.b.prfadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfadocdt
            
            #add-point:AFTER FIELD prfadocdt name="input.a.prfadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfadocdt
            #add-point:ON CHANGE prfadocdt name="input.g.prfadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfadocno
            #add-point:BEFORE FIELD prfadocno name="input.b.prfadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfadocno
            
            #add-point:AFTER FIELD prfadocno name="input.a.prfadocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_prfa_m.prfadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfadocno != g_prfadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfa_t WHERE "||"prfaent = '" ||g_enterprise|| "' AND "||"prfadocno = '"||g_prfa_m.prfadocno ||"'",'std-00004',0) THEN 
                     LET  g_prfa_m.prfadocno = g_prfa_m_t.prfadocno  
                     NEXT FIELD CURRENT
                  END IF
                 #CALL s_aooi200_chk_slip(g_site,g_ooef004,g_prfa_m.prfadocno,g_prog) RETURNING l_success #sakura mark
                  CALL s_aooi200_chk_slip(g_prfa_m.prfasite,g_ooef004,g_prfa_m.prfadocno,g_prog) RETURNING l_success #sakura add
                  IF NOT l_success THEN
                     LET  g_prfa_m.prfadocno = g_prfa_m_t.prfadocno 
                     NEXT FIELD prfadocno
                  END IF
                  IF NOT cl_null(g_prfa_m.prfadocno) THEN 
                    #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
               
                    #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_ooef004
                     LET g_chkparam.arg2 = g_prfa_m.prfadocno
                  
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooba002") THEN

                     ELSE
                        #檢查失敗時後續處理
                        LET  g_prfa_m.prfadocno = g_prfa_m_t.prfadocno 
                        NEXT FIELD prfadocno
                     END IF
           
                  END IF 
                  
                  #ken_mark
                  #CALL s_aooi200_gen_docno(g_prfa_m.prfasite,g_prfa_m.prfadocno,g_prfa_m.prfadocdt,g_prog)
                  #   RETURNING  g_success,g_prfa_m.prfadocno
                  #IF g_success<>'1' THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = "amm-00001"
                  #   LET g_errparam.extend = g_prfa_m.prfadocno
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   NEXT FIELD prfadocno
                  #ELSE
                  #   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfa_t WHERE "||"prfaent = '" ||g_enterprise|| "' AND "||"prfadocno = '"||g_prfa_m.prfadocno ||"'",'std-00004',1) THEN
                  #      LET g_prfa_m.prfadocno = g_prfa_m_t.prfadocno 
                  #      NEXT FIELD prfadocno
                  #   END IF
                  #
                  #END IF
                  #LET g_prfa_m_t.prfadocno = g_prfa_m.prfadocno
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfadocno
            #add-point:ON CHANGE prfadocno name="input.g.prfadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa001
            #add-point:BEFORE FIELD prfa001 name="input.b.prfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa001
            
            #add-point:AFTER FIELD prfa001 name="input.a.prfa001"
            IF  NOT cl_null(g_prfa_m.prfa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfa001 != g_prfa_m_t.prfa001 OR g_prfa_m_t.prfa001 IS NULL )) THEN
                  CALL aprt501_prfa001_init()
               END IF
            END IF
            CALL aprt501_set_entry(p_cmd)
            CALL aprt501_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfa001
            #add-point:ON CHANGE prfa001 name="input.g.prfa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa002
            #add-point:BEFORE FIELD prfa002 name="input.b.prfa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa002
            
            #add-point:AFTER FIELD prfa002 name="input.a.prfa002"
            IF  NOT cl_null(g_prfa_m.prfa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfa002 != g_prfa_m_t.prfa002 OR g_prfa_m_t.prfa002 IS NULL )) THEN
                  CALL aprt501_prfa002() RETURNING l_success,g_errno
                  IF l_success= FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prfa_m.prfa002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfa_m.prfa002 = g_prfa_m_t.prfa002
                     CALL aprt501_prfa002_ref()
                     NEXT FIELD prfa002
                  END IF
               END IF
            END IF
            CALL aprt501_prfa002_ref()            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfa002
            #add-point:ON CHANGE prfa002 name="input.g.prfa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa003
            #add-point:BEFORE FIELD prfa003 name="input.b.prfa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa003
            
            #add-point:AFTER FIELD prfa003 name="input.a.prfa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfa003
            #add-point:ON CHANGE prfa003 name="input.g.prfa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfaacti
            #add-point:BEFORE FIELD prfaacti name="input.b.prfaacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfaacti
            
            #add-point:AFTER FIELD prfaacti name="input.a.prfaacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfaacti
            #add-point:ON CHANGE prfaacti name="input.g.prfaacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfal002
            #add-point:BEFORE FIELD prfal002 name="input.b.prfal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfal002
            
            #add-point:AFTER FIELD prfal002 name="input.a.prfal002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfal002
            #add-point:ON CHANGE prfal002 name="input.g.prfal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfal003
            #add-point:BEFORE FIELD prfal003 name="input.b.prfal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfal003
            
            #add-point:AFTER FIELD prfal003 name="input.a.prfal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfal003
            #add-point:ON CHANGE prfal003 name="input.g.prfal003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa004
            
            #add-point:AFTER FIELD prfa004 name="input.a.prfa004"
            LET g_prfa_m.prfa004_desc = null
            DISPLAY BY NAME g_prfa_m.prfa004_desc
            IF NOT cl_null(g_prfa_m.prfa004) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfa004 != g_prfa_m_t.prfa004 or g_prfa_m_t.prfa004 is null)) THEN    #160824-00007#148 20161101 mark by beckxie
               IF g_prfa_m.prfa004 != g_prfa_m_o.prfa004 OR cl_null(g_prfa_m_o.prfa004) THEN    #160824-00007#148 20161101 add by beckxie
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prfa_m.prfa004
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN

               ELSE
                  #檢查失敗時後續處理
                  #LET g_prfa_m.prfa004 = g_prfa_m_t.prfa004   #160824-00007#148 20161101 mark by beckxie
                  LET g_prfa_m.prfa004 = g_prfa_m_o.prfa004   #160824-00007#148 20161101 add by beckxie
                  LET g_prfa_m.prfa005 = g_prfa_m_o.prfa005   #160824-00007#148 20161101 add by beckxie
                  DISPLAY BY NAME g_prfa_m.prfa005            #160824-00007#148 20161101 add by beckxie
                  CALL aprt501_prfa004_ref()
                  NEXT FIELD CURRENT
               END IF
               CALL aprt501_prfa004_display()
               END IF
            END IF 
            CALL aprt501_prfa004_ref()
            LET g_prfa_m_o.* = g_prfa_m.* #160824-00007#148 20161101 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa004
            #add-point:BEFORE FIELD prfa004 name="input.b.prfa004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfa004
            #add-point:ON CHANGE prfa004 name="input.g.prfa004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfa005
            
            #add-point:AFTER FIELD prfa005 name="input.a.prfa005"
            LET g_prfa_m.prfa005_desc = null
            DISPLAY BY NAME g_prfa_m.prfa005_desc
            IF NOT cl_null(g_prfa_m.prfa005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfa005 != g_prfa_m_t.prfa005 or g_prfa_m_t.prfa005 is null)) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prfa_m.prfa005
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prfa_m.prfa005 = g_prfa_m_t.prfa005
                  CALL aprt501_prfa005_ref()
                  NEXT FIELD CURRENT
               END IF
               END IF

            END IF 
            CALL aprt501_prfa005_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfa005
            #add-point:BEFORE FIELD prfa005 name="input.b.prfa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfa005
            #add-point:ON CHANGE prfa005 name="input.g.prfa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfaunit
            #add-point:BEFORE FIELD prfaunit name="input.b.prfaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfaunit
            
            #add-point:AFTER FIELD prfaunit name="input.a.prfaunit"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfa_m.prfaunit
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfa_m.prfaunit_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfa_m.prfaunit_desc

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfaunit
            #add-point:ON CHANGE prfaunit name="input.g.prfaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfastus
            #add-point:BEFORE FIELD prfastus name="input.b.prfastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfastus
            
            #add-point:AFTER FIELD prfastus name="input.a.prfastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfastus
            #add-point:ON CHANGE prfastus name="input.g.prfastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfasite
            #add-point:ON ACTION controlp INFIELD prfasite name="input.c.prfasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfasite             #給予default值
            LET g_qryparam.default2 = "" #g_prfa_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfasite',g_prfa_m.prfasite,'i')   #150308-00001#4 150309 by lori522612 add 'i'

            CALL q_ooef001_24() 
            
#            CALL q_ooef001()                                #呼叫開窗

            LET g_prfa_m.prfasite = g_qryparam.return1              
            #LET g_prfa_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_prfa_m.prfasite TO prfasite              #
            #DISPLAY g_prfa_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL aprt501_prfasite_ref()
            NEXT FIELD prfasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfadocdt
            #add-point:ON ACTION controlp INFIELD prfadocdt name="input.c.prfadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfadocno
            #add-point:ON ACTION controlp INFIELD prfadocno name="input.c.prfadocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "aprt501" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prfa_m.prfadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prfa_m.prfadocno TO prfadocno              #顯示到畫面上

            NEXT FIELD prfadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa001
            #add-point:ON ACTION controlp INFIELD prfa001 name="input.c.prfa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa002
            #add-point:ON ACTION controlp INFIELD prfa002 name="input.c.prfa002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfa002             #給予default值

            #給予arg
            IF g_prfa_m.prfa001='U' THEN
               CALL q_prfc001()                                #呼叫開窗
            END IF 
            LET g_prfa_m.prfa002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prfa_m.prfa002 TO prfa002              #顯示到畫面上

            NEXT FIELD prfa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa003
            #add-point:ON ACTION controlp INFIELD prfa003 name="input.c.prfa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfaacti
            #add-point:ON ACTION controlp INFIELD prfaacti name="input.c.prfaacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfal002
            #add-point:ON ACTION controlp INFIELD prfal002 name="input.c.prfal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfal003
            #add-point:ON ACTION controlp INFIELD prfal003 name="input.c.prfal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa004
            #add-point:ON ACTION controlp INFIELD prfa004 name="input.c.prfa004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfa004             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_prfa_m.prfa004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prfa_m.prfa004 TO prfa004              #顯示到畫面上
            CALL aprt501_prfa004_ref()
            #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfa004 != g_prfa_m_t.prfa004 or g_prfa_m_t.prfa004 is null)) THEN   #160824-00007#148 20161101 mark by beckxie
            IF g_prfa_m.prfa004 != g_prfa_m_o.prfa004 OR cl_null(g_prfa_m_o.prfa004) THEN   #160824-00007#148 20161101 add by beckxie
               CALL aprt501_prfa004_display()
            END IF            
            NEXT FIELD prfa004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfa005
            #add-point:ON ACTION controlp INFIELD prfa005 name="input.c.prfa005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfa005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_prfa_m.prfa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prfa_m.prfa005 TO prfa005              #顯示到畫面上
            CALL aprt501_prfa005_ref() 
            NEXT FIELD prfa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfaunit
            #add-point:ON ACTION controlp INFIELD prfaunit name="input.c.prfaunit"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfaunit             #給予default值
            LET g_qryparam.default2 = "" #g_prfa_m.ooefl003 #說明(簡稱)

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_prfa_m.prfaunit = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_prfa_m.ooefl003 = g_qryparam.return2 #說明(簡稱)

            DISPLAY g_prfa_m.prfaunit TO prfaunit              #顯示到畫面上
            #DISPLAY g_prfa_m.ooefl003 TO ooefl003 #說明(簡稱)

            NEXT FIELD prfaunit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfastus
            #add-point:ON ACTION controlp INFIELD prfastus name="input.c.prfastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prfa_m.prfadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #ken取消mark
               IF NOT cl_null(g_prfa_m.prfadocno) THEN 
               
                  CALL s_aooi200_gen_docno(g_prfa_m.prfasite,g_prfa_m.prfadocno,g_prfa_m.prfadocdt,g_prog)
                     RETURNING  g_success,g_prfa_m.prfadocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00001"
                     LET g_errparam.extend = g_prfa_m.prfadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD prfadocno
                  ELSE
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfa_t WHERE "||"prfaent = '" ||g_enterprise|| "' AND "||"prfadocno = '"||g_prfa_m.prfadocno ||"'",'std-00004',1) THEN
                        LET g_prfa_m.prfadocno = g_prfadocno_t
                        NEXT FIELD prfadocno
                     END IF

                  END IF
                  LET g_prfa_m_t.prfadocno = g_prfa_m.prfadocno
                     
               END IF
               
               LET g_prfa_m.prfaunit = g_prfa_m.prfasite #ken---add 需求單號：141208-00001 項次：26
               #end add-point
               
               INSERT INTO prfa_t (prfaent,prfasite,prfadocdt,prfadocno,prfa001,prfa002,prfa003,prfaacti, 
                   prfa004,prfa005,prfaunit,prfastus,prfaownid,prfaowndp,prfacrtid,prfacrtdp,prfacrtdt, 
                   prfamodid,prfamoddt,prfacnfid,prfacnfdt)
               VALUES (g_enterprise,g_prfa_m.prfasite,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001, 
                   g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004,g_prfa_m.prfa005, 
                   g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
                   g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
                   g_prfa_m.prfacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prfa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
                              CALL aprt501_pmaa_t('i')
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prfa_m.prfadocno = g_master_multi_table_t.prfaldocno AND
         g_prfa_m.prfal002 = g_master_multi_table_t.prfal002 AND 
         g_prfa_m.prfal003 = g_master_multi_table_t.prfal003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prfalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prfa_m.prfadocno
            LET l_field_keys[02] = 'prfaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prfaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prfal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prfa_m.prfal002
            LET l_fields[01] = 'prfal002'
            LET l_vars[02] = g_prfa_m.prfal003
            LET l_fields[02] = 'prfal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prfal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfa_m.prfa002 != g_prfa_m_t.prfa002 OR g_prfa_m_t.prfa002 IS NULL )) THEN
                  CALL aprt501_ins_prfb() RETURNING l_success
                  IF l_success=false THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprt501_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt501_b_fill()
                  CALL aprt501_b_fill2('0')
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
               CALL aprt501_prfa_t_mask_restore('restore_mask_o')
               
               UPDATE prfa_t SET (prfasite,prfadocdt,prfadocno,prfa001,prfa002,prfa003,prfaacti,prfa004, 
                   prfa005,prfaunit,prfastus,prfaownid,prfaowndp,prfacrtid,prfacrtdp,prfacrtdt,prfamodid, 
                   prfamoddt,prfacnfid,prfacnfdt) = (g_prfa_m.prfasite,g_prfa_m.prfadocdt,g_prfa_m.prfadocno, 
                   g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
                   g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp, 
                   g_prfa_m.prfacrtid,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt, 
                   g_prfa_m.prfacnfid,g_prfa_m.prfacnfdt)
                WHERE prfaent = g_enterprise AND prfadocno = g_prfadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prfa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
                              CALL aprt501_pmaa_t('u')
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prfa_m.prfadocno = g_master_multi_table_t.prfaldocno AND
         g_prfa_m.prfal002 = g_master_multi_table_t.prfal002 AND 
         g_prfa_m.prfal003 = g_master_multi_table_t.prfal003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prfalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prfa_m.prfadocno
            LET l_field_keys[02] = 'prfaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prfaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prfal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prfa_m.prfal002
            LET l_fields[01] = 'prfal002'
            LET l_vars[02] = g_prfa_m.prfal003
            LET l_fields[02] = 'prfal003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prfal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aprt501_prfa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prfa_m_t)
               LET g_log2 = util.JSON.stringify(g_prfa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prfadocno_t = g_prfa_m.prfadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt501.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prfb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prfb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt501_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prfb_d.getLength()
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
            OPEN aprt501_cl USING g_enterprise,g_prfa_m.prfadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt501_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt501_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prfb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prfb_d[l_ac].prfb001 IS NOT NULL
               AND g_prfb_d[l_ac].prfb002 IS NOT NULL
               AND g_prfb_d[l_ac].prfb003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prfb_d_t.* = g_prfb_d[l_ac].*  #BACKUP
               LET g_prfb_d_o.* = g_prfb_d[l_ac].*  #BACKUP
               CALL aprt501_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt501_set_no_entry_b(l_cmd)
               IF NOT aprt501_lock_b("prfb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt501_bcl INTO g_prfb_d[l_ac].prfbacti,g_prfb_d[l_ac].prfb001,g_prfb_d[l_ac].prfb002, 
                      g_prfb_d[l_ac].prfb003,g_prfb_d[l_ac].prfbsite,g_prfb_d[l_ac].prfbunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prfb_d_t.prfb001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prfb_d_mask_o[l_ac].* =  g_prfb_d[l_ac].*
                  CALL aprt501_prfb_t_mask()
                  LET g_prfb_d_mask_n[l_ac].* =  g_prfb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt501_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd='u' then 
               CALL aprt501_fill()
            END IF   
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
            INITIALIZE g_prfb_d[l_ac].* TO NULL 
            INITIALIZE g_prfb_d_t.* TO NULL 
            INITIALIZE g_prfb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prfb_d[l_ac].prfbacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prfb_d_t.* = g_prfb_d[l_ac].*     #新輸入資料
            LET g_prfb_d_o.* = g_prfb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt501_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt501_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prfb_d[li_reproduce_target].* = g_prfb_d[li_reproduce].*
 
               LET g_prfb_d[li_reproduce_target].prfb001 = NULL
               LET g_prfb_d[li_reproduce_target].prfb002 = NULL
               LET g_prfb_d[li_reproduce_target].prfb003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL g_pmaa_d.clear()
            CALL aprt501_fill()
            LET g_prfb_d[l_ac].prfbunit = g_prfa_m.prfaunit
            LET g_prfb_d[l_ac].prfbsite = g_prfa_m.prfasite
            CALL aprt501_create_prfb001()
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
            SELECT COUNT(1) INTO l_count FROM prfb_t 
             WHERE prfbent = g_enterprise AND prfbdocno = g_prfa_m.prfadocno
 
               AND prfb001 = g_prfb_d[l_ac].prfb001
               AND prfb002 = g_prfb_d[l_ac].prfb002
               AND prfb003 = g_prfb_d[l_ac].prfb003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfa_m.prfadocno
               LET gs_keys[2] = g_prfb_d[g_detail_idx].prfb001
               LET gs_keys[3] = g_prfb_d[g_detail_idx].prfb002
               LET gs_keys[4] = g_prfb_d[g_detail_idx].prfb003
               CALL aprt501_insert_b('prfb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prfb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prfb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt501_b_fill()
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
               LET gs_keys[01] = g_prfa_m.prfadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prfb_d_t.prfb001
               LET gs_keys[gs_keys.getLength()+1] = g_prfb_d_t.prfb002
               LET gs_keys[gs_keys.getLength()+1] = g_prfb_d_t.prfb003
 
            
               #刪除同層單身
               IF NOT aprt501_delete_b('prfb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt501_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt501_key_delete_b(gs_keys,'prfb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt501_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt501_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prfb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfbacti
            #add-point:BEFORE FIELD prfbacti name="input.b.page1.prfbacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfbacti
            
            #add-point:AFTER FIELD prfbacti name="input.a.page1.prfbacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfbacti
            #add-point:ON CHANGE prfbacti name="input.g.page1.prfbacti"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfb001
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfb_d[l_ac].prfb001,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfb001
            END IF 
 
 
 
            #add-point:AFTER FIELD prfb001 name="input.a.page1.prfb001"
            IF NOT cl_null(g_prfb_d[l_ac].prfb001) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  g_prfa_m.prfadocno IS NOT NULL AND g_prfb_d[g_detail_idx].prfb001 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb002 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfa_m.prfadocno != g_prfadocno_t OR g_prfb_d[g_detail_idx].prfb001 != g_prfb_d_t.prfb001 OR g_prfb_d[g_detail_idx].prfb002 != g_prfb_d_t.prfb002 OR g_prfb_d[g_detail_idx].prfb003 != g_prfb_d_t.prfb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfb_t WHERE "||"prfbent = '" ||g_enterprise|| "' AND "||"prfbdocno = '"||g_prfa_m.prfadocno ||"'  AND "|| "prfb001 = '"||g_prfb_d[g_detail_idx].prfb001 ||"' AND "|| "prfb002 = '"||g_prfb_d[g_detail_idx].prfb002 ||"' AND "|| "prfb003 = '"||g_prfb_d[g_detail_idx].prfb003 ||"'",'std-00004',0) THEN
                     LET g_prfb_d[l_ac].prfb001 = g_prfb_d_t.prfb001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfb001
            #add-point:BEFORE FIELD prfb001 name="input.b.page1.prfb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfb001
            #add-point:ON CHANGE prfb001 name="input.g.page1.prfb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfb002
            #add-point:BEFORE FIELD prfb002 name="input.b.page1.prfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfb002
            
            #add-point:AFTER FIELD prfb002 name="input.a.page1.prfb002"
            #此段落由子樣板a05產生
            IF  g_prfa_m.prfadocno IS NOT NULL  AND g_prfb_d[g_detail_idx].prfb001 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb002 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfa_m.prfadocno != g_prfadocno_t  OR g_prfb_d[g_detail_idx].prfb001 != g_prfb_d_t.prfb001 OR g_prfb_d[g_detail_idx].prfb002 != g_prfb_d_t.prfb002 OR g_prfb_d[g_detail_idx].prfb003 != g_prfb_d_t.prfb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfb_t WHERE "||"prfbent = '" ||g_enterprise|| "' AND "||"prfbdocno = '"||g_prfa_m.prfadocno ||"'  AND "|| "prfb001 = '"||g_prfb_d[g_detail_idx].prfb001 ||"' AND "|| "prfb002 = '"||g_prfb_d[g_detail_idx].prfb002 ||"' AND "|| "prfb003 = '"||g_prfb_d[g_detail_idx].prfb003 ||"'",'std-00004',0) THEN 
                     LET g_prfb_d[l_ac].prfb002 = g_prfb_d_t.prfb002
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfb002
            #add-point:ON CHANGE prfb002 name="input.g.page1.prfb002"
            IF  g_prfa_m.prfadocno IS NOT NULL  AND g_prfb_d[g_detail_idx].prfb001 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb002 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfa_m.prfadocno != g_prfadocno_t  OR g_prfb_d[g_detail_idx].prfb001 != g_prfb_d_t.prfb001 OR g_prfb_d[g_detail_idx].prfb002 != g_prfb_d_t.prfb002 OR g_prfb_d[g_detail_idx].prfb003 != g_prfb_d_t.prfb003)) THEN 
                  
                  LET g_prfb_d[l_ac].prfb003 = NULL
                  LET g_prfb_d[l_ac].prfb003_desc = NULL
                  DISPLAY g_prfb_d[l_ac].prfb003 TO s_detail1[l_ac].prfb003
                  DISPLAY g_prfb_d[l_ac].prfb003_desc TO s_detail1[l_ac].prfb003_desc
               END IF
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfb003
            
            #add-point:AFTER FIELD prfb003 name="input.a.page1.prfb003"
            #此段落由子樣板a05產生
            LET g_prfb_d[l_ac].prfb003_desc = NULL
            DISPLAY g_prfb_d[l_ac].prfb003_desc to s_detail1[l_ac].prfb003_desc
            IF  g_prfa_m.prfadocno IS NOT NULL  AND g_prfb_d[g_detail_idx].prfb001 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb002 IS NOT NULL AND g_prfb_d[g_detail_idx].prfb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfa_m.prfadocno != g_prfadocno_t  OR g_prfb_d[g_detail_idx].prfb001 != g_prfb_d_t.prfb001 OR g_prfb_d[g_detail_idx].prfb002 != g_prfb_d_t.prfb002 OR g_prfb_d[g_detail_idx].prfb003 != g_prfb_d_t.prfb003 OR g_prfb_d_t.prfb003 is null)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfb_t WHERE "||"prfbent = '" ||g_enterprise|| "' AND "||"prfbdocno = '"||g_prfa_m.prfadocno ||"'  AND "|| "prfb001 = '"||g_prfb_d[g_detail_idx].prfb001 ||"' AND "|| "prfb002 = '"||g_prfb_d[g_detail_idx].prfb002 ||"' AND "|| "prfb003 = '"||g_prfb_d[g_detail_idx].prfb003 ||"'",'std-00004',0) THEN
                     LET g_prfb_d[l_ac].prfb003 = g_prfb_d_t.prfb003
                     CALL aprt501_prfb003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt501_prfb003()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prfb_d[l_ac].prfb003
                     #160318-00005#41 --s add
                     CASE g_prfb_d[l_ac].prfb002
                     WHEN '1'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'apmm100'
                           LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                           LET g_errparam.exeprog = 'apmm100'
                        END IF
                     WHEN '2'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi021'
                           LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi021'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi021'
                           LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi021'
                        END IF
                     WHEN '3'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi037'
                           LET g_errparam.replace[2] = cl_get_progname('axmi037',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi037'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi037'
                           LET g_errparam.replace[2] = cl_get_progname('axmi037',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi037'
                        END IF
                     WHEN '4'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi038'
                           LET g_errparam.replace[2] = cl_get_progname('axmi038',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi038'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi038'
                           LET g_errparam.replace[2] = cl_get_progname('axmi037',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi038'
                        END IF
                     WHEN '5'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi039'
                           LET g_errparam.replace[2] = cl_get_progname('axmi039',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi039'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi039'
                           LET g_errparam.replace[2] = cl_get_progname('axmi039',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi039'
                        END IF
                     WHEN '6'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi040'
                           LET g_errparam.replace[2] = cl_get_progname('axmi040',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi040'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi040'
                           LET g_errparam.replace[2] = cl_get_progname('axmi040',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi040'
                        END IF
                     WHEN '7'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi041'
                           LET g_errparam.replace[2] = cl_get_progname('axmi041',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi041'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi041'
                           LET g_errparam.replace[2] = cl_get_progname('axmi041',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi041'
                        END IF
                     WHEN '8'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi042'
                           LET g_errparam.replace[2] = cl_get_progname('axmi042',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi042'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi042'
                           LET g_errparam.replace[2] = cl_get_progname('axmi042',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi042'
                        END IF
                     WHEN '9'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi043'
                           LET g_errparam.replace[2] = cl_get_progname('axmi043',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi043'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi043'
                           LET g_errparam.replace[2] = cl_get_progname('axmi043',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi043'
                        END IF
                     WHEN '10'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi044'
                           LET g_errparam.replace[2] = cl_get_progname('axmi044',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi044'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi044'
                           LET g_errparam.replace[2] = cl_get_progname('axmi044',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi044'
                        END IF
                     WHEN '11'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi045'
                           LET g_errparam.replace[2] = cl_get_progname('axmi045',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi045'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi045'
                           LET g_errparam.replace[2] = cl_get_progname('axmi045',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi045'
                        END IF
                     WHEN '12'
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'axmi046'
                           LET g_errparam.replace[2] = cl_get_progname('axmi046',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi046'
                        END IF
                        IF g_errno = 'sub-01303' THEN
                           LET g_errparam.replace[1] = 'axmi046'
                           LET g_errparam.replace[2] = cl_get_progname('axmi046',g_lang,"2")
                           LET g_errparam.exeprog = 'axmi046'
                        END IF
                     END CASE
                     #160318-00005#41 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfb_d[l_ac].prfb003 = g_prfb_d_t.prfb003
                     CALL aprt501_prfb003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aprt501_prfb003_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfb003
            #add-point:BEFORE FIELD prfb003 name="input.b.page1.prfb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfb003
            #add-point:ON CHANGE prfb003 name="input.g.page1.prfb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfbsite
            #add-point:BEFORE FIELD prfbsite name="input.b.page1.prfbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfbsite
            
            #add-point:AFTER FIELD prfbsite name="input.a.page1.prfbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfbsite
            #add-point:ON CHANGE prfbsite name="input.g.page1.prfbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfbunit
            #add-point:BEFORE FIELD prfbunit name="input.b.page1.prfbunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfbunit
            
            #add-point:AFTER FIELD prfbunit name="input.a.page1.prfbunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfbunit
            #add-point:ON CHANGE prfbunit name="input.g.page1.prfbunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prfbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfbacti
            #add-point:ON ACTION controlp INFIELD prfbacti name="input.c.page1.prfbacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfb001
            #add-point:ON ACTION controlp INFIELD prfb001 name="input.c.page1.prfb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfb002
            #add-point:ON ACTION controlp INFIELD prfb002 name="input.c.page1.prfb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfb003
            #add-point:ON ACTION controlp INFIELD prfb003 name="input.c.page1.prfb003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfa_m.prfa005             #給予default值

            CASE g_prfb_d[l_ac].prfb002
               WHEN '1'
                  LET g_qryparam.arg1 = 'ALL'
                  CALL q_pmaa001_6() 
               WHEN '2'
                  LET g_qryparam.arg1 =281
                  CALL q_oocq002_5() 
               WHEN '3'
                  LET g_qryparam.arg1=2061
                  CALL q_oocq002_5()
               WHEN '4'
                  LET g_qryparam.arg1=2062
                  CALL q_oocq002_5()
               WHEN '5'
                  LET g_qryparam.arg1=2063
                  CALL q_oocq002_5()
               WHEN '6'
                  LET g_qryparam.arg1=2064
                  CALL q_oocq002_5()
               WHEN '7'
                  LET g_qryparam.arg1=2065
                  CALL q_oocq002_5()
               WHEN '8'
                  LET g_qryparam.arg1=2066
                  CALL q_oocq002_5()
               WHEN '9'
                  LET g_qryparam.arg1=2067
                  CALL q_oocq002_5()
               WHEN '10'
                  LET g_qryparam.arg1=2068
                  CALL q_oocq002_5()
               WHEN '11'
                  LET g_qryparam.arg1=2069
                  CALL q_oocq002_5()
               WHEN '12'
                  LET g_qryparam.arg1=2070
                  CALL q_oocq002_5()         
            END CASE                   

            LET g_prfb_d[l_ac].prfb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prfb_d[l_ac].prfb003 TO s_detail1[l_ac].prfb003              #顯示到畫面上
            CALL aprt501_prfb003_ref()
            NEXT FIELD prfb003                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfbsite
            #add-point:ON ACTION controlp INFIELD prfbsite name="input.c.page1.prfbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfbunit
            #add-point:ON ACTION controlp INFIELD prfbunit name="input.c.page1.prfbunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prfb_d[l_ac].* = g_prfb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt501_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prfb_d[l_ac].prfb001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prfb_d[l_ac].* = g_prfb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt501_prfb_t_mask_restore('restore_mask_o')
      
               UPDATE prfb_t SET (prfbdocno,prfbacti,prfb001,prfb002,prfb003,prfbsite,prfbunit) = (g_prfa_m.prfadocno, 
                   g_prfb_d[l_ac].prfbacti,g_prfb_d[l_ac].prfb001,g_prfb_d[l_ac].prfb002,g_prfb_d[l_ac].prfb003, 
                   g_prfb_d[l_ac].prfbsite,g_prfb_d[l_ac].prfbunit)
                WHERE prfbent = g_enterprise AND prfbdocno = g_prfa_m.prfadocno 
 
                  AND prfb001 = g_prfb_d_t.prfb001 #項次   
                  AND prfb002 = g_prfb_d_t.prfb002  
                  AND prfb003 = g_prfb_d_t.prfb003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prfb_d[l_ac].* = g_prfb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prfb_d[l_ac].* = g_prfb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfa_m.prfadocno
               LET gs_keys_bak[1] = g_prfadocno_t
               LET gs_keys[2] = g_prfb_d[g_detail_idx].prfb001
               LET gs_keys_bak[2] = g_prfb_d_t.prfb001
               LET gs_keys[3] = g_prfb_d[g_detail_idx].prfb002
               LET gs_keys_bak[3] = g_prfb_d_t.prfb002
               LET gs_keys[4] = g_prfb_d[g_detail_idx].prfb003
               LET gs_keys_bak[4] = g_prfb_d_t.prfb003
               CALL aprt501_update_b('prfb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt501_prfb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prfb_d[g_detail_idx].prfb001 = g_prfb_d_t.prfb001 
                  AND g_prfb_d[g_detail_idx].prfb002 = g_prfb_d_t.prfb002 
                  AND g_prfb_d[g_detail_idx].prfb003 = g_prfb_d_t.prfb003 
 
                  ) THEN
                  LET gs_keys[01] = g_prfa_m.prfadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prfb_d_t.prfb001
                  LET gs_keys[gs_keys.getLength()+1] = g_prfb_d_t.prfb002
                  LET gs_keys[gs_keys.getLength()+1] = g_prfb_d_t.prfb003
 
                  CALL aprt501_key_update_b(gs_keys,'prfb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prfa_m),util.JSON.stringify(g_prfb_d_t)
               LET g_log2 = util.JSON.stringify(g_prfa_m),util.JSON.stringify(g_prfb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt501_unlock_b("prfb_t","'1'")
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
               LET g_prfb_d[li_reproduce_target].* = g_prfb_d[li_reproduce].*
 
               LET g_prfb_d[li_reproduce_target].prfb001 = NULL
               LET g_prfb_d[li_reproduce_target].prfb002 = NULL
               LET g_prfb_d[li_reproduce_target].prfb003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prfb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prfb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aprt501.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_pmaa_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
               
      END DISPLAY
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
            NEXT FIELD prfasite #ken---add 需求單號：141208-00001 項次：26
            #end add-point  
            NEXT FIELD prfadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prfbacti
 
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
 
{<section id="aprt501.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt501_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt501_b_fill() #單身填充
      CALL aprt501_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt501_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfa_m.prfadocno
   CALL ap_ref_array2(g_ref_fields," SELECT prfal002,prfal003 FROM prfal_t WHERE prfalent = '"||g_enterprise||"' AND prfaldocno = ? AND prfal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_prfa_m.prfal002 = g_rtn_fields[1] 
   LET g_prfa_m.prfal003 = g_rtn_fields[2] 
   DISPLAY g_prfa_m.prfal002,g_prfa_m.prfal003 TO prfal002,prfal003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfa004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prfa_m.prfa004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfa004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfa005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfa_m.prfa005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfa005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prfa_m.prfaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfa_m.prfaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prfa_m.prfacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfa_m.prfacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prfa_m.prfamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfa_m.prfacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prfa_m.prfacnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfa_m.prfacnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prfa_m_mask_o.* =  g_prfa_m.*
   CALL aprt501_prfa_t_mask()
   LET g_prfa_m_mask_n.* =  g_prfa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001, 
       g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003,g_prfa_m.prfa004, 
       g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc,g_prfa_m.prfaunit,g_prfa_m.prfastus, 
       g_prfa_m.prfaownid,g_prfa_m.prfaownid_desc,g_prfa_m.prfaowndp,g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid, 
       g_prfa_m.prfamodid_desc,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid,g_prfa_m.prfacnfid_desc,g_prfa_m.prfacnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfa_m.prfastus 
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
   FOR l_ac = 1 TO g_prfb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL aprt501_prfb003_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt501_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF l_ac<>0 THEN
      CALL aprt501_fill()
   END IF   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt501_detail_show()
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
 
{<section id="aprt501.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt501_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prfa_t.prfadocno 
   DEFINE l_oldno     LIKE prfa_t.prfadocno 
 
   DEFINE l_master    RECORD LIKE prfa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prfb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：26
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
   
   IF g_prfa_m.prfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prfadocno_t = g_prfa_m.prfadocno
 
    
   LET g_prfa_m.prfadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prfa_m.prfaownid = g_user
      LET g_prfa_m.prfaowndp = g_dept
      LET g_prfa_m.prfacrtid = g_user
      LET g_prfa_m.prfacrtdp = g_dept 
      LET g_prfa_m.prfacrtdt = cl_get_current()
      LET g_prfa_m.prfamodid = g_user
      LET g_prfa_m.prfamoddt = cl_get_current()
      LET g_prfa_m.prfastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #ken---add---s 需求單號：141208-00001 項次：26
   CALL s_aooi500_default(g_prog,'prfasite',g_prfa_m.prfasite)
      RETURNING l_insert,g_prfa_m.prfasite
   IF l_insert = FALSE THEN
      RETURN
   END IF   
   #ken---add---e
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prfa_m.prfasite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prfa_m.prfadocno = r_doctype
   #dongsz--add--end---
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfa_m.prfastus 
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
   
   
   CALL aprt501_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prfa_m.* TO NULL
      INITIALIZE g_prfb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt501_show()
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
   CALL aprt501_set_act_visible()   
   CALL aprt501_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prfadocno_t = g_prfa_m.prfadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prfaent = " ||g_enterprise|| " AND",
                      " prfadocno = '", g_prfa_m.prfadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt501_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt501_idx_chk()
   
   LET g_data_owner = g_prfa_m.prfaownid      
   LET g_data_dept  = g_prfa_m.prfaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt501_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt501_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prfb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt501_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prfb_t
    WHERE prfbent = g_enterprise AND prfbdocno = g_prfadocno_t
 
    INTO TEMP aprt501_detail
 
   #將key修正為調整後   
   UPDATE aprt501_detail 
      #更新key欄位
      SET prfbdocno = g_prfa_m.prfadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prfb_t SELECT * FROM aprt501_detail
   
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
   DROP TABLE aprt501_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prfadocno_t = g_prfa_m.prfadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt501_delete()
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
   
   IF g_prfa_m.prfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.prfaldocno = g_prfa_m.prfadocno
LET g_master_multi_table_t.prfal002 = g_prfa_m.prfal002
LET g_master_multi_table_t.prfal003 = g_prfa_m.prfal003
 
   
   CALL s_transaction_begin()
 
   OPEN aprt501_cl USING g_enterprise,g_prfa_m.prfadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt501_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt501_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
       g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
       g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
       g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc,g_prfa_m.prfaownid_desc, 
       g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfamodid_desc, 
       g_prfa_m.prfacnfid_desc
                  CALL aprt501_pmaa_t('s')
   
   #檢查是否允許此動作
   IF NOT aprt501_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prfa_m_mask_o.* =  g_prfa_m.*
   CALL aprt501_prfa_t_mask()
   LET g_prfa_m_mask_n.* =  g_prfa_m.*
   
   CALL aprt501_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt501_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prfadocno_t = g_prfa_m.prfadocno
 
 
      DELETE FROM prfa_t
       WHERE prfaent = g_enterprise AND prfadocno = g_prfa_m.prfadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prfa_m.prfadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #ken---add---s 需求單號：141208-00001 項次：26
      IF NOT s_aooi200_del_docno(g_prfa_m.prfadocno,g_prfa_m.prfadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken---add---e
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM prfb_t
       WHERE prfbent = g_enterprise AND prfbdocno = g_prfa_m.prfadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
                     CALL aprt501_pmaa_t('d')      
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prfa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt501_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prfb_d.clear() 
 
     
      CALL aprt501_ui_browser_refresh()  
      #CALL aprt501_ui_headershow()  
      #CALL aprt501_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'prfalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.prfaldocno
   LET l_field_keys[02] = 'prfaldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prfal_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt501_browser_fill("")
         CALL aprt501_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt501_cl
 
   #功能已完成,通報訊息中心
   CALL aprt501_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt501_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prfb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt501_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prfbacti,prfb001,prfb002,prfb003,prfbsite,prfbunit  FROM prfb_t", 
                
                     " INNER JOIN prfa_t ON prfaent = " ||g_enterprise|| " AND prfadocno = prfbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE prfbent=? AND prfbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prfb_t.prfb001,prfb_t.prfb002,prfb_t.prfb003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt501_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt501_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prfa_m.prfadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prfa_m.prfadocno INTO g_prfb_d[l_ac].prfbacti,g_prfb_d[l_ac].prfb001, 
          g_prfb_d[l_ac].prfb002,g_prfb_d[l_ac].prfb003,g_prfb_d[l_ac].prfbsite,g_prfb_d[l_ac].prfbunit  
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_prfb_d.deleteElement(g_prfb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt501_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prfb_d.getLength()
      LET g_prfb_d_mask_o[l_ac].* =  g_prfb_d[l_ac].*
      CALL aprt501_prfb_t_mask()
      LET g_prfb_d_mask_n[l_ac].* =  g_prfb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt501_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prfb_t
       WHERE prfbent = g_enterprise AND
         prfbdocno = ps_keys_bak[1] AND prfb001 = ps_keys_bak[2] AND prfb002 = ps_keys_bak[3] AND prfb003 = ps_keys_bak[4]
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
         CALL g_prfb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt501_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prfb_t
                  (prfbent,
                   prfbdocno,
                   prfb001,prfb002,prfb003
                   ,prfbacti,prfbsite,prfbunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prfb_d[g_detail_idx].prfbacti,g_prfb_d[g_detail_idx].prfbsite,g_prfb_d[g_detail_idx].prfbunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prfb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt501_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prfb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt501_prfb_t_mask_restore('restore_mask_o')
               
      UPDATE prfb_t 
         SET (prfbdocno,
              prfb001,prfb002,prfb003
              ,prfbacti,prfbsite,prfbunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prfb_d[g_detail_idx].prfbacti,g_prfb_d[g_detail_idx].prfbsite,g_prfb_d[g_detail_idx].prfbunit)  
 
         WHERE prfbent = g_enterprise AND prfbdocno = ps_keys_bak[1] AND prfb001 = ps_keys_bak[2] AND prfb002 = ps_keys_bak[3] AND prfb003 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt501_prfb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprt501.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt501_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt501.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt501_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt501.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt501_lock_b(ps_table,ps_page)
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
   #CALL aprt501_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prfb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt501_bcl USING g_enterprise,
                                       g_prfa_m.prfadocno,g_prfb_d[g_detail_idx].prfb001,g_prfb_d[g_detail_idx].prfb002, 
                                           g_prfb_d[g_detail_idx].prfb003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt501_bcl:",SQLERRMESSAGE 
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
 
{<section id="aprt501.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt501_unlock_b(ps_table,ps_page)
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
      CLOSE aprt501_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt501_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prfadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prfadocno",TRUE)
      CALL cl_set_comp_entry("prfadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"

      CALL cl_set_comp_entry("prfa001,prfa002",TRUE)
      CALL cl_set_comp_entry("prfasite",TRUE)
      CALL cl_set_comp_entry("prfadocdt",TRUE) #ken---add 需求單號：141208-00001 項次：26
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"

   CALL cl_set_comp_entry("prfaacti",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt501_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prfadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      SELECT count(*) INTO l_cnt FROM prfb_t WHERE prfbent=g_enterprise AND prfbdocno = g_prfa_m.prfadocno
      IF l_cnt>0 THEN  
         CALL cl_set_comp_entry("prfa001,prfa002",FALSE)
      ELSE
         CALL cl_set_comp_entry("prfa001,prfa002",TRUE)      
      END IF   
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prfadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prfadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #ken---add---s 需求單號：141208-00001 項次：26
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("prfasite",FALSE)
      CALL cl_set_comp_entry("prfadocdt",FALSE)
      CALL cl_set_comp_entry("prfadocno",FALSE)
   END IF
   #ken---add---e
   
   IF g_prfa_m.prfa001='I' THEN
      CALL cl_set_comp_entry("prfaacti",FALSE)
   ELSE
      CALL cl_set_comp_entry("prfaacti",TRUE)     
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'prfasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prfasite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt501.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt501_set_entry_b(p_cmd)
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
 
{<section id="aprt501.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt501_set_no_entry_b(p_cmd)
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
 
{<section id="aprt501.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt501_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt501_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prfa_m.prfastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt501_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt501_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt501_default_search()
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
      LET ls_wc = ls_wc, " prfadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prfa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prfb_t" 
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
 
{<section id="aprt501.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt501_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_prfa_m.prfastus = 'X' THEN
      RETURN
   END IF
   IF g_prfa_m.prfastus = 'C' THEN  #結案狀態
      RETURN
   END IF
   IF g_prfa_m.prfastus = 'Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prfa_m.prfadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt501_cl USING g_enterprise,g_prfa_m.prfadocno
   IF STATUS THEN
      CLOSE aprt501_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt501_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
       g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
       g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid, 
       g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc,g_prfa_m.prfaownid_desc, 
       g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfamodid_desc, 
       g_prfa_m.prfacnfid_desc
                  CALL aprt501_pmaa_t('s')
 
   #檢查是否允許此動作
   IF NOT aprt501_action_chk() THEN
      CLOSE aprt501_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc,g_prfa_m.prfadocdt,g_prfa_m.prfadocno,g_prfa_m.prfa001, 
       g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003,g_prfa_m.prfa004, 
       g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc,g_prfa_m.prfaunit,g_prfa_m.prfastus, 
       g_prfa_m.prfaownid,g_prfa_m.prfaownid_desc,g_prfa_m.prfaowndp,g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid, 
       g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid, 
       g_prfa_m.prfamodid_desc,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid,g_prfa_m.prfacnfid_desc,g_prfa_m.prfacnfdt 
 
 
   CASE g_prfa_m.prfastus
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
         CASE g_prfa_m.prfastus
            
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
#      CALL cl_set_act_visible("unconfirmed", FALSE)
#      CALL cl_set_act_visible("invalid,confirmed", true)
#      IF g_prfa_m.prfastus = 'N' THEN
#         CALL cl_set_act_visible("unconfirmed", FALSE)
#         CALL cl_set_act_visible("invalid,confirmed", true)            
#      END IF
#      IF g_prfa_m.prfastus = 'Y' THEN
#         CALL cl_set_act_visible("confirmed,invalid", FALSE)      
#      END IF
#      IF g_prfa_m.prfastus = 'X' THEN
#         CALL cl_set_act_visible("confirmed,invalid", FALSE)      
#      END IF 
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_prfa_m.prfastus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("invalid,confirmed,unconfirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unconfirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aprt501_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt501_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt501_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt501_cl
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
      g_prfa_m.prfastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt501_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT prfastus INTO g_prfa_m.prfastus FROM prfa_t WHERE prfadocno = g_prfa_m.prfadocno
            AND prfaent = g_enterprise         
         CALL s_aprt501_conf_chk(g_prfa_m.prfadocno,g_prfa_m.prfastus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_aprt501_conf_upd(g_prfa_m.prfadocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfa_m.prfadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
               RETURN
            END IF            
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN            
         END IF
                 
      WHEN 'X'
         SELECT prfastus INTO g_prfa_m.prfastus FROM prfa_t WHERE prfadocno = g_prfa_m.prfadocno
            AND prfaent = g_enterprise  
         CALL s_aprt501_void_chk(g_prfa_m.prfadocno,g_prfa_m.prfastus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_aprt501_void_upd(g_prfa_m.prfadocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfa_m.prfadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
               RETURN
            END IF
         ELSE 
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN    
         END IF        
   END CASE
   #end add-point
   
   LET g_prfa_m.prfamodid = g_user
   LET g_prfa_m.prfamoddt = cl_get_current()
   LET g_prfa_m.prfastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prfa_t 
      SET (prfastus,prfamodid,prfamoddt) 
        = (g_prfa_m.prfastus,g_prfa_m.prfamodid,g_prfa_m.prfamoddt)     
    WHERE prfaent = g_enterprise AND prfadocno = g_prfa_m.prfadocno
 
    
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
      EXECUTE aprt501_master_referesh USING g_prfa_m.prfadocno INTO g_prfa_m.prfasite,g_prfa_m.prfadocdt, 
          g_prfa_m.prfadocno,g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004, 
          g_prfa_m.prfa005,g_prfa_m.prfaunit,g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaowndp, 
          g_prfa_m.prfacrtid,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt, 
          g_prfa_m.prfacnfid,g_prfa_m.prfacnfdt,g_prfa_m.prfasite_desc,g_prfa_m.prfa004_desc,g_prfa_m.prfa005_desc, 
          g_prfa_m.prfaownid_desc,g_prfa_m.prfaowndp_desc,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp_desc, 
          g_prfa_m.prfamodid_desc,g_prfa_m.prfacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prfa_m.prfasite,g_prfa_m.prfasite_desc,g_prfa_m.prfadocdt,g_prfa_m.prfadocno, 
          g_prfa_m.prfa001,g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfal002,g_prfa_m.prfal003, 
          g_prfa_m.prfa004,g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc,g_prfa_m.prfaunit, 
          g_prfa_m.prfastus,g_prfa_m.prfaownid,g_prfa_m.prfaownid_desc,g_prfa_m.prfaowndp,g_prfa_m.prfaowndp_desc, 
          g_prfa_m.prfacrtid,g_prfa_m.prfacrtid_desc,g_prfa_m.prfacrtdp,g_prfa_m.prfacrtdp_desc,g_prfa_m.prfacrtdt, 
          g_prfa_m.prfamodid,g_prfa_m.prfamodid_desc,g_prfa_m.prfamoddt,g_prfa_m.prfacnfid,g_prfa_m.prfacnfid_desc, 
          g_prfa_m.prfacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT prfastus,prfacnfid,prfacnfdt,prfamodid,prfamoddt INTO g_prfa_m.prfastus,g_prfa_m.prfacnfid,g_prfa_m.prfacnfdt,
                                                                g_prfa_m.prfamodid,g_prfa_m.prfamoddt  
     FROM prfa_t
    WHERE prfaent = g_enterprise AND prfadocno = g_prfa_m.prfadocno
   DISPLAY BY NAME g_prfa_m.prfastus,g_prfa_m.prfacnfid,g_prfa_m.prfacnfdt,g_prfa_m.prfamodid,g_prfa_m.prfamoddt
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfa_m.prfacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfa_m.prfacnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prfa_m.prfacnfid_desc   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfa_m.prfamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfa_m.prfamodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prfa_m.prfamodid_desc
   IF g_prfa_m.prfastus NOT MATCHES "[DRN]" THEN
      CALL cl_set_act_visible("delete,modify", FALSE)
   ELSE
      CALL cl_set_act_visible("delete,modify", true)    
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt501_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt501_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt501.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt501_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prfb_d.getLength() THEN
         LET g_detail_idx = g_prfb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prfb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prfb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt501_b_fill2(pi_idx)
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
   
   CALL aprt501_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt501_fill_chk(ps_idx)
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
 
{<section id="aprt501.status_show" >}
PRIVATE FUNCTION aprt501_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt501.mask_functions" >}
&include "erp/apr/aprt501_mask.4gl"
 
{</section>}
 
{<section id="aprt501.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt501_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt501_show()
   CALL aprt501_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt501_conf_chk(g_prfa_m.prfadocno,g_prfa_m.prfastus) RETURNING l_success
   IF l_success THEN
            
   ELSE
      CLOSE aprt501_cl
      CALL s_transaction_end('N','0')
      RETURN  FALSE          
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prfa_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prfb_d))
 
 
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
   #CALL aprt501_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt501_ui_headershow()
   CALL aprt501_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt501_draw_out()
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
   CALL aprt501_ui_headershow()  
   CALL aprt501_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt501.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt501_set_pk_array()
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
   LET g_pk_array[1].values = g_prfa_m.prfadocno
   LET g_pk_array[1].column = 'prfadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt501.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt501.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt501_msgcentre_notify(lc_state)
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
   CALL aprt501_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prfa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt501.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt501_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#31 add-S
   SELECT prfastus  INTO g_prfa_m.prfastus
     FROM prfa_t
    WHERE prfaent = g_enterprise
      AND prfadocno = g_prfa_m.prfadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prfa_m.prfastus
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
        LET g_errparam.extend = g_prfa_m.prfadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt501_set_act_visible()
        CALL aprt501_set_act_no_visible()
        CALL aprt501_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#31 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt501.other_function" readonly="Y" >}
#此段落由子樣板a06產生
PRIVATE FUNCTION aprt501_pmaa_t(ps_type)
 

   DEFINE li_cnt    LIKE type_t.num10
   DEFINE ps_type   STRING  
   DEFINE ls_sql    STRING  
#
#   IF ps_type = "s" THEN 
#            LET ls_sql = 'SELECT  FROM pmaa_t WHERE pmaaent= ? AND pmaa001=? ' 
#      DECLARE pmaa_t_cl CURSOR FROM ls_sql 
#      OPEN pmaa_t_cl USING g_enterprise,g_prfa_m.prfadocno
#      FETCH pmaa_t_cl INTO g_prfa_m. 
#
#      IF SQLCA.sqlcode THEN
#                  LET g_prfa_m.  = NULL 
#
#      END IF 
#      RETURN 
#   END IF 
#
#      SELECT COUNT(*) INTO li_cnt FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_prfadocno_t
#   
#   IF li_cnt = 0 AND ps_type = "u" THEN 
#            INSERT INTO pmaa_t 
#      (pmaaent,pmaa001, )
#      VALUES (g_enterprise,g_prfa_m.prfadocno,g_prfa_m. )
#   END IF 
#
#   IF li_cnt > 0 AND ps_type = "u" THEN 
#            UPDATE pmaa_t SET 
#      (pmaa001, ) = 
#      (g_prfa_m.prfadocno,g_prfa_m. ) 
#      WHERE pmaaent = g_enterprise AND pmaa001 = g_prfadocno_t
#
#   END IF 
#
#   IF li_cnt > 0 AND ps_type = "d" THEN 
#            DELETE FROM pmaa_t
#      WHERE pmaaent = g_enterprise AND pmaa001 = g_prfadocno_t
#   END IF 
#
#   IF SQLCA.sqlcode THEN
#      CALL cl_err("",SQLCA.sqlcode,0)
#   END IF 



END FUNCTION
#display prfa004
PRIVATE FUNCTION aprt501_prfa004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfa_m.prfa004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfa_m.prfa004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfa_m.prfa004_desc
   
   
END FUNCTION
#display prfa005
PRIVATE FUNCTION aprt501_prfa004_display()
   SELECT ooag003 INTO g_prfa_m.prfa005
     FROM ooag_t
    WHERE ooagent= g_enterprise
      AND ooag001= g_prfa_m.prfa004 
   CALL aprt501_prfa005_ref()
END FUNCTION
#display prfa005
PRIVATE FUNCTION aprt501_prfa005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfa_m.prfa005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfa_m.prfa005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfa_m.prfa005_desc
END FUNCTION
#display prfa002
PRIVATE FUNCTION aprt501_prfa002_ref()
   
   IF g_prfa_m.prfa001='U' THEN
      SELECT to_char(to_number(max(prfc002))+1) INTO g_prfa_m.prfa003
        FROM prfc_t
       WHERE prfcent = g_enterprise AND prfc001= g_prfa_m.prfa002
      SELECT prfcl003,prfcl004 INTO g_prfa_m.prfal002,g_prfa_m.prfal003
        FROM prfcl_t
       WHERE prfclent = g_enterprise AND prfcl001 = g_prfa_m.prfa002
         AND prfcl002 = g_dlang
      SELECT prfcstus INTO g_prfa_m.prfaacti
        FROM prfc_t
       WHERE prfcent = g_enterprise AND prfc001 = g_prfa_m.prfa002  
      DISPLAY BY NAME g_prfa_m.prfaacti          
   END IF
   IF g_prfa_m.prfa001='I' THEN
      LET  g_prfa_m.prfa003=1 
   END IF
   DISPLAY BY NAME  g_prfa_m.prfa003
END FUNCTION
##display prfasite
PRIVATE FUNCTION aprt501_prfasite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfa_m.prfasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfa_m.prfasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfa_m.prfasite_desc
END FUNCTION
#chk prfa002
PRIVATE FUNCTION aprt501_prfa002()
   DEFINE l_cnt   like type_t.num5
   DEFINE l_cnt2  LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_errno   STRING
   
   LET l_cnt = 0
   LET l_cnt2 = 0
   LET l_success = TRUE
   LET l_errno = NULL
   IF g_prfa_m.prfa001='U' THEN
      SELECT count(*) INTO l_cnt FROM prfc_t WHERE prfcent=g_enterprise
         AND prfc001=g_prfa_m.prfa002
      IF l_cnt<=0 THEN
         LET l_success = FALSE
         LET l_errno = "apr-00153"
         RETURN l_success,l_errno         
      ELSE
         SELECT count(*) INTO l_cnt2 FROM prfc_t WHERE prfcent=g_enterprise
            AND prfc001=g_prfa_m.prfa002 AND prfcstus<>'X'
         IF l_cnt2<=0 THEN   
            LET l_success = FALSE
            LET l_errno = "apr-00154"
            RETURN l_success,l_errno   
         END IF   
      END IF 
               
   END IF
   IF g_prfa_m.prfa001='I' THEN
      SELECT count(*) INTO l_cnt FROM prfc_t WHERE prfcent=g_enterprise
         AND prfc001=g_prfa_m.prfa002
      IF l_cnt>0 THEN
         LET l_success = FALSE
         LET l_errno = "apr-00156"
         RETURN l_success,l_errno           
      END IF
           
   END IF
   LET l_cnt=0
   SELECT count(*) INTO l_cnt FROM prfa_t
    WHERE prfaent = g_enterprise AND prfa002 = g_prfa_m.prfa002
      AND prfastus='N'
   IF l_cnt>0 THEN
      LET l_success = FALSE
      LET l_errno = "apr-00155"
      RETURN l_success,l_errno         
   END IF
   RETURN l_success,l_errno
END FUNCTION
##display prfb003
PRIVATE FUNCTION aprt501_prfb003_ref()
   DEFINE l_oocq001  LIKE oocq_t.oocq001
   CASE g_prfb_d[l_ac].prfb002
      WHEN '1'
         SELECT pmaal003 INTO g_prfb_d[l_ac].prfb003_desc
           FROM pmaal_t WHERE pmaalent = g_enterprise AND pmaal001=g_prfb_d[l_ac].prfb003
            AND pmaal002 = g_dlang
      WHEN '2'
         LET l_oocq001=281
         CALL aprt501_prfb003_display(l_oocq001) 
      WHEN '3'
         LET l_oocq001=2061
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '4'
         LET l_oocq001=2062
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '5'
         LET l_oocq001=2063
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '6'
         LET l_oocq001=2064
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '7'
         LET l_oocq001=2065
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '8'
         LET l_oocq001=2066
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '9'
         LET l_oocq001=2067
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '10'
         LET l_oocq001=2068
         CALL aprt501_prfb003_display(l_oocq001)
      WHEN '11'
         LET l_oocq001=2069
         CALL aprt501_prfb003_display(l_oocq001) 
      WHEN '12'
         LET l_oocq001=2070
         CALL aprt501_prfb003_display(l_oocq001)         
   END CASE         
END FUNCTION
#display
PRIVATE FUNCTION aprt501_prfb003_display(p_oocq001)
   DEFINE p_oocq001  LIKE oocq_t.oocq001
   SELECT oocql004 INTO g_prfb_d[l_ac].prfb003_desc
     FROM oocql_t 
    WHERE oocqlent=g_enterprise 
      AND oocql001=p_oocq001 AND oocql002=g_prfb_d[l_ac].prfb003 AND oocql003=g_dlang
   
   DISPLAY  g_prfb_d[l_ac].prfb003_desc TO s_detail1[l_ac].prfb003_desc
END FUNCTION
#create prfa001
PRIVATE FUNCTION aprt501_create_prfb001()
   SELECT max(prfb001)+1 INTO g_prfb_d[l_ac].prfb001
     FROM prfb_t
    WHERE prfbent = g_enterprise AND prfbdocno=g_prfa_m.prfadocno
   IF cl_null(g_prfb_d[l_ac].prfb001) THEN
      LET g_prfb_d[l_ac].prfb001=1
   END IF   
END FUNCTION
#chk prfb003
PRIVATE FUNCTION aprt501_prfb003()
   DEFINE l_oocq001  LIKE oocq_t.oocq001
   CASE g_prfb_d[l_ac].prfb002
      WHEN '1'
         call aprt501_prfb003_1()
      WHEN '2'
         LET l_oocq001=281
         CALL aprt501_prfb003_2(l_oocq001) 
      WHEN '3'
         LET l_oocq001=2061
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '4'
         LET l_oocq001=2062
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '5'
         LET l_oocq001=2063
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '6'
         LET l_oocq001=2064
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '7'
         LET l_oocq001=2065
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '8'
         LET l_oocq001=2066
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '9'
         LET l_oocq001=2067
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '10'
         LET l_oocq001=2068
         CALL aprt501_prfb003_2(l_oocq001)
      WHEN '11'
         LET l_oocq001=2069
         CALL aprt501_prfb003_2(l_oocq001) 
      WHEN '12'
         LET l_oocq001=2070
         CALL aprt501_prfb003_2(l_oocq001)         
   END CASE  
END FUNCTION
#chk prfb003
PRIVATE FUNCTION aprt501_prfb003_1()
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM pmaa_t WHERE pmaaent = g_enterprise
      AND pmaa001=g_prfb_d[l_ac].prfb003 AND (pmaa002 ='2' OR pmaa002='3')
   IF l_cnt <=0 THEN
      CASE g_prfb_d[l_ac].prfb002
      WHEN '1'
         LET g_errno="apr-00157"
      WHEN '2'
#         LET g_errno="apr-00158"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '3'
#         LET g_errno="apr-00159"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '4'
#         LET g_errno="apr-00160"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '5'
#         LET g_errno="apr-00161"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '6'
#         LET g_errno="apr-00162"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '7'
#         LET g_errno="apr-00163"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '8'
#         LET g_errno="apr-00164"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '9'
#         LET g_errno="apr-00165"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '10'
#         LET g_errno="apr-00166"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '11'
#         LET g_errno="apr-00167"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '12'
#         LET g_errno="apr-00168"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      END CASE
   ELSE
      SELECT count(*) INTO l_cnt FROM pmaa_t WHERE pmaaent = g_enterprise
         AND pmaa001=g_prfb_d[l_ac].prfb003 
         AND (pmaa002 ='2' OR pmaa002='3')
         AND pmaastus='Y'
      IF l_cnt <=0 THEN
         CASE g_prfb_d[l_ac].prfb002
      WHEN '1'
#         LET g_errno="apr-00169"      #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '2'
#         LET g_errno="apr-00170"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '3'
#         LET g_errno="apr-00171"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '4'
#         LET g_errno="apr-00172"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '5'
#         LET g_errno="apr-00173"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '6'
#         LET g_errno="apr-00174"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '7'
#         LET g_errno="apr-00175"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '8'
#         LET g_errno="apr-00176"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '9'
#         LET g_errno="apr-00177"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '10'
#         LET g_errno="apr-00178"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '11'
#         LET g_errno="apr-00179"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '12'
#         LET g_errno="apr-00180"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add         
      END CASE
      END IF   
   END IF   
END FUNCTION
#chk prfb003
PRIVATE FUNCTION aprt501_prfb003_2(p_oocq001)
   DEFINE l_cnt  LIKE type_t.num5
   DEFINE l_cnt1 LIKE type_t.num5
   DEFINE p_oocq001 LIKE oocq_t.oocq001
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM oocq_t WHERE oocqent = g_enterprise
      AND oocq001=p_oocq001 AND oocq002=g_prfb_d[l_ac].prfb003
   IF l_cnt <=0 THEN
      CASE g_prfb_d[l_ac].prfb002
      WHEN '1'
         LET g_errno="apr-00157"
      WHEN '2'
#         LET g_errno="apr-00158"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '3'
#         LET g_errno="apr-00159"       #160318-00005#41  mark
          LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '4'
#         LET g_errno="apr-00160"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '5'
#         LET g_errno="apr-00161"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '6'
#         LET g_errno="apr-00162"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '7'
#         LET g_errno="apr-00163"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '8'
#         LET g_errno="apr-00164"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '9'
#         LET g_errno="apr-00165"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '10'
#         LET g_errno="apr-00166"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '11'
#         LET g_errno="apr-00167"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add
      WHEN '12'
#         LET g_errno="apr-00168"       #160318-00005#41  mark
         LET g_errno="sub-01303"       #160318-00005#41  add         
      END CASE
   ELSE
     SELECT count(*) INTO l_cnt FROM oocq_t WHERE oocqent = g_enterprise
        AND oocq001=p_oocq001 AND oocq002=g_prfb_d[l_ac].prfb003
        AND oocqstus='Y'
      IF l_cnt <=0 THEN
         CASE g_prfb_d[l_ac].prfb002
      WHEN '1'
#         LET g_errno="apr-00169"     #160318-00005#41  mark
         LET g_errno="sub-01302"      #160318-00005#41  add
      WHEN '2'
#         LET g_errno="apr-00170"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '3'
#         LET g_errno="apr-00171"      #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '4'
#         LET g_errno="apr-00172"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '5'
#         LET g_errno="apr-00173"      #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '6'
#         LET g_errno="apr-00174"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '7'
#         LET g_errno="apr-00175"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '8'
#         LET g_errno="apr-00176"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '9'
#         LET g_errno="apr-00177"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '10'
#         LET g_errno="apr-00178"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '11'
#         LET g_errno="apr-00179"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add
      WHEN '12'
#         LET g_errno="apr-00180"       #160318-00005#41  mark
         LET g_errno="sub-01302"       #160318-00005#41  add         
      END CASE
      END IF   
   END IF
END FUNCTION
#fill pmaa
PRIVATE FUNCTION aprt501_fill()
   DEFINE l_sql      STRING
   DEFINE l_sql2     STRING
   DEFINE l_sql3     STRING
   DEFINE l_sql4     STRING
   DEFINE l_prfb001  LIKE prfb_t.prfb001
   DEFINE l_prfb002  LIKE prfb_t.prfb002
   DEFINE l_prfb003  LIKE prfb_t.prfb003                    
                        
   
   CALL g_pmaa_d.clear()
#   IF NOT cl_null(g_prfb_d[l_ac].prfb002) THEN
   LET l_sql = " SELECT distinct pmaa001,pmaal004,pmaal003,pmaal005 ",
               "   FROM pmaa_t LEFT JOIN pmaal_t ON pmaa001=pmaal001 AND pmaaent=pmaalent AND pmaal002='",g_dlang,"' ",
               "  WHERE pmaaent=",g_enterprise," AND pmaastus='Y' "
   let l_sql2 = " SELECT DISTINCT prfb001 FROM prfb_t WHERE prfbent=",g_enterprise," AND prfbdocno='",g_prfa_m.prfadocno,"' AND prfbacti='Y' "  
   PREPARE l_sql2_prfb001_pre FROM l_sql2
   DECLARE l_sql2_prfb001_cs CURSOR FOR  l_sql2_prfb001_pre
   let l_sql3 = " SELECT DISTINCT prfb002 FROM prfb_t WHERE prfbent=",g_enterprise," AND prfbdocno='",g_prfa_m.prfadocno,"' ",
                "    AND prfb001=? AND prfbacti='Y' "
   PREPARE l_sql3_prfb002_pre FROM l_sql3
   DECLARE l_sql3_prfb002_cs CURSOR FOR  l_sql3_prfb002_pre 
   let l_sql4 = " SELECT DISTINCT prfb003 FROM prfb_t WHERE prfbent=",g_enterprise," AND prfbdocno='",g_prfa_m.prfadocno,"' ",
                "    AND prfb001=? AND prfb002=? AND prfbacti='Y' " 
   PREPARE l_sql4_prfb003_pre FROM l_sql4
   DECLARE l_sql4_prfb003_cs CURSOR FOR  l_sql4_prfb003_pre
   LET l_sql4="1<>1"
   LET l_sql3="1=1"
   LET l_sql2="1<>1"
   FOREACH  l_sql2_prfb001_cs INTO l_prfb001
      FOREACH l_sql3_prfb002_cs USING l_prfb001 INTO l_prfb002
         FOREACH l_sql4_prfb003_cs USING l_prfb001,l_prfb002 INTO l_prfb003
            CASE l_prfb002
               WHEN '1'
                  LET l_sql4 = l_sql4," OR pmaa001='",l_prfb003,"' " 
               WHEN '2'
                  LET l_sql4 = l_sql4," OR pmaa090='",l_prfb003,"' "
               WHEN '3'
                  LET l_sql4 = l_sql4," OR pmaa291='",l_prfb003,"' "
               WHEN '4'
                  LET l_sql4 = l_sql4," OR pmaa292='",l_prfb003,"' "
               WHEN '5'
                  LET l_sql4 = l_sql4," OR pmaa293='",l_prfb003,"' "
               WHEN '6'
                  LET l_sql4 = l_sql4," OR pmaa294='",l_prfb003,"' "
               WHEN '7'
                  LET l_sql4 = l_sql4," OR pmaa295='",l_prfb003,"' "
               WHEN '8'
                  LET l_sql4 = l_sql4," OR pmaa296='",l_prfb003,"' "
               WHEN '9'
                  LET l_sql4 = l_sql4," OR pmaa297='",l_prfb003,"' "
               WHEN '10'
                  LET l_sql4 = l_sql4," OR pmaa298='",l_prfb003,"' "
               WHEN '11'
                  LET l_sql4 = l_sql4," OR pmaa299='",l_prfb003,"' "
               WHEN '12'
                  LET l_sql4 = l_sql4," OR pmaa300='",l_prfb003,"' "
         
            END CASE
            LET l_prfb003=null
         END FOREACH
         LET l_sql3 = l_sql3," AND (",l_sql4,") "
         LET l_sql4="1<>1"
         LET l_prfb002=null
      END FOREACH
      LET l_sql2 = l_sql2," OR (",l_sql3,") "
      LET l_sql3="1=1"
      LET l_prfb002=null 
   END FOREACH
      
   LET l_sql = l_sql," AND ( ",l_sql2," )" 
   LET l_sql = l_sql,"  ORDER BY pmaa001 "   
   PREPARE l_sql_pre FROM l_sql
   DECLARE l_sql_cs CURSOR FOR l_sql_pre
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH l_sql_cs INTO g_pmaa_d[l_ac].pmaa001,g_pmaa_d[l_ac].pmaal004,g_pmaa_d[l_ac].pmaal003,g_pmaa_d[l_ac].pmaal005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
   END FOREACH
   LET g_error_show = 0
   
   CALL g_pmaa_d.deleteElement(g_pmaa_d.getLength())
 
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE l_sql_cs
#   END IF   
END FUNCTION
#insert prfb_t
PRIVATE FUNCTION aprt501_ins_prfb()
   DEFINE l_sql      STRING
   DEFINE l_success  LIKE type_t.num5
   LET l_success= TRUE
   IF g_prfa_m.prfa001='U' AND (NOT cl_null(g_prfa_m.prfa002)) THEN
      DELETE FROM prfb_t WHERE prfbent=g_enterprise AND prfbdocno=g_prfa_m.prfadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del prfb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success= FALSE
         RETURN l_success
      END IF
      LET l_sql=" INSERT INTO prfb_t (prfbent,prfbunit,prfbsite,prfbdocno,prfb001,prfb002,prfb003,prfbacti) ",
                " SELECT ",g_enterprise,",'",g_prfa_m.prfaunit,"','",g_prfa_m.prfasite,"','",g_prfa_m.prfadocno,"',",
                "         prfd002,prfd003,prfd004,prfdstus ",
                "   FROM prfd_t ",
                "  WHERE prfdent=",g_enterprise," AND prfd001='",g_prfa_m.prfa002,"' "
      PREPARE l_sql_prfc_pre FROM l_sql
      EXECUTE l_sql_prfc_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins prfb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success=false
         RETURN l_success
      END IF      
   END IF
   RETURN l_success
END FUNCTION

#init
PRIVATE FUNCTION aprt501_prfa001_init()
   IF cl_null(g_prfa_m.prfa002) THEN
      RETURN
   END IF
   INITIALIZE g_prfa_m.prfal002,g_prfa_m.prfal003 TO NULL
   INITIALIZE g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004,
              g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc
           TO NULL
   LET g_prfa_m.prfa004 = g_user
   LET g_prfa_m.prfaacti = 'Y'
   CALL aprt501_prfa004_ref()
   CALL aprt501_prfa004_display()
   DISPLAY BY NAME g_prfa_m.prfal002,g_prfa_m.prfal003,
                   g_prfa_m.prfa002,g_prfa_m.prfa003,g_prfa_m.prfaacti,g_prfa_m.prfa004,
                   g_prfa_m.prfa004_desc,g_prfa_m.prfa005,g_prfa_m.prfa005_desc
END FUNCTION

 
{</section>}
 
