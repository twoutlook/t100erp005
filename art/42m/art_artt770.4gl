#該程式未解開Section, 採用最新樣板產出!
{<section id="artt770.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-01-20 11:01:01), PR版次:0004(2016-11-07 09:41:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: artt770
#+ Description: 自動補貨建議維護作業
#+ Creator....: 03247(2014-12-23 14:42:44)
#+ Modifier...: 03247 -SD/PR- 06137
 
{</section>}
 
{<section id="artt770.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
# Modify......: NO.160816-00068#10   2016/08/17   By 08209    調整transaction
# Modify......: NO.160824-00007#173  2016/11/07   By 06137    修正舊值備份寫法
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
PRIVATE type type_g_rtkm_m        RECORD
       rtkmsite LIKE rtkm_t.rtkmsite, 
   rtkmsite_desc LIKE type_t.chr80, 
   rtkmdocdt LIKE rtkm_t.rtkmdocdt, 
   rtkmdocno LIKE rtkm_t.rtkmdocno, 
   rtkm001 LIKE rtkm_t.rtkm001, 
   rtkm004 LIKE rtkm_t.rtkm004, 
   rtkm002 LIKE rtkm_t.rtkm002, 
   rtkm002_desc LIKE type_t.chr80, 
   rtkm003 LIKE rtkm_t.rtkm003, 
   rtkm003_desc LIKE type_t.chr80, 
   rtkmunit LIKE rtkm_t.rtkmunit, 
   rtkmstus LIKE rtkm_t.rtkmstus, 
   rtkmownid LIKE rtkm_t.rtkmownid, 
   rtkmownid_desc LIKE type_t.chr80, 
   rtkmowndp LIKE rtkm_t.rtkmowndp, 
   rtkmowndp_desc LIKE type_t.chr80, 
   rtkmcrtid LIKE rtkm_t.rtkmcrtid, 
   rtkmcrtid_desc LIKE type_t.chr80, 
   rtkmcrtdp LIKE rtkm_t.rtkmcrtdp, 
   rtkmcrtdp_desc LIKE type_t.chr80, 
   rtkmcrtdt LIKE rtkm_t.rtkmcrtdt, 
   rtkmmodid LIKE rtkm_t.rtkmmodid, 
   rtkmmodid_desc LIKE type_t.chr80, 
   rtkmmoddt LIKE rtkm_t.rtkmmoddt, 
   rtkmcnfid LIKE rtkm_t.rtkmcnfid, 
   rtkmcnfid_desc LIKE type_t.chr80, 
   rtkmcnfdt LIKE rtkm_t.rtkmcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtkn_d        RECORD
       rtknseq LIKE rtkn_t.rtknseq, 
   rtkn002 LIKE rtkn_t.rtkn002, 
   rtkn001 LIKE rtkn_t.rtkn001, 
   rtkn001_desc LIKE type_t.chr500, 
   rtkn001_desc_desc LIKE type_t.chr500, 
   rtkn004 LIKE rtkn_t.rtkn004, 
   rtkn004_desc LIKE type_t.chr500, 
   rtkn006 LIKE rtkn_t.rtkn006, 
   rtkn006_desc LIKE type_t.chr500, 
   rtkn007 LIKE rtkn_t.rtkn007, 
   rtkn007_desc LIKE type_t.chr500, 
   rtkn501a LIKE rtkn_t.rtkn501a, 
   rtkn501b LIKE rtkn_t.rtkn501b, 
   rtkn501c LIKE rtkn_t.rtkn501c, 
   rtkn501d LIKE rtkn_t.rtkn501d, 
   rtkn501 LIKE rtkn_t.rtkn501, 
   rtkn008 LIKE rtkn_t.rtkn008, 
   rtkn009 LIKE rtkn_t.rtkn009, 
   rtkn010 LIKE rtkn_t.rtkn010
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtkmsite LIKE rtkm_t.rtkmsite,
   b_rtkmsite_desc LIKE type_t.chr80,
      b_rtkmdocdt LIKE rtkm_t.rtkmdocdt,
      b_rtkmdocno LIKE rtkm_t.rtkmdocno,
      b_rtkm001 LIKE rtkm_t.rtkm001,
      b_rtkm004 LIKE rtkm_t.rtkm004,
      b_rtkm002 LIKE rtkm_t.rtkm002,
   b_rtkm002_desc LIKE type_t.chr80,
      b_rtkm003 LIKE rtkm_t.rtkm003,
   b_rtkm003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtkm_m          type_g_rtkm_m
DEFINE g_rtkm_m_t        type_g_rtkm_m
DEFINE g_rtkm_m_o        type_g_rtkm_m
DEFINE g_rtkm_m_mask_o   type_g_rtkm_m #轉換遮罩前資料
DEFINE g_rtkm_m_mask_n   type_g_rtkm_m #轉換遮罩後資料
 
   DEFINE g_rtkmdocno_t LIKE rtkm_t.rtkmdocno
 
 
DEFINE g_rtkn_d          DYNAMIC ARRAY OF type_g_rtkn_d
DEFINE g_rtkn_d_t        type_g_rtkn_d
DEFINE g_rtkn_d_o        type_g_rtkn_d
DEFINE g_rtkn_d_mask_o   DYNAMIC ARRAY OF type_g_rtkn_d #轉換遮罩前資料
DEFINE g_rtkn_d_mask_n   DYNAMIC ARRAY OF type_g_rtkn_d #轉換遮罩後資料
 
 
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
 
{<section id="artt770.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
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
   LET g_forupd_sql = " SELECT rtkmsite,'',rtkmdocdt,rtkmdocno,rtkm001,rtkm004,rtkm002,'',rtkm003,'', 
       rtkmunit,rtkmstus,rtkmownid,'',rtkmowndp,'',rtkmcrtid,'',rtkmcrtdp,'',rtkmcrtdt,rtkmmodid,'', 
       rtkmmoddt,rtkmcnfid,'',rtkmcnfdt", 
                      " FROM rtkm_t",
                      " WHERE rtkment= ? AND rtkmdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt770_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtkmsite,t0.rtkmdocdt,t0.rtkmdocno,t0.rtkm001,t0.rtkm004,t0.rtkm002, 
       t0.rtkm003,t0.rtkmunit,t0.rtkmstus,t0.rtkmownid,t0.rtkmowndp,t0.rtkmcrtid,t0.rtkmcrtdp,t0.rtkmcrtdt, 
       t0.rtkmmodid,t0.rtkmmoddt,t0.rtkmcnfid,t0.rtkmcnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.ooag011 , 
       t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM rtkm_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtkmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtkm002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtkm003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtkmownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtkmowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtkmcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.rtkmcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtkmmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rtkmcnfid  ",
 
               " WHERE t0.rtkment = " ||g_enterprise|| " AND t0.rtkmdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt770_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt770 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt770_init()   
 
      #進入選單 Menu (="N")
      CALL artt770_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt770
      
   END IF 
   
   CLOSE artt770_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt770.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt770_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
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
      CALL cl_set_combo_scc_part('rtkmstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
   
   #初始化搜尋條件
   CALL artt770_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt770.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt770_ui_dialog()
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
   DEFINE r_success LIKE type_t.num5
   DEFINE l_rtkmstus LIKE rtkm_t.rtkmstus
   DEFINE l_rtkm004  LIKE rtkm_t.rtkm004
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_rtkm_m.* TO NULL
         CALL g_rtkn_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt770_init()
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
               
               CALL artt770_fetch('') # reload data
               LET l_ac = 1
               CALL artt770_ui_detailshow() #Setting the current row 
         
               CALL artt770_idx_chk()
               #NEXT FIELD rtknseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtkn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt770_idx_chk()
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
               CALL artt770_idx_chk()
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
            CALL artt770_browser_fill("")
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
               CALL artt770_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt770_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt770_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt770_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt770_set_act_visible()   
            CALL artt770_set_act_no_visible()
            IF NOT (g_rtkm_m.rtkmdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtkment = " ||g_enterprise|| " AND",
                                  " rtkmdocno = '", g_rtkm_m.rtkmdocno, "' "
 
               #填到對應位置
               CALL artt770_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "rtkm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtkn_t" 
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
               CALL artt770_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rtkm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtkn_t" 
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
                  CALL artt770_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt770_fetch("F")
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
               CALL artt770_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt770_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt770_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt770_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt770_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt770_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt770_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt770_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt770_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt770_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt770_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtkn_d)
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
               NEXT FIELD rtknseq
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
               CALL artt770_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt770_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt770_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ins_pmda
            LET g_action_choice="ins_pmda"
            IF cl_auth_chk_act("ins_pmda") THEN
               
               #add-point:ON ACTION ins_pmda name="menu.ins_pmda"
               SELECT rtkmstus,rtkm004 INTO l_rtkmstus,l_rtkm004
                 FROM rtkm_t
                WHERE rtkment = g_enterprise
                  AND rtkmdocno = g_rtkm_m.rtkmdocno
               IF l_rtkmstus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "art-00451" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF NOT cl_null(l_rtkm004) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "art-00452" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               CALL s_transaction_begin()
               CALL s_ins_pmda(g_rtkm_m.rtkmdocno) RETURNING r_success
               IF r_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "art-00422" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               SELECT rtkm004 INTO g_rtkm_m.rtkm004
                 FROM rtkm_t
                WHERE rtkment = g_enterprise
                  AND rtkmdocno = g_rtkm_m.rtkmdocno
               DISPLAY BY NAME g_rtkm_m.rtkm004
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/art/artt770_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/art/artt770_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt770_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt770_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt770_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt770_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtkm_m.rtkmdocdt)
 
 
 
         
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
 
{<section id="artt770.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt770_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'rtkmsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rtkmdocno ",
                      " FROM rtkm_t ",
                      " ",
                      " LEFT JOIN rtkn_t ON rtknent = rtkment AND rtkmdocno = rtkndocno ", "  ",
                      #add-point:browser_fill段sql(rtkn_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE rtkment = " ||g_enterprise|| " AND rtknent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtkm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtkmdocno ",
                      " FROM rtkm_t ", 
                      "  ",
                      "  ",
                      " WHERE rtkment = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtkm_t")
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
      INITIALIZE g_rtkm_m.* TO NULL
      CALL g_rtkn_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtkmsite,t0.rtkmdocdt,t0.rtkmdocno,t0.rtkm001,t0.rtkm004,t0.rtkm002,t0.rtkm003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtkmstus,t0.rtkmsite,t0.rtkmdocdt,t0.rtkmdocno,t0.rtkm001,t0.rtkm004, 
          t0.rtkm002,t0.rtkm003,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM rtkm_t t0",
                  "  ",
                  "  LEFT JOIN rtkn_t ON rtknent = rtkment AND rtkmdocno = rtkndocno ", "  ", 
                  #add-point:browser_fill段sql(rtkn_t1) name="browser_fill.join.rtkn_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtkmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtkm002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtkm003 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtkment = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtkm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtkmstus,t0.rtkmsite,t0.rtkmdocdt,t0.rtkmdocno,t0.rtkm001,t0.rtkm004, 
          t0.rtkm002,t0.rtkm003,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM rtkm_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtkmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rtkm002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rtkm003 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtkment = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtkm_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtkmdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtkm_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtkmsite,g_browser[g_cnt].b_rtkmdocdt, 
          g_browser[g_cnt].b_rtkmdocno,g_browser[g_cnt].b_rtkm001,g_browser[g_cnt].b_rtkm004,g_browser[g_cnt].b_rtkm002, 
          g_browser[g_cnt].b_rtkm003,g_browser[g_cnt].b_rtkmsite_desc,g_browser[g_cnt].b_rtkm002_desc, 
          g_browser[g_cnt].b_rtkm003_desc
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
         CALL artt770_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_rtkmdocno) THEN
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
 
{<section id="artt770.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt770_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtkm_m.rtkmdocno = g_browser[g_current_idx].b_rtkmdocno   
 
   EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
       g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
       g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
       g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp_desc, 
       g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmcnfid_desc 
 
   
   CALL artt770_rtkm_t_mask()
   CALL artt770_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt770.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt770_ui_detailshow()
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
 
{<section id="artt770.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt770_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtkmdocno = g_rtkm_m.rtkmdocno 
 
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
 
{<section id="artt770.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt770_construct()
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
   INITIALIZE g_rtkm_m.* TO NULL
   CALL g_rtkn_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON rtkmsite,rtkmdocdt,rtkmdocno,rtkm001,rtkm004,rtkm002,rtkm003,rtkmunit, 
          rtkmstus,rtkmownid,rtkmowndp,rtkmcrtid,rtkmcrtdp,rtkmcrtdt,rtkmmodid,rtkmmoddt,rtkmcnfid,rtkmcnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtkmcrtdt>>----
         AFTER FIELD rtkmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtkmmoddt>>----
         AFTER FIELD rtkmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtkmcnfdt>>----
         AFTER FIELD rtkmcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtkmpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtkmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmsite
            #add-point:ON ACTION controlp INFIELD rtkmsite name="construct.c.rtkmsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtkmsite',g_site,'c')   #150308-00001#5  By benson add 'c' 
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmsite  #顯示到畫面上
            NEXT FIELD rtkmsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmsite
            #add-point:BEFORE FIELD rtkmsite name="construct.b.rtkmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmsite
            
            #add-point:AFTER FIELD rtkmsite name="construct.a.rtkmsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmdocdt
            #add-point:BEFORE FIELD rtkmdocdt name="construct.b.rtkmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmdocdt
            
            #add-point:AFTER FIELD rtkmdocdt name="construct.a.rtkmdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmdocdt
            #add-point:ON ACTION controlp INFIELD rtkmdocdt name="construct.c.rtkmdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtkmdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmdocno
            #add-point:ON ACTION controlp INFIELD rtkmdocno name="construct.c.rtkmdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtkmdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmdocno  #顯示到畫面上
            NEXT FIELD rtkmdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmdocno
            #add-point:BEFORE FIELD rtkmdocno name="construct.b.rtkmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmdocno
            
            #add-point:AFTER FIELD rtkmdocno name="construct.a.rtkmdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm001
            #add-point:BEFORE FIELD rtkm001 name="construct.b.rtkm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm001
            
            #add-point:AFTER FIELD rtkm001 name="construct.a.rtkm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm001
            #add-point:ON ACTION controlp INFIELD rtkm001 name="construct.c.rtkm001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtkm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm004
            #add-point:ON ACTION controlp INFIELD rtkm004 name="construct.c.rtkm004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmda200 = '1' "
            CALL q_pmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkm004  #顯示到畫面上
            NEXT FIELD rtkm004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm004
            #add-point:BEFORE FIELD rtkm004 name="construct.b.rtkm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm004
            
            #add-point:AFTER FIELD rtkm004 name="construct.a.rtkm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm002
            #add-point:ON ACTION controlp INFIELD rtkm002 name="construct.c.rtkm002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkm002  #顯示到畫面上
            NEXT FIELD rtkm002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm002
            #add-point:BEFORE FIELD rtkm002 name="construct.b.rtkm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm002
            
            #add-point:AFTER FIELD rtkm002 name="construct.a.rtkm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm003
            #add-point:ON ACTION controlp INFIELD rtkm003 name="construct.c.rtkm003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkm003  #顯示到畫面上
            NEXT FIELD rtkm003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm003
            #add-point:BEFORE FIELD rtkm003 name="construct.b.rtkm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm003
            
            #add-point:AFTER FIELD rtkm003 name="construct.a.rtkm003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmunit
            #add-point:BEFORE FIELD rtkmunit name="construct.b.rtkmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmunit
            
            #add-point:AFTER FIELD rtkmunit name="construct.a.rtkmunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmunit
            #add-point:ON ACTION controlp INFIELD rtkmunit name="construct.c.rtkmunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmstus
            #add-point:BEFORE FIELD rtkmstus name="construct.b.rtkmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmstus
            
            #add-point:AFTER FIELD rtkmstus name="construct.a.rtkmstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmstus
            #add-point:ON ACTION controlp INFIELD rtkmstus name="construct.c.rtkmstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtkmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmownid
            #add-point:ON ACTION controlp INFIELD rtkmownid name="construct.c.rtkmownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmownid  #顯示到畫面上
            NEXT FIELD rtkmownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmownid
            #add-point:BEFORE FIELD rtkmownid name="construct.b.rtkmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmownid
            
            #add-point:AFTER FIELD rtkmownid name="construct.a.rtkmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmowndp
            #add-point:ON ACTION controlp INFIELD rtkmowndp name="construct.c.rtkmowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmowndp  #顯示到畫面上
            NEXT FIELD rtkmowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmowndp
            #add-point:BEFORE FIELD rtkmowndp name="construct.b.rtkmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmowndp
            
            #add-point:AFTER FIELD rtkmowndp name="construct.a.rtkmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmcrtid
            #add-point:ON ACTION controlp INFIELD rtkmcrtid name="construct.c.rtkmcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmcrtid  #顯示到畫面上
            NEXT FIELD rtkmcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmcrtid
            #add-point:BEFORE FIELD rtkmcrtid name="construct.b.rtkmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmcrtid
            
            #add-point:AFTER FIELD rtkmcrtid name="construct.a.rtkmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtkmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmcrtdp
            #add-point:ON ACTION controlp INFIELD rtkmcrtdp name="construct.c.rtkmcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmcrtdp  #顯示到畫面上
            NEXT FIELD rtkmcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmcrtdp
            #add-point:BEFORE FIELD rtkmcrtdp name="construct.b.rtkmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmcrtdp
            
            #add-point:AFTER FIELD rtkmcrtdp name="construct.a.rtkmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmcrtdt
            #add-point:BEFORE FIELD rtkmcrtdt name="construct.b.rtkmcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtkmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmmodid
            #add-point:ON ACTION controlp INFIELD rtkmmodid name="construct.c.rtkmmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmmodid  #顯示到畫面上
            NEXT FIELD rtkmmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmmodid
            #add-point:BEFORE FIELD rtkmmodid name="construct.b.rtkmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmmodid
            
            #add-point:AFTER FIELD rtkmmodid name="construct.a.rtkmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmmoddt
            #add-point:BEFORE FIELD rtkmmoddt name="construct.b.rtkmmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtkmcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmcnfid
            #add-point:ON ACTION controlp INFIELD rtkmcnfid name="construct.c.rtkmcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkmcnfid  #顯示到畫面上
            NEXT FIELD rtkmcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmcnfid
            #add-point:BEFORE FIELD rtkmcnfid name="construct.b.rtkmcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmcnfid
            
            #add-point:AFTER FIELD rtkmcnfid name="construct.a.rtkmcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmcnfdt
            #add-point:BEFORE FIELD rtkmcnfdt name="construct.b.rtkmcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtknseq,rtkn002,rtkn001,rtkn004,rtkn006,rtkn007,rtkn501a,rtkn501b,rtkn501c, 
          rtkn501d,rtkn501,rtkn008,rtkn009,rtkn010
           FROM s_detail1[1].rtknseq,s_detail1[1].rtkn002,s_detail1[1].rtkn001,s_detail1[1].rtkn004, 
               s_detail1[1].rtkn006,s_detail1[1].rtkn007,s_detail1[1].rtkn501a,s_detail1[1].rtkn501b, 
               s_detail1[1].rtkn501c,s_detail1[1].rtkn501d,s_detail1[1].rtkn501,s_detail1[1].rtkn008, 
               s_detail1[1].rtkn009,s_detail1[1].rtkn010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtknseq
            #add-point:BEFORE FIELD rtknseq name="construct.b.page1.rtknseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtknseq
            
            #add-point:AFTER FIELD rtknseq name="construct.a.page1.rtknseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtknseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtknseq
            #add-point:ON ACTION controlp INFIELD rtknseq name="construct.c.page1.rtknseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtkn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn002
            #add-point:ON ACTION controlp INFIELD rtkn002 name="construct.c.page1.rtkn002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkn002  #顯示到畫面上
            NEXT FIELD rtkn002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn002
            #add-point:BEFORE FIELD rtkn002 name="construct.b.page1.rtkn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn002
            
            #add-point:AFTER FIELD rtkn002 name="construct.a.page1.rtkn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn001
            #add-point:ON ACTION controlp INFIELD rtkn001 name="construct.c.page1.rtkn001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkn001  #顯示到畫面上
            NEXT FIELD rtkn001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn001
            #add-point:BEFORE FIELD rtkn001 name="construct.b.page1.rtkn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn001
            
            #add-point:AFTER FIELD rtkn001 name="construct.a.page1.rtkn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn004
            #add-point:ON ACTION controlp INFIELD rtkn004 name="construct.c.page1.rtkn004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkn004  #顯示到畫面上
            NEXT FIELD rtkn004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn004
            #add-point:BEFORE FIELD rtkn004 name="construct.b.page1.rtkn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn004
            
            #add-point:AFTER FIELD rtkn004 name="construct.a.page1.rtkn004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn006
            #add-point:ON ACTION controlp INFIELD rtkn006 name="construct.c.page1.rtkn006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkn006  #顯示到畫面上
            NEXT FIELD rtkn006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn006
            #add-point:BEFORE FIELD rtkn006 name="construct.b.page1.rtkn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn006
            
            #add-point:AFTER FIELD rtkn006 name="construct.a.page1.rtkn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn007
            #add-point:ON ACTION controlp INFIELD rtkn007 name="construct.c.page1.rtkn007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtkn007  #顯示到畫面上
            NEXT FIELD rtkn007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn007
            #add-point:BEFORE FIELD rtkn007 name="construct.b.page1.rtkn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn007
            
            #add-point:AFTER FIELD rtkn007 name="construct.a.page1.rtkn007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501a
            #add-point:BEFORE FIELD rtkn501a name="construct.b.page1.rtkn501a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501a
            
            #add-point:AFTER FIELD rtkn501a name="construct.a.page1.rtkn501a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn501a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501a
            #add-point:ON ACTION controlp INFIELD rtkn501a name="construct.c.page1.rtkn501a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501b
            #add-point:BEFORE FIELD rtkn501b name="construct.b.page1.rtkn501b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501b
            
            #add-point:AFTER FIELD rtkn501b name="construct.a.page1.rtkn501b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn501b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501b
            #add-point:ON ACTION controlp INFIELD rtkn501b name="construct.c.page1.rtkn501b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501c
            #add-point:BEFORE FIELD rtkn501c name="construct.b.page1.rtkn501c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501c
            
            #add-point:AFTER FIELD rtkn501c name="construct.a.page1.rtkn501c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn501c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501c
            #add-point:ON ACTION controlp INFIELD rtkn501c name="construct.c.page1.rtkn501c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501d
            #add-point:BEFORE FIELD rtkn501d name="construct.b.page1.rtkn501d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501d
            
            #add-point:AFTER FIELD rtkn501d name="construct.a.page1.rtkn501d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn501d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501d
            #add-point:ON ACTION controlp INFIELD rtkn501d name="construct.c.page1.rtkn501d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501
            #add-point:BEFORE FIELD rtkn501 name="construct.b.page1.rtkn501"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501
            
            #add-point:AFTER FIELD rtkn501 name="construct.a.page1.rtkn501"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn501
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501
            #add-point:ON ACTION controlp INFIELD rtkn501 name="construct.c.page1.rtkn501"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn008
            #add-point:BEFORE FIELD rtkn008 name="construct.b.page1.rtkn008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn008
            
            #add-point:AFTER FIELD rtkn008 name="construct.a.page1.rtkn008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn008
            #add-point:ON ACTION controlp INFIELD rtkn008 name="construct.c.page1.rtkn008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn009
            #add-point:BEFORE FIELD rtkn009 name="construct.b.page1.rtkn009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn009
            
            #add-point:AFTER FIELD rtkn009 name="construct.a.page1.rtkn009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn009
            #add-point:ON ACTION controlp INFIELD rtkn009 name="construct.c.page1.rtkn009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn010
            #add-point:BEFORE FIELD rtkn010 name="construct.b.page1.rtkn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn010
            
            #add-point:AFTER FIELD rtkn010 name="construct.a.page1.rtkn010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtkn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn010
            #add-point:ON ACTION controlp INFIELD rtkn010 name="construct.c.page1.rtkn010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_rtkn_d[1].rtknseq = ""
         DISPLAY ARRAY g_rtkn_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
                  WHEN la_wc[li_idx].tableid = "rtkm_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtkn_t" 
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
 
{<section id="artt770.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt770_filter()
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
      CONSTRUCT g_wc_filter ON rtkmsite,rtkmdocdt,rtkmdocno,rtkm001,rtkm004,rtkm002,rtkm003
                          FROM s_browse[1].b_rtkmsite,s_browse[1].b_rtkmdocdt,s_browse[1].b_rtkmdocno, 
                              s_browse[1].b_rtkm001,s_browse[1].b_rtkm004,s_browse[1].b_rtkm002,s_browse[1].b_rtkm003 
 
 
         BEFORE CONSTRUCT
               DISPLAY artt770_filter_parser('rtkmsite') TO s_browse[1].b_rtkmsite
            DISPLAY artt770_filter_parser('rtkmdocdt') TO s_browse[1].b_rtkmdocdt
            DISPLAY artt770_filter_parser('rtkmdocno') TO s_browse[1].b_rtkmdocno
            DISPLAY artt770_filter_parser('rtkm001') TO s_browse[1].b_rtkm001
            DISPLAY artt770_filter_parser('rtkm004') TO s_browse[1].b_rtkm004
            DISPLAY artt770_filter_parser('rtkm002') TO s_browse[1].b_rtkm002
            DISPLAY artt770_filter_parser('rtkm003') TO s_browse[1].b_rtkm003
      
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
 
      CALL artt770_filter_show('rtkmsite')
   CALL artt770_filter_show('rtkmdocdt')
   CALL artt770_filter_show('rtkmdocno')
   CALL artt770_filter_show('rtkm001')
   CALL artt770_filter_show('rtkm004')
   CALL artt770_filter_show('rtkm002')
   CALL artt770_filter_show('rtkm003')
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt770_filter_parser(ps_field)
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
 
{<section id="artt770.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt770_filter_show(ps_field)
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
   LET ls_condition = artt770_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt770_query()
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
   CALL g_rtkn_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt770_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt770_browser_fill("")
      CALL artt770_fetch("")
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
      CALL artt770_filter_show('rtkmsite')
   CALL artt770_filter_show('rtkmdocdt')
   CALL artt770_filter_show('rtkmdocno')
   CALL artt770_filter_show('rtkm001')
   CALL artt770_filter_show('rtkm004')
   CALL artt770_filter_show('rtkm002')
   CALL artt770_filter_show('rtkm003')
   CALL artt770_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt770_fetch("F") 
      #顯示單身筆數
      CALL artt770_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt770_fetch(p_flag)
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
   
   LET g_rtkm_m.rtkmdocno = g_browser[g_current_idx].b_rtkmdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
       g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
       g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
       g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp_desc, 
       g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmcnfid_desc 
 
   
   #遮罩相關處理
   LET g_rtkm_m_mask_o.* =  g_rtkm_m.*
   CALL artt770_rtkm_t_mask()
   LET g_rtkm_m_mask_n.* =  g_rtkm_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt770_set_act_visible()   
   CALL artt770_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtkm_m_t.* = g_rtkm_m.*
   LET g_rtkm_m_o.* = g_rtkm_m.*
   
   LET g_data_owner = g_rtkm_m.rtkmownid      
   LET g_data_dept  = g_rtkm_m.rtkmowndp
   
   #重新顯示   
   CALL artt770_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt770_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtkn_d.clear()   
 
 
   INITIALIZE g_rtkm_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtkmdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtkm_m.rtkmownid = g_user
      LET g_rtkm_m.rtkmowndp = g_dept
      LET g_rtkm_m.rtkmcrtid = g_user
      LET g_rtkm_m.rtkmcrtdp = g_dept 
      LET g_rtkm_m.rtkmcrtdt = cl_get_current()
      LET g_rtkm_m.rtkmmodid = g_user
      LET g_rtkm_m.rtkmmoddt = cl_get_current()
      LET g_rtkm_m.rtkmstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtkm_m_t.* = g_rtkm_m.*
      LET g_rtkm_m_o.* = g_rtkm_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtkm_m.rtkmstus 
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
 
 
 
    
      CALL artt770_input("a")
      
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
         INITIALIZE g_rtkm_m.* TO NULL
         INITIALIZE g_rtkn_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt770_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtkn_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt770_set_act_visible()   
   CALL artt770_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtkment = " ||g_enterprise|| " AND",
                      " rtkmdocno = '", g_rtkm_m.rtkmdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt770_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt770_cl
   
   CALL artt770_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
       g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
       g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
       g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp_desc, 
       g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_rtkm_m_mask_o.* =  g_rtkm_m.*
   CALL artt770_rtkm_t_mask()
   LET g_rtkm_m_mask_n.* =  g_rtkm_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001, 
       g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003,g_rtkm_m.rtkm003_desc, 
       g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp, 
       g_rtkm_m.rtkmowndp_desc,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp,g_rtkm_m.rtkmcrtdp_desc, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid, 
       g_rtkm_m.rtkmcnfid_desc,g_rtkm_m.rtkmcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtkm_m.rtkmownid      
   LET g_data_dept  = g_rtkm_m.rtkmowndp
   
   #功能已完成,通報訊息中心
   CALL artt770_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt770_modify()
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
   LET g_rtkm_m_t.* = g_rtkm_m.*
   LET g_rtkm_m_o.* = g_rtkm_m.*
   
   IF g_rtkm_m.rtkmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
   CALL s_transaction_begin()
   
   OPEN artt770_cl USING g_enterprise,g_rtkm_m.rtkmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt770_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt770_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
       g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
       g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
       g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp_desc, 
       g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT artt770_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtkm_m_mask_o.* =  g_rtkm_m.*
   CALL artt770_rtkm_t_mask()
   LET g_rtkm_m_mask_n.* =  g_rtkm_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL artt770_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtkm_m.rtkmmodid = g_user 
LET g_rtkm_m.rtkmmoddt = cl_get_current()
LET g_rtkm_m.rtkmmodid_desc = cl_get_username(g_rtkm_m.rtkmmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt770_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtkm_t SET (rtkmmodid,rtkmmoddt) = (g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt)
          WHERE rtkment = g_enterprise AND rtkmdocno = g_rtkmdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtkm_m.* = g_rtkm_m_t.*
            CALL artt770_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtkm_m.rtkmdocno != g_rtkm_m_t.rtkmdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rtkn_t SET rtkndocno = g_rtkm_m.rtkmdocno
 
          WHERE rtknent = g_enterprise AND rtkndocno = g_rtkm_m_t.rtkmdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtkn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtkn_t:",SQLERRMESSAGE 
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
   CALL artt770_set_act_visible()   
   CALL artt770_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtkment = " ||g_enterprise|| " AND",
                      " rtkmdocno = '", g_rtkm_m.rtkmdocno, "' "
 
   #填到對應位置
   CALL artt770_browser_fill("")
 
   CLOSE artt770_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt770_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt770.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt770_input(p_cmd)
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
   DEFINE  l_rtdx034             LIKE rtdx_t.rtdx034
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
   DISPLAY BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001, 
       g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003,g_rtkm_m.rtkm003_desc, 
       g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp, 
       g_rtkm_m.rtkmowndp_desc,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp,g_rtkm_m.rtkmcrtdp_desc, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid, 
       g_rtkm_m.rtkmcnfid_desc,g_rtkm_m.rtkmcnfdt
   
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
   LET g_forupd_sql = "SELECT rtknseq,rtkn002,rtkn001,rtkn004,rtkn006,rtkn007,rtkn501a,rtkn501b,rtkn501c, 
       rtkn501d,rtkn501,rtkn008,rtkn009,rtkn010 FROM rtkn_t WHERE rtknent=? AND rtkndocno=? AND rtknseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt770_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt770_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL artt770_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004, 
       g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt770.input.head" >}
      #單頭段
      INPUT BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004, 
          g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt770_cl USING g_enterprise,g_rtkm_m.rtkmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt770_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt770_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt770_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL artt770_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmsite
            
            #add-point:AFTER FIELD rtkmsite name="input.a.rtkmsite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkm_m.rtkmsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtkm_m.rtkmsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkm_m.rtkmsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmsite
            #add-point:BEFORE FIELD rtkmsite name="input.b.rtkmsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkmsite
            #add-point:ON CHANGE rtkmsite name="input.g.rtkmsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmdocdt
            #add-point:BEFORE FIELD rtkmdocdt name="input.b.rtkmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmdocdt
            
            #add-point:AFTER FIELD rtkmdocdt name="input.a.rtkmdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkmdocdt
            #add-point:ON CHANGE rtkmdocdt name="input.g.rtkmdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmdocno
            #add-point:BEFORE FIELD rtkmdocno name="input.b.rtkmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmdocno
            
            #add-point:AFTER FIELD rtkmdocno name="input.a.rtkmdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rtkm_m.rtkmdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtkm_m.rtkmdocno != g_rtkmdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtkm_t WHERE "||"rtkment = '" ||g_enterprise|| "' AND "||"rtkmdocno = '"||g_rtkm_m.rtkmdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkmdocno
            #add-point:ON CHANGE rtkmdocno name="input.g.rtkmdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm001
            #add-point:BEFORE FIELD rtkm001 name="input.b.rtkm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm001
            
            #add-point:AFTER FIELD rtkm001 name="input.a.rtkm001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkm001
            #add-point:ON CHANGE rtkm001 name="input.g.rtkm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm004
            #add-point:BEFORE FIELD rtkm004 name="input.b.rtkm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm004
            
            #add-point:AFTER FIELD rtkm004 name="input.a.rtkm004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkm004
            #add-point:ON CHANGE rtkm004 name="input.g.rtkm004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm002
            
            #add-point:AFTER FIELD rtkm002 name="input.a.rtkm002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkm_m.rtkm002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rtkm_m.rtkm002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkm_m.rtkm002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm002
            #add-point:BEFORE FIELD rtkm002 name="input.b.rtkm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkm002
            #add-point:ON CHANGE rtkm002 name="input.g.rtkm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkm003
            
            #add-point:AFTER FIELD rtkm003 name="input.a.rtkm003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkm_m.rtkm003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtkm_m.rtkm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkm_m.rtkm003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkm003
            #add-point:BEFORE FIELD rtkm003 name="input.b.rtkm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkm003
            #add-point:ON CHANGE rtkm003 name="input.g.rtkm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmunit
            #add-point:BEFORE FIELD rtkmunit name="input.b.rtkmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmunit
            
            #add-point:AFTER FIELD rtkmunit name="input.a.rtkmunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkmunit
            #add-point:ON CHANGE rtkmunit name="input.g.rtkmunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkmstus
            #add-point:BEFORE FIELD rtkmstus name="input.b.rtkmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkmstus
            
            #add-point:AFTER FIELD rtkmstus name="input.a.rtkmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkmstus
            #add-point:ON CHANGE rtkmstus name="input.g.rtkmstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtkmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmsite
            #add-point:ON ACTION controlp INFIELD rtkmsite name="input.c.rtkmsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtkm_m.rtkmsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_rtkm_m.rtkmsite = g_qryparam.return1              

            DISPLAY g_rtkm_m.rtkmsite TO rtkmsite              #

            NEXT FIELD rtkmsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtkmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmdocdt
            #add-point:ON ACTION controlp INFIELD rtkmdocdt name="input.c.rtkmdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkmdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmdocno
            #add-point:ON ACTION controlp INFIELD rtkmdocno name="input.c.rtkmdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm001
            #add-point:ON ACTION controlp INFIELD rtkm001 name="input.c.rtkm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm004
            #add-point:ON ACTION controlp INFIELD rtkm004 name="input.c.rtkm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm002
            #add-point:ON ACTION controlp INFIELD rtkm002 name="input.c.rtkm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkm003
            #add-point:ON ACTION controlp INFIELD rtkm003 name="input.c.rtkm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmunit
            #add-point:ON ACTION controlp INFIELD rtkmunit name="input.c.rtkmunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtkmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkmstus
            #add-point:ON ACTION controlp INFIELD rtkmstus name="input.c.rtkmstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtkm_m.rtkmdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO rtkm_t (rtkment,rtkmsite,rtkmdocdt,rtkmdocno,rtkm001,rtkm004,rtkm002,rtkm003, 
                   rtkmunit,rtkmstus,rtkmownid,rtkmowndp,rtkmcrtid,rtkmcrtdp,rtkmcrtdt,rtkmmodid,rtkmmoddt, 
                   rtkmcnfid,rtkmcnfdt)
               VALUES (g_enterprise,g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001, 
                   g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus, 
                   g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp,g_rtkm_m.rtkmcrtdt, 
                   g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtkm_m:",SQLERRMESSAGE 
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
                  CALL artt770_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt770_b_fill()
                  CALL artt770_b_fill2('0')
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
               CALL artt770_rtkm_t_mask_restore('restore_mask_o')
               
               UPDATE rtkm_t SET (rtkmsite,rtkmdocdt,rtkmdocno,rtkm001,rtkm004,rtkm002,rtkm003,rtkmunit, 
                   rtkmstus,rtkmownid,rtkmowndp,rtkmcrtid,rtkmcrtdp,rtkmcrtdt,rtkmmodid,rtkmmoddt,rtkmcnfid, 
                   rtkmcnfdt) = (g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001, 
                   g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus, 
                   g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp,g_rtkm_m.rtkmcrtdt, 
                   g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt)
                WHERE rtkment = g_enterprise AND rtkmdocno = g_rtkmdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtkm_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artt770_rtkm_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtkm_m_t)
               LET g_log2 = util.JSON.stringify(g_rtkm_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt770.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtkn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtkn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt770_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtkn_d.getLength()
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
            OPEN artt770_cl USING g_enterprise,g_rtkm_m.rtkmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt770_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt770_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtkn_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtkn_d[l_ac].rtknseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtkn_d_t.* = g_rtkn_d[l_ac].*  #BACKUP
               LET g_rtkn_d_o.* = g_rtkn_d[l_ac].*  #BACKUP
               CALL artt770_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL artt770_set_no_entry_b(l_cmd)
               IF NOT artt770_lock_b("rtkn_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt770_bcl INTO g_rtkn_d[l_ac].rtknseq,g_rtkn_d[l_ac].rtkn002,g_rtkn_d[l_ac].rtkn001, 
                      g_rtkn_d[l_ac].rtkn004,g_rtkn_d[l_ac].rtkn006,g_rtkn_d[l_ac].rtkn007,g_rtkn_d[l_ac].rtkn501a, 
                      g_rtkn_d[l_ac].rtkn501b,g_rtkn_d[l_ac].rtkn501c,g_rtkn_d[l_ac].rtkn501d,g_rtkn_d[l_ac].rtkn501, 
                      g_rtkn_d[l_ac].rtkn008,g_rtkn_d[l_ac].rtkn009,g_rtkn_d[l_ac].rtkn010
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtkn_d_t.rtknseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtkn_d_mask_o[l_ac].* =  g_rtkn_d[l_ac].*
                  CALL artt770_rtkn_t_mask()
                  LET g_rtkn_d_mask_n[l_ac].* =  g_rtkn_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt770_show()
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
            INITIALIZE g_rtkn_d[l_ac].* TO NULL 
            INITIALIZE g_rtkn_d_t.* TO NULL 
            INITIALIZE g_rtkn_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtkn_d[l_ac].rtkn501a = "0"
      LET g_rtkn_d[l_ac].rtkn501b = "0"
      LET g_rtkn_d[l_ac].rtkn501c = "0"
      LET g_rtkn_d[l_ac].rtkn501d = "0"
      LET g_rtkn_d[l_ac].rtkn501 = "0"
      LET g_rtkn_d[l_ac].rtkn008 = "0"
      LET g_rtkn_d[l_ac].rtkn009 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_rtkn_d_t.* = g_rtkn_d[l_ac].*     #新輸入資料
            LET g_rtkn_d_o.* = g_rtkn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt770_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artt770_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtkn_d[li_reproduce_target].* = g_rtkn_d[li_reproduce].*
 
               LET g_rtkn_d[li_reproduce_target].rtknseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM rtkn_t 
             WHERE rtknent = g_enterprise AND rtkndocno = g_rtkm_m.rtkmdocno
 
               AND rtknseq = g_rtkn_d[l_ac].rtknseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtkm_m.rtkmdocno
               LET gs_keys[2] = g_rtkn_d[g_detail_idx].rtknseq
               CALL artt770_insert_b('rtkn_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtkn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtkn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt770_b_fill()
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
               LET gs_keys[01] = g_rtkm_m.rtkmdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtkn_d_t.rtknseq
 
            
               #刪除同層單身
               IF NOT artt770_delete_b('rtkn_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt770_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt770_key_delete_b(gs_keys,'rtkn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt770_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt770_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rtkn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtkn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtknseq
            #add-point:BEFORE FIELD rtknseq name="input.b.page1.rtknseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtknseq
            
            #add-point:AFTER FIELD rtknseq name="input.a.page1.rtknseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rtkm_m.rtkmdocno IS NOT NULL AND g_rtkn_d[g_detail_idx].rtknseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtkm_m.rtkmdocno != g_rtkmdocno_t OR g_rtkn_d[g_detail_idx].rtknseq != g_rtkn_d_t.rtknseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtkn_t WHERE "||"rtknent = '" ||g_enterprise|| "' AND "||"rtkndocno = '"||g_rtkm_m.rtkmdocno ||"' AND "|| "rtknseq = '"||g_rtkn_d[g_detail_idx].rtknseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtknseq
            #add-point:ON CHANGE rtknseq name="input.g.page1.rtknseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn002
            #add-point:BEFORE FIELD rtkn002 name="input.b.page1.rtkn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn002
            
            #add-point:AFTER FIELD rtkn002 name="input.a.page1.rtkn002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn002
            #add-point:ON CHANGE rtkn002 name="input.g.page1.rtkn002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn001
            
            #add-point:AFTER FIELD rtkn001 name="input.a.page1.rtkn001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkn_d[l_ac].rtkn001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtkn_d[l_ac].rtkn001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkn_d[l_ac].rtkn001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn001
            #add-point:BEFORE FIELD rtkn001 name="input.b.page1.rtkn001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn001
            #add-point:ON CHANGE rtkn001 name="input.g.page1.rtkn001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn004
            
            #add-point:AFTER FIELD rtkn004 name="input.a.page1.rtkn004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkn_d[l_ac].rtkn004
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtkn_d[l_ac].rtkn004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkn_d[l_ac].rtkn004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn004
            #add-point:BEFORE FIELD rtkn004 name="input.b.page1.rtkn004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn004
            #add-point:ON CHANGE rtkn004 name="input.g.page1.rtkn004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn006
            
            #add-point:AFTER FIELD rtkn006 name="input.a.page1.rtkn006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkn_d[l_ac].rtkn006
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtkn_d[l_ac].rtkn006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkn_d[l_ac].rtkn006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn006
            #add-point:BEFORE FIELD rtkn006 name="input.b.page1.rtkn006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn006
            #add-point:ON CHANGE rtkn006 name="input.g.page1.rtkn006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn007
            
            #add-point:AFTER FIELD rtkn007 name="input.a.page1.rtkn007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtkn_d[l_ac].rtkn007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtkn_d[l_ac].rtkn007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtkn_d[l_ac].rtkn007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn007
            #add-point:BEFORE FIELD rtkn007 name="input.b.page1.rtkn007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn007
            #add-point:ON CHANGE rtkn007 name="input.g.page1.rtkn007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501a
            #add-point:BEFORE FIELD rtkn501a name="input.b.page1.rtkn501a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501a
            
            #add-point:AFTER FIELD rtkn501a name="input.a.page1.rtkn501a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn501a
            #add-point:ON CHANGE rtkn501a name="input.g.page1.rtkn501a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501b
            #add-point:BEFORE FIELD rtkn501b name="input.b.page1.rtkn501b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501b
            
            #add-point:AFTER FIELD rtkn501b name="input.a.page1.rtkn501b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn501b
            #add-point:ON CHANGE rtkn501b name="input.g.page1.rtkn501b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501c
            #add-point:BEFORE FIELD rtkn501c name="input.b.page1.rtkn501c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501c
            
            #add-point:AFTER FIELD rtkn501c name="input.a.page1.rtkn501c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn501c
            #add-point:ON CHANGE rtkn501c name="input.g.page1.rtkn501c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501d
            #add-point:BEFORE FIELD rtkn501d name="input.b.page1.rtkn501d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501d
            
            #add-point:AFTER FIELD rtkn501d name="input.a.page1.rtkn501d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn501d
            #add-point:ON CHANGE rtkn501d name="input.g.page1.rtkn501d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn501
            #add-point:BEFORE FIELD rtkn501 name="input.b.page1.rtkn501"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn501
            
            #add-point:AFTER FIELD rtkn501 name="input.a.page1.rtkn501"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn501
            #add-point:ON CHANGE rtkn501 name="input.g.page1.rtkn501"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtkn_d[l_ac].rtkn008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD rtkn008
            END IF 
 
 
 
            #add-point:AFTER FIELD rtkn008 name="input.a.page1.rtkn008"
            IF NOT cl_null(g_rtkn_d[l_ac].rtkn008) THEN
               #IF l_cmd = 'u' AND ((g_rtkn_d[l_ac].rtkn008 != g_rtkn_d_t.rtkn008) OR cl_null(g_rtkn_d_t.rtkn008)) THEN         #160824-00007#173 Mark By Ken 161107    
               IF (g_rtkn_d[l_ac].rtkn008 != g_rtkn_d_o.rtkn008) OR cl_null(g_rtkn_d_o.rtkn008) THEN        #160824-00007#173 Add By Ken 161107       
                  SELECT rtdx034 INTO l_rtdx034
                    FROM rtdx_t
                   WHERE rtdxent = g_enterprise
                     AND rtdxsite = g_rtkm_m.rtkmsite
                     AND rtdx001 = g_rtkn_d[l_ac].rtkn001
                  IF cl_null(l_rtdx034) THEN
                     LET l_rtdx034 = 0
                  END IF
                  LET g_rtkn_d[l_ac].rtkn009 = g_rtkn_d[l_ac].rtkn008*l_rtdx034
                  
                  IF NOT artt770_rtkn008_chk() THEN
                     #LET g_rtkn_d[l_ac].rtkn008 = g_rtkn_d_t.rtkn008  #160824-00007#173 Mark By Ken 161107
                     LET g_rtkn_d[l_ac].rtkn008 = g_rtkn_d_o.rtkn008   #160824-00007#173 Add By Ken 161107
                     DISPLAY BY NAME g_rtkn_d[l_ac].rtkn008
                     NEXT FIELD rtkn008
                  END IF
                  DISPLAY BY NAME g_rtkn_d[l_ac].rtkn009
               END IF
            END IF
            LET g_rtkn_d_o.* = g_rtkn_d[l_ac].*   #160824-00007#173 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn008
            #add-point:BEFORE FIELD rtkn008 name="input.b.page1.rtkn008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn008
            #add-point:ON CHANGE rtkn008 name="input.g.page1.rtkn008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn009
            #add-point:BEFORE FIELD rtkn009 name="input.b.page1.rtkn009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn009
            
            #add-point:AFTER FIELD rtkn009 name="input.a.page1.rtkn009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn009
            #add-point:ON CHANGE rtkn009 name="input.g.page1.rtkn009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtkn010
            #add-point:BEFORE FIELD rtkn010 name="input.b.page1.rtkn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtkn010
            
            #add-point:AFTER FIELD rtkn010 name="input.a.page1.rtkn010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtkn010
            #add-point:ON CHANGE rtkn010 name="input.g.page1.rtkn010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtknseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtknseq
            #add-point:ON ACTION controlp INFIELD rtknseq name="input.c.page1.rtknseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn002
            #add-point:ON ACTION controlp INFIELD rtkn002 name="input.c.page1.rtkn002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn001
            #add-point:ON ACTION controlp INFIELD rtkn001 name="input.c.page1.rtkn001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn004
            #add-point:ON ACTION controlp INFIELD rtkn004 name="input.c.page1.rtkn004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn006
            #add-point:ON ACTION controlp INFIELD rtkn006 name="input.c.page1.rtkn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn007
            #add-point:ON ACTION controlp INFIELD rtkn007 name="input.c.page1.rtkn007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn501a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501a
            #add-point:ON ACTION controlp INFIELD rtkn501a name="input.c.page1.rtkn501a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn501b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501b
            #add-point:ON ACTION controlp INFIELD rtkn501b name="input.c.page1.rtkn501b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn501c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501c
            #add-point:ON ACTION controlp INFIELD rtkn501c name="input.c.page1.rtkn501c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn501d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501d
            #add-point:ON ACTION controlp INFIELD rtkn501d name="input.c.page1.rtkn501d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn501
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn501
            #add-point:ON ACTION controlp INFIELD rtkn501 name="input.c.page1.rtkn501"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn008
            #add-point:ON ACTION controlp INFIELD rtkn008 name="input.c.page1.rtkn008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn009
            #add-point:ON ACTION controlp INFIELD rtkn009 name="input.c.page1.rtkn009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtkn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtkn010
            #add-point:ON ACTION controlp INFIELD rtkn010 name="input.c.page1.rtkn010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtkn_d[l_ac].* = g_rtkn_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt770_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtkn_d[l_ac].rtknseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtkn_d[l_ac].* = g_rtkn_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt770_rtkn_t_mask_restore('restore_mask_o')
      
               UPDATE rtkn_t SET (rtkndocno,rtknseq,rtkn002,rtkn001,rtkn004,rtkn006,rtkn007,rtkn501a, 
                   rtkn501b,rtkn501c,rtkn501d,rtkn501,rtkn008,rtkn009,rtkn010) = (g_rtkm_m.rtkmdocno, 
                   g_rtkn_d[l_ac].rtknseq,g_rtkn_d[l_ac].rtkn002,g_rtkn_d[l_ac].rtkn001,g_rtkn_d[l_ac].rtkn004, 
                   g_rtkn_d[l_ac].rtkn006,g_rtkn_d[l_ac].rtkn007,g_rtkn_d[l_ac].rtkn501a,g_rtkn_d[l_ac].rtkn501b, 
                   g_rtkn_d[l_ac].rtkn501c,g_rtkn_d[l_ac].rtkn501d,g_rtkn_d[l_ac].rtkn501,g_rtkn_d[l_ac].rtkn008, 
                   g_rtkn_d[l_ac].rtkn009,g_rtkn_d[l_ac].rtkn010)
                WHERE rtknent = g_enterprise AND rtkndocno = g_rtkm_m.rtkmdocno 
 
                  AND rtknseq = g_rtkn_d_t.rtknseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtkn_d[l_ac].* = g_rtkn_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtkn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtkn_d[l_ac].* = g_rtkn_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtkn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtkm_m.rtkmdocno
               LET gs_keys_bak[1] = g_rtkmdocno_t
               LET gs_keys[2] = g_rtkn_d[g_detail_idx].rtknseq
               LET gs_keys_bak[2] = g_rtkn_d_t.rtknseq
               CALL artt770_update_b('rtkn_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt770_rtkn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtkn_d[g_detail_idx].rtknseq = g_rtkn_d_t.rtknseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtkm_m.rtkmdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtkn_d_t.rtknseq
 
                  CALL artt770_key_update_b(gs_keys,'rtkn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtkm_m),util.JSON.stringify(g_rtkn_d_t)
               LET g_log2 = util.JSON.stringify(g_rtkm_m),util.JSON.stringify(g_rtkn_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL artt770_unlock_b("rtkn_t","'1'")
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
               LET g_rtkn_d[li_reproduce_target].* = g_rtkn_d[li_reproduce].*
 
               LET g_rtkn_d[li_reproduce_target].rtknseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtkn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtkn_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="artt770.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD rtkmdocno
         ELSE
            #NEXT FIELD rtkn008
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD rtkmdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtknseq
 
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
 
{<section id="artt770.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt770_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt770_b_fill() #單身填充
      CALL artt770_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt770_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_rtkm_m_mask_o.* =  g_rtkm_m.*
   CALL artt770_rtkm_t_mask()
   LET g_rtkm_m_mask_n.* =  g_rtkm_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001, 
       g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003,g_rtkm_m.rtkm003_desc, 
       g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp, 
       g_rtkm_m.rtkmowndp_desc,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp,g_rtkm_m.rtkmcrtdp_desc, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid, 
       g_rtkm_m.rtkmcnfid_desc,g_rtkm_m.rtkmcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtkm_m.rtkmstus 
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
   FOR l_ac = 1 TO g_rtkn_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt770_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt770_detail_show()
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
 
{<section id="artt770.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt770_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtkm_t.rtkmdocno 
   DEFINE l_oldno     LIKE rtkm_t.rtkmdocno 
 
   DEFINE l_master    RECORD LIKE rtkm_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtkn_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_rtkm_m.rtkmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
    
   LET g_rtkm_m.rtkmdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtkm_m.rtkmownid = g_user
      LET g_rtkm_m.rtkmowndp = g_dept
      LET g_rtkm_m.rtkmcrtid = g_user
      LET g_rtkm_m.rtkmcrtdp = g_dept 
      LET g_rtkm_m.rtkmcrtdt = cl_get_current()
      LET g_rtkm_m.rtkmmodid = g_user
      LET g_rtkm_m.rtkmmoddt = cl_get_current()
      LET g_rtkm_m.rtkmstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtkm_m.rtkmstus 
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
   
   
   CALL artt770_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtkm_m.* TO NULL
      INITIALIZE g_rtkn_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt770_show()
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
   CALL artt770_set_act_visible()   
   CALL artt770_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtkment = " ||g_enterprise|| " AND",
                      " rtkmdocno = '", g_rtkm_m.rtkmdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt770_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt770_idx_chk()
   
   LET g_data_owner = g_rtkm_m.rtkmownid      
   LET g_data_dept  = g_rtkm_m.rtkmowndp
   
   #功能已完成,通報訊息中心
   CALL artt770_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt770_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtkn_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt770_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtkn_t
    WHERE rtknent = g_enterprise AND rtkndocno = g_rtkmdocno_t
 
    INTO TEMP artt770_detail
 
   #將key修正為調整後   
   UPDATE artt770_detail 
      #更新key欄位
      SET rtkndocno = g_rtkm_m.rtkmdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtkn_t SELECT * FROM artt770_detail
   
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
   DROP TABLE artt770_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt770_delete()
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
   
   IF g_rtkm_m.rtkmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artt770_cl USING g_enterprise,g_rtkm_m.rtkmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt770_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt770_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
       g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
       g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
       g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp_desc, 
       g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT artt770_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtkm_m_mask_o.* =  g_rtkm_m.*
   CALL artt770_rtkm_t_mask()
   LET g_rtkm_m_mask_n.* =  g_rtkm_m.*
   
   CALL artt770_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt770_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtkmdocno_t = g_rtkm_m.rtkmdocno
 
 
      DELETE FROM rtkm_t
       WHERE rtkment = g_enterprise AND rtkmdocno = g_rtkm_m.rtkmdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtkm_m.rtkmdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM rtkn_t
       WHERE rtknent = g_enterprise AND rtkndocno = g_rtkm_m.rtkmdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtkn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtkm_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt770_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtkn_d.clear() 
 
     
      CALL artt770_ui_browser_refresh()  
      #CALL artt770_ui_headershow()  
      #CALL artt770_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt770_browser_fill("")
         CALL artt770_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt770_cl
 
   #功能已完成,通報訊息中心
   CALL artt770_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt770.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt770_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtkn_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artt770_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtknseq,rtkn002,rtkn001,rtkn004,rtkn006,rtkn007,rtkn501a,rtkn501b, 
             rtkn501c,rtkn501d,rtkn501,rtkn008,rtkn009,rtkn010 ,t1.imaal003 ,t2.imaal004 ,t3.rtaxl003 , 
             t4.pmaal004 ,t5.oocal003 FROM rtkn_t",   
                     " INNER JOIN rtkm_t ON rtkment = " ||g_enterprise|| " AND rtkmdocno = rtkndocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=rtkn001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=rtkn001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=rtkn004 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=rtkn006 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=rtkn007 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE rtknent=? AND rtkndocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtkn_t.rtknseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt770_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt770_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtkm_m.rtkmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtkm_m.rtkmdocno INTO g_rtkn_d[l_ac].rtknseq,g_rtkn_d[l_ac].rtkn002, 
          g_rtkn_d[l_ac].rtkn001,g_rtkn_d[l_ac].rtkn004,g_rtkn_d[l_ac].rtkn006,g_rtkn_d[l_ac].rtkn007, 
          g_rtkn_d[l_ac].rtkn501a,g_rtkn_d[l_ac].rtkn501b,g_rtkn_d[l_ac].rtkn501c,g_rtkn_d[l_ac].rtkn501d, 
          g_rtkn_d[l_ac].rtkn501,g_rtkn_d[l_ac].rtkn008,g_rtkn_d[l_ac].rtkn009,g_rtkn_d[l_ac].rtkn010, 
          g_rtkn_d[l_ac].rtkn001_desc,g_rtkn_d[l_ac].rtkn001_desc_desc,g_rtkn_d[l_ac].rtkn004_desc,g_rtkn_d[l_ac].rtkn006_desc, 
          g_rtkn_d[l_ac].rtkn007_desc   #(ver:78)
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
   
   CALL g_rtkn_d.deleteElement(g_rtkn_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt770_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtkn_d.getLength()
      LET g_rtkn_d_mask_o[l_ac].* =  g_rtkn_d[l_ac].*
      CALL artt770_rtkn_t_mask()
      LET g_rtkn_d_mask_n[l_ac].* =  g_rtkn_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt770_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rtkn_t
       WHERE rtknent = g_enterprise AND
         rtkndocno = ps_keys_bak[1] AND rtknseq = ps_keys_bak[2]
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
         CALL g_rtkn_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt770_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rtkn_t
                  (rtknent,
                   rtkndocno,
                   rtknseq
                   ,rtkn002,rtkn001,rtkn004,rtkn006,rtkn007,rtkn501a,rtkn501b,rtkn501c,rtkn501d,rtkn501,rtkn008,rtkn009,rtkn010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtkn_d[g_detail_idx].rtkn002,g_rtkn_d[g_detail_idx].rtkn001,g_rtkn_d[g_detail_idx].rtkn004, 
                       g_rtkn_d[g_detail_idx].rtkn006,g_rtkn_d[g_detail_idx].rtkn007,g_rtkn_d[g_detail_idx].rtkn501a, 
                       g_rtkn_d[g_detail_idx].rtkn501b,g_rtkn_d[g_detail_idx].rtkn501c,g_rtkn_d[g_detail_idx].rtkn501d, 
                       g_rtkn_d[g_detail_idx].rtkn501,g_rtkn_d[g_detail_idx].rtkn008,g_rtkn_d[g_detail_idx].rtkn009, 
                       g_rtkn_d[g_detail_idx].rtkn010)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtkn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtkn_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt770_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtkn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt770_rtkn_t_mask_restore('restore_mask_o')
               
      UPDATE rtkn_t 
         SET (rtkndocno,
              rtknseq
              ,rtkn002,rtkn001,rtkn004,rtkn006,rtkn007,rtkn501a,rtkn501b,rtkn501c,rtkn501d,rtkn501,rtkn008,rtkn009,rtkn010) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtkn_d[g_detail_idx].rtkn002,g_rtkn_d[g_detail_idx].rtkn001,g_rtkn_d[g_detail_idx].rtkn004, 
                  g_rtkn_d[g_detail_idx].rtkn006,g_rtkn_d[g_detail_idx].rtkn007,g_rtkn_d[g_detail_idx].rtkn501a, 
                  g_rtkn_d[g_detail_idx].rtkn501b,g_rtkn_d[g_detail_idx].rtkn501c,g_rtkn_d[g_detail_idx].rtkn501d, 
                  g_rtkn_d[g_detail_idx].rtkn501,g_rtkn_d[g_detail_idx].rtkn008,g_rtkn_d[g_detail_idx].rtkn009, 
                  g_rtkn_d[g_detail_idx].rtkn010) 
         WHERE rtknent = g_enterprise AND rtkndocno = ps_keys_bak[1] AND rtknseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtkn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtkn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt770_rtkn_t_mask_restore('restore_mask_n')
               
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
 
{<section id="artt770.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt770_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="artt770.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt770_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="artt770.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt770_lock_b(ps_table,ps_page)
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
   #CALL artt770_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtkn_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt770_bcl USING g_enterprise,
                                       g_rtkm_m.rtkmdocno,g_rtkn_d[g_detail_idx].rtknseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt770_bcl:",SQLERRMESSAGE 
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
 
{<section id="artt770.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt770_unlock_b(ps_table,ps_page)
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
      CLOSE artt770_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt770_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtkmdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtkmdocno",TRUE)
      CALL cl_set_comp_entry("rtkmdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt770_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtkmdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtkmdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtkmdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt770.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt770_set_entry_b(p_cmd)
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
 
{<section id="artt770.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt770_set_no_entry_b(p_cmd)
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
 
{<section id="artt770.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt770_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt770.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt770_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtkm_m.rtkmstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt770.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt770_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt770.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt770_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt770.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt770_default_search()
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
      LET ls_wc = ls_wc, " rtkmdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rtkm_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtkn_t" 
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
 
{<section id="artt770.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt770_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtkm_m.rtkmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt770_cl USING g_enterprise,g_rtkm_m.rtkmdocno
   IF STATUS THEN
      CLOSE artt770_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt770_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
       g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
       g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
       g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp_desc, 
       g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT artt770_action_chk() THEN
      CLOSE artt770_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001, 
       g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003,g_rtkm_m.rtkm003_desc, 
       g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmownid_desc,g_rtkm_m.rtkmowndp, 
       g_rtkm_m.rtkmowndp_desc,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp,g_rtkm_m.rtkmcrtdp_desc, 
       g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid, 
       g_rtkm_m.rtkmcnfid_desc,g_rtkm_m.rtkmcnfdt
 
   CASE g_rtkm_m.rtkmstus
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
         CASE g_rtkm_m.rtkmstus
            
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
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_rtkm_m.rtkmstus
         WHEN "X"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            CALL s_transaction_end('N','0')   #160816-00068#10 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "invalid"
          WHEN "N"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
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
            IF NOT artt770_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt770_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt770_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt770_cl
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
      g_rtkm_m.rtkmstus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt770_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE
      WHEN lc_state = 'Y'
         CALL cl_err_collect_init()
         CALL s_artt770_conf_chk(g_rtkm_m.rtkmdocno,g_rtkm_m.rtkmstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_artt770_conf_upd(g_rtkm_m.rtkmdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtkm_m.rtkmdocno
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
         CALL s_artt770_void_chk(g_rtkm_m.rtkmdocno,g_rtkm_m.rtkmstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00109') THEN
               CALL s_transaction_begin()
               CALL s_artt770_void_upd(g_rtkm_m.rtkmdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtkm_m.rtkmdocno
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
      WHEN lc_state = 'N'
         CALL cl_err_collect_init()
         CALL s_artt770_unconf_chk(g_rtkm_m.rtkmdocno,g_rtkm_m.rtkmstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_artt770_unconf_upd(g_rtkm_m.rtkmdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtkm_m.rtkmdocno
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
   
   LET g_rtkm_m.rtkmmodid = g_user
   LET g_rtkm_m.rtkmmoddt = cl_get_current()
   LET g_rtkm_m.rtkmstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtkm_t 
      SET (rtkmstus,rtkmmodid,rtkmmoddt) 
        = (g_rtkm_m.rtkmstus,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt)     
    WHERE rtkment = g_enterprise AND rtkmdocno = g_rtkm_m.rtkmdocno
 
    
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
      EXECUTE artt770_master_referesh USING g_rtkm_m.rtkmdocno INTO g_rtkm_m.rtkmsite,g_rtkm_m.rtkmdocdt, 
          g_rtkm_m.rtkmdocno,g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm003,g_rtkm_m.rtkmunit, 
          g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtdp, 
          g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt, 
          g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmownid_desc, 
          g_rtkm_m.rtkmowndp_desc,g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmmodid_desc, 
          g_rtkm_m.rtkmcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtkm_m.rtkmsite,g_rtkm_m.rtkmsite_desc,g_rtkm_m.rtkmdocdt,g_rtkm_m.rtkmdocno, 
          g_rtkm_m.rtkm001,g_rtkm_m.rtkm004,g_rtkm_m.rtkm002,g_rtkm_m.rtkm002_desc,g_rtkm_m.rtkm003, 
          g_rtkm_m.rtkm003_desc,g_rtkm_m.rtkmunit,g_rtkm_m.rtkmstus,g_rtkm_m.rtkmownid,g_rtkm_m.rtkmownid_desc, 
          g_rtkm_m.rtkmowndp,g_rtkm_m.rtkmowndp_desc,g_rtkm_m.rtkmcrtid,g_rtkm_m.rtkmcrtid_desc,g_rtkm_m.rtkmcrtdp, 
          g_rtkm_m.rtkmcrtdp_desc,g_rtkm_m.rtkmcrtdt,g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmodid_desc,g_rtkm_m.rtkmmoddt, 
          g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfid_desc,g_rtkm_m.rtkmcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   SELECT rtkmmodid,rtkmmoddt,rtkmcnfid,rtkmcnfdt
     INTO g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,
          g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt
     FROM rtkm_t
    WHERE rtkment = g_enterprise AND rtkmdocno = g_rtkm_m.rtkmdocno
   DISPLAY BY NAME g_rtkm_m.rtkmmodid,g_rtkm_m.rtkmmoddt,
                   g_rtkm_m.rtkmcnfid,g_rtkm_m.rtkmcnfdt
   #end add-point  
 
   CLOSE artt770_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt770_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt770.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt770_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtkn_d.getLength() THEN
         LET g_detail_idx = g_rtkn_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtkn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtkn_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt770_b_fill2(pi_idx)
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
   
   CALL artt770_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt770_fill_chk(ps_idx)
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
 
{<section id="artt770.status_show" >}
PRIVATE FUNCTION artt770_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt770.mask_functions" >}
&include "erp/art/artt770_mask.4gl"
 
{</section>}
 
{<section id="artt770.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt770_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL artt770_show()
   CALL artt770_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtkm_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtkn_d))
 
 
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
   #CALL artt770_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt770_ui_headershow()
   CALL artt770_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt770_draw_out()
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
   CALL artt770_ui_headershow()  
   CALL artt770_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt770.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt770_set_pk_array()
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
   LET g_pk_array[1].values = g_rtkm_m.rtkmdocno
   LET g_pk_array[1].column = 'rtkmdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt770.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt770.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt770_msgcentre_notify(lc_state)
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
   CALL artt770_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtkm_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt770.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt770_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt770.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位檢查
# Memo...........:
# Usage..........: CALL artt770_rtkn008_chk()
# Date & Author..: 20141231 By dongsz
# Modify.........:
################################################################################
PUBLIC FUNCTION artt770_rtkn008_chk()
DEFINE l_rtkn005        LIKE rtkn_t.rtkn005
DEFINE l_rtka008        LIKE rtka_t.rtka008
DEFINE l_rtka009        LIKE rtka_t.rtka009
DEFINE l_imaz002        LIKE imaz_t.imaz002
DEFINE l_imaz005        LIKE imaz_t.imaz005
DEFINE l_rtkh001        LIKE rtkh_t.rtkh001
DEFINE l_rtkh012        LIKE rtkh_t.rtkh012
DEFINE l_rtkh013        LIKE rtkh_t.rtkh013
DEFINE l_rtkn008_sum    LIKE rtkn_t.rtkn008
DEFINE l_rtkn009_sum    LIKE rtkn_t.rtkn009
DEFINE l_mod            LIKE type_t.num5
   
   #出單日最小數量、最小金額的驗證
   SELECT rtkn005 INTO l_rtkn005
     FROM rtkn_t
    WHERE rtknent = g_enterprise
      AND rtkndocno = g_rtkm_m.rtkmdocno
      AND rtknseq = g_rtkn_d[l_ac].rtknseq
   IF l_rtkn005 MATCHES "[013]" THEN
      SELECT rtka008,rtka009 INTO l_rtka008,l_rtka009
        FROM rtka_t
       WHERE rtkaent = g_enterprise
         AND rtka001 = g_rtkn_d[l_ac].rtkn006
         AND rtka002 = '2'
         AND rtka003 = g_rtkm_m.rtkmsite
      IF SQLCA.sqlcode = 100 THEN
         SELECT rtka008,rtka009 INTO l_rtka008,l_rtka009
           FROM rtka_t,rtab_t
          WHERE rtkaent = g_enterprise
            AND rtkaent = rtabent
            AND rtka003 = rtab001
            AND rtka001 = g_rtkn_d[l_ac].rtkn006
            AND rtka002 = '1'
            AND rtab002 = g_rtkm_m.rtkmsite
      END IF
      #抓取对应供应商的总数量和金额
      SELECT SUM(rtkn008),SUM(rtkn009)
        INTO l_rtkn008_sum,l_rtkn009_sum
        FROM rtkn_t
       WHERE rtknent = g_enterprise
         AND rtkndocno = g_rtkm_m.rtkmdocno
         AND rtkn006 = g_rtkn_d[l_ac].rtkn006
         AND rtknseq <> g_rtkn_d[l_ac].rtknseq
      IF cl_null(l_rtkn008_sum) THEN
         LET l_rtkn008_sum = 0
      END IF
      IF cl_null(l_rtkn009_sum) THEN
         LET l_rtkn009_sum = 0
      END IF
      IF g_rtkn_d[l_ac].rtkn008+l_rtkn008_sum < l_rtka008 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00416'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_rtkn_d[l_ac].rtkn006
         LET g_errparam.replace[2] = l_rtka008
         CALL cl_err()
         RETURN FALSE
      END IF
      IF g_rtkn_d[l_ac].rtkn009+l_rtkn009_sum < l_rtka009 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00417'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_rtkn_d[l_ac].rtkn006
         LET g_errparam.replace[2] = l_rtka009
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
    
   #判斷補貨規格
   #抓取aoos020設定的補貨規格級別
   LET l_imaz002 = cl_get_para(g_enterprise,g_rtkm_m.rtkmsite,'S-CIR-1001')
   IF cl_null(l_imaz002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_rtkm_m.rtkmsite
      LET g_errparam.code   = 'art-00415'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   SELECT imaz005 INTO l_imaz005
     FROM imaz_t
    WHERE imazent = g_enterprise
      AND imaz001 = g_rtkn_d[l_ac].rtkn001
      AND imaz002 = l_imaz002
   IF l_imaz005 > 1 THEN
      LET l_mod = g_rtkn_d[l_ac].rtkn008 MOD l_imaz005
      IF l_mod <> 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'art-00418'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
    
   #取補貨模型的限制
   #抓取aoos020設定的補貨模型
   LET l_rtkh001 = cl_get_para(g_enterprise,g_rtkm_m.rtkmsite,'S-CIR-1000')
   IF cl_null(l_rtkh001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_rtkm_m.rtkmsite
      LET g_errparam.code   = 'art-00409'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   SELECT SUM(rtkn008),SUM(rtkn009) INTO l_rtkn008_sum,l_rtkn009_sum
     FROM rtkn_t
    WHERE rtknent = g_enterprise
      AND rtkndocno = g_rtkm_m.rtkmdocno
      AND rtknseq <> g_rtkn_d[l_ac].rtknseq
   IF cl_null(l_rtkn008_sum) THEN
      LET l_rtkn008_sum = 0
   END IF
   IF cl_null(l_rtkn009_sum) THEN
      LET l_rtkn009_sum = 0
   END IF
   SELECT rtkh012,rtkh013 INTO l_rtkh012,l_rtkh013
     FROM rtkh_t
    WHERE rtkhent = g_enterprise
      AND rtkh001 = l_rtkh001
   IF NOT cl_null(l_rtkh012) THEN
      IF g_rtkn_d[l_ac].rtkn008+l_rtkn008_sum > l_rtkh012 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00419'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_rtkn_d[l_ac].rtkn008+l_rtkn008_sum
         LET g_errparam.replace[2] = l_rtkh012
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   IF NOT cl_null(l_rtkh013) THEN
      IF g_rtkn_d[l_ac].rtkn009+l_rtkn009_sum > l_rtkh013 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00420'
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = g_rtkn_d[l_ac].rtkn009+l_rtkn009_sum
         LET g_errparam.replace[2] = l_rtkh013
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

 
{</section>}
 
