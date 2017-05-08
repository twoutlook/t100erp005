#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt131.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0020(2015-07-16 14:31:28), PR版次:0020(2016-10-31 17:22:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000277
#+ Filename...: aprt131
#+ Description: 門店商品捆綁維護作業
#+ Creator....: 02296(2014-03-12 18:40:07)
#+ Modifier...: 02003 -SD/PR- 06137
 
{</section>}
 
{<section id="aprt131.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...:   No.160318-00025#32  2016/04/12  By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)]
#  Modify.....:   NO.160818-00017#30  2016/08/25  By 08742     删除修改未重新判断状态码
#  Modify.....:   NO.160905-00007#12  2016/09/05  by 08742     调整系统中无ENT的SQL条件增加ent
#  Modify.....:   NO.160824-00007#133 2016/10/31  By 06137     修正舊值備份寫法
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
PRIVATE type type_g_prbo_m        RECORD
       prbosite LIKE prbo_t.prbosite, 
   prbosite_desc LIKE type_t.chr80, 
   prbodocdt LIKE prbo_t.prbodocdt, 
   prbodocno LIKE prbo_t.prbodocno, 
   prbo001 LIKE prbo_t.prbo001, 
   prbo001_desc LIKE type_t.chr80, 
   prbo002 LIKE prbo_t.prbo002, 
   prbo003 LIKE prbo_t.prbo003, 
   prbounit LIKE prbo_t.prbounit, 
   prbo004 LIKE prbo_t.prbo004, 
   prbo005 LIKE prbo_t.prbo005, 
   prbo006 LIKE prbo_t.prbo006, 
   prbo007 LIKE prbo_t.prbo007, 
   prbo007_desc LIKE type_t.chr80, 
   prbo015 LIKE prbo_t.prbo015, 
   prbo015_desc LIKE type_t.chr80, 
   prbo014 LIKE prbo_t.prbo014, 
   prbo008 LIKE prbo_t.prbo008, 
   prbo009 LIKE prbo_t.prbo009, 
   prbo010 LIKE prbo_t.prbo010, 
   prbo011 LIKE prbo_t.prbo011, 
   prbo012 LIKE prbo_t.prbo012, 
   prbo012_desc LIKE type_t.chr80, 
   prbo013 LIKE prbo_t.prbo013, 
   prbo013_desc LIKE type_t.chr80, 
   prbostus LIKE prbo_t.prbostus, 
   prboownid LIKE prbo_t.prboownid, 
   prboownid_desc LIKE type_t.chr80, 
   prboowndp LIKE prbo_t.prboowndp, 
   prboowndp_desc LIKE type_t.chr80, 
   prbocrtid LIKE prbo_t.prbocrtid, 
   prbocrtid_desc LIKE type_t.chr80, 
   prbocrtdp LIKE prbo_t.prbocrtdp, 
   prbocrtdp_desc LIKE type_t.chr80, 
   prbocrtdt LIKE prbo_t.prbocrtdt, 
   prbomodid LIKE prbo_t.prbomodid, 
   prbomodid_desc LIKE type_t.chr80, 
   prbomoddt LIKE prbo_t.prbomoddt, 
   prbocnfid LIKE prbo_t.prbocnfid, 
   prbocnfid_desc LIKE type_t.chr80, 
   prbocnfdt LIKE prbo_t.prbocnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prbp_d        RECORD
       prbpseq LIKE prbp_t.prbpseq, 
   prbp001 LIKE prbp_t.prbp001, 
   prbp002 LIKE prbp_t.prbp002, 
   prbp003 LIKE prbp_t.prbp003, 
   imaal003 LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr10, 
   imaa009_desc LIKE type_t.chr500, 
   prbp004 LIKE prbp_t.prbp004, 
   prbp004_desc LIKE type_t.chr500, 
   prbp005 LIKE prbp_t.prbp005, 
   prbp006 LIKE prbp_t.prbp006, 
   prbp007 LIKE prbp_t.prbp007, 
   prbp008 LIKE prbp_t.prbp008, 
   prbp009 LIKE prbp_t.prbp009, 
   prbp010 LIKE prbp_t.prbp010, 
   prbpsite LIKE prbp_t.prbpsite, 
   prbpunit LIKE prbp_t.prbpunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prbosite LIKE prbo_t.prbosite,
   b_prbosite_desc LIKE type_t.chr80,
      b_prbodocdt LIKE prbo_t.prbodocdt,
      b_prbodocno LIKE prbo_t.prbodocno,
      b_prbo001 LIKE prbo_t.prbo001,
   b_prbo001_desc LIKE type_t.chr80,
      b_prbo002 LIKE prbo_t.prbo002,
      b_prbo003 LIKE prbo_t.prbo003,
      b_prbo004 LIKE prbo_t.prbo004,
      b_prbo005 LIKE prbo_t.prbo005,
      b_prbo006 LIKE prbo_t.prbo006,
      b_prbo007 LIKE prbo_t.prbo007,
   b_prbo007_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004 
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prbo_m          type_g_prbo_m
DEFINE g_prbo_m_t        type_g_prbo_m
DEFINE g_prbo_m_o        type_g_prbo_m
DEFINE g_prbo_m_mask_o   type_g_prbo_m #轉換遮罩前資料
DEFINE g_prbo_m_mask_n   type_g_prbo_m #轉換遮罩後資料
 
   DEFINE g_prbodocno_t LIKE prbo_t.prbodocno
 
 
DEFINE g_prbp_d          DYNAMIC ARRAY OF type_g_prbp_d
DEFINE g_prbp_d_t        type_g_prbp_d
DEFINE g_prbp_d_o        type_g_prbp_d
DEFINE g_prbp_d_mask_o   DYNAMIC ARRAY OF type_g_prbp_d #轉換遮罩前資料
DEFINE g_prbp_d_mask_n   DYNAMIC ARRAY OF type_g_prbp_d #轉換遮罩後資料
 
 
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
 
{<section id="aprt131.main" >}
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
   LET g_forupd_sql = " SELECT prbosite,'',prbodocdt,prbodocno,prbo001,'',prbo002,prbo003,prbounit,prbo004, 
       prbo005,prbo006,prbo007,'',prbo015,'',prbo014,prbo008,prbo009,prbo010,prbo011,prbo012,'',prbo013, 
       '',prbostus,prboownid,'',prboowndp,'',prbocrtid,'',prbocrtdp,'',prbocrtdt,prbomodid,'',prbomoddt, 
       prbocnfid,'',prbocnfdt", 
                      " FROM prbo_t",
                      " WHERE prboent= ? AND prbodocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt131_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prbosite,t0.prbodocdt,t0.prbodocno,t0.prbo001,t0.prbo002,t0.prbo003, 
       t0.prbounit,t0.prbo004,t0.prbo005,t0.prbo006,t0.prbo007,t0.prbo015,t0.prbo014,t0.prbo008,t0.prbo009, 
       t0.prbo010,t0.prbo011,t0.prbo012,t0.prbo013,t0.prbostus,t0.prboownid,t0.prboowndp,t0.prbocrtid, 
       t0.prbocrtdp,t0.prbocrtdt,t0.prbomodid,t0.prbomoddt,t0.prbocnfid,t0.prbocnfdt,t1.ooefl003 ,t2.rtaxl003 , 
       t3.oocal003 ,t4.oodbl004 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 , 
       t11.ooag011 ,t12.ooag011",
               " FROM prbo_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.prbo001 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.prbo007 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oodbl_t t4 ON t4.oodblent="||g_enterprise||" AND t4.oodbl002=t0.prbo015 AND t4.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.prbo012  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.prbo013 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.prboownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.prboowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prbocrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.prbocrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prbomodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.prbocnfid  ",
 
               " WHERE t0.prboent = " ||g_enterprise|| " AND t0.prbodocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt131_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt131 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt131_init()   
 
      #進入選單 Menu (="N")
      CALL aprt131_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt131
      
   END IF 
   
   CLOSE aprt131_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt131.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt131_init()
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
      CALL cl_set_combo_scc_part('prbostus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
   
   #初始化搜尋條件
   CALL aprt131_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt131.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt131_ui_dialog()
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
            CALL aprt131_insert()
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
         INITIALIZE g_prbo_m.* TO NULL
         CALL g_prbp_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt131_init()
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
               
               CALL aprt131_fetch('') # reload data
               LET l_ac = 1
               CALL aprt131_ui_detailshow() #Setting the current row 
         
               CALL aprt131_idx_chk()
               #NEXT FIELD prbpseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prbp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt131_idx_chk()
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
               CALL aprt131_idx_chk()
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
            CALL aprt131_browser_fill("")
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
               CALL aprt131_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt131_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt131_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt131_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt131_set_act_visible()   
            CALL aprt131_set_act_no_visible()
            IF NOT (g_prbo_m.prbodocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prboent = " ||g_enterprise|| " AND",
                                  " prbodocno = '", g_prbo_m.prbodocno, "' "
 
               #填到對應位置
               CALL aprt131_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prbo_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbp_t" 
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
               CALL aprt131_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prbo_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbp_t" 
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
                  CALL aprt131_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt131_fetch("F")
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
               CALL aprt131_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt131_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt131_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt131_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt131_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt131_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt131_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt131_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt131_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt131_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt131_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prbp_d)
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
               NEXT FIELD prbpseq
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
               CALL aprt131_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt131_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt131_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt131_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt131_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt131_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aprt131_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt131_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt131_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt131_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt131_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prbo_m.prbodocdt)
 
 
 
         
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
 
{<section id="aprt131.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt131_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prbosite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim() 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prbodocno ",
                      " FROM prbo_t ",
                      " ",
                      " LEFT JOIN prbp_t ON prbpent = prboent AND prbodocno = prbpdocno ", "  ",
                      #add-point:browser_fill段sql(prbp_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE prboent = " ||g_enterprise|| " AND prbpent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prbo_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prbodocno ",
                      " FROM prbo_t ", 
                      "  ",
                      "  ",
                      " WHERE prboent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prbo_t")
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
      INITIALIZE g_prbo_m.* TO NULL
      CALL g_prbp_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prbosite,t0.prbodocdt,t0.prbodocno,t0.prbo001,t0.prbo002,t0.prbo003,t0.prbo004,t0.prbo005,t0.prbo006,t0.prbo007 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prbostus,t0.prbosite,t0.prbodocdt,t0.prbodocno,t0.prbo001,t0.prbo002, 
          t0.prbo003,t0.prbo004,t0.prbo005,t0.prbo006,t0.prbo007,t1.ooefl003 ,t2.rtaxl003 ,t3.oocal003 ", 
 
                  " FROM prbo_t t0",
                  "  ",
                  "  LEFT JOIN prbp_t ON prbpent = prboent AND prbodocno = prbpdocno ", "  ", 
                  #add-point:browser_fill段sql(prbp_t1) name="browser_fill.join.prbp_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.prbo001 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.prbo007 AND t3.oocal002='"||g_dlang||"' ",
 
                  " WHERE t0.prboent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prbo_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prbostus,t0.prbosite,t0.prbodocdt,t0.prbodocno,t0.prbo001,t0.prbo002, 
          t0.prbo003,t0.prbo004,t0.prbo005,t0.prbo006,t0.prbo007,t1.ooefl003 ,t2.rtaxl003 ,t3.oocal003 ", 
 
                  " FROM prbo_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.prbo001 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.prbo007 AND t3.oocal002='"||g_dlang||"' ",
 
                  " WHERE t0.prboent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prbo_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prbodocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prbo_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prbosite,g_browser[g_cnt].b_prbodocdt, 
          g_browser[g_cnt].b_prbodocno,g_browser[g_cnt].b_prbo001,g_browser[g_cnt].b_prbo002,g_browser[g_cnt].b_prbo003, 
          g_browser[g_cnt].b_prbo004,g_browser[g_cnt].b_prbo005,g_browser[g_cnt].b_prbo006,g_browser[g_cnt].b_prbo007, 
          g_browser[g_cnt].b_prbosite_desc,g_browser[g_cnt].b_prbo001_desc,g_browser[g_cnt].b_prbo007_desc 
 
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
         CALL aprt131_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prbodocno) THEN
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
 
