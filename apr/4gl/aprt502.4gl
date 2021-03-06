#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt502.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-03-09 12:00:00), PR版次:0014(2016-09-05 19:43:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000188
#+ Filename...: aprt502
#+ Description: 產品價格組申請作業
#+ Creator....: 02296(2014-03-26 14:28:17)
#+ Modifier...: 06137 -SD/PR- 06189
 
{</section>}
 
{<section id="aprt502.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
# Modify......: NO.160318-00025#33   2016/04/13   By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
# Modify......: NO.160513-00002#1    2016/05/17   by 08172    单身一新增时单身二的显示
# Modify......: NO.160816-00068#11   2016/08/17   By 08209    調整transaction
# Modify......: NO.160818-00017#31   2016/08/30   By 08742    删除修改未重新判断状态码
#160905-00007#13  20160905 by geza           sql加上ent条件
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
PRIVATE type type_g_prfe_m        RECORD
       prfesite LIKE prfe_t.prfesite, 
   prfesite_desc LIKE type_t.chr80, 
   prfedocdt LIKE prfe_t.prfedocdt, 
   prfedocno LIKE prfe_t.prfedocno, 
   prfe001 LIKE prfe_t.prfe001, 
   prfe002 LIKE prfe_t.prfe002, 
   prfe003 LIKE prfe_t.prfe003, 
   prfeacti LIKE prfe_t.prfeacti, 
   prfel002 LIKE prfel_t.prfel002, 
   prfel003 LIKE prfel_t.prfel003, 
   prfe004 LIKE prfe_t.prfe004, 
   prfe004_desc LIKE type_t.chr80, 
   prfe005 LIKE prfe_t.prfe005, 
   prfe005_desc LIKE type_t.chr80, 
   prfeunit LIKE prfe_t.prfeunit, 
   prfestus LIKE prfe_t.prfestus, 
   prfeownid LIKE prfe_t.prfeownid, 
   prfeownid_desc LIKE type_t.chr80, 
   prfeowndp LIKE prfe_t.prfeowndp, 
   prfeowndp_desc LIKE type_t.chr80, 
   prfecrtid LIKE prfe_t.prfecrtid, 
   prfecrtid_desc LIKE type_t.chr80, 
   prfecrtdp LIKE prfe_t.prfecrtdp, 
   prfecrtdp_desc LIKE type_t.chr80, 
   prfecrtdt LIKE prfe_t.prfecrtdt, 
   prfemodid LIKE prfe_t.prfemodid, 
   prfemodid_desc LIKE type_t.chr80, 
   prfemoddt LIKE prfe_t.prfemoddt, 
   prfecnfid LIKE prfe_t.prfecnfid, 
   prfecnfid_desc LIKE type_t.chr80, 
   prfecnfdt LIKE prfe_t.prfecnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prff_d        RECORD
       prffacti LIKE prff_t.prffacti, 
   prff001 LIKE prff_t.prff001, 
   prff002 LIKE prff_t.prff002, 
   prff003 LIKE prff_t.prff003, 
   prff003_desc LIKE type_t.chr500, 
   prffsite LIKE prff_t.prffsite, 
   prffunit LIKE prff_t.prffunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prfesite LIKE prfe_t.prfesite,
   b_prfesite_desc LIKE type_t.chr80,
      b_prfedocdt LIKE prfe_t.prfedocdt,
      b_prfedocno LIKE prfe_t.prfedocno,
      b_prfe001 LIKE prfe_t.prfe001,
      b_prfe002 LIKE prfe_t.prfe002,
      b_prfe003 LIKE prfe_t.prfe003,
   b_prfedocno_desc LIKE type_t.chr80,
   b_prfel003_2 LIKE prfel_t.prfel003,
      b_prfeacti LIKE prfe_t.prfeacti,
      b_prfe004 LIKE prfe_t.prfe004,
   b_prfe004_desc LIKE type_t.chr80,
      b_prfe005 LIKE prfe_t.prfe005,
   b_prfe005_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_imaa_d       DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         imaa001      LIKE imaa_t.imaa001,
         imaal003     LIKE imaal_t.imaal003,
         imaal004     LIKE imaal_t.imaal004,
         imaa009      LIKE imaa_t.imaa009          
      END RECORD
DEFINE g_site_flag    LIKE type_t.num5 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prfe_m          type_g_prfe_m
DEFINE g_prfe_m_t        type_g_prfe_m
DEFINE g_prfe_m_o        type_g_prfe_m
DEFINE g_prfe_m_mask_o   type_g_prfe_m #轉換遮罩前資料
DEFINE g_prfe_m_mask_n   type_g_prfe_m #轉換遮罩後資料
 
   DEFINE g_prfedocno_t LIKE prfe_t.prfedocno
 
 
DEFINE g_prff_d          DYNAMIC ARRAY OF type_g_prff_d
DEFINE g_prff_d_t        type_g_prff_d
DEFINE g_prff_d_o        type_g_prff_d
DEFINE g_prff_d_mask_o   DYNAMIC ARRAY OF type_g_prff_d #轉換遮罩前資料
DEFINE g_prff_d_mask_n   DYNAMIC ARRAY OF type_g_prff_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      prfeldocno LIKE prfel_t.prfeldocno,
      prfel002 LIKE prfel_t.prfel002,
      prfel003 LIKE prfel_t.prfel003
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
 
{<section id="aprt502.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prfesite,'',prfedocdt,prfedocno,prfe001,prfe002,prfe003,prfeacti,'','', 
       prfe004,'',prfe005,'',prfeunit,prfestus,prfeownid,'',prfeowndp,'',prfecrtid,'',prfecrtdp,'',prfecrtdt, 
       prfemodid,'',prfemoddt,prfecnfid,'',prfecnfdt", 
                      " FROM prfe_t",
                      " WHERE prfeent= ? AND prfedocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt502_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prfesite,t0.prfedocdt,t0.prfedocno,t0.prfe001,t0.prfe002,t0.prfe003, 
       t0.prfeacti,t0.prfe004,t0.prfe005,t0.prfeunit,t0.prfestus,t0.prfeownid,t0.prfeowndp,t0.prfecrtid, 
       t0.prfecrtdp,t0.prfecrtdt,t0.prfemodid,t0.prfemoddt,t0.prfecnfid,t0.prfecnfdt,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM prfe_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.prfe004  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prfe005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prfeownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prfeowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.prfecrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.prfecrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prfemodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prfecnfid  ",
 
               " WHERE t0.prfeent = " ||g_enterprise|| " AND t0.prfedocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt502_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt502 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt502_init()   
 
      #進入選單 Menu (="N")
      CALL aprt502_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt502
      
   END IF 
   
   CLOSE aprt502_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt502.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt502_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
      CALL cl_set_combo_scc_part('prfestus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prfe001','32') 
   CALL cl_set_combo_scc('prff002','6517') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL aprt502_set_combo()
   CALL cl_set_combo_scc('b_prfe001','32')   
   #end add-point
   
   #初始化搜尋條件
   CALL aprt502_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt502.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt502_ui_dialog()
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
            CALL aprt502_insert()
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
         INITIALIZE g_prfe_m.* TO NULL
         CALL g_prff_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt502_init()
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
               
               CALL aprt502_fetch('') # reload data
               LET l_ac = 1
               CALL aprt502_ui_detailshow() #Setting the current row 
         
               CALL aprt502_idx_chk()
               #NEXT FIELD prff001
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prff_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt502_idx_chk()
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
               CALL aprt502_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_imaa_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               
            BEFORE DISPLAY
                              
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprt502_browser_fill("")
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
               CALL aprt502_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt502_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt502_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt502_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt502_set_act_visible()   
            CALL aprt502_set_act_no_visible()
            IF NOT (g_prfe_m.prfedocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prfeent = " ||g_enterprise|| " AND",
                                  " prfedocno = '", g_prfe_m.prfedocno, "' "
 
               #填到對應位置
               CALL aprt502_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prfe_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prff_t" 
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
               CALL aprt502_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prfe_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prff_t" 
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
                  CALL aprt502_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt502_fetch("F")
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
               CALL aprt502_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt502_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt502_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt502_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt502_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt502_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt502_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt502_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt502_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt502_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt502_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prff_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #ken---add---s 需求單號：150107-00009 項次：11
                  LET g_export_node[2] = base.typeInfo.create(g_imaa_d)
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
               NEXT FIELD prff001
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
               CALL aprt502_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt502_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt502_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt502_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt502_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt502_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt502_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt502_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt502_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt502_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prfe_m.prfedocdt)
 
 
 
         
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
 
{<section id="aprt502.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt502_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prfesite') RETURNING l_where 
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prfedocno ",
                      " FROM prfe_t ",
                      " ",
                      " LEFT JOIN prff_t ON prffent = prfeent AND prfedocno = prffdocno ", "  ",
                      #add-point:browser_fill段sql(prff_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN prfel_t ON prfelent = "||g_enterprise||" AND prfedocno = prfeldocno AND prfel001 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE prfeent = " ||g_enterprise|| " AND prffent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prfe_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prfedocno ",
                      " FROM prfe_t ", 
                      "  ",
                      "  LEFT JOIN prfel_t ON prfelent = "||g_enterprise||" AND prfedocno = prfeldocno AND prfel001 = '",g_dlang,"' ",
                      " WHERE prfeent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prfe_t")
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
      INITIALIZE g_prfe_m.* TO NULL
      CALL g_prff_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prfesite,t0.prfedocdt,t0.prfedocno,t0.prfe001,t0.prfe002,t0.prfe003,t0.prfeacti,t0.prfe004,t0.prfe005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prfestus,t0.prfesite,t0.prfedocdt,t0.prfedocno,t0.prfe001,t0.prfe002, 
          t0.prfe003,t0.prfeacti,t0.prfe004,t0.prfe005,t1.ooefl003 ,t2.prfel002 ,t3.ooag011 ,t4.ooefl003 ", 
 
                  " FROM prfe_t t0",
                  "  ",
                  "  LEFT JOIN prff_t ON prffent = prfeent AND prfedocno = prffdocno ", "  ", 
                  #add-point:browser_fill段sql(prff_t1) name="browser_fill.join.prff_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prfel_t t2 ON t2.prfelent="||g_enterprise||" AND t2.prfeldocno=t0.prfedocno AND t2.prfel001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prfe004  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prfe005 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prfeent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prfe_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prfestus,t0.prfesite,t0.prfedocdt,t0.prfedocno,t0.prfe001,t0.prfe002, 
          t0.prfe003,t0.prfeacti,t0.prfe004,t0.prfe005,t1.ooefl003 ,t2.prfel002 ,t3.ooag011 ,t4.ooefl003 ", 
 
                  " FROM prfe_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN prfel_t t2 ON t2.prfelent="||g_enterprise||" AND t2.prfeldocno=t0.prfedocno AND t2.prfel001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prfe004  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prfe005 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prfeent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prfe_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prfedocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prfe_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prfesite,g_browser[g_cnt].b_prfedocdt, 
          g_browser[g_cnt].b_prfedocno,g_browser[g_cnt].b_prfe001,g_browser[g_cnt].b_prfe002,g_browser[g_cnt].b_prfe003, 
          g_browser[g_cnt].b_prfeacti,g_browser[g_cnt].b_prfe004,g_browser[g_cnt].b_prfe005,g_browser[g_cnt].b_prfesite_desc, 
          g_browser[g_cnt].b_prfedocno_desc,g_browser[g_cnt].b_prfe004_desc,g_browser[g_cnt].b_prfe005_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_prfedocno
      CALL ap_ref_array2(g_ref_fields,"SELECT prfel003 FROM prfel_t WHERE prfelent='"||g_enterprise||"' AND prfeldocno=? AND prfel001='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prfel003_2 = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prfel003_2
         #end add-point
      
         #遮罩相關處理
         CALL aprt502_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prfedocno) THEN
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
 
{<section id="aprt502.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt502_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prfe_m.prfedocno = g_browser[g_current_idx].b_prfedocno   
 
   EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
       g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
       g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
       g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc,g_prfe_m.prfeownid_desc, 
       g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfemodid_desc, 
       g_prfe_m.prfecnfid_desc
   
   CALL aprt502_prfe_t_mask()
   CALL aprt502_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt502.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt502_ui_detailshow()
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
 
{<section id="aprt502.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt502_ui_browser_refresh()
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
      IF g_browser[l_i].b_prfedocno = g_prfe_m.prfedocno 
 
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
 
{<section id="aprt502.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt502_construct()
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
   INITIALIZE g_prfe_m.* TO NULL
   CALL g_prff_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON prfesite,prfedocdt,prfedocno,prfe001,prfe002,prfe003,prfeacti,prfel002, 
          prfel003,prfe004,prfe005,prfeunit,prfestus,prfeownid,prfeowndp,prfecrtid,prfecrtdp,prfecrtdt, 
          prfemodid,prfemoddt,prfecnfid,prfecnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prfecrtdt>>----
         AFTER FIELD prfecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prfemoddt>>----
         AFTER FIELD prfemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prfecnfdt>>----
         AFTER FIELD prfecnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prfepstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prfesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfesite
            #add-point:ON ACTION controlp INFIELD prfesite name="construct.c.prfesite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfesite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prfesite  #顯示到畫面上
            NEXT FIELD prfesite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfesite
            #add-point:BEFORE FIELD prfesite name="construct.b.prfesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfesite
            
            #add-point:AFTER FIELD prfesite name="construct.a.prfesite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfedocdt
            #add-point:BEFORE FIELD prfedocdt name="construct.b.prfedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfedocdt
            
            #add-point:AFTER FIELD prfedocdt name="construct.a.prfedocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfedocdt
            #add-point:ON ACTION controlp INFIELD prfedocdt name="construct.c.prfedocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfedocno
            #add-point:ON ACTION controlp INFIELD prfedocno name="construct.c.prfedocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prfedocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfedocno  #顯示到畫面上
            NEXT FIELD prfedocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfedocno
            #add-point:BEFORE FIELD prfedocno name="construct.b.prfedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfedocno
            
            #add-point:AFTER FIELD prfedocno name="construct.a.prfedocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe001
            #add-point:BEFORE FIELD prfe001 name="construct.b.prfe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe001
            
            #add-point:AFTER FIELD prfe001 name="construct.a.prfe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe001
            #add-point:ON ACTION controlp INFIELD prfe001 name="construct.c.prfe001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe002
            #add-point:ON ACTION controlp INFIELD prfe002 name="construct.c.prfe002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prfe002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfe002  #顯示到畫面上
            NEXT FIELD prfe002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe002
            #add-point:BEFORE FIELD prfe002 name="construct.b.prfe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe002
            
            #add-point:AFTER FIELD prfe002 name="construct.a.prfe002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe003
            #add-point:BEFORE FIELD prfe003 name="construct.b.prfe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe003
            
            #add-point:AFTER FIELD prfe003 name="construct.a.prfe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe003
            #add-point:ON ACTION controlp INFIELD prfe003 name="construct.c.prfe003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfeacti
            #add-point:BEFORE FIELD prfeacti name="construct.b.prfeacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfeacti
            
            #add-point:AFTER FIELD prfeacti name="construct.a.prfeacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfeacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfeacti
            #add-point:ON ACTION controlp INFIELD prfeacti name="construct.c.prfeacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfel002
            #add-point:BEFORE FIELD prfel002 name="construct.b.prfel002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfel002
            
            #add-point:AFTER FIELD prfel002 name="construct.a.prfel002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfel002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfel002
            #add-point:ON ACTION controlp INFIELD prfel002 name="construct.c.prfel002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfel003
            #add-point:BEFORE FIELD prfel003 name="construct.b.prfel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfel003
            
            #add-point:AFTER FIELD prfel003 name="construct.a.prfel003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfel003
            #add-point:ON ACTION controlp INFIELD prfel003 name="construct.c.prfel003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe004
            #add-point:ON ACTION controlp INFIELD prfe004 name="construct.c.prfe004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfe004  #顯示到畫面上
            NEXT FIELD prfe004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe004
            #add-point:BEFORE FIELD prfe004 name="construct.b.prfe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe004
            
            #add-point:AFTER FIELD prfe004 name="construct.a.prfe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfe005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe005
            #add-point:ON ACTION controlp INFIELD prfe005 name="construct.c.prfe005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfe005  #顯示到畫面上
            NEXT FIELD prfe005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe005
            #add-point:BEFORE FIELD prfe005 name="construct.b.prfe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe005
            
            #add-point:AFTER FIELD prfe005 name="construct.a.prfe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfeunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfeunit
            #add-point:ON ACTION controlp INFIELD prfeunit name="construct.c.prfeunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfeunit  #顯示到畫面上
            NEXT FIELD prfeunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfeunit
            #add-point:BEFORE FIELD prfeunit name="construct.b.prfeunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfeunit
            
            #add-point:AFTER FIELD prfeunit name="construct.a.prfeunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfestus
            #add-point:BEFORE FIELD prfestus name="construct.b.prfestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfestus
            
            #add-point:AFTER FIELD prfestus name="construct.a.prfestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfestus
            #add-point:ON ACTION controlp INFIELD prfestus name="construct.c.prfestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfeownid
            #add-point:ON ACTION controlp INFIELD prfeownid name="construct.c.prfeownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfeownid  #顯示到畫面上
            NEXT FIELD prfeownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfeownid
            #add-point:BEFORE FIELD prfeownid name="construct.b.prfeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfeownid
            
            #add-point:AFTER FIELD prfeownid name="construct.a.prfeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfeowndp
            #add-point:ON ACTION controlp INFIELD prfeowndp name="construct.c.prfeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfeowndp  #顯示到畫面上
            NEXT FIELD prfeowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfeowndp
            #add-point:BEFORE FIELD prfeowndp name="construct.b.prfeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfeowndp
            
            #add-point:AFTER FIELD prfeowndp name="construct.a.prfeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfecrtid
            #add-point:ON ACTION controlp INFIELD prfecrtid name="construct.c.prfecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfecrtid  #顯示到畫面上
            NEXT FIELD prfecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfecrtid
            #add-point:BEFORE FIELD prfecrtid name="construct.b.prfecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfecrtid
            
            #add-point:AFTER FIELD prfecrtid name="construct.a.prfecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfecrtdp
            #add-point:ON ACTION controlp INFIELD prfecrtdp name="construct.c.prfecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfecrtdp  #顯示到畫面上
            NEXT FIELD prfecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfecrtdp
            #add-point:BEFORE FIELD prfecrtdp name="construct.b.prfecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfecrtdp
            
            #add-point:AFTER FIELD prfecrtdp name="construct.a.prfecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfecrtdt
            #add-point:BEFORE FIELD prfecrtdt name="construct.b.prfecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfemodid
            #add-point:ON ACTION controlp INFIELD prfemodid name="construct.c.prfemodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfemodid  #顯示到畫面上
            NEXT FIELD prfemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfemodid
            #add-point:BEFORE FIELD prfemodid name="construct.b.prfemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfemodid
            
            #add-point:AFTER FIELD prfemodid name="construct.a.prfemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfemoddt
            #add-point:BEFORE FIELD prfemoddt name="construct.b.prfemoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfecnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfecnfid
            #add-point:ON ACTION controlp INFIELD prfecnfid name="construct.c.prfecnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfecnfid  #顯示到畫面上
            NEXT FIELD prfecnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfecnfid
            #add-point:BEFORE FIELD prfecnfid name="construct.b.prfecnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfecnfid
            
            #add-point:AFTER FIELD prfecnfid name="construct.a.prfecnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfecnfdt
            #add-point:BEFORE FIELD prfecnfdt name="construct.b.prfecnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prffacti,prff001,prff002,prff003,prffsite,prffunit
           FROM s_detail1[1].prffacti,s_detail1[1].prff001,s_detail1[1].prff002,s_detail1[1].prff003, 
               s_detail1[1].prffsite,s_detail1[1].prffunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prffacti
            #add-point:BEFORE FIELD prffacti name="construct.b.page1.prffacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prffacti
            
            #add-point:AFTER FIELD prffacti name="construct.a.page1.prffacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prffacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prffacti
            #add-point:ON ACTION controlp INFIELD prffacti name="construct.c.page1.prffacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prff001
            #add-point:BEFORE FIELD prff001 name="construct.b.page1.prff001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prff001
            
            #add-point:AFTER FIELD prff001 name="construct.a.page1.prff001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prff001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prff001
            #add-point:ON ACTION controlp INFIELD prff001 name="construct.c.page1.prff001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prff002
            #add-point:BEFORE FIELD prff002 name="construct.b.page1.prff002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prff002
            
            #add-point:AFTER FIELD prff002 name="construct.a.page1.prff002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prff002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prff002
            #add-point:ON ACTION controlp INFIELD prff002 name="construct.c.page1.prff002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prff003
            #add-point:BEFORE FIELD prff003 name="construct.b.page1.prff003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prff003
            
            #add-point:AFTER FIELD prff003 name="construct.a.page1.prff003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prff003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prff003
            #add-point:ON ACTION controlp INFIELD prff003 name="construct.c.page1.prff003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prff003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prff003  #顯示到畫面上
            NEXT FIELD prff003  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prffsite
            #add-point:BEFORE FIELD prffsite name="construct.b.page1.prffsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prffsite
            
            #add-point:AFTER FIELD prffsite name="construct.a.page1.prffsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prffsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prffsite
            #add-point:ON ACTION controlp INFIELD prffsite name="construct.c.page1.prffsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prffunit
            #add-point:BEFORE FIELD prffunit name="construct.b.page1.prffunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prffunit
            
            #add-point:AFTER FIELD prffunit name="construct.a.page1.prffunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prffunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prffunit
            #add-point:ON ACTION controlp INFIELD prffunit name="construct.c.page1.prffunit"
            
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
                  WHEN la_wc[li_idx].tableid = "prfe_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prff_t" 
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
 
{<section id="aprt502.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt502_filter()
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
      CONSTRUCT g_wc_filter ON prfesite,prfedocdt,prfedocno,prfe001,prfe002,prfe003,prfeacti,prfe004, 
          prfe005
                          FROM s_browse[1].b_prfesite,s_browse[1].b_prfedocdt,s_browse[1].b_prfedocno, 
                              s_browse[1].b_prfe001,s_browse[1].b_prfe002,s_browse[1].b_prfe003,s_browse[1].b_prfeacti, 
                              s_browse[1].b_prfe004,s_browse[1].b_prfe005
 
         BEFORE CONSTRUCT
               DISPLAY aprt502_filter_parser('prfesite') TO s_browse[1].b_prfesite
            DISPLAY aprt502_filter_parser('prfedocdt') TO s_browse[1].b_prfedocdt
            DISPLAY aprt502_filter_parser('prfedocno') TO s_browse[1].b_prfedocno
            DISPLAY aprt502_filter_parser('prfe001') TO s_browse[1].b_prfe001
            DISPLAY aprt502_filter_parser('prfe002') TO s_browse[1].b_prfe002
            DISPLAY aprt502_filter_parser('prfe003') TO s_browse[1].b_prfe003
            DISPLAY aprt502_filter_parser('prfeacti') TO s_browse[1].b_prfeacti
            DISPLAY aprt502_filter_parser('prfe004') TO s_browse[1].b_prfe004
            DISPLAY aprt502_filter_parser('prfe005') TO s_browse[1].b_prfe005
      
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
 
      CALL aprt502_filter_show('prfesite')
   CALL aprt502_filter_show('prfedocdt')
   CALL aprt502_filter_show('prfedocno')
   CALL aprt502_filter_show('prfe001')
   CALL aprt502_filter_show('prfe002')
   CALL aprt502_filter_show('prfe003')
   CALL aprt502_filter_show('prfeacti')
   CALL aprt502_filter_show('prfe004')
   CALL aprt502_filter_show('prfe005')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt502_filter_parser(ps_field)
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
 
{<section id="aprt502.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt502_filter_show(ps_field)
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
   LET ls_condition = aprt502_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt502_query()
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
   CALL g_prff_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt502_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt502_browser_fill("")
      CALL aprt502_fetch("")
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
      CALL aprt502_filter_show('prfesite')
   CALL aprt502_filter_show('prfedocdt')
   CALL aprt502_filter_show('prfedocno')
   CALL aprt502_filter_show('prfe001')
   CALL aprt502_filter_show('prfe002')
   CALL aprt502_filter_show('prfe003')
   CALL aprt502_filter_show('prfeacti')
   CALL aprt502_filter_show('prfe004')
   CALL aprt502_filter_show('prfe005')
   CALL aprt502_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt502_fetch("F") 
      #顯示單身筆數
      CALL aprt502_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt502_fetch(p_flag)
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
   
   LET g_prfe_m.prfedocno = g_browser[g_current_idx].b_prfedocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
       g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
       g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
       g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc,g_prfe_m.prfeownid_desc, 
       g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfemodid_desc, 
       g_prfe_m.prfecnfid_desc
   
   #遮罩相關處理
   LET g_prfe_m_mask_o.* =  g_prfe_m.*
   CALL aprt502_prfe_t_mask()
   LET g_prfe_m_mask_n.* =  g_prfe_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt502_set_act_visible()   
   CALL aprt502_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_prfe_m.prfestus <> "N" THEN
#      CALL cl_set_act_visible("delete,modify", FALSE)
#   ELSE
#      CALL cl_set_act_visible("delete,modify", true)    
#   END IF
   IF g_prfe_m.prfestus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prfe_m_t.* = g_prfe_m.*
   LET g_prfe_m_o.* = g_prfe_m.*
   
   LET g_data_owner = g_prfe_m.prfeownid      
   LET g_data_dept  = g_prfe_m.prfeowndp
   
   #重新顯示   
   CALL aprt502_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt502_insert()
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
   CALL g_prff_d.clear()   
 
 
   INITIALIZE g_prfe_m.* TO NULL             #DEFAULT 設定
   
   LET g_prfedocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prfe_m.prfeownid = g_user
      LET g_prfe_m.prfeowndp = g_dept
      LET g_prfe_m.prfecrtid = g_user
      LET g_prfe_m.prfecrtdp = g_dept 
      LET g_prfe_m.prfecrtdt = cl_get_current()
      LET g_prfe_m.prfemodid = g_user
      LET g_prfe_m.prfemoddt = cl_get_current()
      LET g_prfe_m.prfestus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prfe_m.prfe001 = "I"
      LET g_prfe_m.prfeacti = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prfe_m.prfestus = "N"
      CALL g_imaa_d.clear()
#      LET g_prfe_m.prfesite = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prfesite',g_prfe_m.prfesite)
         RETURNING l_insert,g_prfe_m.prfesite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prfe_m.prfeunit = g_prfe_m.prfesite
      CALL aprt502_prfesite_ref()
      LET g_prfe_m.prfedocdt = g_today
      LET g_prfe_m.prfe004 = g_user
      CALL aprt502_prfe004_ref()
      CALL aprt502_prfe004_display()
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prfe_m.prfesite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prfe_m.prfedocno = r_doctype
      #dongsz--add--end---
      
      LET g_prfe_m_t.* = g_prfe_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prfe_m_t.* = g_prfe_m.*
      LET g_prfe_m_o.* = g_prfe_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfe_m.prfestus 
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
 
 
 
    
      CALL aprt502_input("a")
      
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
         INITIALIZE g_prfe_m.* TO NULL
         INITIALIZE g_prff_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt502_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prff_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt502_set_act_visible()   
   CALL aprt502_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prfedocno_t = g_prfe_m.prfedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prfeent = " ||g_enterprise|| " AND",
                      " prfedocno = '", g_prfe_m.prfedocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt502_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt502_cl
   
   CALL aprt502_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
       g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
       g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
       g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc,g_prfe_m.prfeownid_desc, 
       g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfemodid_desc, 
       g_prfe_m.prfecnfid_desc
   
   
   #遮罩相關處理
   LET g_prfe_m_mask_o.* =  g_prfe_m.*
   CALL aprt502_prfe_t_mask()
   LET g_prfe_m_mask_n.* =  g_prfe_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001, 
       g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003,g_prfe_m.prfe004, 
       g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc,g_prfe_m.prfeunit,g_prfe_m.prfestus, 
       g_prfe_m.prfeownid,g_prfe_m.prfeownid_desc,g_prfe_m.prfeowndp,g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid, 
       g_prfe_m.prfemodid_desc,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid,g_prfe_m.prfecnfid_desc,g_prfe_m.prfecnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prfe_m.prfeownid      
   LET g_data_dept  = g_prfe_m.prfeowndp
   
   #功能已完成,通報訊息中心
   CALL aprt502_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt502_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_prfe_m.prfestus MATCHES "[DR]" THEN 
      LET g_prfe_m.prfestus = "N"
   END IF
   IF g_prfe_m.prfestus<>'N' THEN
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prfe_m_t.* = g_prfe_m.*
   LET g_prfe_m_o.* = g_prfe_m.*
   
   IF g_prfe_m.prfedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prfedocno_t = g_prfe_m.prfedocno
 
   CALL s_transaction_begin()
   
   OPEN aprt502_cl USING g_enterprise,g_prfe_m.prfedocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt502_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt502_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
       g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
       g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
       g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc,g_prfe_m.prfeownid_desc, 
       g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfemodid_desc, 
       g_prfe_m.prfecnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt502_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prfe_m_mask_o.* =  g_prfe_m.*
   CALL aprt502_prfe_t_mask()
   LET g_prfe_m_mask_n.* =  g_prfe_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aprt502_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_prfedocno_t = g_prfe_m.prfedocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prfe_m.prfemodid = g_user 
LET g_prfe_m.prfemoddt = cl_get_current()
LET g_prfe_m.prfemodid_desc = cl_get_username(g_prfe_m.prfemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_prfe_m.prfestus MATCHES "[DR]" THEN 
         LET g_prfe_m.prfestus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt502_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prfe_t SET (prfemodid,prfemoddt) = (g_prfe_m.prfemodid,g_prfe_m.prfemoddt)
          WHERE prfeent = g_enterprise AND prfedocno = g_prfedocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prfe_m.* = g_prfe_m_t.*
            CALL aprt502_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prfe_m.prfedocno != g_prfe_m_t.prfedocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prff_t SET prffdocno = g_prfe_m.prfedocno
 
          WHERE prffent = g_enterprise AND prffdocno = g_prfe_m_t.prfedocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prff_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prff_t:",SQLERRMESSAGE 
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
   CALL aprt502_set_act_visible()   
   CALL aprt502_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prfeent = " ||g_enterprise|| " AND",
                      " prfedocno = '", g_prfe_m.prfedocno, "' "
 
   #填到對應位置
   CALL aprt502_browser_fill("")
 
   CLOSE aprt502_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt502_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt502.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt502_input(p_cmd)
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
   DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001, 
       g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003,g_prfe_m.prfe004, 
       g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc,g_prfe_m.prfeunit,g_prfe_m.prfestus, 
       g_prfe_m.prfeownid,g_prfe_m.prfeownid_desc,g_prfe_m.prfeowndp,g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid, 
       g_prfe_m.prfemodid_desc,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid,g_prfe_m.prfecnfid_desc,g_prfe_m.prfecnfdt 
 
   
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
   LET g_forupd_sql = "SELECT prffacti,prff001,prff002,prff003,prffsite,prffunit FROM prff_t WHERE prffent=?  
       AND prffdocno=? AND prff001=? AND prff002=? AND prff003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt502_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt502_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt502_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002, 
       g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003,g_prfe_m.prfe004,g_prfe_m.prfe005, 
       g_prfe_m.prfeunit,g_prfe_m.prfestus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_prfe_m.prfesite
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt502.input.head" >}
      #單頭段
      INPUT BY NAME g_prfe_m.prfesite,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002, 
          g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003,g_prfe_m.prfe004,g_prfe_m.prfe005, 
          g_prfe_m.prfeunit,g_prfe_m.prfestus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
            IF NOT cl_null(g_prfe_m.prfedocno) THEN
#               CALL n_prfal(g_prfe_m.prfedocno)
               CALL n_prfel(g_prfe_m.prfedocno)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prfe_m.prfedocno
               #CALL ap_ref_array2(g_ref_fields," SELECT prfel002,prfel003 FROM prfel_t WHERE prfeldocno = ? AND prfel001 = '"||g_lang||"'","") RETURNING g_rtn_fields #mark by geza 20160905 #160905-00007#13
               CALL ap_ref_array2(g_ref_fields," SELECT prfel002,prfel003 FROM prfel_t WHERE prfelent = '"||g_enterprise||"' AND prfeldocno = ? AND prfel001 = '"||g_dlang||"'","") RETURNING g_rtn_fields #add by geza 20160905 #160905-00007#13
               LET g_prfe_m.prfel002 = g_rtn_fields[1]
               LET g_prfe_m.prfel003 = g_rtn_fields[2]
               DISPLAY BY NAME g_prfe_m.prfel002
               DISPLAY BY NAME g_prfe_m.prfel003
            END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt502_cl USING g_enterprise,g_prfe_m.prfedocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt502_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt502_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.prfeldocno = g_prfe_m.prfedocno
LET g_master_multi_table_t.prfel002 = g_prfe_m.prfel002
LET g_master_multi_table_t.prfel003 = g_prfe_m.prfel003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prfeldocno = ''
LET g_master_multi_table_t.prfel002 = ''
LET g_master_multi_table_t.prfel003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt502_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aprt502_set_entry(p_cmd)
            CALL aprt502_set_no_entry(p_cmd)
            #end add-point
            CALL aprt502_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfesite
            
            #add-point:AFTER FIELD prfesite name="input.a.prfesite"
            IF NOT cl_null(g_prfe_m.prfesite) THEN
               CALL s_aooi500_chk(g_prog,'prfesite',g_prfe_m.prfesite,g_prfe_m.prfesite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prfe_m.prfesite = g_prfe_m_t.prfesite
                  CALL aprt502_prfesite_ref()
                  DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc
                  NEXT FIELD CURRENT
               END IF
            #sakura---add--str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               LET g_prfe_m.prfesite = g_prfe_m_t.prfesite
               CALL aprt502_prfesite_ref()
               DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc
               NEXT FIELD CURRENT               
            #sakura---add--end		               
            END IF
            LET g_site_flag = TRUE
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfe_m.prfesite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfe_m.prfesite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfe_m.prfesite_desc
            CALL aprt502_set_entry(p_cmd)
            CALL aprt502_set_no_entry(p_cmd)                        


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfesite
            #add-point:BEFORE FIELD prfesite name="input.b.prfesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfesite
            #add-point:ON CHANGE prfesite name="input.g.prfesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfedocdt
            #add-point:BEFORE FIELD prfedocdt name="input.b.prfedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfedocdt
            
            #add-point:AFTER FIELD prfedocdt name="input.a.prfedocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfedocdt
            #add-point:ON CHANGE prfedocdt name="input.g.prfedocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfedocno
            #add-point:BEFORE FIELD prfedocno name="input.b.prfedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfedocno
            
            #add-point:AFTER FIELD prfedocno name="input.a.prfedocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_prfe_m.prfedocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfedocno != g_prfedocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfe_t WHERE "||"prfeent = '" ||g_enterprise|| "' AND "||"prfedocno = '"||g_prfe_m.prfedocno ||"'",'std-00004',0) THEN 
                     LET g_prfe_m.prfedocno = g_prfe_m_t.prfedocno
                     NEXT FIELD CURRENT
                  END IF
                 #CALL s_aooi200_chk_slip(g_site,g_ooef004,g_prfe_m.prfedocno,g_prog) RETURNING l_success #sakura mark
                  CALL s_aooi200_chk_slip(g_prfe_m.prfeunit,g_ooef004,g_prfe_m.prfedocno,g_prog) RETURNING l_success #sakura add
                  IF NOT l_success THEN
                     LET  g_prfe_m.prfedocno = g_prfe_m_t.prfedocno 
                     NEXT FIELD prfedocno
                  END IF
                  IF NOT cl_null(g_prfe_m.prfedocno) THEN 
                    #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
               
                    #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_ooef004
                     LET g_chkparam.arg2 = g_prfe_m.prfedocno
                  
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooba002") THEN

                     ELSE
                        #檢查失敗時後續處理
                        LET  g_prfe_m.prfedocno = g_prfe_m_t.prfedocno 
                        NEXT FIELD prfedocno
                     END IF
           
                  END IF 
                  
                  #ken_mark
                  #CALL s_aooi200_gen_docno(g_prfe_m.prfesite,g_prfe_m.prfedocno,g_prfe_m.prfedocdt,g_prog)
                  #   RETURNING  g_success,g_prfe_m.prfedocno
                  #IF g_success<>'1' THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = "amm-00001"
                  #   LET g_errparam.extend = g_prfe_m.prfedocno
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   NEXT FIELD prfedocno
                  #ELSE
                  #   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfe_t WHERE "||"prfeent = '" ||g_enterprise|| "' AND "||"prfedocno = '"||g_prfe_m.prfedocno ||"'",'std-00004',1) THEN
                  #      LET g_prfe_m.prfedocno = g_prfe_m_t.prfedocno 
                  #      NEXT FIELD prfedocno
                  #   END IF
                  #
                  #END IF
                  #LET g_prfe_m_t.prfedocno = g_prfe_m.prfedocno
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfedocno
            #add-point:ON CHANGE prfedocno name="input.g.prfedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe001
            #add-point:BEFORE FIELD prfe001 name="input.b.prfe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe001
            
            #add-point:AFTER FIELD prfe001 name="input.a.prfe001"
            IF  NOT cl_null(g_prfe_m.prfe001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfe001 != g_prfe_m_t.prfe001 OR g_prfe_m_t.prfe001 IS NULL )) THEN
                  CALL aprt502_prfe001_init()
               END IF
            END IF
            CALL aprt502_set_entry(p_cmd)
            CALL aprt502_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfe001
            #add-point:ON CHANGE prfe001 name="input.g.prfe001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe002
            #add-point:BEFORE FIELD prfe002 name="input.b.prfe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe002
            
            #add-point:AFTER FIELD prfe002 name="input.a.prfe002"
            IF  NOT cl_null(g_prfe_m.prfe002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfe002 != g_prfe_m_t.prfe002 OR g_prfe_m_t.prfe002 IS NULL )) THEN
                  CALL aprt502_prfe002() RETURNING l_success,g_errno
                  IF l_success= FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prfe_m.prfe002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfe_m.prfe002 = g_prfe_m_t.prfe002
                     CALL aprt502_prfe002_ref()
                     NEXT FIELD prfe002
                  END IF
               END IF
            END IF
            CALL aprt502_prfe002_ref()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfe002
            #add-point:ON CHANGE prfe002 name="input.g.prfe002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfe_m.prfe003,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfe003
            END IF 
 
 
 
            #add-point:AFTER FIELD prfe003 name="input.a.prfe003"
            IF NOT cl_null(g_prfe_m.prfe003) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe003
            #add-point:BEFORE FIELD prfe003 name="input.b.prfe003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfe003
            #add-point:ON CHANGE prfe003 name="input.g.prfe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfeacti
            #add-point:BEFORE FIELD prfeacti name="input.b.prfeacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfeacti
            
            #add-point:AFTER FIELD prfeacti name="input.a.prfeacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfeacti
            #add-point:ON CHANGE prfeacti name="input.g.prfeacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfel002
            #add-point:BEFORE FIELD prfel002 name="input.b.prfel002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfel002
            
            #add-point:AFTER FIELD prfel002 name="input.a.prfel002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfel002
            #add-point:ON CHANGE prfel002 name="input.g.prfel002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfel003
            #add-point:BEFORE FIELD prfel003 name="input.b.prfel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfel003
            
            #add-point:AFTER FIELD prfel003 name="input.a.prfel003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfel003
            #add-point:ON CHANGE prfel003 name="input.g.prfel003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe004
            
            #add-point:AFTER FIELD prfe004 name="input.a.prfe004"
            LET g_prfe_m.prfe004_desc = NULL
            DISPLAY BY NAME g_prfe_m.prfe004_desc
            IF NOT cl_null(g_prfe_m.prfe004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfe004 != g_prfe_m_t.prfe004 OR g_prfe_m_t.prfe004 IS null)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfe_m.prfe004
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfe_m.prfe004 = g_prfe_m_t.prfe004
                     CALL aprt502_prfe004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt502_prfe004_display()

               END IF 
            END IF   
            CALL aprt502_prfe004_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe004
            #add-point:BEFORE FIELD prfe004 name="input.b.prfe004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfe004
            #add-point:ON CHANGE prfe004 name="input.g.prfe004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfe005
            
            #add-point:AFTER FIELD prfe005 name="input.a.prfe005"
            LET g_prfe_m.prfe005_desc = NULL
            DISPLAY BY NAME g_prfe_m.prfe005_desc
            IF NOT cl_null(g_prfe_m.prfe005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfe005 != g_prfe_m_t.prfe005 OR g_prfe_m_t.prfe005 IS null)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfe_m.prfe005 
                  LET g_chkparam.arg2 = g_today
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001_3") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfe_m.prfe005 = g_prfe_m_t.prfe005
                     CALL aprt502_prfe005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt502_prfe005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfe005
            #add-point:BEFORE FIELD prfe005 name="input.b.prfe005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfe005
            #add-point:ON CHANGE prfe005 name="input.g.prfe005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfeunit
            #add-point:BEFORE FIELD prfeunit name="input.b.prfeunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfeunit
            
            #add-point:AFTER FIELD prfeunit name="input.a.prfeunit"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfeunit
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfeunit_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfeunit_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfeunit
            #add-point:ON CHANGE prfeunit name="input.g.prfeunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfestus
            #add-point:BEFORE FIELD prfestus name="input.b.prfestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfestus
            
            #add-point:AFTER FIELD prfestus name="input.a.prfestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfestus
            #add-point:ON CHANGE prfestus name="input.g.prfestus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prfesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfesite
            #add-point:ON ACTION controlp INFIELD prfesite name="input.c.prfesite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfe_m.prfesite             #給予default值
            LET g_qryparam.default2 = "" #g_prfe_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfesite',g_prfe_m.prfesite,'i') #150308-00001#1  By Ken add 'c' 150309

            CALL q_ooef001_24()  
            
#            CALL q_ooef001()                                #呼叫開窗

            LET g_prfe_m.prfesite = g_qryparam.return1              
            #LET g_prfe_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_prfe_m.prfesite TO prfesite              #
            #DISPLAY g_prfe_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL aprt502_prfesite_ref()
            NEXT FIELD prfesite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfedocdt
            #add-point:ON ACTION controlp INFIELD prfedocdt name="input.c.prfedocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfedocno
            #add-point:ON ACTION controlp INFIELD prfedocno name="input.c.prfedocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfe_m.prfedocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004#
            #LET g_qryparam.arg2 = "aprt502" #   #160705-00042#4 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#4 160711 by sakura add
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prfe_m.prfedocno = g_qryparam.return1              

            DISPLAY g_prfe_m.prfedocno TO prfedocno              #

            NEXT FIELD prfedocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe001
            #add-point:ON ACTION controlp INFIELD prfe001 name="input.c.prfe001"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe002
            #add-point:ON ACTION controlp INFIELD prfe002 name="input.c.prfe002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfe_m.prfe002             #給予default值

            #給予arg
            IF g_prfe_m.prfe001='U' THEN
               CALL q_prfg001()                                #呼叫開窗
            END IF
            LET g_prfe_m.prfe002 = g_qryparam.return1              

            DISPLAY g_prfe_m.prfe002 TO prfe002              #

            NEXT FIELD prfe002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe003
            #add-point:ON ACTION controlp INFIELD prfe003 name="input.c.prfe003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfeacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfeacti
            #add-point:ON ACTION controlp INFIELD prfeacti name="input.c.prfeacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfel002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfel002
            #add-point:ON ACTION controlp INFIELD prfel002 name="input.c.prfel002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfel003
            #add-point:ON ACTION controlp INFIELD prfel003 name="input.c.prfel003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe004
            #add-point:ON ACTION controlp INFIELD prfe004 name="input.c.prfe004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfe_m.prfe004             #給予default值

            #給予arg
            
            CALL q_ooag001()                                #呼叫開窗

            LET g_prfe_m.prfe004 = g_qryparam.return1              

            DISPLAY g_prfe_m.prfe004 TO prfe004              #
            CALL aprt502_prfe004_ref()
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfe004 != g_prfe_m_t.prfe004 OR g_prfe_m_t.prfe004 IS null)) THEN
               CALL aprt502_prfe004_display()
            END IF            
            NEXT FIELD prfe004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfe005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfe005
            #add-point:ON ACTION controlp INFIELD prfe005 name="input.c.prfe005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfe_m.prfe005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_prfe_m.prfe005 = g_qryparam.return1              

            DISPLAY g_prfe_m.prfe005 TO prfe005              #
            CALL aprt502_prfe005_ref()
            NEXT FIELD prfe005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfeunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfeunit
            #add-point:ON ACTION controlp INFIELD prfeunit name="input.c.prfeunit"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfe_m.prfeunit             #給予default值
            LET g_qryparam.default2 = "" #g_prfe_m.ooefl003 #說明(簡稱)
            #給予arg
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_prfe_m.prfeunit = g_qryparam.return1              
            #LET g_prfe_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_prfe_m.prfeunit TO prfeunit              #
            #DISPLAY g_prfe_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD prfeunit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfestus
            #add-point:ON ACTION controlp INFIELD prfestus name="input.c.prfestus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prfe_m.prfedocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
#               IF NOT cl_null(g_prfe_m.prfedocno) THEN 
                  
                  #ken---add---s 需求單號：141208-00001 項次：27
                  CALL s_aooi200_gen_docno(g_prfe_m.prfeunit,g_prfe_m.prfedocno,g_prfe_m.prfedocdt,g_prog)
                     RETURNING  g_success,g_prfe_m.prfedocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00001"
                     LET g_errparam.extend = g_prfe_m.prfedocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD prfedocno
                  END IF
                  DISPLAY BY NAME g_prfe_m.prfedocno
                  
                  LET g_prfe_m.prfeunit = g_prfe_m.prfesite 
                  #ken---add---e
                  
                  #ELSE
                  #   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfe_t WHERE "||"prfeent = '" ||g_enterprise|| "' AND "||"prfedocno = '"||g_prfe_m.prfedocno ||"'",'std-00004',1) THEN
                  #      LET g_prfe_m.prfedocno = g_prfedocno_t
                  #      NEXT FIELD prfedocno
                  #   END IF
                  #
                  #END IF
                  #LET g_prfe_m_t.prfedocno = g_prfe_m.prfedocno
                     
#               END IF
               #end add-point
               
               INSERT INTO prfe_t (prfeent,prfesite,prfedocdt,prfedocno,prfe001,prfe002,prfe003,prfeacti, 
                   prfe004,prfe005,prfeunit,prfestus,prfeownid,prfeowndp,prfecrtid,prfecrtdp,prfecrtdt, 
                   prfemodid,prfemoddt,prfecnfid,prfecnfdt)
               VALUES (g_enterprise,g_prfe_m.prfesite,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001, 
                   g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004,g_prfe_m.prfe005, 
                   g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
                   g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
                   g_prfe_m.prfecnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prfe_m:",SQLERRMESSAGE 
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
         IF g_prfe_m.prfedocno = g_master_multi_table_t.prfeldocno AND
         g_prfe_m.prfel002 = g_master_multi_table_t.prfel002 AND 
         g_prfe_m.prfel003 = g_master_multi_table_t.prfel003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prfelent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prfe_m.prfedocno
            LET l_field_keys[02] = 'prfeldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prfeldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prfel001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prfe_m.prfel002
            LET l_fields[01] = 'prfel002'
            LET l_vars[02] = g_prfe_m.prfel003
            LET l_fields[02] = 'prfel003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prfel_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfe_m.prfe002 != g_prfe_m_t.prfe002 OR g_prfe_m_t.prfe002 IS NULL )) THEN
                  CALL aprt502_ins_prff() RETURNING l_success
                  IF l_success=false THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprt502_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt502_b_fill()
                  CALL aprt502_b_fill2('0')
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
               CALL aprt502_prfe_t_mask_restore('restore_mask_o')
               
               UPDATE prfe_t SET (prfesite,prfedocdt,prfedocno,prfe001,prfe002,prfe003,prfeacti,prfe004, 
                   prfe005,prfeunit,prfestus,prfeownid,prfeowndp,prfecrtid,prfecrtdp,prfecrtdt,prfemodid, 
                   prfemoddt,prfecnfid,prfecnfdt) = (g_prfe_m.prfesite,g_prfe_m.prfedocdt,g_prfe_m.prfedocno, 
                   g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
                   g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp, 
                   g_prfe_m.prfecrtid,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt, 
                   g_prfe_m.prfecnfid,g_prfe_m.prfecnfdt)
                WHERE prfeent = g_enterprise AND prfedocno = g_prfedocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prfe_t:",SQLERRMESSAGE 
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
         IF g_prfe_m.prfedocno = g_master_multi_table_t.prfeldocno AND
         g_prfe_m.prfel002 = g_master_multi_table_t.prfel002 AND 
         g_prfe_m.prfel003 = g_master_multi_table_t.prfel003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prfelent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prfe_m.prfedocno
            LET l_field_keys[02] = 'prfeldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prfeldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'prfel001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prfe_m.prfel002
            LET l_fields[01] = 'prfel002'
            LET l_vars[02] = g_prfe_m.prfel003
            LET l_fields[02] = 'prfel003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prfel_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aprt502_prfe_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prfe_m_t)
               LET g_log2 = util.JSON.stringify(g_prfe_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prfedocno_t = g_prfe_m.prfedocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt502.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prff_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prff_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt502_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prff_d.getLength()
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
            OPEN aprt502_cl USING g_enterprise,g_prfe_m.prfedocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt502_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt502_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prff_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prff_d[l_ac].prff001 IS NOT NULL
               AND g_prff_d[l_ac].prff002 IS NOT NULL
               AND g_prff_d[l_ac].prff003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prff_d_t.* = g_prff_d[l_ac].*  #BACKUP
               LET g_prff_d_o.* = g_prff_d[l_ac].*  #BACKUP
               CALL aprt502_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt502_set_no_entry_b(l_cmd)
               IF NOT aprt502_lock_b("prff_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt502_bcl INTO g_prff_d[l_ac].prffacti,g_prff_d[l_ac].prff001,g_prff_d[l_ac].prff002, 
                      g_prff_d[l_ac].prff003,g_prff_d[l_ac].prffsite,g_prff_d[l_ac].prffunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prff_d_t.prff001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prff_d_mask_o[l_ac].* =  g_prff_d[l_ac].*
                  CALL aprt502_prff_t_mask()
                  LET g_prff_d_mask_n[l_ac].* =  g_prff_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt502_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF NOT cl_null(l_ac) AND l_ac<>0 THEN
               CALL aprt502_fill()
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
            INITIALIZE g_prff_d[l_ac].* TO NULL 
            INITIALIZE g_prff_d_t.* TO NULL 
            INITIALIZE g_prff_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prff_d[l_ac].prffacti = "Y"
      LET g_prff_d[l_ac].prff002 = "4"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prff_d_t.* = g_prff_d[l_ac].*     #新輸入資料
            LET g_prff_d_o.* = g_prff_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt502_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt502_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prff_d[li_reproduce_target].* = g_prff_d[li_reproduce].*
 
               LET g_prff_d[li_reproduce_target].prff001 = NULL
               LET g_prff_d[li_reproduce_target].prff002 = NULL
               LET g_prff_d[li_reproduce_target].prff003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL g_imaa_d.clear()
            CALL aprt502_fill()
            LET g_prff_d[l_ac].prffunit = g_prfe_m.prfeunit
            LET g_prff_d[l_ac].prffsite = g_prfe_m.prfesite
            CALL aprt502_create_prff001()
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
            SELECT COUNT(1) INTO l_count FROM prff_t 
             WHERE prffent = g_enterprise AND prffdocno = g_prfe_m.prfedocno
 
               AND prff001 = g_prff_d[l_ac].prff001
               AND prff002 = g_prff_d[l_ac].prff002
               AND prff003 = g_prff_d[l_ac].prff003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfe_m.prfedocno
               LET gs_keys[2] = g_prff_d[g_detail_idx].prff001
               LET gs_keys[3] = g_prff_d[g_detail_idx].prff002
               LET gs_keys[4] = g_prff_d[g_detail_idx].prff003
               CALL aprt502_insert_b('prff_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prff_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prff_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt502_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL aprt502_fill()               #160513-00002#1   by 08172
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
               LET gs_keys[01] = g_prfe_m.prfedocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prff_d_t.prff001
               LET gs_keys[gs_keys.getLength()+1] = g_prff_d_t.prff002
               LET gs_keys[gs_keys.getLength()+1] = g_prff_d_t.prff003
 
            
               #刪除同層單身
               IF NOT aprt502_delete_b('prff_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt502_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt502_key_delete_b(gs_keys,'prff_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt502_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt502_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prff_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prff_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prffacti
            #add-point:BEFORE FIELD prffacti name="input.b.page1.prffacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prffacti
            
            #add-point:AFTER FIELD prffacti name="input.a.page1.prffacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prffacti
            #add-point:ON CHANGE prffacti name="input.g.page1.prffacti"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prff001
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prff_d[l_ac].prff001,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prff001
            END IF 
 
 
 
            #add-point:AFTER FIELD prff001 name="input.a.page1.prff001"
            IF NOT cl_null(g_prff_d[l_ac].prff001) THEN 
            END IF 


            #此段落由子樣板a05產生
            IF  g_prfe_m.prfedocno IS NOT NULL AND g_prff_d[g_detail_idx].prff001 IS NOT NULL AND g_prff_d[g_detail_idx].prff002 IS NOT NULL AND g_prff_d[g_detail_idx].prff003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfe_m.prfedocno != g_prfedocno_t OR g_prff_d[g_detail_idx].prff001 != g_prff_d_t.prff001 OR g_prff_d[g_detail_idx].prff002 != g_prff_d_t.prff002 OR g_prff_d[g_detail_idx].prff003 != g_prff_d_t.prff003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prff_t WHERE "||"prffent = '" ||g_enterprise|| "' AND "||"prffdocno = '"||g_prfe_m.prfedocno ||"' AND "|| "prff001 = '"||g_prff_d[g_detail_idx].prff001 ||"' AND "|| "prff002 = '"||g_prff_d[g_detail_idx].prff002 ||"' AND "|| "prff003 = '"||g_prff_d[g_detail_idx].prff003 ||"'",'std-00004',0) THEN 
                     LET g_prff_d[l_ac].prff001 = g_prff_d_t.prff001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prff001
            #add-point:BEFORE FIELD prff001 name="input.b.page1.prff001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prff001
            #add-point:ON CHANGE prff001 name="input.g.page1.prff001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prff002
            #add-point:BEFORE FIELD prff002 name="input.b.page1.prff002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prff002
            
            #add-point:AFTER FIELD prff002 name="input.a.page1.prff002"
            #此段落由子樣板a05產生
            IF  g_prfe_m.prfedocno IS NOT NULL AND g_prff_d[g_detail_idx].prff001 IS NOT NULL AND g_prff_d[g_detail_idx].prff002 IS NOT NULL AND g_prff_d[g_detail_idx].prff003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfe_m.prfedocno != g_prfedocno_t OR g_prff_d[g_detail_idx].prff001 != g_prff_d_t.prff001 OR g_prff_d[g_detail_idx].prff002 != g_prff_d_t.prff002 OR g_prff_d[g_detail_idx].prff003 != g_prff_d_t.prff003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prff_t WHERE "||"prffent = '" ||g_enterprise|| "' AND "||"prffdocno = '"||g_prfe_m.prfedocno ||"' AND "|| "prff001 = '"||g_prff_d[g_detail_idx].prff001 ||"' AND "|| "prff002 = '"||g_prff_d[g_detail_idx].prff002 ||"' AND "|| "prff003 = '"||g_prff_d[g_detail_idx].prff003 ||"'",'std-00004',0) THEN 
                     LET g_prff_d[l_ac].prff002 = g_prff_d_t.prff002
                     NEXT FIELD CURRENT
                  END IF
#                  LET g_prff_d[l_ac].prff003=null
#                  LET g_prff_d[l_ac].prff003_desc = NULL
#                  DISPLAY g_prff_d[l_ac].prff003 TO s_detail1[l_ac].prff003
#                  DISPLAY g_prff_d[l_ac].prff003_desc TO s_detail1[l_ac].prff003_desc
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prff002
            #add-point:ON CHANGE prff002 name="input.g.page1.prff002"
            IF  g_prfe_m.prfedocno IS NOT NULL AND g_prff_d[g_detail_idx].prff001 IS NOT NULL AND g_prff_d[g_detail_idx].prff002 IS NOT NULL AND g_prff_d[g_detail_idx].prff003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfe_m.prfedocno != g_prfedocno_t OR g_prff_d[g_detail_idx].prff001 != g_prff_d_t.prff001 OR g_prff_d[g_detail_idx].prff002 != g_prff_d_t.prff002 OR g_prff_d[g_detail_idx].prff003 != g_prff_d_t.prff003)) THEN 
                  
                  LET g_prff_d[l_ac].prff003=null
                  LET g_prff_d[l_ac].prff003_desc = NULL
                  DISPLAY g_prff_d[l_ac].prff003 TO s_detail1[l_ac].prff003
                  DISPLAY g_prff_d[l_ac].prff003_desc TO s_detail1[l_ac].prff003_desc
               END IF
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prff003
            
            #add-point:AFTER FIELD prff003 name="input.a.page1.prff003"
            #此段落由子樣板a05產生
            LET g_prff_d[l_ac].prff003_desc = NULL
            DISPLAY g_prff_d[l_ac].prff003_desc TO s_detail1[l_ac].prff003_desc
            IF  g_prfe_m.prfedocno IS NOT NULL AND g_prff_d[g_detail_idx].prff001 IS NOT NULL AND g_prff_d[g_detail_idx].prff002 IS NOT NULL AND g_prff_d[g_detail_idx].prff003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfe_m.prfedocno != g_prfedocno_t OR g_prff_d[g_detail_idx].prff001 != g_prff_d_t.prff001 OR g_prff_d[g_detail_idx].prff002 != g_prff_d_t.prff002 OR g_prff_d[g_detail_idx].prff003 != g_prff_d_t.prff003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prff_t WHERE "||"prffent = '" ||g_enterprise|| "' AND "||"prffdocno = '"||g_prfe_m.prfedocno ||"' AND "|| "prff001 = '"||g_prff_d[g_detail_idx].prff001 ||"' AND "|| "prff002 = '"||g_prff_d[g_detail_idx].prff002 ||"' AND "|| "prff003 = '"||g_prff_d[g_detail_idx].prff003 ||"'",'std-00004',0) THEN 
                     LET g_prff_d[l_ac].prff003 = g_prff_d_t.prff003
                     CALL aprt502_prff003_ref()                     
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt502_prff003() RETURNING l_success
                  IF l_success=false THEN
                     LET g_prff_d[l_ac].prff003 = g_prff_d_t.prff003
                     CALL aprt502_prff003_ref()                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aprt502_prff003_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prff003
            #add-point:BEFORE FIELD prff003 name="input.b.page1.prff003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prff003
            #add-point:ON CHANGE prff003 name="input.g.page1.prff003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prffsite
            #add-point:BEFORE FIELD prffsite name="input.b.page1.prffsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prffsite
            
            #add-point:AFTER FIELD prffsite name="input.a.page1.prffsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prffsite
            #add-point:ON CHANGE prffsite name="input.g.page1.prffsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prffunit
            #add-point:BEFORE FIELD prffunit name="input.b.page1.prffunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prffunit
            
            #add-point:AFTER FIELD prffunit name="input.a.page1.prffunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prffunit
            #add-point:ON CHANGE prffunit name="input.g.page1.prffunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prffacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prffacti
            #add-point:ON ACTION controlp INFIELD prffacti name="input.c.page1.prffacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prff001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prff001
            #add-point:ON ACTION controlp INFIELD prff001 name="input.c.page1.prff001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prff002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prff002
            #add-point:ON ACTION controlp INFIELD prff002 name="input.c.page1.prff002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prff003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prff003
            #add-point:ON ACTION controlp INFIELD prff003 name="input.c.page1.prff003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prff_d[l_ac].prff003             #給予default值

            #給予arg

            CALL aprt502_prff003_ctp()

            LET g_prff_d[l_ac].prff003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prff_d[l_ac].prff003 TO s_detail1[l_ac].prff003              #顯示到畫面上           
            CALL aprt502_prff003_ref()
            NEXT FIELD prff003  
            #END add-point
 
 
         #Ctrlp:input.c.page1.prffsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prffsite
            #add-point:ON ACTION controlp INFIELD prffsite name="input.c.page1.prffsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prffunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prffunit
            #add-point:ON ACTION controlp INFIELD prffunit name="input.c.page1.prffunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prff_d[l_ac].* = g_prff_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt502_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prff_d[l_ac].prff001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prff_d[l_ac].* = g_prff_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt502_prff_t_mask_restore('restore_mask_o')
      
               UPDATE prff_t SET (prffdocno,prffacti,prff001,prff002,prff003,prffsite,prffunit) = (g_prfe_m.prfedocno, 
                   g_prff_d[l_ac].prffacti,g_prff_d[l_ac].prff001,g_prff_d[l_ac].prff002,g_prff_d[l_ac].prff003, 
                   g_prff_d[l_ac].prffsite,g_prff_d[l_ac].prffunit)
                WHERE prffent = g_enterprise AND prffdocno = g_prfe_m.prfedocno 
 
                  AND prff001 = g_prff_d_t.prff001 #項次   
                  AND prff002 = g_prff_d_t.prff002  
                  AND prff003 = g_prff_d_t.prff003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prff_d[l_ac].* = g_prff_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prff_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prff_d[l_ac].* = g_prff_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prff_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfe_m.prfedocno
               LET gs_keys_bak[1] = g_prfedocno_t
               LET gs_keys[2] = g_prff_d[g_detail_idx].prff001
               LET gs_keys_bak[2] = g_prff_d_t.prff001
               LET gs_keys[3] = g_prff_d[g_detail_idx].prff002
               LET gs_keys_bak[3] = g_prff_d_t.prff002
               LET gs_keys[4] = g_prff_d[g_detail_idx].prff003
               LET gs_keys_bak[4] = g_prff_d_t.prff003
               CALL aprt502_update_b('prff_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt502_prff_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prff_d[g_detail_idx].prff001 = g_prff_d_t.prff001 
                  AND g_prff_d[g_detail_idx].prff002 = g_prff_d_t.prff002 
                  AND g_prff_d[g_detail_idx].prff003 = g_prff_d_t.prff003 
 
                  ) THEN
                  LET gs_keys[01] = g_prfe_m.prfedocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prff_d_t.prff001
                  LET gs_keys[gs_keys.getLength()+1] = g_prff_d_t.prff002
                  LET gs_keys[gs_keys.getLength()+1] = g_prff_d_t.prff003
 
                  CALL aprt502_key_update_b(gs_keys,'prff_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prfe_m),util.JSON.stringify(g_prff_d_t)
               LET g_log2 = util.JSON.stringify(g_prfe_m),util.JSON.stringify(g_prff_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt502_unlock_b("prff_t","'1'")
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
               LET g_prff_d[li_reproduce_target].* = g_prff_d[li_reproduce].*
 
               LET g_prff_d[li_reproduce_target].prff001 = NULL
               LET g_prff_d[li_reproduce_target].prff002 = NULL
               LET g_prff_d[li_reproduce_target].prff003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prff_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prff_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aprt502.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_imaa_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
               
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
            NEXT FIELD prfesite  #ken---add 需求單號：141208-00001 項次：27
            #end add-point  
            NEXT FIELD prfedocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prffacti
 
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
 
{<section id="aprt502.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt502_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt502_b_fill() #單身填充
      CALL aprt502_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt502_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfe_m.prfedocno
   CALL ap_ref_array2(g_ref_fields," SELECT prfel002,prfel003 FROM prfel_t WHERE prfelent = '"||g_enterprise||"' AND prfeldocno = ? AND prfel001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_prfe_m.prfel002 = g_rtn_fields[1] 
   LET g_prfe_m.prfel003 = g_rtn_fields[2] 
   DISPLAY g_prfe_m.prfel002,g_prfe_m.prfel003 TO prfel002,prfel003
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfeunit
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfeunit_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfeunit_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfe004
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfe004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfe004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfe005
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfe005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfe005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfeownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfeownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfeownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfeowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfeowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfeowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfecrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfecrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfecrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfecrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfecrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfecrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfemodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfemodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfemodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfe_m.prfecnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfe_m.prfecnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfe_m.prfecnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prfe_m_mask_o.* =  g_prfe_m.*
   CALL aprt502_prfe_t_mask()
   LET g_prfe_m_mask_n.* =  g_prfe_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001, 
       g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003,g_prfe_m.prfe004, 
       g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc,g_prfe_m.prfeunit,g_prfe_m.prfestus, 
       g_prfe_m.prfeownid,g_prfe_m.prfeownid_desc,g_prfe_m.prfeowndp,g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid, 
       g_prfe_m.prfemodid_desc,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid,g_prfe_m.prfecnfid_desc,g_prfe_m.prfecnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfe_m.prfestus 
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
   FOR l_ac = 1 TO g_prff_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL aprt502_prff003_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt502_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF NOT cl_null(l_ac) AND l_ac<>0 THEN
      CALL aprt502_fill()
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt502_detail_show()
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
 
{<section id="aprt502.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt502_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prfe_t.prfedocno 
   DEFINE l_oldno     LIKE prfe_t.prfedocno 
 
   DEFINE l_master    RECORD LIKE prfe_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prff_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5  #ken 需求單號：141208-00001 項次：27
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
   
   IF g_prfe_m.prfedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prfedocno_t = g_prfe_m.prfedocno
 
    
   LET g_prfe_m.prfedocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prfe_m.prfeownid = g_user
      LET g_prfe_m.prfeowndp = g_dept
      LET g_prfe_m.prfecrtid = g_user
      LET g_prfe_m.prfecrtdp = g_dept 
      LET g_prfe_m.prfecrtdt = cl_get_current()
      LET g_prfe_m.prfemodid = g_user
      LET g_prfe_m.prfemoddt = cl_get_current()
      LET g_prfe_m.prfestus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #ken---add---s 需求單號：141208-00001 項次：27
   CALL s_aooi500_default(g_prog,'prfesite',g_prfe_m.prfesite)
      RETURNING l_insert,g_prfe_m.prfesite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   #ken---add---e
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prfe_m.prfesite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prfe_m.prfedocno = r_doctype
   #dongsz--add--end---
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfe_m.prfestus 
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
   
   
   CALL aprt502_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prfe_m.* TO NULL
      INITIALIZE g_prff_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt502_show()
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
   CALL aprt502_set_act_visible()   
   CALL aprt502_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prfedocno_t = g_prfe_m.prfedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prfeent = " ||g_enterprise|| " AND",
                      " prfedocno = '", g_prfe_m.prfedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt502_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt502_idx_chk()
   
   LET g_data_owner = g_prfe_m.prfeownid      
   LET g_data_dept  = g_prfe_m.prfeowndp
   
   #功能已完成,通報訊息中心
   CALL aprt502_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt502_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prff_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt502_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prff_t
    WHERE prffent = g_enterprise AND prffdocno = g_prfedocno_t
 
    INTO TEMP aprt502_detail
 
   #將key修正為調整後   
   UPDATE aprt502_detail 
      #更新key欄位
      SET prffdocno = g_prfe_m.prfedocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prff_t SELECT * FROM aprt502_detail
   
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
   DROP TABLE aprt502_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prfedocno_t = g_prfe_m.prfedocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt502_delete()
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
   
   IF g_prfe_m.prfedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.prfeldocno = g_prfe_m.prfedocno
LET g_master_multi_table_t.prfel002 = g_prfe_m.prfel002
LET g_master_multi_table_t.prfel003 = g_prfe_m.prfel003
 
   
   CALL s_transaction_begin()
 
   OPEN aprt502_cl USING g_enterprise,g_prfe_m.prfedocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt502_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt502_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
       g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
       g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
       g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc,g_prfe_m.prfeownid_desc, 
       g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfemodid_desc, 
       g_prfe_m.prfecnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt502_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prfe_m_mask_o.* =  g_prfe_m.*
   CALL aprt502_prfe_t_mask()
   LET g_prfe_m_mask_n.* =  g_prfe_m.*
   
   CALL aprt502_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt502_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prfedocno_t = g_prfe_m.prfedocno
 
 
      DELETE FROM prfe_t
       WHERE prfeent = g_enterprise AND prfedocno = g_prfe_m.prfedocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prfe_m.prfedocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #ken---add---s 需求單號：141208-00001 項次：27
      IF NOT s_aooi200_del_docno(g_prfe_m.prfedocno,g_prfe_m.prfedocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken---add---e
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM prff_t
       WHERE prffent = g_enterprise AND prffdocno = g_prfe_m.prfedocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prff_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prfe_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt502_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prff_d.clear() 
 
     
      CALL aprt502_ui_browser_refresh()  
      #CALL aprt502_ui_headershow()  
      #CALL aprt502_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'prfelent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.prfeldocno
   LET l_field_keys[02] = 'prfeldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prfel_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt502_browser_fill("")
         CALL aprt502_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt502_cl
 
   #功能已完成,通報訊息中心
   CALL aprt502_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt502.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt502_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prff_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt502_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prffacti,prff001,prff002,prff003,prffsite,prffunit  FROM prff_t", 
                
                     " INNER JOIN prfe_t ON prfeent = " ||g_enterprise|| " AND prfedocno = prffdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE prffent=? AND prffdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prff_t.prff001,prff_t.prff002,prff_t.prff003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt502_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt502_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prfe_m.prfedocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prfe_m.prfedocno INTO g_prff_d[l_ac].prffacti,g_prff_d[l_ac].prff001, 
          g_prff_d[l_ac].prff002,g_prff_d[l_ac].prff003,g_prff_d[l_ac].prffsite,g_prff_d[l_ac].prffunit  
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
   
   CALL g_prff_d.deleteElement(g_prff_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt502_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prff_d.getLength()
      LET g_prff_d_mask_o[l_ac].* =  g_prff_d[l_ac].*
      CALL aprt502_prff_t_mask()
      LET g_prff_d_mask_n[l_ac].* =  g_prff_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt502_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prff_t
       WHERE prffent = g_enterprise AND
         prffdocno = ps_keys_bak[1] AND prff001 = ps_keys_bak[2] AND prff002 = ps_keys_bak[3] AND prff003 = ps_keys_bak[4]
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
         CALL g_prff_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt502_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prff_t
                  (prffent,
                   prffdocno,
                   prff001,prff002,prff003
                   ,prffacti,prffsite,prffunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prff_d[g_detail_idx].prffacti,g_prff_d[g_detail_idx].prffsite,g_prff_d[g_detail_idx].prffunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prff_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prff_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt502_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prff_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt502_prff_t_mask_restore('restore_mask_o')
               
      UPDATE prff_t 
         SET (prffdocno,
              prff001,prff002,prff003
              ,prffacti,prffsite,prffunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prff_d[g_detail_idx].prffacti,g_prff_d[g_detail_idx].prffsite,g_prff_d[g_detail_idx].prffunit)  
 
         WHERE prffent = g_enterprise AND prffdocno = ps_keys_bak[1] AND prff001 = ps_keys_bak[2] AND prff002 = ps_keys_bak[3] AND prff003 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prff_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prff_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt502_prff_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprt502.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt502_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt502.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt502_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt502.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt502_lock_b(ps_table,ps_page)
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
   #CALL aprt502_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prff_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt502_bcl USING g_enterprise,
                                       g_prfe_m.prfedocno,g_prff_d[g_detail_idx].prff001,g_prff_d[g_detail_idx].prff002, 
                                           g_prff_d[g_detail_idx].prff003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt502_bcl:",SQLERRMESSAGE 
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
 
{<section id="aprt502.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt502_unlock_b(ps_table,ps_page)
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
      CLOSE aprt502_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt502_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prfedocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prfedocno",TRUE)
      CALL cl_set_comp_entry("prfedocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prfesite",TRUE)
      CALL cl_set_comp_entry("prfe001,prfe002",TRUE)
      CALL cl_set_comp_entry("prfedocdt",TRUE)  #ken---add 需求單號：141208-00001 項次：27
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("prfeacti",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt502_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prfedocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      SELECT count(*) INTO l_cnt FROM prff_t WHERE prffent=g_enterprise AND prffdocno = g_prfe_m.prfedocno
      IF l_cnt>0 THEN  
         CALL cl_set_comp_entry("prfe001,prfe002",FALSE)
      ELSE
         CALL cl_set_comp_entry("prfe001,prfe002",TRUE)      
      END IF
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prfedocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prfedocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #ken---add---s 需求單號：141208-00001 項次：27
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("prfesite",FALSE)
      CALL cl_set_comp_entry("prfedocdt",FALSE)
      CALL cl_set_comp_entry("prfedocno",FALSE)
   END IF
   #ken---add---e
   
   IF g_prfe_m.prfe001='I' THEN
      CALL cl_set_comp_entry("prfeacti",FALSE)
   ELSE
      CALL cl_set_comp_entry("prfeacti",TRUE)     
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'prfesite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prfesite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt502.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt502_set_entry_b(p_cmd)
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
 
{<section id="aprt502.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt502_set_no_entry_b(p_cmd)
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
 
{<section id="aprt502.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt502_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt502_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prfe_m.prfestus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt502_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt502_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt502_default_search()
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
      LET ls_wc = ls_wc, " prfedocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prfe_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prff_t" 
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
 
{<section id="aprt502.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt502_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_prfe_m.prfestus = 'X'  THEN
      RETURN
   END IF
   IF g_prfe_m.prfestus = 'C' THEN  #結案狀態
      RETURN
   END IF
   IF g_prfe_m.prfestus = 'Y' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prfe_m.prfedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt502_cl USING g_enterprise,g_prfe_m.prfedocno
   IF STATUS THEN
      CLOSE aprt502_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt502_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
       g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
       g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid, 
       g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc,g_prfe_m.prfeownid_desc, 
       g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfemodid_desc, 
       g_prfe_m.prfecnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt502_action_chk() THEN
      CLOSE aprt502_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc,g_prfe_m.prfedocdt,g_prfe_m.prfedocno,g_prfe_m.prfe001, 
       g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003,g_prfe_m.prfe004, 
       g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc,g_prfe_m.prfeunit,g_prfe_m.prfestus, 
       g_prfe_m.prfeownid,g_prfe_m.prfeownid_desc,g_prfe_m.prfeowndp,g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid, 
       g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid, 
       g_prfe_m.prfemodid_desc,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid,g_prfe_m.prfecnfid_desc,g_prfe_m.prfecnfdt 
 
 
   CASE g_prfe_m.prfestus
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
         CASE g_prfe_m.prfestus
            
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
#      IF g_prfe_m.prfestus = 'N' THEN
#         CALL cl_set_act_visible("unconfirmed", FALSE)
#         CALL cl_set_act_visible("invalid,confirmed", true)            
#      END IF
#      IF g_prfe_m.prfestus = 'Y' THEN
#         CALL cl_set_act_visible("confirmed,invalid", FALSE)      
#      END IF
#      IF g_prfe_m.prfestus = 'X' THEN
#         CALL cl_set_act_visible("confirmed,invalid", FALSE)      
#      END IF
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_prfe_m.prfestus
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
            IF NOT aprt502_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt502_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt502_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt502_cl
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
      g_prfe_m.prfestus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt502_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT prfestus INTO g_prfe_m.prfestus FROM prfe_t WHERE prfedocno = g_prfe_m.prfedocno
            AND prfeent = g_enterprise         
         CALL s_aprt502_conf_chk(g_prfe_m.prfedocno,g_prfe_m.prfestus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_aprt502_conf_upd(g_prfe_m.prfedocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfe_m.prfedocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
               RETURN
            END IF            
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN            
         END IF
                 
      WHEN 'X'
         SELECT prfestus INTO g_prfe_m.prfestus FROM prfe_t WHERE prfedocno = g_prfe_m.prfedocno
            AND prfeent = g_enterprise  
         CALL s_aprt502_void_chk(g_prfe_m.prfedocno,g_prfe_m.prfestus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_aprt502_void_upd(g_prfe_m.prfedocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfe_m.prfedocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
               RETURN
            END IF
         ELSE 
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN    
         END IF        
   END CASE
   #end add-point
   
   LET g_prfe_m.prfemodid = g_user
   LET g_prfe_m.prfemoddt = cl_get_current()
   LET g_prfe_m.prfestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prfe_t 
      SET (prfestus,prfemodid,prfemoddt) 
        = (g_prfe_m.prfestus,g_prfe_m.prfemodid,g_prfe_m.prfemoddt)     
    WHERE prfeent = g_enterprise AND prfedocno = g_prfe_m.prfedocno
 
    
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
      EXECUTE aprt502_master_referesh USING g_prfe_m.prfedocno INTO g_prfe_m.prfesite,g_prfe_m.prfedocdt, 
          g_prfe_m.prfedocno,g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004, 
          g_prfe_m.prfe005,g_prfe_m.prfeunit,g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeowndp, 
          g_prfe_m.prfecrtid,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt, 
          g_prfe_m.prfecnfid,g_prfe_m.prfecnfdt,g_prfe_m.prfesite_desc,g_prfe_m.prfe004_desc,g_prfe_m.prfe005_desc, 
          g_prfe_m.prfeownid_desc,g_prfe_m.prfeowndp_desc,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp_desc, 
          g_prfe_m.prfemodid_desc,g_prfe_m.prfecnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prfe_m.prfesite,g_prfe_m.prfesite_desc,g_prfe_m.prfedocdt,g_prfe_m.prfedocno, 
          g_prfe_m.prfe001,g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfel002,g_prfe_m.prfel003, 
          g_prfe_m.prfe004,g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc,g_prfe_m.prfeunit, 
          g_prfe_m.prfestus,g_prfe_m.prfeownid,g_prfe_m.prfeownid_desc,g_prfe_m.prfeowndp,g_prfe_m.prfeowndp_desc, 
          g_prfe_m.prfecrtid,g_prfe_m.prfecrtid_desc,g_prfe_m.prfecrtdp,g_prfe_m.prfecrtdp_desc,g_prfe_m.prfecrtdt, 
          g_prfe_m.prfemodid,g_prfe_m.prfemodid_desc,g_prfe_m.prfemoddt,g_prfe_m.prfecnfid,g_prfe_m.prfecnfid_desc, 
          g_prfe_m.prfecnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT prfestus,prfecnfid,prfecnfdt,prfemodid,prfemoddt INTO g_prfe_m.prfestus,g_prfe_m.prfecnfid,g_prfe_m.prfecnfdt,
                                                                g_prfe_m.prfemodid,g_prfe_m.prfemoddt  
     FROM prfe_t
    WHERE prfeent = g_enterprise AND prfedocno = g_prfe_m.prfedocno
   DISPLAY BY NAME g_prfe_m.prfestus,g_prfe_m.prfecnfid,g_prfe_m.prfecnfdt,g_prfe_m.prfemodid,g_prfe_m.prfemoddt
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfe_m.prfecnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfe_m.prfecnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prfe_m.prfecnfid_desc   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfe_m.prfemodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfe_m.prfemodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prfe_m.prfemodid_desc
   IF g_prfe_m.prfestus NOT MATCHES "[DNR]" THEN
      CALL cl_set_act_visible("delete,modify,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("delete,modify,modify_detail", true)    
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt502_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt502_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt502.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt502_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prff_d.getLength() THEN
         LET g_detail_idx = g_prff_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prff_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prff_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt502_b_fill2(pi_idx)
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
   
   CALL aprt502_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt502_fill_chk(ps_idx)
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
 
{<section id="aprt502.status_show" >}
PRIVATE FUNCTION aprt502_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt502.mask_functions" >}
&include "erp/apr/aprt502_mask.4gl"
 
{</section>}
 
{<section id="aprt502.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt502_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   define  l_success   like type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt502_show()
   CALL aprt502_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt502_conf_chk(g_prfe_m.prfedocno,g_prfe_m.prfestus) RETURNING l_success
   IF l_success THEN
            
   ELSE
      CLOSE aprt502_cl
      CALL s_transaction_end('N','0')
      RETURN  FALSE          
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prfe_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prff_d))
 
 
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
   #CALL aprt502_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt502_ui_headershow()
   CALL aprt502_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt502_draw_out()
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
   CALL aprt502_ui_headershow()  
   CALL aprt502_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt502.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt502_set_pk_array()
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
   LET g_pk_array[1].values = g_prfe_m.prfedocno
   LET g_pk_array[1].column = 'prfedocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt502.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt502.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt502_msgcentre_notify(lc_state)
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
   CALL aprt502_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prfe_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt502.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt502_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#31 add-S
   SELECT prfestus  INTO g_prfe_m.prfestus
     FROM prfe_t
    WHERE prfeent = g_enterprise
      AND prfedocno = g_prfe_m.prfedocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prfe_m.prfestus
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
        LET g_errparam.extend = g_prfe_m.prfedocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt502_set_act_visible()
        CALL aprt502_set_act_no_visible()
        CALL aprt502_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#31 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt502.other_function" readonly="Y" >}

#display prfesite
PRIVATE FUNCTION aprt502_prfesite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfe_m.prfesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfe_m.prfesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfe_m.prfesite_desc
END FUNCTION

#display prfe004
PRIVATE FUNCTION aprt502_prfe004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfe_m.prfe004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfe_m.prfe004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfe_m.prfe004_desc
END FUNCTION

#display prfe005
PRIVATE FUNCTION aprt502_prfe005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfe_m.prfe005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfe_m.prfe005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfe_m.prfe005_desc
END FUNCTION

#display prfe004,prfe005
PRIVATE FUNCTION aprt502_prfe004_display()
   SELECT ooag003 INTO g_prfe_m.prfe005
     FROM ooag_t
    WHERE ooagent= g_enterprise
      AND ooag001= g_prfe_m.prfe004 
   CALL aprt502_prfe005_ref()
END FUNCTION

#init
PRIVATE FUNCTION aprt502_prfe001_init()
   IF cl_null(g_prfe_m.prfe002) THEN
      RETURN
   END IF
   INITIALIZE g_prfe_m.prfel002,g_prfe_m.prfel003 TO NULL
   INITIALIZE g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004,
              g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc
           TO NULL
   LET g_prfe_m.prfe004 = g_user
   LET g_prfe_m.prfeacti = 'Y'
   CALL aprt502_prfe004_ref()
   CALL aprt502_prfe004_display()
   DISPLAY BY NAME g_prfe_m.prfel002,g_prfe_m.prfel003,
                   g_prfe_m.prfe002,g_prfe_m.prfe003,g_prfe_m.prfeacti,g_prfe_m.prfe004,
                   g_prfe_m.prfe004_desc,g_prfe_m.prfe005,g_prfe_m.prfe005_desc
END FUNCTION

#chk prfe002
PRIVATE FUNCTION aprt502_prfe002()
   DEFINE l_cnt   like type_t.num5
   DEFINE l_cnt2  LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_errno   STRING
   
   LET l_cnt = 0
   LET l_cnt2 = 0
   LET l_success = TRUE
   LET l_errno = NULL
   IF g_prfe_m.prfe001='U' THEN
      SELECT count(*) INTO l_cnt FROM prfg_t WHERE prfgent=g_enterprise
         AND prfg001=g_prfe_m.prfe002
      IF l_cnt<=0 THEN
         LET l_success = FALSE
         LET l_errno = "apr-00199"
         RETURN l_success,l_errno            
      END IF 
               
   END IF
   IF g_prfe_m.prfe001='I' THEN
      SELECT count(*) INTO l_cnt FROM prfg_t WHERE prfgent=g_enterprise
         AND prfg001=g_prfe_m.prfe002
      IF l_cnt>0 THEN
         LET l_success = FALSE
         LET l_errno = "apr-00200"
         RETURN l_success,l_errno           
      END IF
           
   END IF
   LET l_cnt=0
   SELECT count(*) INTO l_cnt FROM prfe_t
    WHERE prfeent = g_enterprise AND prfe002 = g_prfe_m.prfe002
      AND prfestus='N'
   IF l_cnt>0 THEN
      LET l_success = FALSE
      LET l_errno = "apr-00201"
      RETURN l_success,l_errno         
   END IF
   RETURN l_success,l_errno
END FUNCTION

#display prfe003
PRIVATE FUNCTION aprt502_prfe002_ref()
   IF g_prfe_m.prfe001='U' THEN
      SELECT to_char(to_number(max(prfg002))+1) INTO g_prfe_m.prfe003
        FROM prfg_t
       WHERE prfgent = g_enterprise AND prfg001= g_prfe_m.prfe002
      SELECT prfgl003,prfgl004 INTO g_prfe_m.prfel002,g_prfe_m.prfel003
        FROM prfgl_t
       WHERE prfglent = g_enterprise AND prfgl001 = g_prfe_m.prfe002
         AND prfgl002 = g_dlang
      SELECT prfgstus INTO g_prfe_m.prfeacti
        FROM prfg_t
       WHERE prfgent = g_enterprise AND prfg001 = g_prfe_m.prfe002  
      DISPLAY BY NAME g_prfe_m.prfeacti          
   END IF
   IF g_prfe_m.prfe001='I' THEN
      LET  g_prfe_m.prfe003=1 
   END IF
   DISPLAY BY NAME  g_prfe_m.prfe003
END FUNCTION

#create prff001
PRIVATE FUNCTION aprt502_create_prff001()
   SELECT max(prff001)+1 INTO g_prff_d[l_ac].prff001
     FROM prff_t
    WHERE prffent = g_enterprise AND prffdocno=g_prfe_m.prfedocno
   IF cl_null(g_prff_d[l_ac].prff001) THEN
      LET g_prff_d[l_ac].prff001=1
   END IF
END FUNCTION

##chk prff003
PRIVATE FUNCTION aprt502_prff003()
   DEFINE l_rtax005   LIKE rtax_t.rtax005
   DEFINE l_stus      LIKE type_t.chr1
   DEFINE l_oocq001   LIKE oocq_t.oocq001
   DEFINE l_success   LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   LET l_success = TRUE
   IF cl_null(g_prff_d[l_ac].prff002) THEN
      RETURN l_success
   END IF
   CASE g_prff_d[l_ac].prff002
      WHEN '4'
         SELECT imaastus INTO l_stus
           FROM imaa_t
          WHERE  imaaent = g_enterprise  AND imaa001 = g_prff_d[l_ac].prff003
         CASE
            WHEN SQLCA.sqlcode = 100 LET g_errno = 'aim-00001' #该商品不存在或在当前组织不可使用
            WHEN l_stus <> 'Y'       LET g_errno = 'aim-00101' #该商品在当前组织已无效
         END CASE
      WHEN '5'
         SELECT rtax005,rtaxstus INTO l_rtax005,l_stus
           FROM rtax_t
          WHERE rtaxent = g_enterprise AND rtax001 = g_prff_d[l_ac].prff003
         CASE
            WHEN SQLCA.sqlcode = 100 LET g_errno = 'agc-00027' #该品类编号不存在
            WHEN l_stus <> 'Y'       LET g_errno = 'agc-00028' #该品类编号已无效
            WHEN l_rtax005 <> 0      LET g_errno = 'agc-00029' #该品类编号存在下级品类
         END CASE
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   CASE g_prff_d[l_ac].prff002
      WHEN '4'
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_prff_d[l_ac].prff003
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET l_success = FALSE
            RETURN l_success
         END IF
      WHEN '5'
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_prff_d[l_ac].prff003
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET l_success = FALSE
            RETURN l_success
         END IF
      OTHERWISE
         SELECT oocqstus INTO l_stus
           FROM oocq_t
          WHERE oocqent = g_enterprise AND oocq001 = l_oocq001 AND oocq002 = g_prff_d[l_ac].prff003
         CASE
            WHEN SQLCA.sqlcode = 100
               CASE g_prff_d[l_ac].prff002                 
                  WHEN '6'
                     LET g_errno="aim-00178"
                  WHEN '7'
                     LET g_errno="apr-00217"
                  WHEN '8'
                     LET g_errno="apr-00218"
                  WHEN '9'
                     LET g_errno="apr-00219"
                  WHEN 'A'
                     LET g_errno="apr-00220"
                  WHEN 'B'
                     LET g_errno="apr-00221"
                  WHEN 'C'
                     LET g_errno="apr-00222"
                  WHEN 'D'
                     LET g_errno="apr-00223"
                  WHEN 'E'
                     LET g_errno="apr-00224"
                  WHEN 'F'
                     LET g_errno="apr-00225"
                  WHEN 'G'
                     LET g_errno="apr-00226"
                  WHEN 'H'
                     LET g_errno="apr-00227"
                  WHEN 'I'
                     LET g_errno="apr-00228"
                  WHEN 'J'
                     LET g_errno="apr-00229"
                  WHEN 'K'
                     LET g_errno="apr-00230"
                  WHEN 'L'
                     LET g_errno="apr-00231"
               END CASE            
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_prff_d[l_ac].prff003
            LET g_errparam.popup = TRUE
            CALL cl_err()

               LET l_success = FALSE
               RETURN l_success
            WHEN l_stus <> 'Y'
               CASE g_prff_d[l_ac].prff002                 
                  WHEN '6'
#                     LET g_errno="aim-00179"    #160318-00005#41  mark
                     LET g_errno="sub-01302"     #160318-00005#41  add
                  WHEN '7'
                     LET g_errno="apr-00232"
                  WHEN '8'
                     LET g_errno="apr-00233"
                  WHEN '9'
                     LET g_errno="apr-00234"
                  WHEN 'A'
                     LET g_errno="apr-00235"
                  WHEN 'B'
                     LET g_errno="apr-00236"
                  WHEN 'C'
                     LET g_errno="apr-00237"
                  WHEN 'D'
                     LET g_errno="apr-00238"
                  WHEN 'E'
                     LET g_errno="apr-00239"
                  WHEN 'F'
                     LET g_errno="apr-00240"
                  WHEN 'G'
                     LET g_errno="apr-00241"
                  WHEN 'H'
                     LET g_errno="apr-00242"
                  WHEN 'I'
                     LET g_errno="apr-00243"
                  WHEN 'J'
                     LET g_errno="apr-00244"
                  WHEN 'K'
                     LET g_errno="apr-00245"
                  WHEN 'L'
                     LET g_errno="apr-00246"
               END CASE
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_prff_d[l_ac].prff003
            #160318-00005#41 --s add
            IF g_errno = 'sub-01302' THEN
               LET g_errparam.replace[1] = 'arti001'
               LET g_errparam.replace[2] = cl_get_progname('arti001',g_lang,"2")
               LET g_errparam.exeprog = 'arti001'
            END IF
            #160318-00005#41 --e add
            LET g_errparam.popup = TRUE
            CALL cl_err()

               LET l_success = FALSE
               RETURN l_success
         END CASE
   END CASE
   RETURN l_success
END FUNCTION

#display prff003
PRIVATE FUNCTION aprt502_prff003_ref()
   DEFINE l_oocq001   LIKE oocq_t.oocq001
   IF cl_null(g_prff_d[l_ac].prff002) THEN
      RETURN
   END IF
   CASE g_prff_d[l_ac].prff002
      WHEN '6'
         LET l_oocq001 = '2000'
      WHEN '7'
         LET l_oocq001 = '2001'
      WHEN '8'
         LET l_oocq001 = '2002'
      WHEN '9'
         LET l_oocq001 = '2003'
      WHEN 'A'
         LET l_oocq001 = '2004'
      WHEN 'B'
         LET l_oocq001 = '2005'
      WHEN 'C'
         LET l_oocq001 = '2006'
      WHEN 'D'
         LET l_oocq001 = '2007'
      WHEN 'E'
         LET l_oocq001 = '2008'
      WHEN 'F'
         LET l_oocq001 = '2009'
      WHEN 'G'
         LET l_oocq001 = '2010'
      WHEN 'H'
         LET l_oocq001 = '2011'
      WHEN 'I'
         LET l_oocq001 = '2012'
      WHEN 'J'
         LET l_oocq001 = '2013'
      WHEN 'K'
         LET l_oocq001 = '2014'
      WHEN 'L'
         LET l_oocq001 = '2015'
   END CASE
   CASE g_prff_d[l_ac].prff002
      WHEN '4'
         SELECT imaal003 INTO g_prff_d[l_ac].prff003_desc
           FROM imaal_t
          WHERE imaalent = g_enterprise AND imaal001 = g_prff_d[l_ac].prff003 AND imaal002 = g_dlang
      WHEN '5'
         SELECT rtaxl003 INTO g_prff_d[l_ac].prff003_desc
           FROM rtaxl_t
          WHERE rtaxlent = g_enterprise AND rtaxl001 = g_prff_d[l_ac].prff003 AND rtaxl002 = g_dlang
      OTHERWISE
         SELECT oocql004 INTO g_prff_d[l_ac].prff003_desc
           FROM oocql_t
          WHERE oocqlent = g_enterprise AND oocql001 = l_oocq001 AND oocql002 = g_prff_d[l_ac].prff003 AND oocql003 = g_dlang
   END CASE
END FUNCTION

#controlp prff003
PRIVATE FUNCTION aprt502_prff003_ctp()
   CASE g_prff_d[l_ac].prff002
      WHEN '4'
         LET g_qryparam.arg1 = null
      WHEN '6'
         LET g_qryparam.arg1 = '2000'
      WHEN '7'
         LET g_qryparam.arg1 = '2001'
      WHEN '8'
         LET g_qryparam.arg1 = '2002'
      WHEN '9'
         LET g_qryparam.arg1 = '2003'
      WHEN 'A'
         LET g_qryparam.arg1 = '2004'
      WHEN 'B'
         LET g_qryparam.arg1 = '2005'
      WHEN 'C'
         LET g_qryparam.arg1 = '2006'
      WHEN 'D'
         LET g_qryparam.arg1 = '2007'
      WHEN 'E'
         LET g_qryparam.arg1 = '2008'
      WHEN 'F'
         LET g_qryparam.arg1 = '2009'
      WHEN 'G'
         LET g_qryparam.arg1 = '2010'
      WHEN 'H'
         LET g_qryparam.arg1 = '2011'
      WHEN 'I'
         LET g_qryparam.arg1 = '2012'
      WHEN 'J'
         LET g_qryparam.arg1 = '2013'
      WHEN 'K'
         LET g_qryparam.arg1 = '2014'
      WHEN 'L'
         LET g_qryparam.arg1 = '2015'
   END CASE
   CASE g_prff_d[l_ac].prff002
      WHEN '4'
         CALL q_imaa001()
      WHEN '5'
         CALL q_rtax001()
      OTHERWISE
         CALL q_oocq002()
   END CASE
END FUNCTION

#combox
PRIVATE FUNCTION aprt502_set_combo()
   DEFINE l_values   STRING
   DEFINE l_items    STRING
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
   DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004
   LET l_values = NULL
   LET l_items = NULL
   LET l_gzcb002 = NULL
   LET l_gzcbl004 = NULL
   
   DECLARE aprt502_gzcb_cs1 CURSOR FOR
    SELECT gzcb002,gzcbl004 FROM gzcb_t,gzcbl_t
     WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
       AND gzcb001 = '6517'   AND gzcbl003 = g_dlang
       AND gzcb002 IN ('4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L')
     ORDER BY gzcb001
   FOREACH aprt502_gzcb_cs1 INTO l_gzcb002,l_gzcbl004
      LET l_values = l_values CLIPPED ,",",l_gzcb002
      LET l_items  = l_items CLIPPED ,",",l_gzcb002 CLIPPED,':',l_gzcbl004
   END FOREACH
   CALL cl_set_combo_items("prff002",l_values,l_items)
END FUNCTION

#insert prff_t
PRIVATE FUNCTION aprt502_ins_prff()
   DEFINE l_sql      STRING
   DEFINE l_success  LIKE type_t.num5
   LET l_success= TRUE
   IF g_prfe_m.prfe001='U' AND (NOT cl_null(g_prfe_m.prfe002)) THEN
      DELETE FROM prff_t WHERE prffent=g_enterprise AND prffdocno=g_prfe_m.prfedocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del prff_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success= FALSE
         RETURN l_success
      END IF
      LET l_sql=" INSERT INTO prff_t (prffent,prffunit,prffsite,prffdocno,prff001,prff002,prff003,prffacti) ",
                " SELECT ",g_enterprise,",'",g_prfe_m.prfeunit,"','",g_prfe_m.prfesite,"','",g_prfe_m.prfedocno,"',",
                "         prfh002,prfh003,prfh004,prfhstus ",
                "   FROM prfh_t ",
                "  WHERE prfhent=",g_enterprise," AND prfh001='",g_prfe_m.prfe002,"' "
      PREPARE l_sql_prff_pre FROM l_sql
      EXECUTE l_sql_prff_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins prff_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_success=false
         RETURN l_success
      END IF      
   END IF
   RETURN l_success
END FUNCTION

#fill imaa_t
PRIVATE FUNCTION aprt502_fill()
   DEFINE l_sql      STRING
   DEFINE l_sql2     STRING
   DEFINE l_sql3     STRING
   DEFINE l_sql4     STRING
   DEFINE l_prff001  LIKE prff_t.prff001
   DEFINE l_prff002  LIKE prff_t.prff002
   DEFINE l_prff003  LIKE prff_t.prff003                    
                        
   
   CALL g_imaa_d.clear()
   LET l_sql = " SELECT distinct imaa001,imaal003,imaal004,imaa009 ",
               "   FROM imaa_t LEFT JOIN imaal_t ON imaa001=imaal001 AND imaaent=imaalent AND imaal002='",g_dlang,"' ",
               "  WHERE imaaent=",g_enterprise," AND imaastus='Y' "
   let l_sql2 = " SELECT DISTINCT prff001 FROM prff_t WHERE prffent=",g_enterprise," AND prffdocno='",g_prfe_m.prfedocno,"' AND prffacti='Y' " 

 
   PREPARE l_sql2_prff001_pre FROM l_sql2
   DECLARE l_sql2_prff001_cs CURSOR FOR  l_sql2_prff001_pre
   let l_sql3 = " SELECT DISTINCT prff002 FROM prff_t WHERE prffent=",g_enterprise," AND prffdocno='",g_prfe_m.prfedocno,"' ",
                "    AND prff001=? AND prffacti='Y' "
   PREPARE l_sql3_prff002_pre FROM l_sql3
   DECLARE l_sql3_prff002_cs CURSOR FOR  l_sql3_prff002_pre 
   let l_sql4 = " SELECT DISTINCT prff003 FROM prff_t WHERE prffent=",g_enterprise," AND prffdocno='",g_prfe_m.prfedocno,"' ",
                "    AND prff001=? AND prff002=? AND prffacti='Y' " 
   PREPARE l_sql4_prff003_pre FROM l_sql4
   DECLARE l_sql4_prff003_cs CURSOR FOR  l_sql4_prff003_pre
   LET l_sql4="1<>1"
   LET l_sql3="1=1"
   LET l_sql2="1<>1"
   FOREACH  l_sql2_prff001_cs INTO l_prff001
      FOREACH l_sql3_prff002_cs USING l_prff001 INTO l_prff002
         FOREACH l_sql4_prff003_cs USING l_prff001,l_prff002 INTO l_prff003
            CASE l_prff002
               WHEN '4'
                  LET l_sql4 = l_sql4," OR imaa001='",l_prff003,"' " 
               WHEN '5'
                  LET l_sql4 = l_sql4," OR imaa009='",l_prff003,"' "
               WHEN '6'
                  LET l_sql4 = l_sql4," OR imaa122='",l_prff003,"' "
               WHEN '7'
                  LET l_sql4 = l_sql4," OR imaa131='",l_prff003,"' "
               WHEN '8'
                  LET l_sql4 = l_sql4," OR imaa126='",l_prff003,"' "
               WHEN '9'
                  LET l_sql4 = l_sql4," OR imaa127='",l_prff003,"' "
               WHEN 'A'
                  LET l_sql4 = l_sql4," OR imaa128='",l_prff003,"' "
               WHEN 'B'
                  LET l_sql4 = l_sql4," OR imaa129='",l_prff003,"' "
               WHEN 'C'
                  LET l_sql4 = l_sql4," OR imaa132='",l_prff003,"' "
               WHEN 'D'
                  LET l_sql4 = l_sql4," OR imaa133='",l_prff003,"' "
               WHEN 'E'
                  LET l_sql4 = l_sql4," OR imaa134='",l_prff003,"' "
               WHEN 'F'
                  LET l_sql4 = l_sql4," OR imaa135='",l_prff003,"' "
               WHEN 'G'
                  LET l_sql4 = l_sql4," OR imaa136='",l_prff003,"' "
               WHEN 'H'
                  LET l_sql4 = l_sql4," OR imaa137='",l_prff003,"' "
               WHEN 'I'
                  LET l_sql4 = l_sql4," OR imaa138='",l_prff003,"' "
               WHEN 'J'
                  LET l_sql4 = l_sql4," OR imaa139='",l_prff003,"' "
               WHEN 'K'
                  LET l_sql4 = l_sql4," OR imaa140='",l_prff003,"' "
               WHEN 'L'
                  LET l_sql4 = l_sql4," OR imaa141='",l_prff003,"' "
         
            END CASE
            LET l_prff003=null
         END FOREACH
         LET l_sql3 = l_sql3," AND (",l_sql4,") "
         LET l_sql4="1<>1"
         LET l_prff002=null
      END FOREACH
      LET l_sql2 = l_sql2," OR (",l_sql3,") "
      LET l_sql3="1=1"
      LET l_prff002=null 
   END FOREACH
      
   LET l_sql = l_sql," AND ( ",l_sql2," )"  
   LET l_sql = l_sql,"  ORDER BY imaa001 "    
   PREPARE l_sql_pre FROM l_sql
   DECLARE l_sql_cs CURSOR FOR l_sql_pre
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH l_sql_cs INTO g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].imaal003,g_imaa_d[l_ac].imaal004,g_imaa_d[l_ac].imaa009
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
   
   CALL g_imaa_d.deleteElement(g_imaa_d.getLength())
 
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE l_sql_cs
END FUNCTION

 
{</section>}
 
