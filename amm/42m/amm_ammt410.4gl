#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2015-05-28 06:34:20), PR版次:0018(2016-11-23 18:49:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000437
#+ Filename...: ammt410
#+ Description: 會員卡狀態異動維護作業
#+ Creator....: 01996(2013-09-16 09:58:16)
#+ Modifier...: 01533 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt410.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#24  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#44  2016/04/19 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160705-00042#11  2016/07/15 By sakura  查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#160816-00068#4   2016/08/16 By earl    調整transaction
#160818-00017#23  2016/08/24 By 08742   删除修改未重新判断状态码
#160905-00007#6   2016/09/05 By 02599   SQL条件增加ent
#161111-00028#1   2016/11/11 BY 02481   标准程式定义采用宣告模式,弃用.*写法
#160824-00007#124 2016/11/23 By sakura  新舊值備份處理
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
PRIVATE type type_g_mmbd_m        RECORD
       mmbd000 LIKE mmbd_t.mmbd000, 
   mmbdsite LIKE mmbd_t.mmbdsite, 
   mmbdsite_desc LIKE type_t.chr80, 
   mmbdunit LIKE mmbd_t.mmbdunit, 
   mmbddocdt LIKE mmbd_t.mmbddocdt, 
   mmbddocno LIKE mmbd_t.mmbddocno, 
   mmbd002 LIKE mmbd_t.mmbd002, 
   mmbd002_desc LIKE type_t.chr80, 
   mmbd001 LIKE mmbd_t.mmbd001, 
   mmbd001_desc LIKE type_t.chr80, 
   mmbdstus LIKE mmbd_t.mmbdstus, 
   mmbdownid LIKE mmbd_t.mmbdownid, 
   mmbdownid_desc LIKE type_t.chr80, 
   mmbdowndp LIKE mmbd_t.mmbdowndp, 
   mmbdowndp_desc LIKE type_t.chr80, 
   mmbdcrtid LIKE mmbd_t.mmbdcrtid, 
   mmbdcrtid_desc LIKE type_t.chr80, 
   mmbdcrtdp LIKE mmbd_t.mmbdcrtdp, 
   mmbdcrtdp_desc LIKE type_t.chr80, 
   mmbdcrtdt LIKE mmbd_t.mmbdcrtdt, 
   mmbdmodid LIKE mmbd_t.mmbdmodid, 
   mmbdmodid_desc LIKE type_t.chr80, 
   mmbdmoddt LIKE mmbd_t.mmbdmoddt, 
   mmbdcnfid LIKE mmbd_t.mmbdcnfid, 
   mmbdcnfid_desc LIKE type_t.chr80, 
   mmbdcnfdt LIKE mmbd_t.mmbdcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmbe_d        RECORD
       mmbeseq LIKE mmbe_t.mmbeseq, 
   mmbesite LIKE mmbe_t.mmbesite, 
   mmbesite_desc LIKE type_t.chr500, 
   mmbe001 LIKE mmbe_t.mmbe001, 
   mmbe002 LIKE mmbe_t.mmbe002, 
   mmbe002_desc LIKE type_t.chr500, 
   mmbe003 LIKE mmbe_t.mmbe003, 
   mmbe003_desc LIKE type_t.chr500, 
   mmbe006 LIKE mmbe_t.mmbe006, 
   mmbe005 LIKE mmbe_t.mmbe005, 
   mmbeunit LIKE mmbe_t.mmbeunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmbd000 LIKE mmbd_t.mmbd000,
      b_mmbdunit LIKE mmbd_t.mmbdunit,
      b_mmbddocno LIKE mmbd_t.mmbddocno,
      b_mmbddocdt LIKE mmbd_t.mmbddocdt,
      b_mmbdsite LIKE mmbd_t.mmbdsite,
   b_mmbdsite_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_copy_flag   LIKE type_t.chr1
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmbd_m          type_g_mmbd_m
DEFINE g_mmbd_m_t        type_g_mmbd_m
DEFINE g_mmbd_m_o        type_g_mmbd_m
DEFINE g_mmbd_m_mask_o   type_g_mmbd_m #轉換遮罩前資料
DEFINE g_mmbd_m_mask_n   type_g_mmbd_m #轉換遮罩後資料
 
   DEFINE g_mmbddocno_t LIKE mmbd_t.mmbddocno
 
 
DEFINE g_mmbe_d          DYNAMIC ARRAY OF type_g_mmbe_d
DEFINE g_mmbe_d_t        type_g_mmbe_d
DEFINE g_mmbe_d_o        type_g_mmbe_d
DEFINE g_mmbe_d_mask_o   DYNAMIC ARRAY OF type_g_mmbe_d #轉換遮罩前資料
DEFINE g_mmbe_d_mask_n   DYNAMIC ARRAY OF type_g_mmbe_d #轉換遮罩後資料
 
 
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
 
{<section id="ammt410.main" >}
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
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_copy_flag = 'a'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mmbd000,mmbdsite,'',mmbdunit,mmbddocdt,mmbddocno,mmbd002,'',mmbd001,'', 
       mmbdstus,mmbdownid,'',mmbdowndp,'',mmbdcrtid,'',mmbdcrtdp,'',mmbdcrtdt,mmbdmodid,'',mmbdmoddt, 
       mmbdcnfid,'',mmbdcnfdt", 
                      " FROM mmbd_t",
                      " WHERE mmbdent= ? AND mmbddocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmbd000,t0.mmbdsite,t0.mmbdunit,t0.mmbddocdt,t0.mmbddocno,t0.mmbd002, 
       t0.mmbd001,t0.mmbdstus,t0.mmbdownid,t0.mmbdowndp,t0.mmbdcrtid,t0.mmbdcrtdp,t0.mmbdcrtdt,t0.mmbdmodid, 
       t0.mmbdmoddt,t0.mmbdcnfid,t0.mmbdcnfdt,t1.ooefl003 ,t2.oocql004 ,t3.oocql004 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM mmbd_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbdsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2055' AND t2.oocql002=t0.mmbd002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2056' AND t3.oocql002=t0.mmbd001 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mmbdownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mmbdowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mmbdcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mmbdcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmbdmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mmbdcnfid  ",
 
               " WHERE t0.mmbdent = " ||g_enterprise|| " AND t0.mmbddocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammt410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt410 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt410_init()   
 
      #進入選單 Menu (="N")
      CALL ammt410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt410
      
   END IF 
   
   CLOSE ammt410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt410_init()
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
      CALL cl_set_combo_scc_part('mmbdstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mmbd000','6511') 
   CALL cl_set_combo_scc('mmbe005','6515') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_mmbd000','6511') 
   CALL cl_set_comp_visible("mmbe003,mmbe003_desc,mmbe005,mmbe006",TRUE)
   IF g_argv[1] MATCHES '[3489]' THEN
      CALL cl_set_comp_visible("mmbe005",FALSE)
   END IF
   
   IF g_argv[1] = '4' THEN
      CALL cl_set_comp_visible("mmbe003,mmbe003_desc,mmbe006",FALSE)
   END IF
   
   IF g_argv[1] != '3' THEN
      CALL cl_set_act_visible("open_pc",FALSE)
   END IF
   
   #end add-point
   
   #初始化搜尋條件
   CALL ammt410_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt410.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt410_ui_dialog()
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
            CALL ammt410_insert()
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
         INITIALIZE g_mmbd_m.* TO NULL
         CALL g_mmbe_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammt410_init()
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
               
               CALL ammt410_fetch('') # reload data
               LET l_ac = 1
               CALL ammt410_ui_detailshow() #Setting the current row 
         
               CALL ammt410_idx_chk()
               #NEXT FIELD mmbeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmbe_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt410_idx_chk()
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
               CALL ammt410_idx_chk()
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
            CALL ammt410_browser_fill("")
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
               CALL ammt410_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt410_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt410_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            IF g_argv[1] = '3' THEN
               CALL DIALOG.setActionActive("open_pc", TRUE)
#mark by yangxf ---start---               
#               IF cl_null(g_mmbd_m.mmbddocno) THEN
#                  CALL DIALOG.setActionActive("open_pc", FALSE)
#               END IF
#mark by yangxf ---end---
            ELSE
               CALL DIALOG.setActionActive("open_pc", FALSE)
            END IF
            IF cl_null(g_argv[1]) THEN
               CALL DIALOG.setActionActive("insert",FALSE)
               CALL DIALOG.setActionActive("modify",FALSE)
               CALL DIALOG.setActionActive("modify_detail",FALSE)
               CALL DIALOG.setActionActive("delete",FALSE)
               CALL DIALOG.setActionActive("reproduce",FALSE)
            END IF
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammt410_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammt410_set_act_visible()   
            CALL ammt410_set_act_no_visible()
            IF NOT (g_mmbd_m.mmbddocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmbdent = " ||g_enterprise|| " AND",
                                  " mmbddocno = '", g_mmbd_m.mmbddocno, "' "
 
               #填到對應位置
               CALL ammt410_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mmbd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbe_t" 
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
               CALL ammt410_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mmbd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbe_t" 
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
                  CALL ammt410_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt410_fetch("F")
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
               CALL ammt410_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammt410_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt410_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammt410_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt410_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammt410_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt410_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammt410_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt410_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammt410_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt410_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmbe_d)
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
               NEXT FIELD mmbeseq
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
               CALL ammt410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ammt410_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pc
            LET g_action_choice="open_pc"
            IF cl_auth_chk_act("open_pc") THEN
               
               #add-point:ON ACTION open_pc name="menu.open_pc"
               #modify by yangxf ---start---
               IF NOT cl_null(g_mmbd_m.mmbddocno) AND g_mmbd_m.mmbdstus = 'N' THEN
                  CALL ammt410_01(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdsite)
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amm/ammt410_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amm/ammt410_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL ammt410_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt410_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmbd_m.mmbddocdt)
 
 
 
         
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
 
{<section id="ammt410.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt410_browser_fill(ps_page_action)
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mmbddocno ",
                      " FROM mmbd_t ",
                      " ",
                      " LEFT JOIN mmbe_t ON mmbeent = mmbdent AND mmbddocno = mmbedocno ", "  ",
                      #add-point:browser_fill段sql(mmbe_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mmbdent = " ||g_enterprise|| " AND mmbeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmbd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmbddocno ",
                      " FROM mmbd_t ", 
                      "  ",
                      "  ",
                      " WHERE mmbdent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmbd_t")
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
      INITIALIZE g_mmbd_m.* TO NULL
      CALL g_mmbe_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmbd000,t0.mmbdunit,t0.mmbddocno,t0.mmbddocdt,t0.mmbdsite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbdstus,t0.mmbd000,t0.mmbdunit,t0.mmbddocno,t0.mmbddocdt,t0.mmbdsite, 
          t1.ooefl003 ",
                  " FROM mmbd_t t0",
                  "  ",
                  "  LEFT JOIN mmbe_t ON mmbeent = mmbdent AND mmbddocno = mmbedocno ", "  ", 
                  #add-point:browser_fill段sql(mmbe_t1) name="browser_fill.join.mmbe_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbdsite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmbdent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmbd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbdstus,t0.mmbd000,t0.mmbdunit,t0.mmbddocno,t0.mmbddocdt,t0.mmbdsite, 
          t1.ooefl003 ",
                  " FROM mmbd_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbdsite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmbdent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmbd_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmbddocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmbd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbd000,g_browser[g_cnt].b_mmbdunit, 
          g_browser[g_cnt].b_mmbddocno,g_browser[g_cnt].b_mmbddocdt,g_browser[g_cnt].b_mmbdsite,g_browser[g_cnt].b_mmbdsite_desc 
 
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
         CALL ammt410_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_mmbddocno) THEN
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
 
