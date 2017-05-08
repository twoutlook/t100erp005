#該程式未解開Section, 採用最新樣板產出!
{<section id="amrt310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-06-03 18:22:21), PR版次:0008(2016-08-26 09:31:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000078
#+ Filename...: amrt310
#+ Description: 資源維修工單報工作業
#+ Creator....: 04441(2014-12-23 16:26:25)
#+ Modifier...: 05384 -SD/PR- 08734
 
{</section>}
 
{<section id="amrt310.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#24  2016/04/25 BY 07900     校验代码重复错误讯息的修改
#160524-00044#4   2016/06/03 By shiun     修改欄位預設
#160716-00005#1   2016/08/07 By Sarah     維護料號秏用裡的料號輸入後，請帶出據點的發料單位
#160812-00017#5 16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#24 2016-08-24 By 08734 删除修改未重新判断状态码
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
PRIVATE type type_g_mrdj_m        RECORD
       mrdjdocno LIKE mrdj_t.mrdjdocno, 
   mrdjdocno_desc LIKE type_t.chr80, 
   mrdjdocdt LIKE mrdj_t.mrdjdocdt, 
   mrdjsite LIKE mrdj_t.mrdjsite, 
   mrdj001 LIKE mrdj_t.mrdj001, 
   mrdj001_desc LIKE type_t.chr80, 
   mrdj002 LIKE mrdj_t.mrdj002, 
   mrdj002_desc LIKE type_t.chr80, 
   mrdjstus LIKE mrdj_t.mrdjstus, 
   mrdj003 LIKE mrdj_t.mrdj003, 
   mrdjownid LIKE mrdj_t.mrdjownid, 
   mrdjownid_desc LIKE type_t.chr80, 
   mrdjowndp LIKE mrdj_t.mrdjowndp, 
   mrdjowndp_desc LIKE type_t.chr80, 
   mrdjcrtid LIKE mrdj_t.mrdjcrtid, 
   mrdjcrtid_desc LIKE type_t.chr80, 
   mrdjcrtdp LIKE mrdj_t.mrdjcrtdp, 
   mrdjcrtdp_desc LIKE type_t.chr80, 
   mrdjcrtdt LIKE mrdj_t.mrdjcrtdt, 
   mrdjmodid LIKE mrdj_t.mrdjmodid, 
   mrdjmodid_desc LIKE type_t.chr80, 
   mrdjmoddt LIKE mrdj_t.mrdjmoddt, 
   mrdjcnfid LIKE mrdj_t.mrdjcnfid, 
   mrdjcnfid_desc LIKE type_t.chr80, 
   mrdjcnfdt LIKE mrdj_t.mrdjcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrdk_d        RECORD
       mrdksite LIKE mrdk_t.mrdksite, 
   mrdkseq LIKE mrdk_t.mrdkseq, 
   mrdk001 LIKE mrdk_t.mrdk001, 
   mrdk002 LIKE mrdk_t.mrdk002, 
   mrdk002_desc LIKE type_t.chr500, 
   mrdk003 LIKE mrdk_t.mrdk003, 
   mrdk004 LIKE mrdk_t.mrdk004, 
   mrdk005 LIKE mrdk_t.mrdk005, 
   mrdk006 LIKE mrdk_t.mrdk006, 
   mrdk007 LIKE mrdk_t.mrdk007, 
   mrdk008 LIKE mrdk_t.mrdk008, 
   mrdk009 LIKE mrdk_t.mrdk009
       END RECORD
PRIVATE TYPE type_g_mrdk2_d RECORD
       mrdlsite LIKE mrdl_t.mrdlsite, 
   mrdlseq1 LIKE mrdl_t.mrdlseq1, 
   mrdl001 LIKE mrdl_t.mrdl001, 
   mrdl001_desc LIKE type_t.chr500, 
   mrdl002 LIKE mrdl_t.mrdl002, 
   mrdl002_desc LIKE type_t.chr500, 
   mrdl003 LIKE mrdl_t.mrdl003, 
   mrdl004 LIKE mrdl_t.mrdl004, 
   mrdl006 LIKE mrdl_t.mrdl006
       END RECORD
PRIVATE TYPE type_g_mrdk3_d RECORD
       mrdmsite LIKE mrdm_t.mrdmsite, 
   mrdmseq1 LIKE mrdm_t.mrdmseq1, 
   mrdm001 LIKE mrdm_t.mrdm001, 
   mrdm001_desc LIKE type_t.chr500, 
   mrdm001_desc_desc LIKE type_t.chr500, 
   mrdm002 LIKE mrdm_t.mrdm002, 
   mrdm003 LIKE mrdm_t.mrdm003, 
   mrdm003_desc LIKE type_t.chr500, 
   mrdm004 LIKE mrdm_t.mrdm004, 
   mrdm005 LIKE mrdm_t.mrdm005, 
   mrdm006 LIKE mrdm_t.mrdm006, 
   mrdm006_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mrdjdocno LIKE mrdj_t.mrdjdocno,
      b_mrdjdocdt LIKE mrdj_t.mrdjdocdt,
      b_mrdj001 LIKE mrdj_t.mrdj001,
   b_mrdj001_desc LIKE type_t.chr80,
      b_mrdj002 LIKE mrdj_t.mrdj002,
   b_mrdj002_desc LIKE type_t.chr80,
      b_mrdjcrtid LIKE mrdj_t.mrdjcrtid,
   b_mrdjcrtid_desc LIKE type_t.chr80,
      b_mrdjcrtdt LIKE mrdj_t.mrdjcrtdt,
      b_mrdjmodid LIKE mrdj_t.mrdjmodid,
   b_mrdjmodid_desc LIKE type_t.chr80,
      b_mrdjmoddt LIKE mrdj_t.mrdjmoddt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrdj_m          type_g_mrdj_m
DEFINE g_mrdj_m_t        type_g_mrdj_m
DEFINE g_mrdj_m_o        type_g_mrdj_m
DEFINE g_mrdj_m_mask_o   type_g_mrdj_m #轉換遮罩前資料
DEFINE g_mrdj_m_mask_n   type_g_mrdj_m #轉換遮罩後資料
 
   DEFINE g_mrdjdocno_t LIKE mrdj_t.mrdjdocno
 
 
DEFINE g_mrdk_d          DYNAMIC ARRAY OF type_g_mrdk_d
DEFINE g_mrdk_d_t        type_g_mrdk_d
DEFINE g_mrdk_d_o        type_g_mrdk_d
DEFINE g_mrdk_d_mask_o   DYNAMIC ARRAY OF type_g_mrdk_d #轉換遮罩前資料
DEFINE g_mrdk_d_mask_n   DYNAMIC ARRAY OF type_g_mrdk_d #轉換遮罩後資料
DEFINE g_mrdk2_d          DYNAMIC ARRAY OF type_g_mrdk2_d
DEFINE g_mrdk2_d_t        type_g_mrdk2_d
DEFINE g_mrdk2_d_o        type_g_mrdk2_d
DEFINE g_mrdk2_d_mask_o   DYNAMIC ARRAY OF type_g_mrdk2_d #轉換遮罩前資料
DEFINE g_mrdk2_d_mask_n   DYNAMIC ARRAY OF type_g_mrdk2_d #轉換遮罩後資料
DEFINE g_mrdk3_d          DYNAMIC ARRAY OF type_g_mrdk3_d
DEFINE g_mrdk3_d_t        type_g_mrdk3_d
DEFINE g_mrdk3_d_o        type_g_mrdk3_d
DEFINE g_mrdk3_d_mask_o   DYNAMIC ARRAY OF type_g_mrdk3_d #轉換遮罩前資料
DEFINE g_mrdk3_d_mask_n   DYNAMIC ARRAY OF type_g_mrdk3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
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
 
{<section id="amrt310.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrdjdocno,'',mrdjdocdt,mrdjsite,mrdj001,'',mrdj002,'',mrdjstus,mrdj003, 
       mrdjownid,'',mrdjowndp,'',mrdjcrtid,'',mrdjcrtdp,'',mrdjcrtdt,mrdjmodid,'',mrdjmoddt,mrdjcnfid, 
       '',mrdjcnfdt", 
                      " FROM mrdj_t",
                      " WHERE mrdjent= ? AND mrdjdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrdjdocno,t0.mrdjdocdt,t0.mrdjsite,t0.mrdj001,t0.mrdj002,t0.mrdjstus, 
       t0.mrdj003,t0.mrdjownid,t0.mrdjowndp,t0.mrdjcrtid,t0.mrdjcrtdp,t0.mrdjcrtdt,t0.mrdjmodid,t0.mrdjmoddt, 
       t0.mrdjcnfid,t0.mrdjcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooag011",
               " FROM mrdj_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdj001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdj002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdjownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.mrdjowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mrdjcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.mrdjcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mrdjmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mrdjcnfid  ",
 
               " WHERE t0.mrdjent = " ||g_enterprise|| " AND t0.mrdjdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrt310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrt310 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrt310_init()   
 
      #進入選單 Menu (="N")
      CALL amrt310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrt310
      
   END IF 
   
   CLOSE amrt310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrt310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrt310_init()
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mrdjstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mrdk007','5203') 
   CALL cl_set_combo_scc('mrdl004','5204') 
   CALL cl_set_combo_scc('mrdm002','4039') 
   CALL cl_set_combo_scc('mrdm005','4041') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('mrdl001','1127')
   CALL cl_set_combo_scc('mrdl002','1128')
   CALL cl_set_combo_scc('mrdm006','1129')

   #end add-point
   
   #初始化搜尋條件
   CALL amrt310_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrt310.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrt310_ui_dialog()
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
            CALL amrt310_insert()
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
         INITIALIZE g_mrdj_m.* TO NULL
         CALL g_mrdk_d.clear()
         CALL g_mrdk2_d.clear()
         CALL g_mrdk3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrt310_init()
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
               
               CALL amrt310_fetch('') # reload data
               LET l_ac = 1
               CALL amrt310_ui_detailshow() #Setting the current row 
         
               CALL amrt310_idx_chk()
               #NEXT FIELD mrdkseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mrdk_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt310_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL amrt310_b_fill2('2')
CALL amrt310_b_fill2('3')
 
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
               CALL amrt310_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_mrdk2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL amrt310_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第二階單身段落
         DISPLAY ARRAY g_mrdk3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL amrt310_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL amrt310_browser_fill("")
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
               CALL amrt310_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrt310_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrt310_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrt310_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrt310_set_act_visible()   
            CALL amrt310_set_act_no_visible()
            IF NOT (g_mrdj_m.mrdjdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mrdjent = " ||g_enterprise|| " AND",
                                  " mrdjdocno = '", g_mrdj_m.mrdjdocno, "' "
 
               #填到對應位置
               CALL amrt310_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mrdj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdk_t" 
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
               CALL amrt310_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mrdj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdk_t" 
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
                  CALL amrt310_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrt310_fetch("F")
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
               CALL amrt310_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrt310_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt310_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrt310_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt310_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrt310_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt310_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrt310_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt310_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrt310_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt310_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrdk_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mrdk2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mrdk3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD mrdkseq
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
               CALL amrt310_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrt310_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amrt310_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrt310_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amr/amrt310_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amr/amrt310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amrt310_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrt310_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrt310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrt310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrt310_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mrdj_m.mrdjdocdt)
 
 
 
         
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
 
{<section id="amrt310.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrt310_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " mrdjsite = '",g_site,"' "
   ELSE
      LET g_wc = g_wc," AND mrdjsite = '",g_site,"' "
   END IF

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
      LET l_sub_sql = " SELECT DISTINCT mrdjdocno ",
                      " FROM mrdj_t ",
                      " ",
                      " LEFT JOIN mrdk_t ON mrdkent = mrdjent AND mrdjdocno = mrdkdocno ", "  ",
                      #add-point:browser_fill段sql(mrdk_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN mrdl_t ON mrdlent = mrdjent AND mrdkdocno = mrdldocno AND mrdkseq = mrdlseq", "  ",
                      #add-point:browser_fill段sql(mrdl_t1) name="browser_fill.cnt.join.mrdl_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mrdm_t ON mrdment = mrdjent AND mrdkdocno = mrdmdocno AND mrdkseq = mrdmseq", "  ",
                      #add-point:browser_fill段sql(mrdm_t1) name="browser_fill.cnt.join.mrdm_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
                      " ",
 
 
                      " WHERE mrdjent = " ||g_enterprise|| " AND mrdkent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrdj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrdjdocno ",
                      " FROM mrdj_t ", 
                      "  ",
                      "  ",
                      " WHERE mrdjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrdj_t")
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
      INITIALIZE g_mrdj_m.* TO NULL
      CALL g_mrdk_d.clear()        
      CALL g_mrdk2_d.clear() 
      CALL g_mrdk3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrdjdocno,t0.mrdjdocdt,t0.mrdj001,t0.mrdj002,t0.mrdjcrtid,t0.mrdjcrtdt,t0.mrdjmodid,t0.mrdjmoddt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdjstus,t0.mrdjdocno,t0.mrdjdocdt,t0.mrdj001,t0.mrdj002,t0.mrdjcrtid, 
          t0.mrdjcrtdt,t0.mrdjmodid,t0.mrdjmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooag011 ",
                  " FROM mrdj_t t0",
                  "  ",
                  "  LEFT JOIN mrdk_t ON mrdkent = mrdjent AND mrdjdocno = mrdkdocno ", "  ", 
                  #add-point:browser_fill段sql(mrdk_t1) name="browser_fill.join.mrdk_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrdl_t ON mrdlent = mrdjent AND mrdkdocno = mrdldocno AND mrdkseq = mrdlseq", "  ", 
                  #add-point:browser_fill段sql(mrdl_t1) name="browser_fill.join.mrdl_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrdm_t ON mrdment = mrdjent AND mrdkdocno = mrdmdocno AND mrdkseq = mrdmseq", "  ", 
                  #add-point:browser_fill段sql(mrdm_t1) name="browser_fill.join.mrdm_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
                  " ",
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdj001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdj002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdjcrtid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdjmodid  ",
 
                  " WHERE t0.mrdjent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrdj_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdjstus,t0.mrdjdocno,t0.mrdjdocdt,t0.mrdj001,t0.mrdj002,t0.mrdjcrtid, 
          t0.mrdjcrtdt,t0.mrdjmodid,t0.mrdjmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooag011 ",
                  " FROM mrdj_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdj001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdj002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdjcrtid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdjmodid  ",
 
                  " WHERE t0.mrdjent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mrdj_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mrdjdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrdj_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mrdjdocno,g_browser[g_cnt].b_mrdjdocdt, 
          g_browser[g_cnt].b_mrdj001,g_browser[g_cnt].b_mrdj002,g_browser[g_cnt].b_mrdjcrtid,g_browser[g_cnt].b_mrdjcrtdt, 
          g_browser[g_cnt].b_mrdjmodid,g_browser[g_cnt].b_mrdjmoddt,g_browser[g_cnt].b_mrdj001_desc, 
          g_browser[g_cnt].b_mrdj002_desc,g_browser[g_cnt].b_mrdjcrtid_desc,g_browser[g_cnt].b_mrdjmodid_desc 
 
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
         CALL amrt310_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_mrdjdocno) THEN
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
 
{<section id="amrt310.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrt310_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrdj_m.mrdjdocno = g_browser[g_current_idx].b_mrdjdocno   
 
   EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
       g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
       g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
       g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
   
   CALL amrt310_mrdj_t_mask()
   CALL amrt310_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrt310.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrt310_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrt310_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrdjdocno = g_mrdj_m.mrdjdocno 
 
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
 
{<section id="amrt310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrt310_construct()
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
   INITIALIZE g_mrdj_m.* TO NULL
   CALL g_mrdk_d.clear()        
   CALL g_mrdk2_d.clear() 
   CALL g_mrdk3_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON mrdjdocno,mrdjdocdt,mrdjsite,mrdj001,mrdj002,mrdjstus,mrdj003,mrdjownid, 
          mrdjowndp,mrdjcrtid,mrdjcrtdp,mrdjcrtdt,mrdjmodid,mrdjmoddt,mrdjcnfid,mrdjcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrdjcrtdt>>----
         AFTER FIELD mrdjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrdjmoddt>>----
         AFTER FIELD mrdjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdjcnfdt>>----
         AFTER FIELD mrdjcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdjpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mrdjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjdocno
            #add-point:ON ACTION controlp INFIELD mrdjdocno name="construct.c.mrdjdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrdjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjdocno  #顯示到畫面上
            NEXT FIELD mrdjdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjdocno
            #add-point:BEFORE FIELD mrdjdocno name="construct.b.mrdjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjdocno
            
            #add-point:AFTER FIELD mrdjdocno name="construct.a.mrdjdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjdocdt
            #add-point:BEFORE FIELD mrdjdocdt name="construct.b.mrdjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjdocdt
            
            #add-point:AFTER FIELD mrdjdocdt name="construct.a.mrdjdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjdocdt
            #add-point:ON ACTION controlp INFIELD mrdjdocdt name="construct.c.mrdjdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjsite
            #add-point:BEFORE FIELD mrdjsite name="construct.b.mrdjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjsite
            
            #add-point:AFTER FIELD mrdjsite name="construct.a.mrdjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjsite
            #add-point:ON ACTION controlp INFIELD mrdjsite name="construct.c.mrdjsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdj001
            #add-point:ON ACTION controlp INFIELD mrdj001 name="construct.c.mrdj001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdj001  #顯示到畫面上
            NEXT FIELD mrdj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdj001
            #add-point:BEFORE FIELD mrdj001 name="construct.b.mrdj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdj001
            
            #add-point:AFTER FIELD mrdj001 name="construct.a.mrdj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdj002
            #add-point:ON ACTION controlp INFIELD mrdj002 name="construct.c.mrdj002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdj002  #顯示到畫面上
            NEXT FIELD mrdj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdj002
            #add-point:BEFORE FIELD mrdj002 name="construct.b.mrdj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdj002
            
            #add-point:AFTER FIELD mrdj002 name="construct.a.mrdj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjstus
            #add-point:BEFORE FIELD mrdjstus name="construct.b.mrdjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjstus
            
            #add-point:AFTER FIELD mrdjstus name="construct.a.mrdjstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjstus
            #add-point:ON ACTION controlp INFIELD mrdjstus name="construct.c.mrdjstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdj003
            #add-point:BEFORE FIELD mrdj003 name="construct.b.mrdj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdj003
            
            #add-point:AFTER FIELD mrdj003 name="construct.a.mrdj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdj003
            #add-point:ON ACTION controlp INFIELD mrdj003 name="construct.c.mrdj003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjownid
            #add-point:ON ACTION controlp INFIELD mrdjownid name="construct.c.mrdjownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjownid  #顯示到畫面上
            NEXT FIELD mrdjownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjownid
            #add-point:BEFORE FIELD mrdjownid name="construct.b.mrdjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjownid
            
            #add-point:AFTER FIELD mrdjownid name="construct.a.mrdjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjowndp
            #add-point:ON ACTION controlp INFIELD mrdjowndp name="construct.c.mrdjowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjowndp  #顯示到畫面上
            NEXT FIELD mrdjowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjowndp
            #add-point:BEFORE FIELD mrdjowndp name="construct.b.mrdjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjowndp
            
            #add-point:AFTER FIELD mrdjowndp name="construct.a.mrdjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjcrtid
            #add-point:ON ACTION controlp INFIELD mrdjcrtid name="construct.c.mrdjcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjcrtid  #顯示到畫面上
            NEXT FIELD mrdjcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjcrtid
            #add-point:BEFORE FIELD mrdjcrtid name="construct.b.mrdjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjcrtid
            
            #add-point:AFTER FIELD mrdjcrtid name="construct.a.mrdjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjcrtdp
            #add-point:ON ACTION controlp INFIELD mrdjcrtdp name="construct.c.mrdjcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjcrtdp  #顯示到畫面上
            NEXT FIELD mrdjcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjcrtdp
            #add-point:BEFORE FIELD mrdjcrtdp name="construct.b.mrdjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjcrtdp
            
            #add-point:AFTER FIELD mrdjcrtdp name="construct.a.mrdjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjcrtdt
            #add-point:BEFORE FIELD mrdjcrtdt name="construct.b.mrdjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjmodid
            #add-point:ON ACTION controlp INFIELD mrdjmodid name="construct.c.mrdjmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjmodid  #顯示到畫面上
            NEXT FIELD mrdjmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjmodid
            #add-point:BEFORE FIELD mrdjmodid name="construct.b.mrdjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjmodid
            
            #add-point:AFTER FIELD mrdjmodid name="construct.a.mrdjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjmoddt
            #add-point:BEFORE FIELD mrdjmoddt name="construct.b.mrdjmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdjcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjcnfid
            #add-point:ON ACTION controlp INFIELD mrdjcnfid name="construct.c.mrdjcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdjcnfid  #顯示到畫面上
            NEXT FIELD mrdjcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjcnfid
            #add-point:BEFORE FIELD mrdjcnfid name="construct.b.mrdjcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjcnfid
            
            #add-point:AFTER FIELD mrdjcnfid name="construct.a.mrdjcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjcnfdt
            #add-point:BEFORE FIELD mrdjcnfdt name="construct.b.mrdjcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrdksite,mrdkseq,mrdk001,mrdk002,mrdk003,mrdk004,mrdk005,mrdk006,mrdk007, 
          mrdk008,mrdk009
           FROM s_detail1[1].mrdksite,s_detail1[1].mrdkseq,s_detail1[1].mrdk001,s_detail1[1].mrdk002, 
               s_detail1[1].mrdk003,s_detail1[1].mrdk004,s_detail1[1].mrdk005,s_detail1[1].mrdk006,s_detail1[1].mrdk007, 
               s_detail1[1].mrdk008,s_detail1[1].mrdk009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdksite
            #add-point:BEFORE FIELD mrdksite name="construct.b.page1.mrdksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdksite
            
            #add-point:AFTER FIELD mrdksite name="construct.a.page1.mrdksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdksite
            #add-point:ON ACTION controlp INFIELD mrdksite name="construct.c.page1.mrdksite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdkseq
            #add-point:BEFORE FIELD mrdkseq name="construct.b.page1.mrdkseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdkseq
            
            #add-point:AFTER FIELD mrdkseq name="construct.a.page1.mrdkseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdkseq
            #add-point:ON ACTION controlp INFIELD mrdkseq name="construct.c.page1.mrdkseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk001
            #add-point:ON ACTION controlp INFIELD mrdk001 name="construct.c.page1.mrdk001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrdhdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdk001  #顯示到畫面上
            NEXT FIELD mrdk001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk001
            #add-point:BEFORE FIELD mrdk001 name="construct.b.page1.mrdk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk001
            
            #add-point:AFTER FIELD mrdk001 name="construct.a.page1.mrdk001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk002
            #add-point:ON ACTION controlp INFIELD mrdk002 name="construct.c.page1.mrdk002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdk002  #顯示到畫面上
            NEXT FIELD mrdk002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk002
            #add-point:BEFORE FIELD mrdk002 name="construct.b.page1.mrdk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk002
            
            #add-point:AFTER FIELD mrdk002 name="construct.a.page1.mrdk002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk003
            #add-point:BEFORE FIELD mrdk003 name="construct.b.page1.mrdk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk003
            
            #add-point:AFTER FIELD mrdk003 name="construct.a.page1.mrdk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk003
            #add-point:ON ACTION controlp INFIELD mrdk003 name="construct.c.page1.mrdk003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk004
            #add-point:BEFORE FIELD mrdk004 name="construct.b.page1.mrdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk004
            
            #add-point:AFTER FIELD mrdk004 name="construct.a.page1.mrdk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk004
            #add-point:ON ACTION controlp INFIELD mrdk004 name="construct.c.page1.mrdk004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk005
            #add-point:BEFORE FIELD mrdk005 name="construct.b.page1.mrdk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk005
            
            #add-point:AFTER FIELD mrdk005 name="construct.a.page1.mrdk005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk005
            #add-point:ON ACTION controlp INFIELD mrdk005 name="construct.c.page1.mrdk005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk006
            #add-point:BEFORE FIELD mrdk006 name="construct.b.page1.mrdk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk006
            
            #add-point:AFTER FIELD mrdk006 name="construct.a.page1.mrdk006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk006
            #add-point:ON ACTION controlp INFIELD mrdk006 name="construct.c.page1.mrdk006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk007
            #add-point:BEFORE FIELD mrdk007 name="construct.b.page1.mrdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk007
            
            #add-point:AFTER FIELD mrdk007 name="construct.a.page1.mrdk007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk007
            #add-point:ON ACTION controlp INFIELD mrdk007 name="construct.c.page1.mrdk007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk008
            #add-point:BEFORE FIELD mrdk008 name="construct.b.page1.mrdk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk008
            
            #add-point:AFTER FIELD mrdk008 name="construct.a.page1.mrdk008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk008
            #add-point:ON ACTION controlp INFIELD mrdk008 name="construct.c.page1.mrdk008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk009
            #add-point:BEFORE FIELD mrdk009 name="construct.b.page1.mrdk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk009
            
            #add-point:AFTER FIELD mrdk009 name="construct.a.page1.mrdk009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk009
            #add-point:ON ACTION controlp INFIELD mrdk009 name="construct.c.page1.mrdk009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON mrdlsite,mrdlseq1,mrdl001,mrdl002,mrdl003,mrdl004,mrdl006
           FROM s_detail2[1].mrdlsite,s_detail2[1].mrdlseq1,s_detail2[1].mrdl001,s_detail2[1].mrdl002, 
               s_detail2[1].mrdl003,s_detail2[1].mrdl004,s_detail2[1].mrdl006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdlsite
            #add-point:BEFORE FIELD mrdlsite name="construct.b.page2.mrdlsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdlsite
            
            #add-point:AFTER FIELD mrdlsite name="construct.a.page2.mrdlsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdlsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdlsite
            #add-point:ON ACTION controlp INFIELD mrdlsite name="construct.c.page2.mrdlsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdlseq1
            #add-point:BEFORE FIELD mrdlseq1 name="construct.b.page2.mrdlseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdlseq1
            
            #add-point:AFTER FIELD mrdlseq1 name="construct.a.page2.mrdlseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdlseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdlseq1
            #add-point:ON ACTION controlp INFIELD mrdlseq1 name="construct.c.page2.mrdlseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mrdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl001
            #add-point:ON ACTION controlp INFIELD mrdl001 name="construct.c.page2.mrdl001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1127"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdl001  #顯示到畫面上
            NEXT FIELD mrdl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl001
            #add-point:BEFORE FIELD mrdl001 name="construct.b.page2.mrdl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl001
            
            #add-point:AFTER FIELD mrdl001 name="construct.a.page2.mrdl001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl002
            #add-point:ON ACTION controlp INFIELD mrdl002 name="construct.c.page2.mrdl002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1128"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdl002  #顯示到畫面上
            NEXT FIELD mrdl002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl002
            #add-point:BEFORE FIELD mrdl002 name="construct.b.page2.mrdl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl002
            
            #add-point:AFTER FIELD mrdl002 name="construct.a.page2.mrdl002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl003
            #add-point:BEFORE FIELD mrdl003 name="construct.b.page2.mrdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl003
            
            #add-point:AFTER FIELD mrdl003 name="construct.a.page2.mrdl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl003
            #add-point:ON ACTION controlp INFIELD mrdl003 name="construct.c.page2.mrdl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl004
            #add-point:BEFORE FIELD mrdl004 name="construct.b.page2.mrdl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl004
            
            #add-point:AFTER FIELD mrdl004 name="construct.a.page2.mrdl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl004
            #add-point:ON ACTION controlp INFIELD mrdl004 name="construct.c.page2.mrdl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl006
            #add-point:BEFORE FIELD mrdl006 name="construct.b.page2.mrdl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl006
            
            #add-point:AFTER FIELD mrdl006 name="construct.a.page2.mrdl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrdl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl006
            #add-point:ON ACTION controlp INFIELD mrdl006 name="construct.c.page2.mrdl006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON mrdmsite,mrdmseq1,mrdm001,mrdm002,mrdm003,mrdm004,mrdm005,mrdm006
           FROM s_detail3[1].mrdmsite,s_detail3[1].mrdmseq1,s_detail3[1].mrdm001,s_detail3[1].mrdm002, 
               s_detail3[1].mrdm003,s_detail3[1].mrdm004,s_detail3[1].mrdm005,s_detail3[1].mrdm006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdmsite
            #add-point:BEFORE FIELD mrdmsite name="construct.b.page3.mrdmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdmsite
            
            #add-point:AFTER FIELD mrdmsite name="construct.a.page3.mrdmsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrdmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdmsite
            #add-point:ON ACTION controlp INFIELD mrdmsite name="construct.c.page3.mrdmsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdmseq1
            #add-point:BEFORE FIELD mrdmseq1 name="construct.b.page3.mrdmseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdmseq1
            
            #add-point:AFTER FIELD mrdmseq1 name="construct.a.page3.mrdmseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrdmseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdmseq1
            #add-point:ON ACTION controlp INFIELD mrdmseq1 name="construct.c.page3.mrdmseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mrdm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm001
            #add-point:ON ACTION controlp INFIELD mrdm001 name="construct.c.page3.mrdm001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdm001  #顯示到畫面上
            NEXT FIELD mrdm001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm001
            #add-point:BEFORE FIELD mrdm001 name="construct.b.page3.mrdm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm001
            
            #add-point:AFTER FIELD mrdm001 name="construct.a.page3.mrdm001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm002
            #add-point:BEFORE FIELD mrdm002 name="construct.b.page3.mrdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm002
            
            #add-point:AFTER FIELD mrdm002 name="construct.a.page3.mrdm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrdm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm002
            #add-point:ON ACTION controlp INFIELD mrdm002 name="construct.c.page3.mrdm002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mrdm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm003
            #add-point:ON ACTION controlp INFIELD mrdm003 name="construct.c.page3.mrdm003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imao002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdm003  #顯示到畫面上
            NEXT FIELD mrdm003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm003
            #add-point:BEFORE FIELD mrdm003 name="construct.b.page3.mrdm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm003
            
            #add-point:AFTER FIELD mrdm003 name="construct.a.page3.mrdm003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm004
            #add-point:BEFORE FIELD mrdm004 name="construct.b.page3.mrdm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm004
            
            #add-point:AFTER FIELD mrdm004 name="construct.a.page3.mrdm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm004
            #add-point:ON ACTION controlp INFIELD mrdm004 name="construct.c.page3.mrdm004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm005
            #add-point:BEFORE FIELD mrdm005 name="construct.b.page3.mrdm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm005
            
            #add-point:AFTER FIELD mrdm005 name="construct.a.page3.mrdm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrdm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm005
            #add-point:ON ACTION controlp INFIELD mrdm005 name="construct.c.page3.mrdm005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mrdm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm006
            #add-point:ON ACTION controlp INFIELD mrdm006 name="construct.c.page3.mrdm006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1129"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdm006  #顯示到畫面上
            NEXT FIELD mrdm006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm006
            #add-point:BEFORE FIELD mrdm006 name="construct.b.page3.mrdm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm006
            
            #add-point:AFTER FIELD mrdm006 name="construct.a.page3.mrdm006"
            
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
                  WHEN la_wc[li_idx].tableid = "mrdj_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrdk_t" 
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrt310_filter()
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
      CONSTRUCT g_wc_filter ON mrdjdocno,mrdjdocdt,mrdj001,mrdj002,mrdjcrtid,mrdjcrtdt,mrdjmodid,mrdjmoddt 
 
                          FROM s_browse[1].b_mrdjdocno,s_browse[1].b_mrdjdocdt,s_browse[1].b_mrdj001, 
                              s_browse[1].b_mrdj002,s_browse[1].b_mrdjcrtid,s_browse[1].b_mrdjcrtdt, 
                              s_browse[1].b_mrdjmodid,s_browse[1].b_mrdjmoddt
 
         BEFORE CONSTRUCT
               DISPLAY amrt310_filter_parser('mrdjdocno') TO s_browse[1].b_mrdjdocno
            DISPLAY amrt310_filter_parser('mrdjdocdt') TO s_browse[1].b_mrdjdocdt
            DISPLAY amrt310_filter_parser('mrdj001') TO s_browse[1].b_mrdj001
            DISPLAY amrt310_filter_parser('mrdj002') TO s_browse[1].b_mrdj002
            DISPLAY amrt310_filter_parser('mrdjcrtid') TO s_browse[1].b_mrdjcrtid
            DISPLAY amrt310_filter_parser('mrdjcrtdt') TO s_browse[1].b_mrdjcrtdt
            DISPLAY amrt310_filter_parser('mrdjmodid') TO s_browse[1].b_mrdjmodid
            DISPLAY amrt310_filter_parser('mrdjmoddt') TO s_browse[1].b_mrdjmoddt
      
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
 
      CALL amrt310_filter_show('mrdjdocno')
   CALL amrt310_filter_show('mrdjdocdt')
   CALL amrt310_filter_show('mrdj001')
   CALL amrt310_filter_show('mrdj002')
   CALL amrt310_filter_show('mrdjcrtid')
   CALL amrt310_filter_show('mrdjcrtdt')
   CALL amrt310_filter_show('mrdjmodid')
   CALL amrt310_filter_show('mrdjmoddt')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrt310_filter_parser(ps_field)
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
 
{<section id="amrt310.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrt310_filter_show(ps_field)
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
   LET ls_condition = amrt310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrt310_query()
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
   CALL g_mrdk_d.clear()
   CALL g_mrdk2_d.clear()
   CALL g_mrdk3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrt310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrt310_browser_fill("")
      CALL amrt310_fetch("")
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL amrt310_filter_show('mrdjdocno')
   CALL amrt310_filter_show('mrdjdocdt')
   CALL amrt310_filter_show('mrdj001')
   CALL amrt310_filter_show('mrdj002')
   CALL amrt310_filter_show('mrdjcrtid')
   CALL amrt310_filter_show('mrdjcrtdt')
   CALL amrt310_filter_show('mrdjmodid')
   CALL amrt310_filter_show('mrdjmoddt')
   CALL amrt310_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrt310_fetch("F") 
      #顯示單身筆數
      CALL amrt310_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrt310_fetch(p_flag)
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
   CALL g_mrdk2_d.clear()
   CALL g_mrdk3_d.clear()
 
   
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
   
   LET g_mrdj_m.mrdjdocno = g_browser[g_current_idx].b_mrdjdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
       g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
       g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
       g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
   
   #遮罩相關處理
   LET g_mrdj_m_mask_o.* =  g_mrdj_m.*
   CALL amrt310_mrdj_t_mask()
   LET g_mrdj_m_mask_n.* =  g_mrdj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt310_set_act_visible()   
   CALL amrt310_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrdj_m_t.* = g_mrdj_m.*
   LET g_mrdj_m_o.* = g_mrdj_m.*
   
   LET g_data_owner = g_mrdj_m.mrdjownid      
   LET g_data_dept  = g_mrdj_m.mrdjowndp
   
   #重新顯示   
   CALL amrt310_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrt310_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mrdk_d.clear()   
   CALL g_mrdk2_d.clear()  
   CALL g_mrdk3_d.clear()  
 
 
   INITIALIZE g_mrdj_m.* TO NULL             #DEFAULT 設定
   
   LET g_mrdjdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdj_m.mrdjownid = g_user
      LET g_mrdj_m.mrdjowndp = g_dept
      LET g_mrdj_m.mrdjcrtid = g_user
      LET g_mrdj_m.mrdjcrtdp = g_dept 
      LET g_mrdj_m.mrdjcrtdt = cl_get_current()
      LET g_mrdj_m.mrdjmodid = g_user
      LET g_mrdj_m.mrdjmoddt = cl_get_current()
      LET g_mrdj_m.mrdjstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mrdj_m.mrdjsite = g_site
      LET g_mrdj_m.mrdjdocdt = g_today
      LET g_mrdj_m.mrdj001 = g_user
      LET g_mrdj_m.mrdj002 = g_dept
      CALL s_desc_get_person_desc(g_mrdj_m.mrdj001) RETURNING g_mrdj_m.mrdj001_desc
      CALL s_desc_get_department_desc(g_mrdj_m.mrdj002) RETURNING g_mrdj_m.mrdj002_desc
      DISPLAY BY NAME g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc

      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrdj_m_t.* = g_mrdj_m.*
      LET g_mrdj_m_o.* = g_mrdj_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdj_m.mrdjstus 
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
 
 
 
    
      CALL amrt310_input("a")
      
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
         INITIALIZE g_mrdj_m.* TO NULL
         INITIALIZE g_mrdk_d TO NULL
         INITIALIZE g_mrdk2_d TO NULL
         INITIALIZE g_mrdk3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrt310_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mrdk_d.clear()
      #CALL g_mrdk2_d.clear()
      #CALL g_mrdk3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt310_set_act_visible()   
   CALL amrt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdjent = " ||g_enterprise|| " AND",
                      " mrdjdocno = '", g_mrdj_m.mrdjdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrt310_cl
   
   CALL amrt310_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
       g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
       g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
       g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
   
   
   #遮罩相關處理
   LET g_mrdj_m_mask_o.* =  g_mrdj_m.*
   CALL amrt310_mrdj_t_mask()
   LET g_mrdj_m_mask_n.* =  g_mrdj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001, 
       g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003, 
       g_mrdj_m.mrdjownid,g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid, 
       g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdp_desc,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfid_desc,g_mrdj_m.mrdjcnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mrdj_m.mrdjownid      
   LET g_data_dept  = g_mrdj_m.mrdjowndp
   
   #功能已完成,通報訊息中心
   CALL amrt310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrt310_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrdj_m_t.* = g_mrdj_m.*
   LET g_mrdj_m_o.* = g_mrdj_m.*
   
   IF g_mrdj_m.mrdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
   CALL s_transaction_begin()
   
   OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
       g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
       g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
       g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
   
   #檢查是否允許此動作
   IF NOT amrt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdj_m_mask_o.* =  g_mrdj_m.*
   CALL amrt310_mrdj_t_mask()
   LET g_mrdj_m_mask_n.* =  g_mrdj_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
   
   CALL amrt310_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
    
   WHILE TRUE
      LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mrdj_m.mrdjmodid = g_user 
LET g_mrdj_m.mrdjmoddt = cl_get_current()
LET g_mrdj_m.mrdjmodid_desc = cl_get_username(g_mrdj_m.mrdjmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mrdj_m.mrdjstus MATCHES "[DR]" THEN 
         LET g_mrdj_m.mrdjstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrt310_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mrdj_t SET (mrdjmodid,mrdjmoddt) = (g_mrdj_m.mrdjmodid,g_mrdj_m.mrdjmoddt)
          WHERE mrdjent = g_enterprise AND mrdjdocno = g_mrdjdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrdj_m.* = g_mrdj_m_t.*
            CALL amrt310_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrdj_m.mrdjdocno != g_mrdj_m_t.mrdjdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mrdk_t SET mrdkdocno = g_mrdj_m.mrdjdocno
 
          WHERE mrdkent = g_enterprise AND mrdkdocno = g_mrdj_m_t.mrdjdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrdk_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         UPDATE mrdl_t
            SET mrdldocno = g_mrdj_m.mrdjdocno
 
          WHERE mrdlent = g_enterprise AND
                mrdldocno = g_mrdjdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdl_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         UPDATE mrdm_t
            SET mrdmdocno = g_mrdj_m.mrdjdocno
 
          WHERE mrdment = g_enterprise AND
                mrdmdocno = g_mrdjdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdm_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt310_set_act_visible()   
   CALL amrt310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrdjent = " ||g_enterprise|| " AND",
                      " mrdjdocno = '", g_mrdj_m.mrdjdocno, "' "
 
   #填到對應位置
   CALL amrt310_browser_fill("")
 
   CLOSE amrt310_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt310_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrt310.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrt310_input(p_cmd)
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
   DEFINE l_ooef004              LIKE ooef_t.ooef004
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_mrdh005              LIKE mrdh_t.mrdh005
   DEFINE l_mrbaqty              LIKE mrba_t.mrba006
   DEFINE l_mrba034              LIKE mrba_t.mrba034
   DEFINE l_mrba035              LIKE mrba_t.mrba035
   DEFINE  l_where               STRING  #160204-00004#5 20160223 s983961--add
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
   DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001, 
       g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003, 
       g_mrdj_m.mrdjownid,g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid, 
       g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdp_desc,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfid_desc,g_mrdj_m.mrdjcnfdt 
 
   
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
   LET g_forupd_sql = "SELECT mrdksite,mrdkseq,mrdk001,mrdk002,mrdk003,mrdk004,mrdk005,mrdk006,mrdk007, 
       mrdk008,mrdk009 FROM mrdk_t WHERE mrdkent=? AND mrdkdocno=? AND mrdkseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt310_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mrdlsite,mrdlseq1,mrdl001,mrdl002,mrdl003,mrdl004,mrdl006 FROM mrdl_t  
       WHERE mrdlent=? AND mrdldocno=? AND mrdlseq=? AND mrdlseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt310_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mrdmsite,mrdmseq1,mrdm001,mrdm002,mrdm003,mrdm004,mrdm005,mrdm006 FROM  
       mrdm_t WHERE mrdment=? AND mrdmdocno=? AND mrdmseq=? AND mrdmseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt310_bcl3 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrt310_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amrt310_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002, 
       g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_site
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrt310.input.head" >}
      #單頭段
      INPUT BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002, 
          g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrt310_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_mrdj_m_t.* = g_mrdj_m.*
            LET g_mrdj_m_o.* = g_mrdj_m.*

            #end add-point
            CALL amrt310_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjdocno
            
            #add-point:AFTER FIELD mrdjdocno name="input.a.mrdjdocno"
            LET g_mrdj_m.mrdjdocno_desc = ''
            IF  NOT cl_null(g_mrdj_m.mrdjdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrdj_m.mrdjdocno != g_mrdjdocno_t )) THEN 
                  IF NOT amrt310_mrdjdocno_chk() THEN
                     LET g_mrdj_m.mrdjdocno = g_mrdjdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdj_m.mrdjdocno) RETURNING g_mrdj_m.mrdjdocno_desc
                     DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_aooi200_get_slip_desc(g_mrdj_m.mrdjdocno) RETURNING g_mrdj_m.mrdjdocno_desc
            DISPLAY BY NAME g_mrdj_m.mrdjdocno_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjdocno
            #add-point:BEFORE FIELD mrdjdocno name="input.b.mrdjdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdjdocno
            #add-point:ON CHANGE mrdjdocno name="input.g.mrdjdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjdocdt
            #add-point:BEFORE FIELD mrdjdocdt name="input.b.mrdjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjdocdt
            
            #add-point:AFTER FIELD mrdjdocdt name="input.a.mrdjdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdjdocdt
            #add-point:ON CHANGE mrdjdocdt name="input.g.mrdjdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjsite
            #add-point:BEFORE FIELD mrdjsite name="input.b.mrdjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjsite
            
            #add-point:AFTER FIELD mrdjsite name="input.a.mrdjsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdjsite
            #add-point:ON CHANGE mrdjsite name="input.g.mrdjsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdj001
            
            #add-point:AFTER FIELD mrdj001 name="input.a.mrdj001"
            LET g_mrdj_m.mrdj001_desc = ''
            IF NOT cl_null(g_mrdj_m.mrdj001) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdj_m.mrdj001 != g_mrdj_m_o.mrdj001 OR g_mrdj_m_o.mrdj001 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdj_m.mrdj001
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#24  by 07900 --add-end  
                  IF cl_chk_exist("v_ooag001") THEN
                     #抓取業務人員對應的部門
                     SELECT ooag003 INTO g_mrdj_m.mrdj002 FROM ooag_t
                      WHERE ooagent = g_enterprise AND ooag001 = g_mrdj_m.mrdj001
                     CALL s_desc_get_department_desc(g_mrdj_m.mrdj002) RETURNING g_mrdj_m.mrdj002_desc
                     DISPLAY BY NAME g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc
                  ELSE
                     LET g_mrdj_m.mrdj001 = g_mrdj_m_o.mrdj001 
                     CALL s_desc_get_person_desc(g_mrdj_m.mrdj001) RETURNING g_mrdj_m.mrdj001_desc
                     DISPLAY BY NAME g_mrdj_m.mrdj001,g_mrdj_m.mrdj001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_mrdj_m.mrdj001) RETURNING g_mrdj_m.mrdj001_desc
            DISPLAY BY NAME g_mrdj_m.mrdj001_desc
            LET g_mrdj_m_o.mrdj001 = g_mrdj_m.mrdj001
            LET g_mrdj_m_o.mrdj002 = g_mrdj_m.mrdj002

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdj001
            #add-point:BEFORE FIELD mrdj001 name="input.b.mrdj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdj001
            #add-point:ON CHANGE mrdj001 name="input.g.mrdj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdj002
            
            #add-point:AFTER FIELD mrdj002 name="input.a.mrdj002"
            LET g_mrdj_m.mrdj002_desc = ''
            IF NOT cl_null(g_mrdj_m.mrdj002) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdj_m.mrdj002 != g_mrdj_m_o.mrdj002 OR g_mrdj_m_o.mrdj002 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdj_m.mrdj002
                  LET g_chkparam.arg2 = g_mrdj_m.mrdjdocdt
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mrdj_m.mrdj002 = g_mrdj_m_o.mrdj002 
                     CALL s_desc_get_department_desc(g_mrdj_m.mrdj002) RETURNING g_mrdj_m.mrdj002_desc
                     DISPLAY BY NAME g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_mrdj_m.mrdj002) RETURNING g_mrdj_m.mrdj002_desc
            DISPLAY BY NAME g_mrdj_m.mrdj002_desc
            LET g_mrdj_m_o.mrdj002 = g_mrdj_m.mrdj002

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdj002
            #add-point:BEFORE FIELD mrdj002 name="input.b.mrdj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdj002
            #add-point:ON CHANGE mrdj002 name="input.g.mrdj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdjstus
            #add-point:BEFORE FIELD mrdjstus name="input.b.mrdjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdjstus
            
            #add-point:AFTER FIELD mrdjstus name="input.a.mrdjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdjstus
            #add-point:ON CHANGE mrdjstus name="input.g.mrdjstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdj003
            #add-point:BEFORE FIELD mrdj003 name="input.b.mrdj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdj003
            
            #add-point:AFTER FIELD mrdj003 name="input.a.mrdj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdj003
            #add-point:ON CHANGE mrdj003 name="input.g.mrdj003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrdjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjdocno
            #add-point:ON ACTION controlp INFIELD mrdjdocno name="input.c.mrdjdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdj_m.mrdjdocno
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()
            LET g_mrdj_m.mrdjdocno = g_qryparam.return1              
            CALL s_aooi200_get_slip_desc(g_mrdj_m.mrdjdocno) RETURNING g_mrdj_m.mrdjdocno_desc
            DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc
            NEXT FIELD mrdjdocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.mrdjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjdocdt
            #add-point:ON ACTION controlp INFIELD mrdjdocdt name="input.c.mrdjdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjsite
            #add-point:ON ACTION controlp INFIELD mrdjsite name="input.c.mrdjsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdj001
            #add-point:ON ACTION controlp INFIELD mrdj001 name="input.c.mrdj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdj_m.mrdj001
            CALL q_ooag001()
            LET g_mrdj_m.mrdj001 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_mrdj_m.mrdj001) RETURNING g_mrdj_m.mrdj001_desc
            DISPLAY BY NAME g_mrdj_m.mrdj001,g_mrdj_m.mrdj001_desc
            NEXT FIELD mrdj001

            #END add-point
 
 
         #Ctrlp:input.c.mrdj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdj002
            #add-point:ON ACTION controlp INFIELD mrdj002 name="input.c.mrdj002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdj_m.mrdj002
            LET g_qryparam.arg1 = g_mrdj_m.mrdjdocdt
            CALL q_ooeg001()
            LET g_mrdj_m.mrdj002 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_mrdj_m.mrdj002) RETURNING g_mrdj_m.mrdj002_desc
            DISPLAY BY NAME g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc
            NEXT FIELD mrdj002

            #END add-point
 
 
         #Ctrlp:input.c.mrdjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdjstus
            #add-point:ON ACTION controlp INFIELD mrdjstus name="input.c.mrdjstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdj003
            #add-point:ON ACTION controlp INFIELD mrdj003 name="input.c.mrdj003"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrdj_m.mrdjdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt,g_prog) RETURNING l_success,g_mrdj_m.mrdjdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mrdj_m.mrdjdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mrdjdocno
               END IF
               DISPLAY BY NAME g_mrdj_m.mrdjdocno
               #end add-point
               
               INSERT INTO mrdj_t (mrdjent,mrdjdocno,mrdjdocdt,mrdjsite,mrdj001,mrdj002,mrdjstus,mrdj003, 
                   mrdjownid,mrdjowndp,mrdjcrtid,mrdjcrtdp,mrdjcrtdt,mrdjmodid,mrdjmoddt,mrdjcnfid,mrdjcnfdt) 
 
               VALUES (g_enterprise,g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001, 
                   g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid,g_mrdj_m.mrdjowndp, 
                   g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid,g_mrdj_m.mrdjmoddt, 
                   g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrdj_m:",SQLERRMESSAGE 
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
                  CALL amrt310_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrt310_b_fill()
                  CALL amrt310_b_fill2('0')
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
               CALL amrt310_mrdj_t_mask_restore('restore_mask_o')
               
               UPDATE mrdj_t SET (mrdjdocno,mrdjdocdt,mrdjsite,mrdj001,mrdj002,mrdjstus,mrdj003,mrdjownid, 
                   mrdjowndp,mrdjcrtid,mrdjcrtdp,mrdjcrtdt,mrdjmodid,mrdjmoddt,mrdjcnfid,mrdjcnfdt) = (g_mrdj_m.mrdjdocno, 
                   g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus, 
                   g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid,g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp, 
                   g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid,g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt) 
 
                WHERE mrdjent = g_enterprise AND mrdjdocno = g_mrdjdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrdj_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrt310_mrdj_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrdj_m_t)
               LET g_log2 = util.JSON.stringify(g_mrdj_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrt310.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrdk_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdk_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mrdk_d.getLength()
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
            CALL amrt310_b_fill2('2')
CALL amrt310_b_fill2('3')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdk_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdk_d[l_ac].mrdkseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrdk_d_t.* = g_mrdk_d[l_ac].*  #BACKUP
               LET g_mrdk_d_o.* = g_mrdk_d[l_ac].*  #BACKUP
               CALL amrt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amrt310_set_no_entry_b(l_cmd)
               IF NOT amrt310_lock_b("mrdk_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt310_bcl INTO g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdkseq,g_mrdk_d[l_ac].mrdk001, 
                      g_mrdk_d[l_ac].mrdk002,g_mrdk_d[l_ac].mrdk003,g_mrdk_d[l_ac].mrdk004,g_mrdk_d[l_ac].mrdk005, 
                      g_mrdk_d[l_ac].mrdk006,g_mrdk_d[l_ac].mrdk007,g_mrdk_d[l_ac].mrdk008,g_mrdk_d[l_ac].mrdk009 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mrdk_d_t.mrdkseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdk_d_mask_o[l_ac].* =  g_mrdk_d[l_ac].*
                  CALL amrt310_mrdk_t_mask()
                  LET g_mrdk_d_mask_n[l_ac].* =  g_mrdk_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt310_show()
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
            INITIALIZE g_mrdk_d[l_ac].* TO NULL 
            INITIALIZE g_mrdk_d_t.* TO NULL 
            INITIALIZE g_mrdk_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mrdk_d[l_ac].mrdk007 = "1"
      LET g_mrdk_d[l_ac].mrdk008 = "0"
      LET g_mrdk_d[l_ac].mrdk009 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(mrdkseq)+1 INTO g_mrdk_d[l_ac].mrdkseq
              FROM mrdk_t
             WHERE mrdkent = g_enterprise
               AND mrdkdocno = g_mrdj_m.mrdjdocno
            IF cl_null(g_mrdk_d[l_ac].mrdkseq) OR g_mrdk_d[l_ac].mrdkseq = 0 THEN
               LET g_mrdk_d[l_ac].mrdkseq = 1
            END IF
            LET g_mrdk_d[l_ac].mrdksite = g_site

            #end add-point
            LET g_mrdk_d_t.* = g_mrdk_d[l_ac].*     #新輸入資料
            LET g_mrdk_d_o.* = g_mrdk_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amrt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdk_d[li_reproduce_target].* = g_mrdk_d[li_reproduce].*
 
               LET g_mrdk_d[li_reproduce_target].mrdkseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM mrdk_t 
             WHERE mrdkent = g_enterprise AND mrdkdocno = g_mrdj_m.mrdjdocno
 
               AND mrdkseq = g_mrdk_d[l_ac].mrdkseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               CALL amrt310_insert_b('mrdk_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mrdk_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt310_b_fill()
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
               LET gs_keys[01] = g_mrdj_m.mrdjdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mrdk_d_t.mrdkseq
 
            
               #刪除同層單身
               IF NOT amrt310_delete_b('mrdk_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrt310_key_delete_b(gs_keys,'mrdk_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt310_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mrdk_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdk_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdksite
            #add-point:BEFORE FIELD mrdksite name="input.b.page1.mrdksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdksite
            
            #add-point:AFTER FIELD mrdksite name="input.a.page1.mrdksite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdksite
            #add-point:ON CHANGE mrdksite name="input.g.page1.mrdksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdkseq
            #add-point:BEFORE FIELD mrdkseq name="input.b.page1.mrdkseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdkseq
            
            #add-point:AFTER FIELD mrdkseq name="input.a.page1.mrdkseq"
            IF  g_mrdj_m.mrdjdocno IS NOT NULL AND g_mrdk_d[g_detail_idx].mrdkseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdj_m.mrdjdocno != g_mrdjdocno_t OR g_mrdk_d[g_detail_idx].mrdkseq != g_mrdk_d_t.mrdkseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdk_t WHERE "||"mrdkent = '" ||g_enterprise|| "' AND "||"mrdkdocno = '"||g_mrdj_m.mrdjdocno ||"' AND "|| "mrdkseq = '"||g_mrdk_d[g_detail_idx].mrdkseq ||"'",'std-00004',0) THEN
                     LET g_mrdk_d[g_detail_idx].mrdkseq = g_mrdk_d_t.mrdkseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdkseq
            #add-point:ON CHANGE mrdkseq name="input.g.page1.mrdkseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk001
            
            #add-point:AFTER FIELD mrdk001 name="input.a.page1.mrdk001"
            IF NOT cl_null(g_mrdk_d[l_ac].mrdk001) THEN
               #160204-00004#5 20160222 s983961--add(s)
               IF NOT cl_null(g_mrdj_m.mrdjdocno) THEN 
                  IF NOT s_aooi210_check_doc(g_site,'', g_mrdk_d[l_ac].mrdk001 , g_mrdj_m.mrdjdocno ,'4','') THEN
                     LET g_mrdk_d[l_ac].mrdk001 = g_mrdk_d_o.mrdk001
                     NEXT FIELD CURRENT               
                  END IF
               END IF
               #160204-00004#5 20160222 s983961--add(e)
        
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk_d[l_ac].mrdk001 != g_mrdk_d_o.mrdk001)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdk_d[l_ac].mrdk001
                  IF NOT cl_chk_exist("v_mrdhdocno") THEN
                     LET g_mrdk_d[l_ac].mrdk001 = g_mrdk_d_o.mrdk001
                     NEXT FIELD CURRENT
                  END IF
                  #mod--160524-00044#4 By shiun--(S)
                  #從amrt300預帶資料
#                  SELECT mrdh003,mrdh004,mrdh005,mrdh006,mrdh007
#                    INTO g_mrdk_d[l_ac].mrdk002,g_mrdk_d[l_ac].mrdk003,g_mrdk_d[l_ac].mrdk004,
#                         g_mrdk_d[l_ac].mrdk005,g_mrdk_d[l_ac].mrdk006
#                    FROM mrdh_t
#                   WHERE mrdhent = g_enterprise
#                     AND mrdhdocno = g_mrdk_d[l_ac].mrdk001
                  SELECT mrdh003,mrdh004,mrdh005,mrdh006,mrdh007
                    INTO g_mrdk_d[l_ac].mrdk002,g_mrdk_d[l_ac].mrdk003,g_mrdk_d[l_ac].mrdk004,
                         g_mrdk_d[l_ac].mrdk005,g_mrdk_d[l_ac].mrdk009
                    FROM mrdh_t
                   WHERE mrdhent = g_enterprise
                     AND mrdhdocno = g_mrdk_d[l_ac].mrdk001
                  #mod--160524-00044#4 By shiun--(E)
                  CALL amrt310_get_mrba004(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                       RETURNING g_mrdk_d[l_ac].mrdk002_desc
                  #預計延長資源使用天數(mrdk008) & 預計增加資源使用次數(mrdk009)
                  LET l_mrba034 = ''
                  LET l_mrba035 = ''
                  CALL amrt310_get_mrba034(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                       RETURNING l_mrba034,l_mrba035
                  LET g_mrdk_d[l_ac].mrdk008 = g_mrdk_d[l_ac].mrdk005 - l_mrba034
                  #mod--160524-00044#4 By shiun--(S)
#                  LET g_mrdk_d[l_ac].mrdk009 = g_mrdk_d[l_ac].mrdk006 - l_mrba035                  
                  LET g_mrdk_d[l_ac].mrdk006 = l_mrba035 + g_mrdk_d[l_ac].mrdk009
                  #mod--160524-00044#4 By shiun--(E)
               END IF
            END IF
            LET g_mrdk_d_o.mrdk001 = g_mrdk_d[l_ac].mrdk001
            LET g_mrdk_d_o.mrdk002 = g_mrdk_d[l_ac].mrdk002
            LET g_mrdk_d_o.mrdk003 = g_mrdk_d[l_ac].mrdk003
            LET g_mrdk_d_o.mrdk004 = g_mrdk_d[l_ac].mrdk004
            LET g_mrdk_d_o.mrdk005 = g_mrdk_d[l_ac].mrdk005
            LET g_mrdk_d_o.mrdk006 = g_mrdk_d[l_ac].mrdk006
            LET g_mrdk_d_o.mrdk008 = g_mrdk_d[l_ac].mrdk008
            LET g_mrdk_d_o.mrdk009 = g_mrdk_d[l_ac].mrdk009
            CALL amrt310_set_entry_b(l_cmd)
            CALL amrt310_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk001
            #add-point:BEFORE FIELD mrdk001 name="input.b.page1.mrdk001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk001
            #add-point:ON CHANGE mrdk001 name="input.g.page1.mrdk001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk002
            
            #add-point:AFTER FIELD mrdk002 name="input.a.page1.mrdk002"
            LET g_mrdk_d[l_ac].mrdk002_desc = ''
            IF NOT cl_null(g_mrdk_d[l_ac].mrdk002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk_d[l_ac].mrdk002 != g_mrdk_d_o.mrdk002)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdk_d[l_ac].mrdk002
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#24  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_mrba001_5") THEN
                     LET g_mrdk_d[l_ac].mrdk002 = g_mrdk_d_o.mrdk002
                     CALL amrt310_get_mrba004(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                          RETURNING g_mrdk_d[l_ac].mrdk002_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_mrdk_d[l_ac].mrdk001) THEN
                     SELECT mrba008 INTO g_mrdk_d[l_ac].mrdk003 FROM mrba_t
                      WHERE mrbaent = g_enterprise AND mrbasite = g_site
                        AND mrba001 = g_mrdk_d[l_ac].mrdk002
                  END IF
               END IF
            END IF 
            CALL amrt310_get_mrba004(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                 RETURNING g_mrdk_d[l_ac].mrdk002_desc
            LET g_mrdk_d_o.mrdk002 = g_mrdk_d[l_ac].mrdk002
            LET g_mrdk_d_o.mrdk003 = g_mrdk_d[l_ac].mrdk003
            #預計延長資源使用天數(mrdk008) & 預計增加資源使用次數(mrdk009)
            LET l_mrba034 = ''
            LET l_mrba035 = ''
            CALL amrt310_get_mrba034(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                 RETURNING l_mrba034,l_mrba035
            LET g_mrdk_d[l_ac].mrdk008 = g_mrdk_d[l_ac].mrdk005 - l_mrba034
            LET g_mrdk_d[l_ac].mrdk009 = g_mrdk_d[l_ac].mrdk006 - l_mrba035
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk002
            #add-point:BEFORE FIELD mrdk002 name="input.b.page1.mrdk002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk002
            #add-point:ON CHANGE mrdk002 name="input.g.page1.mrdk002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk003
            #add-point:BEFORE FIELD mrdk003 name="input.b.page1.mrdk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk003
            
            #add-point:AFTER FIELD mrdk003 name="input.a.page1.mrdk003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk003
            #add-point:ON CHANGE mrdk003 name="input.g.page1.mrdk003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdk_d[l_ac].mrdk004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdk004
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdk004 name="input.a.page1.mrdk004"
            IF NOT cl_null(g_mrdk_d[l_ac].mrdk004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk_d_o.mrdk004 IS NULL OR g_mrdk_d[l_ac].mrdk004 != g_mrdk_d_o.mrdk004)) THEN
                  IF NOT cl_null(g_mrdk_d[l_ac].mrdk001) THEN
                     #維修數量不可超出該維護工單的維修數量！
                     LET l_mrdh005 = ''
                     SELECT mrdh005 INTO l_mrdh005
                       FROM mrdh_t
                      WHERE mrdhent = g_enterprise
                        AND mrdhdocno = g_mrdk_d[l_ac].mrdk001
                     IF g_mrdk_d[l_ac].mrdk004 > l_mrdh005 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.code   = 'amr-00101'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_mrdk_d[l_ac].mrdk004 = g_mrdk_d_o.mrdk004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #維修數量不可超出資源主檔資源數量-已借出數量！
                  LET l_mrbaqty = ''
                  SELECT mrba006-mrba104 INTO l_mrbaqty
                    FROM mrba_t
                   WHERE mrbaent = g_enterprise
                     AND mrba001 = g_mrdk_d[l_ac].mrdk002
                  IF g_mrdk_d[l_ac].mrdk004 > l_mrbaqty THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = 'amr-00100'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_mrdk_d[l_ac].mrdk004 = g_mrdk_d_o.mrdk004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_mrdk_d_o.mrdk004 = g_mrdk_d[l_ac].mrdk004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk004
            #add-point:BEFORE FIELD mrdk004 name="input.b.page1.mrdk004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk004
            #add-point:ON CHANGE mrdk004 name="input.g.page1.mrdk004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk005
            #add-point:BEFORE FIELD mrdk005 name="input.b.page1.mrdk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk005
            
            #add-point:AFTER FIELD mrdk005 name="input.a.page1.mrdk005"
            #預計延長資源使用天數(mrdk008) & 預計增加資源使用次數(mrdk009)
            LET l_mrba034 = ''
            LET l_mrba035 = ''
            CALL amrt310_get_mrba034(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                 RETURNING l_mrba034,l_mrba035
            #add--160524-00044#4 By shiun--(S)
            IF NOT cl_null(g_mrdk_d[l_ac].mrdk005) AND g_mrdk_d[l_ac].mrdk005 < l_mrba034 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amr-00116'
               LET g_errparam.extend = g_mrdk_d[l_ac].mrdk005
               LET g_errparam.popup = TRUE
               CALL cl_err()               
               NEXT FIELD CURRENT
            END IF
            #add--160524-00044#4 By shiun--(E)
            LET g_mrdk_d[l_ac].mrdk008 = g_mrdk_d[l_ac].mrdk005 - l_mrba034
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk005
            #add-point:ON CHANGE mrdk005 name="input.g.page1.mrdk005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk006
            #add-point:BEFORE FIELD mrdk006 name="input.b.page1.mrdk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk006
            
            #add-point:AFTER FIELD mrdk006 name="input.a.page1.mrdk006"
            #預計延長資源使用天數(mrdk008) & 預計增加資源使用次數(mrdk009)
            LET l_mrba034 = ''
            LET l_mrba035 = ''
            CALL amrt310_get_mrba034(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                 RETURNING l_mrba034,l_mrba035
            LET g_mrdk_d[l_ac].mrdk009 = g_mrdk_d[l_ac].mrdk006 - l_mrba035
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk006
            #add-point:ON CHANGE mrdk006 name="input.g.page1.mrdk006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk007
            #add-point:BEFORE FIELD mrdk007 name="input.b.page1.mrdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk007
            
            #add-point:AFTER FIELD mrdk007 name="input.a.page1.mrdk007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk007
            #add-point:ON CHANGE mrdk007 name="input.g.page1.mrdk007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdk_d[l_ac].mrdk008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdk008
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdk008 name="input.a.page1.mrdk008"
            IF NOT cl_null(g_mrdk_d[l_ac].mrdk008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk008
            #add-point:BEFORE FIELD mrdk008 name="input.b.page1.mrdk008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk008
            #add-point:ON CHANGE mrdk008 name="input.g.page1.mrdk008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdk009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdk_d[l_ac].mrdk009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdk009
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdk009 name="input.a.page1.mrdk009"
            IF NOT cl_null(g_mrdk_d[l_ac].mrdk009) THEN 
               #add--160524-00044#4 By shiun--(S)
               CALL amrt310_get_mrba034(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                    RETURNING l_mrba034,l_mrba035
               LET g_mrdk_d[l_ac].mrdk006 = l_mrba035 + g_mrdk_d[l_ac].mrdk009            
               #add--160524-00044#4 By shiun--(E)
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdk009
            #add-point:BEFORE FIELD mrdk009 name="input.b.page1.mrdk009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdk009
            #add-point:ON CHANGE mrdk009 name="input.g.page1.mrdk009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrdksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdksite
            #add-point:ON ACTION controlp INFIELD mrdksite name="input.c.page1.mrdksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdkseq
            #add-point:ON ACTION controlp INFIELD mrdkseq name="input.c.page1.mrdkseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk001
            #add-point:ON ACTION controlp INFIELD mrdk001 name="input.c.page1.mrdk001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk_d[l_ac].mrdk001
            #160204-00004#5 20160223 s983961--add(s)
            IF NOT cl_null(g_mrdj_m.mrdjdocno) THEN
               LET l_success = ''
               LET l_where = ''
               CALL s_aooi210_get_check_sql(g_site,'', g_mrdj_m.mrdjdocno ,'4','','mrdhdocno') RETURNING l_success,l_where
               IF l_success AND NOT cl_null(l_where) THEN
                  LET g_qryparam.where = l_where
                  CALL q_mrdhdocno()                                #呼叫開窗
               END IF
            END IF
            #160204-00004#5 20160223 s983961--add(e)               
            #CALL q_mrdhdocno()  #160204-00004#5 20160223 s983961--mark
            LET g_mrdk_d[l_ac].mrdk001 = g_qryparam.return1              
            DISPLAY g_mrdk_d[l_ac].mrdk001 TO mrdk001
            NEXT FIELD mrdk001

            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk002
            #add-point:ON ACTION controlp INFIELD mrdk002 name="input.c.page1.mrdk002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk_d[l_ac].mrdk002
            CALL q_mrba001_4()
            LET g_mrdk_d[l_ac].mrdk002 = g_qryparam.return1              
            DISPLAY g_mrdk_d[l_ac].mrdk002 TO mrdk002
            CALL amrt310_get_mrba004(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
                 RETURNING g_mrdk_d[l_ac].mrdk002_desc
            NEXT FIELD mrdk002

            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk003
            #add-point:ON ACTION controlp INFIELD mrdk003 name="input.c.page1.mrdk003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk004
            #add-point:ON ACTION controlp INFIELD mrdk004 name="input.c.page1.mrdk004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk005
            #add-point:ON ACTION controlp INFIELD mrdk005 name="input.c.page1.mrdk005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk006
            #add-point:ON ACTION controlp INFIELD mrdk006 name="input.c.page1.mrdk006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk007
            #add-point:ON ACTION controlp INFIELD mrdk007 name="input.c.page1.mrdk007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk008
            #add-point:ON ACTION controlp INFIELD mrdk008 name="input.c.page1.mrdk008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdk009
            #add-point:ON ACTION controlp INFIELD mrdk009 name="input.c.page1.mrdk009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdk_d[l_ac].* = g_mrdk_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mrdk_d[l_ac].mrdkseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdk_d[l_ac].* = g_mrdk_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amrt310_mrdk_t_mask_restore('restore_mask_o')
      
               UPDATE mrdk_t SET (mrdkdocno,mrdksite,mrdkseq,mrdk001,mrdk002,mrdk003,mrdk004,mrdk005, 
                   mrdk006,mrdk007,mrdk008,mrdk009) = (g_mrdj_m.mrdjdocno,g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdkseq, 
                   g_mrdk_d[l_ac].mrdk001,g_mrdk_d[l_ac].mrdk002,g_mrdk_d[l_ac].mrdk003,g_mrdk_d[l_ac].mrdk004, 
                   g_mrdk_d[l_ac].mrdk005,g_mrdk_d[l_ac].mrdk006,g_mrdk_d[l_ac].mrdk007,g_mrdk_d[l_ac].mrdk008, 
                   g_mrdk_d[l_ac].mrdk009)
                WHERE mrdkent = g_enterprise AND mrdkdocno = g_mrdj_m.mrdjdocno 
 
                  AND mrdkseq = g_mrdk_d_t.mrdkseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdk_d[l_ac].* = g_mrdk_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdk_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdk_d[l_ac].* = g_mrdk_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdk_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys_bak[1] = g_mrdjdocno_t
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys_bak[2] = g_mrdk_d_t.mrdkseq
               CALL amrt310_update_b('mrdk_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrt310_mrdk_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mrdk_d[g_detail_idx].mrdkseq = g_mrdk_d_t.mrdkseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mrdj_m.mrdjdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrdk_d_t.mrdkseq
 
                  CALL amrt310_key_update_b(gs_keys,'mrdk_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrdj_m),util.JSON.stringify(g_mrdk_d_t)
               LET g_log2 = util.JSON.stringify(g_mrdj_m),util.JSON.stringify(g_mrdk_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrt310_unlock_b("mrdk_t","'1'")
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
               LET g_mrdk_d[li_reproduce_target].* = g_mrdk_d[li_reproduce].*
 
               LET g_mrdk_d[li_reproduce_target].mrdkseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdk_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdk_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_mrdk2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_mrdk_d.getLength() = 0 THEN
               NEXT FIELD mrdkseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_mrdk_d[g_detail_idx].mrdkseq) THEN
               NEXT FIELD mrdkseq
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdk2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrdk2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrdk2_d[l_ac].* TO NULL 
            INITIALIZE g_mrdk2_d_t.* TO NULL 
            INITIALIZE g_mrdk2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mrdk2_d[l_ac].mrdl001 = "1"
      LET g_mrdk2_d[l_ac].mrdl002 = "1"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            SELECT MAX(mrdlseq1)+1 INTO g_mrdk2_d[l_ac].mrdlseq1
              FROM mrdl_t
             WHERE mrdlent = g_enterprise
               AND mrdldocno = g_mrdj_m.mrdjdocno
               AND mrdlseq = g_mrdk_d[g_detail_idx].mrdkseq
            IF cl_null(g_mrdk2_d[l_ac].mrdlseq1) OR g_mrdk2_d[l_ac].mrdlseq1 = 0 THEN
               LET g_mrdk2_d[l_ac].mrdlseq1 = 1
            END IF
            LET g_mrdk2_d[l_ac].mrdlsite = g_site

            #end add-point
            LET g_mrdk2_d_t.* = g_mrdk2_d[l_ac].*     #新輸入資料
            LET g_mrdk2_d_o.* = g_mrdk2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL amrt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdk2_d[li_reproduce_target].* = g_mrdk2_d[li_reproduce].*
 
               LET g_mrdk2_d[li_reproduce_target].mrdlseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[2] = l_ac
            LET g_current_page = 2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE amrt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN amrt310_bcl USING g_enterprise,g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt310_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt310_cl
               CLOSE amrt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdk2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdk2_d[l_ac].mrdlseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrdk2_d_t.* = g_mrdk2_d[l_ac].*  #BACKUP
               LET g_mrdk2_d_o.* = g_mrdk2_d[l_ac].*  #BACKUP
               CALL amrt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL amrt310_set_no_entry_b(l_cmd)
               IF NOT amrt310_lock_b("mrdl_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt310_bcl2 INTO g_mrdk2_d[l_ac].mrdlsite,g_mrdk2_d[l_ac].mrdlseq1,g_mrdk2_d[l_ac].mrdl001, 
                      g_mrdk2_d[l_ac].mrdl002,g_mrdk2_d[l_ac].mrdl003,g_mrdk2_d[l_ac].mrdl004,g_mrdk2_d[l_ac].mrdl006 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdk2_d_mask_o[l_ac].* =  g_mrdk2_d[l_ac].*
                  CALL amrt310_mrdl_t_mask()
                  LET g_mrdk2_d_mask_n[l_ac].* =  g_mrdk2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys[3] = g_mrdk2_d_t.mrdlseq1
 
 
               #刪除同層單身
               IF NOT amrt310_delete_b('mrdl_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt310_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
 
               LET l_count = g_mrdk_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdk2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mrdl_t 
             WHERE mrdlent = g_enterprise AND mrdldocno = g_mrdj_m.mrdjdocno AND mrdlseq = g_mrdk_d[g_detail_idx].mrdkseq  
                 AND mrdlseq1 = g_mrdk2_d[g_detail_idx2].mrdlseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys[3] = g_mrdk2_d[g_detail_idx2].mrdlseq1
               CALL amrt310_insert_b('mrdl_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrdk_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt310_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdk2_d[l_ac].* = g_mrdk2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt310_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdk2_d[l_ac].* = g_mrdk2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL amrt310_mrdl_t_mask_restore('restore_mask_o')
               
               UPDATE mrdl_t SET (mrdldocno,mrdlseq,mrdlsite,mrdlseq1,mrdl001,mrdl002,mrdl003,mrdl004, 
                   mrdl006) = (g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq,g_mrdk2_d[l_ac].mrdlsite, 
                   g_mrdk2_d[l_ac].mrdlseq1,g_mrdk2_d[l_ac].mrdl001,g_mrdk2_d[l_ac].mrdl002,g_mrdk2_d[l_ac].mrdl003, 
                   g_mrdk2_d[l_ac].mrdl004,g_mrdk2_d[l_ac].mrdl006) #自訂欄位頁簽
                WHERE mrdlent = g_enterprise AND mrdldocno = g_mrdjdocno_t AND mrdlseq = g_mrdk_d[g_detail_idx].mrdkseq  
                    AND mrdlseq1 = g_mrdk2_d_t.mrdlseq1
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdk2_d[l_ac].* = g_mrdk2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdk2_d[l_ac].* = g_mrdk2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys_bak[1] = g_mrdjdocno_t
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys_bak[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys[3] = g_mrdk2_d[g_detail_idx2].mrdlseq1
               LET gs_keys_bak[3] = g_mrdk2_d_t.mrdlseq1
               CALL amrt310_update_b('mrdl_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrt310_mrdl_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrdj_m),util.JSON.stringify(g_mrdk2_d_t)
               LET g_log2 = util.JSON.stringify(g_mrdj_m),util.JSON.stringify(g_mrdk2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdlsite
            #add-point:BEFORE FIELD mrdlsite name="input.b.page2.mrdlsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdlsite
            
            #add-point:AFTER FIELD mrdlsite name="input.a.page2.mrdlsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdlsite
            #add-point:ON CHANGE mrdlsite name="input.g.page2.mrdlsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdlseq1
            #add-point:BEFORE FIELD mrdlseq1 name="input.b.page2.mrdlseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdlseq1
            
            #add-point:AFTER FIELD mrdlseq1 name="input.a.page2.mrdlseq1"
            IF  g_mrdj_m.mrdjdocno IS NOT NULL AND g_mrdk_d[g_detail_idx].mrdkseq IS NOT NULL AND g_mrdk2_d[g_detail_idx2].mrdlseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdj_m.mrdjdocno != g_mrdjdocno_t OR g_mrdk_d[g_detail_idx].mrdkseq != g_mrdk_d[g_detail_idx].mrdkseq OR g_mrdk2_d[g_detail_idx2].mrdlseq1 != g_mrdk2_d_t.mrdlseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdl_t WHERE "||"mrdlent = '" ||g_enterprise|| "' AND "||"mrdldocno = '"||g_mrdj_m.mrdjdocno ||"' AND "|| "mrdlseq = '"||g_mrdk_d[g_detail_idx].mrdkseq ||"' AND "|| "mrdlseq1 = '"||g_mrdk2_d[g_detail_idx2].mrdlseq1 ||"'",'std-00004',0) THEN
                     LET g_mrdk2_d[g_detail_idx2].mrdlseq1 = g_mrdk2_d_t.mrdlseq1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdlseq1
            #add-point:ON CHANGE mrdlseq1 name="input.g.page2.mrdlseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl001
            
            #add-point:AFTER FIELD mrdl001 name="input.a.page2.mrdl001"
            LET g_mrdk2_d[l_ac].mrdl001_desc = ''
            IF NOT cl_null(g_mrdk2_d[l_ac].mrdl001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk2_d[l_ac].mrdl001 != g_mrdk2_d_o.mrdl001)) THEN 
                  IF NOT s_azzi650_chk_exist('1127',g_mrdk2_d[l_ac].mrdl001) THEN
                     LET g_mrdk2_d[l_ac].mrdl001 = g_mrdk2_d_o.mrdl001
                     CALL s_desc_get_acc_desc('1127',g_mrdk2_d[l_ac].mrdl001)
                          RETURNING g_mrdk2_d[l_ac].mrdl001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('1127',g_mrdk2_d[l_ac].mrdl001)
                 RETURNING g_mrdk2_d[l_ac].mrdl001_desc
            LET g_mrdk2_d_o.mrdl001 = g_mrdk2_d[l_ac].mrdl001

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl001
            #add-point:BEFORE FIELD mrdl001 name="input.b.page2.mrdl001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdl001
            #add-point:ON CHANGE mrdl001 name="input.g.page2.mrdl001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl002
            
            #add-point:AFTER FIELD mrdl002 name="input.a.page2.mrdl002"
            LET g_mrdk2_d[l_ac].mrdl002_desc = ''
            IF NOT cl_null(g_mrdk2_d[l_ac].mrdl002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk2_d[l_ac].mrdl002 != g_mrdk2_d_o.mrdl002)) THEN 
                  IF NOT s_azzi650_chk_exist('1128',g_mrdk2_d[l_ac].mrdl002) THEN
                     LET g_mrdk2_d[l_ac].mrdl002 = g_mrdk2_d_o.mrdl002
                     CALL s_desc_get_acc_desc('1128',g_mrdk2_d[l_ac].mrdl002)
                          RETURNING g_mrdk2_d[l_ac].mrdl002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('1128',g_mrdk2_d[l_ac].mrdl002)
                 RETURNING g_mrdk2_d[l_ac].mrdl002_desc
            LET g_mrdk2_d_o.mrdl002 = g_mrdk2_d[l_ac].mrdl002

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl002
            #add-point:BEFORE FIELD mrdl002 name="input.b.page2.mrdl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdl002
            #add-point:ON CHANGE mrdl002 name="input.g.page2.mrdl002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdk2_d[l_ac].mrdl003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdl003
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdl003 name="input.a.page2.mrdl003"
            CALL cl_set_comp_required("mrdl004",FALSE)
            IF NOT cl_null(g_mrdk2_d[l_ac].mrdl003) THEN
               CALL cl_set_comp_required("mrdl004",TRUE)
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl003
            #add-point:BEFORE FIELD mrdl003 name="input.b.page2.mrdl003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdl003
            #add-point:ON CHANGE mrdl003 name="input.g.page2.mrdl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl004
            #add-point:BEFORE FIELD mrdl004 name="input.b.page2.mrdl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl004
            
            #add-point:AFTER FIELD mrdl004 name="input.a.page2.mrdl004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdl004
            #add-point:ON CHANGE mrdl004 name="input.g.page2.mrdl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdl006
            #add-point:BEFORE FIELD mrdl006 name="input.b.page2.mrdl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdl006
            
            #add-point:AFTER FIELD mrdl006 name="input.a.page2.mrdl006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdl006
            #add-point:ON CHANGE mrdl006 name="input.g.page2.mrdl006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mrdlsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdlsite
            #add-point:ON ACTION controlp INFIELD mrdlsite name="input.c.page2.mrdlsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrdlseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdlseq1
            #add-point:ON ACTION controlp INFIELD mrdlseq1 name="input.c.page2.mrdlseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl001
            #add-point:ON ACTION controlp INFIELD mrdl001 name="input.c.page2.mrdl001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk2_d[l_ac].mrdl001
            LET g_qryparam.arg1 = "1127"
            CALL q_oocq002()
            LET g_mrdk2_d[l_ac].mrdl001 = g_qryparam.return1              
            DISPLAY g_mrdk2_d[l_ac].mrdl001 TO mrdl001
            CALL s_desc_get_acc_desc('1127',g_mrdk2_d[l_ac].mrdl001)
                 RETURNING g_mrdk2_d[l_ac].mrdl001_desc
            NEXT FIELD mrdl001

            #END add-point
 
 
         #Ctrlp:input.c.page2.mrdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl002
            #add-point:ON ACTION controlp INFIELD mrdl002 name="input.c.page2.mrdl002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk2_d[l_ac].mrdl002
            LET g_qryparam.arg1 = "1128"
            CALL q_oocq002()
            LET g_mrdk2_d[l_ac].mrdl002 = g_qryparam.return1              
            DISPLAY g_mrdk2_d[l_ac].mrdl002 TO mrdl002
            CALL s_desc_get_acc_desc('1128',g_mrdk2_d[l_ac].mrdl002)
                 RETURNING g_mrdk2_d[l_ac].mrdl002_desc
            NEXT FIELD mrdl002

            #END add-point
 
 
         #Ctrlp:input.c.page2.mrdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl003
            #add-point:ON ACTION controlp INFIELD mrdl003 name="input.c.page2.mrdl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrdl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl004
            #add-point:ON ACTION controlp INFIELD mrdl004 name="input.c.page2.mrdl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrdl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdl006
            #add-point:ON ACTION controlp INFIELD mrdl006 name="input.c.page2.mrdl006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrdk2_d[l_ac].* = g_mrdk2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt310_bcl2
               CLOSE amrt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrt310_unlock_b("mrdl_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2_after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
 
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mrdk2_d[li_reproduce_target].* = g_mrdk2_d[li_reproduce].*
 
               LET g_mrdk2_d[li_reproduce_target].mrdlseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdk2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdk2_d.getLength()+1
            END IF
        
      END INPUT
      INPUT ARRAY g_mrdk3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_mrdk_d.getLength() = 0 THEN
               NEXT FIELD mrdkseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_mrdk_d[g_detail_idx].mrdkseq) THEN
               NEXT FIELD mrdkseq
            END IF
            #add-point:資料輸入前 name="input.body3.before_input2"
 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdk3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrdk3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrdk3_d[l_ac].* TO NULL 
            INITIALIZE g_mrdk3_d_t.* TO NULL 
            INITIALIZE g_mrdk3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_mrdk3_d[l_ac].mrdm002 = "1"
      LET g_mrdk3_d[l_ac].mrdm005 = "1"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            SELECT MAX(mrdmseq1)+1 INTO g_mrdk3_d[l_ac].mrdmseq1
              FROM mrdm_t
             WHERE mrdment = g_enterprise
               AND mrdmdocno = g_mrdj_m.mrdjdocno
               AND mrdmseq = g_mrdk_d[g_detail_idx].mrdkseq
            IF cl_null(g_mrdk3_d[l_ac].mrdmseq1) OR g_mrdk3_d[l_ac].mrdmseq1 = 0 THEN
               LET g_mrdk3_d[l_ac].mrdmseq1 = 1
            END IF
            LET g_mrdk3_d[l_ac].mrdmsite = g_site

            #end add-point
            LET g_mrdk3_d_t.* = g_mrdk3_d[l_ac].*     #新輸入資料
            LET g_mrdk3_d_o.* = g_mrdk3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL amrt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdk3_d[li_reproduce_target].* = g_mrdk3_d[li_reproduce].*
 
               LET g_mrdk3_d[li_reproduce_target].mrdmseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[3] = l_ac
            LET g_current_page = 3
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE amrt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN amrt310_bcl USING g_enterprise,g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt310_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt310_cl
               CLOSE amrt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdk3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdk3_d[l_ac].mrdmseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrdk3_d_t.* = g_mrdk3_d[l_ac].*  #BACKUP
               LET g_mrdk3_d_o.* = g_mrdk3_d[l_ac].*  #BACKUP
               CALL amrt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL amrt310_set_no_entry_b(l_cmd)
               IF NOT amrt310_lock_b("mrdm_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt310_bcl3 INTO g_mrdk3_d[l_ac].mrdmsite,g_mrdk3_d[l_ac].mrdmseq1,g_mrdk3_d[l_ac].mrdm001, 
                      g_mrdk3_d[l_ac].mrdm002,g_mrdk3_d[l_ac].mrdm003,g_mrdk3_d[l_ac].mrdm004,g_mrdk3_d[l_ac].mrdm005, 
                      g_mrdk3_d[l_ac].mrdm006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdk3_d_mask_o[l_ac].* =  g_mrdk3_d[l_ac].*
                  CALL amrt310_mrdm_t_mask()
                  LET g_mrdk3_d_mask_n[l_ac].* =  g_mrdk3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys[3] = g_mrdk3_d_t.mrdmseq1
 
 
               #刪除同層單身
               IF NOT amrt310_delete_b('mrdm_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt310_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
 
               LET l_count = g_mrdk_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdk3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mrdm_t 
             WHERE mrdment = g_enterprise AND mrdmdocno = g_mrdj_m.mrdjdocno AND mrdmseq = g_mrdk_d[g_detail_idx].mrdkseq  
                 AND mrdmseq1 = g_mrdk3_d[g_detail_idx2].mrdmseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys[3] = g_mrdk3_d[g_detail_idx2].mrdmseq1
               CALL amrt310_insert_b('mrdm_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrdk_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt310_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdk3_d[l_ac].* = g_mrdk3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt310_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdk3_d[l_ac].* = g_mrdk3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL amrt310_mrdm_t_mask_restore('restore_mask_o')
               
               UPDATE mrdm_t SET (mrdmdocno,mrdmseq,mrdmsite,mrdmseq1,mrdm001,mrdm002,mrdm003,mrdm004, 
                   mrdm005,mrdm006) = (g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq,g_mrdk3_d[l_ac].mrdmsite, 
                   g_mrdk3_d[l_ac].mrdmseq1,g_mrdk3_d[l_ac].mrdm001,g_mrdk3_d[l_ac].mrdm002,g_mrdk3_d[l_ac].mrdm003, 
                   g_mrdk3_d[l_ac].mrdm004,g_mrdk3_d[l_ac].mrdm005,g_mrdk3_d[l_ac].mrdm006) #自訂欄位頁簽 
 
                WHERE mrdment = g_enterprise AND mrdmdocno = g_mrdjdocno_t AND mrdmseq = g_mrdk_d[g_detail_idx].mrdkseq  
                    AND mrdmseq1 = g_mrdk3_d_t.mrdmseq1
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdk3_d[l_ac].* = g_mrdk3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdk3_d[l_ac].* = g_mrdk3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdj_m.mrdjdocno
               LET gs_keys_bak[1] = g_mrdjdocno_t
               LET gs_keys[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys_bak[2] = g_mrdk_d[g_detail_idx].mrdkseq
               LET gs_keys[3] = g_mrdk3_d[g_detail_idx2].mrdmseq1
               LET gs_keys_bak[3] = g_mrdk3_d_t.mrdmseq1
               CALL amrt310_update_b('mrdm_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrt310_mrdm_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrdj_m),util.JSON.stringify(g_mrdk3_d_t)
               LET g_log2 = util.JSON.stringify(g_mrdj_m),util.JSON.stringify(g_mrdk3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdmsite
            #add-point:BEFORE FIELD mrdmsite name="input.b.page3.mrdmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdmsite
            
            #add-point:AFTER FIELD mrdmsite name="input.a.page3.mrdmsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdmsite
            #add-point:ON CHANGE mrdmsite name="input.g.page3.mrdmsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdmseq1
            #add-point:BEFORE FIELD mrdmseq1 name="input.b.page3.mrdmseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdmseq1
            
            #add-point:AFTER FIELD mrdmseq1 name="input.a.page3.mrdmseq1"
            IF  g_mrdj_m.mrdjdocno IS NOT NULL AND g_mrdk_d[g_detail_idx].mrdkseq IS NOT NULL AND g_mrdk3_d[g_detail_idx2].mrdmseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdj_m.mrdjdocno != g_mrdjdocno_t OR g_mrdk_d[g_detail_idx].mrdkseq != g_mrdk_d[g_detail_idx].mrdkseq OR g_mrdk3_d[g_detail_idx2].mrdmseq1 != g_mrdk3_d_t.mrdmseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdm_t WHERE "||"mrdment = '" ||g_enterprise|| "' AND "||"mrdmdocno = '"||g_mrdj_m.mrdjdocno ||"' AND "|| "mrdmseq = '"||g_mrdk_d[g_detail_idx].mrdkseq ||"' AND "|| "mrdmseq1 = '"||g_mrdk3_d[g_detail_idx2].mrdmseq1 ||"'",'std-00004',0) THEN
                     LET g_mrdk3_d[g_detail_idx2].mrdmseq1 = g_mrdk3_d_t.mrdmseq1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdmseq1
            #add-point:ON CHANGE mrdmseq1 name="input.g.page3.mrdmseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm001
            
            #add-point:AFTER FIELD mrdm001 name="input.a.page3.mrdm001"
            LET g_mrdk3_d[l_ac].mrdm001_desc = ''
            LET g_mrdk3_d[l_ac].mrdm001_desc_desc = ''
            IF NOT cl_null(g_mrdk3_d[l_ac].mrdm001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk3_d[l_ac].mrdm001 != g_mrdk3_d_o.mrdm001)) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdk3_d[l_ac].mrdm001
                  IF NOT cl_chk_exist("v_imaf001_1") THEN
                     LET g_mrdk3_d[l_ac].mrdm001 = g_mrdk3_d_o.mrdm001
                     CALL s_desc_get_item_desc(g_mrdk3_d[l_ac].mrdm001)
                          RETURNING g_mrdk3_d[l_ac].mrdm001_desc,g_mrdk3_d[l_ac].mrdm001_desc_desc
                     NEXT FIELD CURRENT
                  END IF
#160716-00005#1-s add
                  #維護料號秏用裡的料號輸入後，請直接帶出據點的發料單位
                  SELECT imae081 INTO g_mrdk3_d[l_ac].mrdm003 FROM imae_t
                   WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=g_mrdk3_d[l_ac].mrdm001
#160716-00005#1-e add
               END IF
            END IF 
            CALL s_desc_get_item_desc(g_mrdk3_d[l_ac].mrdm001)
                 RETURNING g_mrdk3_d[l_ac].mrdm001_desc,g_mrdk3_d[l_ac].mrdm001_desc_desc
            LET g_mrdk3_d_o.mrdm001 = g_mrdk3_d[l_ac].mrdm001

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm001
            #add-point:BEFORE FIELD mrdm001 name="input.b.page3.mrdm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdm001
            #add-point:ON CHANGE mrdm001 name="input.g.page3.mrdm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm002
            #add-point:BEFORE FIELD mrdm002 name="input.b.page3.mrdm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm002
            
            #add-point:AFTER FIELD mrdm002 name="input.a.page3.mrdm002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdm002
            #add-point:ON CHANGE mrdm002 name="input.g.page3.mrdm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm003
            
            #add-point:AFTER FIELD mrdm003 name="input.a.page3.mrdm003"
            LET g_mrdk3_d[l_ac].mrdm003_desc = ''
            IF NOT cl_null(g_mrdk3_d[l_ac].mrdm003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk3_d[l_ac].mrdm003 != g_mrdk3_d_o.mrdm003)) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdk3_d[l_ac].mrdm001
                  LET g_chkparam.arg2 = g_mrdk3_d[l_ac].mrdm003
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_mrdk3_d[l_ac].mrdm003 = g_mrdk3_d_o.mrdm003
                     CALL s_desc_get_unit_desc(g_mrdk3_d[l_ac].mrdm003)
                          RETURNING g_mrdk3_d[l_ac].mrdm003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL s_desc_get_unit_desc(g_mrdk3_d[l_ac].mrdm003)
                 RETURNING g_mrdk3_d[l_ac].mrdm003_desc
            LET g_mrdk3_d_o.mrdm003 = g_mrdk3_d[l_ac].mrdm003

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm003
            #add-point:BEFORE FIELD mrdm003 name="input.b.page3.mrdm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdm003
            #add-point:ON CHANGE mrdm003 name="input.g.page3.mrdm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdk3_d[l_ac].mrdm004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrdm004
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdm004 name="input.a.page3.mrdm004"
            CALL cl_set_comp_required("mrdm003",FALSE)
            IF NOT cl_null(g_mrdk3_d[l_ac].mrdm004) THEN 
               CALL cl_set_comp_required("mrdm003",TRUE)
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm004
            #add-point:BEFORE FIELD mrdm004 name="input.b.page3.mrdm004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdm004
            #add-point:ON CHANGE mrdm004 name="input.g.page3.mrdm004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm005
            #add-point:BEFORE FIELD mrdm005 name="input.b.page3.mrdm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm005
            
            #add-point:AFTER FIELD mrdm005 name="input.a.page3.mrdm005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdm005
            #add-point:ON CHANGE mrdm005 name="input.g.page3.mrdm005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdm006
            
            #add-point:AFTER FIELD mrdm006 name="input.a.page3.mrdm006"
            LET g_mrdk3_d[l_ac].mrdm006_desc = ''
            IF NOT cl_null(g_mrdk3_d[l_ac].mrdm006) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdk3_d[l_ac].mrdm006 != g_mrdk3_d_o.mrdm006)) THEN 
                  IF NOT s_azzi650_chk_exist('1129',g_mrdk3_d[l_ac].mrdm006) THEN
                     LET g_mrdk3_d[l_ac].mrdm006 = g_mrdk3_d_o.mrdm006
                     CALL s_desc_get_acc_desc('1129',g_mrdk3_d[l_ac].mrdm006)
                          RETURNING g_mrdk3_d[l_ac].mrdm006_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('1129',g_mrdk3_d[l_ac].mrdm006)
                 RETURNING g_mrdk3_d[l_ac].mrdm006_desc
            LET g_mrdk3_d_o.mrdm006 = g_mrdk3_d[l_ac].mrdm006

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdm006
            #add-point:BEFORE FIELD mrdm006 name="input.b.page3.mrdm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdm006
            #add-point:ON CHANGE mrdm006 name="input.g.page3.mrdm006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.mrdmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdmsite
            #add-point:ON ACTION controlp INFIELD mrdmsite name="input.c.page3.mrdmsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdmseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdmseq1
            #add-point:ON ACTION controlp INFIELD mrdmseq1 name="input.c.page3.mrdmseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm001
            #add-point:ON ACTION controlp INFIELD mrdm001 name="input.c.page3.mrdm001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk3_d[l_ac].mrdm001
            CALL q_imaf001()
            LET g_mrdk3_d[l_ac].mrdm001 = g_qryparam.return1              
            DISPLAY g_mrdk3_d[l_ac].mrdm001 TO mrdm001
            CALL s_desc_get_item_desc(g_mrdk3_d[l_ac].mrdm001)
                 RETURNING g_mrdk3_d[l_ac].mrdm001_desc,g_mrdk3_d[l_ac].mrdm001_desc_desc
            NEXT FIELD mrdm001

            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm002
            #add-point:ON ACTION controlp INFIELD mrdm002 name="input.c.page3.mrdm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm003
            #add-point:ON ACTION controlp INFIELD mrdm003 name="input.c.page3.mrdm003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk3_d[l_ac].mrdm003
            LET g_qryparam.arg1 = g_mrdk3_d[l_ac].mrdm001
            CALL q_imao002()
            LET g_mrdk3_d[l_ac].mrdm003 = g_qryparam.return1              
            DISPLAY g_mrdk3_d[l_ac].mrdm003 TO mrdm003
            CALL s_desc_get_unit_desc(g_mrdk3_d[l_ac].mrdm003)
                 RETURNING g_mrdk3_d[l_ac].mrdm003_desc
            NEXT FIELD mrdm003

            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm004
            #add-point:ON ACTION controlp INFIELD mrdm004 name="input.c.page3.mrdm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm005
            #add-point:ON ACTION controlp INFIELD mrdm005 name="input.c.page3.mrdm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrdm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdm006
            #add-point:ON ACTION controlp INFIELD mrdm006 name="input.c.page3.mrdm006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdk3_d[l_ac].mrdm006
            LET g_qryparam.arg1 = "1129"
            CALL q_oocq002()
            LET g_mrdk3_d[l_ac].mrdm006 = g_qryparam.return1              
            DISPLAY g_mrdk3_d[l_ac].mrdm006 TO mrdm006
            CALL s_desc_get_acc_desc('1129',g_mrdk3_d[l_ac].mrdm006)
                 RETURNING g_mrdk3_d[l_ac].mrdm006_desc
            NEXT FIELD mrdm006


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3_after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrdk3_d[l_ac].* = g_mrdk3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt310_bcl3
               CLOSE amrt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrt310_unlock_b("mrdm_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3_after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
 
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mrdk3_d[li_reproduce_target].* = g_mrdk3_d[li_reproduce].*
 
               LET g_mrdk3_d[li_reproduce_target].mrdmseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdk3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdk3_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="amrt310.input.other" >}
      
      #add-point:自定義input name="input.more_input"
 
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mrdjdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrdksite
               WHEN "s_detail2"
                  NEXT FIELD mrdlsite
               WHEN "s_detail3"
                  NEXT FIELD mrdmsite
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
 
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrt310_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrt310_b_fill() #單身填充
      CALL amrt310_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrt310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_get_slip_desc(g_mrdj_m.mrdjdocno) RETURNING g_mrdj_m.mrdjdocno_desc
   CALL s_desc_get_person_desc(g_mrdj_m.mrdj001) RETURNING g_mrdj_m.mrdj001_desc
   CALL s_desc_get_department_desc(g_mrdj_m.mrdj002) RETURNING g_mrdj_m.mrdj002_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mrdj_m_mask_o.* =  g_mrdj_m.*
   CALL amrt310_mrdj_t_mask()
   LET g_mrdj_m_mask_n.* =  g_mrdj_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001, 
       g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003, 
       g_mrdj_m.mrdjownid,g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid, 
       g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdp_desc,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfid_desc,g_mrdj_m.mrdjcnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdj_m.mrdjstus 
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
   FOR l_ac = 1 TO g_mrdk_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL amrt310_get_mrba004(g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdk002)
           RETURNING g_mrdk_d[l_ac].mrdk002_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mrdk2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mrdk3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      CALL s_desc_get_item_desc(g_mrdk3_d[l_ac].mrdm001)
           RETURNING g_mrdk3_d[l_ac].mrdm001_desc,g_mrdk3_d[l_ac].mrdm001_desc_desc
      CALL s_desc_get_unit_desc(g_mrdk3_d[l_ac].mrdm003)
           RETURNING g_mrdk3_d[l_ac].mrdm003_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrt310_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrt310_detail_show()
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
 
{<section id="amrt310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrt310_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrdj_t.mrdjdocno 
   DEFINE l_oldno     LIKE mrdj_t.mrdjdocno 
 
   DEFINE l_master    RECORD LIKE mrdj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrdk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE mrdl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mrdm_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_mrdj_m.mrdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
    
   LET g_mrdj_m.mrdjdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdj_m.mrdjownid = g_user
      LET g_mrdj_m.mrdjowndp = g_dept
      LET g_mrdj_m.mrdjcrtid = g_user
      LET g_mrdj_m.mrdjcrtdp = g_dept 
      LET g_mrdj_m.mrdjcrtdt = cl_get_current()
      LET g_mrdj_m.mrdjmodid = g_user
      LET g_mrdj_m.mrdjmoddt = cl_get_current()
      LET g_mrdj_m.mrdjstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mrdj_m.mrdjcnfid = ""
   LET g_mrdj_m.mrdjcnfdt = ""
   LET g_mrdj_m.mrdjdocdt = g_today
   LET g_mrdj_m.mrdj001   = g_user
   LET g_mrdj_m.mrdj002   = g_dept
   LET g_mrdj_m.mrdj001_desc = cl_get_username(g_mrdj_m.mrdj001)
   LET g_mrdj_m.mrdj002_desc = cl_get_deptname(g_mrdj_m.mrdj002)
   LET g_mrdj_m.mrdjownid_desc = cl_get_username(g_mrdj_m.mrdjownid)
   LET g_mrdj_m.mrdjcrtid_desc = cl_get_username(g_mrdj_m.mrdjcrtid)
   LET g_mrdj_m.mrdjowndp_desc = cl_get_deptname(g_mrdj_m.mrdjowndp)
   LET g_mrdj_m.mrdjcrtdp_desc = cl_get_deptname(g_mrdj_m.mrdjcrtdp)
   LET g_mrdj_m.mrdjmodid_desc = ''
   LET g_mrdj_m.mrdjcnfid_desc = ''

   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdj_m.mrdjstus 
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
      LET g_mrdj_m.mrdjdocno_desc = ''
   DISPLAY BY NAME g_mrdj_m.mrdjdocno_desc
 
   
   CALL amrt310_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrdj_m.* TO NULL
      INITIALIZE g_mrdk_d TO NULL
      INITIALIZE g_mrdk2_d TO NULL
      INITIALIZE g_mrdk3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrt310_show()
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
   CALL amrt310_set_act_visible()   
   CALL amrt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdjent = " ||g_enterprise|| " AND",
                      " mrdjdocno = '", g_mrdj_m.mrdjdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amrt310_idx_chk()
   
   LET g_data_owner = g_mrdj_m.mrdjownid      
   LET g_data_dept  = g_mrdj_m.mrdjowndp
   
   #功能已完成,通報訊息中心
   CALL amrt310_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrt310_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrdk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE mrdl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mrdm_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrt310_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdk_t
    WHERE mrdkent = g_enterprise AND mrdkdocno = g_mrdjdocno_t
 
    INTO TEMP amrt310_detail
 
   #將key修正為調整後   
   UPDATE amrt310_detail 
      #更新key欄位
      SET mrdkdocno = g_mrdj_m.mrdjdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mrdk_t SELECT * FROM amrt310_detail
   
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
   DROP TABLE amrt310_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdl_t 
    WHERE mrdlent = g_enterprise AND mrdldocno = g_mrdjdocno_t
 
    INTO TEMP amrt310_detail
 
   #將key修正為調整後   
   UPDATE amrt310_detail SET mrdldocno = g_mrdj_m.mrdjdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO mrdl_t SELECT * FROM amrt310_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrt310_detail
   
   LET g_data_owner = g_mrdj_m.mrdjownid      
   LET g_data_dept  = g_mrdj_m.mrdjowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdm_t 
    WHERE mrdment = g_enterprise AND mrdmdocno = g_mrdjdocno_t
 
    INTO TEMP amrt310_detail
 
   #將key修正為調整後   
   UPDATE amrt310_detail SET mrdmdocno = g_mrdj_m.mrdjdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO mrdm_t SELECT * FROM amrt310_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrt310_detail
   
   LET g_data_owner = g_mrdj_m.mrdjownid      
   LET g_data_dept  = g_mrdj_m.mrdjowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrt310_delete()
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
   
   IF g_mrdj_m.mrdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
       g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
       g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
       g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amrt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdj_m_mask_o.* =  g_mrdj_m.*
   CALL amrt310_mrdj_t_mask()
   LET g_mrdj_m_mask_n.* =  g_mrdj_m.*
   
   CALL amrt310_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrt310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mrdjdocno_t = g_mrdj_m.mrdjdocno
 
 
      DELETE FROM mrdj_t
       WHERE mrdjent = g_enterprise AND mrdjdocno = g_mrdj_m.mrdjdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrdj_m.mrdjdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT s_aooi360_del('6',g_prog,g_mrdj_m.mrdjdocno,'','','','','','','','','4') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mrdk_t
       WHERE mrdkent = g_enterprise AND mrdkdocno = g_mrdj_m.mrdjdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM mrdl_t
       WHERE mrdlent = g_enterprise AND
             mrdldocno = g_mrdj_m.mrdjdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM mrdm_t
       WHERE mrdment = g_enterprise AND
             mrdmdocno = g_mrdj_m.mrdjdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrdj_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mrdk_d.clear() 
      CALL g_mrdk2_d.clear()       
      CALL g_mrdk3_d.clear()       
 
     
      CALL amrt310_ui_browser_refresh()  
      #CALL amrt310_ui_headershow()  
      #CALL amrt310_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrt310_browser_fill("")
         CALL amrt310_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrt310_cl
 
   #功能已完成,通報訊息中心
   CALL amrt310_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrt310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrt310_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mrdk_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrt310_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrdksite,mrdkseq,mrdk001,mrdk002,mrdk003,mrdk004,mrdk005,mrdk006, 
             mrdk007,mrdk008,mrdk009 ,t1.mrba004 FROM mrdk_t",   
                     " INNER JOIN mrdj_t ON mrdjent = " ||g_enterprise|| " AND mrdjdocno = mrdkdocno ",
 
                     #"",
                     " LEFT JOIN mrdl_t ON mrdkent = mrdlent AND mrdkdocno = mrdldocno AND mrdkseq = mrdlseq ",
               " LEFT JOIN mrdm_t ON mrdkent = mrdment AND mrdkdocno = mrdmdocno AND mrdkseq = mrdmseq ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
                     " ",
 
 
                                    " LEFT JOIN mrba_t t1 ON t1.mrbaent="||g_enterprise||" AND t1.mrbasite=mrdksite AND t1.mrba001=mrdk002  ",
 
                     " WHERE mrdkent=? AND mrdkdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
   IF NOT cl_null(g_wc2_table3) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table3 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY mrdk_t.mrdkseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt310_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrt310_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrdj_m.mrdjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrdj_m.mrdjdocno INTO g_mrdk_d[l_ac].mrdksite,g_mrdk_d[l_ac].mrdkseq, 
          g_mrdk_d[l_ac].mrdk001,g_mrdk_d[l_ac].mrdk002,g_mrdk_d[l_ac].mrdk003,g_mrdk_d[l_ac].mrdk004, 
          g_mrdk_d[l_ac].mrdk005,g_mrdk_d[l_ac].mrdk006,g_mrdk_d[l_ac].mrdk007,g_mrdk_d[l_ac].mrdk008, 
          g_mrdk_d[l_ac].mrdk009,g_mrdk_d[l_ac].mrdk002_desc   #(ver:78)
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
   
   CALL g_mrdk_d.deleteElement(g_mrdk_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrt310_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrdk_d.getLength()
      LET g_mrdk_d_mask_o[l_ac].* =  g_mrdk_d[l_ac].*
      CALL amrt310_mrdk_t_mask()
      LET g_mrdk_d_mask_n[l_ac].* =  g_mrdk_d[l_ac].*
   END FOR
   
   LET g_mrdk2_d_mask_o.* =  g_mrdk2_d.*
   FOR l_ac = 1 TO g_mrdk2_d.getLength()
      LET g_mrdk2_d_mask_o[l_ac].* =  g_mrdk2_d[l_ac].*
      CALL amrt310_mrdl_t_mask()
      LET g_mrdk2_d_mask_n[l_ac].* =  g_mrdk2_d[l_ac].*
   END FOR
   LET g_mrdk3_d_mask_o.* =  g_mrdk3_d.*
   FOR l_ac = 1 TO g_mrdk3_d.getLength()
      LET g_mrdk3_d_mask_o[l_ac].* =  g_mrdk3_d[l_ac].*
      CALL amrt310_mrdm_t_mask()
      LET g_mrdk3_d_mask_n[l_ac].* =  g_mrdk3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrt310_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mrdk_t
       WHERE mrdkent = g_enterprise AND
         mrdkdocno = ps_keys_bak[1] AND mrdkseq = ps_keys_bak[2]
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
         CALL g_mrdk_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mrdl_t
       WHERE mrdlent = g_enterprise AND
             mrdldocno = ps_keys_bak[1] AND mrdlseq = ps_keys_bak[2] AND mrdlseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_mrdk2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM mrdm_t
       WHERE mrdment = g_enterprise AND
             mrdmdocno = ps_keys_bak[1] AND mrdmseq = ps_keys_bak[2] AND mrdmseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_mrdk3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrt310_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mrdk_t
                  (mrdkent,
                   mrdkdocno,
                   mrdkseq
                   ,mrdksite,mrdk001,mrdk002,mrdk003,mrdk004,mrdk005,mrdk006,mrdk007,mrdk008,mrdk009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mrdk_d[g_detail_idx].mrdksite,g_mrdk_d[g_detail_idx].mrdk001,g_mrdk_d[g_detail_idx].mrdk002, 
                       g_mrdk_d[g_detail_idx].mrdk003,g_mrdk_d[g_detail_idx].mrdk004,g_mrdk_d[g_detail_idx].mrdk005, 
                       g_mrdk_d[g_detail_idx].mrdk006,g_mrdk_d[g_detail_idx].mrdk007,g_mrdk_d[g_detail_idx].mrdk008, 
                       g_mrdk_d[g_detail_idx].mrdk009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mrdk_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mrdl_t
                  (mrdlent,
                   mrdldocno,mrdlseq,
                   mrdlseq1
                   ,mrdlsite,mrdl001,mrdl002,mrdl003,mrdl004,mrdl006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mrdk2_d[g_detail_idx2].mrdlsite,g_mrdk2_d[g_detail_idx2].mrdl001,g_mrdk2_d[g_detail_idx2].mrdl002, 
                       g_mrdk2_d[g_detail_idx2].mrdl003,g_mrdk2_d[g_detail_idx2].mrdl004,g_mrdk2_d[g_detail_idx2].mrdl006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_mrdk2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO mrdm_t
                  (mrdment,
                   mrdmdocno,mrdmseq,
                   mrdmseq1
                   ,mrdmsite,mrdm001,mrdm002,mrdm003,mrdm004,mrdm005,mrdm006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mrdk3_d[g_detail_idx2].mrdmsite,g_mrdk3_d[g_detail_idx2].mrdm001,g_mrdk3_d[g_detail_idx2].mrdm002, 
                       g_mrdk3_d[g_detail_idx2].mrdm003,g_mrdk3_d[g_detail_idx2].mrdm004,g_mrdk3_d[g_detail_idx2].mrdm005, 
                       g_mrdk3_d[g_detail_idx2].mrdm006)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_mrdk3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrt310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdk_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrt310_mrdk_t_mask_restore('restore_mask_o')
               
      UPDATE mrdk_t 
         SET (mrdkdocno,
              mrdkseq
              ,mrdksite,mrdk001,mrdk002,mrdk003,mrdk004,mrdk005,mrdk006,mrdk007,mrdk008,mrdk009) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrdk_d[g_detail_idx].mrdksite,g_mrdk_d[g_detail_idx].mrdk001,g_mrdk_d[g_detail_idx].mrdk002, 
                  g_mrdk_d[g_detail_idx].mrdk003,g_mrdk_d[g_detail_idx].mrdk004,g_mrdk_d[g_detail_idx].mrdk005, 
                  g_mrdk_d[g_detail_idx].mrdk006,g_mrdk_d[g_detail_idx].mrdk007,g_mrdk_d[g_detail_idx].mrdk008, 
                  g_mrdk_d[g_detail_idx].mrdk009) 
         WHERE mrdkent = g_enterprise AND mrdkdocno = ps_keys_bak[1] AND mrdkseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdk_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt310_mrdk_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL amrt310_mrdl_t_mask_restore('restore_mask_o')
               
      UPDATE mrdl_t 
         SET (mrdldocno,mrdlseq,
              mrdlseq1
              ,mrdlsite,mrdl001,mrdl002,mrdl003,mrdl004,mrdl006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mrdk2_d[g_detail_idx2].mrdlsite,g_mrdk2_d[g_detail_idx2].mrdl001,g_mrdk2_d[g_detail_idx2].mrdl002, 
                  g_mrdk2_d[g_detail_idx2].mrdl003,g_mrdk2_d[g_detail_idx2].mrdl004,g_mrdk2_d[g_detail_idx2].mrdl006)  
 
         WHERE mrdlent = g_enterprise AND mrdldocno = ps_keys_bak[1] AND mrdlseq = ps_keys_bak[2] AND mrdlseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt310_mrdl_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL amrt310_mrdm_t_mask_restore('restore_mask_o')
               
      UPDATE mrdm_t 
         SET (mrdmdocno,mrdmseq,
              mrdmseq1
              ,mrdmsite,mrdm001,mrdm002,mrdm003,mrdm004,mrdm005,mrdm006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mrdk3_d[g_detail_idx2].mrdmsite,g_mrdk3_d[g_detail_idx2].mrdm001,g_mrdk3_d[g_detail_idx2].mrdm002, 
                  g_mrdk3_d[g_detail_idx2].mrdm003,g_mrdk3_d[g_detail_idx2].mrdm004,g_mrdk3_d[g_detail_idx2].mrdm005, 
                  g_mrdk3_d[g_detail_idx2].mrdm006) 
         WHERE mrdment = g_enterprise AND mrdmdocno = ps_keys_bak[1] AND mrdmseq = ps_keys_bak[2] AND mrdmseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt310_mrdm_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrt310_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'mrdk_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE mrdl_t 
         SET (mrdldocno,mrdlseq) 
              = 
             (g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq) 
         WHERE mrdlent = g_enterprise AND
               mrdldocno = ps_keys_bak[1] AND mrdlseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行update
   IF ps_table = 'mrdk_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update3"
      
      #end add-point
      
      UPDATE mrdm_t 
         SET (mrdmdocno,mrdmseq) 
              = 
             (g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq) 
         WHERE mrdment = g_enterprise AND
               mrdmdocno = ps_keys_bak[1] AND mrdmseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update3"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrt310_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'mrdk_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM mrdl_t 
            WHERE mrdlent = g_enterprise AND
                  mrdldocno = ps_keys_bak[1] AND mrdlseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行delete
   IF ps_table = 'mrdk_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete3"
      
      #end add-point
      
      DELETE FROM mrdm_t 
            WHERE mrdment = g_enterprise AND
                  mrdmdocno = ps_keys_bak[1] AND mrdmseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete3"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrt310_lock_b(ps_table,ps_page)
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
   #CALL amrt310_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mrdk_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrt310_bcl USING g_enterprise,
                                       g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt310_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mrdl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrt310_bcl2 USING g_enterprise,
                                             g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq,
                                             g_mrdk2_d[g_detail_idx2].mrdlseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt310_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "mrdm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrt310_bcl3 USING g_enterprise,
                                             g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq,
                                             g_mrdk3_d[g_detail_idx2].mrdmseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt310_bcl3:",SQLERRMESSAGE 
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
 
{<section id="amrt310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrt310_unlock_b(ps_table,ps_page)
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
      CLOSE amrt310_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrt310_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrt310_bcl3
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrt310_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mrdjdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrdjdocno",TRUE)
      CALL cl_set_comp_entry("mrdjdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mrdjdocdt",TRUE)

      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrt310_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrdjdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mrdjdocdt",FALSE)

      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mrdjdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mrdjdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrt310_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mrdk002",TRUE)
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrt310_set_no_entry_b(p_cmd)
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
   IF NOT cl_null(g_mrdk_d[l_ac].mrdk001) THEN
      CALL cl_set_comp_entry("mrdk002",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrt310_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrt310_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_mrdj_m.mrdjstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrt310_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrt310_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrt310_default_search()
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
      LET ls_wc = ls_wc, " mrdjdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mrdj_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrdk_t" 
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
      LET g_wc = g_wc," mrdjsite = '", g_argv[1], "' "
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
 
{<section id="amrt310.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrt310_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrdj_m.mrdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrt310_cl USING g_enterprise,g_mrdj_m.mrdjdocno
   IF STATUS THEN
      CLOSE amrt310_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
       g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
       g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
       g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amrt310_action_chk() THEN
      CLOSE amrt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001, 
       g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003, 
       g_mrdj_m.mrdjownid,g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid, 
       g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdp_desc,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
       g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfid_desc,g_mrdj_m.mrdjcnfdt 
 
 
   CASE g_mrdj_m.mrdjstus
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
         CASE g_mrdj_m.mrdjstus
            
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
      CALL cl_set_act_visible("confirmed,unconfirmed,invalid",FALSE)
      
      CASE g_mrdj_m.mrdjstus
         #未確認，需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
         WHEN "N"
            CALL cl_set_act_visible("invalid,confirmed",TRUE)
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF  
         #作廢
         WHEN "X"
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         #已確認
         WHEN "Y"
            CALL cl_set_act_visible("unconfirmed",TRUE)
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"     
             CALL cl_set_act_visible("confirmed ",TRUE)  
         #已拒絕，保留修改的功能(如作廢)，隱藏其他應用功能
         #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
         WHEN "R"
            CALL cl_set_act_visible("invalid,confirmed",TRUE)
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #抽單，需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
         WHEN "D"
            CALL cl_set_act_visible("invalid,confirmed",TRUE)
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
      END CASE
         
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT amrt310_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amrt310_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT amrt310_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amrt310_cl
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
      g_mrdj_m.mrdjstus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()

   IF lc_state = 'Y' THEN
      IF NOT s_amrt310_conf_chk(g_mrdj_m.mrdjdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_amrt310_conf_upd(g_mrdj_m.mrdjdocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
      
   IF lc_state = 'X' THEN
      IF NOT s_amrt310_invalid_chk(g_mrdj_m.mrdjdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_amrt310_invalid_upd(g_mrdj_m.mrdjdocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF  
   
   IF lc_state = 'N' THEN
      IF NOT s_amrt310_unconf_chk(g_mrdj_m.mrdjdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_amrt310_unconf_upd(g_mrdj_m.mrdjdocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF

   CALL cl_err_collect_show()
   #end add-point
   
   LET g_mrdj_m.mrdjmodid = g_user
   LET g_mrdj_m.mrdjmoddt = cl_get_current()
   LET g_mrdj_m.mrdjstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrdj_t 
      SET (mrdjstus,mrdjmodid,mrdjmoddt) 
        = (g_mrdj_m.mrdjstus,g_mrdj_m.mrdjmodid,g_mrdj_m.mrdjmoddt)     
    WHERE mrdjent = g_enterprise AND mrdjdocno = g_mrdj_m.mrdjdocno
 
    
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
      EXECUTE amrt310_master_referesh USING g_mrdj_m.mrdjdocno INTO g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocdt, 
          g_mrdj_m.mrdjsite,g_mrdj_m.mrdj001,g_mrdj_m.mrdj002,g_mrdj_m.mrdjstus,g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid, 
          g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdt,g_mrdj_m.mrdjmodid, 
          g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfdt,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002_desc, 
          g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp_desc,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp_desc, 
          g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrdj_m.mrdjdocno,g_mrdj_m.mrdjdocno_desc,g_mrdj_m.mrdjdocdt,g_mrdj_m.mrdjsite, 
          g_mrdj_m.mrdj001,g_mrdj_m.mrdj001_desc,g_mrdj_m.mrdj002,g_mrdj_m.mrdj002_desc,g_mrdj_m.mrdjstus, 
          g_mrdj_m.mrdj003,g_mrdj_m.mrdjownid,g_mrdj_m.mrdjownid_desc,g_mrdj_m.mrdjowndp,g_mrdj_m.mrdjowndp_desc, 
          g_mrdj_m.mrdjcrtid,g_mrdj_m.mrdjcrtid_desc,g_mrdj_m.mrdjcrtdp,g_mrdj_m.mrdjcrtdp_desc,g_mrdj_m.mrdjcrtdt, 
          g_mrdj_m.mrdjmodid,g_mrdj_m.mrdjmodid_desc,g_mrdj_m.mrdjmoddt,g_mrdj_m.mrdjcnfid,g_mrdj_m.mrdjcnfid_desc, 
          g_mrdj_m.mrdjcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrt310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt310_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt310.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrt310_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mrdk_d.getLength() THEN
         LET g_detail_idx = g_mrdk_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrdk_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrdk_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_mrdk2_d.getLength() THEN
         LET g_detail_idx2 = g_mrdk2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_mrdk2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_mrdk2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_mrdk3_d.getLength() THEN
         LET g_detail_idx2 = g_mrdk3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_mrdk3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_mrdk3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrt310_b_fill2(pi_idx)
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
   
   IF amrt310_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_mrdk_d.getLength() > 0 THEN
               CALL g_mrdk2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT mrdlsite,mrdlseq1,mrdl001,mrdl002,mrdl003,mrdl004,mrdl006 ,t2.oocql004 , 
             t3.oocql004 FROM mrdl_t",    
                     "",
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1127' AND t2.oocql002=mrdl001 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='1128' AND t3.oocql002=mrdl002 AND t3.oocql003='"||g_dlang||"' ",
 
                     " WHERE mrdlent=? AND mrdldocno=? AND mrdlseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  mrdl_t.mrdlseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_mrdk2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt310_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR amrt310_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq INTO g_mrdk2_d[l_ac].mrdlsite, 
             g_mrdk2_d[l_ac].mrdlseq1,g_mrdk2_d[l_ac].mrdl001,g_mrdk2_d[l_ac].mrdl002,g_mrdk2_d[l_ac].mrdl003, 
             g_mrdk2_d[l_ac].mrdl004,g_mrdk2_d[l_ac].mrdl006,g_mrdk2_d[l_ac].mrdl001_desc,g_mrdk2_d[l_ac].mrdl002_desc  
               #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_mrdk2_d.deleteElement(g_mrdk2_d.getLength())
 
      END IF
   END IF
 
   IF amrt310_fill_chk(3) THEN
      IF (pi_idx = 3 OR pi_idx = 0 ) AND g_mrdk_d.getLength() > 0 THEN
               CALL g_mrdk3_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT mrdmsite,mrdmseq1,mrdm001,mrdm002,mrdm003,mrdm004,mrdm005,mrdm006 , 
             t4.imaal003 ,t5.imaal004 ,t6.oocal003 ,t7.oocql004 FROM mrdm_t",    
                     "",
                                    " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=mrdm001 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=mrdm001 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=mrdm003 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='1129' AND t7.oocql002=mrdm006 AND t7.oocql003='"||g_dlang||"' ",
 
                     " WHERE mrdment=? AND mrdmdocno=? AND mrdmseq=?"
         
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  mrdm_t.mrdmseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill3"
         
         #end add-point
         
         #先清空資料
               CALL g_mrdk3_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt310_pb3 FROM g_sql
         DECLARE b_fill_curs3 CURSOR FOR amrt310_pb3
         
      #  OPEN b_fill_curs3 USING g_enterprise,g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs3 USING g_enterprise,g_mrdj_m.mrdjdocno,g_mrdk_d[g_detail_idx].mrdkseq INTO g_mrdk3_d[l_ac].mrdmsite, 
             g_mrdk3_d[l_ac].mrdmseq1,g_mrdk3_d[l_ac].mrdm001,g_mrdk3_d[l_ac].mrdm002,g_mrdk3_d[l_ac].mrdm003, 
             g_mrdk3_d[l_ac].mrdm004,g_mrdk3_d[l_ac].mrdm005,g_mrdk3_d[l_ac].mrdm006,g_mrdk3_d[l_ac].mrdm001_desc, 
             g_mrdk3_d[l_ac].mrdm001_desc_desc,g_mrdk3_d[l_ac].mrdm003_desc,g_mrdk3_d[l_ac].mrdm006_desc  
               #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill3"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_mrdk3_d.deleteElement(g_mrdk3_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_mrdk2_d_mask_o.* =  g_mrdk2_d.*
   FOR l_ac = 1 TO g_mrdk2_d.getLength()
      LET g_mrdk2_d_mask_o[l_ac].* =  g_mrdk2_d[l_ac].*
      CALL amrt310_mrdl_t_mask()
      LET g_mrdk2_d_mask_n[l_ac].* =  g_mrdk2_d[l_ac].*
   END FOR
   LET g_mrdk3_d_mask_o.* =  g_mrdk3_d.*
   FOR l_ac = 1 TO g_mrdk3_d.getLength()
      LET g_mrdk3_d_mask_o[l_ac].* =  g_mrdk3_d[l_ac].*
      CALL amrt310_mrdm_t_mask()
      LET g_mrdk3_d_mask_n[l_ac].* =  g_mrdk3_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL amrt310_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrt310_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amrt310.status_show" >}
PRIVATE FUNCTION amrt310_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrt310.mask_functions" >}
&include "erp/amr/amrt310_mask.4gl"
 
{</section>}
 
{<section id="amrt310.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION amrt310_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL amrt310_show()
   CALL amrt310_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
#   #確認前檢核段
#   IF NOT s_amrt310_conf_chk(g_mrdj_m.mrdjdocno) THEN
#      CLOSE amrt310_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
#
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mrdj_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mrdk_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mrdk2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_mrdk3_d))
 
 
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
   #CALL amrt310_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amrt310_ui_headershow()
   CALL amrt310_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION amrt310_draw_out()
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
   CALL amrt310_ui_headershow()  
   CALL amrt310_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="amrt310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrt310_set_pk_array()
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
   LET g_pk_array[1].values = g_mrdj_m.mrdjdocno
   LET g_pk_array[1].column = 'mrdjdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt310.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrt310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrt310_msgcentre_notify(lc_state)
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
   CALL amrt310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrdj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt310.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrt310_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#24 add-S
   SELECT mrdjstus  INTO g_mrdj_m.mrdjstus
     FROM mrdj_t
    WHERE mrdjent = g_enterprise
      AND mrdjdocno = g_mrdj_m.mrdjdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mrdj_m.mrdjstus
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
        LET g_errparam.extend = g_mrdj_m.mrdjdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrt310_set_act_visible()
        CALL amrt310_set_act_no_visible()
        CALL amrt310_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#24 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt310.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 報工單號檢核
# Memo...........:
# Usage..........: CALL amrt310_mrdjdocno_chk()
#                  RETURNING TRUE OR FALSE
# Input parameter: 
# Return code....: 
# Date & Author..: 141224 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt310_mrdjdocno_chk()
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5

   #key值
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdj_t WHERE "||"mrdjent = '" ||g_enterprise|| "' AND "||"mrdjdocno = '"||g_mrdj_m.mrdjdocno ||"'",'std-00004',0) THEN
      RETURN FALSE
   END IF

   #檢查單別
   IF NOT s_aooi200_chk_slip(g_site,'',g_mrdj_m.mrdjdocno,g_prog) THEN
      RETURN FALSE
   END IF

   #檢核輸入的單據別是否可以被key人員對應的控制組使用,'6' 為生管控制組類型
   CALL s_control_chk_doc('1',g_mrdj_m.mrdjdocno,'6',g_user,g_dept,'','') RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN
      RETURN FALSE
   END IF

   RETURN TRUE

END FUNCTION

################################################################################
# Descriptions...: 取得資源編號名稱
# Memo...........:
# Usage..........: CALL amrt310_get_mrba004(p_mrdksite,p_mrdk002)
#                  RETURNING r_mrba004
# Input parameter: 
# Return code....: 
# Date & Author..: 141224 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt310_get_mrba004(p_mrdksite,p_mrdk002)
DEFINE p_mrdksite   LIKE mrdk_t.mrdksite
DEFINE p_mrdk002    LIKE mrdk_t.mrdk002
DEFINE r_mrba004    LIKE mrba_t.mrba004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrdksite
   LET g_ref_fields[2] = p_mrdk002
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite=? AND mrba001=? ","") RETURNING g_rtn_fields
   LET r_mrba004 = '', g_rtn_fields[1] , ''
   
   RETURN r_mrba004

END FUNCTION

################################################################################
# Descriptions...: 抓取mrba034,mrba035
# Memo...........:
# Usage..........: CALL amrt310_get_mrba034(p_mrdksite,p_mrdk002)
#                  RETURNING r_mrba034,r_mrba035
# Input parameter: p_mrdksite  營運據點
#                : p_mrdk002   料件編號
# Return code....: r_mrba034   預估除役日期
#                : r_mrba035   預計運作次數
# Date & Author..: 15/06/29 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt310_get_mrba034(p_mrdksite,p_mrdk002)
DEFINE p_mrdksite   LIKE mrdk_t.mrdksite
DEFINE p_mrdk002    LIKE mrdk_t.mrdk002
DEFINE r_mrba034    DATETIME YEAR TO SECOND
DEFINE r_mrba035    LIKE mrba_t.mrba035

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrdksite
   LET g_ref_fields[2] = p_mrdk002
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba034,mrba035 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite=? AND mrba001=? ","") RETURNING g_rtn_fields
   IF cl_null(g_rtn_fields[2]) THEN LET g_rtn_fields[2] = 0 END IF
   LET r_mrba034 = g_rtn_fields[1]
   LET r_mrba035 = g_rtn_fields[2]
      
   RETURN r_mrba034,r_mrba035

END FUNCTION

 
{</section>}
 