{<section id="aprt131.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt131_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prbo_m.prbodocno = g_browser[g_current_idx].b_prbodocno   
 
   EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
       g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
       g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
       g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
       g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
       g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
       g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
   
   CALL aprt131_prbo_t_mask()
   CALL aprt131_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt131.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt131_ui_detailshow()
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
 
{<section id="aprt131.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt131_ui_browser_refresh()
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
      IF g_browser[l_i].b_prbodocno = g_prbo_m.prbodocno 
 
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
 
{<section id="aprt131.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt131_construct()
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
   INITIALIZE g_prbo_m.* TO NULL
   CALL g_prbp_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON prbosite,prbodocdt,prbodocno,prbo001,prbo002,prbo003,prbounit,prbo004, 
          prbo005,prbo006,prbo007,prbo015,prbo014,prbo008,prbo009,prbo010,prbo011,prbo012,prbo013,prbostus, 
          prboownid,prboowndp,prbocrtid,prbocrtdp,prbocrtdt,prbomodid,prbomoddt,prbocnfid,prbocnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbocrtdt>>----
         AFTER FIELD prbocrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbomoddt>>----
         AFTER FIELD prbomoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbocnfdt>>----
         AFTER FIELD prbocnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbopstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prbosite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbosite
            #add-point:ON ACTION controlp INFIELD prbosite name="construct.c.prbosite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#			LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbosite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prbosite  #顯示到畫面上

            NEXT FIELD prbosite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbosite
            #add-point:BEFORE FIELD prbosite name="construct.b.prbosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbosite
            
            #add-point:AFTER FIELD prbosite name="construct.a.prbosite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbodocdt
            #add-point:BEFORE FIELD prbodocdt name="construct.b.prbodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbodocdt
            
            #add-point:AFTER FIELD prbodocdt name="construct.a.prbodocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbodocdt
            #add-point:ON ACTION controlp INFIELD prbodocdt name="construct.c.prbodocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbodocno
            #add-point:ON ACTION controlp INFIELD prbodocno name="construct.c.prbodocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_prbodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbodocno  #顯示到畫面上

            NEXT FIELD prbodocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbodocno
            #add-point:BEFORE FIELD prbodocno name="construct.b.prbodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbodocno
            
            #add-point:AFTER FIELD prbodocno name="construct.a.prbodocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo001
            #add-point:ON ACTION controlp INFIELD prbo001 name="construct.c.prbo001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbo001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO rtax001 #品類編號 

            NEXT FIELD prbo001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo001
            #add-point:BEFORE FIELD prbo001 name="construct.b.prbo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo001
            
            #add-point:AFTER FIELD prbo001 name="construct.a.prbo001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo002
            #add-point:BEFORE FIELD prbo002 name="construct.b.prbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo002
            
            #add-point:AFTER FIELD prbo002 name="construct.a.prbo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo002
            #add-point:ON ACTION controlp INFIELD prbo002 name="construct.c.prbo002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo003
            #add-point:BEFORE FIELD prbo003 name="construct.b.prbo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo003
            
            #add-point:AFTER FIELD prbo003 name="construct.a.prbo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo003
            #add-point:ON ACTION controlp INFIELD prbo003 name="construct.c.prbo003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbounit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbounit
            #add-point:ON ACTION controlp INFIELD prbounit name="construct.c.prbounit"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbounit  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD prbounit                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbounit
            #add-point:BEFORE FIELD prbounit name="construct.b.prbounit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbounit
            
            #add-point:AFTER FIELD prbounit name="construct.a.prbounit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo004
            #add-point:BEFORE FIELD prbo004 name="construct.b.prbo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo004
            
            #add-point:AFTER FIELD prbo004 name="construct.a.prbo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo004
            #add-point:ON ACTION controlp INFIELD prbo004 name="construct.c.prbo004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo005
            #add-point:BEFORE FIELD prbo005 name="construct.b.prbo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo005
            
            #add-point:AFTER FIELD prbo005 name="construct.a.prbo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo005
            #add-point:ON ACTION controlp INFIELD prbo005 name="construct.c.prbo005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo006
            #add-point:BEFORE FIELD prbo006 name="construct.b.prbo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo006
            
            #add-point:AFTER FIELD prbo006 name="construct.a.prbo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo006
            #add-point:ON ACTION controlp INFIELD prbo006 name="construct.c.prbo006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo007
            #add-point:ON ACTION controlp INFIELD prbo007 name="construct.c.prbo007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbo007  #顯示到畫面上

            NEXT FIELD prbo007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo007
            #add-point:BEFORE FIELD prbo007 name="construct.b.prbo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo007
            
            #add-point:AFTER FIELD prbo007 name="construct.a.prbo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo015
            #add-point:ON ACTION controlp INFIELD prbo015 name="construct.c.prbo015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbo015  #顯示到畫面上
            NEXT FIELD prbo015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo015
            #add-point:BEFORE FIELD prbo015 name="construct.b.prbo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo015
            
            #add-point:AFTER FIELD prbo015 name="construct.a.prbo015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo014
            #add-point:BEFORE FIELD prbo014 name="construct.b.prbo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo014
            
            #add-point:AFTER FIELD prbo014 name="construct.a.prbo014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo014
            #add-point:ON ACTION controlp INFIELD prbo014 name="construct.c.prbo014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo008
            #add-point:BEFORE FIELD prbo008 name="construct.b.prbo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo008
            
            #add-point:AFTER FIELD prbo008 name="construct.a.prbo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo008
            #add-point:ON ACTION controlp INFIELD prbo008 name="construct.c.prbo008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo009
            #add-point:BEFORE FIELD prbo009 name="construct.b.prbo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo009
            
            #add-point:AFTER FIELD prbo009 name="construct.a.prbo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo009
            #add-point:ON ACTION controlp INFIELD prbo009 name="construct.c.prbo009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo010
            #add-point:BEFORE FIELD prbo010 name="construct.b.prbo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo010
            
            #add-point:AFTER FIELD prbo010 name="construct.a.prbo010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo010
            #add-point:ON ACTION controlp INFIELD prbo010 name="construct.c.prbo010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo011
            #add-point:BEFORE FIELD prbo011 name="construct.b.prbo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo011
            
            #add-point:AFTER FIELD prbo011 name="construct.a.prbo011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo011
            #add-point:ON ACTION controlp INFIELD prbo011 name="construct.c.prbo011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbo012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo012
            #add-point:ON ACTION controlp INFIELD prbo012 name="construct.c.prbo012"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbo012  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooag003 #歸屬部門 
               #DISPLAY g_qryparam.return3 TO oofa011 #全名 
               #DISPLAY g_qryparam.return4 TO ooefl003 #說明(簡稱) 

            NEXT FIELD prbo012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo012
            #add-point:BEFORE FIELD prbo012 name="construct.b.prbo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo012
            
            #add-point:AFTER FIELD prbo012 name="construct.a.prbo012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbo013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo013
            #add-point:ON ACTION controlp INFIELD prbo013 name="construct.c.prbo013"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbo013  #顯示到畫面上

            NEXT FIELD prbo013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo013
            #add-point:BEFORE FIELD prbo013 name="construct.b.prbo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo013
            
            #add-point:AFTER FIELD prbo013 name="construct.a.prbo013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbostus
            #add-point:BEFORE FIELD prbostus name="construct.b.prbostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbostus
            
            #add-point:AFTER FIELD prbostus name="construct.a.prbostus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbostus
            #add-point:ON ACTION controlp INFIELD prbostus name="construct.c.prbostus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prboownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prboownid
            #add-point:ON ACTION controlp INFIELD prboownid name="construct.c.prboownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prboownid  #顯示到畫面上

            NEXT FIELD prboownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prboownid
            #add-point:BEFORE FIELD prboownid name="construct.b.prboownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prboownid
            
            #add-point:AFTER FIELD prboownid name="construct.a.prboownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prboowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prboowndp
            #add-point:ON ACTION controlp INFIELD prboowndp name="construct.c.prboowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prboowndp  #顯示到畫面上

            NEXT FIELD prboowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prboowndp
            #add-point:BEFORE FIELD prboowndp name="construct.b.prboowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prboowndp
            
            #add-point:AFTER FIELD prboowndp name="construct.a.prboowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbocrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbocrtid
            #add-point:ON ACTION controlp INFIELD prbocrtid name="construct.c.prbocrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbocrtid  #顯示到畫面上

            NEXT FIELD prbocrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbocrtid
            #add-point:BEFORE FIELD prbocrtid name="construct.b.prbocrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbocrtid
            
            #add-point:AFTER FIELD prbocrtid name="construct.a.prbocrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbocrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbocrtdp
            #add-point:ON ACTION controlp INFIELD prbocrtdp name="construct.c.prbocrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbocrtdp  #顯示到畫面上

            NEXT FIELD prbocrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbocrtdp
            #add-point:BEFORE FIELD prbocrtdp name="construct.b.prbocrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbocrtdp
            
            #add-point:AFTER FIELD prbocrtdp name="construct.a.prbocrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbocrtdt
            #add-point:BEFORE FIELD prbocrtdt name="construct.b.prbocrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbomodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbomodid
            #add-point:ON ACTION controlp INFIELD prbomodid name="construct.c.prbomodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbomodid  #顯示到畫面上

            NEXT FIELD prbomodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbomodid
            #add-point:BEFORE FIELD prbomodid name="construct.b.prbomodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbomodid
            
            #add-point:AFTER FIELD prbomodid name="construct.a.prbomodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbomoddt
            #add-point:BEFORE FIELD prbomoddt name="construct.b.prbomoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbocnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbocnfid
            #add-point:ON ACTION controlp INFIELD prbocnfid name="construct.c.prbocnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbocnfid  #顯示到畫面上

            NEXT FIELD prbocnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbocnfid
            #add-point:BEFORE FIELD prbocnfid name="construct.b.prbocnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbocnfid
            
            #add-point:AFTER FIELD prbocnfid name="construct.a.prbocnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbocnfdt
            #add-point:BEFORE FIELD prbocnfdt name="construct.b.prbocnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prbpseq,prbp001,prbp002,prbp003,prbp004,prbp005,prbp006,prbp007,prbp008, 
          prbp009,prbp010,prbpsite,prbpunit
           FROM s_detail1[1].prbpseq,s_detail1[1].prbp001,s_detail1[1].prbp002,s_detail1[1].prbp003, 
               s_detail1[1].prbp004,s_detail1[1].prbp005,s_detail1[1].prbp006,s_detail1[1].prbp007,s_detail1[1].prbp008, 
               s_detail1[1].prbp009,s_detail1[1].prbp010,s_detail1[1].prbpsite,s_detail1[1].prbpunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbpseq
            #add-point:BEFORE FIELD prbpseq name="construct.b.page1.prbpseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbpseq
            
            #add-point:AFTER FIELD prbpseq name="construct.a.page1.prbpseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbpseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbpseq
            #add-point:ON ACTION controlp INFIELD prbpseq name="construct.c.page1.prbpseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbp001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp001
            #add-point:ON ACTION controlp INFIELD prbp001 name="construct.c.page1.prbp001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtdx001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbp001  #顯示到畫面上

            NEXT FIELD prbp001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp001
            #add-point:BEFORE FIELD prbp001 name="construct.b.page1.prbp001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp001
            
            #add-point:AFTER FIELD prbp001 name="construct.a.page1.prbp001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp002
            #add-point:ON ACTION controlp INFIELD prbp002 name="construct.c.page1.prbp002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtdx002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbp002  #顯示到畫面上

            NEXT FIELD prbp002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp002
            #add-point:BEFORE FIELD prbp002 name="construct.b.page1.prbp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp002
            
            #add-point:AFTER FIELD prbp002 name="construct.a.page1.prbp002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp003
            #add-point:BEFORE FIELD prbp003 name="construct.b.page1.prbp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp003
            
            #add-point:AFTER FIELD prbp003 name="construct.a.page1.prbp003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp003
            #add-point:ON ACTION controlp INFIELD prbp003 name="construct.c.page1.prbp003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp004
            #add-point:ON ACTION controlp INFIELD prbp004 name="construct.c.page1.prbp004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbp004  #顯示到畫面上

            NEXT FIELD prbp004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp004
            #add-point:BEFORE FIELD prbp004 name="construct.b.page1.prbp004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp004
            
            #add-point:AFTER FIELD prbp004 name="construct.a.page1.prbp004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp005
            #add-point:BEFORE FIELD prbp005 name="construct.b.page1.prbp005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp005
            
            #add-point:AFTER FIELD prbp005 name="construct.a.page1.prbp005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp005
            #add-point:ON ACTION controlp INFIELD prbp005 name="construct.c.page1.prbp005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp006
            #add-point:BEFORE FIELD prbp006 name="construct.b.page1.prbp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp006
            
            #add-point:AFTER FIELD prbp006 name="construct.a.page1.prbp006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp006
            #add-point:ON ACTION controlp INFIELD prbp006 name="construct.c.page1.prbp006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp007
            #add-point:BEFORE FIELD prbp007 name="construct.b.page1.prbp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp007
            
            #add-point:AFTER FIELD prbp007 name="construct.a.page1.prbp007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp007
            #add-point:ON ACTION controlp INFIELD prbp007 name="construct.c.page1.prbp007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp008
            #add-point:BEFORE FIELD prbp008 name="construct.b.page1.prbp008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp008
            
            #add-point:AFTER FIELD prbp008 name="construct.a.page1.prbp008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp008
            #add-point:ON ACTION controlp INFIELD prbp008 name="construct.c.page1.prbp008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp009
            #add-point:BEFORE FIELD prbp009 name="construct.b.page1.prbp009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp009
            
            #add-point:AFTER FIELD prbp009 name="construct.a.page1.prbp009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp009
            #add-point:ON ACTION controlp INFIELD prbp009 name="construct.c.page1.prbp009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp010
            #add-point:BEFORE FIELD prbp010 name="construct.b.page1.prbp010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp010
            
            #add-point:AFTER FIELD prbp010 name="construct.a.page1.prbp010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbp010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp010
            #add-point:ON ACTION controlp INFIELD prbp010 name="construct.c.page1.prbp010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbpsite
            #add-point:BEFORE FIELD prbpsite name="construct.b.page1.prbpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbpsite
            
            #add-point:AFTER FIELD prbpsite name="construct.a.page1.prbpsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbpsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbpsite
            #add-point:ON ACTION controlp INFIELD prbpsite name="construct.c.page1.prbpsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbpunit
            #add-point:BEFORE FIELD prbpunit name="construct.b.page1.prbpunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbpunit
            
            #add-point:AFTER FIELD prbpunit name="construct.a.page1.prbpunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbpunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbpunit
            #add-point:ON ACTION controlp INFIELD prbpunit name="construct.c.page1.prbpunit"
            
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
                  WHEN la_wc[li_idx].tableid = "prbo_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prbp_t" 
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
 
{<section id="aprt131.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt131_filter()
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
      CONSTRUCT g_wc_filter ON prbosite,prbodocdt,prbodocno,prbo001,prbo002,prbo003,prbo004,prbo005, 
          prbo006,prbo007
                          FROM s_browse[1].b_prbosite,s_browse[1].b_prbodocdt,s_browse[1].b_prbodocno, 
                              s_browse[1].b_prbo001,s_browse[1].b_prbo002,s_browse[1].b_prbo003,s_browse[1].b_prbo004, 
                              s_browse[1].b_prbo005,s_browse[1].b_prbo006,s_browse[1].b_prbo007
 
         BEFORE CONSTRUCT
               DISPLAY aprt131_filter_parser('prbosite') TO s_browse[1].b_prbosite
            DISPLAY aprt131_filter_parser('prbodocdt') TO s_browse[1].b_prbodocdt
            DISPLAY aprt131_filter_parser('prbodocno') TO s_browse[1].b_prbodocno
            DISPLAY aprt131_filter_parser('prbo001') TO s_browse[1].b_prbo001
            DISPLAY aprt131_filter_parser('prbo002') TO s_browse[1].b_prbo002
            DISPLAY aprt131_filter_parser('prbo003') TO s_browse[1].b_prbo003
            DISPLAY aprt131_filter_parser('prbo004') TO s_browse[1].b_prbo004
            DISPLAY aprt131_filter_parser('prbo005') TO s_browse[1].b_prbo005
            DISPLAY aprt131_filter_parser('prbo006') TO s_browse[1].b_prbo006
            DISPLAY aprt131_filter_parser('prbo007') TO s_browse[1].b_prbo007
      
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
 
      CALL aprt131_filter_show('prbosite')
   CALL aprt131_filter_show('prbodocdt')
   CALL aprt131_filter_show('prbodocno')
   CALL aprt131_filter_show('prbo001')
   CALL aprt131_filter_show('prbo002')
   CALL aprt131_filter_show('prbo003')
   CALL aprt131_filter_show('prbo004')
   CALL aprt131_filter_show('prbo005')
   CALL aprt131_filter_show('prbo006')
   CALL aprt131_filter_show('prbo007')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt131_filter_parser(ps_field)
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
 
{<section id="aprt131.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt131_filter_show(ps_field)
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
   LET ls_condition = aprt131_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt131_query()
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
   CALL g_prbp_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt131_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt131_browser_fill("")
      CALL aprt131_fetch("")
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
      CALL aprt131_filter_show('prbosite')
   CALL aprt131_filter_show('prbodocdt')
   CALL aprt131_filter_show('prbodocno')
   CALL aprt131_filter_show('prbo001')
   CALL aprt131_filter_show('prbo002')
   CALL aprt131_filter_show('prbo003')
   CALL aprt131_filter_show('prbo004')
   CALL aprt131_filter_show('prbo005')
   CALL aprt131_filter_show('prbo006')
   CALL aprt131_filter_show('prbo007')
   CALL aprt131_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt131_fetch("F") 
      #顯示單身筆數
      CALL aprt131_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt131_fetch(p_flag)
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
   
   LET g_prbo_m.prbodocno = g_browser[g_current_idx].b_prbodocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
       g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
       g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
       g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
       g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
       g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
       g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
   
   #遮罩相關處理
   LET g_prbo_m_mask_o.* =  g_prbo_m.*
   CALL aprt131_prbo_t_mask()
   LET g_prbo_m_mask_n.* =  g_prbo_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt131_set_act_visible()   
   CALL aprt131_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_prbo_m.prbostus<>'N' THEN
#      CALL cl_set_act_visible("modify,delete",false)
#   ELSE
#      CALL cl_set_act_visible("modify,delete",true)
#   END IF
   IF g_prbo_m.prbostus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prbo_m_t.* = g_prbo_m.*
   LET g_prbo_m_o.* = g_prbo_m.*
   
   LET g_data_owner = g_prbo_m.prboownid      
   LET g_data_dept  = g_prbo_m.prboowndp
   
   #重新顯示   
   CALL aprt131_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt131_insert()
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
   CALL g_prbp_d.clear()   
 
 
   INITIALIZE g_prbo_m.* TO NULL             #DEFAULT 設定
   
   LET g_prbodocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbo_m.prboownid = g_user
      LET g_prbo_m.prboowndp = g_dept
      LET g_prbo_m.prbocrtid = g_user
      LET g_prbo_m.prbocrtdp = g_dept 
      LET g_prbo_m.prbocrtdt = cl_get_current()
      LET g_prbo_m.prbomodid = g_user
      LET g_prbo_m.prbomoddt = cl_get_current()
      LET g_prbo_m.prbostus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prbo_m.prbo006 = "0"
      LET g_prbo_m.prbo008 = "0"
      LET g_prbo_m.prbo010 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prbosite',g_prbo_m.prbosite)
         RETURNING l_insert,g_prbo_m.prbosite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prbo_m.prbostus = "N"
      LET g_prbo_m.prbounit = g_prbo_m.prbosite
      LET g_prbo_m.prbo002 =g_today
      LET g_prbo_m.prbo003 =g_today
#      LET g_prbo_m.prbosite = g_prbo_m.prbounit
      CALL aprt131_prbosite_ref()
      LET g_prbo_m.prbodocdt = g_today
      LET g_prbo_m.prbo012 = g_user
      CALL aprt131_prbo012_ref()
      call aprt131_prbo012_display() 
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prbo_m.prbosite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prbo_m.prbodocno = r_doctype
      #dongsz--add--end---
            
      LET g_prbo_m_t.* = g_prbo_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prbo_m_t.* = g_prbo_m.*
      LET g_prbo_m_o.* = g_prbo_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbo_m.prbostus 
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
 
 
 
    
      CALL aprt131_input("a")
      
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
         INITIALIZE g_prbo_m.* TO NULL
         INITIALIZE g_prbp_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt131_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prbp_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt131_set_act_visible()   
   CALL aprt131_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prbodocno_t = g_prbo_m.prbodocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prboent = " ||g_enterprise|| " AND",
                      " prbodocno = '", g_prbo_m.prbodocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt131_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt131_cl
   
   CALL aprt131_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
       g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
       g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
       g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
       g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
       g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
       g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
   
   
   #遮罩相關處理
   LET g_prbo_m_mask_o.* =  g_prbo_m.*
   CALL aprt131_prbo_t_mask()
   LET g_prbo_m_mask_n.* =  g_prbo_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbosite_desc,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005, 
       g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo007_desc,g_prbo_m.prbo015,g_prbo_m.prbo015_desc, 
       g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012, 
       g_prbo_m.prbo012_desc,g_prbo_m.prbo013,g_prbo_m.prbo013_desc,g_prbo_m.prbostus,g_prbo_m.prboownid, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid,g_prbo_m.prbocrtid_desc, 
       g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdp_desc,g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomodid_desc, 
       g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfid_desc,g_prbo_m.prbocnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prbo_m.prboownid      
   LET g_data_dept  = g_prbo_m.prboowndp
   
   #功能已完成,通報訊息中心
   CALL aprt131_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt131_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_prbo_m.prbostus MATCHES "[DR]" THEN 
      LET g_prbo_m.prbostus = "N"
   END IF
   IF g_prbo_m.prbostus<>'N' THEN
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prbo_m_t.* = g_prbo_m.*
   LET g_prbo_m_o.* = g_prbo_m.*
   
   IF g_prbo_m.prbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prbodocno_t = g_prbo_m.prbodocno
 
   CALL s_transaction_begin()
   
   OPEN aprt131_cl USING g_enterprise,g_prbo_m.prbodocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt131_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt131_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
       g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
       g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
       g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
       g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
       g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
       g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt131_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prbo_m_mask_o.* =  g_prbo_m.*
   CALL aprt131_prbo_t_mask()
   LET g_prbo_m_mask_n.* =  g_prbo_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aprt131_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_prbodocno_t = g_prbo_m.prbodocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prbo_m.prbomodid = g_user 
LET g_prbo_m.prbomoddt = cl_get_current()
LET g_prbo_m.prbomodid_desc = cl_get_username(g_prbo_m.prbomodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_prbo_m.prbostus MATCHES "[DR]" THEN 
         LET g_prbo_m.prbostus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt131_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prbo_t SET (prbomodid,prbomoddt) = (g_prbo_m.prbomodid,g_prbo_m.prbomoddt)
          WHERE prboent = g_enterprise AND prbodocno = g_prbodocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prbo_m.* = g_prbo_m_t.*
            CALL aprt131_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prbo_m.prbodocno != g_prbo_m_t.prbodocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prbp_t SET prbpdocno = g_prbo_m.prbodocno
 
          WHERE prbpent = g_enterprise AND prbpdocno = g_prbo_m_t.prbodocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prbp_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbp_t:",SQLERRMESSAGE 
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
   CALL aprt131_set_act_visible()   
   CALL aprt131_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prboent = " ||g_enterprise|| " AND",
                      " prbodocno = '", g_prbo_m.prbodocno, "' "
 
   #填到對應位置
   CALL aprt131_browser_fill("")
 
   CLOSE aprt131_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt131_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt131.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt131_input(p_cmd)
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
   DEFINE  l_ooaa002             LIKE ooaa_t.ooaa002
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               STRING
   DEFINE  l_rtax004             LIKE rtax_t.rtax004         #150512-00027#1--add by dongsz
   DEFINE  l_ooef019             LIKE ooef_t.ooef019
   DEFINE  l_prbp001             LIKE prbp_t.prbp001
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
   DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbosite_desc,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005, 
       g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo007_desc,g_prbo_m.prbo015,g_prbo_m.prbo015_desc, 
       g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012, 
       g_prbo_m.prbo012_desc,g_prbo_m.prbo013,g_prbo_m.prbo013_desc,g_prbo_m.prbostus,g_prbo_m.prboownid, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid,g_prbo_m.prbocrtid_desc, 
       g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdp_desc,g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomodid_desc, 
       g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfid_desc,g_prbo_m.prbocnfdt
   
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
   LET g_forupd_sql = "SELECT prbpseq,prbp001,prbp002,prbp003,prbp004,prbp005,prbp006,prbp007,prbp008, 
       prbp009,prbp010,prbpsite,prbpunit FROM prbp_t WHERE prbpent=? AND prbpdocno=? AND prbpseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt131_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt131_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt131_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002, 
       g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007, 
       g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011, 
       g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus
   
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
 
{<section id="aprt131.input.head" >}
      #單頭段
      INPUT BY NAME g_prbo_m.prbosite,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002, 
          g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007, 
          g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011, 
          g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt131_cl USING g_enterprise,g_prbo_m.prbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt131_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt131_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt131_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_cmd_t = 'r' THEN
            ELSE
               CALL aprt131_set_entry(p_cmd)
               CALL aprt131_set_no_entry(p_cmd)            
            END IF 
            #end add-point
            CALL aprt131_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbosite
            
            #add-point:AFTER FIELD prbosite name="input.a.prbosite"
            IF NOT cl_null(g_prbo_m.prbosite) THEN
               CALL s_aooi500_chk(g_prog,'prbosite',g_prbo_m.prbosite,g_prbo_m.prbosite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prbo_m.prbosite = g_prbo_m_t.prbosite
                  CALL aprt131_prbosite_ref()
                  DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbosite_desc
                  NEXT FIELD CURRENT
               END IF
               
               LET g_site_flag = TRUE
               CALL aprt131_set_entry(p_cmd)
               CALL aprt131_set_no_entry(p_cmd)
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbo_m.prbosite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbo_m.prbosite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbo_m.prbosite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbosite
            #add-point:BEFORE FIELD prbosite name="input.b.prbosite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbosite
            #add-point:ON CHANGE prbosite name="input.g.prbosite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbodocdt
            #add-point:BEFORE FIELD prbodocdt name="input.b.prbodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbodocdt
            
            #add-point:AFTER FIELD prbodocdt name="input.a.prbodocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbodocdt
            #add-point:ON CHANGE prbodocdt name="input.g.prbodocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbodocno
            #add-point:BEFORE FIELD prbodocno name="input.b.prbodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbodocno
            
            #add-point:AFTER FIELD prbodocno name="input.a.prbodocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_prbo_m.prbodocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbodocno != g_prbodocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbo_t WHERE "||"prboent = '" ||g_enterprise|| "' AND "||"prbodocno = '"||g_prbo_m.prbodocno ||"'",'std-00004',0) THEN 
                     LET g_prbo_m.prbodocno = g_prbo_m_t.prbodocno
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_chk_slip(g_site,g_ooef004,g_prbo_m.prbodocno,g_prog) RETURNING l_success
                  IF l_success=FALSE THEN
                     LET g_prbo_m.prbodocno = g_prbo_m_t.prbodocno
                     NEXT FIELD prbodocno
                  END IF
               END IF
            END IF
            IF p_cmd='a' THEN
#               CALL s_autobarcode_generate('3')
#               RETURNING g_prbo_m.prbo004,l_success
#               IF NOT l_success THEN
#                  NEXT FIELD prbodocno
#               END IF
#               CALL s_auto_barcode('3')
#               RETURNING g_prbo_m.prbo004,l_success
#               IF NOT l_success THEN  
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
#               SELECT count(*) INTO l_count 
#                 FROM prbo_t
#                WHERE prbo004=g_prbo_m.prbo004
#               IF l_count>0 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = "apr-00136"
#                  LET g_errparam.extend = g_prbo_m.prbo004
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
            END IF
            DISPLAY BY NAME g_prbo_m.prbo004


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbodocno
            #add-point:ON CHANGE prbodocno name="input.g.prbodocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo001
            
            #add-point:AFTER FIELD prbo001 name="input.a.prbo001"
            LET g_prbo_m.prbo001_desc=null
            DISPLAY BY NAME g_prbo_m.prbo001_desc
            IF NOT cl_null(g_prbo_m.prbo001) AND g_prbo_m.prbo001 <> 'ALL' THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')    #150512-00027#1--add by dongsz
#               SELECT ooaa002 INTO l_ooaa002 FROM ooaa_t                       #150512-00027#1--mark by dongsz
#                WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0001'        #150512-00027#1--mark by dongsz
               LET g_chkparam.arg1 = g_prbo_m.prbo001
               #LET g_chkparam.arg2 = l_ooaa002         #150512-00027#1--mark by dongsz
               LET g_chkparam.arg2 = l_rtax004          #150512-00027#1--add by dongsz
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_3") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbo_m.prbo001 = g_prbo_m_t.prbo001
                  CALL aprt131_prbo001_ref()
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_prbo_m.prbo001 <> g_prbo_m_t.prbo001 OR cl_null(g_prbo_m_t.prbo001))) THEN   #150512-00027#1--add by dongsz
                  CALL aprt131_chk_prbo001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbo_m.prbo001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prbo_m.prbo001 = g_prbo_m_t.prbo001
                     CALL aprt131_prbo001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF           #150512-00027#1--add by dongsz

            END IF 
            CALL aprt131_prbo001_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo001
            #add-point:BEFORE FIELD prbo001 name="input.b.prbo001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo001
            #add-point:ON CHANGE prbo001 name="input.g.prbo001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo002
            #add-point:BEFORE FIELD prbo002 name="input.b.prbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo002
            
            #add-point:AFTER FIELD prbo002 name="input.a.prbo002"
            IF  NOT cl_null(g_prbo_m.prbo002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo002 != g_prbo_m_t.prbo002 OR g_prbo_m_t.prbo002 IS NULL )) THEN 
                  IF g_prbo_m.prbo002<g_today THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apr-00063"
                     LET g_errparam.extend = g_prbo_m.prbo002||'<'||g_today
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbo_m.prbo002 = g_prbo_m_t.prbo002
                     NEXT FIELD prbo002
                  END IF
                  CALL aprt131_chk_prbo002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbo_m.prbo002||'>'||g_prbo_m.prbo003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbo_m.prbo002 = g_prbo_m_t.prbo002
                     NEXT FIELD prbo002
                  END IF
                  
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo002
            #add-point:ON CHANGE prbo002 name="input.g.prbo002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo003
            #add-point:BEFORE FIELD prbo003 name="input.b.prbo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo003
            
            #add-point:AFTER FIELD prbo003 name="input.a.prbo003"
            IF  NOT cl_null(g_prbo_m.prbo003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo003 != g_prbo_m_t.prbo003 OR g_prbo_m_t.prbo003 IS NULL )) THEN 
                  IF g_prbo_m.prbo003<g_today THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "apr-00063"
                     LET g_errparam.extend = g_prbo_m.prbo003||'<'||g_today
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbo_m.prbo003 = g_prbo_m_t.prbo003
                     NEXT FIELD prbo003
                  END IF
                  CALL aprt131_chk_prbo002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbo_m.prbo002||'>'||g_prbo_m.prbo003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbo_m.prbo003 = g_prbo_m_t.prbo003
                     NEXT FIELD prbo003
                  END IF
                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo003
            #add-point:ON CHANGE prbo003 name="input.g.prbo003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbounit
            
            #add-point:AFTER FIELD prbounit name="input.a.prbounit"
            IF NOT cl_null(g_prbo_m.prbounit) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbo_m.prbounit
               LET g_chkparam.arg2 = '8'
               LET g_chkparam.arg3 = ''

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooed004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbounit
            #add-point:BEFORE FIELD prbounit name="input.b.prbounit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbounit
            #add-point:ON CHANGE prbounit name="input.g.prbounit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo004
            #add-point:BEFORE FIELD prbo004 name="input.b.prbo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo004
            
            #add-point:AFTER FIELD prbo004 name="input.a.prbo004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo004
            #add-point:ON CHANGE prbo004 name="input.g.prbo004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo005
            #add-point:BEFORE FIELD prbo005 name="input.b.prbo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo005
            
            #add-point:AFTER FIELD prbo005 name="input.a.prbo005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo005
            #add-point:ON CHANGE prbo005 name="input.g.prbo005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbo_m.prbo006,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prbo006
            END IF 
 
 
 
            #add-point:AFTER FIELD prbo006 name="input.a.prbo006"
            IF NOT cl_null(g_prbo_m.prbo006) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo006 != g_prbo_m_t.prbo006 OR g_prbo_m_t.prbo006 IS NULL )) THEN    #160824-00007#133 Mark By Ken 161031
               IF (g_prbo_m.prbo006 != g_prbo_m_o.prbo006 OR g_prbo_m_o.prbo006 IS NULL ) THEN   #160824-00007#133 Add By Ken 161031
                  CALL aprt131_sum_prbo008() 
               END IF                  
            END IF 
            LET g_prbo_m_o.* = g_prbo_m.*   #160824-00007#133 Add By Ken 161031
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo006
            #add-point:BEFORE FIELD prbo006 name="input.b.prbo006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo006
            #add-point:ON CHANGE prbo006 name="input.g.prbo006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo007
            
            #add-point:AFTER FIELD prbo007 name="input.a.prbo007"
            LET g_prbo_m.prbo007_desc =null
            DISPLAY BY NAME g_prbo_m.prbo007_desc
            IF NOT cl_null(g_prbo_m.prbo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo007 != g_prbo_m_t.prbo007 OR g_prbo_m_t.prbo007 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prbo_m.prbo007
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"  #160318-00025#32  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooca001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prbo_m.prbo007 =g_prbo_m_t.prbo007
                     CALL aprt131_prbo007_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt131_prbo007_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo007
            #add-point:BEFORE FIELD prbo007 name="input.b.prbo007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo007
            #add-point:ON CHANGE prbo007 name="input.g.prbo007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo015
            
            #add-point:AFTER FIELD prbo015 name="input.a.prbo015"
            IF NOT cl_null(g_prbo_m.prbo015) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbo_m.prbosite
               LET g_chkparam.arg2 = g_prbo_m.prbo015
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_prbo_m.prbo015 =g_prbo_m_t.prbo015
                  NEXT FIELD CURRENT
               END IF
               #單頭和商品的稅別是否一致檢查
               LET l_count=0
               SELECT count(*) INTO l_count
                 FROM prbp_t
                WHERE prbpent=g_enterprise
                  AND prbpdocno=g_prbo_m.prbodocno
               IF NOT cl_null(l_count) AND l_count>0 THEN
                  DECLARE aprt131_chekprbo015 CURSOR FOR SELECT prbp001 FROM prbp_t WHERE prbpent=g_enterprise AND prbpdocno=g_prbo_m.prbodocno
                  FOREACH aprt131_chekprbo015 INTO l_prbp001
                     CALL aprt131_chek_prbo015(l_prbp001) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = g_prbo_m.prbo015
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                      
                        LET g_prbo_m.prbo015 =g_prbo_m_t.prbo015
                        NEXT FIELD CURRENT
                     END IF
                  END FOREACH
               END IF

            END IF 
            
            SELECT ooef019 INTO l_ooef019 
              FROM ooef_t
             WHERE ooefent=g_enterprise
               AND ooef001=g_prbo_m.prbosite
               
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbo_m.prbo015
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbo_m.prbo015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbo_m.prbo015_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo015
            #add-point:BEFORE FIELD prbo015 name="input.b.prbo015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo015
            #add-point:ON CHANGE prbo015 name="input.g.prbo015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo014
            #add-point:BEFORE FIELD prbo014 name="input.b.prbo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo014
            
            #add-point:AFTER FIELD prbo014 name="input.a.prbo014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo014
            #add-point:ON CHANGE prbo014 name="input.g.prbo014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo008
            #add-point:BEFORE FIELD prbo008 name="input.b.prbo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo008
            
            #add-point:AFTER FIELD prbo008 name="input.a.prbo008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo008
            #add-point:ON CHANGE prbo008 name="input.g.prbo008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo009
            #add-point:BEFORE FIELD prbo009 name="input.b.prbo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo009
            
            #add-point:AFTER FIELD prbo009 name="input.a.prbo009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo009
            #add-point:ON CHANGE prbo009 name="input.g.prbo009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo010
            #add-point:BEFORE FIELD prbo010 name="input.b.prbo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo010
            
            #add-point:AFTER FIELD prbo010 name="input.a.prbo010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo010
            #add-point:ON CHANGE prbo010 name="input.g.prbo010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo011
            #add-point:BEFORE FIELD prbo011 name="input.b.prbo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo011
            
            #add-point:AFTER FIELD prbo011 name="input.a.prbo011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo011
            #add-point:ON CHANGE prbo011 name="input.g.prbo011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo012
            
            #add-point:AFTER FIELD prbo012 name="input.a.prbo012"
            LET g_prbo_m.prbo012_desc = NULL
            DISPLAY BY NAME g_prbo_m.prbo012_desc
            IF NOT cl_null(g_prbo_m.prbo012) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo012 != g_prbo_m_t.prbo012 OR g_prbo_m_t.prbo012 IS NULL )) THEN   #160824-00007#133 Mark By Ken 161031
               IF (g_prbo_m.prbo012 != g_prbo_m_o.prbo012 OR g_prbo_m_o.prbo012 IS NULL ) THEN    #160824-00007#133 Add By Ken 161031
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prbo_m.prbo012
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#32  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prbo_m.prbo012 =g_prbo_m_t.prbo012   #160824-00007#133 Mark By Ken 161031
                     LET g_prbo_m.prbo012 =g_prbo_m_o.prbo012    #160824-00007#133 Add By Ken 161031
                     CALL aprt131_prbo012_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt131_prbo012_display()
               END IF

            END IF 
            CALL aprt131_prbo012_ref()
            LET g_prbo_m_o.* = g_prbo_m.*   #160824-00007#133 Add By Ken 161031
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo012
            #add-point:BEFORE FIELD prbo012 name="input.b.prbo012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo012
            #add-point:ON CHANGE prbo012 name="input.g.prbo012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbo013
            
            #add-point:AFTER FIELD prbo013 name="input.a.prbo013"
            LET g_prbo_m.prbo013_desc = null
            DISPLAY BY NAME g_prbo_m.prbo013_desc
            IF NOT cl_null(g_prbo_m.prbo013) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo013 != g_prbo_m_t.prbo013 OR g_prbo_m_t.prbo013 IS NULL )) THEN   #160824-00007#133 Mark By Ken 161031
               IF (g_prbo_m.prbo013 != g_prbo_m_o.prbo013 OR g_prbo_m_o.prbo013 IS NULL ) THEN    #160824-00007#133 Add By Ken 161031
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prbo_m.prbo013
                  LET g_chkparam.arg2 = g_today
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#32  add
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001_3") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prbo_m.prbo013 =g_prbo_m_t.prbo013  #160824-00007#133 Mark By Ken 161031
                     LET g_prbo_m.prbo013 =g_prbo_m_o.prbo013   #160824-00007#133 Add By Ken 161031
                     CALL aprt131_prbo013_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt131_prbo013_ref()
            LET g_prbo_m_o.* = g_prbo_m.*   #160824-00007#133 Add By Ken 161031
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbo013
            #add-point:BEFORE FIELD prbo013 name="input.b.prbo013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbo013
            #add-point:ON CHANGE prbo013 name="input.g.prbo013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbostus
            #add-point:BEFORE FIELD prbostus name="input.b.prbostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbostus
            
            #add-point:AFTER FIELD prbostus name="input.a.prbostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbostus
            #add-point:ON CHANGE prbostus name="input.g.prbostus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prbosite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbosite
            #add-point:ON ACTION controlp INFIELD prbosite name="input.c.prbosite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbosite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbosite',g_prbo_m.prbosite,'i')   #150308-00001#4 150309 by lori522612 add 'c'
            
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prbo_m.prbosite = g_qryparam.return1              

            DISPLAY g_prbo_m.prbosite TO prbosite              #
            CALL aprt131_prbosite_ref()

            NEXT FIELD prbosite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbodocdt
            #add-point:ON ACTION controlp INFIELD prbodocdt name="input.c.prbodocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbodocno
            #add-point:ON ACTION controlp INFIELD prbodocno name="input.c.prbodocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbodocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "aprt131" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prbo_m.prbodocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbo_m.prbodocno TO prbodocno              #顯示到畫面上

            NEXT FIELD prbodocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo001
            #add-point:ON ACTION controlp INFIELD prbo001 name="input.c.prbo001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			   LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')    #150512-00027#1--add by dongsz