{<section id="ammt410.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt410_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmbd_m.mmbddocno = g_browser[g_current_idx].b_mmbddocno   
 
   EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
       g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus, 
       g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt,g_mmbd_m.mmbdsite_desc, 
       g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc, 
       g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdcnfid_desc
   
   CALL ammt410_mmbd_t_mask()
   CALL ammt410_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammt410.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt410_ui_detailshow()
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
 
{<section id="ammt410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt410_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmbddocno = g_mmbd_m.mmbddocno 
 
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
 
{<section id="ammt410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt410_construct()
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
   INITIALIZE g_mmbd_m.* TO NULL
   CALL g_mmbe_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mmbd000,mmbdsite,mmbdunit,mmbddocdt,mmbddocno,mmbd002,mmbd001,mmbdstus, 
          mmbdownid,mmbdowndp,mmbdcrtid,mmbdcrtdp,mmbdcrtdt,mmbdmodid,mmbdmoddt,mmbdcnfid,mmbdcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmbdcrtdt>>----
         AFTER FIELD mmbdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmbdmoddt>>----
         AFTER FIELD mmbdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbdcnfdt>>----
         AFTER FIELD mmbdcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbdpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbd000
            #add-point:BEFORE FIELD mmbd000 name="construct.b.mmbd000"
            DISPLAY g_argv[1] TO mmbd000
            NEXT FIELD mmbddocno
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbd000
            
            #add-point:AFTER FIELD mmbd000 name="construct.a.mmbd000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbd000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbd000
            #add-point:ON ACTION controlp INFIELD mmbd000 name="construct.c.mmbd000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbdsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdsite
            #add-point:ON ACTION controlp INFIELD mmbdsite name="construct.c.mmbdsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                               #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdsite  #顯示到畫面上

            NEXT FIELD mmbdsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdsite
            #add-point:BEFORE FIELD mmbdsite name="construct.b.mmbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdsite
            
            #add-point:AFTER FIELD mmbdsite name="construct.a.mmbdsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdunit
            #add-point:BEFORE FIELD mmbdunit name="construct.b.mmbdunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdunit
            
            #add-point:AFTER FIELD mmbdunit name="construct.a.mmbdunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbdunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdunit
            #add-point:ON ACTION controlp INFIELD mmbdunit name="construct.c.mmbdunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbddocdt
            #add-point:BEFORE FIELD mmbddocdt name="construct.b.mmbddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbddocdt
            
            #add-point:AFTER FIELD mmbddocdt name="construct.a.mmbddocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbddocdt
            #add-point:ON ACTION controlp INFIELD mmbddocdt name="construct.c.mmbddocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbddocno
            #add-point:ON ACTION controlp INFIELD mmbddocno name="construct.c.mmbddocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
             LET g_qryparam.arg1 = g_argv[1]
    
            CALL q_mmbddocno()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO mmbddocno  #顯示到畫面上

            NEXT FIELD mmbddocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbddocno
            #add-point:BEFORE FIELD mmbddocno name="construct.b.mmbddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbddocno
            
            #add-point:AFTER FIELD mmbddocno name="construct.a.mmbddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbd002
            #add-point:ON ACTION controlp INFIELD mmbd002 name="construct.c.mmbd002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2055" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbd002  #顯示到畫面上

            NEXT FIELD mmbd002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbd002
            #add-point:BEFORE FIELD mmbd002 name="construct.b.mmbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbd002
            
            #add-point:AFTER FIELD mmbd002 name="construct.a.mmbd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbd001
            #add-point:ON ACTION controlp INFIELD mmbd001 name="construct.c.mmbd001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2056" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbd001  #顯示到畫面上

            NEXT FIELD mmbd001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbd001
            #add-point:BEFORE FIELD mmbd001 name="construct.b.mmbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbd001
            
            #add-point:AFTER FIELD mmbd001 name="construct.a.mmbd001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdstus
            #add-point:BEFORE FIELD mmbdstus name="construct.b.mmbdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdstus
            
            #add-point:AFTER FIELD mmbdstus name="construct.a.mmbdstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdstus
            #add-point:ON ACTION controlp INFIELD mmbdstus name="construct.c.mmbdstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdownid
            #add-point:ON ACTION controlp INFIELD mmbdownid name="construct.c.mmbdownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdownid  #顯示到畫面上

            NEXT FIELD mmbdownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdownid
            #add-point:BEFORE FIELD mmbdownid name="construct.b.mmbdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdownid
            
            #add-point:AFTER FIELD mmbdownid name="construct.a.mmbdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdowndp
            #add-point:ON ACTION controlp INFIELD mmbdowndp name="construct.c.mmbdowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdowndp  #顯示到畫面上

            NEXT FIELD mmbdowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdowndp
            #add-point:BEFORE FIELD mmbdowndp name="construct.b.mmbdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdowndp
            
            #add-point:AFTER FIELD mmbdowndp name="construct.a.mmbdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdcrtid
            #add-point:ON ACTION controlp INFIELD mmbdcrtid name="construct.c.mmbdcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdcrtid  #顯示到畫面上

            NEXT FIELD mmbdcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdcrtid
            #add-point:BEFORE FIELD mmbdcrtid name="construct.b.mmbdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdcrtid
            
            #add-point:AFTER FIELD mmbdcrtid name="construct.a.mmbdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdcrtdp
            #add-point:ON ACTION controlp INFIELD mmbdcrtdp name="construct.c.mmbdcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdcrtdp  #顯示到畫面上

            NEXT FIELD mmbdcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdcrtdp
            #add-point:BEFORE FIELD mmbdcrtdp name="construct.b.mmbdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdcrtdp
            
            #add-point:AFTER FIELD mmbdcrtdp name="construct.a.mmbdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdcrtdt
            #add-point:BEFORE FIELD mmbdcrtdt name="construct.b.mmbdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdmodid
            #add-point:ON ACTION controlp INFIELD mmbdmodid name="construct.c.mmbdmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdmodid  #顯示到畫面上

            NEXT FIELD mmbdmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdmodid
            #add-point:BEFORE FIELD mmbdmodid name="construct.b.mmbdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdmodid
            
            #add-point:AFTER FIELD mmbdmodid name="construct.a.mmbdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdmoddt
            #add-point:BEFORE FIELD mmbdmoddt name="construct.b.mmbdmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbdcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdcnfid
            #add-point:ON ACTION controlp INFIELD mmbdcnfid name="construct.c.mmbdcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbdcnfid  #顯示到畫面上

            NEXT FIELD mmbdcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdcnfid
            #add-point:BEFORE FIELD mmbdcnfid name="construct.b.mmbdcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdcnfid
            
            #add-point:AFTER FIELD mmbdcnfid name="construct.a.mmbdcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdcnfdt
            #add-point:BEFORE FIELD mmbdcnfdt name="construct.b.mmbdcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmbeseq,mmbesite,mmbe001,mmbe002,mmbe003,mmbe006,mmbe005
           FROM s_detail1[1].mmbeseq,s_detail1[1].mmbesite,s_detail1[1].mmbe001,s_detail1[1].mmbe002, 
               s_detail1[1].mmbe003,s_detail1[1].mmbe006,s_detail1[1].mmbe005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbeseq
            #add-point:BEFORE FIELD mmbeseq name="construct.b.page1.mmbeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbeseq
            
            #add-point:AFTER FIELD mmbeseq name="construct.a.page1.mmbeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbeseq
            #add-point:ON ACTION controlp INFIELD mmbeseq name="construct.c.page1.mmbeseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmbesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbesite
            #add-point:ON ACTION controlp INFIELD mmbesite name="construct.c.page1.mmbesite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbesite  #顯示到畫面上

            NEXT FIELD mmbesite  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbesite
            #add-point:BEFORE FIELD mmbesite name="construct.b.page1.mmbesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbesite
            
            #add-point:AFTER FIELD mmbesite name="construct.a.page1.mmbesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe001
            #add-point:ON ACTION controlp INFIELD mmbe001 name="construct.c.page1.mmbe001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #根據當前程式參數給與不同開窗邏輯
            CASE 
               WHEN g_argv[1] = '3' 
                  LET g_qryparam.where = " mmaq006 = '2'"
                  CALL q_mmbe001_2()
               WHEN g_argv[1] = '4'
                  LET g_qryparam.where = " mmaq006 = '1'"
                  CALL q_mmbe001_1()
               WHEN g_argv[1] MATCHES '[56]'
                  LET g_qryparam.where = " mmaq006 IN ('2','3')"
                  CALL q_mmbe001()
               WHEN g_argv[1] = '8'
                  LET g_qryparam.where = " mmaq006 = '5'"
                  CALL q_mmbe001()  
               WHEN g_argv[1] = '9'
                  LET g_qryparam.where = " mmaq006 = '6'"
                  CALL q_mmbe001()  
               WHEN g_argv[1] = '7'
                  LET g_qryparam.where = " mmaq006 IN ('2','3','5')"
                  CALL q_mmbe001()                  
            END CASE
            INITIALIZE g_qryparam.where TO NULL                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbe001  #顯示到畫面上

            NEXT FIELD mmbe001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe001
            #add-point:BEFORE FIELD mmbe001 name="construct.b.page1.mmbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe001
            
            #add-point:AFTER FIELD mmbe001 name="construct.a.page1.mmbe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe002
            #add-point:ON ACTION controlp INFIELD mmbe002 name="construct.c.page1.mmbe002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbe002  #顯示到畫面上

            NEXT FIELD mmbe002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe002
            #add-point:BEFORE FIELD mmbe002 name="construct.b.page1.mmbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe002
            
            #add-point:AFTER FIELD mmbe002 name="construct.a.page1.mmbe002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe003
            #add-point:ON ACTION controlp INFIELD mmbe003 name="construct.c.page1.mmbe003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbe003  #顯示到畫面上

            NEXT FIELD mmbe003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe003
            #add-point:BEFORE FIELD mmbe003 name="construct.b.page1.mmbe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe003
            
            #add-point:AFTER FIELD mmbe003 name="construct.a.page1.mmbe003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe006
            #add-point:BEFORE FIELD mmbe006 name="construct.b.page1.mmbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe006
            
            #add-point:AFTER FIELD mmbe006 name="construct.a.page1.mmbe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe006
            #add-point:ON ACTION controlp INFIELD mmbe006 name="construct.c.page1.mmbe006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe005
            #add-point:BEFORE FIELD mmbe005 name="construct.b.page1.mmbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe005
            
            #add-point:AFTER FIELD mmbe005 name="construct.a.page1.mmbe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe005
            #add-point:ON ACTION controlp INFIELD mmbe005 name="construct.c.page1.mmbe005"
            
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
                  WHEN la_wc[li_idx].tableid = "mmbd_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmbe_t" 
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
 
{<section id="ammt410.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammt410_filter()
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
      CONSTRUCT g_wc_filter ON mmbd000,mmbdunit,mmbddocno,mmbddocdt,mmbdsite
                          FROM s_browse[1].b_mmbd000,s_browse[1].b_mmbdunit,s_browse[1].b_mmbddocno, 
                              s_browse[1].b_mmbddocdt,s_browse[1].b_mmbdsite
 
         BEFORE CONSTRUCT
               DISPLAY ammt410_filter_parser('mmbd000') TO s_browse[1].b_mmbd000
            DISPLAY ammt410_filter_parser('mmbdunit') TO s_browse[1].b_mmbdunit
            DISPLAY ammt410_filter_parser('mmbddocno') TO s_browse[1].b_mmbddocno
            DISPLAY ammt410_filter_parser('mmbddocdt') TO s_browse[1].b_mmbddocdt
            DISPLAY ammt410_filter_parser('mmbdsite') TO s_browse[1].b_mmbdsite
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
#      ON ACTION controlp INFIELD mmbddocno
#            #add-point:ON ACTION controlp INFIELD mmbddocno
#            #此段落由子樣板a08產生
#            #開窗c段
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.arg1 = g_argv[1]
#
#            CALL q_mmbddocno()                           #呼叫開窗
#
#            DISPLAY g_qryparam.return1 TO mmbddocno  #顯示到畫面上
#
#            NEXT FIELD mmbddocno
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
      
#       ON ACTION controlp INFIELD mmbd003
#            #add-point:ON ACTION controlp INFIELD mmbd003
#            #此段落由子樣板a08產生
#            #開窗c段
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_argv[1]
#            CALL q_mmbd003()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO mmbd003  #顯示到畫面上
#
#            NEXT FIELD mmbd003
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
 
      CALL ammt410_filter_show('mmbd000')
   CALL ammt410_filter_show('mmbdunit')
   CALL ammt410_filter_show('mmbddocno')
   CALL ammt410_filter_show('mmbddocdt')
   CALL ammt410_filter_show('mmbdsite')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt410_filter_parser(ps_field)
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
 
{<section id="ammt410.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt410_filter_show(ps_field)
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
   LET ls_condition = ammt410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt410_query()
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
   CALL g_mmbe_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammt410_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt410_browser_fill("")
      CALL ammt410_fetch("")
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
      CALL ammt410_filter_show('mmbd000')
   CALL ammt410_filter_show('mmbdunit')
   CALL ammt410_filter_show('mmbddocno')
   CALL ammt410_filter_show('mmbddocdt')
   CALL ammt410_filter_show('mmbdsite')
   CALL ammt410_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammt410_fetch("F") 
      #顯示單身筆數
      CALL ammt410_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt410_fetch(p_flag)
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
   
   LET g_mmbd_m.mmbddocno = g_browser[g_current_idx].b_mmbddocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
       g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus, 
       g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt,g_mmbd_m.mmbdsite_desc, 
       g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc, 
       g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdcnfid_desc
   
   #遮罩相關處理
   LET g_mmbd_m_mask_o.* =  g_mmbd_m.*
   CALL ammt410_mmbd_t_mask()
   LET g_mmbd_m_mask_n.* =  g_mmbd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt410_set_act_visible()   
   CALL ammt410_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
  #IF g_mmbd_m.mmbdstus = 'N' THEN
  #   CALL cl_set_act_visible("modify,delete",TRUE)
  #ELSE
  #   CALL cl_set_act_visible("modify,delete",FALSE)
  #END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmbd_m_t.* = g_mmbd_m.*
   LET g_mmbd_m_o.* = g_mmbd_m.*
   
   LET g_data_owner = g_mmbd_m.mmbdownid      
   LET g_data_dept  = g_mmbd_m.mmbdowndp
   
   #重新顯示   
   CALL ammt410_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt410_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004
   #ken---add---e
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmbe_d.clear()   
 
 
   INITIALIZE g_mmbd_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmbddocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmbd_m.mmbdownid = g_user
      LET g_mmbd_m.mmbdowndp = g_dept
      LET g_mmbd_m.mmbdcrtid = g_user
      LET g_mmbd_m.mmbdcrtdp = g_dept 
      LET g_mmbd_m.mmbdcrtdt = cl_get_current()
      LET g_mmbd_m.mmbdmodid = g_user
      LET g_mmbd_m.mmbdmoddt = cl_get_current()
      LET g_mmbd_m.mmbdstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmbd_m.mmbdstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mmbd_m.mmbd000 = g_argv[1]
      LET g_mmbd_m.mmbddocdt = g_today
      LET g_mmbd_m.mmbdunit = g_site
      CALL ammt410_mmbdsite_desc()
      LET g_mmbd_m.mmbdsite = g_site
      
      #ken---add---s 需求單號：141125-00002 項次：4
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmbd_m.mmbdsite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_mmbd_m.mmbddocno = l_doctype      
      #ken---add---e
      
      LET g_mmbd_m_t.* = g_mmbd_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmbd_m_t.* = g_mmbd_m.*
      LET g_mmbd_m_o.* = g_mmbd_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbd_m.mmbdstus 
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
 
 
 
    
      CALL ammt410_input("a")
      
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
         INITIALIZE g_mmbd_m.* TO NULL
         INITIALIZE g_mmbe_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammt410_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmbe_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt410_set_act_visible()   
   CALL ammt410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmbdent = " ||g_enterprise|| " AND",
                      " mmbddocno = '", g_mmbd_m.mmbddocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammt410_cl
   
   CALL ammt410_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
       g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus, 
       g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt,g_mmbd_m.mmbdsite_desc, 
       g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc, 
       g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdcnfid_desc
   
   
   #遮罩相關處理
   LET g_mmbd_m_mask_o.* =  g_mmbd_m.*
   CALL ammt410_mmbd_t_mask()
   LET g_mmbd_m_mask_n.* =  g_mmbd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdsite_desc,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt, 
       g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001,g_mmbd_m.mmbd001_desc, 
       g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdowndp_desc, 
       g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtid_desc,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfid_desc, 
       g_mmbd_m.mmbdcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmbd_m.mmbdownid      
   LET g_data_dept  = g_mmbd_m.mmbdowndp
   
   #功能已完成,通報訊息中心
   CALL ammt410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt410_modify()
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
   LET g_mmbd_m_t.* = g_mmbd_m.*
   LET g_mmbd_m_o.* = g_mmbd_m.*
   
   IF g_mmbd_m.mmbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
   CALL s_transaction_begin()
   
   OPEN ammt410_cl USING g_enterprise,g_mmbd_m.mmbddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
       g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus, 
       g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt,g_mmbd_m.mmbdsite_desc, 
       g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc, 
       g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdcnfid_desc
   
   #檢查是否允許此動作
   IF NOT ammt410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmbd_m_mask_o.* =  g_mmbd_m.*
   CALL ammt410_mmbd_t_mask()
   LET g_mmbd_m_mask_n.* =  g_mmbd_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL ammt410_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmbd_m.mmbdmodid = g_user 
LET g_mmbd_m.mmbdmoddt = cl_get_current()
LET g_mmbd_m.mmbdmodid_desc = cl_get_username(g_mmbd_m.mmbdmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammt410_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmbd_t SET (mmbdmodid,mmbdmoddt) = (g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt)
          WHERE mmbdent = g_enterprise AND mmbddocno = g_mmbddocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmbd_m.* = g_mmbd_m_t.*
            CALL ammt410_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmbd_m.mmbddocno != g_mmbd_m_t.mmbddocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmbe_t SET mmbedocno = g_mmbd_m.mmbddocno
 
          WHERE mmbeent = g_enterprise AND mmbedocno = g_mmbd_m_t.mmbddocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmbe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbe_t:",SQLERRMESSAGE 
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
   CALL ammt410_set_act_visible()   
   CALL ammt410_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmbdent = " ||g_enterprise|| " AND",
                      " mmbddocno = '", g_mmbd_m.mmbddocno, "' "
 
   #填到對應位置
   CALL ammt410_browser_fill("")
 
   CLOSE ammt410_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt410_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammt410.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt410_input(p_cmd)
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
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_ooef004        LIKE ooef_t.ooef004
   DEFINE l_oobl002        LIKE oobl_t.oobl002
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
   DISPLAY BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdsite_desc,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt, 
       g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001,g_mmbd_m.mmbd001_desc, 
       g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdowndp_desc, 
       g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtid_desc,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfid_desc, 
       g_mmbd_m.mmbdcnfdt
   
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
   LET g_forupd_sql = "SELECT mmbeseq,mmbesite,mmbe001,mmbe002,mmbe003,mmbe006,mmbe005,mmbeunit FROM  
       mmbe_t WHERE mmbeent=? AND mmbedocno=? AND mmbeseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt410_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammt410_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno, 
       g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammt410.input.head" >}
      #單頭段
      INPUT BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno, 
          g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammt410_cl USING g_enterprise,g_mmbd_m.mmbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammt410_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_cmd_t = 'r' THEN
               LET g_mmbd_m.mmbddocdt = g_today
               LET g_mmbd_m.mmbdstus = "N"
               LET g_mmbd_m.mmbdcnfid = ''
               LET g_mmbd_m.mmbdcnfdt = ''
               
            END IF
            NEXT FIELD mmbddocno
            #end add-point
            CALL ammt410_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbd000
            #add-point:BEFORE FIELD mmbd000 name="input.b.mmbd000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbd000
            
            #add-point:AFTER FIELD mmbd000 name="input.a.mmbd000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbd000
            #add-point:ON CHANGE mmbd000 name="input.g.mmbd000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdsite
            
            #add-point:AFTER FIELD mmbdsite name="input.a.mmbdsite"
            CALL ammt410_mmbdsite_desc()
            IF NOT cl_null(g_mmbd_m.mmbdsite) THEN
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mmbd_m.mmbdsite

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_20") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_mmbd_m.mmbdsite = g_mmbd_m_t.mmbdsite
                  NEXT FIELD CURRENT
               END IF
               
            END IF 
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdsite
            #add-point:BEFORE FIELD mmbdsite name="input.b.mmbdsite"
            CALL ammt410_mmbdsite_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbdsite
            #add-point:ON CHANGE mmbdsite name="input.g.mmbdsite"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdunit
            #add-point:BEFORE FIELD mmbdunit name="input.b.mmbdunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdunit
            
            #add-point:AFTER FIELD mmbdunit name="input.a.mmbdunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbdunit
            #add-point:ON CHANGE mmbdunit name="input.g.mmbdunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbddocdt
            #add-point:BEFORE FIELD mmbddocdt name="input.b.mmbddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbddocdt
            
            #add-point:AFTER FIELD mmbddocdt name="input.a.mmbddocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbddocdt
            #add-point:ON CHANGE mmbddocdt name="input.g.mmbddocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbddocno
            #add-point:BEFORE FIELD mmbddocno name="input.b.mmbddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbddocno
            
            #add-point:AFTER FIELD mmbddocno name="input.a.mmbddocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbd_m.mmbddocno) THEN 
                IF NOT ammt410_mmbddocno_chk(p_cmd,g_mmbd_m.mmbddocno) THEN
                   LET g_mmbd_m.mmbddocno = g_mmbddocno_t
                   NEXT FIELD CURRENT
                END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbddocno
            #add-point:ON CHANGE mmbddocno name="input.g.mmbddocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbd002
            
            #add-point:AFTER FIELD mmbd002 name="input.a.mmbd002"
            LET g_mmbd_m.mmbd002_desc = ''
            DISPLAY BY NAME g_mmbd_m.mmbd002_desc
            IF NOT cl_null(g_mmbd_m.mmbd002) THEN
               IF NOT ap_chk_isExist(g_mmbd_m.mmbd002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent='"||g_enterprise||"' AND oocq001='2055' AND oocq002 = ?",'sub-01303','ammi020') THEN #160318-00005#24 mod#'amm-00040',1) THEN
                  LET g_mmbd_m.mmbd002 = g_mmbd_m_t.mmbd002
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT ap_chk_isExist(g_mmbd_m.mmbd002,"SELECT COUNT(*) FROM oocq_t WHERE oocqent='"||g_enterprise||"' AND oocq001='2055' AND oocq002 = ? AND oocqstus = 'Y'",'amm-00041',1) THEN
                  LET g_mmbd_m.mmbd002 = g_mmbd_m_t.mmbd002
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbd_m.mmbd002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2055' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmbd_m.mmbd002_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmbd_m.mmbd002_desc
   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbd002
            #add-point:BEFORE FIELD mmbd002 name="input.b.mmbd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbd002
            #add-point:ON CHANGE mmbd002 name="input.g.mmbd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbd001
            
            #add-point:AFTER FIELD mmbd001 name="input.a.mmbd001"
            LET g_mmbd_m.mmbd001_desc = ''
            DISPLAY BY NAME g_mmbd_m.mmbd001_desc
            IF NOT cl_null(g_mmbd_m.mmbd001) THEN
               IF NOT ap_chk_isExist(g_mmbd_m.mmbd001,"SELECT COUNT(*) FROM oocq_t WHERE oocqent='"||g_enterprise||"' AND oocq001='2056' AND oocq002 = ?",'amm-00042',1) THEN
                  LET g_mmbd_m.mmbd001 = g_mmbd_m_t.mmbd001
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT ap_chk_isExist(g_mmbd_m.mmbd001,"SELECT COUNT(*) FROM oocq_t WHERE oocqent='"||g_enterprise||"' AND oocq001='2056' AND oocq002 = ? AND oocqstus = 'Y'",'amm-00043',1) THEN
                  LET g_mmbd_m.mmbd001 = g_mmbd_m_t.mmbd001
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbd_m.mmbd001
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2056' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmbd_m.mmbd001_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmbd_m.mmbd001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbd001
            #add-point:BEFORE FIELD mmbd001 name="input.b.mmbd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbd001
            #add-point:ON CHANGE mmbd001 name="input.g.mmbd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbdstus
            #add-point:BEFORE FIELD mmbdstus name="input.b.mmbdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbdstus
            
            #add-point:AFTER FIELD mmbdstus name="input.a.mmbdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbdstus
            #add-point:ON CHANGE mmbdstus name="input.g.mmbdstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmbd000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbd000
            #add-point:ON ACTION controlp INFIELD mmbd000 name="input.c.mmbd000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbdsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdsite
            #add-point:ON ACTION controlp INFIELD mmbdsite name="input.c.mmbdsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbd_m.mmbdsite             #給予default值

			   LET g_qryparam.where = " ooef201 = 'Y' "
            CALL q_ooef001()                                #呼叫開窗

            LET g_mmbd_m.mmbdsite  = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbd_m.mmbdsite TO mmbdsite              #顯示到畫面上

            NEXT FIELD mmbdsite
            #END add-point
 
 
         #Ctrlp:input.c.mmbdunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdunit
            #add-point:ON ACTION controlp INFIELD mmbdunit name="input.c.mmbdunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbddocdt
            #add-point:ON ACTION controlp INFIELD mmbddocdt name="input.c.mmbddocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbddocno
            #add-point:ON ACTION controlp INFIELD mmbddocno name="input.c.mmbddocno"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbd_m.mmbddocno             #給予default值
            SELECT ooef004 INTO l_ooef004 FROM ooef_t  WHERE ooefent = g_enterprise  AND ooef001 = g_site
            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            #160705-00042#11 160715 by sakura mark(S)
            #CASE g_argv[1]
            #   WHEN '3'
            #      LET g_qryparam.arg2 = 'ammt411' 
            #   WHEN '4'
            #      LET g_qryparam.arg2 = 'ammt412'
            #   WHEN '5'
            #      LET g_qryparam.arg2 = 'ammt413'
            #   WHEN '8'
            #      LET g_qryparam.arg2 = 'ammt414'
            #   WHEN '6'
            #      LET g_qryparam.arg2 = 'ammt415'
            #   WHEN '9'
            #      LET g_qryparam.arg2 = 'ammt416'
            #   WHEN '7'
            #      LET g_qryparam.arg2 = 'ammt417'
            #END CASE
            #160705-00042#11 160715 by sakura mark(E)
            LET g_qryparam.arg2 = g_prog   #160705-00042#11 160715 by sakura add
            CALL q_ooba002_1()                                #呼叫開窗
            INITIALIZE g_qryparam.arg1 TO NULL
            INITIALIZE g_qryparam.arg2 TO NULL
            LET g_mmbd_m.mmbddocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_mmbd_m.mmbddocno TO mmbddocno              #顯示到畫面上

            NEXT FIELD mmbddocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbd002
            #add-point:ON ACTION controlp INFIELD mmbd002 name="input.c.mmbd002"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbd_m.mmbd002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2055" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmbd_m.mmbd002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbd_m.mmbd002 TO mmbd002              #顯示到畫面上

            NEXT FIELD mmbd002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbd001
            #add-point:ON ACTION controlp INFIELD mmbd001 name="input.c.mmbd001"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbd_m.mmbd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2056" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmbd_m.mmbd001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbd_m.mmbd001 TO mmbd001              #顯示到畫面上

            NEXT FIELD mmbd001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbdstus
            #add-point:ON ACTION controlp INFIELD mmbdstus name="input.c.mmbdstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmbd_m.mmbddocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_gen_docno(g_site,g_mmbd_m.mmbddocno,g_today,g_prog) RETURNING l_success,g_mmbd_m.mmbddocno
               #end add-point
               
               INSERT INTO mmbd_t (mmbdent,mmbd000,mmbdsite,mmbdunit,mmbddocdt,mmbddocno,mmbd002,mmbd001, 
                   mmbdstus,mmbdownid,mmbdowndp,mmbdcrtid,mmbdcrtdp,mmbdcrtdt,mmbdmodid,mmbdmoddt,mmbdcnfid, 
                   mmbdcnfdt)
               VALUES (g_enterprise,g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt, 
                   g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid, 
                   g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt,g_mmbd_m.mmbdmodid, 
                   g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmbd_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  IF l_cmd_t != 'r' THEN
                     LET g_mmbd_m_t.* = g_mmbd_m.*
                     LET g_mmbddocno_t = g_mmbd_m.mmbddocno
                  END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammt410_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammt410_b_fill()
                  CALL ammt410_b_fill2('0')
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
               CALL ammt410_mmbd_t_mask_restore('restore_mask_o')
               
               UPDATE mmbd_t SET (mmbd000,mmbdsite,mmbdunit,mmbddocdt,mmbddocno,mmbd002,mmbd001,mmbdstus, 
                   mmbdownid,mmbdowndp,mmbdcrtid,mmbdcrtdp,mmbdcrtdt,mmbdmodid,mmbdmoddt,mmbdcnfid,mmbdcnfdt) = (g_mmbd_m.mmbd000, 
                   g_mmbd_m.mmbdsite,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002, 
                   g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid, 
                   g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt,g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid, 
                   g_mmbd_m.mmbdcnfdt)
                WHERE mmbdent = g_enterprise AND mmbddocno = g_mmbddocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmbd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL ammt410_mmbd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmbd_m_t)
               LET g_log2 = util.JSON.stringify(g_mmbd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt410.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmbe_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmbe_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt410_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmbe_d.getLength()
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
            OPEN ammt410_cl USING g_enterprise,g_mmbd_m.mmbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmbe_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmbe_d[l_ac].mmbeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmbe_d_t.* = g_mmbe_d[l_ac].*  #BACKUP
               LET g_mmbe_d_o.* = g_mmbe_d[l_ac].*  #BACKUP
               CALL ammt410_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL ammt410_set_no_entry_b(l_cmd)
               IF NOT ammt410_lock_b("mmbe_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt410_bcl INTO g_mmbe_d[l_ac].mmbeseq,g_mmbe_d[l_ac].mmbesite,g_mmbe_d[l_ac].mmbe001, 
                      g_mmbe_d[l_ac].mmbe002,g_mmbe_d[l_ac].mmbe003,g_mmbe_d[l_ac].mmbe006,g_mmbe_d[l_ac].mmbe005, 
                      g_mmbe_d[l_ac].mmbeunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmbe_d_t.mmbeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmbe_d_mask_o[l_ac].* =  g_mmbe_d[l_ac].*
                  CALL ammt410_mmbe_t_mask()
                  LET g_mmbe_d_mask_n[l_ac].* =  g_mmbe_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt410_show()
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
            INITIALIZE g_mmbe_d[l_ac].* TO NULL 
            INITIALIZE g_mmbe_d_t.* TO NULL 
            INITIALIZE g_mmbe_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mmbe_d_t.* = g_mmbe_d[l_ac].*     #新輸入資料
            LET g_mmbe_d_o.* = g_mmbe_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt410_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmbe_d[li_reproduce_target].* = g_mmbe_d[li_reproduce].*
 
               LET g_mmbe_d[li_reproduce_target].mmbeseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_mmbe_d[l_ac].mmbesite = g_mmbd_m.mmbdsite
            CALL ammt410_mmbesite_desc(g_mmbe_d[l_ac].mmbesite)
            
            SELECT MAX(mmbeseq) INTO g_mmbe_d[l_ac].mmbeseq FROM mmbe_t WHERE mmbeent = g_enterprise
              AND mmbedocno = g_mmbd_m.mmbddocno 
            IF cl_null(g_mmbe_d[l_ac].mmbeseq) THEN LET g_mmbe_d[l_ac].mmbeseq = 0 END IF
            LET g_mmbe_d[l_ac].mmbeseq = g_mmbe_d[l_ac].mmbeseq + 1
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
            SELECT COUNT(1) INTO l_count FROM mmbe_t 
             WHERE mmbeent = g_enterprise AND mmbedocno = g_mmbd_m.mmbddocno
 
               AND mmbeseq = g_mmbe_d[l_ac].mmbeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbd_m.mmbddocno
               LET gs_keys[2] = g_mmbe_d[g_detail_idx].mmbeseq
               CALL ammt410_insert_b('mmbe_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmbe_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt410_b_fill()
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
               LET gs_keys[01] = g_mmbd_m.mmbddocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmbe_d_t.mmbeseq
 
            
               #刪除同層單身
               IF NOT ammt410_delete_b('mmbe_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt410_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt410_key_delete_b(gs_keys,'mmbe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt410_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt410_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mmbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmbe_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbeseq
            #add-point:BEFORE FIELD mmbeseq name="input.b.page1.mmbeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbeseq
            
            #add-point:AFTER FIELD mmbeseq name="input.a.page1.mmbeseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbd_m.mmbddocno) AND NOT cl_null(g_mmbe_d[l_ac].mmbeseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbd_m.mmbddocno != g_mmbddocno_t OR g_mmbe_d[l_ac].mmbeseq != g_mmbe_d_t.mmbeseq))) THEN 
                  IF NOT ap_chk_notDup(g_mmbe_d[l_ac].mmbeseq,"SELECT COUNT(*) FROM mmbe_t WHERE mmbeent = '" ||g_enterprise|| "' AND mmbedocno = '"||g_mmbd_m.mmbddocno ||"' AND mmbeseq = '"||g_mmbe_d[l_ac].mmbeseq ||"'",'std-00004',1) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbeseq
            #add-point:ON CHANGE mmbeseq name="input.g.page1.mmbeseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbesite
            
            #add-point:AFTER FIELD mmbesite name="input.a.page1.mmbesite"
            CALL ammt410_mmbesite_desc(g_mmbe_d[l_ac].mmbesite)
            IF NOT cl_null(g_mmbe_d[l_ac].mmbesite) THEN
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mmbe_d[l_ac].mmbesite
               LET g_chkparam.arg2 = '8'
               LET g_chkparam.arg3 = g_mmbd_m.mmbdsite
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooed004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_mmbe_d[l_ac].mmbesite = g_mmbe_d_t.mmbesite
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbesite
            #add-point:BEFORE FIELD mmbesite name="input.b.page1.mmbesite"
            CALL ammt410_mmbesite_desc(g_mmbe_d[l_ac].mmbesite)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbesite
            #add-point:ON CHANGE mmbesite name="input.g.page1.mmbesite"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe001
            #add-point:BEFORE FIELD mmbe001 name="input.b.page1.mmbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe001
            
            #add-point:AFTER FIELD mmbe001 name="input.a.page1.mmbe001"
            INITIALIZE g_mmbe_d[l_ac].mmbe002 TO NULL
            INITIALIZE g_mmbe_d[l_ac].mmbe002_desc TO NULL
            INITIALIZE g_mmbe_d[l_ac].mmbe002_desc TO NULL
            INITIALIZE g_mmbe_d[l_ac].mmbe003 TO NULL
            INITIALIZE g_mmbe_d[l_ac].mmbe006 TO NULL
            INITIALIZE g_mmbe_d[l_ac].mmbe005 TO NULL
            DISPLAY BY NAME g_mmbe_d[l_ac].mmbe002,g_mmbe_d[l_ac].mmbe002_desc,g_mmbe_d[l_ac].mmbe003,g_mmbe_d[l_ac].mmbe003_desc,
                   g_mmbe_d[l_ac].mmbe006,g_mmbe_d[l_ac].mmbe005
            IF NOT cl_null(g_mmbe_d[l_ac].mmbe001) THEN
#              IF (p_cmd = 'a' OR (p_cmd = 'u' AND g_mmbe_d[l_ac].mmbe001 != g_mmbe_d_t.mmbe001)) THEN    #150204-00001#42  by geza 20150511
              #IF (l_cmd = 'a' OR (l_cmd = 'u' AND g_mmbe_d[l_ac].mmbe001 != g_mmbe_d_t.mmbe001)) THEN    #150204-00001#42  by geza 20150511   #160824-00007#124 by sakura mark
              IF g_mmbe_d[l_ac].mmbe001 != g_mmbe_d_o.mmbe001 OR cl_null(g_mmbe_d_o.mmbe001) THEN   #160824-00007#124 by sakura add
                  IF NOT ammt410_mmbe001_chk(g_mmbe_d[l_ac].mmbe001,g_mmbe_d[l_ac].mmbesite) THEN
                     #LET g_mmbe_d[l_ac].mmbe001 = g_mmbe_d_t.mmbe001  #160824-00007#124 by sakura mark
                     LET g_mmbe_d[l_ac].mmbe001 = g_mmbe_d_o.mmbe001   #160824-00007#124 by sakura add
                     NEXT FIELD CURRENT
                  ELSE
                     CALL ammt410_mmbe001_desc()
                  END IF
              END IF
            END IF
            LET g_mmbe_d_o.* = g_mmbe_d[l_ac].*   #160824-00007#124 by sakura add
            CALL ammt410_mmbe001_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbe001
            #add-point:ON CHANGE mmbe001 name="input.g.page1.mmbe001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe002
            
            #add-point:AFTER FIELD mmbe002 name="input.a.page1.mmbe002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbe_d[l_ac].mmbe002
            CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmbe_d[l_ac].mmbe002_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmbe_d[l_ac].mmbe002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe002
            #add-point:BEFORE FIELD mmbe002 name="input.b.page1.mmbe002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbe002
            #add-point:ON CHANGE mmbe002 name="input.g.page1.mmbe002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe003
            
            #add-point:AFTER FIELD mmbe003 name="input.a.page1.mmbe003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbe_d[l_ac].mmbe003
            CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? ","") RETURNING g_rtn_fields
            LET g_mmbe_d[l_ac].mmbe003_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_mmbe_d[l_ac].mmbe003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe003
            #add-point:BEFORE FIELD mmbe003 name="input.b.page1.mmbe003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbe003
            #add-point:ON CHANGE mmbe003 name="input.g.page1.mmbe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe006
            #add-point:BEFORE FIELD mmbe006 name="input.b.page1.mmbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe006
            
            #add-point:AFTER FIELD mmbe006 name="input.a.page1.mmbe006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbe006
            #add-point:ON CHANGE mmbe006 name="input.g.page1.mmbe006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbe005
            #add-point:BEFORE FIELD mmbe005 name="input.b.page1.mmbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbe005
            
            #add-point:AFTER FIELD mmbe005 name="input.a.page1.mmbe005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbe005
            #add-point:ON CHANGE mmbe005 name="input.g.page1.mmbe005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmbeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbeseq
            #add-point:ON ACTION controlp INFIELD mmbeseq name="input.c.page1.mmbeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbesite
            #add-point:ON ACTION controlp INFIELD mmbesite name="input.c.page1.mmbesite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbe_d[l_ac].mmbesite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_mmbd_m.mmbdsite
            LET g_qryparam.arg2 = '8'
            CALL q_ooed004()                                #呼叫開窗

            LET g_mmbe_d[l_ac].mmbesite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbe_d[l_ac].mmbesite TO mmbesite             #顯示到畫面上

            NEXT FIELD mmbesite
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe001
            #add-point:ON ACTION controlp INFIELD mmbe001 name="input.c.page1.mmbe001"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbe_d[l_ac].mmbe001             #給予default值

            #根據當前程式參數給與不同開窗邏輯
            CASE 
               WHEN g_argv[1] = '3' 
                  LET g_qryparam.where = " mmaq006 = '2'"
                  CALL q_mmbe001_2()
               WHEN g_argv[1] = '4'
                  LET g_qryparam.arg1 = g_mmbe_d[l_ac].mmbesite
                  LET g_qryparam.where = " mmaq006 = '1'"
                  CALL q_mmbe001_1()
               WHEN g_argv[1] MATCHES '[56]'
                  LET g_qryparam.where = " mmaq006 IN ('2','3')"
                  CALL q_mmbe001()
               WHEN g_argv[1] = '8'
                  LET g_qryparam.where = " mmaq006 = '5'"
                  CALL q_mmbe001()  
               WHEN g_argv[1] = '9'
                  LET g_qryparam.where = " mmaq006 = '6'"
                  CALL q_mmbe001()  
               WHEN g_argv[1] = '7'
                  LET g_qryparam.where = " mmaq006 IN ('2','3','5')"
                  CALL q_mmbe001()                  
            END CASE
            INITIALIZE g_qryparam.where TO NULL      

            LET g_mmbe_d[l_ac].mmbe001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbe_d[l_ac].mmbe001 TO mmbe001              #顯示到畫面上

            NEXT FIELD mmbe001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe002
            #add-point:ON ACTION controlp INFIELD mmbe002 name="input.c.page1.mmbe002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe003
            #add-point:ON ACTION controlp INFIELD mmbe003 name="input.c.page1.mmbe003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe006
            #add-point:ON ACTION controlp INFIELD mmbe006 name="input.c.page1.mmbe006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbe005
            #add-point:ON ACTION controlp INFIELD mmbe005 name="input.c.page1.mmbe005"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmbe_d[l_ac].* = g_mmbe_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt410_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmbe_d[l_ac].mmbeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmbe_d[l_ac].* = g_mmbe_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL ammt410_mmbe_t_mask_restore('restore_mask_o')
      
               UPDATE mmbe_t SET (mmbedocno,mmbeseq,mmbesite,mmbe001,mmbe002,mmbe003,mmbe006,mmbe005, 
                   mmbeunit) = (g_mmbd_m.mmbddocno,g_mmbe_d[l_ac].mmbeseq,g_mmbe_d[l_ac].mmbesite,g_mmbe_d[l_ac].mmbe001, 
                   g_mmbe_d[l_ac].mmbe002,g_mmbe_d[l_ac].mmbe003,g_mmbe_d[l_ac].mmbe006,g_mmbe_d[l_ac].mmbe005, 
                   g_mmbe_d[l_ac].mmbeunit)
                WHERE mmbeent = g_enterprise AND mmbedocno = g_mmbd_m.mmbddocno 
 
                  AND mmbeseq = g_mmbe_d_t.mmbeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmbe_d[l_ac].* = g_mmbe_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmbe_d[l_ac].* = g_mmbe_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbd_m.mmbddocno
               LET gs_keys_bak[1] = g_mmbddocno_t
               LET gs_keys[2] = g_mmbe_d[g_detail_idx].mmbeseq
               LET gs_keys_bak[2] = g_mmbe_d_t.mmbeseq
               CALL ammt410_update_b('mmbe_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammt410_mmbe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmbe_d[g_detail_idx].mmbeseq = g_mmbe_d_t.mmbeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mmbd_m.mmbddocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmbe_d_t.mmbeseq
 
                  CALL ammt410_key_update_b(gs_keys,'mmbe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbd_m),util.JSON.stringify(g_mmbe_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbd_m),util.JSON.stringify(g_mmbe_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL ammt410_unlock_b("mmbe_t","'1'")
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
               LET g_mmbe_d[li_reproduce_target].* = g_mmbe_d[li_reproduce].*
 
               LET g_mmbe_d[li_reproduce_target].mmbeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmbe_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmbe_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="ammt410.input.other" >}
      
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
            NEXT FIELD mmbddocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmbeseq
 
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
 
{<section id="ammt410.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt410_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammt410_b_fill() #單身填充
      CALL ammt410_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            CALL ammt410_mmbdsite_desc()
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbd002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2055' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbd002_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbd002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbd001
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2056' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbd001_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbd001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbdownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbdownid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbdownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbdowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbdowndp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbdowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbdcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbdcrtid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbdcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbdcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbdcrtdp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbdcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbdmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbdmodid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbd_m.mmbdmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbd_m.mmbdcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbd_m.mmbdcnfid_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_mmbd_m.mmbdcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mmbd_m_mask_o.* =  g_mmbd_m.*
   CALL ammt410_mmbd_t_mask()
   LET g_mmbd_m_mask_n.* =  g_mmbd_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdsite_desc,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt, 
       g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001,g_mmbd_m.mmbd001_desc, 
       g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdowndp_desc, 
       g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtid_desc,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfid_desc, 
       g_mmbd_m.mmbdcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbd_m.mmbdstus 
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
   FOR l_ac = 1 TO g_mmbe_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            CALL ammt410_mmbesite_desc(g_mmbe_d[l_ac].mmbesite)
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbe_d[l_ac].mmbe002
#            CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbe_d[l_ac].mmbe002_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_mmbe_d[l_ac].mmbe002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbe_d[l_ac].mmbe003
#            CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? ","") RETURNING g_rtn_fields
#            LET g_mmbe_d[l_ac].mmbe003_desc = g_rtn_fields[1] 
#            DISPLAY BY NAME g_mmbe_d[l_ac].mmbe003_desc
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt410_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammt410_detail_show()
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
 
{<section id="ammt410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt410_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmbd_t.mmbddocno 
   DEFINE l_oldno     LIKE mmbd_t.mmbddocno 
 
   DEFINE l_master    RECORD LIKE mmbd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmbe_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_ooef004   LIKE ooef_t.ooef004
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_doctype     LIKE rtai_t.rtai004
   #ken---add---e  
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
   
   IF g_mmbd_m.mmbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
    
   LET g_mmbd_m.mmbddocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmbd_m.mmbdownid = g_user
      LET g_mmbd_m.mmbdowndp = g_dept
      LET g_mmbd_m.mmbdcrtid = g_user
      LET g_mmbd_m.mmbdcrtdp = g_dept 
      LET g_mmbd_m.mmbdcrtdt = cl_get_current()
      LET g_mmbd_m.mmbdmodid = g_user
      LET g_mmbd_m.mmbdmoddt = cl_get_current()
      LET g_mmbd_m.mmbdstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mmbd_m.mmbdsite = g_site #ken
   LET g_copy_flag = 'r'
   
   #ken---add---s 需求單號：141125-00002 項次：4
   #預設單據的單別 
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mmbd_m.mmbdsite,g_prog,'1')
        RETURNING l_success, l_doctype
   LET g_mmbd_m.mmbddocno = l_doctype      
   #ken---add---e
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbd_m.mmbdstus 
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
   
   
   CALL ammt410_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmbd_m.* TO NULL
      INITIALIZE g_mmbe_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammt410_show()
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
   CALL ammt410_set_act_visible()   
   CALL ammt410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmbdent = " ||g_enterprise|| " AND",
                      " mmbddocno = '", g_mmbd_m.mmbddocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL ammt410_idx_chk()
   
   LET g_data_owner = g_mmbd_m.mmbdownid      
   LET g_data_dept  = g_mmbd_m.mmbdowndp
   
   #功能已完成,通報訊息中心
   CALL ammt410_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt410_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmbe_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt410_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmbe_t
    WHERE mmbeent = g_enterprise AND mmbedocno = g_mmbddocno_t
 
    INTO TEMP ammt410_detail
 
   #將key修正為調整後   
   UPDATE ammt410_detail 
      #更新key欄位
      SET mmbedocno = g_mmbd_m.mmbddocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmbe_t SELECT * FROM ammt410_detail
   
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
   DROP TABLE ammt410_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt410_delete()
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
   
   IF g_mmbd_m.mmbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN ammt410_cl USING g_enterprise,g_mmbd_m.mmbddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
       g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus, 
       g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt,g_mmbd_m.mmbdsite_desc, 
       g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc, 
       g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmbd_m_mask_o.* =  g_mmbd_m.*
   CALL ammt410_mmbd_t_mask()
   LET g_mmbd_m_mask_n.* =  g_mmbd_m.*
   
   CALL ammt410_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmbddocno_t = g_mmbd_m.mmbddocno
 
 
      DELETE FROM mmbd_t
       WHERE mmbdent = g_enterprise AND mmbddocno = g_mmbd_m.mmbddocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmbd_m.mmbddocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM mmbe_t
       WHERE mmbeent = g_enterprise AND mmbedocno = g_mmbd_m.mmbddocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmbd_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammt410_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmbe_d.clear() 
 
     
      CALL ammt410_ui_browser_refresh()  
      #CALL ammt410_ui_headershow()  
      #CALL ammt410_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammt410_browser_fill("")
         CALL ammt410_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt410_cl
 
   #功能已完成,通報訊息中心
   CALL ammt410_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt410_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmbe_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF ammt410_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmbeseq,mmbesite,mmbe001,mmbe002,mmbe003,mmbe006,mmbe005,mmbeunit , 
             t1.ooefl003 ,t2.mmanl003 ,t3.mmaf008 FROM mmbe_t",   
                     " INNER JOIN mmbd_t ON mmbdent = " ||g_enterprise|| " AND mmbddocno = mmbedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=mmbesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t2 ON t2.mmanlent="||g_enterprise||" AND t2.mmanl001=mmbe002 AND t2.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN mmaf_t t3 ON t3.mmafent="||g_enterprise||" AND t3.mmaf001=mmbe003  ",
 
                     " WHERE mmbeent=? AND mmbedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmbe_t.mmbeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt410_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammt410_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmbd_m.mmbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmbd_m.mmbddocno INTO g_mmbe_d[l_ac].mmbeseq,g_mmbe_d[l_ac].mmbesite, 
          g_mmbe_d[l_ac].mmbe001,g_mmbe_d[l_ac].mmbe002,g_mmbe_d[l_ac].mmbe003,g_mmbe_d[l_ac].mmbe006, 
          g_mmbe_d[l_ac].mmbe005,g_mmbe_d[l_ac].mmbeunit,g_mmbe_d[l_ac].mmbesite_desc,g_mmbe_d[l_ac].mmbe002_desc, 
          g_mmbe_d[l_ac].mmbe003_desc   #(ver:78)
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
   
   CALL g_mmbe_d.deleteElement(g_mmbe_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt410_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmbe_d.getLength()
      LET g_mmbe_d_mask_o[l_ac].* =  g_mmbe_d[l_ac].*
      CALL ammt410_mmbe_t_mask()
      LET g_mmbe_d_mask_n[l_ac].* =  g_mmbe_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt410_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mmbe_t
       WHERE mmbeent = g_enterprise AND
         mmbedocno = ps_keys_bak[1] AND mmbeseq = ps_keys_bak[2]
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
         CALL g_mmbe_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt410_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mmbe_t
                  (mmbeent,
                   mmbedocno,
                   mmbeseq
                   ,mmbesite,mmbe001,mmbe002,mmbe003,mmbe006,mmbe005,mmbeunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmbe_d[g_detail_idx].mmbesite,g_mmbe_d[g_detail_idx].mmbe001,g_mmbe_d[g_detail_idx].mmbe002, 
                       g_mmbe_d[g_detail_idx].mmbe003,g_mmbe_d[g_detail_idx].mmbe006,g_mmbe_d[g_detail_idx].mmbe005, 
                       g_mmbe_d[g_detail_idx].mmbeunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmbe_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt410_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammt410_mmbe_t_mask_restore('restore_mask_o')
               
      UPDATE mmbe_t 
         SET (mmbedocno,
              mmbeseq
              ,mmbesite,mmbe001,mmbe002,mmbe003,mmbe006,mmbe005,mmbeunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmbe_d[g_detail_idx].mmbesite,g_mmbe_d[g_detail_idx].mmbe001,g_mmbe_d[g_detail_idx].mmbe002, 
                  g_mmbe_d[g_detail_idx].mmbe003,g_mmbe_d[g_detail_idx].mmbe006,g_mmbe_d[g_detail_idx].mmbe005, 
                  g_mmbe_d[g_detail_idx].mmbeunit) 
         WHERE mmbeent = g_enterprise AND mmbedocno = ps_keys_bak[1] AND mmbeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt410_mmbe_t_mask_restore('restore_mask_n')
               
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
 
{<section id="ammt410.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammt410_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt410.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammt410_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt410.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt410_lock_b(ps_table,ps_page)
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
   #CALL ammt410_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmbe_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt410_bcl USING g_enterprise,
                                       g_mmbd_m.mmbddocno,g_mmbe_d[g_detail_idx].mmbeseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt410_bcl:",SQLERRMESSAGE 
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
 
{<section id="ammt410.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt410_unlock_b(ps_table,ps_page)
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
      CLOSE ammt410_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt410_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mmbddocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmbddocno",TRUE)
      CALL cl_set_comp_entry("mmbddocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mmbdsite",TRUE)
      CALL cl_set_comp_entry("mmbddocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mmbddsite",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmbddocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      IF NOT ammt410_mmbdsite_chk() THEN
         CALL cl_set_comp_entry("mmbdsite",FALSE)  
      END IF
      CALL cl_set_comp_entry("mmbddocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mmbddocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mmbddocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_copy_flag = 'r' THEN
      CALL cl_set_comp_entry("mmbdsite",FALSE)
      LET g_copy_flag = 'a'
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt410_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mmbdsite",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt410_set_no_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mmbddocno,mmbddocdt",FALSE)
   IF NOT ammt410_mmbdsite_chk() THEN
      CALL cl_set_comp_entry("mmbdsite",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt410_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt410_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mmbd_m.mmbdstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   IF cl_null(g_argv[1]) THEN
      CALL cl_set_act_visible("insert,modify,delete,modify_detail,reproduce", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammt410_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammt410_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt410_default_search()
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
      LET ls_wc = ls_wc, " mmbddocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " mmbddocno = '", g_argv[02], "' AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "mmbd_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmbe_t" 
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
      LET g_wc = g_wc, " AND mmbd000 = '",g_argv[1], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt410.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt410_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_errno      LIKE type_t.chr10
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_mmbe001    LIKE mmbe_t.mmbe001
   DEFINE l_mmbesite   LIKE mmbe_t.mmbesite
   DEFINE l_mmbddocno  LIKE mmbd_t.mmbddocno
   DEFINE l_msg        STRING
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF (g_argv[1] MATCHES '[5869]' AND g_mmbd_m.mmbdstus = 'Y') OR g_mmbd_m.mmbdstus = 'X' OR g_mmbe_d.getLength() < 1 THEN
      RETURN 
   END IF
   IF cl_null(g_argv[1]) THEN RETURN END IF
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmbd_m.mmbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt410_cl USING g_enterprise,g_mmbd_m.mmbddocno
   IF STATUS THEN
      CLOSE ammt410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
       g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001,g_mmbd_m.mmbdstus, 
       g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt,g_mmbd_m.mmbdsite_desc, 
       g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc, 
       g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt410_action_chk() THEN
      CLOSE ammt410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdsite_desc,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt, 
       g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001,g_mmbd_m.mmbd001_desc, 
       g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdowndp_desc, 
       g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtid_desc,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdcrtdt, 
       g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfid_desc, 
       g_mmbd_m.mmbdcnfdt
 
   CASE g_mmbd_m.mmbdstus
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
         CASE g_mmbd_m.mmbdstus
            
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
         CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_mmbd_m.mmbdstus
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
            
         WHEN "Y"
            HIDE OPTION "open"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN
            
         WHEN "X"
            HIDE OPTION "open"
            HIDE OPTION "confirmed"
            CALL s_transaction_end('N','0')  #160816-00068#4 add
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
            IF NOT ammt410_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt410_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT ammt410_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt410_cl
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
      g_mmbd_m.mmbdstus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
     
   DECLARE mmbe_curs CURSOR FOR 
      SELECT mmbe001,mmbesite FROM mmbe_t WHERE mmbeent = g_enterprise 
          AND mmbedocno = g_mmbd_m.mmbddocno
   FOREACH  mmbe_curs INTO l_mmbe001,l_mmbesite
      IF lc_state = 'N' THEN
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM mmbe_t,mmbd_t WHERE mmbeent = g_enterprise
            AND mmbe001 = l_mmbe001 AND mmbdent = mmbeent 
            AND mmbedocno = mmbddocno AND mmbdstus = 'N'
         IF l_n > 0 THEN  
            CALL ammt410_unconf_only(l_mmbe001) RETURNING l_mmbddocno,l_msg
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00110'
            LET g_errparam.extend = l_mmbe001
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_mmbddocno
            LET g_errparam.replace[2] = l_msg
            CALL cl_err()
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN 
         END IF
       END IF
       IF lc_state = 'Y' THEN
          IF NOT ammt410_cnf_mmbe_chk(l_mmbe001,l_mmbesite) THEN
             CALL s_transaction_end('N','0')  #160816-00068#4 add
             RETURN
          END IF
       END IF
   END FOREACH
   
   CASE lc_state
      WHEN 'Y'
         
         CASE g_argv[1]
            WHEN '3'
               IF NOT ammt410_ammt411_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
            WHEN '4'
               IF NOT ammt410_ammt412_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
            WHEN '5'
               IF NOT ammt410_ammt413_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
            WHEN '6'
               IF NOT ammt410_ammt415_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
            WHEN '7'
               IF NOT ammt410_ammt417_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
            WHEN '8'
               IF NOT ammt410_ammt414_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
            WHEN '9'
               IF NOT ammt410_ammt416_conf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN 
               END IF
         END CASE
      WHEN 'N'
         CASE g_argv[1]
            WHEN '3'
               IF NOT ammt410_ammt411_unconf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '4'
               IF NOT ammt410_ammt412_unconf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '7'
               IF NOT ammt410_ammt417_unconf() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
         END CASE
      WHEN 'X'
         CASE g_argv[1]
            WHEN '3'
               IF NOT ammt410_ammt411_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '4'
               IF NOT ammt410_ammt412_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '5'
               IF NOT ammt410_ammt413_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '6'
               IF NOT ammt410_ammt415_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '7'
               IF NOT ammt410_ammt417_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '8'
               IF NOT ammt410_ammt414_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
            WHEN '9'
               IF NOT ammt410_ammt416_void() THEN
                  CALL s_transaction_end('N','0')  #160816-00068#4 add
                  RETURN
               END IF
         END CASE
   END CASE
   #end add-point
   
   LET g_mmbd_m.mmbdmodid = g_user
   LET g_mmbd_m.mmbdmoddt = cl_get_current()
   LET g_mmbd_m.mmbdstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmbd_t 
      SET (mmbdstus,mmbdmodid,mmbdmoddt) 
        = (g_mmbd_m.mmbdstus,g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt)     
    WHERE mmbdent = g_enterprise AND mmbddocno = g_mmbd_m.mmbddocno
 
    
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
      EXECUTE ammt410_master_referesh USING g_mmbd_m.mmbddocno INTO g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite, 
          g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt,g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd001, 
          g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtdp, 
          g_mmbd_m.mmbdcrtdt,g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfdt, 
          g_mmbd_m.mmbdsite_desc,g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001_desc,g_mmbd_m.mmbdownid_desc, 
          g_mmbd_m.mmbdowndp_desc,g_mmbd_m.mmbdcrtid_desc,g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdmodid_desc, 
          g_mmbd_m.mmbdcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmbd_m.mmbd000,g_mmbd_m.mmbdsite,g_mmbd_m.mmbdsite_desc,g_mmbd_m.mmbdunit,g_mmbd_m.mmbddocdt, 
          g_mmbd_m.mmbddocno,g_mmbd_m.mmbd002,g_mmbd_m.mmbd002_desc,g_mmbd_m.mmbd001,g_mmbd_m.mmbd001_desc, 
          g_mmbd_m.mmbdstus,g_mmbd_m.mmbdownid,g_mmbd_m.mmbdownid_desc,g_mmbd_m.mmbdowndp,g_mmbd_m.mmbdowndp_desc, 
          g_mmbd_m.mmbdcrtid,g_mmbd_m.mmbdcrtid_desc,g_mmbd_m.mmbdcrtdp,g_mmbd_m.mmbdcrtdp_desc,g_mmbd_m.mmbdcrtdt, 
          g_mmbd_m.mmbdmodid,g_mmbd_m.mmbdmodid_desc,g_mmbd_m.mmbdmoddt,g_mmbd_m.mmbdcnfid,g_mmbd_m.mmbdcnfid_desc, 
          g_mmbd_m.mmbdcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammt410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt410_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt410.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammt410_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmbe_d.getLength() THEN
         LET g_detail_idx = g_mmbe_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbe_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbe_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt410_b_fill2(pi_idx)
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
   
   CALL ammt410_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt410_fill_chk(ps_idx)
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
 
{<section id="ammt410.status_show" >}
PRIVATE FUNCTION ammt410_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt410.mask_functions" >}
&include "erp/amm/ammt410_mask.4gl"
 
{</section>}
 
{<section id="ammt410.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION ammt410_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL ammt410_show()
   CALL ammt410_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmbd_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmbe_d))
 
 
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
   #CALL ammt410_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt410_ui_headershow()
   CALL ammt410_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION ammt410_draw_out()
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
   CALL ammt410_ui_headershow()  
   CALL ammt410_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="ammt410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt410_set_pk_array()
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
   LET g_pk_array[1].values = g_mmbd_m.mmbddocno
   LET g_pk_array[1].column = 'mmbddocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt410.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammt410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt410_msgcentre_notify(lc_state)
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
   CALL ammt410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmbd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt410.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt410_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#23 add-S
   SELECT mmbdstus  INTO g_mmbd_m.mmbdstus
     FROM mmbd_t
    WHERE mmbdent = g_enterprise
      AND mmbddocno = g_mmbd_m.mmbddocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mmbd_m.mmbdstus
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
        LET g_errparam.extend = g_mmbd_m.mmbddocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt410_set_act_visible()
        CALL ammt410_set_act_no_visible()
        CALL ammt410_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#23 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt410.other_function" readonly="Y" >}
#+ ammt416 取消凍結審核處理
PRIVATE FUNCTION ammt410_ammt416_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt416_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt416_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt417 註銷審核處理
PRIVATE FUNCTION ammt410_ammt417_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt417_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt417_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+
PRIVATE FUNCTION ammt410_mmbe001_chk(p_mmbe001,p_mmbesite)
DEFINE l_sql          STRING
DEFINE l_errno        STRING
DEFINE l_n            LIKE type_t.num5
DEFINE l_mmbddocno    LIKE mmbd_t.mmbddocno
DEFINE l_msg          STRING
DEFINE p_mmbe001      LIKE mmbe_t.mmbe001
DEFINE p_mmbesite     LIKE mmbe_t.mmbesite
DEFINE l_mman042      LIKE mman_t.mman042     #add by yangxf 

   LET l_sql = "SELECT COUNT(*) FROM mmaq_t WHERE mmaqent='",g_enterprise CLIPPED,"' AND mmaq001=?"
   
   
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM mmbe_t,mmbd_t WHERE mmbeent = g_enterprise
      AND mmbe001 = p_mmbe001 AND mmbdent = mmbeent 
      AND mmbedocno = mmbddocno  AND mmbddocno = g_mmbd_m.mmbddocno AND mmbdstus = 'N'
   IF l_n > 0 THEN  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00069'
      LET g_errparam.extend = p_mmbe001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM mmbe_t,mmbd_t WHERE mmbeent = g_enterprise
      AND mmbe001 = p_mmbe001 AND mmbdent = mmbeent 
      AND mmbedocno = mmbddocno AND mmbdstus = 'N'
   IF l_n > 0 THEN  
      CALL ammt410_unconf_only(p_mmbe001) RETURNING l_mmbddocno,l_msg
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00096'
      LET g_errparam.extend = p_mmbe001
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_mmbddocno
      LET g_errparam.replace[2] = l_msg
      CALL cl_err()

    # CALL cl_err(p_mmbe001,'amm-00096',1)
      RETURN FALSE
   END IF

   
   IF NOT ap_chk_isExist(p_mmbe001,l_sql,'amm-00005',1) THEN
      RETURN FALSE
   END IF

   CASE WHEN g_argv[1]='3'
           LET l_sql = l_sql," AND mmaq006 = '2'"
           LET l_errno = 'amm-00048'
        WHEN g_argv[1]='4'
           LET l_sql = l_sql," AND mmaq006 = '1'" 
           LET l_errno = 'amm-00049'
        WHEN g_argv[1] MATCHES '[56]'
           LET l_sql = l_sql," AND mmaq006 IN ('2','3')"
           LET l_errno = 'amm-00050'
        WHEN g_argv[1]='8'
           LET l_sql = l_sql," AND mmaq006 = '5'"
           LET l_errno = 'amm-00051'
        WHEN g_argv[1]='9'
           LET l_sql = l_sql," AND mmaq006 = '6'"
           LET l_errno = 'amm-00052'
        WHEN g_argv[1]='7'
           LET l_sql = l_sql," AND mmaq006 IN ('2','3','5')"
           LET l_errno = 'amm-00053'
   END CASE
   
   IF NOT ap_chk_isExist(p_mmbe001,l_sql,l_errno,1) THEN
      RETURN FALSE
   END IF
   IF g_argv[1] = '1' THEN
      LET l_sql = "SELECT COUNT(*) FROM mmaq_t,mman_t WHERE mmaqent='",g_enterprise CLIPPED,"'",
                  " AND mmaq001=? AND mmaq006 = '2' AND mman016='Y' AND mmanent=mmaqent AND mman001=mmaq002 "
      IF NOT ap_chk_isExist(p_mmbe001,l_sql,'amm-00056',1) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_argv[1] = '4' AND NOT cl_null(p_mmbesite) THEN
      LET l_sql = l_sql," AND mmaq020 = '",p_mmbesite CLIPPED,"'"
      IF NOT ap_chk_isExist(p_mmbe001,l_sql,'amm-00054',1) THEN
         RETURN FALSE
      END IF
   END IF
   #add by yangxf ---start----#判断此卡是否为储值卡，若是则提示若要佔註銷儲值卡請於 ammt426 進行維護作業
   IF g_argv[1] = '7' THEN 
      SELECT mman042 INTO l_mman042
        FROM mmaq_t,mman_t 
       WHERE mmaqent = g_enterprise AND mmaq001 = g_mmbe_d[l_ac].mmbe001
         AND mmanent = mmaqent AND mman001 = mmaq002 
      IF l_mman042 = 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00469'
         LET g_errparam.extend = g_mmbe_d[l_ac].mmbe001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF 
   END IF 
   #add by yangxf ----end-----
   RETURN TRUE
END FUNCTION
#+ ammt414 取消掛失審核處理
PRIVATE FUNCTION ammt410_ammt414_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt414_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt414_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt415 凍結審核處理
PRIVATE FUNCTION ammt410_ammt415_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt415_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt415_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ 營運據點名稱
PRIVATE FUNCTION ammt410_mmbdsite_desc()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbd_m.mmbdsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbd_m.mmbdsite_desc =  g_rtn_fields[1]
      DISPLAY BY NAME g_mmbd_m.mmbdsite_desc
END FUNCTION
#+
PRIVATE FUNCTION ammt410_mmbdsite_chk()
DEFINE l_n    LIKE type_t.num5
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM mmbe_t
    WHERE mmbeent = g_enterprise 
      AND mmbedocno = g_mmbd_m.mmbddocno
   IF l_n > 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ 維護完會員卡號後帶出後面欄位值
PRIVATE FUNCTION ammt410_mmbe001_desc()
#DEFINE l_mman    RECORD LIKE mman_t.* #161111-00028#1--mark
#161111-00028#1----add------begin---------------------
DEFINE l_mman RECORD  #會員卡種資料檔
       mmanent LIKE mman_t.mmanent, #企業編號
       mmanunit LIKE mman_t.mmanunit, #應用組織
       mman001 LIKE mman_t.mman001, #卡種編號
       mman002 LIKE mman_t.mman002, #版本
       mman003 LIKE mman_t.mman003, #外社卡
       mman004 LIKE mman_t.mman004, #no use
       mman005 LIKE mman_t.mman005, #卡號總碼長
       mman006 LIKE mman_t.mman006, #卡號固定編號長度
       mman007 LIKE mman_t.mman007, #卡號固定編號
       mman008 LIKE mman_t.mman008, #卡號流水碼長度
       mman009 LIKE mman_t.mman009, #發卡方式
       mman010 LIKE mman_t.mman010, #消費附贈最低消費金額
       mman011 LIKE mman_t.mman011, #購卡金額
       mman012 LIKE mman_t.mman012, #發卡贈品商品編號
       mman013 LIKE mman_t.mman013, #換卡工本費
       mman014 LIKE mman_t.mman014, #補卡工本費
       mman015 LIKE mman_t.mman015, #卡記名
       mman016 LIKE mman_t.mman016, #使用時需開卡
       mman017 LIKE mman_t.mman017, #卡需設定密碼
       mman018 LIKE mman_t.mman018, #卡效期控管
       mman019 LIKE mman_t.mman019, #效期規則起算基準
       mman020 LIKE mman_t.mman020, #有效期至
       mman021 LIKE mman_t.mman021, #效期指定日期
       mman022 LIKE mman_t.mman022, #效期指定月份長度
       mman023 LIKE mman_t.mman023, #卡效期延長
       mman024 LIKE mman_t.mman024, #效期延長月份長度
       mman025 LIKE mman_t.mman025, #效期延長次數
       mman026 LIKE mman_t.mman026, #會員折扣
       mman027 LIKE mman_t.mman027, #積點
       mman028 LIKE mman_t.mman028, #預設積點基準單位
       mman029 LIKE mman_t.mman029, #預設積點基準
       mman030 LIKE mman_t.mman030, #預設單位積點
       mman031 LIKE mman_t.mman031, #積點清零規則
       mman032 LIKE mman_t.mman032, #積點月後清零
       mman033 LIKE mman_t.mman033, #積點日後清零
       mman034 LIKE mman_t.mman034, #積點指定清零日期-月
       mman035 LIKE mman_t.mman035, #積點指定清零日期-日
       mman036 LIKE mman_t.mman036, #積點取位
       mman037 LIKE mman_t.mman037, #取位方法
       mman038 LIKE mman_t.mman038, #積點抵現
       mman039 LIKE mman_t.mman039, #預設最低抵現消費額
       mman040 LIKE mman_t.mman040, #預設抵現積點基準
       mman041 LIKE mman_t.mman041, #預設抵現單位金額
       mman042 LIKE mman_t.mman042, #可儲值
       mman043 LIKE mman_t.mman043, #可重複儲值
       mman044 LIKE mman_t.mman044, #每次儲值金額上限
       mman045 LIKE mman_t.mman045, #每次儲值金額下限
       mman046 LIKE mman_t.mman046, #最高總儲值金額
       mman047 LIKE mman_t.mman047, #儲值折扣
       mman048 LIKE mman_t.mman048, #預設儲值折扣率
       mman049 LIKE mman_t.mman049, #儲值加值
       mman050 LIKE mman_t.mman050, #預設加值最低金額條件
       mman051 LIKE mman_t.mman051, #預設加值儲值金額基準
       mman052 LIKE mman_t.mman052, #預設單位加值金額
       mman053 LIKE mman_t.mman053, #卡種對應商品編號
       mman054 LIKE mman_t.mman054, #儲值金額對應商品編號
       mman055 LIKE mman_t.mman055, #預設抵現上限比例
       mman056 LIKE mman_t.mman056, #預設抵現上限金額
       mman057 LIKE mman_t.mman057, #積點抵現對應款別編號
       mman058 LIKE mman_t.mman058, #儲值對應款別編號
       mman059 LIKE mman_t.mman059, #卡異動明細產生方式
       mman060 LIKE mman_t.mman060, #積分對應商品編號
       mmanstus LIKE mman_t.mmanstus, #狀態碼
       mmanownid LIKE mman_t.mmanownid, #資料所有者
       mmanowndp LIKE mman_t.mmanowndp, #資料所有部門
       mmancrtid LIKE mman_t.mmancrtid, #資料建立者
       mmancrtdp LIKE mman_t.mmancrtdp, #資料建立部門
       mmancrtdt LIKE mman_t.mmancrtdt, #資料創建日
       mmanmodid LIKE mman_t.mmanmodid, #資料修改者
       mmanmoddt LIKE mman_t.mmanmoddt, #最近修改日
       mmancnfid LIKE mman_t.mmancnfid, #資料確認者
       mmancnfdt LIKE mman_t.mmancnfdt, #資料確認日
       mman061 LIKE mman_t.mman061, #銷售認列方式
       mman062 LIKE mman_t.mman062, #會員價
       mman063 LIKE mman_t.mman063, #會員價選擇
       mman064 LIKE mman_t.mman064, #預設折扣率
       mman065 LIKE mman_t.mman065, #儲值付款單次使用否
       mman066 LIKE mman_t.mman066, #卡類型
       mman067 LIKE mman_t.mman067, #特價積點基準
       mman068 LIKE mman_t.mman068, #特價單位積點
       mman069 LIKE mman_t.mman069, #記名累計金額
       mman070 LIKE mman_t.mman070, #用卡支付積分否
       mman071 LIKE mman_t.mman071, #加值類型
       mman072 LIKE mman_t.mman072, #與其他卡種同時使用否
       mman073 LIKE mman_t.mman073 #參加促銷金額否
       END RECORD
#161111-00028#1----add----end-------------------------
DEFINE l_mmaq021 LIKE mmaq_t.mmaq021
DEFINE l_mmaq023 LIKE mmaq_t.mmaq023
DEFINE l_mmaq025 LIKE mmaq_t.mmaq025
   SELECT mmaq002,mmanl003,mmaq003,mmaf008,mmaq005,mmaq006,mmaq021,mmaq023,mmaq025
     INTO g_mmbe_d[l_ac].mmbe002,g_mmbe_d[l_ac].mmbe002_desc,g_mmbe_d[l_ac].mmbe003,g_mmbe_d[l_ac].mmbe003_desc,
          g_mmbe_d[l_ac].mmbe006,g_mmbe_d[l_ac].mmbe005,l_mmaq021,l_mmaq023,l_mmaq025
     #FROM mmaq_t LEFT OUTER JOIN mmaf_t  ON  mmafent = g_enterprise AND mmaf001 = mmaq002    #150525-00013#1
      FROM mmaq_t LEFT OUTER JOIN mmaf_t  ON  mmafent = g_enterprise AND mmaf001 = mmaq003    
                 LEFT OUTER JOIN mmanl_t ON mmanlent = g_enterprise AND mmanl001 = mmaq002 AND mmanl002 = g_dlang
                 LEFT OUTER JOIN mman_t  ON  mmanent = g_enterprise AND mman001 = mmaq002 
    WHERE mmaqent = g_enterprise AND mmaq001 = g_mmbe_d[l_ac].mmbe001
   IF g_argv[1] = '3' THEN                     #ammt411邏輯
      # SELECT * INTO l_mman.* FROM mman_t  #161111-00028#1--MARK
        SELECT mman001,mman018 INTO l_mman.mman001,l_mman.mman018 FROM mman_t   #161111-00028#1--add
        WHERE mmanent = g_enterprise
          AND mman001 = g_mmbe_d[l_ac].mmbe002
       IF l_mman.mman018 = 'N' THEN            #當[C:卡效期控管]='N'時表示不控管效期
          LET g_mmbe_d[l_ac].mmbe006 = ''
       ELSE     
          CALL s_ammt320_create_date(l_mman.mman001,g_mmbd_m.mmbddocdt) RETURNING  g_mmbe_d[l_ac].mmbe006    
       END IF
   END IF  
   DISPLAY BY NAME g_mmbe_d[l_ac].mmbe002,g_mmbe_d[l_ac].mmbe002_desc,g_mmbe_d[l_ac].mmbe003,g_mmbe_d[l_ac].mmbe003_desc,
                   g_mmbe_d[l_ac].mmbe006,g_mmbe_d[l_ac].mmbe005
END FUNCTION
#+ ammt411 開卡取消審核處理
PRIVATE FUNCTION ammt410_ammt411_unconf()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt411_unconf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt411_unconf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE   
END FUNCTION
#+ ammt411 開卡审核处理
PRIVATE FUNCTION ammt410_ammt411_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt411_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt411_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#ammt412 作廢審核處理
PRIVATE FUNCTION ammt410_ammt412_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt412_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt412_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt413 掛失審核處理
PRIVATE FUNCTION ammt410_ammt413_conf()
DEFINE l_success    LIKE type_t.num5
DEFINE l_errno      LIKE type_t.chr10
   CALL s_ammt413_conf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt413_conf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt412 作廢取消審核處理
PRIVATE FUNCTION ammt410_ammt412_unconf()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt412_unconf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt412_unconf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE 
END FUNCTION
#+ ammt417 註銷取消審核處理
PRIVATE FUNCTION ammt410_ammt417_unconf()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt417_unconf_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('amm-00073') THEN
         CALL s_transaction_begin()
         CALL s_ammt417_unconf_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE 
END FUNCTION
#+ ammt411 開卡單作廢
PRIVATE FUNCTION ammt410_ammt411_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt411_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt411_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE 
END FUNCTION
#+ ammt412 作廢單作廢
PRIVATE FUNCTION ammt410_ammt412_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt412_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt412_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE 
END FUNCTION
#+ ammt413 掛失單作廢
PRIVATE FUNCTION ammt410_ammt413_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt413_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt413_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt414 取消掛失單作廢
PRIVATE FUNCTION ammt410_ammt414_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt414_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt414_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt415 凍結單作廢
PRIVATE FUNCTION ammt410_ammt415_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt415_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt415_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt415 取消凍結單作廢
PRIVATE FUNCTION ammt410_ammt416_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt416_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt416_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ ammt417 註銷單作廢
PRIVATE FUNCTION ammt410_ammt417_void()
DEFINE l_success  LIKE type_t.num5
DEFINE l_errno    LIKE type_t.chr10
   CALL s_ammt417_void_chk(g_mmbd_m.mmbddocno,g_mmbd_m.mmbdstus) RETURNING l_success,l_errno
   IF l_success THEN
      IF cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_begin()
         CALL s_ammt417_void_upd(g_mmbd_m.mmbddocno) RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
            RETURN FALSE
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE   
         RETURN FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_mmbd_m.mmbddocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+
PRIVATE FUNCTION ammt410_mmbddocno_chk(p_cmd,p_mmbddocno)
DEFINE p_cmd         LIKE type_t.chr1
DEFINE l_oobl002     LIKE oobl_t.oobl002
DEFINE p_mmbddocno   LIKE mmbd_t.mmbddocno
DEFINE l_ooef004     LIKE ooef_t.ooef004
   
   IF p_cmd = 'a' OR (p_cmd = 'u' AND p_mmbddocno != g_mmbddocno_t ) THEN 
      IF NOT ap_chk_notDup(p_mmbddocno,"SELECT COUNT(*) FROM mmbd_t WHERE "||"mmbdent = " ||g_enterprise|| " AND "||"mmbddocno = '"||p_mmbddocno ||"'",'std-00004',1) THEN 
         RETURN FALSE
      END IF
      CASE g_argv[1]
         WHEN '3'
            LET l_oobl002 = 'ammt411' 
         WHEN '4'
            LET l_oobl002 = 'ammt412'
         WHEN '5'
            LET l_oobl002 = 'ammt413'
         WHEN '8'
            LET l_oobl002 = 'ammt414'
         WHEN '6'
            LET l_oobl002 = 'ammt415'
         WHEN '9'
            LET l_oobl002 = 'ammt416'
         WHEN '7'
            LET l_oobl002 = 'ammt417'
      END CASE
#      IF NOT ap_chk_isExist(p_mmbddocno,"SELECT COUNT(*) FROM ooba_t,oobl_t WHERE oobaent='"||g_enterprise||"' AND ooba001='"||l_ooef004||"' AND ooba002=? AND ooblent ="||g_enterprise||" AND oobl001='"||p_mmbddocno||"' AND oobl002='"||l_oobl002||"'",'aim-00056',1) THEN
#         RETURN FALSE
#      END IF
#      
#      IF NOT ap_chk_isExist(p_mmbddocno,"SELECT COUNT(*) FROM ooba_t,oobl_t WHERE oobaent='"||g_enterprise||"' AND ooba001='"||l_ooef004||"' AND ooba002=? AND ooblent ="||g_enterprise||" AND oobl001='"||p_mmbddocno||"' AND oobl002='"||l_oobl002||"' AND oobastus='Y'",'sub-01302','aooi200') THEN
#         RETURN FALSE
#      END IF
       IF NOT s_aooi200_chk_slip(g_site,'',p_mmbddocno,l_oobl002) THEN
          RETURN FALSE
       END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION ammt410_mmbdsite(p_mmbdsite)
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1    LIKE type_t.num5 
   DEFINE p_mmbdsite LIKE mmbd_t.mmbdsite
   DEFINE l_sql     STRING
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   LET l_sql="SELECT COUNT(*)  FROM ooed_t WHERE ooed004 ='",p_mmbdsite,"' AND ooed001='2' ",
             "   AND ooedent=",g_enterprise, #160905-00007#6 add
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null) ",
             "   AND ooed004 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_site,"' CONNECT BY  NOCYCLE PRIOR ooed004=ooed005 AND ooed001='2' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
#             "         (SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"'))" #160905-00007#6 mark
             "         (SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise," AND ooed004='",g_site,"'))" #160905-00007#6 add
   PREPARE l_sql_ooea_pre1 FROM l_sql
   EXECUTE l_sql_ooea_pre1 INTO l_cnt   
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00163"
   ELSE
      LET l_sql="SELECT COUNT(*)  FROM ooed_t,ooea_t WHERE ooea001=ooed004 AND ooed004 ='",p_mmbdsite,"' AND ooed001='2' AND ooeastus='Y' ",
             "   AND ooeaent=ooedent AND ooedent=",g_enterprise, #160905-00007#6 add
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
             "   AND ooea001 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_site,"' CONNECT BY  NOCYCLE PRIOR ooed004=ooed005 AND ooed001='2' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
#             "         (SELECT ooea001 FROM ooea_t WHERE ooea001='",g_site,"'))" #160905-00007#6 mark
             "         (SELECT ooea001 FROM ooea_t WHERE ooeaent=",g_enterprise," ANND ooea001='",g_site,"'))" #160905-00007#6 add
      PREPARE l_sql_ooea_pre2 FROM l_sql
      EXECUTE l_sql_ooea_pre2 INTO l_cnt1       
      IF l_cnt1 <= 0 THEN
         LET g_errno = 'sub-01302'  #160318-00005#24 mod  #"amm-00007"
      END IF         
   END IF
END FUNCTION

PRIVATE FUNCTION ammt410_mmbesite_desc(p_mmbesite)
DEFINE p_mmbesite    LIKE mmbe_t.mmbesite
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mmbesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbe_d[l_ac].mmbesite_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmbe_d[l_ac].mmbesite_desc
END FUNCTION

PRIVATE FUNCTION ammt410_mmbesite_chk(p_mmbesite)
DEFINE p_mmbesite    LIKE mmbe_t.mmbesite
DEFINE   l_cnt       LIKE type_t.num5
DEFINE   l_ooeastus  LIKE ooea_t.ooeastus
DEFINE   l_ooea004   LIKE ooea_t.ooea004
DEFINE   l_sql       STRING
   LET g_errno = NULL
   LET l_cnt = 0
   SELECT ooea004,ooeastus INTO l_ooea004,l_ooeastus
     FROM ooea_t WHERE ooea001 = p_mmbesite AND ooeaent = g_enterprise
     
   CASE WHEN SQLCA.SQLCODE = 100       LET g_errno = 'aim-00060'
        WHEN l_ooeastus='N'            LET g_errno = 'aoo-00012'      
        WHEN l_ooea004 = 'N'           LET g_errno = 'amm-00059'        
   END CASE     
   IF NOT cl_null(g_errno) THEN
      RETURN
   END IF
   LET l_sql = " SELECT COUNT(ooed004) FROM ooed_t where ooed004 = '",p_mmbesite ,"'",
               "  AND ooedent = ",g_enterprise, #160905-00007#6 add
               "  START WITH ooed004 = '",g_mmbd_m.mmbdsite ,"'",
               "  CONNECT BY NOCYCLE PRIOR ooed004 = ooed005  " 
   PREPARE ooed_pre FROM l_sql
   EXECUTE ooed_pre INTO l_cnt   
   IF l_cnt = 0 THEN
      LET g_errno = "amm-00089"
      RETURN
   END IF  
END FUNCTION

PRIVATE FUNCTION ammt410_unconf_only(p_mmbe001)
DEFINE p_mmbe001    LIKE mmbe_t.mmbe001
DEFINE l_mmbddocno  LIKE mmbd_t.mmbddocno
DEFINE l_mmbd000    LIKE mmbd_t.mmbd000
DEFINE l_msg        STRING
         SELECT mmbddocno,mmbd000 INTO l_mmbddocno,l_mmbd000 FROM mmbe_t,mmbd_t WHERE mmbeent = g_enterprise
            AND mmbe001 = p_mmbe001 AND mmbdent = mmbeent 
            AND mmbedocno = mmbddocno AND mmbdstus = 'N' 
         CASE l_mmbd000 
            WHEN '3' LET l_msg = cl_getmsg('amm-00145',g_lang) 
            WHEN '4' LET l_msg = cl_getmsg('amm-00146',g_lang) 
            WHEN '5' LET l_msg = cl_getmsg('amm-00147',g_lang)    
            WHEN '6' LET l_msg = cl_getmsg('amm-00149',g_lang)  
            WHEN '7' LET l_msg = cl_getmsg('amm-00151',g_lang)  
            WHEN '8' LET l_msg = cl_getmsg('amm-00148',g_lang)  
            WHEN '9' LET l_msg = cl_getmsg('amm-00150',g_lang)  
         END CASE
         RETURN l_mmbddocno,l_msg
END FUNCTION

PRIVATE FUNCTION ammt410_cnf_mmbe_chk(p_mmbe001,p_mmbesite)
DEFINE l_sql          STRING
DEFINE l_errno        STRING
DEFINE l_n            LIKE type_t.num5
DEFINE l_mmbddocno    LIKE mmbd_t.mmbddocno
DEFINE l_msg          STRING
DEFINE p_mmbe001      LIKE mmbe_t.mmbe001
DEFINE p_mmbesite     LIKE mmbe_t.mmbesite
   LET l_sql = "SELECT COUNT(*) FROM mmaq_t WHERE mmaqent='",g_enterprise CLIPPED,"' AND mmaq001=?"
   
   IF NOT ap_chk_isExist(p_mmbe001,l_sql,'amm-00005',1) THEN
      RETURN FALSE
   END IF

   CASE WHEN g_argv[1]='3'
           LET l_sql = l_sql," AND mmaq006 = '2'"
           LET l_errno = 'amm-00048'
        WHEN g_argv[1]='4'
           LET l_sql = l_sql," AND mmaq006 = '1'" 
           LET l_errno = 'amm-00049'
        WHEN g_argv[1] MATCHES '[56]'
           LET l_sql = l_sql," AND mmaq006 IN ('2','3')"
           LET l_errno = 'amm-00050'
        WHEN g_argv[1]='8'
           LET l_sql = l_sql," AND mmaq006 = '5'"
           LET l_errno = 'amm-00051'
        WHEN g_argv[1]='9'
           LET l_sql = l_sql," AND mmaq006 = '6'"
           LET l_errno = 'amm-00052'
        WHEN g_argv[1]='7'
           LET l_sql = l_sql," AND mmaq006 IN ('2','3','5')"
           LET l_errno = 'amm-00053'
   END CASE
   
   IF NOT ap_chk_isExist(p_mmbe001,l_sql,l_errno,1) THEN
      RETURN FALSE
   END IF
   IF g_argv[1] = '1' THEN
      LET l_sql = "SELECT COUNT(*) FROM mmaq_t,mman_t WHERE mmaqent='",g_enterprise CLIPPED,"'",
                  " AND mmaq001=? AND mmaq006 = '2' AND mman016='Y' AND mmanent=mmaqent AND mman001=mmaq002 "
      IF NOT ap_chk_isExist(p_mmbe001,l_sql,'amm-00056',1) THEN
         RETURN FALSE
      END IF
   END IF
   IF g_argv[1] = '4' AND NOT cl_null(p_mmbesite) THEN
      LET l_sql = l_sql," AND mmaq020 = '",p_mmbesite CLIPPED,"'"
      IF NOT ap_chk_isExist(p_mmbe001,l_sql,'amm-00054',1) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

 
{</section>}
 
