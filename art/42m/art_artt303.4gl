#該程式未解開Section, 採用最新樣板產出!
{<section id="artt303.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-08-20 16:01:00), PR版次:0006(2016-11-29 09:35:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: artt303
#+ Description: 商品主供應商調整作業
#+ Creator....: 03247(2015-08-20 15:35:36)
#+ Modifier...: 03247 -SD/PR- 06814
 
{</section>}
 
{<section id="artt303.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#33   2016/04/13   By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160816-00068#10   2016/08/17   By 08209    調整transaction
#160818-00017#34   2016/08/24   By 08734    删除修改未重新判断状态码
#160824-00007#164  2016/11/29   By 06814    新舊值相關
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
PRIVATE type type_g_rtbg_m        RECORD
       rtbgsite LIKE rtbg_t.rtbgsite, 
   rtbgsite_desc LIKE type_t.chr80, 
   rtbgdocdt LIKE rtbg_t.rtbgdocdt, 
   rtbgdocno LIKE rtbg_t.rtbgdocno, 
   rtbg001 LIKE rtbg_t.rtbg001, 
   rtbg001_desc LIKE type_t.chr80, 
   rtbg002 LIKE rtbg_t.rtbg002, 
   rtbg002_desc LIKE type_t.chr80, 
   rtbg003 LIKE rtbg_t.rtbg003, 
   rtbgunit LIKE rtbg_t.rtbgunit, 
   rtbgstus LIKE rtbg_t.rtbgstus, 
   rtbgownid LIKE rtbg_t.rtbgownid, 
   rtbgownid_desc LIKE type_t.chr80, 
   rtbgowndp LIKE rtbg_t.rtbgowndp, 
   rtbgowndp_desc LIKE type_t.chr80, 
   rtbgcrtid LIKE rtbg_t.rtbgcrtid, 
   rtbgcrtid_desc LIKE type_t.chr80, 
   rtbgcrtdp LIKE rtbg_t.rtbgcrtdp, 
   rtbgcrtdp_desc LIKE type_t.chr80, 
   rtbgcrtdt LIKE rtbg_t.rtbgcrtdt, 
   rtbgmodid LIKE rtbg_t.rtbgmodid, 
   rtbgmodid_desc LIKE type_t.chr80, 
   rtbgmoddt LIKE rtbg_t.rtbgmoddt, 
   rtbgcnfid LIKE rtbg_t.rtbgcnfid, 
   rtbgcnfid_desc LIKE type_t.chr80, 
   rtbgcnfdt LIKE rtbg_t.rtbgcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtbh_d        RECORD
       rtbhseq LIKE rtbh_t.rtbhseq, 
   rtbhsite LIKE rtbh_t.rtbhsite, 
   rtbhsite_desc LIKE type_t.chr500, 
   rtbh001 LIKE rtbh_t.rtbh001, 
   rtbh002 LIKE rtbh_t.rtbh002, 
   rtbh002_desc LIKE type_t.chr500, 
   rtbh002_desc_desc LIKE type_t.chr500, 
   rtbh003 LIKE rtbh_t.rtbh003, 
   rtbh003_desc LIKE type_t.chr500, 
   rtbh004 LIKE rtbh_t.rtbh004, 
   rtbh004_desc LIKE type_t.chr500, 
   rtbh005 LIKE rtbh_t.rtbh005, 
   rtbh005_desc LIKE type_t.chr500, 
   rtbh006 LIKE rtbh_t.rtbh006, 
   rtbh006_desc LIKE type_t.chr500, 
   rtbh007 LIKE rtbh_t.rtbh007, 
   rtbh008 LIKE rtbh_t.rtbh008, 
   rtbhunit LIKE rtbh_t.rtbhunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtbgsite LIKE rtbg_t.rtbgsite,
   b_rtbgsite_desc LIKE type_t.chr80,
      b_rtbgdocdt LIKE rtbg_t.rtbgdocdt,
      b_rtbgdocno LIKE rtbg_t.rtbgdocno,
      b_rtbg001 LIKE rtbg_t.rtbg001,
   b_rtbg001_desc LIKE type_t.chr80,
      b_rtbg002 LIKE rtbg_t.rtbg002,
   b_rtbg002_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtbg_m          type_g_rtbg_m
DEFINE g_rtbg_m_t        type_g_rtbg_m
DEFINE g_rtbg_m_o        type_g_rtbg_m
DEFINE g_rtbg_m_mask_o   type_g_rtbg_m #轉換遮罩前資料
DEFINE g_rtbg_m_mask_n   type_g_rtbg_m #轉換遮罩後資料
 
   DEFINE g_rtbgdocno_t LIKE rtbg_t.rtbgdocno
 
 
DEFINE g_rtbh_d          DYNAMIC ARRAY OF type_g_rtbh_d
DEFINE g_rtbh_d_t        type_g_rtbh_d
DEFINE g_rtbh_d_o        type_g_rtbh_d
DEFINE g_rtbh_d_mask_o   DYNAMIC ARRAY OF type_g_rtbh_d #轉換遮罩前資料
DEFINE g_rtbh_d_mask_n   DYNAMIC ARRAY OF type_g_rtbh_d #轉換遮罩後資料
 
 
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
 
{<section id="artt303.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rtbgsite,'',rtbgdocdt,rtbgdocno,rtbg001,'',rtbg002,'',rtbg003,rtbgunit, 
       rtbgstus,rtbgownid,'',rtbgowndp,'',rtbgcrtid,'',rtbgcrtdp,'',rtbgcrtdt,rtbgmodid,'',rtbgmoddt, 
       rtbgcnfid,'',rtbgcnfdt", 
                      " FROM rtbg_t",
                      " WHERE rtbgent= ? AND rtbgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt303_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtbgsite,t0.rtbgdocdt,t0.rtbgdocno,t0.rtbg001,t0.rtbg002,t0.rtbg003, 
       t0.rtbgunit,t0.rtbgstus,t0.rtbgownid,t0.rtbgowndp,t0.rtbgcrtid,t0.rtbgcrtdp,t0.rtbgcrtdt,t0.rtbgmodid, 
       t0.rtbgmoddt,t0.rtbgcnfid,t0.rtbgcnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM rtbg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtbg001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtbg002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtbgownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtbgowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtbgcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.rtbgcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtbgmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rtbgcnfid  ",
 
               " WHERE t0.rtbgent = " ||g_enterprise|| " AND t0.rtbgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt303_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt303 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt303_init()   
 
      #進入選單 Menu (="N")
      CALL artt303_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt303
      
   END IF 
   
   CLOSE artt303_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt303.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt303_init()
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
      CALL cl_set_combo_scc_part('rtbgstus','13','N,Y,X,A,D,R,W')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
   #初始化搜尋條件
   CALL artt303_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt303.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt303_ui_dialog()
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
            CALL artt303_insert()
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
         INITIALIZE g_rtbg_m.* TO NULL
         CALL g_rtbh_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt303_init()
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
               
               CALL artt303_fetch('') # reload data
               LET l_ac = 1
               CALL artt303_ui_detailshow() #Setting the current row 
         
               CALL artt303_idx_chk()
               #NEXT FIELD rtbhseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtbh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt303_idx_chk()
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
               CALL artt303_idx_chk()
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
            CALL artt303_browser_fill("")
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
               CALL artt303_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt303_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt303_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt303_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt303_set_act_visible()   
            CALL artt303_set_act_no_visible()
            IF NOT (g_rtbg_m.rtbgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtbgent = " ||g_enterprise|| " AND",
                                  " rtbgdocno = '", g_rtbg_m.rtbgdocno, "' "
 
               #填到對應位置
               CALL artt303_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "rtbg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtbh_t" 
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
               CALL artt303_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rtbg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtbh_t" 
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
                  CALL artt303_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt303_fetch("F")
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
               CALL artt303_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt303_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt303_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt303_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt303_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt303_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt303_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt303_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt303_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt303_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt303_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtbh_d)
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
               NEXT FIELD rtbhseq
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
               CALL artt303_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt303_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt303_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt303_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/art/artt303_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/art/artt303_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt303_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt303_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt303_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt303_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt303_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtbg_m.rtbgdocdt)
 
 
 
         
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
 
{<section id="artt303.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt303_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'rtbgsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rtbgdocno ",
                      " FROM rtbg_t ",
                      " ",
                      " LEFT JOIN rtbh_t ON rtbhent = rtbgent AND rtbgdocno = rtbhdocno ", "  ",
                      #add-point:browser_fill段sql(rtbh_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE rtbgent = " ||g_enterprise|| " AND rtbhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtbg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtbgdocno ",
                      " FROM rtbg_t ", 
                      "  ",
                      "  ",
                      " WHERE rtbgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtbg_t")
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
      INITIALIZE g_rtbg_m.* TO NULL
      CALL g_rtbh_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtbgsite,t0.rtbgdocdt,t0.rtbgdocno,t0.rtbg001,t0.rtbg002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtbgstus,t0.rtbgsite,t0.rtbgdocdt,t0.rtbgdocno,t0.rtbg001,t0.rtbg002, 
          t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM rtbg_t t0",
                  "  ",
                  "  LEFT JOIN rtbh_t ON rtbhent = rtbgent AND rtbgdocno = rtbhdocno ", "  ", 
                  #add-point:browser_fill段sql(rtbh_t1) name="browser_fill.join.rtbh_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtbg001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtbg002 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtbgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtbg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtbgstus,t0.rtbgsite,t0.rtbgdocdt,t0.rtbgdocno,t0.rtbg001,t0.rtbg002, 
          t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM rtbg_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtbg001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtbg002 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtbgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtbg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtbgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtbg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtbgsite,g_browser[g_cnt].b_rtbgdocdt, 
          g_browser[g_cnt].b_rtbgdocno,g_browser[g_cnt].b_rtbg001,g_browser[g_cnt].b_rtbg002,g_browser[g_cnt].b_rtbgsite_desc, 
          g_browser[g_cnt].b_rtbg001_desc,g_browser[g_cnt].b_rtbg002_desc
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
         CALL artt303_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_rtbgdocno) THEN
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
 
{<section id="artt303.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt303_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtbg_m.rtbgdocno = g_browser[g_current_idx].b_rtbgdocno   
 
   EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
       g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
       g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid_desc, 
       g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc
   
   CALL artt303_rtbg_t_mask()
   CALL artt303_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt303.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt303_ui_detailshow()
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
 
{<section id="artt303.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt303_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtbgdocno = g_rtbg_m.rtbgdocno 
 
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
 
{<section id="artt303.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt303_construct()
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
   INITIALIZE g_rtbg_m.* TO NULL
   CALL g_rtbh_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON rtbgsite,rtbgdocdt,rtbgdocno,rtbg001,rtbg002,rtbg003,rtbgunit,rtbgstus, 
          rtbgownid,rtbgowndp,rtbgcrtid,rtbgcrtdp,rtbgcrtdt,rtbgmodid,rtbgmoddt,rtbgcnfid,rtbgcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtbgcrtdt>>----
         AFTER FIELD rtbgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtbgmoddt>>----
         AFTER FIELD rtbgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtbgcnfdt>>----
         AFTER FIELD rtbgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtbgpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgsite
            #add-point:ON ACTION controlp INFIELD rtbgsite name="construct.c.rtbgsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbgsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgsite  #顯示到畫面上
            NEXT FIELD rtbgsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgsite
            #add-point:BEFORE FIELD rtbgsite name="construct.b.rtbgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgsite
            
            #add-point:AFTER FIELD rtbgsite name="construct.a.rtbgsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgdocdt
            #add-point:BEFORE FIELD rtbgdocdt name="construct.b.rtbgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgdocdt
            
            #add-point:AFTER FIELD rtbgdocdt name="construct.a.rtbgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgdocdt
            #add-point:ON ACTION controlp INFIELD rtbgdocdt name="construct.c.rtbgdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgdocno
            #add-point:ON ACTION controlp INFIELD rtbgdocno name="construct.c.rtbgdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtbgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgdocno  #顯示到畫面上
            NEXT FIELD rtbgdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgdocno
            #add-point:BEFORE FIELD rtbgdocno name="construct.b.rtbgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgdocno
            
            #add-point:AFTER FIELD rtbgdocno name="construct.a.rtbgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbg001
            #add-point:ON ACTION controlp INFIELD rtbg001 name="construct.c.rtbg001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbg001  #顯示到畫面上
            NEXT FIELD rtbg001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbg001
            #add-point:BEFORE FIELD rtbg001 name="construct.b.rtbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbg001
            
            #add-point:AFTER FIELD rtbg001 name="construct.a.rtbg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbg002
            #add-point:ON ACTION controlp INFIELD rtbg002 name="construct.c.rtbg002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbg002  #顯示到畫面上
            NEXT FIELD rtbg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbg002
            #add-point:BEFORE FIELD rtbg002 name="construct.b.rtbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbg002
            
            #add-point:AFTER FIELD rtbg002 name="construct.a.rtbg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbg003
            #add-point:BEFORE FIELD rtbg003 name="construct.b.rtbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbg003
            
            #add-point:AFTER FIELD rtbg003 name="construct.a.rtbg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbg003
            #add-point:ON ACTION controlp INFIELD rtbg003 name="construct.c.rtbg003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgunit
            #add-point:BEFORE FIELD rtbgunit name="construct.b.rtbgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgunit
            
            #add-point:AFTER FIELD rtbgunit name="construct.a.rtbgunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgunit
            #add-point:ON ACTION controlp INFIELD rtbgunit name="construct.c.rtbgunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgstus
            #add-point:BEFORE FIELD rtbgstus name="construct.b.rtbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgstus
            
            #add-point:AFTER FIELD rtbgstus name="construct.a.rtbgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgstus
            #add-point:ON ACTION controlp INFIELD rtbgstus name="construct.c.rtbgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgownid
            #add-point:ON ACTION controlp INFIELD rtbgownid name="construct.c.rtbgownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgownid  #顯示到畫面上
            NEXT FIELD rtbgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgownid
            #add-point:BEFORE FIELD rtbgownid name="construct.b.rtbgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgownid
            
            #add-point:AFTER FIELD rtbgownid name="construct.a.rtbgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgowndp
            #add-point:ON ACTION controlp INFIELD rtbgowndp name="construct.c.rtbgowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgowndp  #顯示到畫面上
            NEXT FIELD rtbgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgowndp
            #add-point:BEFORE FIELD rtbgowndp name="construct.b.rtbgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgowndp
            
            #add-point:AFTER FIELD rtbgowndp name="construct.a.rtbgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgcrtid
            #add-point:ON ACTION controlp INFIELD rtbgcrtid name="construct.c.rtbgcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgcrtid  #顯示到畫面上
            NEXT FIELD rtbgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgcrtid
            #add-point:BEFORE FIELD rtbgcrtid name="construct.b.rtbgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgcrtid
            
            #add-point:AFTER FIELD rtbgcrtid name="construct.a.rtbgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtbgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgcrtdp
            #add-point:ON ACTION controlp INFIELD rtbgcrtdp name="construct.c.rtbgcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgcrtdp  #顯示到畫面上
            NEXT FIELD rtbgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgcrtdp
            #add-point:BEFORE FIELD rtbgcrtdp name="construct.b.rtbgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgcrtdp
            
            #add-point:AFTER FIELD rtbgcrtdp name="construct.a.rtbgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgcrtdt
            #add-point:BEFORE FIELD rtbgcrtdt name="construct.b.rtbgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgmodid
            #add-point:ON ACTION controlp INFIELD rtbgmodid name="construct.c.rtbgmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgmodid  #顯示到畫面上
            NEXT FIELD rtbgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgmodid
            #add-point:BEFORE FIELD rtbgmodid name="construct.b.rtbgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgmodid
            
            #add-point:AFTER FIELD rtbgmodid name="construct.a.rtbgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgmoddt
            #add-point:BEFORE FIELD rtbgmoddt name="construct.b.rtbgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtbgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgcnfid
            #add-point:ON ACTION controlp INFIELD rtbgcnfid name="construct.c.rtbgcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbgcnfid  #顯示到畫面上
            NEXT FIELD rtbgcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgcnfid
            #add-point:BEFORE FIELD rtbgcnfid name="construct.b.rtbgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgcnfid
            
            #add-point:AFTER FIELD rtbgcnfid name="construct.a.rtbgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgcnfdt
            #add-point:BEFORE FIELD rtbgcnfdt name="construct.b.rtbgcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtbhseq,rtbhsite,rtbh001,rtbh002,rtbh003,rtbh004,rtbh005,rtbh006,rtbh007, 
          rtbh008,rtbhunit
           FROM s_detail1[1].rtbhseq,s_detail1[1].rtbhsite,s_detail1[1].rtbh001,s_detail1[1].rtbh002, 
               s_detail1[1].rtbh003,s_detail1[1].rtbh004,s_detail1[1].rtbh005,s_detail1[1].rtbh006,s_detail1[1].rtbh007, 
               s_detail1[1].rtbh008,s_detail1[1].rtbhunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbhseq
            #add-point:BEFORE FIELD rtbhseq name="construct.b.page1.rtbhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbhseq
            
            #add-point:AFTER FIELD rtbhseq name="construct.a.page1.rtbhseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbhseq
            #add-point:ON ACTION controlp INFIELD rtbhseq name="construct.c.page1.rtbhseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtbhsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbhsite
            #add-point:ON ACTION controlp INFIELD rtbhsite name="construct.c.page1.rtbhsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbgsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbhsite  #顯示到畫面上
            NEXT FIELD rtbhsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbhsite
            #add-point:BEFORE FIELD rtbhsite name="construct.b.page1.rtbhsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbhsite
            
            #add-point:AFTER FIELD rtbhsite name="construct.a.page1.rtbhsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh001
            #add-point:ON ACTION controlp INFIELD rtbh001 name="construct.c.page1.rtbh001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stas003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh001  #顯示到畫面上
            NEXT FIELD rtbh001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh001
            #add-point:BEFORE FIELD rtbh001 name="construct.b.page1.rtbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh001
            
            #add-point:AFTER FIELD rtbh001 name="construct.a.page1.rtbh001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh002
            #add-point:ON ACTION controlp INFIELD rtbh002 name="construct.c.page1.rtbh002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stas003()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO rtbh002  #顯示到畫面上
            NEXT FIELD rtbh002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh002
            #add-point:BEFORE FIELD rtbh002 name="construct.b.page1.rtbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh002
            
            #add-point:AFTER FIELD rtbh002 name="construct.a.page1.rtbh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh003
            #add-point:ON ACTION controlp INFIELD rtbh003 name="construct.c.page1.rtbh003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh003  #顯示到畫面上
            NEXT FIELD rtbh003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh003
            #add-point:BEFORE FIELD rtbh003 name="construct.b.page1.rtbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh003
            
            #add-point:AFTER FIELD rtbh003 name="construct.a.page1.rtbh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh004
            #add-point:ON ACTION controlp INFIELD rtbh004 name="construct.c.page1.rtbh004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh004  #顯示到畫面上
            NEXT FIELD rtbh004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh004
            #add-point:BEFORE FIELD rtbh004 name="construct.b.page1.rtbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh004
            
            #add-point:AFTER FIELD rtbh004 name="construct.a.page1.rtbh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh005
            #add-point:ON ACTION controlp INFIELD rtbh005 name="construct.c.page1.rtbh005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh005  #顯示到畫面上
            NEXT FIELD rtbh005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh005
            #add-point:BEFORE FIELD rtbh005 name="construct.b.page1.rtbh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh005
            
            #add-point:AFTER FIELD rtbh005 name="construct.a.page1.rtbh005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh006
            #add-point:ON ACTION controlp INFIELD rtbh006 name="construct.c.page1.rtbh006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh006  #顯示到畫面上
            NEXT FIELD rtbh006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh006
            #add-point:BEFORE FIELD rtbh006 name="construct.b.page1.rtbh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh006
            
            #add-point:AFTER FIELD rtbh006 name="construct.a.page1.rtbh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh007
            #add-point:ON ACTION controlp INFIELD rtbh007 name="construct.c.page1.rtbh007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stan001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh007  #顯示到畫面上
            NEXT FIELD rtbh007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh007
            #add-point:BEFORE FIELD rtbh007 name="construct.b.page1.rtbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh007
            
            #add-point:AFTER FIELD rtbh007 name="construct.a.page1.rtbh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh008
            #add-point:ON ACTION controlp INFIELD rtbh008 name="construct.c.page1.rtbh008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stan001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtbh008  #顯示到畫面上
            NEXT FIELD rtbh008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh008
            #add-point:BEFORE FIELD rtbh008 name="construct.b.page1.rtbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh008
            
            #add-point:AFTER FIELD rtbh008 name="construct.a.page1.rtbh008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbhunit
            #add-point:BEFORE FIELD rtbhunit name="construct.b.page1.rtbhunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbhunit
            
            #add-point:AFTER FIELD rtbhunit name="construct.a.page1.rtbhunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtbhunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbhunit
            #add-point:ON ACTION controlp INFIELD rtbhunit name="construct.c.page1.rtbhunit"
            
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
                  WHEN la_wc[li_idx].tableid = "rtbg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtbh_t" 
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
 
{<section id="artt303.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt303_filter()
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
      CONSTRUCT g_wc_filter ON rtbgsite,rtbgdocdt,rtbgdocno,rtbg001,rtbg002
                          FROM s_browse[1].b_rtbgsite,s_browse[1].b_rtbgdocdt,s_browse[1].b_rtbgdocno, 
                              s_browse[1].b_rtbg001,s_browse[1].b_rtbg002
 
         BEFORE CONSTRUCT
               DISPLAY artt303_filter_parser('rtbgsite') TO s_browse[1].b_rtbgsite
            DISPLAY artt303_filter_parser('rtbgdocdt') TO s_browse[1].b_rtbgdocdt
            DISPLAY artt303_filter_parser('rtbgdocno') TO s_browse[1].b_rtbgdocno
            DISPLAY artt303_filter_parser('rtbg001') TO s_browse[1].b_rtbg001
            DISPLAY artt303_filter_parser('rtbg002') TO s_browse[1].b_rtbg002
      
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
 
      CALL artt303_filter_show('rtbgsite')
   CALL artt303_filter_show('rtbgdocdt')
   CALL artt303_filter_show('rtbgdocno')
   CALL artt303_filter_show('rtbg001')
   CALL artt303_filter_show('rtbg002')
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt303_filter_parser(ps_field)
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
 
{<section id="artt303.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt303_filter_show(ps_field)
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
   LET ls_condition = artt303_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt303_query()
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
   CALL g_rtbh_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt303_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt303_browser_fill("")
      CALL artt303_fetch("")
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
      CALL artt303_filter_show('rtbgsite')
   CALL artt303_filter_show('rtbgdocdt')
   CALL artt303_filter_show('rtbgdocno')
   CALL artt303_filter_show('rtbg001')
   CALL artt303_filter_show('rtbg002')
   CALL artt303_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt303_fetch("F") 
      #顯示單身筆數
      CALL artt303_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt303_fetch(p_flag)
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
   
   LET g_rtbg_m.rtbgdocno = g_browser[g_current_idx].b_rtbgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
       g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
       g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid_desc, 
       g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc
   
   #遮罩相關處理
   LET g_rtbg_m_mask_o.* =  g_rtbg_m.*
   CALL artt303_rtbg_t_mask()
   LET g_rtbg_m_mask_n.* =  g_rtbg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt303_set_act_visible()   
   CALL artt303_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtbg_m_t.* = g_rtbg_m.*
   LET g_rtbg_m_o.* = g_rtbg_m.*
   
   LET g_data_owner = g_rtbg_m.rtbgownid      
   LET g_data_dept  = g_rtbg_m.rtbgowndp
   
   #重新顯示   
   CALL artt303_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt303_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtbh_d.clear()   
 
 
   INITIALIZE g_rtbg_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtbgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtbg_m.rtbgownid = g_user
      LET g_rtbg_m.rtbgowndp = g_dept
      LET g_rtbg_m.rtbgcrtid = g_user
      LET g_rtbg_m.rtbgcrtdp = g_dept 
      LET g_rtbg_m.rtbgcrtdt = cl_get_current()
      LET g_rtbg_m.rtbgmodid = g_user
      LET g_rtbg_m.rtbgmoddt = cl_get_current()
      LET g_rtbg_m.rtbgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'rtbgsite',g_rtbg_m.rtbgsite)
         RETURNING l_insert,g_rtbg_m.rtbgsite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_rtbg_m.rtbgunit = g_rtbg_m.rtbgsite
      LET g_rtbg_m.rtbgdocdt = g_today
      LET g_rtbg_m.rtbg001 = g_user
      LET g_rtbg_m.rtbg002 = g_dept
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtbg_m.rtbgsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_rtbg_m.rtbgdocno = r_doctype
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtbg_m.rtbgsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtbg_m.rtbgsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtbg_m.rtbgsite_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtbg_m.rtbg001
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_rtbg_m.rtbg001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtbg_m.rtbg001_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtbg_m.rtbg002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtbg_m.rtbg002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtbg_m.rtbg002_desc
      
      LET g_rtbg_m_t.* = g_rtbg_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtbg_m_t.* = g_rtbg_m.*
      LET g_rtbg_m_o.* = g_rtbg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtbg_m.rtbgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
    
      CALL artt303_input("a")
      
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
         INITIALIZE g_rtbg_m.* TO NULL
         INITIALIZE g_rtbh_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt303_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtbh_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt303_set_act_visible()   
   CALL artt303_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtbgent = " ||g_enterprise|| " AND",
                      " rtbgdocno = '", g_rtbg_m.rtbgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt303_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt303_cl
   
   CALL artt303_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
       g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
       g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid_desc, 
       g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc
   
   
   #遮罩相關處理
   LET g_rtbg_m_mask_o.* =  g_rtbg_m.*
   CALL artt303_rtbg_t_mask()
   LET g_rtbg_m_mask_n.* =  g_rtbg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite_desc,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit, 
       g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgowndp_desc, 
       g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtid_desc,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfid_desc, 
       g_rtbg_m.rtbgcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtbg_m.rtbgownid      
   LET g_data_dept  = g_rtbg_m.rtbgowndp
   
   #功能已完成,通報訊息中心
   CALL artt303_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt303_modify()
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
   LET g_rtbg_m_t.* = g_rtbg_m.*
   LET g_rtbg_m_o.* = g_rtbg_m.*
   
   IF g_rtbg_m.rtbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
   CALL s_transaction_begin()
   
   OPEN artt303_cl USING g_enterprise,g_rtbg_m.rtbgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt303_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt303_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
       g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
       g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid_desc, 
       g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc
   
   #檢查是否允許此動作
   IF NOT artt303_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtbg_m_mask_o.* =  g_rtbg_m.*
   CALL artt303_rtbg_t_mask()
   LET g_rtbg_m_mask_n.* =  g_rtbg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL artt303_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtbg_m.rtbgmodid = g_user 
LET g_rtbg_m.rtbgmoddt = cl_get_current()
LET g_rtbg_m.rtbgmodid_desc = cl_get_username(g_rtbg_m.rtbgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt303_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtbg_t SET (rtbgmodid,rtbgmoddt) = (g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt)
          WHERE rtbgent = g_enterprise AND rtbgdocno = g_rtbgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtbg_m.* = g_rtbg_m_t.*
            CALL artt303_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtbg_m.rtbgdocno != g_rtbg_m_t.rtbgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rtbh_t SET rtbhdocno = g_rtbg_m.rtbgdocno
 
          WHERE rtbhent = g_enterprise AND rtbhdocno = g_rtbg_m_t.rtbgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtbh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtbh_t:",SQLERRMESSAGE 
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
   CALL artt303_set_act_visible()   
   CALL artt303_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtbgent = " ||g_enterprise|| " AND",
                      " rtbgdocno = '", g_rtbg_m.rtbgdocno, "' "
 
   #填到對應位置
   CALL artt303_browser_fill("")
 
   CLOSE artt303_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt303_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt303.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt303_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_flag                LIKE type_t.num5
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
   DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite_desc,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit, 
       g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgowndp_desc, 
       g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtid_desc,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfid_desc, 
       g_rtbg_m.rtbgcnfdt
   
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
   LET g_forupd_sql = "SELECT rtbhseq,rtbhsite,rtbh001,rtbh002,rtbh003,rtbh004,rtbh005,rtbh006,rtbh007, 
       rtbh008,rtbhunit FROM rtbh_t WHERE rtbhent=? AND rtbhdocno=? AND rtbhseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt303_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt303_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL artt303_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002, 
       g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt303.input.head" >}
      #單頭段
      INPUT BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002, 
          g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt303_cl USING g_enterprise,g_rtbg_m.rtbgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt303_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt303_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt303_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL artt303_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgsite
            
            #add-point:AFTER FIELD rtbgsite name="input.a.rtbgsite"
            IF NOT cl_null(g_rtbg_m.rtbgsite) THEN
               CALL s_aooi500_chk(g_prog,'rtbgsite',g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_rtbg_m.rtbgsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_rtbg_m.rtbgsite = g_rtbg_m_t.rtbgsite
                  CALL s_desc_get_department_desc(g_rtbg_m.rtbgsite) RETURNING g_rtbg_m.rtbgsite_desc
                  DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite_desc
                  NEXT FIELD CURRENT
               END IF
               
               LET g_site_flag = TRUE
               CALL artt303_set_entry(p_cmd)
               CALL artt303_set_no_entry(p_cmd)
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbg_m.rtbgsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbg_m.rtbgsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbg_m.rtbgsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgsite
            #add-point:BEFORE FIELD rtbgsite name="input.b.rtbgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbgsite
            #add-point:ON CHANGE rtbgsite name="input.g.rtbgsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgdocdt
            #add-point:BEFORE FIELD rtbgdocdt name="input.b.rtbgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgdocdt
            
            #add-point:AFTER FIELD rtbgdocdt name="input.a.rtbgdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbgdocdt
            #add-point:ON CHANGE rtbgdocdt name="input.g.rtbgdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgdocno
            
            #add-point:AFTER FIELD rtbgdocno name="input.a.rtbgdocno"
            IF NOT cl_null(g_rtbg_m.rtbgdocno) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               CALL s_aooi100_sel_ooef004(g_rtbg_m.rtbgsite)
                    RETURNING l_success,l_ooef004
               LET g_chkparam.arg1 = l_ooef004
               LET g_chkparam.arg2 = g_rtbg_m.rtbgdocno
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rtbg_m.rtbgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtbg_m.rtbgdocno != g_rtbgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtbg_t WHERE "||"rtbgent = '" ||g_enterprise|| "' AND "||"rtbgdocno = '"||g_rtbg_m.rtbgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgdocno
            #add-point:BEFORE FIELD rtbgdocno name="input.b.rtbgdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbgdocno
            #add-point:ON CHANGE rtbgdocno name="input.g.rtbgdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbg001
            
            #add-point:AFTER FIELD rtbg001 name="input.a.rtbg001"
            IF NOT cl_null(g_rtbg_m.rtbg001) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbg_m.rtbg001
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#33  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rtbg_m.rtbg001 = g_rtbg_m_t.rtbg001
                  DISPLAY BY NAME g_rtbg_m.rtbg001
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbg_m.rtbg001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rtbg_m.rtbg001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbg_m.rtbg001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbg001
            #add-point:BEFORE FIELD rtbg001 name="input.b.rtbg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbg001
            #add-point:ON CHANGE rtbg001 name="input.g.rtbg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbg002
            
            #add-point:AFTER FIELD rtbg002 name="input.a.rtbg002"
            IF NOT cl_null(g_rtbg_m.rtbg002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbg_m.rtbg002
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rtbg_m.rtbg002 = g_rtbg_m_t.rtbg002
                  DISPLAY BY NAME g_rtbg_m.rtbg002
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbg_m.rtbg002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbg_m.rtbg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbg_m.rtbg002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbg002
            #add-point:BEFORE FIELD rtbg002 name="input.b.rtbg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbg002
            #add-point:ON CHANGE rtbg002 name="input.g.rtbg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbg003
            #add-point:BEFORE FIELD rtbg003 name="input.b.rtbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbg003
            
            #add-point:AFTER FIELD rtbg003 name="input.a.rtbg003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbg003
            #add-point:ON CHANGE rtbg003 name="input.g.rtbg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgunit
            #add-point:BEFORE FIELD rtbgunit name="input.b.rtbgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgunit
            
            #add-point:AFTER FIELD rtbgunit name="input.a.rtbgunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbgunit
            #add-point:ON CHANGE rtbgunit name="input.g.rtbgunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbgstus
            #add-point:BEFORE FIELD rtbgstus name="input.b.rtbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbgstus
            
            #add-point:AFTER FIELD rtbgstus name="input.a.rtbgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbgstus
            #add-point:ON CHANGE rtbgstus name="input.g.rtbgstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgsite
            #add-point:ON ACTION controlp INFIELD rtbgsite name="input.c.rtbgsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbg_m.rtbgsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbgsite',g_rtbg_m.rtbgsite,'i')

            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtbg_m.rtbgsite = g_qryparam.return1              

            DISPLAY g_rtbg_m.rtbgsite TO rtbgsite              #

            NEXT FIELD rtbgsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgdocdt
            #add-point:ON ACTION controlp INFIELD rtbgdocdt name="input.c.rtbgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtbgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgdocno
            #add-point:ON ACTION controlp INFIELD rtbgdocno name="input.c.rtbgdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbg_m.rtbgdocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_rtbg_m.rtbgsite)
               RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_rtbg_m.rtbgdocno = g_qryparam.return1              

            DISPLAY g_rtbg_m.rtbgdocno TO rtbgdocno              #

            NEXT FIELD rtbgdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbg001
            #add-point:ON ACTION controlp INFIELD rtbg001 name="input.c.rtbg001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbg_m.rtbg001             #給予default值
            LET g_qryparam.default2 = g_rtbg_m.rtbg001_desc #归属部门
            LET g_qryparam.default3 = g_rtbg_m.rtbg002 #說明(簡稱)
            LET g_qryparam.default4 = g_rtbg_m.rtbg002_desc #全名
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001_6()                                #呼叫開窗

            LET g_rtbg_m.rtbg001 = g_qryparam.return1              
            LET g_rtbg_m.rtbg001_desc = g_qryparam.return2 
            LET g_rtbg_m.rtbg002 = g_qryparam.return3 
            LET g_rtbg_m.rtbg002_desc = g_qryparam.return4
            DISPLAY g_rtbg_m.rtbg001 TO rtbg001              #
            DISPLAY g_rtbg_m.rtbg001_desc TO rtbg001_desc #归属部门
            DISPLAY g_rtbg_m.rtbg002 TO rtbg002 #說明(簡稱)
            DISPLAY g_rtbg_m.rtbg002_desc TO rtbg002_desc #全名
            NEXT FIELD rtbg001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbg002
            #add-point:ON ACTION controlp INFIELD rtbg002 name="input.c.rtbg002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbg_m.rtbg002             #給予default值
            LET g_qryparam.default2 = g_rtbg_m.rtbg002_desc #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001()                                #呼叫開窗

            LET g_rtbg_m.rtbg002 = g_qryparam.return1              
            LET g_rtbg_m.rtbg002_desc = g_qryparam.return2 
            DISPLAY g_rtbg_m.rtbg002 TO rtbg002              #
            DISPLAY g_rtbg_m.rtbg002_desc TO rtbg002_desc #部門編號
            NEXT FIELD rtbg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbg003
            #add-point:ON ACTION controlp INFIELD rtbg003 name="input.c.rtbg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtbgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgunit
            #add-point:ON ACTION controlp INFIELD rtbgunit name="input.c.rtbgunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbgstus
            #add-point:ON ACTION controlp INFIELD rtbgstus name="input.c.rtbgstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtbg_m.rtbgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbgdocdt,g_prog) RETURNING l_flag,g_rtbg_m.rtbgdocno
               IF NOT l_flag THEN
                  NEXT FIELD rtbgdocno
               END IF
               #end add-point
               
               INSERT INTO rtbg_t (rtbgent,rtbgsite,rtbgdocdt,rtbgdocno,rtbg001,rtbg002,rtbg003,rtbgunit, 
                   rtbgstus,rtbgownid,rtbgowndp,rtbgcrtid,rtbgcrtdp,rtbgcrtdt,rtbgmodid,rtbgmoddt,rtbgcnfid, 
                   rtbgcnfdt)
               VALUES (g_enterprise,g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001, 
                   g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid, 
                   g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt,g_rtbg_m.rtbgmodid, 
                   g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtbg_m:",SQLERRMESSAGE 
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
                  CALL artt303_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt303_b_fill()
                  CALL artt303_b_fill2('0')
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
               CALL artt303_rtbg_t_mask_restore('restore_mask_o')
               
               UPDATE rtbg_t SET (rtbgsite,rtbgdocdt,rtbgdocno,rtbg001,rtbg002,rtbg003,rtbgunit,rtbgstus, 
                   rtbgownid,rtbgowndp,rtbgcrtid,rtbgcrtdp,rtbgcrtdt,rtbgmodid,rtbgmoddt,rtbgcnfid,rtbgcnfdt) = (g_rtbg_m.rtbgsite, 
                   g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003, 
                   g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid, 
                   g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt,g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid, 
                   g_rtbg_m.rtbgcnfdt)
                WHERE rtbgent = g_enterprise AND rtbgdocno = g_rtbgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtbg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artt303_rtbg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtbg_m_t)
               LET g_log2 = util.JSON.stringify(g_rtbg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt303.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtbh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtbh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt303_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtbh_d.getLength()
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
            OPEN artt303_cl USING g_enterprise,g_rtbg_m.rtbgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt303_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt303_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtbh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtbh_d[l_ac].rtbhseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtbh_d_t.* = g_rtbh_d[l_ac].*  #BACKUP
               LET g_rtbh_d_o.* = g_rtbh_d[l_ac].*  #BACKUP
               CALL artt303_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL artt303_set_no_entry_b(l_cmd)
               IF NOT artt303_lock_b("rtbh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt303_bcl INTO g_rtbh_d[l_ac].rtbhseq,g_rtbh_d[l_ac].rtbhsite,g_rtbh_d[l_ac].rtbh001, 
                      g_rtbh_d[l_ac].rtbh002,g_rtbh_d[l_ac].rtbh003,g_rtbh_d[l_ac].rtbh004,g_rtbh_d[l_ac].rtbh005, 
                      g_rtbh_d[l_ac].rtbh006,g_rtbh_d[l_ac].rtbh007,g_rtbh_d[l_ac].rtbh008,g_rtbh_d[l_ac].rtbhunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtbh_d_t.rtbhseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtbh_d_mask_o[l_ac].* =  g_rtbh_d[l_ac].*
                  CALL artt303_rtbh_t_mask()
                  LET g_rtbh_d_mask_n[l_ac].* =  g_rtbh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt303_show()
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
            INITIALIZE g_rtbh_d[l_ac].* TO NULL 
            INITIALIZE g_rtbh_d_t.* TO NULL 
            INITIALIZE g_rtbh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtbh_d[l_ac].rtbhseq = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_rtbh_d_t.* = g_rtbh_d[l_ac].*     #新輸入資料
            LET g_rtbh_d_o.* = g_rtbh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt303_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artt303_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtbh_d[li_reproduce_target].* = g_rtbh_d[li_reproduce].*
 
               LET g_rtbh_d[li_reproduce_target].rtbhseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_rtbh_d[l_ac].rtbhsite = g_rtbg_m.rtbgsite
            SELECT MAX(rtbhseq)+1 INTO g_rtbh_d[l_ac].rtbhseq
              FROM rtbh_t
             WHERE rtbhent = g_enterprise
               AND rtbhdocno = g_rtbg_m.rtbgdocno
            IF cl_null(g_rtbh_d[l_ac].rtbhseq) THEN
               LET g_rtbh_d[l_ac].rtbhseq = 1
            END IF
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
            SELECT COUNT(1) INTO l_count FROM rtbh_t 
             WHERE rtbhent = g_enterprise AND rtbhdocno = g_rtbg_m.rtbgdocno
 
               AND rtbhseq = g_rtbh_d[l_ac].rtbhseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtbg_m.rtbgdocno
               LET gs_keys[2] = g_rtbh_d[g_detail_idx].rtbhseq
               CALL artt303_insert_b('rtbh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtbh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtbh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt303_b_fill()
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
               LET gs_keys[01] = g_rtbg_m.rtbgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtbh_d_t.rtbhseq
 
            
               #刪除同層單身
               IF NOT artt303_delete_b('rtbh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt303_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt303_key_delete_b(gs_keys,'rtbh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt303_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt303_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rtbh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtbh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbhseq
            #add-point:BEFORE FIELD rtbhseq name="input.b.page1.rtbhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbhseq
            
            #add-point:AFTER FIELD rtbhseq name="input.a.page1.rtbhseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtbg_m.rtbgdocno IS NOT NULL AND g_rtbh_d[g_detail_idx].rtbhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtbg_m.rtbgdocno != g_rtbgdocno_t OR g_rtbh_d[g_detail_idx].rtbhseq != g_rtbh_d_t.rtbhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtbh_t WHERE "||"rtbhent = '" ||g_enterprise|| "' AND "||"rtbhdocno = '"||g_rtbg_m.rtbgdocno ||"' AND "|| "rtbhseq = '"||g_rtbh_d[g_detail_idx].rtbhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbhseq
            #add-point:ON CHANGE rtbhseq name="input.g.page1.rtbhseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbhsite
            
            #add-point:AFTER FIELD rtbhsite name="input.a.page1.rtbhsite"
            IF NOT cl_null(g_rtbh_d[l_ac].rtbhsite) THEN
               CALL s_aooi500_chk(g_prog,'rtbhsite',g_rtbh_d[l_ac].rtbhsite,g_rtbg_m.rtbgsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_rtbh_d[l_ac].rtbhsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
             
                  LET g_rtbh_d[l_ac].rtbhsite = g_rtbh_d_t.rtbhsite
                  CALL s_desc_get_department_desc(g_rtbh_d[l_ac].rtbhsite) RETURNING g_rtbh_d[l_ac].rtbhsite_desc
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbhsite,g_rtbh_d[l_ac].rtbhsite_desc
                  NEXT FIELD CURRENT
               END IF
               
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rtbh_d[l_ac].rtbhsite <> g_rtbh_d_t.rtbhsite OR cl_null(g_rtbh_d_t.rtbhsite))) THEN
                  IF NOT cl_null(g_rtbh_d[l_ac].rtbh002) THEN
                     LET l_n = 0                  
                     SELECT COUNT(*) INTO l_n
                       FROM rtbh_t
                      WHERE rtbhent = g_enterprise
                        AND rtbhdocno = g_rtbg_m.rtbgdocno
                        AND rtbhsite = g_rtbh_d[l_ac].rtbhsite
                        AND rtbh002 = g_rtbh_d[l_ac].rtbh002
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = 'art-00489'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                        LET g_rtbh_d[l_ac].rtbhsite = g_rtbh_d_t.rtbhsite
                        CALL s_desc_get_department_desc(g_rtbh_d[l_ac].rtbhsite) RETURNING g_rtbh_d[l_ac].rtbhsite_desc
                        DISPLAY BY NAME g_rtbh_d[l_ac].rtbhsite,g_rtbh_d[l_ac].rtbhsite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               
               #对应商品必须存在此供应商的采购协议里
               IF NOT artt303_rtbh002_chk() THEN
                  LET g_rtbh_d[l_ac].rtbhsite = g_rtbh_d_t.rtbhsite
                  CALL s_desc_get_department_desc(g_rtbh_d[l_ac].rtbhsite) RETURNING g_rtbh_d[l_ac].rtbhsite_desc
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbhsite,g_rtbh_d[l_ac].rtbhsite_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbhsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbh_d[l_ac].rtbhsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbh_d[l_ac].rtbhsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbhsite
            #add-point:BEFORE FIELD rtbhsite name="input.b.page1.rtbhsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbhsite
            #add-point:ON CHANGE rtbhsite name="input.g.page1.rtbhsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh001
            
            #add-point:AFTER FIELD rtbh001 name="input.a.page1.rtbh001"
            IF NOT cl_null(g_rtbh_d[l_ac].rtbh001) THEN 
#應用 a17 樣板自動產生(Version:2)
               SELECT imay001 INTO g_rtbh_d[l_ac].rtbh002
                 FROM imay_t
                WHERE imayent = g_enterprise
                  AND imay003 = g_rtbh_d[l_ac].rtbh001
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbh_d[l_ac].rtbh002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_stas003") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  #LET g_rtbh_d[l_ac].rtbh001 = g_rtbh_d_t.rtbh001   #160824-00007#164 20161129 mark by beckxie
                  #160824-00007#164 20161129 add by beckxie---S
                  LET g_rtbh_d[l_ac].rtbh001           = g_rtbh_d_o.rtbh001   
                  LET g_rtbh_d[l_ac].rtbh003           = g_rtbh_d_o.rtbh003          
                  LET g_rtbh_d[l_ac].rtbh003_desc      = g_rtbh_d_o.rtbh003_desc     
                  LET g_rtbh_d[l_ac].rtbh005           = g_rtbh_d_o.rtbh005          
                  LET g_rtbh_d[l_ac].rtbh007           = g_rtbh_d_o.rtbh007          
                  LET g_rtbh_d[l_ac].rtbh005_desc      = g_rtbh_d_o.rtbh005_desc     
                  LET g_rtbh_d[l_ac].rtbh001           = g_rtbh_d_o.rtbh001          
                  LET g_rtbh_d[l_ac].rtbh002_desc      = g_rtbh_d_o.rtbh002_desc     
                  LET g_rtbh_d[l_ac].rtbh002_desc_desc = g_rtbh_d_o.rtbh002_desc_desc
                  #160824-00007#164 20161129 add by beckxie---E
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbh001
                  NEXT FIELD CURRENT
               END IF

               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rtbh_d[l_ac].rtbh001 <> g_rtbh_d_t.rtbh001 OR cl_null(g_rtbh_d_t.rtbh001))) THEN   #160824-00007#164 20161129 mark by beckxie
               IF g_rtbh_d[l_ac].rtbh001 <> g_rtbh_d_o.rtbh001 OR cl_null(g_rtbh_d_o.rtbh001) THEN   #160824-00007#164 20161129 add by beckxie
                  IF NOT cl_null(g_rtbh_d[l_ac].rtbhsite) THEN
                     LET l_n = 0                  
                     SELECT COUNT(*) INTO l_n
                       FROM rtbh_t
                      WHERE rtbhent = g_enterprise
                        AND rtbhdocno = g_rtbg_m.rtbgdocno
                        AND rtbhsite = g_rtbh_d[l_ac].rtbhsite
                        AND rtbh002 = g_rtbh_d[l_ac].rtbh002
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = 'art-00489'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                        #LET g_rtbh_d[l_ac].rtbh001 = g_rtbh_d_t.rtbh001   #160824-00007#164 20161129 mark by beckxie
                        #160824-00007#164 20161129 add by beckxie---S
                        LET g_rtbh_d[l_ac].rtbh001           = g_rtbh_d_o.rtbh001
                        LET g_rtbh_d[l_ac].rtbh003           = g_rtbh_d_o.rtbh003
                        LET g_rtbh_d[l_ac].rtbh003_desc      = g_rtbh_d_o.rtbh003_desc
                        LET g_rtbh_d[l_ac].rtbh005           = g_rtbh_d_o.rtbh005
                        LET g_rtbh_d[l_ac].rtbh007           = g_rtbh_d_o.rtbh007
                        LET g_rtbh_d[l_ac].rtbh005_desc      = g_rtbh_d_o.rtbh005_desc
                        LET g_rtbh_d[l_ac].rtbh002_desc      = g_rtbh_d_o.rtbh002_desc
                        LET g_rtbh_d[l_ac].rtbh002_desc_desc = g_rtbh_d_o.rtbh002_desc_desc
                        #160824-00007#164 20161129 add by beckxie---E
                        DISPLAY BY NAME g_rtbh_d[l_ac].rtbh001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF 

            CALL artt303_rtbh002_ref()
            LET g_rtbh_d_o.* = g_rtbh_d[l_ac].*   #160824-00007#164 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh001
            #add-point:BEFORE FIELD rtbh001 name="input.b.page1.rtbh001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh001
            #add-point:ON CHANGE rtbh001 name="input.g.page1.rtbh001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh002
            
            #add-point:AFTER FIELD rtbh002 name="input.a.page1.rtbh002"
            IF NOT cl_null(g_rtbh_d[l_ac].rtbh002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbh_d[l_ac].rtbh002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_stas003") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  #LET g_rtbh_d[l_ac].rtbh002 = g_rtbh_d_t.rtbh002   #160824-00007#164 20161129 mark by beckxie
                  #160824-00007#164 20161129 add by beckxie---S
                  LET g_rtbh_d[l_ac].rtbh002           = g_rtbh_d_o.rtbh002   
                  LET g_rtbh_d[l_ac].rtbh003           = g_rtbh_d_o.rtbh003          
                  LET g_rtbh_d[l_ac].rtbh003_desc      = g_rtbh_d_o.rtbh003_desc     
                  LET g_rtbh_d[l_ac].rtbh005           = g_rtbh_d_o.rtbh005          
                  LET g_rtbh_d[l_ac].rtbh007           = g_rtbh_d_o.rtbh007          
                  LET g_rtbh_d[l_ac].rtbh005_desc      = g_rtbh_d_o.rtbh005_desc     
                  LET g_rtbh_d[l_ac].rtbh001           = g_rtbh_d_o.rtbh001          
                  LET g_rtbh_d[l_ac].rtbh002_desc      = g_rtbh_d_o.rtbh002_desc     
                  LET g_rtbh_d[l_ac].rtbh002_desc_desc = g_rtbh_d_o.rtbh002_desc_desc
                  #160824-00007#164 20161129 add by beckxie---E
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbh002
                  NEXT FIELD CURRENT
               END IF

               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_rtbh_d[l_ac].rtbh002 <> g_rtbh_d_t.rtbh002 OR cl_null(g_rtbh_d_t.rtbh002))) THEN
                  IF NOT cl_null(g_rtbh_d[l_ac].rtbhsite) THEN
                     LET l_n = 0                  
                     SELECT COUNT(*) INTO l_n
                       FROM rtbh_t
                      WHERE rtbhent = g_enterprise
                        AND rtbhdocno = g_rtbg_m.rtbgdocno
                        AND rtbhsite = g_rtbh_d[l_ac].rtbhsite
                        AND rtbh002 = g_rtbh_d[l_ac].rtbh002
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = 'art-00489'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                        #LET g_rtbh_d[l_ac].rtbh002 = g_rtbh_d_t.rtbh002   #160824-00007#164 20161129 mark by beckxie
                        #160824-00007#164 20161129 add by beckxie---S
                        LET g_rtbh_d[l_ac].rtbh002           = g_rtbh_d_o.rtbh002   
                        LET g_rtbh_d[l_ac].rtbh003           = g_rtbh_d_o.rtbh003          
                        LET g_rtbh_d[l_ac].rtbh003_desc      = g_rtbh_d_o.rtbh003_desc     
                        LET g_rtbh_d[l_ac].rtbh005           = g_rtbh_d_o.rtbh005          
                        LET g_rtbh_d[l_ac].rtbh007           = g_rtbh_d_o.rtbh007          
                        LET g_rtbh_d[l_ac].rtbh005_desc      = g_rtbh_d_o.rtbh005_desc     
                        LET g_rtbh_d[l_ac].rtbh001           = g_rtbh_d_o.rtbh001          
                        LET g_rtbh_d[l_ac].rtbh002_desc      = g_rtbh_d_o.rtbh002_desc     
                        LET g_rtbh_d[l_ac].rtbh002_desc_desc = g_rtbh_d_o.rtbh002_desc_desc
                        #160824-00007#164 20161129 add by beckxie---E
                        DISPLAY BY NAME g_rtbh_d[l_ac].rtbh002
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               
               #对应商品必须存在此供应商的采购协议里
               IF NOT artt303_rtbh002_chk() THEN
                  #LET g_rtbh_d[l_ac].rtbh002 = g_rtbh_d_t.rtbh002   #160824-00007#164 20161129 mark by beckxie
                  #160824-00007#164 20161129 add by beckxie---S
                  LET g_rtbh_d[l_ac].rtbh002           = g_rtbh_d_o.rtbh002   
                  LET g_rtbh_d[l_ac].rtbh003           = g_rtbh_d_o.rtbh003          
                  LET g_rtbh_d[l_ac].rtbh003_desc      = g_rtbh_d_o.rtbh003_desc     
                  LET g_rtbh_d[l_ac].rtbh005           = g_rtbh_d_o.rtbh005          
                  LET g_rtbh_d[l_ac].rtbh007           = g_rtbh_d_o.rtbh007          
                  LET g_rtbh_d[l_ac].rtbh005_desc      = g_rtbh_d_o.rtbh005_desc     
                  LET g_rtbh_d[l_ac].rtbh001           = g_rtbh_d_o.rtbh001          
                  LET g_rtbh_d[l_ac].rtbh002_desc      = g_rtbh_d_o.rtbh002_desc     
                  LET g_rtbh_d[l_ac].rtbh002_desc_desc = g_rtbh_d_o.rtbh002_desc_desc
                  #160824-00007#164 20161129 add by beckxie---E
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbh002
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh002
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbh_d[l_ac].rtbh002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbh_d[l_ac].rtbh002_desc

            CALL artt303_rtbh002_ref()
            
            LET g_rtbh_d_o.* = g_rtbh_d[l_ac].*   #160824-00007#164 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh002
            #add-point:BEFORE FIELD rtbh002 name="input.b.page1.rtbh002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh002
            #add-point:ON CHANGE rtbh002 name="input.g.page1.rtbh002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh003
            
            #add-point:AFTER FIELD rtbh003 name="input.a.page1.rtbh003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh003
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbh_d[l_ac].rtbh003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbh_d[l_ac].rtbh003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh003
            #add-point:BEFORE FIELD rtbh003 name="input.b.page1.rtbh003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh003
            #add-point:ON CHANGE rtbh003 name="input.g.page1.rtbh003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh004
            
            #add-point:AFTER FIELD rtbh004 name="input.a.page1.rtbh004"
            IF NOT cl_null(g_rtbh_d[l_ac].rtbh004) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rtbh_d[l_ac].rtbh004

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_rtbh_d[l_ac].rtbh004 = g_rtbh_d_t.rtbh004
                  LET g_rtbh_d[l_ac].rtbh004_desc = ''
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbh004,g_rtbh_d[l_ac].rtbh004_desc
                  NEXT FIELD CURRENT
               END IF

               #不可等於原供應商
               IF NOT cl_null(g_rtbh_d[l_ac].rtbh003) THEN
                  IF g_rtbh_d[l_ac].rtbh004 = g_rtbh_d[l_ac].rtbh003 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtbh_d[l_ac].rtbh004 
                     LET g_errparam.code   = "art-00702" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_rtbh_d[l_ac].rtbh004 = g_rtbh_d_t.rtbh004
                     LET g_rtbh_d[l_ac].rtbh004_desc = ''
                     DISPLAY BY NAME g_rtbh_d[l_ac].rtbh004,g_rtbh_d[l_ac].rtbh004_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               #对应商品必须存在此供应商的采购协议里
               IF NOT artt303_rtbh002_chk() THEN
                  LET g_rtbh_d[l_ac].rtbh004 = g_rtbh_d_t.rtbh004
                  LET g_rtbh_d[l_ac].rtbh004_desc = ''
                  DISPLAY BY NAME g_rtbh_d[l_ac].rtbh004,g_rtbh_d[l_ac].rtbh004_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbh_d[l_ac].rtbh004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbh_d[l_ac].rtbh004_desc

            CALL artt303_rtbh004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh004
            #add-point:BEFORE FIELD rtbh004 name="input.b.page1.rtbh004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh004
            #add-point:ON CHANGE rtbh004 name="input.g.page1.rtbh004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh005
            
            #add-point:AFTER FIELD rtbh005 name="input.a.page1.rtbh005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh005
            CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbh_d[l_ac].rtbh005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbh_d[l_ac].rtbh005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh005
            #add-point:BEFORE FIELD rtbh005 name="input.b.page1.rtbh005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh005
            #add-point:ON CHANGE rtbh005 name="input.g.page1.rtbh005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh006
            
            #add-point:AFTER FIELD rtbh006 name="input.a.page1.rtbh006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh006
            CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtbh_d[l_ac].rtbh006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtbh_d[l_ac].rtbh006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh006
            #add-point:BEFORE FIELD rtbh006 name="input.b.page1.rtbh006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh006
            #add-point:ON CHANGE rtbh006 name="input.g.page1.rtbh006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh007
            #add-point:BEFORE FIELD rtbh007 name="input.b.page1.rtbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh007
            
            #add-point:AFTER FIELD rtbh007 name="input.a.page1.rtbh007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh007
            #add-point:ON CHANGE rtbh007 name="input.g.page1.rtbh007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbh008
            #add-point:BEFORE FIELD rtbh008 name="input.b.page1.rtbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbh008
            
            #add-point:AFTER FIELD rtbh008 name="input.a.page1.rtbh008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbh008
            #add-point:ON CHANGE rtbh008 name="input.g.page1.rtbh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtbhunit
            #add-point:BEFORE FIELD rtbhunit name="input.b.page1.rtbhunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtbhunit
            
            #add-point:AFTER FIELD rtbhunit name="input.a.page1.rtbhunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtbhunit
            #add-point:ON CHANGE rtbhunit name="input.g.page1.rtbhunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtbhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbhseq
            #add-point:ON ACTION controlp INFIELD rtbhseq name="input.c.page1.rtbhseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbhsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbhsite
            #add-point:ON ACTION controlp INFIELD rtbhsite name="input.c.page1.rtbhsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbh_d[l_ac].rtbhsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtbgsite',g_rtbg_m.rtbgsite,'i')

            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtbh_d[l_ac].rtbhsite = g_qryparam.return1              

            DISPLAY g_rtbh_d[l_ac].rtbhsite TO rtbhsite              #

            NEXT FIELD rtbhsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh001
            #add-point:ON ACTION controlp INFIELD rtbh001 name="input.c.page1.rtbh001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbh_d[l_ac].rtbh001             #給予default值
            LET g_qryparam.default2 = "" #g_rtbh_d[l_ac].imaal004 #規格
            LET g_qryparam.default3 = "" #g_rtbh_d[l_ac].stas003 #商品編號
            LET g_qryparam.default4 = "" #g_rtbh_d[l_ac].stas004 #商品條碼
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_stas003()                                #呼叫開窗

            LET g_rtbh_d[l_ac].rtbh001 = g_qryparam.return1              
            #LET g_rtbh_d[l_ac].imaal004 = g_qryparam.return2 
            #LET g_rtbh_d[l_ac].stas003 = g_qryparam.return3 
            #LET g_rtbh_d[l_ac].stas004 = g_qryparam.return4 
            DISPLAY g_rtbh_d[l_ac].rtbh001 TO rtbh001              #
            #DISPLAY g_rtbh_d[l_ac].imaal004 TO imaal004 #規格
            #DISPLAY g_rtbh_d[l_ac].stas003 TO stas003 #商品編號
            #DISPLAY g_rtbh_d[l_ac].stas004 TO stas004 #商品條碼
            NEXT FIELD rtbh001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh002
            #add-point:ON ACTION controlp INFIELD rtbh002 name="input.c.page1.rtbh002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbh_d[l_ac].rtbh001             #給予default值
            LET g_qryparam.default2 = g_rtbh_d[l_ac].rtbh002 #規格
            LET g_qryparam.default3 = "" #g_rtbh_d[l_ac].stas003 #商品編號
            LET g_qryparam.default4 = "" #g_rtbh_d[l_ac].stas004 #商品條碼
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_stas003()                                #呼叫開窗

            LET g_rtbh_d[l_ac].rtbh001 = g_qryparam.return1              
            LET g_rtbh_d[l_ac].rtbh002 = g_qryparam.return2 
            #LET g_rtbh_d[l_ac].stas003 = g_qryparam.return3 
            #LET g_rtbh_d[l_ac].stas004 = g_qryparam.return4 
            DISPLAY g_rtbh_d[l_ac].rtbh001 TO rtbh001              #
            DISPLAY g_rtbh_d[l_ac].rtbh002 TO rtbh002#規格
            #DISPLAY g_rtbh_d[l_ac].stas003 TO stas003 #商品編號
            #DISPLAY g_rtbh_d[l_ac].stas004 TO stas004 #商品條碼
            NEXT FIELD rtbh002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh003
            #add-point:ON ACTION controlp INFIELD rtbh003 name="input.c.page1.rtbh003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbh_d[l_ac].rtbh003             #給予default值
            LET g_qryparam.default2 = g_rtbh_d[l_ac].rtbh003_desc #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_rtbh_d[l_ac].rtbh003 = g_qryparam.return1              
            LET g_rtbh_d[l_ac].rtbh003_desc = g_qryparam.return2 
            DISPLAY g_rtbh_d[l_ac].rtbh003 TO rtbh003              #
            DISPLAY g_rtbh_d[l_ac].rtbh003_desc TO rtbh003_desc #交易對象簡稱
            NEXT FIELD rtbh003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh004
            #add-point:ON ACTION controlp INFIELD rtbh004 name="input.c.page1.rtbh004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtbh_d[l_ac].rtbh004             #給予default值
            LET g_qryparam.default2 = g_rtbh_d[l_ac].rtbh004_desc #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #s
            IF NOT cl_null(g_rtbh_d[l_ac].rtbh002) THEN
               LET g_qryparam.where = " pmaa001 IN (SELECT DISTINCT star003 FROM star_t,stas_t ",
                                      "              WHERE starent = ",g_enterprise," AND starent = stasent ",
                                      "                AND star001 = stas001 AND stas003 = '",g_rtbh_d[l_ac].rtbh002,"') "
            END IF

            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_rtbh_d[l_ac].rtbh004 = g_qryparam.return1              
            LET g_rtbh_d[l_ac].rtbh004_desc = g_qryparam.return2 
            DISPLAY g_rtbh_d[l_ac].rtbh004 TO rtbh004              #
            DISPLAY g_rtbh_d[l_ac].rtbh004_desc TO rtbh004_desc #交易對象簡稱
            NEXT FIELD rtbh004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh005
            #add-point:ON ACTION controlp INFIELD rtbh005 name="input.c.page1.rtbh005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh006
            #add-point:ON ACTION controlp INFIELD rtbh006 name="input.c.page1.rtbh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh007
            #add-point:ON ACTION controlp INFIELD rtbh007 name="input.c.page1.rtbh007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbh008
            #add-point:ON ACTION controlp INFIELD rtbh008 name="input.c.page1.rtbh008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtbhunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtbhunit
            #add-point:ON ACTION controlp INFIELD rtbhunit name="input.c.page1.rtbhunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtbh_d[l_ac].* = g_rtbh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt303_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtbh_d[l_ac].rtbhseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtbh_d[l_ac].* = g_rtbh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt303_rtbh_t_mask_restore('restore_mask_o')
      
               UPDATE rtbh_t SET (rtbhdocno,rtbhseq,rtbhsite,rtbh001,rtbh002,rtbh003,rtbh004,rtbh005, 
                   rtbh006,rtbh007,rtbh008,rtbhunit) = (g_rtbg_m.rtbgdocno,g_rtbh_d[l_ac].rtbhseq,g_rtbh_d[l_ac].rtbhsite, 
                   g_rtbh_d[l_ac].rtbh001,g_rtbh_d[l_ac].rtbh002,g_rtbh_d[l_ac].rtbh003,g_rtbh_d[l_ac].rtbh004, 
                   g_rtbh_d[l_ac].rtbh005,g_rtbh_d[l_ac].rtbh006,g_rtbh_d[l_ac].rtbh007,g_rtbh_d[l_ac].rtbh008, 
                   g_rtbh_d[l_ac].rtbhunit)
                WHERE rtbhent = g_enterprise AND rtbhdocno = g_rtbg_m.rtbgdocno 
 
                  AND rtbhseq = g_rtbh_d_t.rtbhseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtbh_d[l_ac].* = g_rtbh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtbh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtbh_d[l_ac].* = g_rtbh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtbh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtbg_m.rtbgdocno
               LET gs_keys_bak[1] = g_rtbgdocno_t
               LET gs_keys[2] = g_rtbh_d[g_detail_idx].rtbhseq
               LET gs_keys_bak[2] = g_rtbh_d_t.rtbhseq
               CALL artt303_update_b('rtbh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt303_rtbh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtbh_d[g_detail_idx].rtbhseq = g_rtbh_d_t.rtbhseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtbg_m.rtbgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtbh_d_t.rtbhseq
 
                  CALL artt303_key_update_b(gs_keys,'rtbh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtbg_m),util.JSON.stringify(g_rtbh_d_t)
               LET g_log2 = util.JSON.stringify(g_rtbg_m),util.JSON.stringify(g_rtbh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL artt303_unlock_b("rtbh_t","'1'")
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
               LET g_rtbh_d[li_reproduce_target].* = g_rtbh_d[li_reproduce].*
 
               LET g_rtbh_d[li_reproduce_target].rtbhseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtbh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtbh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="artt303.input.other" >}
      
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
            NEXT FIELD rtbgsite
            #end add-point  
            NEXT FIELD rtbgdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtbhseq
 
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
 
{<section id="artt303.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt303_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt303_b_fill() #單身填充
      CALL artt303_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt303_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_rtbg_m_mask_o.* =  g_rtbg_m.*
   CALL artt303_rtbg_t_mask()
   LET g_rtbg_m_mask_n.* =  g_rtbg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite_desc,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit, 
       g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgowndp_desc, 
       g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtid_desc,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfid_desc, 
       g_rtbg_m.rtbgcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtbg_m.rtbgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_rtbh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt303_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt303_detail_show()
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
 
{<section id="artt303.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt303_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtbg_t.rtbgdocno 
   DEFINE l_oldno     LIKE rtbg_t.rtbgdocno 
 
   DEFINE l_master    RECORD LIKE rtbg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtbh_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_rtbg_m.rtbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
    
   LET g_rtbg_m.rtbgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtbg_m.rtbgownid = g_user
      LET g_rtbg_m.rtbgowndp = g_dept
      LET g_rtbg_m.rtbgcrtid = g_user
      LET g_rtbg_m.rtbgcrtdp = g_dept 
      LET g_rtbg_m.rtbgcrtdt = cl_get_current()
      LET g_rtbg_m.rtbgmodid = g_user
      LET g_rtbg_m.rtbgmoddt = cl_get_current()
      LET g_rtbg_m.rtbgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtbg_m.rtbgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL artt303_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtbg_m.* TO NULL
      INITIALIZE g_rtbh_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt303_show()
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
   CALL artt303_set_act_visible()   
   CALL artt303_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtbgent = " ||g_enterprise|| " AND",
                      " rtbgdocno = '", g_rtbg_m.rtbgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt303_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt303_idx_chk()
   
   LET g_data_owner = g_rtbg_m.rtbgownid      
   LET g_data_dept  = g_rtbg_m.rtbgowndp
   
   #功能已完成,通報訊息中心
   CALL artt303_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt303_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtbh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt303_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtbh_t
    WHERE rtbhent = g_enterprise AND rtbhdocno = g_rtbgdocno_t
 
    INTO TEMP artt303_detail
 
   #將key修正為調整後   
   UPDATE artt303_detail 
      #更新key欄位
      SET rtbhdocno = g_rtbg_m.rtbgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtbh_t SELECT * FROM artt303_detail
   
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
   DROP TABLE artt303_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt303_delete()
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
   
   IF g_rtbg_m.rtbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artt303_cl USING g_enterprise,g_rtbg_m.rtbgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt303_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt303_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
       g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
       g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid_desc, 
       g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT artt303_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtbg_m_mask_o.* =  g_rtbg_m.*
   CALL artt303_rtbg_t_mask()
   LET g_rtbg_m_mask_n.* =  g_rtbg_m.*
   
   CALL artt303_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt303_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtbgdocno_t = g_rtbg_m.rtbgdocno
 
 
      DELETE FROM rtbg_t
       WHERE rtbgent = g_enterprise AND rtbgdocno = g_rtbg_m.rtbgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtbg_m.rtbgdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_rtbg_m.rtbgdocno,g_rtbg_m.rtbgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rtbh_t
       WHERE rtbhent = g_enterprise AND rtbhdocno = g_rtbg_m.rtbgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtbg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt303_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtbh_d.clear() 
 
     
      CALL artt303_ui_browser_refresh()  
      #CALL artt303_ui_headershow()  
      #CALL artt303_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt303_browser_fill("")
         CALL artt303_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt303_cl
 
   #功能已完成,通報訊息中心
   CALL artt303_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt303.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt303_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtbh_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artt303_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtbhseq,rtbhsite,rtbh001,rtbh002,rtbh003,rtbh004,rtbh005,rtbh006, 
             rtbh007,rtbh008,rtbhunit ,t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t4.pmaal004 ,t5.pmaal004 , 
             t6.staal003 ,t7.staal003 FROM rtbh_t",   
                     " INNER JOIN rtbg_t ON rtbgent = " ||g_enterprise|| " AND rtbgdocno = rtbhdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=rtbhsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=rtbh002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=rtbh002 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=rtbh003 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=rtbh004 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t6 ON t6.staalent="||g_enterprise||" AND t6.staal001=rtbh005 AND t6.staal002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t7 ON t7.staalent="||g_enterprise||" AND t7.staal001=rtbh006 AND t7.staal002='"||g_dlang||"' ",
 
                     " WHERE rtbhent=? AND rtbhdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtbh_t.rtbhseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt303_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt303_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtbg_m.rtbgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtbg_m.rtbgdocno INTO g_rtbh_d[l_ac].rtbhseq,g_rtbh_d[l_ac].rtbhsite, 
          g_rtbh_d[l_ac].rtbh001,g_rtbh_d[l_ac].rtbh002,g_rtbh_d[l_ac].rtbh003,g_rtbh_d[l_ac].rtbh004, 
          g_rtbh_d[l_ac].rtbh005,g_rtbh_d[l_ac].rtbh006,g_rtbh_d[l_ac].rtbh007,g_rtbh_d[l_ac].rtbh008, 
          g_rtbh_d[l_ac].rtbhunit,g_rtbh_d[l_ac].rtbhsite_desc,g_rtbh_d[l_ac].rtbh002_desc,g_rtbh_d[l_ac].rtbh002_desc_desc, 
          g_rtbh_d[l_ac].rtbh003_desc,g_rtbh_d[l_ac].rtbh004_desc,g_rtbh_d[l_ac].rtbh005_desc,g_rtbh_d[l_ac].rtbh006_desc  
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
   
   CALL g_rtbh_d.deleteElement(g_rtbh_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt303_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtbh_d.getLength()
      LET g_rtbh_d_mask_o[l_ac].* =  g_rtbh_d[l_ac].*
      CALL artt303_rtbh_t_mask()
      LET g_rtbh_d_mask_n[l_ac].* =  g_rtbh_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt303_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rtbh_t
       WHERE rtbhent = g_enterprise AND
         rtbhdocno = ps_keys_bak[1] AND rtbhseq = ps_keys_bak[2]
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
         CALL g_rtbh_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt303_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rtbh_t
                  (rtbhent,
                   rtbhdocno,
                   rtbhseq
                   ,rtbhsite,rtbh001,rtbh002,rtbh003,rtbh004,rtbh005,rtbh006,rtbh007,rtbh008,rtbhunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtbh_d[g_detail_idx].rtbhsite,g_rtbh_d[g_detail_idx].rtbh001,g_rtbh_d[g_detail_idx].rtbh002, 
                       g_rtbh_d[g_detail_idx].rtbh003,g_rtbh_d[g_detail_idx].rtbh004,g_rtbh_d[g_detail_idx].rtbh005, 
                       g_rtbh_d[g_detail_idx].rtbh006,g_rtbh_d[g_detail_idx].rtbh007,g_rtbh_d[g_detail_idx].rtbh008, 
                       g_rtbh_d[g_detail_idx].rtbhunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtbh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtbh_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt303_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtbh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt303_rtbh_t_mask_restore('restore_mask_o')
               
      UPDATE rtbh_t 
         SET (rtbhdocno,
              rtbhseq
              ,rtbhsite,rtbh001,rtbh002,rtbh003,rtbh004,rtbh005,rtbh006,rtbh007,rtbh008,rtbhunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtbh_d[g_detail_idx].rtbhsite,g_rtbh_d[g_detail_idx].rtbh001,g_rtbh_d[g_detail_idx].rtbh002, 
                  g_rtbh_d[g_detail_idx].rtbh003,g_rtbh_d[g_detail_idx].rtbh004,g_rtbh_d[g_detail_idx].rtbh005, 
                  g_rtbh_d[g_detail_idx].rtbh006,g_rtbh_d[g_detail_idx].rtbh007,g_rtbh_d[g_detail_idx].rtbh008, 
                  g_rtbh_d[g_detail_idx].rtbhunit) 
         WHERE rtbhent = g_enterprise AND rtbhdocno = ps_keys_bak[1] AND rtbhseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtbh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtbh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt303_rtbh_t_mask_restore('restore_mask_n')
               
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
 
{<section id="artt303.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt303_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="artt303.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt303_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="artt303.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt303_lock_b(ps_table,ps_page)
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
   #CALL artt303_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtbh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt303_bcl USING g_enterprise,
                                       g_rtbg_m.rtbgdocno,g_rtbh_d[g_detail_idx].rtbhseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt303_bcl:",SQLERRMESSAGE 
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
 
{<section id="artt303.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt303_unlock_b(ps_table,ps_page)
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
      CLOSE artt303_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt303_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtbgdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtbgdocno",TRUE)
      CALL cl_set_comp_entry("rtbgdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("rtbgsite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt303_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtbgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtbgdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtbgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'rtbgsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtbgsite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt303.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt303_set_entry_b(p_cmd)
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
 
{<section id="artt303.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt303_set_no_entry_b(p_cmd)
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
 
{<section id="artt303.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt303_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt303.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt303_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtbg_m.rtbgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt303.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt303_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt303.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt303_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt303.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt303_default_search()
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
      LET ls_wc = ls_wc, " rtbgdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rtbg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtbh_t" 
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
 
{<section id="artt303.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt303_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtbg_m.rtbgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt303_cl USING g_enterprise,g_rtbg_m.rtbgdocno
   IF STATUS THEN
      CLOSE artt303_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt303_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
       g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
       g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid_desc, 
       g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT artt303_action_chk() THEN
      CLOSE artt303_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite_desc,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001, 
       g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit, 
       g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgowndp_desc, 
       g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtid_desc,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgcrtdt, 
       g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfid_desc, 
       g_rtbg_m.rtbgcnfdt
 
   CASE g_rtbg_m.rtbgstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_rtbg_m.rtbgstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_rtbg_m.rtbgstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "X"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "confirmed"
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt303_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt303_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt303_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt303_cl
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
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      ) OR 
      g_rtbg_m.rtbgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt303_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE
      WHEN lc_state = 'Y'
         CALL cl_err_collect_init()
         CALL s_artt303_conf_chk(g_rtbg_m.rtbgdocno,g_rtbg_m.rtbgstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_artt303_conf_upd(g_rtbg_m.rtbgdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtbg_m.rtbgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN
         END IF
      WHEN lc_state = 'X'
         CALL cl_err_collect_init()
         CALL s_artt303_void_chk(g_rtbg_m.rtbgdocno,g_rtbg_m.rtbgstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('art-00039') THEN
               CALL s_transaction_begin()
               CALL s_artt303_void_upd(g_rtbg_m.rtbgdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtbg_m.rtbgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN
         END IF
      OTHERWISE
         CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
         RETURN
   END CASE 
   #end add-point
   
   LET g_rtbg_m.rtbgmodid = g_user
   LET g_rtbg_m.rtbgmoddt = cl_get_current()
   LET g_rtbg_m.rtbgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtbg_t 
      SET (rtbgstus,rtbgmodid,rtbgmoddt) 
        = (g_rtbg_m.rtbgstus,g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt)     
    WHERE rtbgent = g_enterprise AND rtbgdocno = g_rtbg_m.rtbgdocno
 
    
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
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE artt303_master_referesh USING g_rtbg_m.rtbgdocno INTO g_rtbg_m.rtbgsite,g_rtbg_m.rtbgdocdt, 
          g_rtbg_m.rtbgdocno,g_rtbg_m.rtbg001,g_rtbg_m.rtbg002,g_rtbg_m.rtbg003,g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus, 
          g_rtbg_m.rtbgownid,g_rtbg_m.rtbgowndp,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdt, 
          g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid,g_rtbg_m.rtbgcnfdt,g_rtbg_m.rtbgsite_desc, 
          g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp_desc, 
          g_rtbg_m.rtbgcrtid_desc,g_rtbg_m.rtbgcrtdp_desc,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtbg_m.rtbgsite,g_rtbg_m.rtbgsite_desc,g_rtbg_m.rtbgdocdt,g_rtbg_m.rtbgdocno, 
          g_rtbg_m.rtbg001,g_rtbg_m.rtbg001_desc,g_rtbg_m.rtbg002,g_rtbg_m.rtbg002_desc,g_rtbg_m.rtbg003, 
          g_rtbg_m.rtbgunit,g_rtbg_m.rtbgstus,g_rtbg_m.rtbgownid,g_rtbg_m.rtbgownid_desc,g_rtbg_m.rtbgowndp, 
          g_rtbg_m.rtbgowndp_desc,g_rtbg_m.rtbgcrtid,g_rtbg_m.rtbgcrtid_desc,g_rtbg_m.rtbgcrtdp,g_rtbg_m.rtbgcrtdp_desc, 
          g_rtbg_m.rtbgcrtdt,g_rtbg_m.rtbgmodid,g_rtbg_m.rtbgmodid_desc,g_rtbg_m.rtbgmoddt,g_rtbg_m.rtbgcnfid, 
          g_rtbg_m.rtbgcnfid_desc,g_rtbg_m.rtbgcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE artt303_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt303_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt303.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt303_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtbh_d.getLength() THEN
         LET g_detail_idx = g_rtbh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtbh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtbh_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt303_b_fill2(pi_idx)
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
   
   CALL artt303_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt303_fill_chk(ps_idx)
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
 
{<section id="artt303.status_show" >}
PRIVATE FUNCTION artt303_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt303.mask_functions" >}
&include "erp/art/artt303_mask.4gl"
 
{</section>}
 
{<section id="artt303.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt303_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL artt303_show()
   CALL artt303_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtbg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtbh_d))
 
 
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
   #CALL artt303_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt303_ui_headershow()
   CALL artt303_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt303_draw_out()
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
   CALL artt303_ui_headershow()  
   CALL artt303_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt303.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt303_set_pk_array()
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
   LET g_pk_array[1].values = g_rtbg_m.rtbgdocno
   LET g_pk_array[1].column = 'rtbgdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt303.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt303.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt303_msgcentre_notify(lc_state)
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
   CALL artt303_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtbg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt303.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt303_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#34 add-S
   SELECT rtbgstus  INTO g_rtbg_m.rtbgstus
     FROM rtbg_t
    WHERE rtbgent = g_enterprise
      AND rtbgdocno = g_rtbg_m.rtbgdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rtbg_m.rtbgstus
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
        LET g_errparam.extend = g_rtbg_m.rtbgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL artt303_set_act_visible()
        CALL artt303_set_act_no_visible()
        CALL artt303_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#34 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt303.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 商品帶值
# Memo...........:
# Usage..........: CALL artt303_rtbh002_ref()
# Date & Author..: 20150820 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt303_rtbh002_ref()
DEFINE l_star001       LIKE star_t.star001
DEFINE l_n             LIKE type_t.num10

   IF cl_null(g_rtbh_d[l_ac].rtbhsite) OR cl_null(g_rtbh_d[l_ac].rtbh002) THEN
      RETURN
   END IF
   
   #抓原主供應商
   SELECT imaf153 INTO g_rtbh_d[l_ac].rtbh003
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_rtbh_d[l_ac].rtbhsite
      AND imaf001 = g_rtbh_d[l_ac].rtbh002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbh_d[l_ac].rtbh003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbh_d[l_ac].rtbh003_desc
      
   #抓原結算方式和合同
   SELECT DISTINCT star001,star006,star004
     INTO l_star001,g_rtbh_d[l_ac].rtbh005,g_rtbh_d[l_ac].rtbh007
     FROM star_t,stas_t
    WHERE starent = stasent AND starent = g_enterprise
      AND star001 = stas001
      AND starsite = g_rtbh_d[l_ac].rtbhsite
      AND star003 = g_rtbh_d[l_ac].rtbh003
      AND stas003 = g_rtbh_d[l_ac].rtbh002
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh005
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbh_d[l_ac].rtbh005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbh_d[l_ac].rtbh005_desc
   
   #带出商品条码
   LET l_n = 0
   IF NOT cl_null(g_rtbh_d[l_ac].rtbh001) THEN
      SELECT COUNT(*) INTO l_n
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_rtbh_d[l_ac].rtbh002
         AND imay003 = g_rtbh_d[l_ac].rtbh001
   END IF
   IF cl_null(g_rtbh_d[l_ac].rtbh001) OR l_n < 1 THEN
      SELECT stas004 INTO g_rtbh_d[l_ac].rtbh001
        FROM stas_t
       WHERE stasent = g_enterprise
         AND stas001 = l_star001
         AND stas003 = g_rtbh_d[l_ac].rtbh002
   END IF
   
   #抓品名和規格
   SELECT imaal003,imaal004 INTO g_rtbh_d[l_ac].rtbh002_desc,g_rtbh_d[l_ac].rtbh002_desc_desc
     FROM imaal_t
    WHERE imaalent = g_enterprise
      AND imaal001 = g_rtbh_d[l_ac].rtbh002

END FUNCTION

################################################################################
# Descriptions...: 供应商带值
# Memo...........:
# Usage..........: CALL artt303_rtbh004_ref()
# Date & Author..: 20150820 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt303_rtbh004_ref()

   IF cl_null(g_rtbh_d[l_ac].rtbhsite) OR cl_null(g_rtbh_d[l_ac].rtbh002) OR cl_null(g_rtbh_d[l_ac].rtbh004) THEN
      RETURN
   END IF  
   
   #抓新結算方式和合同
   SELECT DISTINCT star006,star004
     INTO g_rtbh_d[l_ac].rtbh006,g_rtbh_d[l_ac].rtbh008
     FROM star_t,stas_t
    WHERE starent = stasent AND starent = g_enterprise
      AND star001 = stas001
      AND starsite = g_rtbh_d[l_ac].rtbhsite
      AND star003 = g_rtbh_d[l_ac].rtbh004
      AND stas003 = g_rtbh_d[l_ac].rtbh002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtbh_d[l_ac].rtbh006
   CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtbh_d[l_ac].rtbh006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtbh_d[l_ac].rtbh006_desc
   
END FUNCTION

################################################################################
# Descriptions...: 检查商品和供应商是否存在于采购协议中
# Memo...........:
# Usage..........: CALL artt303_rtbh002_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150820 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artt303_rtbh002_chk()
DEFINE l_n      LIKE type_t.num10

   IF cl_null(g_rtbh_d[l_ac].rtbhsite) OR cl_null(g_rtbh_d[l_ac].rtbh002) OR
      cl_null(g_rtbh_d[l_ac].rtbh004) THEN
      RETURN TRUE
   END IF

   #对应商品必须存在此供应商的采购协议里
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM star_t,stas_t
    WHERE starent = stasent 
      AND starent = g_enterprise
      AND star001 = stas001
      AND starsite = g_rtbh_d[l_ac].rtbhsite
      AND star003 = g_rtbh_d[l_ac].rtbh004
      AND stas003 = g_rtbh_d[l_ac].rtbh002
   IF l_n < 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = "art-00703" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN FALSE
   END IF
               
   RETURN TRUE
END FUNCTION

 
{</section>}
 