#            SELECT ooaa002 INTO l_ooaa002 FROM ooaa_t                       #150512-00027#1--mark by dongsz
#             WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0001'        #150512-00027#1--mark by dongsz
            LET g_qryparam.default1 = g_prbo_m.prbo001             #給予default值
            LET g_qryparam.default2 = "" #g_prbo_m.rtax001 #品類編號

            #給予arg
            #LET g_qryparam.arg1 = l_ooaa002   #              #150512-00027#1--mark by dongsz
            LET g_qryparam.arg1 = l_rtax004                   #150512-00027#1--add by dongsz

            CALL q_rtax001_4()                                #呼叫開窗

            LET g_prbo_m.prbo001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_prbo_m.rtax001 = g_qryparam.return2 #品類編號

            DISPLAY g_prbo_m.prbo001 TO prbo001              #顯示到畫面上
            #DISPLAY g_prbo_m.rtax001 TO rtax001 #品類編號
            CALL aprt131_prbo001_ref()
            NEXT FIELD prbo001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo002
            #add-point:ON ACTION controlp INFIELD prbo002 name="input.c.prbo002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo003
            #add-point:ON ACTION controlp INFIELD prbo003 name="input.c.prbo003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbounit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbounit
            #add-point:ON ACTION controlp INFIELD prbounit name="input.c.prbounit"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbounit             #給予default值
            LET g_qryparam.default2 = "" #g_prbo_m.ooefl003 #說明(簡稱)

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #

            CALL q_ooed004()                                #呼叫開窗

            LET g_prbo_m.prbounit = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_prbo_m.ooefl003 = g_qryparam.return2 #說明(簡稱)

            DISPLAY g_prbo_m.prbounit TO prbounit              #顯示到畫面上
            #DISPLAY g_prbo_m.ooefl003 TO ooefl003 #說明(簡稱)

            NEXT FIELD prbounit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo004
            #add-point:ON ACTION controlp INFIELD prbo004 name="input.c.prbo004"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo005
            #add-point:ON ACTION controlp INFIELD prbo005 name="input.c.prbo005"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo006
            #add-point:ON ACTION controlp INFIELD prbo006 name="input.c.prbo006"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo007
            #add-point:ON ACTION controlp INFIELD prbo007 name="input.c.prbo007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbo007             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prbo_m.prbo007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbo_m.prbo007 TO prbo007              #顯示到畫面上
            CALL aprt131_prbo007_ref()
            NEXT FIELD prbo007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbo015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo015
            #add-point:ON ACTION controlp INFIELD prbo015 name="input.c.prbo015"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbo015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prbo_m.prbosite


            CALL q_oodb002_3()                                #呼叫開窗

            LET g_prbo_m.prbo015 = g_qryparam.return1              

            DISPLAY g_prbo_m.prbo015 TO prbo015              #
            SELECT ooef019 INTO l_ooef019 
              FROM ooef_t
             WHERE ooefent=g_enterprise
               AND ooef001=g_prbo_m.prbosite
               
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbo_m.prbo015
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbo_m.prbo015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbo_m.prbo015_desc
            NEXT FIELD prbo015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo014
            #add-point:ON ACTION controlp INFIELD prbo014 name="input.c.prbo014"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo008
            #add-point:ON ACTION controlp INFIELD prbo008 name="input.c.prbo008"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo009
            #add-point:ON ACTION controlp INFIELD prbo009 name="input.c.prbo009"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo010
            #add-point:ON ACTION controlp INFIELD prbo010 name="input.c.prbo010"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo011
            #add-point:ON ACTION controlp INFIELD prbo011 name="input.c.prbo011"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbo012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo012
            #add-point:ON ACTION controlp INFIELD prbo012 name="input.c.prbo012"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbo012             #給予default值
            LET g_qryparam.default2 = "" #g_prbo_m.ooag003 #歸屬部門
            LET g_qryparam.default3 = "" #g_prbo_m.oofa011 #全名
            LET g_qryparam.default4 = "" #g_prbo_m.ooefl003 #說明(簡稱)

            #給予arg

            CALL q_ooag001_6()                                #呼叫開窗

            LET g_prbo_m.prbo012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_prbo_m.ooag003 = g_qryparam.return2 #歸屬部門
            #LET g_prbo_m.oofa011 = g_qryparam.return3 #全名
            #LET g_prbo_m.ooefl003 = g_qryparam.return4 #說明(簡稱)

            DISPLAY g_prbo_m.prbo012 TO prbo012              #顯示到畫面上
            #DISPLAY g_prbo_m.ooag003 TO ooag003 #歸屬部門
            #DISPLAY g_prbo_m.oofa011 TO oofa011 #全名
            #DISPLAY g_prbo_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL aprt131_prbo012_ref()
            #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo012 != g_prbo_m_t.prbo012 OR g_prbo_m_t.prbo012 IS NULL )) THEN    #160824-00007#133 Mark By Ken 161031
            IF (g_prbo_m.prbo012 != g_prbo_m_o.prbo012 OR g_prbo_m_o.prbo012 IS NULL ) THEN    #160824-00007#133 Add By Ken 161031
               CALL aprt131_prbo012_display() 
            END IF
            NEXT FIELD prbo012                          #返回原欄位
            LET g_prbo_m_o.* = g_prbo_m.*   #160824-00007#133 Add By Ken 161031

            #END add-point
 
 
         #Ctrlp:input.c.prbo013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbo013
            #add-point:ON ACTION controlp INFIELD prbo013 name="input.c.prbo013"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbo_m.prbo013             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_prbo_m.prbo013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbo_m.prbo013 TO prbo013              #顯示到畫面上
            CALL aprt131_prbo013_ref()
            NEXT FIELD prbo013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbostus
            #add-point:ON ACTION controlp INFIELD prbostus name="input.c.prbostus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prbo_m.prbodocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_auto_barcode('3')
               RETURNING g_prbo_m.prbo004,l_success
               IF NOT l_success THEN  
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
               #160905-00007#12  -S
              #SELECT count(*) INTO l_count 
              #  FROM prbo_t
              # WHERE prbo004=g_prbo_m.prbo004
                SELECT count(*) INTO l_count 
                 FROM prbo_t
                WHERE prbo004=g_prbo_m.prbo004
                  AND prboent = g_enterprise
               #160905-00007#12  -E 
               IF l_count>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apr-00136"
                  LET g_errparam.extend = g_prbo_m.prbo004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  NEXT FIELD prbodocno
               END IF
               
               IF NOT cl_null(g_prbo_m.prbodocno) THEN 
               
                  CALL s_aooi200_gen_docno(g_prbo_m.prbosite,g_prbo_m.prbodocno,g_prbo_m.prbodocdt,g_prog)
                     RETURNING  g_success,g_prbo_m.prbodocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = "amm-00001"
                       LET g_errparam.extend = g_prbo_m.prbodocno
                       LET g_errparam.popup = TRUE
                       CALL cl_err()

                     NEXT FIELD prbodocno
                  ELSE
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbo_t WHERE "||"prboent = '" ||g_enterprise|| "' AND "||"prbodocno = '"||g_prbo_m.prbodocno ||"'",'std-00004',1) THEN
                        LET g_prbo_m.prbodocno = g_prbodocno_t
                        NEXT FIELD prbodocno
                     END IF

                  END IF
                  LET g_prbo_m_t.prbodocno = g_prbo_m.prbodocno
                     
               END IF  
               #end add-point
               
               INSERT INTO prbo_t (prboent,prbosite,prbodocdt,prbodocno,prbo001,prbo002,prbo003,prbounit, 
                   prbo004,prbo005,prbo006,prbo007,prbo015,prbo014,prbo008,prbo009,prbo010,prbo011,prbo012, 
                   prbo013,prbostus,prboownid,prboowndp,prbocrtid,prbocrtdp,prbocrtdt,prbomodid,prbomoddt, 
                   prbocnfid,prbocnfdt)
               VALUES (g_enterprise,g_prbo_m.prbosite,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001, 
                   g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005, 
                   g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
                   g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013, 
                   g_prbo_m.prbostus,g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp, 
                   g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prbo_m:",SQLERRMESSAGE 
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
                  CALL aprt131_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt131_b_fill()
                  CALL aprt131_b_fill2('0')
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
               CALL aprt131_prbo_t_mask_restore('restore_mask_o')
               
               UPDATE prbo_t SET (prbosite,prbodocdt,prbodocno,prbo001,prbo002,prbo003,prbounit,prbo004, 
                   prbo005,prbo006,prbo007,prbo015,prbo014,prbo008,prbo009,prbo010,prbo011,prbo012,prbo013, 
                   prbostus,prboownid,prboowndp,prbocrtid,prbocrtdp,prbocrtdt,prbomodid,prbomoddt,prbocnfid, 
                   prbocnfdt) = (g_prbo_m.prbosite,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001, 
                   g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005, 
                   g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
                   g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013, 
                   g_prbo_m.prbostus,g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp, 
                   g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt) 
 
                WHERE prboent = g_enterprise AND prbodocno = g_prbodocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prbo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"

               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbo_m.prbo006 != g_prbo_m_t.prbo006 OR g_prbo_m_t.prbo006 IS NULL )) THEN   #160824-00007#133 Mark By Ken 161031
               IF (g_prbo_m.prbo006 != g_prbo_m_o.prbo006 OR g_prbo_m_o.prbo006 IS NULL ) THEN    #160824-00007#133 Add By Ken 161031
                  CALL aprt131_sum_prbp008()
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "prbo_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF 
               END IF                  
               LET g_prbo_m_o.* = g_prbo_m.*   #160824-00007#133 Add By Ken 161031
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt131_prbo_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prbo_m_t)
               LET g_log2 = util.JSON.stringify(g_prbo_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prbodocno_t = g_prbo_m.prbodocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt131.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prbp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prbp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt131_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prbp_d.getLength()
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
            OPEN aprt131_cl USING g_enterprise,g_prbo_m.prbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt131_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt131_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prbp_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prbp_d[l_ac].prbpseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prbp_d_t.* = g_prbp_d[l_ac].*  #BACKUP
               LET g_prbp_d_o.* = g_prbp_d[l_ac].*  #BACKUP
               CALL aprt131_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt131_set_no_entry_b(l_cmd)
               IF NOT aprt131_lock_b("prbp_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt131_bcl INTO g_prbp_d[l_ac].prbpseq,g_prbp_d[l_ac].prbp001,g_prbp_d[l_ac].prbp002, 
                      g_prbp_d[l_ac].prbp003,g_prbp_d[l_ac].prbp004,g_prbp_d[l_ac].prbp005,g_prbp_d[l_ac].prbp006, 
                      g_prbp_d[l_ac].prbp007,g_prbp_d[l_ac].prbp008,g_prbp_d[l_ac].prbp009,g_prbp_d[l_ac].prbp010, 
                      g_prbp_d[l_ac].prbpsite,g_prbp_d[l_ac].prbpunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prbp_d_t.prbpseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prbp_d_mask_o[l_ac].* =  g_prbp_d[l_ac].*
                  CALL aprt131_prbp_t_mask()
                  LET g_prbp_d_mask_n[l_ac].* =  g_prbp_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt131_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
#             CALL aprt131_show()
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
            INITIALIZE g_prbp_d[l_ac].* TO NULL 
            INITIALIZE g_prbp_d_t.* TO NULL 
            INITIALIZE g_prbp_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prbp_d[l_ac].prbp006 = "0"
      LET g_prbp_d[l_ac].prbp007 = "0"
      LET g_prbp_d[l_ac].prbp008 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prbp_d_t.* = g_prbp_d[l_ac].*     #新輸入資料
            LET g_prbp_d_o.* = g_prbp_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt131_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt131_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prbp_d[li_reproduce_target].* = g_prbp_d[li_reproduce].*
 
               LET g_prbp_d[li_reproduce_target].prbpseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL aprt131_create_prbpseq()
            LET g_prbp_d[l_ac].prbpunit = g_prbo_m.prbounit
            LET g_prbp_d[l_ac].prbpsite = g_prbo_m.prbosite
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
            SELECT COUNT(1) INTO l_count FROM prbp_t 
             WHERE prbpent = g_enterprise AND prbpdocno = g_prbo_m.prbodocno
 
               AND prbpseq = g_prbp_d[l_ac].prbpseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbo_m.prbodocno
               LET gs_keys[2] = g_prbp_d[g_detail_idx].prbpseq
               CALL aprt131_insert_b('prbp_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               DISPLAY g_prbp_d[l_ac].prbp008,g_prbp_d[l_ac].prbp009,g_prbp_d[l_ac].prbp010
                    to s_detail1[l_ac].prbp008,s_detail1[l_ac].prbp009,s_detail1[l_ac].prbp010
               CALL aprt131_show()     
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prbp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt131_b_fill()
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
               LET gs_keys[01] = g_prbo_m.prbodocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prbp_d_t.prbpseq
 
            
               #刪除同層單身
               IF NOT aprt131_delete_b('prbp_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt131_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt131_key_delete_b(gs_keys,'prbp_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt131_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prbp_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  CALL aprt131_sum_prbo008()
                  CALL aprt131_sum_prbp008()
               END IF
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt131_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  
               #end add-point
               LET l_count = g_prbp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prbp_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbpseq
            #add-point:BEFORE FIELD prbpseq name="input.b.page1.prbpseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbpseq
            
            #add-point:AFTER FIELD prbpseq name="input.a.page1.prbpseq"
            #此段落由子樣板a05產生
            IF  g_prbo_m.prbodocno IS NOT NULL AND g_prbp_d[g_detail_idx].prbpseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbo_m.prbodocno != g_prbodocno_t OR g_prbp_d[g_detail_idx].prbpseq != g_prbp_d_t.prbpseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbp_t WHERE "||"prbpent = '" ||g_enterprise|| "' AND "||"prbpdocno = '"||g_prbo_m.prbodocno ||"' AND "|| "prbpseq = '"||g_prbp_d[g_detail_idx].prbpseq ||"'",'std-00004',0) THEN 
                     LET g_prbp_d[l_ac].prbpseq = g_prbp_d_t.prbpseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbpseq
            #add-point:ON CHANGE prbpseq name="input.g.page1.prbpseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp001
            
            #add-point:AFTER FIELD prbp001 name="input.a.page1.prbp001"
            CALL aprt131_null_prbp001()
            IF NOT cl_null(g_prbp_d[l_ac].prbp001) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prbp_d[l_ac].prbp001 != g_prbp_d_t.prbp001 OR g_prbp_d_t.prbp001 IS NULL )) THEN   #160824-00007#133 Mark By Ken 161031
               IF ( g_prbp_d[l_ac].prbp001 != g_prbp_d_o.prbp001 OR g_prbp_d_o.prbp001 IS NULL ) THEN   #160824-00007#133 Add By Ken 161031
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prbp_d[l_ac].prbp001
                  LET g_chkparam.arg2 = g_prbo_m.prbosite
                  IF g_prbo_m.prbo001<>'ALL'  THEN
                     LET g_chkparam.arg3 = g_prbo_m.prbo001
   
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_rtdx001_8") THEN

                     ELSE
                        #檢查失敗時後續處理
                        #LET g_prbp_d[l_ac].prbp001 = g_prbp_d_t.prbp001   #160824-00007#133 Mark By Ken 161031
                        LET g_prbp_d[l_ac].prbp001 = g_prbp_d_o.prbp001    #160824-00007#133 Add By Ken 161031
                        CALL aprt131_prbp0011_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF cl_chk_exist("v_rtdx001_1") THEN

                     ELSE
                        #檢查失敗時後續處理
                        #LET g_prbp_d[l_ac].prbp001 = g_prbp_d_t.prbp001   #160824-00007#133 Mark By Ken 161031
                        LET g_prbp_d[l_ac].prbp001 = g_prbp_d_o.prbp001    #160824-00007#133 Add By Ken 161031
                        CALL aprt131_prbp0011_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL aprt131_unique_prbp001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prbp_d[l_ac].prbp001 = g_prbp_d_t.prbp001   #160824-00007#133 Mark By Ken 161031
                     LET g_prbp_d[l_ac].prbp001 = g_prbp_d_o.prbp001    #160824-00007#133 Add By Ken 161031
                     CALL aprt131_prbp0011_ref()
                     NEXT FIELD prbp001
                  END IF
                  CALL aprt131_chk_prbp0012()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prbp_d[l_ac].prbp001 = g_prbp_d_t.prbp001   #160824-00007#133 Mark By Ken 161031
                     LET g_prbp_d[l_ac].prbp001 = g_prbp_d_o.prbp001    #160824-00007#133 Add By Ken 161031
                     CALL aprt131_prbp0011_ref()
                     NEXT FIELD prbp001
                  END IF
                  #單頭和商品的稅別是否一致檢查
                  CALL aprt131_chek_prbo015(g_prbp_d[l_ac].prbp001) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prbp_d[l_ac].prbp001 = g_prbp_d_t.prbp001   #160824-00007#133 Mark By Ken 161031
                     LET g_prbp_d[l_ac].prbp001 = g_prbp_d_o.prbp001    #160824-00007#133 Add By Ken 161031
                     CALL aprt131_prbp0011_ref()
                     NEXT FIELD prbp001
                  END IF                  
                  CALL aprt131_prbp001_ref()
               END IF
            END IF 
            CALL aprt131_prbp0011_ref()
            LET g_prbp_d_o.* = g_prbp_d[l_ac].*   #160824-00007#133 Add By Ken 161031
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp001
            #add-point:BEFORE FIELD prbp001 name="input.b.page1.prbp001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp001
            #add-point:ON CHANGE prbp001 name="input.g.page1.prbp001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp002
            #add-point:BEFORE FIELD prbp002 name="input.b.page1.prbp002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp002
            
            #add-point:AFTER FIELD prbp002 name="input.a.page1.prbp002"
            IF NOT cl_null(g_prbp_d[l_ac].prbp002) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prbp_d[l_ac].prbp002 != g_prbp_d_t.prbp002 OR g_prbp_d_t.prbp002 IS NULL )) THEN   #160824-00007#133 Mark By Ken 161031
               IF ( g_prbp_d[l_ac].prbp002 != g_prbp_d_o.prbp002 OR g_prbp_d_o.prbp002 IS NULL ) THEN   #160824-00007#133 Add By Ken 161031
                  CALL aprt131_chk_prbp002()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prbp_d[l_ac].prbp002 = g_prbp_d_t.prbp002  #160824-00007#133 Mark By Ken 161031
                     LET g_prbp_d[l_ac].prbp002 = g_prbp_d_o.prbp002   #160824-00007#133 Add By Ken 161031
                     NEXT FIELD prbp002
                  END IF 
                  #單頭和商品的稅別是否一致檢查
                  SELECT rtdx001 INTO l_prbp001
                    FROM rtdx_t LEFT JOIN imaa_t ON imaa001=rtdx001 AND imaaent=rtdxent
                                LEFT JOIN imay_t ON rtdx001=imay001 AND rtdxent=imayent
                   WHERE imayent=g_enterprise AND imay003= g_prbp_d[l_ac].prbp002
                     AND rtdxsite=g_prbo_m.prbosite AND imaastus='Y' AND rtdxstus='Y'
         
                  CALL aprt131_chek_prbo015(l_prbp001) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prbp_d[l_ac].prbp002 = g_prbp_d_t.prbp002  #160824-00007#133 Mark By Ken 161031
                     LET g_prbp_d[l_ac].prbp002 = g_prbp_d_o.prbp002   #160824-00007#133 Add By Ken 161031
                     NEXT FIELD prbp002
                  END IF
                  
                  IF cl_null( g_prbp_d[l_ac].prbp001) THEN
                     CALL aprt131_prbp002_ref()
                     CALL aprt131_unique_prbp001()
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                        #LET g_prbp_d[l_ac].prbp002 = g_prbp_d_t.prbp002  #160824-00007#133 Mark By Ken 161031
                        LET g_prbp_d[l_ac].prbp002 = g_prbp_d_o.prbp002   #160824-00007#133 Add By Ken 161031                        
                        LET g_prbp_d[l_ac].prbp001 = NULL
                        NEXT FIELD prbp002
                     END IF
                     CALL aprt131_prbp0011_ref()
                  END IF
                  CALL aprt131_chk_prbp0012()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prbp_d[l_ac].prbp002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prbp_d[l_ac].prbp002 = g_prbp_d_t.prbp002  #160824-00007#133 Mark By Ken 161031
                     LET g_prbp_d[l_ac].prbp002 = g_prbp_d_o.prbp002   #160824-00007#133 Add By Ken 161031                     
                     NEXT FIELD prbp002
                  END IF                   
                  
               END IF 
            END IF   
            CALL aprt131_prbp0011_ref()
            LET g_prbp_d_o.* = g_prbp_d[l_ac].*   #160824-00007#133 Add By Ken 161031
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp002
            #add-point:ON CHANGE prbp002 name="input.g.page1.prbp002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp003
            #add-point:BEFORE FIELD prbp003 name="input.b.page1.prbp003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp003
            
            #add-point:AFTER FIELD prbp003 name="input.a.page1.prbp003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp003
            #add-point:ON CHANGE prbp003 name="input.g.page1.prbp003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp004
            
            #add-point:AFTER FIELD prbp004 name="input.a.page1.prbp004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbp_d[l_ac].prbp004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbp_d[l_ac].prbp004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbp_d[l_ac].prbp004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp004
            #add-point:BEFORE FIELD prbp004 name="input.b.page1.prbp004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp004
            #add-point:ON CHANGE prbp004 name="input.g.page1.prbp004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbp_d[l_ac].prbp005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbp005
            END IF 
 
 
 
            #add-point:AFTER FIELD prbp005 name="input.a.page1.prbp005"
            IF NOT cl_null(g_prbp_d[l_ac].prbp005) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp005
            #add-point:BEFORE FIELD prbp005 name="input.b.page1.prbp005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp005
            #add-point:ON CHANGE prbp005 name="input.g.page1.prbp005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp006
            #add-point:BEFORE FIELD prbp006 name="input.b.page1.prbp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp006
            
            #add-point:AFTER FIELD prbp006 name="input.a.page1.prbp006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp006
            #add-point:ON CHANGE prbp006 name="input.g.page1.prbp006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp007
            #add-point:BEFORE FIELD prbp007 name="input.b.page1.prbp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp007
            
            #add-point:AFTER FIELD prbp007 name="input.a.page1.prbp007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp007
            #add-point:ON CHANGE prbp007 name="input.g.page1.prbp007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp008
            #add-point:BEFORE FIELD prbp008 name="input.b.page1.prbp008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp008
            
            #add-point:AFTER FIELD prbp008 name="input.a.page1.prbp008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp008
            #add-point:ON CHANGE prbp008 name="input.g.page1.prbp008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp009
            #add-point:BEFORE FIELD prbp009 name="input.b.page1.prbp009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp009
            
            #add-point:AFTER FIELD prbp009 name="input.a.page1.prbp009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp009
            #add-point:ON CHANGE prbp009 name="input.g.page1.prbp009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbp010
            #add-point:BEFORE FIELD prbp010 name="input.b.page1.prbp010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbp010
            
            #add-point:AFTER FIELD prbp010 name="input.a.page1.prbp010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbp010
            #add-point:ON CHANGE prbp010 name="input.g.page1.prbp010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbpsite
            #add-point:BEFORE FIELD prbpsite name="input.b.page1.prbpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbpsite
            
            #add-point:AFTER FIELD prbpsite name="input.a.page1.prbpsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbpsite
            #add-point:ON CHANGE prbpsite name="input.g.page1.prbpsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbpunit
            #add-point:BEFORE FIELD prbpunit name="input.b.page1.prbpunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbpunit
            
            #add-point:AFTER FIELD prbpunit name="input.a.page1.prbpunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbpunit
            #add-point:ON CHANGE prbpunit name="input.g.page1.prbpunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prbpseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbpseq
            #add-point:ON ACTION controlp INFIELD prbpseq name="input.c.page1.prbpseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp001
            #add-point:ON ACTION controlp INFIELD prbp001 name="input.c.page1.prbp001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbp_d[l_ac].prbp001             #給予default值

            #給予arg
            IF g_prbo_m.prbo001<>'ALL' THEN
               LET g_qryparam.arg1 = g_prbo_m.prbosite #
               LET g_qryparam.arg2 = g_prbo_m.prbo001 #

               CALL q_rtdx001_17()                                #呼叫開窗
            ELSE
               LET g_qryparam.arg1 = g_prbo_m.prbosite #

               CALL q_rtdx001_6()
            END IF
            LET g_prbp_d[l_ac].prbp001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbp_d[l_ac].prbp001 TO prbp001              #顯示到畫面上

            NEXT FIELD prbp001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp002
            #add-point:ON ACTION controlp INFIELD prbp002 name="input.c.page1.prbp002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbp_d[l_ac].prbp002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prbo_m.prbosite #
            IF cl_null(g_prbp_d[l_ac].prbp001) THEN 
               LET g_qryparam.WHERE  =" imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 START WITH rtax003 = '",g_prbo_m.prbo001,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 UNION SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbo_m.prbo001,"')"
            ELSE
               LET g_qryparam.WHERE  =" rtdx001='",g_prbp_d[l_ac].prbp001,"' AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 START WITH rtax003 = '",g_prbo_m.prbo001,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 UNION SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbo_m.prbo001,"')"
            END IF               
            CALL q_rtdx002_1()                                #呼叫開窗

            LET g_prbp_d[l_ac].prbp002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbp_d[l_ac].prbp002 TO prbp002              #顯示到畫面上

            NEXT FIELD prbp002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp003
            #add-point:ON ACTION controlp INFIELD prbp003 name="input.c.page1.prbp003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp004
            #add-point:ON ACTION controlp INFIELD prbp004 name="input.c.page1.prbp004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbp_d[l_ac].prbp004             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prbp_d[l_ac].prbp004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbp_d[l_ac].prbp004 TO prbp004              #顯示到畫面上
            
            NEXT FIELD prbp004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp005
            #add-point:ON ACTION controlp INFIELD prbp005 name="input.c.page1.prbp005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp006
            #add-point:ON ACTION controlp INFIELD prbp006 name="input.c.page1.prbp006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp007
            #add-point:ON ACTION controlp INFIELD prbp007 name="input.c.page1.prbp007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp008
            #add-point:ON ACTION controlp INFIELD prbp008 name="input.c.page1.prbp008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp009
            #add-point:ON ACTION controlp INFIELD prbp009 name="input.c.page1.prbp009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbp010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbp010
            #add-point:ON ACTION controlp INFIELD prbp010 name="input.c.page1.prbp010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbpsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbpsite
            #add-point:ON ACTION controlp INFIELD prbpsite name="input.c.page1.prbpsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbpunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbpunit
            #add-point:ON ACTION controlp INFIELD prbpunit name="input.c.page1.prbpunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prbp_d[l_ac].* = g_prbp_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt131_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prbp_d[l_ac].prbpseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prbp_d[l_ac].* = g_prbp_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt131_prbp_t_mask_restore('restore_mask_o')
      
               UPDATE prbp_t SET (prbpdocno,prbpseq,prbp001,prbp002,prbp003,prbp004,prbp005,prbp006, 
                   prbp007,prbp008,prbp009,prbp010,prbpsite,prbpunit) = (g_prbo_m.prbodocno,g_prbp_d[l_ac].prbpseq, 
                   g_prbp_d[l_ac].prbp001,g_prbp_d[l_ac].prbp002,g_prbp_d[l_ac].prbp003,g_prbp_d[l_ac].prbp004, 
                   g_prbp_d[l_ac].prbp005,g_prbp_d[l_ac].prbp006,g_prbp_d[l_ac].prbp007,g_prbp_d[l_ac].prbp008, 
                   g_prbp_d[l_ac].prbp009,g_prbp_d[l_ac].prbp010,g_prbp_d[l_ac].prbpsite,g_prbp_d[l_ac].prbpunit) 
 
                WHERE prbpent = g_enterprise AND prbpdocno = g_prbo_m.prbodocno 
 
                  AND prbpseq = g_prbp_d_t.prbpseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               IF SQLCA.sqlcode THEN
                  
               ELSE
                  CALL aprt131_sum_prbo008()
                  CALL aprt131_sum_prbp008()

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "prbp_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbp_d[l_ac].* = g_prbp_d_t.*                   
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     LET SQLCA.sqlcode=null
                     LET SQLCA.sqlerrd[3]=null                 
                  END IF
               END IF  
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prbp_d[l_ac].* = g_prbp_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prbp_d[l_ac].* = g_prbp_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbo_m.prbodocno
               LET gs_keys_bak[1] = g_prbodocno_t
               LET gs_keys[2] = g_prbp_d[g_detail_idx].prbpseq
               LET gs_keys_bak[2] = g_prbp_d_t.prbpseq
               CALL aprt131_update_b('prbp_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt131_prbp_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prbp_d[g_detail_idx].prbpseq = g_prbp_d_t.prbpseq 
 
                  ) THEN
                  LET gs_keys[01] = g_prbo_m.prbodocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prbp_d_t.prbpseq
 
                  CALL aprt131_key_update_b(gs_keys,'prbp_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prbo_m),util.JSON.stringify(g_prbp_d_t)
               LET g_log2 = util.JSON.stringify(g_prbo_m),util.JSON.stringify(g_prbp_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt131_unlock_b("prbp_t","'1'")
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
               LET g_prbp_d[li_reproduce_target].* = g_prbp_d[li_reproduce].*
 
               LET g_prbp_d[li_reproduce_target].prbpseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prbp_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prbp_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aprt131.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD prbosite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prbpseq
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD prbodocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prbpseq
 
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
 
{<section id="aprt131.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt131_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt131_b_fill() #單身填充
      CALL aprt131_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt131_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbosite
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbosite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbosite_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbo001
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbo001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbo001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbo007
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbo007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbo007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbo012
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbo012_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbo012_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbo013
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbo013_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbo013_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prboownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbo_m.prboownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prboownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prboowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbo_m.prboowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prboowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbocrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbocrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbocrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbocrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbocrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbocrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbomodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbomodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbomodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbo_m.prbocnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbo_m.prbocnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbo_m.prbocnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prbo_m_mask_o.* =  g_prbo_m.*
   CALL aprt131_prbo_t_mask()
   LET g_prbo_m_mask_n.* =  g_prbo_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbosite_desc,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005, 
       g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo007_desc,g_prbo_m.prbo015,g_prbo_m.prbo015_desc, 
       g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012, 
       g_prbo_m.prbo012_desc,g_prbo_m.prbo013,g_prbo_m.prbo013_desc,g_prbo_m.prbostus,g_prbo_m.prboownid, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid,g_prbo_m.prbocrtid_desc, 
       g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdp_desc,g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomodid_desc, 
       g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfid_desc,g_prbo_m.prbocnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbo_m.prbostus 
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
   FOR l_ac = 1 TO g_prbp_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbp_d[l_ac].prbp004
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbp_d[l_ac].prbp004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbp_d[l_ac].prbp004_desc
      CALL aprt131_prbp0011_ref()
      SELECT prbp008,prbp009,prbp010 
        INTO  g_prbp_d[l_ac].prbp008,g_prbp_d[l_ac].prbp009,g_prbp_d[l_ac].prbp010
        FROM prbp_t
       WHERE prbpdocno=g_prbo_m.prbodocno AND prbpent=g_enterprise
         AND prbpseq=g_prbp_d[l_ac].prbpseq
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt131_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt131_detail_show()
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
 
{<section id="aprt131.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt131_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prbo_t.prbodocno 
   DEFINE l_oldno     LIKE prbo_t.prbodocno 
 
   DEFINE l_master    RECORD LIKE prbo_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prbp_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
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
   
   IF g_prbo_m.prbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prbodocno_t = g_prbo_m.prbodocno
 
    
   LET g_prbo_m.prbodocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbo_m.prboownid = g_user
      LET g_prbo_m.prboowndp = g_dept
      LET g_prbo_m.prbocrtid = g_user
      LET g_prbo_m.prbocrtdp = g_dept 
      LET g_prbo_m.prbocrtdt = cl_get_current()
      LET g_prbo_m.prbomodid = g_user
      LET g_prbo_m.prbomoddt = cl_get_current()
      LET g_prbo_m.prbostus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL s_transaction_begin()
   LET g_prbo_m.prbocnfid = ""
   LET g_prbo_m.prbocnfdt = ""
   LET g_prbo_m.prbostus='N'
   LET g_site_flag = FALSE
   CALL s_aooi500_default(g_prog,'prbosite',g_prbo_m.prbosite)
      RETURNING l_insert,g_prbo_m.prbosite
   IF NOT l_insert THEN
      RETURN
   END IF
   LET g_prbo_m.prbounit = g_prbo_m.prbosite
#   LET g_prbo_m.prbosite = g_prbo_m.prbounit
   CALL aprt131_prbosite_ref()
   LET g_prbo_m.prbodocdt = g_today
   LET g_prbo_m.prbo012 = g_user
   CALL aprt131_prbo012_ref()
   CALL aprt131_prbo012_display()
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prbo_m.prbosite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prbo_m.prbodocno = r_doctype
   #dongsz--add--end---  
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbo_m.prbostus 
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
   
   
   CALL aprt131_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prbo_m.* TO NULL
      INITIALIZE g_prbp_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt131_show()
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
   CALL aprt131_set_act_visible()   
   CALL aprt131_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prbodocno_t = g_prbo_m.prbodocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prboent = " ||g_enterprise|| " AND",
                      " prbodocno = '", g_prbo_m.prbodocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt131_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt131_idx_chk()
   
   LET g_data_owner = g_prbo_m.prboownid      
   LET g_data_dept  = g_prbo_m.prboowndp
   
   #功能已完成,通報訊息中心
   CALL aprt131_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt131_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prbp_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt131_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prbp_t
    WHERE prbpent = g_enterprise AND prbpdocno = g_prbodocno_t
 
    INTO TEMP aprt131_detail
 
   #將key修正為調整後   
   UPDATE aprt131_detail 
      #更新key欄位
      SET prbpdocno = g_prbo_m.prbodocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prbp_t SELECT * FROM aprt131_detail
   
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
   DROP TABLE aprt131_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prbodocno_t = g_prbo_m.prbodocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt131_delete()
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
   
   IF g_prbo_m.prbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt131_cl USING g_enterprise,g_prbo_m.prbodocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt131_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt131_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
       g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
       g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
       g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
       g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
       g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
       g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt131_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prbo_m_mask_o.* =  g_prbo_m.*
   CALL aprt131_prbo_t_mask()
   LET g_prbo_m_mask_n.* =  g_prbo_m.*
   
   CALL aprt131_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt131_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prbodocno_t = g_prbo_m.prbodocno
 
 
      DELETE FROM prbo_t
       WHERE prboent = g_enterprise AND prbodocno = g_prbo_m.prbodocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prbo_m.prbodocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #150518-00006#1--add by dongsz--str---
      IF NOT s_aooi200_del_docno(g_prbo_m.prbodocno,g_prbo_m.prbodocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #150518-00006#1--add by dongsz--end---
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM prbp_t
       WHERE prbpent = g_enterprise AND prbpdocno = g_prbo_m.prbodocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prbo_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt131_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prbp_d.clear() 
 
     
      CALL aprt131_ui_browser_refresh()  
      #CALL aprt131_ui_headershow()  
      #CALL aprt131_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt131_browser_fill("")
         CALL aprt131_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt131_cl
 
   #功能已完成,通報訊息中心
   CALL aprt131_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt131.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt131_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prbp_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt131_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prbpseq,prbp001,prbp002,prbp003,prbp004,prbp005,prbp006,prbp007, 
             prbp008,prbp009,prbp010,prbpsite,prbpunit ,t1.oocal003 FROM prbp_t",   
                     " INNER JOIN prbo_t ON prboent = " ||g_enterprise|| " AND prbodocno = prbpdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=prbp004 AND t1.oocal002='"||g_dlang||"' ",
 
                     " WHERE prbpent=? AND prbpdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prbp_t.prbpseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt131_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt131_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prbo_m.prbodocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prbo_m.prbodocno INTO g_prbp_d[l_ac].prbpseq,g_prbp_d[l_ac].prbp001, 
          g_prbp_d[l_ac].prbp002,g_prbp_d[l_ac].prbp003,g_prbp_d[l_ac].prbp004,g_prbp_d[l_ac].prbp005, 
          g_prbp_d[l_ac].prbp006,g_prbp_d[l_ac].prbp007,g_prbp_d[l_ac].prbp008,g_prbp_d[l_ac].prbp009, 
          g_prbp_d[l_ac].prbp010,g_prbp_d[l_ac].prbpsite,g_prbp_d[l_ac].prbpunit,g_prbp_d[l_ac].prbp004_desc  
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
   
   CALL g_prbp_d.deleteElement(g_prbp_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt131_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prbp_d.getLength()
      LET g_prbp_d_mask_o[l_ac].* =  g_prbp_d[l_ac].*
      CALL aprt131_prbp_t_mask()
      LET g_prbp_d_mask_n[l_ac].* =  g_prbp_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt131_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prbp_t
       WHERE prbpent = g_enterprise AND
         prbpdocno = ps_keys_bak[1] AND prbpseq = ps_keys_bak[2]
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
         CALL g_prbp_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt131_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prbp_t
                  (prbpent,
                   prbpdocno,
                   prbpseq
                   ,prbp001,prbp002,prbp003,prbp004,prbp005,prbp006,prbp007,prbp008,prbp009,prbp010,prbpsite,prbpunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prbp_d[g_detail_idx].prbp001,g_prbp_d[g_detail_idx].prbp002,g_prbp_d[g_detail_idx].prbp003, 
                       g_prbp_d[g_detail_idx].prbp004,g_prbp_d[g_detail_idx].prbp005,g_prbp_d[g_detail_idx].prbp006, 
                       g_prbp_d[g_detail_idx].prbp007,g_prbp_d[g_detail_idx].prbp008,g_prbp_d[g_detail_idx].prbp009, 
                       g_prbp_d[g_detail_idx].prbp010,g_prbp_d[g_detail_idx].prbpsite,g_prbp_d[g_detail_idx].prbpunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prbp_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      CALL aprt131_sum_prbo008()
      CALL aprt131_sum_prbp008()
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prbp_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt131_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prbp_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt131_prbp_t_mask_restore('restore_mask_o')
               
      UPDATE prbp_t 
         SET (prbpdocno,
              prbpseq
              ,prbp001,prbp002,prbp003,prbp004,prbp005,prbp006,prbp007,prbp008,prbp009,prbp010,prbpsite,prbpunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prbp_d[g_detail_idx].prbp001,g_prbp_d[g_detail_idx].prbp002,g_prbp_d[g_detail_idx].prbp003, 
                  g_prbp_d[g_detail_idx].prbp004,g_prbp_d[g_detail_idx].prbp005,g_prbp_d[g_detail_idx].prbp006, 
                  g_prbp_d[g_detail_idx].prbp007,g_prbp_d[g_detail_idx].prbp008,g_prbp_d[g_detail_idx].prbp009, 
                  g_prbp_d[g_detail_idx].prbp010,g_prbp_d[g_detail_idx].prbpsite,g_prbp_d[g_detail_idx].prbpunit)  
 
         WHERE prbpent = g_enterprise AND prbpdocno = ps_keys_bak[1] AND prbpseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbp_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbp_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt131_prbp_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprt131.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt131_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt131.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt131_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt131.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt131_lock_b(ps_table,ps_page)
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
   #CALL aprt131_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prbp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt131_bcl USING g_enterprise,
                                       g_prbo_m.prbodocno,g_prbp_d[g_detail_idx].prbpseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt131_bcl:",SQLERRMESSAGE 
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
 
{<section id="aprt131.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt131_unlock_b(ps_table,ps_page)
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
      CLOSE aprt131_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt131_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prbodocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prbodocno",TRUE)
      CALL cl_set_comp_entry("prbodocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prbosite",TRUE)

      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt131_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prbodocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prbodocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prbodocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'prbosite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prbosite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt131.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt131_set_entry_b(p_cmd)
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
 
{<section id="aprt131.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt131_set_no_entry_b(p_cmd)
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
 
{<section id="aprt131.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt131_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt131_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prbo_m.prbostus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt131_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt131_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt131_default_search()
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
      LET ls_wc = ls_wc, " prbodocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prbo_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prbp_t" 
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
 
{<section id="aprt131.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt131_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success like type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_prbo_m.prbostus = 'X' THEN
      RETURN
   END IF
   IF g_prbo_m.prbostus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prbo_m.prbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt131_cl USING g_enterprise,g_prbo_m.prbodocno
   IF STATUS THEN
      CLOSE aprt131_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt131_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
       g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
       g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
       g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
       g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
       g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
       g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt131_action_chk() THEN
      CLOSE aprt131_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbosite_desc,g_prbo_m.prbodocdt,g_prbo_m.prbodocno,g_prbo_m.prbo001, 
       g_prbo_m.prbo001_desc,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004,g_prbo_m.prbo005, 
       g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo007_desc,g_prbo_m.prbo015,g_prbo_m.prbo015_desc, 
       g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012, 
       g_prbo_m.prbo012_desc,g_prbo_m.prbo013,g_prbo_m.prbo013_desc,g_prbo_m.prbostus,g_prbo_m.prboownid, 
       g_prbo_m.prboownid_desc,g_prbo_m.prboowndp,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid,g_prbo_m.prbocrtid_desc, 
       g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdp_desc,g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomodid_desc, 
       g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfid_desc,g_prbo_m.prbocnfdt
 
   CASE g_prbo_m.prbostus
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
         CASE g_prbo_m.prbostus
            
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
#      CALL cl_set_act_visible("invalid,unconfirmed,confirmed", true)
#      IF g_prbo_m.prbostus <> 'N' THEN
#         CALL cl_set_act_visible("unconfirmed", true)
#      ELSE
#         CALL cl_set_act_visible("unconfirmed", FALSE)
#         CALL cl_set_act_visible("invalid,confirmed", true)            
#      END IF
#      IF g_prbo_m.prbostus = 'Y' THEN
#         CALL cl_set_act_visible("unconfirmed", TRUE)
#         CALL cl_set_act_visible("confirmed,invalid", FALSE)      
#      END IF
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_prbo_m.prbostus
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
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
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
            IF NOT aprt131_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt131_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt131_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt131_cl
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
      g_prbo_m.prbostus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt131_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT prbostus INTO g_prbo_m.prbostus FROM prbo_t WHERE prbodocno = g_prbo_m.prbodocno
            AND prboent = g_enterprise   
         CALL cl_err_collect_init()            
         CALL s_aprt131_conf_chk(g_prbo_m.prbodocno,g_prbo_m.prbostus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_aprt131_conf_upd(g_prbo_m.prbodocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbo_m.prbodocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               RETURN
            END IF            
         ELSE
            RETURN            
         END IF
                
      WHEN 'N'
         SELECT prbostus INTO g_prbo_m.prbostus FROM prbo_t WHERE prbodocno = g_prbo_m.prbodocno
            AND prboent = g_enterprise 
         CALL s_aprt131_unconf_chk(g_prbo_m.prbodocno,g_prbo_m.prbostus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_transaction_begin()
               CALL s_aprt131_unconf_upd(g_prbo_m.prbodocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbo_m.prbodocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN
            END IF
         ELSE
            RETURN    
         END IF 
      WHEN 'X'
         SELECT prbostus INTO g_prbo_m.prbostus FROM prbo_t WHERE prbodocno = g_prbo_m.prbodocno
            AND prboent = g_enterprise  
         CALL s_aprt131_void_chk(g_prbo_m.prbodocno,g_prbo_m.prbostus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_aprt131_void_upd(g_prbo_m.prbodocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbo_m.prbodocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN
            END IF
         ELSE 
            RETURN    
         END IF        
   END CASE
   #end add-point
   
   LET g_prbo_m.prbomodid = g_user
   LET g_prbo_m.prbomoddt = cl_get_current()
   LET g_prbo_m.prbostus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prbo_t 
      SET (prbostus,prbomodid,prbomoddt) 
        = (g_prbo_m.prbostus,g_prbo_m.prbomodid,g_prbo_m.prbomoddt)     
    WHERE prboent = g_enterprise AND prbodocno = g_prbo_m.prbodocno
 
    
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
      EXECUTE aprt131_master_referesh USING g_prbo_m.prbodocno INTO g_prbo_m.prbosite,g_prbo_m.prbodocdt, 
          g_prbo_m.prbodocno,g_prbo_m.prbo001,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit,g_prbo_m.prbo004, 
          g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo015,g_prbo_m.prbo014,g_prbo_m.prbo008, 
          g_prbo_m.prbo009,g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo013,g_prbo_m.prbostus, 
          g_prbo_m.prboownid,g_prbo_m.prboowndp,g_prbo_m.prbocrtid,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdt, 
          g_prbo_m.prbomodid,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbosite_desc, 
          g_prbo_m.prbo001_desc,g_prbo_m.prbo007_desc,g_prbo_m.prbo015_desc,g_prbo_m.prbo012_desc,g_prbo_m.prbo013_desc, 
          g_prbo_m.prboownid_desc,g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp_desc, 
          g_prbo_m.prbomodid_desc,g_prbo_m.prbocnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prbo_m.prbosite,g_prbo_m.prbosite_desc,g_prbo_m.prbodocdt,g_prbo_m.prbodocno, 
          g_prbo_m.prbo001,g_prbo_m.prbo001_desc,g_prbo_m.prbo002,g_prbo_m.prbo003,g_prbo_m.prbounit, 
          g_prbo_m.prbo004,g_prbo_m.prbo005,g_prbo_m.prbo006,g_prbo_m.prbo007,g_prbo_m.prbo007_desc, 
          g_prbo_m.prbo015,g_prbo_m.prbo015_desc,g_prbo_m.prbo014,g_prbo_m.prbo008,g_prbo_m.prbo009, 
          g_prbo_m.prbo010,g_prbo_m.prbo011,g_prbo_m.prbo012,g_prbo_m.prbo012_desc,g_prbo_m.prbo013, 
          g_prbo_m.prbo013_desc,g_prbo_m.prbostus,g_prbo_m.prboownid,g_prbo_m.prboownid_desc,g_prbo_m.prboowndp, 
          g_prbo_m.prboowndp_desc,g_prbo_m.prbocrtid,g_prbo_m.prbocrtid_desc,g_prbo_m.prbocrtdp,g_prbo_m.prbocrtdp_desc, 
          g_prbo_m.prbocrtdt,g_prbo_m.prbomodid,g_prbo_m.prbomodid_desc,g_prbo_m.prbomoddt,g_prbo_m.prbocnfid, 
          g_prbo_m.prbocnfid_desc,g_prbo_m.prbocnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT prbostus,prbocnfid,prbocnfdt,prbomodid,prbomoddt INTO g_prbo_m.prbostus,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,
                                                                g_prbo_m.prbomodid,g_prbo_m.prbomoddt  
     FROM prbo_t
    WHERE prboent = g_enterprise AND prbodocno = g_prbo_m.prbodocno
   DISPLAY BY NAME g_prbo_m.prbostus,g_prbo_m.prbocnfid,g_prbo_m.prbocnfdt,g_prbo_m.prbomodid,g_prbo_m.prbomoddt
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbocnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbo_m.prbocnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prbo_m.prbocnfid_desc   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbomodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbo_m.prbomodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prbo_m.prbomodid_desc
   IF g_prbo_m.prbostus NOT MATCHES "[DNR]" THEN
      CALL cl_set_act_visible("delete,modify", FALSE)
   ELSE
      CALL cl_set_act_visible("delete,modify", true)    
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt131_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt131_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt131.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt131_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prbp_d.getLength() THEN
         LET g_detail_idx = g_prbp_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prbp_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prbp_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt131_b_fill2(pi_idx)
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
   
   CALL aprt131_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt131_fill_chk(ps_idx)
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
 
{<section id="aprt131.status_show" >}
PRIVATE FUNCTION aprt131_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt131.mask_functions" >}
&include "erp/apr/aprt131_mask.4gl"
 
{</section>}
 
{<section id="aprt131.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt131_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt131_show()
   CALL aprt131_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt131_conf_chk(g_prbo_m.prbodocno,g_prbo_m.prbostus) RETURNING l_success
   IF l_success THEN
            
   ELSE
      CLOSE aprt131_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE           
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prbo_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prbp_d))
 
 
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
   #CALL aprt131_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt131_ui_headershow()
   CALL aprt131_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt131_draw_out()
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
   CALL aprt131_ui_headershow()  
   CALL aprt131_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt131.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt131_set_pk_array()
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
   LET g_pk_array[1].values = g_prbo_m.prbodocno
   LET g_pk_array[1].column = 'prbodocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt131.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt131.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt131_msgcentre_notify(lc_state)
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
   CALL aprt131_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prbo_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt131.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt131_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#30 add-S
   SELECT prbostus  INTO g_prbo_m.prbostus
     FROM prbo_t
    WHERE prboent = g_enterprise
      AND prbodocno = g_prbo_m.prbodocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prbo_m.prbostus
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
        LET g_errparam.extend = g_prbo_m.prbodocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt131_set_act_visible()
        CALL aprt131_set_act_no_visible()
        CALL aprt131_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#30 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt131.other_function" readonly="Y" >}
#display prbosite
PRIVATE FUNCTION aprt131_prbosite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbosite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbo_m.prbosite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbo_m.prbosite_desc
END FUNCTION
#display prbo001
PRIVATE FUNCTION aprt131_prbo001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbo001
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbo_m.prbo001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbo_m.prbo001_desc
END FUNCTION
#display prbo007
PRIVATE FUNCTION aprt131_prbo007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbo007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbo_m.prbo007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbo_m.prbo007_desc
END FUNCTION
#display prbo012
PRIVATE FUNCTION aprt131_prbo012_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbo012
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbo_m.prbo012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbo_m.prbo012_desc
END FUNCTION
#display prbo013
PRIVATE FUNCTION aprt131_prbo013_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbo_m.prbo013
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbo_m.prbo013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbo_m.prbo013_desc
END FUNCTION
#display prbo013
PRIVATE FUNCTION aprt131_prbo012_display()
   SELECT ooag003 INTO g_prbo_m.prbo013
     FROM ooag_t
    WHERE ooagent= g_enterprise
      AND ooag001= g_prbo_m.prbo012
   CALL aprt131_prbo013_ref()   
END FUNCTION
#chk prbo002
PRIVATE FUNCTION aprt131_chk_prbo002()
   LET g_errno=null
   IF NOT cl_null(g_prbo_m.prbo002) AND NOT cl_null(g_prbo_m.prbo003) THEN
      IF g_prbo_m.prbo003<g_prbo_m.prbo002 THEN
         LET g_errno="amm-00080"
      END IF
   END IF
END FUNCTION
#create prbpseq
PRIVATE FUNCTION aprt131_create_prbpseq()
   IF cl_null(g_prbp_d[l_ac].prbpseq) THEN
      SELECT max(prbpseq)+1 INTO g_prbp_d[l_ac].prbpseq
        FROM prbp_t
       WHERE prbpent=g_enterprise AND prbpdocno=g_prbo_m.prbodocno 
   END IF
   IF cl_null(g_prbp_d[l_ac].prbpseq) OR g_prbp_d[l_ac].prbpseq=0 THEN
      LET g_prbp_d[l_ac].prbpseq=1
   END IF
END FUNCTION
##display prbp002
PRIVATE FUNCTION aprt131_prbp001_ref()
   
      SELECT rtdx002 INTO g_prbp_d[l_ac].prbp002 FROM rtdx_t,imay_t
       WHERE rtdx001=imay001 AND rtdx002 = imay003 AND rtdxent=imayent 
         AND rtdx001 = g_prbp_d[l_ac].prbp001
         AND rtdxent = g_enterprise AND rtdxstus = 'Y' AND imaystus='Y'
      DISPLAY  g_prbp_d[l_ac].prbp002 TO s_detail1[l_ac].prbp002
    
   DISPLAY g_prbp_d[l_ac].prbp002 TO s_detail[l_ac].prbp002   
END FUNCTION
#display prbp001,prbp002,prbp003,imaal003,imaal004,imaa009
PRIVATE FUNCTION aprt131_prbp0011_ref()
DEFINE l_rtdx032   LIKE rtdx_t.rtdx032
DEFINE l_rtdx034   LIKE rtdx_t.rtdx034
DEFINE l_rtdx016   LIKE rtdx_t.rtdx016
DEFINE l_rtdx021   LIKE rtdx_t.rtdx021
   
   SELECT rtdx002 INTO g_prbp_d[l_ac].prbp002 FROM rtdx_t,imay_t
    WHERE rtdx001=imay001 AND rtdx002 = imay003 AND rtdxent=imayent 
      AND rtdx001 = g_prbp_d[l_ac].prbp001
      AND rtdxent = g_enterprise AND rtdxstus = 'Y' AND imaystus='Y'
   DISPLAY  g_prbp_d[l_ac].prbp002 TO s_detail1[l_ac].prbp002
      
   SELECT imaal003,imaal004 INTO g_prbp_d[l_ac].imaal003,g_prbp_d[l_ac].imaal004
     FROM imaal_t
    WHERE imaalent=g_enterprise AND imaal001= g_prbp_d[l_ac].prbp001
   SELECT imaa009 INTO g_prbp_d[l_ac].imaa009
     FROM imaa_t
    WHERE imaaent=g_enterprise AND imaa001= g_prbp_d[l_ac].prbp001
   SELECT rtaxl003 INTO g_prbp_d[l_ac].imaa009_desc
     FROM rtaxl_t
    WHERE rtaxlent=g_enterprise AND rtaxl001= g_prbp_d[l_ac].imaa009
      AND rtaxl002=g_dlang    
   #150312-00002#5 Modify-S By Ken 150317
   #SELECT rtdx033,rtdx034,rtdx016 
   #  INTO g_prbp_d[l_ac].prbp004,g_prbp_d[l_ac].prbp006,g_prbp_d[l_ac].prbp007
   #  FROM rtdx_t
   # WHERE rtdxent=g_enterprise AND rtdxsite=g_prbo_m.prbosite
   #   AND rtdx001 = g_prbp_d[l_ac].prbp001
#mark by yangxf ---start---
#   SELECT imaa106,rtdx034,rtdx016 
#     INTO g_prbp_d[l_ac].prbp004,g_prbp_d[l_ac].prbp006,g_prbp_d[l_ac].prbp007
#     FROM rtdx_t,imaa_t
#    WHERE rtdxent = imaaent AND rtdx001 = imaa001
#      AND rtdxent = g_enterprise AND rtdxsite = g_prbo_m.prbosite
#      AND rtdx001 = g_prbp_d[l_ac].prbp001
#mark by yangxf ----end---
#add by yangxf ----start----
   SELECT imaa106
     INTO g_prbp_d[l_ac].prbp004
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prbp_d[l_ac].prbp001
   #根據單頭日期獲取门店清单中日期范围内的最新进价，和最新促销价，如果促销进价为空，则取最新进价
   SELECT rtdx034 INTO l_rtdx034
     FROM rtdx_t
    WHERE rtdxent = = g_enterprise
      AND rtdxsite = g_prbo_m.prbosite
      AND rtdx001 = g_prbp_d[l_ac].prbp001
   SELECT rtdx032 INTO l_rtdx032
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_prbo_m.prbosite
      AND rtdx001 = g_prbp_d[l_ac].prbp001
      AND (rtdx041 BETWEEN g_prbo_m.prbo002 AND g_prbo_m.prbo003
       OR  rtdx042 BETWEEN g_prbo_m.prbo002 AND g_prbo_m.prbo003 
       OR  g_prbo_m.prbo002 BETWEEN rtdx041 AND rtdx042)
   IF NOT cl_null(l_rtdx032) THEN 
      LET g_prbp_d[l_ac].prbp006 = l_rtdx032
   ELSE
      LET g_prbp_d[l_ac].prbp006 = l_rtdx034
   END IF 
   #当前执行售价抓取门店清单中的售价，如果促销售价取促销售价
   SELECT rtdx016
     INTO l_rtdx016
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_prbo_m.prbosite
      AND rtdx001 = g_prbp_d[l_ac].prbp001
   SELECT rtdx021
     INTO l_rtdx021
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_prbo_m.prbosite
      AND rtdx001 = g_prbp_d[l_ac].prbp001
      AND (rtdx022 BETWEEN  g_prbo_m.prbo002 AND g_prbo_m.prbo003
       OR  rtdx023 BETWEEN g_prbo_m.prbo002 AND g_prbo_m.prbo003
       OR  g_prbo_m.prbo002 BETWEEN rtdx022 AND rtdx023)
   IF NOT cl_null(l_rtdx021) THEN 
      LET g_prbp_d[l_ac].prbp007 = l_rtdx021
   ELSE
      LET g_prbp_d[l_ac].prbp007 = l_rtdx016
   END IF 
#add by yangxf ----end------
   #150312-00002#5 Modify-E
   SELECT oocal003 INTO g_prbp_d[l_ac].prbp004_desc
     FROM oocal_t
    WHERE oocalent=g_enterprise AND oocal001= g_prbp_d[l_ac].prbp004
      AND oocal002=g_dlang    
   IF cl_null(g_prbp_d[l_ac].prbp007)  THEN
      LET g_prbp_d[l_ac].prbp007=0
   END IF   
   IF cl_null(g_prbp_d[l_ac].prbp007) OR g_prbp_d[l_ac].prbp007=0 THEN
   ELSE
      LET g_prbp_d[l_ac].prbp010=(g_prbp_d[l_ac].prbp007-g_prbp_d[l_ac].prbp006)/g_prbp_d[l_ac].prbp007*100  
   END IF 
   DISPLAY g_prbp_d[l_ac].imaal003,g_prbp_d[l_ac].imaal004,g_prbp_d[l_ac].imaa009,
           g_prbp_d[l_ac].imaa009_desc,g_prbp_d[l_ac].prbp004,g_prbp_d[l_ac].prbp004_desc,
           g_prbp_d[l_ac].prbp006, g_prbp_d[l_ac].prbp007,g_prbp_d[l_ac].prbp010
        TO s_detail1[l_ac].imaal003,s_detail1[l_ac].imaal004,s_detail1[l_ac].imaa009,
           s_detail1[l_ac].imaa009_desc,s_detail1[l_ac].prbp004,s_detail1[l_ac].prbp004_desc,
           s_detail1[l_ac].prbp006,s_detail1[l_ac].prbp007,s_detail1[l_ac].prbp010     
END FUNCTION
#display prbp002
PRIVATE FUNCTION aprt131_prbp002_ref()
   IF cl_null(g_prbp_d[l_ac].prbp001) THEN
      SELECT rtdx001 INTO g_prbp_d[l_ac].prbp001
        FROM rtdx_t LEFT JOIN imaa_t ON imaa001=rtdx001 AND imaaent=rtdxent
                    LEFT JOIN imay_t ON rtdx001=imay001 AND rtdxent=imayent
       WHERE imayent=g_enterprise AND imay003= g_prbp_d[l_ac].prbp002
         AND rtdxsite=g_prbo_m.prbosite AND imaastus='Y' AND rtdxstus='Y'       
   END IF
   DISPLAY g_prbp_d[l_ac].prbp001 TO s_detail[l_ac].prbp001
END FUNCTION
#chk prbp001
PRIVATE FUNCTION aprt131_unique_prbp001()
   DEFINE l_cnt LIKE type_t.num5
   LET g_errno = NULL
   LET l_cnt = 0
   SELECT count(*) INTO l_cnt FROM prbp_t WHERE prbpdocno = g_prbo_m.prbodocno
      AND prbpent = g_enterprise AND prbp001 = g_prbp_d[l_ac].prbp001
   IF l_cnt >0 THEN
      LET g_errno  = "art-00072"
   END IF
END FUNCTION
##null prbp001,imaal003,imaal004....
PRIVATE FUNCTION aprt131_null_prbp001()
   LET g_prbp_d[l_ac].imaal003 = NULL
   LET g_prbp_d[l_ac].imaal004 = NULL
   LET g_prbp_d[l_ac].imaa009 = NULL
   LET g_prbp_d[l_ac].imaa009_desc = NULL
   LET g_prbp_d[l_ac].prbp004 = NULL
   LET g_prbp_d[l_ac].prbp004_desc = NULL
   LET g_prbp_d[l_ac].prbp006 = NULL
   LET g_prbp_d[l_ac].prbp007 = NULL
   DISPLAY g_prbp_d[l_ac].imaal003,g_prbp_d[l_ac].imaal004,g_prbp_d[l_ac].imaa009,
           g_prbp_d[l_ac].imaa009_desc,g_prbp_d[l_ac].prbp004,g_prbp_d[l_ac].prbp004_desc,
           g_prbp_d[l_ac].prbp006, g_prbp_d[l_ac].prbp007
        TO s_detail1[l_ac].imaal003,s_detail1[l_ac].imaal004,s_detail1[l_ac].imaa009,
           s_detail1[l_ac].imaa009_desc,s_detail1[l_ac].prbp004,s_detail1[l_ac].prbp004_desc,
           s_detail1[l_ac].prbp006,s_detail1[l_ac].prbp007   
END FUNCTION
#chk prbp002
PRIVATE FUNCTION aprt131_chk_prbp002()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   DEFIne l_sql   string
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0  
   IF g_prbo_m.prbo001<>'ALL' THEN
      LET l_sql = " SELECT COUNT(*) ",
        " FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent ",
        "            LEFT JOIN imay_t ON imay001=rtdx001 AND imayent=rtdxent  ",
       #" WHERE imay003 = '",g_prbp_d[l_ac].prbp002,"' AND rtdxsite = '",g_prbo_m.prbosite,"'", #160905-00007#12  mark
       " WHERE imay003 = '",g_prbp_d[l_ac].prbp002,"' AND rtdxent = ",g_enterprise," AND rtdxsite = '",g_prbo_m.prbosite,"'", #160905-00007#12  add
       #"  AND imaa009  IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 ",  #160905-00007#12  mark
       "  AND imaa009  IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax005 = 0 ",  #160905-00007#12  add
       "                       START WITH rtax003 = '",g_prbo_m.prbo001,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
       "                       UNION ",
       #"                       SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbo_m.prbo001,"')"  #160905-00007#12 mark
       "                       SELECT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax001 = '",g_prbo_m.prbo001,"')"  #160905-00007#12 add
      PREPARE l_sql_prbp002_pre FROM l_sql
      EXECUTE l_sql_prbp002_pre INTO l_cnt      
      IF l_cnt <=0 THEN
         LET g_errno="art-00152"
      ELSE
         LET l_sql = " SELECT COUNT(*) ",
        " FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent ",
        "            LEFT JOIN imay_t ON imay001=rtdx001 AND imayent=rtdxent  ",
       #" WHERE imay003 = '",g_prbp_d[l_ac].prbp002,"' AND rtdxsite = '",g_prbo_m.prbosite,"'", #160905-00007#12  mark
       " WHERE imay003 = '",g_prbp_d[l_ac].prbp002,"' AND rtdxent = ",g_enterprise," AND rtdxsite = '",g_prbo_m.prbosite,"'", #160905-00007#12  add
      # "  AND imaa009  IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 ",  #160905-00007#12  mark
       "  AND imaa009  IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax005 = 0 ",  #160905-00007#12  add
       "                       START WITH rtax003 = '",g_prbo_m.prbo001,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
       "                       UNION ",
       #"                       SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbo_m.prbo001,"')",  #160905-00007#12 mark
       "                       SELECT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax001 = '",g_prbo_m.prbo001,"')",  #160905-00007#12 add
       "     AND rtdxstus='Y' AND imaystus='Y' AND imaastus='Y'"
         PREPARE l_sql_prbp002_pre2 FROM l_sql
         EXECUTE l_sql_prbp002_pre2 INTO l_cnt1
         IF l_cnt1<=0 THEN
            LET g_errno="art-00153"
         END IF      
      END IF
   ELSE
      SELECT COUNT(*) INTO l_cnt
        FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent 
                    LEFT JOIN imay_t ON imay001=rtdx001 AND imayent=rtdxent
       WHERE imay003 = g_prbp_d[l_ac].prbp002 AND rtdxsite = g_prbo_m.prbosite
      IF l_cnt <=0 THEN
         LET g_errno="art-00152"
      ELSE
         SELECT COUNT(*) INTO l_cnt1
           FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent 
                       LEFT JOIN imay_t ON imay001=rtdx001 AND imayent=rtdxent
          WHERE imay003 = g_prbp_d[l_ac].prbp002 AND rtdxsite = g_prbo_m.prbosite
            AND rtdxstus='Y' AND imaystus='Y' AND imaastus='Y'
         IF l_cnt1<=0 THEN
            LET g_errno="art-00153"
         END IF      
      END IF
   END IF 
END FUNCTION
#chk prbp001,prbp002
PRIVATE FUNCTION aprt131_chk_prbp0012()
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_cnt1       LIKE type_t.num5


   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0 
   IF NOT cl_null(g_prbp_d[l_ac].prbp002) AND NOT cl_null(g_prbp_d[l_ac].prbp001) THEN
      SELECT COUNT(*) INTO l_cnt
        FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent 
                    LEFT JOIN imay_t ON imay001=rtdx001 AND rtdxent=imayent 
       WHERE rtdx001 = g_prbp_d[l_ac].prbp001 
         AND imay003 = g_prbp_d[l_ac].prbp002 
         AND rtdxsite = g_prbo_m.prbosite
         
      IF l_cnt <=0 THEN
         LET g_errno="art-00286"
      ELSE
         SELECT COUNT(*) INTO l_cnt1
           FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent 
                       LEFT JOIN imay_t ON imay001=rtdx001 AND rtdxent=imayent
          WHERE rtdx001 = g_prbp_d[l_ac].prbp001 
            AND imay003 = g_prbp_d[l_ac].prbp002 
            AND rtdxsite = g_prbo_m.prbosite
            AND rtdxstus='Y' AND imaystus='Y' AND imaastus='Y'
         IF l_cnt1<=0 THEN
            LET g_errno="art-00153"
         END IF      
      END IF
        
   END IF
        
END FUNCTION
#display prbo008
PRIVATE FUNCTION aprt131_sum_prbo008()
   DEFINE  l_prbo008   LIKE prbo_t.prbo008
   DEFINE  l_prbo009   LIKE prbo_t.prbo009 
   DEFINE  l_prbo010   LIKE prbo_t.prbo010   
   
   SELECT sum(prbp007*prbp005),sum(prbp005*prbp007),sum(prbp005*prbp006) 
     INTO l_prbo008,l_prbo009,l_prbo010 
     FROM prbp_t 
    WHERE prbpent=g_enterprise
      AND prbpdocno=g_prbo_m.prbodocno
   LET g_prbo_m.prbo008= l_prbo008- g_prbo_m.prbo006   
   IF cl_null(l_prbo009) OR l_prbo009=0 THEN
      LET g_prbo_m.prbo009=100
   ELSE   
      LET g_prbo_m.prbo009= g_prbo_m.prbo006/l_prbo009*100     #add by pengxin  20160317 (*100)
   END IF 
   LET g_prbo_m.prbo010= l_prbo010

   IF cl_null(g_prbo_m.prbo006) OR g_prbo_m.prbo006=0 THEN
      LET g_prbo_m.prbo011=0
   ELSE
      LET g_prbo_m.prbo011=(g_prbo_m.prbo006-g_prbo_m.prbo010)/g_prbo_m.prbo006*100
   END IF   
END FUNCTION
#create prbo004
PRIVATE FUNCTION aprt131_create_prbo004(p_type)
DEFINE p_type like rtaj_t.rtaj001
DEFINE l_rtaj002 LIKE rtaj_t.rtaj002
DEFINE l_rtaj003 LIKE rtaj_t.rtaj003
DEFINE l_rtaj021 LIKE rtaj_t.rtaj021
DEFINE l_rtaj011 LIKE rtaj_t.rtaj011
DEFINE l_rtaj012 LIKE rtaj_t.rtaj012
DEFINE l_rtaj007 LIKE rtaj_t.rtaj007
DEFINE i         LIKE type_t.num5
DEFINE l_serial  STRING
DEFINE l_string  STRING
DEFINE l_n1      LIKE type_t.num5
DEFINE l_n2      LIKE type_t.num5
DEFINE l_n3      LIKE type_t.num5
DEFINE l_sum     LIKE type_t.num5
DEFINE l_str1    LIKE type_t.chr1
DEFINE l_mod      LIKE type_t.num5
DEFINE r_prbo004 LIKE type_t.chr50
DEFINE r_success LIKE type_t.num5
DEFINE l_number  LIKE type_t.num5
DEFINE l_num     DYNAMIC ARRAY OF RECORD
       number    LIKE type_t.num5
                 END RECORD

   LET r_success=true
   SELECT rtaj021,rtaj011,rtaj012,rtaj007 INTO l_rtaj021,l_rtaj011,l_rtaj012,l_rtaj007 FROM rtaj_t
    WHERE rtajent=g_enterprise AND rtaj001=p_type
   IF cl_null(l_rtaj021) THEN
#      #偶數和
#      LET l_n2=1+2
#      #奇數和
#      LET l_n1=2
#      LET l_n3=3*3+2
#      LET l_n3=1
#      LET l_n3=10-l_n3
#      LET l_str1=l_n3
      LET l_num[1].number=2
      LET l_num[2].number=3
      FOR i= l_rtaj011 TO l_rtaj012   
         LET l_num[i].number=0
      END FOR
      #偶數和
      FOR i=0 TO (l_rtaj012/2)
         LET l_n2=l_n2+l_num[i*2+1].number
      END FOR
      #奇數和
      FOR i=1 TO (l_rtaj012/2)
         LET l_n1=l_n1+l_num[i*2].number
      END FOR
      LET l_n3=l_n2*3
      LET l_sum=l_n3+l_n1
      LET l_mod = l_sum MOD 10
      LET l_sum=10-l_mod
      LET r_prbo004='23'
      FOR i= l_rtaj011 TO l_rtaj012
         LET l_str1=l_num[i].number      
         LET r_prbo004=r_prbo004,l_str1
      END FOR 
      LET l_str1=l_sum       
      LET r_prbo004=r_prbo004,l_str1
   ELSE
      LET l_string = l_rtaj021
      LET l_number = l_string.subString(l_rtaj011,l_rtaj012)+1
      LET l_serial=l_number
      FOR i=1 TO l_serial.getLength()
         LET l_num[l_rtaj012-i+1].number=l_serial.subString(l_serial.getLength()-i+1,l_serial.getLength()-i+1)
      END FOR
      FOR i= l_rtaj011 TO l_rtaj012-l_serial.getLength()     
         LET l_num[i].number=0
      END FOR
      LET l_num[1].number=2
      LET l_num[2].number=3
      #偶數和
      FOR i=0 TO (l_rtaj012/2)
         LET l_n2=l_n2+l_num[i*2+1].number
      END FOR
      #奇數和
      FOR i=1 TO (l_rtaj012/2)
         LET l_n1=l_n1+l_num[i*2].number
      END FOR
      LET l_n3=l_n2*3
      LET l_sum=l_n3+l_n1
      LET l_mod = l_sum MOD 10
      LET l_sum=10-l_mod 
      LET r_prbo004='23'
      FOR i= l_rtaj011 TO l_rtaj012
         LET l_str1=l_num[i].number      
         LET r_prbo004=r_prbo004,l_str1
      END FOR
      LET l_str1=l_sum
      LET r_prbo004=r_prbo004,l_str1
   END IF
   UPDATE rtaj_t SET rtaj021=r_prbo004
    WHERE rtajent=g_enterprise
      AND rtaj001=p_type
   IF SQLCA.sqlcode THEN
      LET r_success=false
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_prbo004,r_success
   END IF    
   RETURN r_prbo004,r_success
END FUNCTION
#sum prbp008,prbp009
PRIVATE FUNCTION aprt131_sum_prbp008()
   DEFINE l_sum_prbp007  LIKE prbp_t.prbp007
   UPDATE prbo_t SET prbo008=g_prbo_m.prbo008,
                     prbo009=g_prbo_m.prbo009,
                     prbo010=g_prbo_m.prbo010,
                     prbo011=g_prbo_m.prbo011
    WHERE prboent=g_enterprise AND prbodocno=g_prbo_m.prbodocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "aprt131"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE    
      SELECT sum(prbp007*prbp005) INTO l_sum_prbp007 
        FROM prbp_t 
       WHERE prbpent=g_enterprise
         AND prbpdocno=g_prbo_m.prbodocno
      
   
      UPDATE prbp_t SET prbp008=(prbp007*prbp005)/l_sum_prbp007*(l_sum_prbp007-g_prbo_m.prbo006),
                        prbp009=(prbp007*prbp005-((prbp007*prbp005)/l_sum_prbp007*(l_sum_prbp007-g_prbo_m.prbo006)))/nvl((prbp007*prbp005),1)*100  #add by pengxin   20160318  (*100)
       WHERE prbpent=g_enterprise
         AND prbpdocno=g_prbo_m.prbodocno 
      IF SQLCA.sqlcode THEN
      END IF
            
   END IF         
END FUNCTION

#chk prbo001
PRIVATE FUNCTION aprt131_chk_prbo001()
   DEFINE l_cnt  like type_t.num5
   DEFINE l_cnt1  like type_t.num5
   DEFINE l_sql  STRING
   LET g_errno=null
   
   LET l_sql=" SELECT count(*) FROM prbp_t LEFT JOIN imaa_t ON prbpent=imaaent AND prbp001=imaa001",
    #" WHERE prbpent=g_enterprise AND prbpdocno = '",g_prbo_m.prbodocno,"'",            #150512-00027#1--mark by dongsz
    " WHERE prbpent=",g_enterprise," AND prbpdocno = '",g_prbo_m.prbodocno,"'",             #150512-00027#1--add by dongsz
    #"  AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 START WITH rtax003 = '",g_prbo_m.prbo001,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 UNION SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbo_m.prbo001,"')" #160905-00007#12  mark
    "  AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax005 = 0 START WITH rtax003 = '",g_prbo_m.prbo001,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 UNION SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbo_m.prbo001,"')" #160905-00007#12  add
   PREPARE l_sql_prbp001_pre FROM l_sql
   EXECUTE l_sql_prbp001_pre INTO l_cnt   
   SELECT count(*) INTO l_cnt1 FROM prbp_t LEFT JOIN imaa_t ON prbpent=imaaent AND prbp001=imaa001
    WHERE prbpent=g_enterprise AND prbpdocno = g_prbo_m.prbodocno
   IF cl_null(l_cnt) THEN
      LET l_cnt=0
   END IF
   IF cl_null(l_cnt1) THEN
      LET l_cnt1=0
   END IF    
   IF l_cnt<>l_cnt1 THEN
      LET g_errno="apr-00062"
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 單頭和單身稅別檢查
# Memo...........:
# Usage..........: CALL aprt131_chek_prbo015(p_prbp001)
# Input parameter: p_prbp001  商品編號
# Return code....: r_success  TRUE/FALSE
#                : r_errno    錯誤信息代碼
# Date & Author..: 20150527 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt131_chek_prbo015(p_prbp001)
DEFINE p_prbp001    LIKE prbp_t.prbp001
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      STRING
DEFINE l_rtdx014    LIKE rtdx_t.rtdx014


   LET r_success=TRUE
   SELECT rtdx014 INTO l_rtdx014
     FROM rtdx_t
    WHERE rtdxent=g_enterprise
      AND rtdxsite=g_prbo_m.prbosite
      AND rtdx001=p_prbp001
   IF l_rtdx014<>g_prbo_m.prbo015 THEN
      LET r_success=FALSE
      LET r_errno="apr-00400"
      RETURN r_success,r_errno
   END IF 

   RETURN r_success,r_errno
   
END FUNCTION

 
{</section>}
 
