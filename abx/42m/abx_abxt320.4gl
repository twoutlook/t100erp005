#該程式未解開Section, 採用最新樣板產出!
{<section id="abxt320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-01-28 17:34:12), PR版次:0004(2016-08-26 11:30:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: abxt320
#+ Description: 保稅機器設備收回建立作業
#+ Creator....: 06815(2016-01-22 18:22:11)
#+ Modifier...: 06815 -SD/PR- 01534
 
{</section>}
 
{<section id="abxt320.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#27    16/04/29   BY 07900     校验代码重复错误讯息的修改
#160816-00068#14    16/08/17   By 08209     調整transaction
#160818-00017#4     16/08/26   By lixh      单据类作业修改，删除时需重新检查状态
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
PRIVATE type type_g_bxdj_m        RECORD
       bxdjdocno LIKE bxdj_t.bxdjdocno, 
   bxdjdocno_desc LIKE type_t.chr80, 
   bxdjdocdt LIKE bxdj_t.bxdjdocdt, 
   bxdj001 LIKE bxdj_t.bxdj001, 
   bxdj001_desc LIKE type_t.chr80, 
   bxdj002 LIKE bxdj_t.bxdj002, 
   bxdj002_desc LIKE type_t.chr80, 
   bxdjsite LIKE bxdj_t.bxdjsite, 
   bxdjstus LIKE bxdj_t.bxdjstus, 
   bxdj010 LIKE bxdj_t.bxdj010, 
   bxdjownid LIKE bxdj_t.bxdjownid, 
   bxdjownid_desc LIKE type_t.chr80, 
   bxdjowndp LIKE bxdj_t.bxdjowndp, 
   bxdjowndp_desc LIKE type_t.chr80, 
   bxdjcrtid LIKE bxdj_t.bxdjcrtid, 
   bxdjcrtid_desc LIKE type_t.chr80, 
   bxdjcrtdp LIKE bxdj_t.bxdjcrtdp, 
   bxdjcrtdp_desc LIKE type_t.chr80, 
   bxdjcrtdt LIKE bxdj_t.bxdjcrtdt, 
   bxdjmodid LIKE bxdj_t.bxdjmodid, 
   bxdjmodid_desc LIKE type_t.chr80, 
   bxdjmoddt LIKE bxdj_t.bxdjmoddt, 
   bxdjcnfid LIKE bxdj_t.bxdjcnfid, 
   bxdjcnfid_desc LIKE type_t.chr80, 
   bxdjcnfdt LIKE bxdj_t.bxdjcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bxdk_d        RECORD
       bxdkseq LIKE bxdk_t.bxdkseq, 
   bxdk001 LIKE bxdk_t.bxdk001, 
   bxdk002 LIKE bxdk_t.bxdk002, 
   l_bxdi001 LIKE type_t.chr20, 
   l_bxdb002 LIKE type_t.chr500, 
   l_bxdb003 LIKE type_t.chr500, 
   l_bxdb004 LIKE type_t.chr500, 
   l_bxdi002 LIKE type_t.num10, 
   l_bxdc003 LIKE type_t.chr10, 
   bxdc003_desc LIKE type_t.chr500, 
   l_bxdc004 LIKE type_t.chr20, 
   bxdc004_desc LIKE type_t.chr500, 
   bxdk003 LIKE bxdk_t.bxdk003, 
   bxdk004 LIKE bxdk_t.bxdk004, 
   bxdksite LIKE bxdk_t.bxdksite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bxdjdocno LIKE bxdj_t.bxdjdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_bxdj_m          type_g_bxdj_m
DEFINE g_bxdj_m_t        type_g_bxdj_m
DEFINE g_bxdj_m_o        type_g_bxdj_m
DEFINE g_bxdj_m_mask_o   type_g_bxdj_m #轉換遮罩前資料
DEFINE g_bxdj_m_mask_n   type_g_bxdj_m #轉換遮罩後資料
 
   DEFINE g_bxdjdocno_t LIKE bxdj_t.bxdjdocno
 
 
DEFINE g_bxdk_d          DYNAMIC ARRAY OF type_g_bxdk_d
DEFINE g_bxdk_d_t        type_g_bxdk_d
DEFINE g_bxdk_d_o        type_g_bxdk_d
DEFINE g_bxdk_d_mask_o   DYNAMIC ARRAY OF type_g_bxdk_d #轉換遮罩前資料
DEFINE g_bxdk_d_mask_n   DYNAMIC ARRAY OF type_g_bxdk_d #轉換遮罩後資料
 
 
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
 
{<section id="abxt320.main" >}
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
   CALL cl_ap_init("abx","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bxdjdocno,'',bxdjdocdt,bxdj001,'',bxdj002,'',bxdjsite,bxdjstus,bxdj010, 
       bxdjownid,'',bxdjowndp,'',bxdjcrtid,'',bxdjcrtdp,'',bxdjcrtdt,bxdjmodid,'',bxdjmoddt,bxdjcnfid, 
       '',bxdjcnfdt", 
                      " FROM bxdj_t",
                      " WHERE bxdjent= ? AND bxdjdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abxt320_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bxdjdocno,t0.bxdjdocdt,t0.bxdj001,t0.bxdj002,t0.bxdjsite,t0.bxdjstus, 
       t0.bxdj010,t0.bxdjownid,t0.bxdjowndp,t0.bxdjcrtid,t0.bxdjcrtdp,t0.bxdjcrtdt,t0.bxdjmodid,t0.bxdjmoddt, 
       t0.bxdjcnfid,t0.bxdjcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooag011",
               " FROM bxdj_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.bxdj001  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.bxdj002 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.bxdjownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.bxdjowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.bxdjcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.bxdjcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.bxdjmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.bxdjcnfid  ",
 
               " WHERE t0.bxdjent = " ||g_enterprise|| " AND t0.bxdjdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abxt320_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abxt320 WITH FORM cl_ap_formpath("abx",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abxt320_init()   
 
      #進入選單 Menu (="N")
      CALL abxt320_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abxt320
      
   END IF 
   
   CLOSE abxt320_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abxt320.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abxt320_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql        STRING 
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
      CALL cl_set_combo_scc_part('bxdjstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET l_sql = "SELECT  UNIQUE bxdi001,bxdi002,bxdisite  FROM bxdi_t ",   
               " WHERE bxdidocno = ? ",
               "   AND bxdiseq = ?   ",
               "   AND bxdient = '"||g_enterprise||"' "
   PREPARE abxt320_bxdi FROM l_sql
   DECLARE b_fill_bxdi CURSOR FOR abxt320_bxdi
     
   
   LET l_sql = "SELECT  UNIQUE bxdb002,bxdb003,bxdb004  FROM bxdb_t ",   
               " WHERE bxdbsite = ? ",
               "   AND bxdb001 = ?   ",
               "   AND bxdbent = '"||g_enterprise||"' "
   PREPARE abxt320_bxdb FROM l_sql
   DECLARE b_fill_bxdb CURSOR FOR abxt320_bxdb
   
   LET l_sql = "SELECT  UNIQUE bxdc003,ooag011,bxdc004,ooefl003  ",
               "  FROM bxdc_t ",
               "  LEFT OUTER JOIN ooefl_t ON ooeflent = bxdcent AND ooefl001 = bxdc003 AND ooefl002 = '",g_dlang,"' ",
               "  LEFT OUTER JOIN ooag_t ON ooagent = bxdcent AND ooag001 = bxdc004  ",                
               " WHERE bxdcsite = ? ",
               "   AND bxdc001 = ?   ",
               "   AND bxdc002 = ?   ",
               "   AND bxdcent = '"||g_enterprise||"' "
   PREPARE abxt320_bxdc FROM l_sql
   DECLARE b_fill_bxdc CURSOR FOR abxt320_bxdc
   
   CALL abxt320_set_act_visible()
   CALL abxt320_set_act_no_visible()
   
   #  EXECUTE b_fill_bxdi USING p_bxdk001,p_bxdk002
   #                       INTO g_bxdk_d[l_ac].l_bxdi001,g_bxdk_d[l_ac].l_bxdi002,l_bxdisite 
   #                                           
   #  EXECUTE b_fill_bxdb USING l_bxdisite,g_bxdk_d[l_ac].l_bxdi001 
   #                       INTO g_bxdk_d[l_ac].l_bxdb002,g_bxdk_d[l_ac].l_bxdb003,g_bxdk_d[l_ac].l_bxdb004  
   #   
   #  EXECUTE b_fill_bxdc USING l_bxdisite,g_bxdk_d[l_ac].l_bxdi001,g_bxdk_d[l_ac].l_bxdi002
   #                       INTO g_bxdk_d[l_ac].l_bxdc003,g_bxdk_d[l_ac].bxdc003_desc,g_bxdk_d[l_ac].l_bxdc004,g_bxdk_d[l_ac].bxdc004_desc                               
   #end add-point
   
   #初始化搜尋條件
   CALL abxt320_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abxt320.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abxt320_ui_dialog()
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
            CALL abxt320_insert()
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
         INITIALIZE g_bxdj_m.* TO NULL
         CALL g_bxdk_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abxt320_init()
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
               
               CALL abxt320_fetch('') # reload data
               LET l_ac = 1
               CALL abxt320_ui_detailshow() #Setting the current row 
         
               CALL abxt320_idx_chk()
               #NEXT FIELD bxdkseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bxdk_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abxt320_idx_chk()
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
               CALL abxt320_idx_chk()
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
            CALL abxt320_browser_fill("")
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
               CALL abxt320_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abxt320_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abxt320_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL abxt320_set_act_visible()
            CALL abxt320_set_act_no_visible()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abxt320_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abxt320_set_act_visible()   
            CALL abxt320_set_act_no_visible()
            IF NOT (g_bxdj_m.bxdjdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " bxdjent = " ||g_enterprise|| " AND",
                                  " bxdjdocno = '", g_bxdj_m.bxdjdocno, "' "
 
               #填到對應位置
               CALL abxt320_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "bxdj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bxdk_t" 
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
               CALL abxt320_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bxdj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bxdk_t" 
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
                  CALL abxt320_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abxt320_fetch("F")
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
               CALL abxt320_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abxt320_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt320_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abxt320_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt320_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abxt320_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt320_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abxt320_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt320_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abxt320_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abxt320_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bxdk_d)
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
               NEXT FIELD bxdkseq
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
               CALL abxt320_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abxt320_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abxt320_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abxt320_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/abx/abxt320_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/abx/abxt320_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abxt320_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abxt320_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abxt320_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abxt320_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abxt320_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_bxdj_m.bxdjdocdt)
 
 
 
         
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
 
{<section id="abxt320.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abxt320_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT bxdjdocno ",
                      " FROM bxdj_t ",
                      " ",
                      " LEFT JOIN bxdk_t ON bxdkent = bxdjent AND bxdjdocno = bxdkdocno ", "  ",
                      #add-point:browser_fill段sql(bxdk_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE bxdjent = " ||g_enterprise|| " AND bxdkent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bxdj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bxdjdocno ",
                      " FROM bxdj_t ", 
                      "  ",
                      "  ",
                      " WHERE bxdjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bxdj_t")
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
      INITIALIZE g_bxdj_m.* TO NULL
      CALL g_bxdk_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bxdjdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bxdjstus,t0.bxdjdocno ",
                  " FROM bxdj_t t0",
                  "  ",
                  "  LEFT JOIN bxdk_t ON bxdkent = bxdjent AND bxdjdocno = bxdkdocno ", "  ", 
                  #add-point:browser_fill段sql(bxdk_t1) name="browser_fill.join.bxdk_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.bxdjent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bxdj_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bxdjstus,t0.bxdjdocno ",
                  " FROM bxdj_t t0",
                  "  ",
                  
                  " WHERE t0.bxdjent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("bxdj_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
  LET g_sql = g_sql, " AND t0.bxdjsite = '" ||g_site|| "' "
   #end add-point
   LET g_sql = g_sql, " ORDER BY bxdjdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bxdj_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bxdjdocno
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
         CALL abxt320_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_bxdjdocno) THEN
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
 
{<section id="abxt320.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abxt320_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bxdj_m.bxdjdocno = g_browser[g_current_idx].b_bxdjdocno   
 
   EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
       g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
       g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
   
   CALL abxt320_bxdj_t_mask()
   CALL abxt320_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abxt320.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abxt320_ui_detailshow()
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
 
{<section id="abxt320.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abxt320_ui_browser_refresh()
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
      IF g_browser[l_i].b_bxdjdocno = g_bxdj_m.bxdjdocno 
 
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
 
{<section id="abxt320.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abxt320_construct()
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
   INITIALIZE g_bxdj_m.* TO NULL
   CALL g_bxdk_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON bxdjdocno,bxdjdocdt,bxdj001,bxdj002,bxdjsite,bxdjstus,bxdj010,bxdjownid, 
          bxdjowndp,bxdjcrtid,bxdjcrtdp,bxdjcrtdt,bxdjmodid,bxdjmoddt,bxdjcnfid,bxdjcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bxdjcrtdt>>----
         AFTER FIELD bxdjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bxdjmoddt>>----
         AFTER FIELD bxdjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bxdjcnfdt>>----
         AFTER FIELD bxdjcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bxdjpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.bxdjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjdocno
            #add-point:ON ACTION controlp INFIELD bxdjdocno name="construct.c.bxdjdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxdjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjdocno  #顯示到畫面上
            NEXT FIELD bxdjdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjdocno
            #add-point:BEFORE FIELD bxdjdocno name="construct.b.bxdjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjdocno
            
            #add-point:AFTER FIELD bxdjdocno name="construct.a.bxdjdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjdocdt
            #add-point:BEFORE FIELD bxdjdocdt name="construct.b.bxdjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjdocdt
            
            #add-point:AFTER FIELD bxdjdocdt name="construct.a.bxdjdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjdocdt
            #add-point:ON ACTION controlp INFIELD bxdjdocdt name="construct.c.bxdjdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxdj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdj001
            #add-point:ON ACTION controlp INFIELD bxdj001 name="construct.c.bxdj001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdj001  #顯示到畫面上
            NEXT FIELD bxdj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdj001
            #add-point:BEFORE FIELD bxdj001 name="construct.b.bxdj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdj001
            
            #add-point:AFTER FIELD bxdj001 name="construct.a.bxdj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdj002
            #add-point:ON ACTION controlp INFIELD bxdj002 name="construct.c.bxdj002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdj002  #顯示到畫面上
            NEXT FIELD bxdj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdj002
            #add-point:BEFORE FIELD bxdj002 name="construct.b.bxdj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdj002
            
            #add-point:AFTER FIELD bxdj002 name="construct.a.bxdj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjsite
            #add-point:BEFORE FIELD bxdjsite name="construct.b.bxdjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjsite
            
            #add-point:AFTER FIELD bxdjsite name="construct.a.bxdjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjsite
            #add-point:ON ACTION controlp INFIELD bxdjsite name="construct.c.bxdjsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjstus
            #add-point:BEFORE FIELD bxdjstus name="construct.b.bxdjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjstus
            
            #add-point:AFTER FIELD bxdjstus name="construct.a.bxdjstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjstus
            #add-point:ON ACTION controlp INFIELD bxdjstus name="construct.c.bxdjstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdj010
            #add-point:BEFORE FIELD bxdj010 name="construct.b.bxdj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdj010
            
            #add-point:AFTER FIELD bxdj010 name="construct.a.bxdj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdj010
            #add-point:ON ACTION controlp INFIELD bxdj010 name="construct.c.bxdj010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxdjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjownid
            #add-point:ON ACTION controlp INFIELD bxdjownid name="construct.c.bxdjownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjownid  #顯示到畫面上
            NEXT FIELD bxdjownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjownid
            #add-point:BEFORE FIELD bxdjownid name="construct.b.bxdjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjownid
            
            #add-point:AFTER FIELD bxdjownid name="construct.a.bxdjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjowndp
            #add-point:ON ACTION controlp INFIELD bxdjowndp name="construct.c.bxdjowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjowndp  #顯示到畫面上
            NEXT FIELD bxdjowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjowndp
            #add-point:BEFORE FIELD bxdjowndp name="construct.b.bxdjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjowndp
            
            #add-point:AFTER FIELD bxdjowndp name="construct.a.bxdjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjcrtid
            #add-point:ON ACTION controlp INFIELD bxdjcrtid name="construct.c.bxdjcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjcrtid  #顯示到畫面上
            NEXT FIELD bxdjcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjcrtid
            #add-point:BEFORE FIELD bxdjcrtid name="construct.b.bxdjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjcrtid
            
            #add-point:AFTER FIELD bxdjcrtid name="construct.a.bxdjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjcrtdp
            #add-point:ON ACTION controlp INFIELD bxdjcrtdp name="construct.c.bxdjcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjcrtdp  #顯示到畫面上
            NEXT FIELD bxdjcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjcrtdp
            #add-point:BEFORE FIELD bxdjcrtdp name="construct.b.bxdjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjcrtdp
            
            #add-point:AFTER FIELD bxdjcrtdp name="construct.a.bxdjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjcrtdt
            #add-point:BEFORE FIELD bxdjcrtdt name="construct.b.bxdjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxdjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjmodid
            #add-point:ON ACTION controlp INFIELD bxdjmodid name="construct.c.bxdjmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjmodid  #顯示到畫面上
            NEXT FIELD bxdjmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjmodid
            #add-point:BEFORE FIELD bxdjmodid name="construct.b.bxdjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjmodid
            
            #add-point:AFTER FIELD bxdjmodid name="construct.a.bxdjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjmoddt
            #add-point:BEFORE FIELD bxdjmoddt name="construct.b.bxdjmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxdjcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjcnfid
            #add-point:ON ACTION controlp INFIELD bxdjcnfid name="construct.c.bxdjcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdjcnfid  #顯示到畫面上
            NEXT FIELD bxdjcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjcnfid
            #add-point:BEFORE FIELD bxdjcnfid name="construct.b.bxdjcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjcnfid
            
            #add-point:AFTER FIELD bxdjcnfid name="construct.a.bxdjcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjcnfdt
            #add-point:BEFORE FIELD bxdjcnfdt name="construct.b.bxdjcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bxdkseq,bxdk001,bxdk003,bxdk004,bxdksite
           FROM s_detail1[1].bxdkseq,s_detail1[1].bxdk001,s_detail1[1].bxdk003,s_detail1[1].bxdk004, 
               s_detail1[1].bxdksite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdkseq
            #add-point:BEFORE FIELD bxdkseq name="construct.b.page1.bxdkseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdkseq
            
            #add-point:AFTER FIELD bxdkseq name="construct.a.page1.bxdkseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxdkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdkseq
            #add-point:ON ACTION controlp INFIELD bxdkseq name="construct.c.page1.bxdkseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.bxdk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk001
            #add-point:ON ACTION controlp INFIELD bxdk001 name="construct.c.page1.bxdk001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxdidocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdk001  #顯示到畫面上
            NEXT FIELD bxdk001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk001
            #add-point:BEFORE FIELD bxdk001 name="construct.b.page1.bxdk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk001
            
            #add-point:AFTER FIELD bxdk001 name="construct.a.page1.bxdk001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk003
            #add-point:BEFORE FIELD bxdk003 name="construct.b.page1.bxdk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk003
            
            #add-point:AFTER FIELD bxdk003 name="construct.a.page1.bxdk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxdk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk003
            #add-point:ON ACTION controlp INFIELD bxdk003 name="construct.c.page1.bxdk003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk004
            #add-point:BEFORE FIELD bxdk004 name="construct.b.page1.bxdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk004
            
            #add-point:AFTER FIELD bxdk004 name="construct.a.page1.bxdk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxdk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk004
            #add-point:ON ACTION controlp INFIELD bxdk004 name="construct.c.page1.bxdk004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdksite
            #add-point:BEFORE FIELD bxdksite name="construct.b.page1.bxdksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdksite
            
            #add-point:AFTER FIELD bxdksite name="construct.a.page1.bxdksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bxdksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdksite
            #add-point:ON ACTION controlp INFIELD bxdksite name="construct.c.page1.bxdksite"
            
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
                  WHEN la_wc[li_idx].tableid = "bxdj_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bxdk_t" 
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
 
{<section id="abxt320.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abxt320_filter()
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
      CONSTRUCT g_wc_filter ON bxdjdocno
                          FROM s_browse[1].b_bxdjdocno
 
         BEFORE CONSTRUCT
               DISPLAY abxt320_filter_parser('bxdjdocno') TO s_browse[1].b_bxdjdocno
      
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
 
      CALL abxt320_filter_show('bxdjdocno')
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abxt320_filter_parser(ps_field)
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
 
{<section id="abxt320.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abxt320_filter_show(ps_field)
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
   LET ls_condition = abxt320_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abxt320_query()
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
   CALL g_bxdk_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abxt320_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abxt320_browser_fill("")
      CALL abxt320_fetch("")
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
      CALL abxt320_filter_show('bxdjdocno')
   CALL abxt320_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abxt320_fetch("F") 
      #顯示單身筆數
      CALL abxt320_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abxt320_fetch(p_flag)
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
   
   LET g_bxdj_m.bxdjdocno = g_browser[g_current_idx].b_bxdjdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
       g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
       g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
   
   #遮罩相關處理
   LET g_bxdj_m_mask_o.* =  g_bxdj_m.*
   CALL abxt320_bxdj_t_mask()
   LET g_bxdj_m_mask_n.* =  g_bxdj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abxt320_set_act_visible()   
   CALL abxt320_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_bxdj_m_t.* = g_bxdj_m.*
   LET g_bxdj_m_o.* = g_bxdj_m.*
   
   LET g_data_owner = g_bxdj_m.bxdjownid      
   LET g_data_dept  = g_bxdj_m.bxdjowndp
   
   #重新顯示   
   CALL abxt320_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.insert" >}
#+ 資料新增
PRIVATE FUNCTION abxt320_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bxdk_d.clear()   
 
 
   INITIALIZE g_bxdj_m.* TO NULL             #DEFAULT 設定
   
   LET g_bxdjdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bxdj_m.bxdjownid = g_user
      LET g_bxdj_m.bxdjowndp = g_dept
      LET g_bxdj_m.bxdjcrtid = g_user
      LET g_bxdj_m.bxdjcrtdp = g_dept 
      LET g_bxdj_m.bxdjcrtdt = cl_get_current()
      LET g_bxdj_m.bxdjmodid = g_user
      LET g_bxdj_m.bxdjmoddt = cl_get_current()
      LET g_bxdj_m.bxdjstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_bxdj_m.bxdjdocdt = g_today
      LET g_bxdj_m.bxdj001 = g_user
      LET g_bxdj_m.bxdj002 = g_dept
      LET g_bxdj_m.bxdjsite = g_site
      CALL s_desc_get_person_desc(g_bxdj_m.bxdj001) RETURNING g_bxdj_m.bxdj001_desc
      DISPLAY BY NAME g_bxdj_m.bxdj001_desc      
      CALL s_desc_get_department_desc(g_bxdj_m.bxdj002) RETURNING g_bxdj_m.bxdj002_desc
      DISPLAY BY NAME g_bxdj_m.bxdj002_desc
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bxdj_m_t.* = g_bxdj_m.*
      LET g_bxdj_m_o.* = g_bxdj_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxdj_m.bxdjstus 
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
 
 
 
    
      CALL abxt320_input("a")
      
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
         INITIALIZE g_bxdj_m.* TO NULL
         INITIALIZE g_bxdk_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abxt320_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bxdk_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abxt320_set_act_visible()   
   CALL abxt320_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bxdjent = " ||g_enterprise|| " AND",
                      " bxdjdocno = '", g_bxdj_m.bxdjdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abxt320_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abxt320_cl
   
   CALL abxt320_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
       g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
       g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
   
   
   #遮罩相關處理
   LET g_bxdj_m_mask_o.* =  g_bxdj_m.*
   CALL abxt320_bxdj_t_mask()
   LET g_bxdj_m_mask_n.* =  g_bxdj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocno_desc,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj001_desc, 
       g_bxdj_m.bxdj002,g_bxdj_m.bxdj002_desc,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtid_desc, 
       g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdp_desc,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmodid_desc, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfid_desc,g_bxdj_m.bxdjcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bxdj_m.bxdjownid      
   LET g_data_dept  = g_bxdj_m.bxdjowndp
   
   #功能已完成,通報訊息中心
   CALL abxt320_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.modify" >}
#+ 資料修改
PRIVATE FUNCTION abxt320_modify()
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
   LET g_bxdj_m_t.* = g_bxdj_m.*
   LET g_bxdj_m_o.* = g_bxdj_m.*
   
   IF g_bxdj_m.bxdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
   CALL s_transaction_begin()
   
   OPEN abxt320_cl USING g_enterprise,g_bxdj_m.bxdjdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxt320_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abxt320_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
       g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
       g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
   
   #檢查是否允許此動作
   IF NOT abxt320_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bxdj_m_mask_o.* =  g_bxdj_m.*
   CALL abxt320_bxdj_t_mask()
   LET g_bxdj_m_mask_n.* =  g_bxdj_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL abxt320_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bxdj_m.bxdjmodid = g_user 
LET g_bxdj_m.bxdjmoddt = cl_get_current()
LET g_bxdj_m.bxdjmodid_desc = cl_get_username(g_bxdj_m.bxdjmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abxt320_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bxdj_t SET (bxdjmodid,bxdjmoddt) = (g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmoddt)
          WHERE bxdjent = g_enterprise AND bxdjdocno = g_bxdjdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bxdj_m.* = g_bxdj_m_t.*
            CALL abxt320_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bxdj_m.bxdjdocno != g_bxdj_m_t.bxdjdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bxdk_t SET bxdkdocno = g_bxdj_m.bxdjdocno
 
          WHERE bxdkent = g_enterprise AND bxdkdocno = g_bxdj_m_t.bxdjdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bxdk_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bxdk_t:",SQLERRMESSAGE 
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
   CALL abxt320_set_act_visible()   
   CALL abxt320_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bxdjent = " ||g_enterprise|| " AND",
                      " bxdjdocno = '", g_bxdj_m.bxdjdocno, "' "
 
   #填到對應位置
   CALL abxt320_browser_fill("")
 
   CLOSE abxt320_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abxt320_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abxt320.input" >}
#+ 資料輸入
PRIVATE FUNCTION abxt320_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_errno                LIKE type_t.chr10
   DEFINE l_ooef004              LIKE ooef_t.ooef004
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
   DISPLAY BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocno_desc,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj001_desc, 
       g_bxdj_m.bxdj002,g_bxdj_m.bxdj002_desc,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtid_desc, 
       g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdp_desc,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmodid_desc, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfid_desc,g_bxdj_m.bxdjcnfdt
   
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
   LET g_forupd_sql = "SELECT bxdkseq,bxdk001,bxdk002,bxdk003,bxdk004,bxdksite FROM bxdk_t WHERE bxdkent=?  
       AND bxdkdocno=? AND bxdkseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abxt320_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abxt320_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abxt320_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite, 
       g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abxt320.input.head" >}
      #單頭段
      INPUT BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite, 
          g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abxt320_cl USING g_enterprise,g_bxdj_m.bxdjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abxt320_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abxt320_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abxt320_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abxt320_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjdocno
            
            #add-point:AFTER FIELD bxdjdocno name="input.a.bxdjdocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_bxdj_m.bxdjdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bxdj_m.bxdjdocno != g_bxdjdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxdj_t WHERE "||"bxdjent = '" ||g_enterprise|| "' AND "||"bxdjdocno = '"||g_bxdj_m.bxdjdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_bxdj_m.bxdjdocno,g_prog) THEN
                     LET g_bxdj_m.bxdjdocno = g_bxdjdocno_t
                     CALL abxt320_bxdjdocno_ref()
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjdocno
            #add-point:BEFORE FIELD bxdjdocno name="input.b.bxdjdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdjdocno
            #add-point:ON CHANGE bxdjdocno name="input.g.bxdjdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjdocdt
            #add-point:BEFORE FIELD bxdjdocdt name="input.b.bxdjdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjdocdt
            
            #add-point:AFTER FIELD bxdjdocdt name="input.a.bxdjdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdjdocdt
            #add-point:ON CHANGE bxdjdocdt name="input.g.bxdjdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdj001
            
            #add-point:AFTER FIELD bxdj001 name="input.a.bxdj001"
            CALL s_desc_get_person_desc(g_bxdj_m.bxdj001) RETURNING g_bxdj_m.bxdj001_desc
            DISPLAY BY NAME g_bxdj_m.bxdj001_desc
            IF NOT cl_null(g_bxdj_m.bxdj001) THEN 
               IF g_bxdj_m.bxdj001 != g_bxdj_m_o.bxdj001 OR cl_null(g_bxdj_m_o.bxdj001) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_bxdj_m.bxdj001
                  #160318-00025#27  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#27  by 07900 --add-end
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_bxdj_m.bxdj002 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_bxdj_m.bxdj001
                     CALL s_desc_get_department_desc(g_bxdj_m.bxdj002) RETURNING g_bxdj_m.bxdj002_desc
                     DISPLAY BY NAME g_bxdj_m.bxdj002,g_bxdj_m.bxdj002_desc 
                  ELSE
                     LET g_bxdj_m.bxdj001 = g_bxdj_m_o.bxdj001
                     CALL s_desc_get_person_desc(g_bxdj_m.bxdj001) RETURNING g_bxdj_m.bxdj001_desc
                     DISPLAY BY NAME g_bxdj_m.bxdj001_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
            END IF
            LET g_bxdj_m_o.bxdj001 = g_bxdj_m.bxdj001
            #CALL abxt320_bxdk001_def()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdj001
            #add-point:BEFORE FIELD bxdj001 name="input.b.bxdj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdj001
            #add-point:ON CHANGE bxdj001 name="input.g.bxdj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdj002
            
            #add-point:AFTER FIELD bxdj002 name="input.a.bxdj002"
            IF NOT cl_null(g_bxdj_m.bxdj002) THEN 
                  INITIALIZE g_chkparam.* TO NULL          
                  #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_bxdj_m.bxdj002
                   LET g_chkparam.arg2 = g_bxdj_m.bxdjdocdt
                  #160318-00025#27  by 07900 --add-str
                   LET g_errshow = TRUE #是否開窗                   
                   LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#27  by 07900 --add-end                    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN                                                 
                    LET g_bxdj_m.bxdj002 = g_bxdj_m_t.bxdj002
                    CALL s_desc_get_department_desc(g_bxdj_m.bxdj002) RETURNING g_bxdj_m.bxdj002_desc
                    DISPLAY BY NAME g_bxdj_m.bxdj002_desc 
                    NEXT FIELD CURRENT
                  END IF     
            END IF 
            
            LET g_bxdj_m_o.bxdj002 = g_bxdj_m.bxdj002
            CALL s_desc_get_department_desc(g_bxdj_m.bxdj002) RETURNING g_bxdj_m.bxdj002_desc
            DISPLAY BY NAME g_bxdj_m.bxdj002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdj002
            #add-point:BEFORE FIELD bxdj002 name="input.b.bxdj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdj002
            #add-point:ON CHANGE bxdj002 name="input.g.bxdj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjsite
            #add-point:BEFORE FIELD bxdjsite name="input.b.bxdjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjsite
            
            #add-point:AFTER FIELD bxdjsite name="input.a.bxdjsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdjsite
            #add-point:ON CHANGE bxdjsite name="input.g.bxdjsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdjstus
            #add-point:BEFORE FIELD bxdjstus name="input.b.bxdjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdjstus
            
            #add-point:AFTER FIELD bxdjstus name="input.a.bxdjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdjstus
            #add-point:ON CHANGE bxdjstus name="input.g.bxdjstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdj010
            #add-point:BEFORE FIELD bxdj010 name="input.b.bxdj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdj010
            
            #add-point:AFTER FIELD bxdj010 name="input.a.bxdj010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdj010
            #add-point:ON CHANGE bxdj010 name="input.g.bxdj010"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bxdjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjdocno
            #add-point:ON ACTION controlp INFIELD bxdjdocno name="input.c.bxdjdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bxdj_m.bxdjdocno             #給予default值

            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise  
            
            #給予arg
            LET g_qryparam.arg1 = l_ooef004 
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_bxdj_m.bxdjdocno = g_qryparam.return1              

            DISPLAY g_bxdj_m.bxdjdocno TO bxdjdocno              #
            CALL abxt320_bxdjdocno_ref()
            NEXT FIELD bxdjdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bxdjdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjdocdt
            #add-point:ON ACTION controlp INFIELD bxdjdocdt name="input.c.bxdjdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxdj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdj001
            #add-point:ON ACTION controlp INFIELD bxdj001 name="input.c.bxdj001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bxdj_m.bxdj001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_bxdj_m.bxdj001 = g_qryparam.return1              

            DISPLAY g_bxdj_m.bxdj001 TO bxdj001              #

            NEXT FIELD bxdj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bxdj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdj002
            #add-point:ON ACTION controlp INFIELD bxdj002 name="input.c.bxdj002"
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bxdj_m.bxdj002              #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_bxdj_m.bxdjdocdt
            CALL q_ooeg001()                                #呼叫開窗
            LET g_bxdj_m.bxdj002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_bxdj_m.bxdj002 TO bxdj002              #顯示到畫面上
            NEXT FIELD bxdj002                          #返回原欄位
            

            #END add-point
 
 
         #Ctrlp:input.c.bxdjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjsite
            #add-point:ON ACTION controlp INFIELD bxdjsite name="input.c.bxdjsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxdjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdjstus
            #add-point:ON ACTION controlp INFIELD bxdjstus name="input.c.bxdjstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxdj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdj010
            #add-point:ON ACTION controlp INFIELD bxdj010 name="input.c.bxdj010"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bxdj_m.bxdjdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #取單號
               CALL s_aooi200_gen_docno(g_site,g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt,g_prog) RETURNING l_success,g_bxdj_m.bxdjdocno 
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_bxdj_m.bxdjdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD bxdjdocno
                  CONTINUE DIALOG
               END IF 
               DISPLAY BY NAME g_bxdj_m.bxdjdocno 
               #end add-point
               
               INSERT INTO bxdj_t (bxdjent,bxdjdocno,bxdjdocdt,bxdj001,bxdj002,bxdjsite,bxdjstus,bxdj010, 
                   bxdjownid,bxdjowndp,bxdjcrtid,bxdjcrtdp,bxdjcrtdt,bxdjmodid,bxdjmoddt,bxdjcnfid,bxdjcnfdt) 
 
               VALUES (g_enterprise,g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj002, 
                   g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid,g_bxdj_m.bxdjowndp, 
                   g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmoddt, 
                   g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bxdj_m:",SQLERRMESSAGE 
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
                  CALL abxt320_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abxt320_b_fill()
                  CALL abxt320_b_fill2('0')
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
               CALL abxt320_bxdj_t_mask_restore('restore_mask_o')
               
               UPDATE bxdj_t SET (bxdjdocno,bxdjdocdt,bxdj001,bxdj002,bxdjsite,bxdjstus,bxdj010,bxdjownid, 
                   bxdjowndp,bxdjcrtid,bxdjcrtdp,bxdjcrtdt,bxdjmodid,bxdjmoddt,bxdjcnfid,bxdjcnfdt) = (g_bxdj_m.bxdjdocno, 
                   g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus, 
                   g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid,g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp, 
                   g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt) 
 
                WHERE bxdjent = g_enterprise AND bxdjdocno = g_bxdjdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bxdj_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abxt320_bxdj_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bxdj_m_t)
               LET g_log2 = util.JSON.stringify(g_bxdj_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abxt320.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bxdk_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bxdk_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abxt320_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bxdk_d.getLength()
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
            OPEN abxt320_cl USING g_enterprise,g_bxdj_m.bxdjdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abxt320_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abxt320_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bxdk_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bxdk_d[l_ac].bxdkseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bxdk_d_t.* = g_bxdk_d[l_ac].*  #BACKUP
               LET g_bxdk_d_o.* = g_bxdk_d[l_ac].*  #BACKUP
               CALL abxt320_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abxt320_set_no_entry_b(l_cmd)
               IF NOT abxt320_lock_b("bxdk_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abxt320_bcl INTO g_bxdk_d[l_ac].bxdkseq,g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002, 
                      g_bxdk_d[l_ac].bxdk003,g_bxdk_d[l_ac].bxdk004,g_bxdk_d[l_ac].bxdksite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bxdk_d_t.bxdkseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bxdk_d_mask_o[l_ac].* =  g_bxdk_d[l_ac].*
                  CALL abxt320_bxdk_t_mask()
                  LET g_bxdk_d_mask_n[l_ac].* =  g_bxdk_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abxt320_show()
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
            INITIALIZE g_bxdk_d[l_ac].* TO NULL 
            INITIALIZE g_bxdk_d_t.* TO NULL 
            INITIALIZE g_bxdk_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_bxdk_d[l_ac].bxdk003 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #項次加1
            SELECT MAX(bxdkseq)+1 INTO g_bxdk_d[l_ac].bxdkseq
              FROM bxdk_t
             WHERE bxdkent = g_enterprise
               AND bxdkdocno = g_bxdj_m.bxdjdocno
            IF cl_null(g_bxdk_d[l_ac].bxdkseq) OR g_bxdk_d[l_ac].bxdkseq = 0 THEN
               LET g_bxdk_d[l_ac].bxdkseq = 1
            END IF           
            #給預設值
            LET g_bxdk_d[l_ac].bxdk003 = ''            
            LET g_bxdk_d[l_ac].bxdksite = g_site       
            #end add-point
            LET g_bxdk_d_t.* = g_bxdk_d[l_ac].*     #新輸入資料
            LET g_bxdk_d_o.* = g_bxdk_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abxt320_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abxt320_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bxdk_d[li_reproduce_target].* = g_bxdk_d[li_reproduce].*
 
               LET g_bxdk_d[li_reproduce_target].bxdkseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bxdk_t 
             WHERE bxdkent = g_enterprise AND bxdkdocno = g_bxdj_m.bxdjdocno
 
               AND bxdkseq = g_bxdk_d[l_ac].bxdkseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bxdj_m.bxdjdocno
               LET gs_keys[2] = g_bxdk_d[g_detail_idx].bxdkseq
               CALL abxt320_insert_b('bxdk_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bxdk_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bxdk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abxt320_b_fill()
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
               LET gs_keys[01] = g_bxdj_m.bxdjdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_bxdk_d_t.bxdkseq
 
            
               #刪除同層單身
               IF NOT abxt320_delete_b('bxdk_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abxt320_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abxt320_key_delete_b(gs_keys,'bxdk_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abxt320_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abxt320_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bxdk_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bxdk_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdkseq
            #add-point:BEFORE FIELD bxdkseq name="input.b.page1.bxdkseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdkseq
            
            #add-point:AFTER FIELD bxdkseq name="input.a.page1.bxdkseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_bxdj_m.bxdjdocno IS NOT NULL AND g_bxdk_d[g_detail_idx].bxdkseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bxdj_m.bxdjdocno != g_bxdjdocno_t OR g_bxdk_d[g_detail_idx].bxdkseq != g_bxdk_d_t.bxdkseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxdk_t WHERE "||"bxdkent = '" ||g_enterprise|| "' AND "||"bxdkdocno = '"||g_bxdj_m.bxdjdocno ||"' AND "|| "bxdkseq = '"||g_bxdk_d[g_detail_idx].bxdkseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdkseq
            #add-point:ON CHANGE bxdkseq name="input.g.page1.bxdkseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk001
            #add-point:BEFORE FIELD bxdk001 name="input.b.page1.bxdk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk001
            
            #add-point:AFTER FIELD bxdk001 name="input.a.page1.bxdk001"
            IF NOT cl_null(g_bxdk_d[l_ac].bxdk001) THEN
              IF g_bxdk_d[l_ac].bxdk001 <> g_bxdk_d_o.bxdk001 OR cl_null(g_bxdk_d_o.bxdk001) THEN
                 CALL abxt320_bxdk001_chk(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002) RETURNING l_success,l_errno
                 IF NOT l_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = l_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_bxdk_d[l_ac].bxdk001 = g_bxdk_d_o.bxdk001
                   CALL abxt320_bxdk001_init(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002)
                   NEXT FIELD CURRENT    
                 END IF
                 
                 #20160314 s983961--add(s)
                 IF NOT cl_null(g_bxdk_d[l_ac].bxdk002) AND NOT cl_null(g_bxdk_d[l_ac].bxdk003) THEN
                    CALL abxt320_bxdk003_chk(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002,g_bxdk_d[l_ac].bxdk003,g_bxdj_m.bxdjdocno) RETURNING l_success,l_errno
                    IF NOT l_success THEN                   
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = l_errno
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_bxdk_d[l_ac].bxdk003 = g_bxdk_d_t.bxdk003                      
                      NEXT FIELD bxdk003                   
                    END IF
                 END IF   
                 #20160314 s983961--add(e)
              END IF
            END IF
            LET g_bxdk_d_o.bxdk001 = g_bxdk_d[l_ac].bxdk001
            CALL abxt320_bxdk001_init(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002)                          
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdk001
            #add-point:ON CHANGE bxdk001 name="input.g.page1.bxdk001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk002
            #add-point:BEFORE FIELD bxdk002 name="input.b.page1.bxdk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk002
            
            #add-point:AFTER FIELD bxdk002 name="input.a.page1.bxdk002"
            IF NOT cl_null(g_bxdk_d[l_ac].bxdk002) THEN
              IF g_bxdk_d[l_ac].bxdk002 <> g_bxdk_d_o.bxdk002 OR cl_null(g_bxdk_d_o.bxdk002) THEN
                 CALL abxt320_bxdk002_chk(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002) RETURNING l_success,l_errno
                 IF NOT l_success THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = l_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_bxdk_d[l_ac].bxdk002 = g_bxdk_d_o.bxdk002
                   CALL abxt320_bxdk001_init(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002) 
                   #CALL abxt320_bxdk001_def()
                   NEXT FIELD CURRENT
                 END IF
                 
                 #20160314 s983961--add(s)
                 IF NOT cl_null(g_bxdk_d[l_ac].bxdk001) AND NOT cl_null(g_bxdk_d[l_ac].bxdk003) THEN
                    CALL abxt320_bxdk003_chk(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002,g_bxdk_d[l_ac].bxdk003,g_bxdj_m.bxdjdocno) RETURNING l_success,l_errno
                    IF NOT l_success THEN                   
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = l_errno
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_bxdk_d[l_ac].bxdk003 = g_bxdk_d_t.bxdk003                      
                      NEXT FIELD bxdk003                   
                    END IF
                 END IF   
                 #20160314 s983961--add(e)
              END IF
            END IF
            
            CALL abxt320_bxdk001_init(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002) 
            LET g_bxdk_d_o.bxdk002 = g_bxdk_d[l_ac].bxdk002
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdk002
            #add-point:ON CHANGE bxdk002 name="input.g.page1.bxdk002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bxdk_d[l_ac].bxdk003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bxdk003
            END IF 
 
 
 
            #add-point:AFTER FIELD bxdk003 name="input.a.page1.bxdk003"
            IF NOT cl_null(g_bxdk_d[l_ac].bxdk003) THEN
              IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_bxdk_d[l_ac].bxdk003 != g_bxdk_d_t.bxdk003 OR g_bxdk_d_t.bxdk003 IS NULL )) THEN
                 CALL abxt320_bxdk003_chk(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002,g_bxdk_d[l_ac].bxdk003,g_bxdj_m.bxdjdocno) RETURNING l_success,l_errno
                 IF NOT l_success THEN                   
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = l_errno
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET g_bxdk_d[l_ac].bxdk003 = g_bxdk_d_t.bxdk003
                   
                   IF cl_null(g_bxdk_d[l_ac].bxdk001) THEN
                     NEXT FIELD bxdk001
                   END IF
                   IF cl_null(g_bxdk_d[l_ac].bxdk002) THEN
                     NEXT FIELD bxdk002
                   ELSE
                     NEXT FIELD CURRENT
                   END IF                     
                 END IF
              END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk003
            #add-point:BEFORE FIELD bxdk003 name="input.b.page1.bxdk003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdk003
            #add-point:ON CHANGE bxdk003 name="input.g.page1.bxdk003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdk004
            #add-point:BEFORE FIELD bxdk004 name="input.b.page1.bxdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdk004
            
            #add-point:AFTER FIELD bxdk004 name="input.a.page1.bxdk004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdk004
            #add-point:ON CHANGE bxdk004 name="input.g.page1.bxdk004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdksite
            #add-point:BEFORE FIELD bxdksite name="input.b.page1.bxdksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdksite
            
            #add-point:AFTER FIELD bxdksite name="input.a.page1.bxdksite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdksite
            #add-point:ON CHANGE bxdksite name="input.g.page1.bxdksite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bxdkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdkseq
            #add-point:ON ACTION controlp INFIELD bxdkseq name="input.c.page1.bxdkseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxdk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk001
            #add-point:ON ACTION controlp INFIELD bxdk001 name="input.c.page1.bxdk001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bxdk_d[l_ac].bxdk001             #給予default值
            LET g_qryparam.default2 = ''           #g_bxdk_d[l_ac].bxdiseq #項次
            
            CALL q_bxdidocno()                                #呼叫開窗

            LET g_bxdk_d[l_ac].bxdk001 = g_qryparam.return1              
            LET g_bxdk_d[l_ac].bxdk002 = g_qryparam.return2 
            DISPLAY g_bxdk_d[l_ac].bxdk001 TO bxdk001              #
            DISPLAY g_bxdk_d[l_ac].bxdk002 TO bxdk002 
            #DISPLAY g_bxdk_d[l_ac].bxdiseq TO bxdiseq #項次
            NEXT FIELD bxdk001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.bxdk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk002
            #add-point:ON ACTION controlp INFIELD bxdk002 name="input.c.page1.bxdk002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bxdk_d[l_ac].bxdk001             #給予default值
            LET g_qryparam.default2 = ''           #g_bxdk_d[l_ac].bxdiseq #項次
            
            CALL q_bxdidocno()                                #呼叫開窗

            LET g_bxdk_d[l_ac].bxdk001 = g_qryparam.return1              
            LET g_bxdk_d[l_ac].bxdk002 = g_qryparam.return2 
            DISPLAY g_bxdk_d[l_ac].bxdk001 TO bxdk001              
            DISPLAY g_bxdk_d[l_ac].bxdk002 TO bxdk002
   
            NEXT FIELD bxdk002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxdk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk003
            #add-point:ON ACTION controlp INFIELD bxdk003 name="input.c.page1.bxdk003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxdk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdk004
            #add-point:ON ACTION controlp INFIELD bxdk004 name="input.c.page1.bxdk004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bxdksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdksite
            #add-point:ON ACTION controlp INFIELD bxdksite name="input.c.page1.bxdksite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bxdk_d[l_ac].* = g_bxdk_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abxt320_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bxdk_d[l_ac].bxdkseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bxdk_d[l_ac].* = g_bxdk_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL abxt320_bxdk_t_mask_restore('restore_mask_o')
      
               UPDATE bxdk_t SET (bxdkdocno,bxdkseq,bxdk001,bxdk002,bxdk003,bxdk004,bxdksite) = (g_bxdj_m.bxdjdocno, 
                   g_bxdk_d[l_ac].bxdkseq,g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002,g_bxdk_d[l_ac].bxdk003, 
                   g_bxdk_d[l_ac].bxdk004,g_bxdk_d[l_ac].bxdksite)
                WHERE bxdkent = g_enterprise AND bxdkdocno = g_bxdj_m.bxdjdocno 
 
                  AND bxdkseq = g_bxdk_d_t.bxdkseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bxdk_d[l_ac].* = g_bxdk_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxdk_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bxdk_d[l_ac].* = g_bxdk_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bxdk_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bxdj_m.bxdjdocno
               LET gs_keys_bak[1] = g_bxdjdocno_t
               LET gs_keys[2] = g_bxdk_d[g_detail_idx].bxdkseq
               LET gs_keys_bak[2] = g_bxdk_d_t.bxdkseq
               CALL abxt320_update_b('bxdk_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abxt320_bxdk_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bxdk_d[g_detail_idx].bxdkseq = g_bxdk_d_t.bxdkseq 
 
                  ) THEN
                  LET gs_keys[01] = g_bxdj_m.bxdjdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bxdk_d_t.bxdkseq
 
                  CALL abxt320_key_update_b(gs_keys,'bxdk_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bxdj_m),util.JSON.stringify(g_bxdk_d_t)
               LET g_log2 = util.JSON.stringify(g_bxdj_m),util.JSON.stringify(g_bxdk_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abxt320_unlock_b("bxdk_t","'1'")
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
               LET g_bxdk_d[li_reproduce_target].* = g_bxdk_d[li_reproduce].*
 
               LET g_bxdk_d[li_reproduce_target].bxdkseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bxdk_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bxdk_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="abxt320.input.other" >}
      
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
            NEXT FIELD bxdjdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bxdkseq
 
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
   IF NOT abxt320_bxdk_chk(g_bxdj_m.bxdjdocno) THEN
      IF cl_ask_confirm('abx-00007') THEN
         CALL abxt320_bxdj_del(g_bxdj_m.bxdjdocno)
         RETURNING l_success   
         IF l_success THEN
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF               
            IF NOT s_aooi200_del_docno(g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt) THEN
               CALL s_transaction_end('N','0')
            ELSE            
               CALL s_transaction_end('Y','0')
            END IF
         END IF   
         #CALL abxt320_delete()
         CALL abxt320_browser_fill("")
         CALL abxt320_b_fill()
      ELSE
         CALL abxt320_b_fill()         
      END IF
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abxt320_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abxt320_b_fill() #單身填充
      CALL abxt320_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abxt320_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL abxt320_bxdjdocno_ref()
   #end add-point
   
   #遮罩相關處理
   LET g_bxdj_m_mask_o.* =  g_bxdj_m.*
   CALL abxt320_bxdj_t_mask()
   LET g_bxdj_m_mask_n.* =  g_bxdj_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocno_desc,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj001_desc, 
       g_bxdj_m.bxdj002,g_bxdj_m.bxdj002_desc,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtid_desc, 
       g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdp_desc,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmodid_desc, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfid_desc,g_bxdj_m.bxdjcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxdj_m.bxdjstus 
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
   FOR l_ac = 1 TO g_bxdk_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

   #INITIALIZE g_ref_fields TO NULL 
   #LET g_ref_fields[1] = g_bxdj_m.bxdjdocno
   #LET g_ref_fields[2] = g_bxdk_d[l_ac].bxdkseq
   #CALL ap_ref_array2(g_ref_fields," SELECT bxdi001,bxdi002 FROM bxdi_t WHERE bxdient = '"||g_enterprise||"' AND bxdidocno = ? AND bxdiseq = ? ","") RETURNING g_rtn_fields 
   #LET g_bxdk_d[l_ac].bxdi001 = g_rtn_fields[1] 
   #LET g_bxdk_d[l_ac].bxdi002 = g_rtn_fields[2] 
   #DISPLAY BY NAME g_bxdk_d[l_ac].bxdi001,g_bxdk_d[l_ac].bxdi002
   #INITIALIZE g_ref_fields TO NULL 
   #LET g_ref_fields[1] = g_bxdj_m.bxdjdocno
   #LET g_ref_fields[2] = g_bxdk_d[l_ac].bxdkseq
   #CALL ap_ref_array2(g_ref_fields," SELECT bxdc003,bxdc004 FROM bxdc_t WHERE bxdcent = '"||g_enterprise||"' AND bxdcsite = ? AND bxdc001 = ? AND bxdc002 = ? ","") RETURNING g_rtn_fields 
   #LET g_bxdk_d[l_ac].bxdc003 = g_rtn_fields[1] 
   #LET g_bxdk_d[l_ac].bxdc004 = g_rtn_fields[2] 
   #DISPLAY BY NAME g_bxdk_d[l_ac].bxdc003,g_bxdk_d[l_ac].bxdc004
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abxt320_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abxt320_detail_show()
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
 
{<section id="abxt320.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abxt320_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bxdj_t.bxdjdocno 
   DEFINE l_oldno     LIKE bxdj_t.bxdjdocno 
 
   DEFINE l_master    RECORD LIKE bxdj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bxdk_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_bxdj_m.bxdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
    
   LET g_bxdj_m.bxdjdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bxdj_m.bxdjownid = g_user
      LET g_bxdj_m.bxdjowndp = g_dept
      LET g_bxdj_m.bxdjcrtid = g_user
      LET g_bxdj_m.bxdjcrtdp = g_dept 
      LET g_bxdj_m.bxdjcrtdt = cl_get_current()
      LET g_bxdj_m.bxdjmodid = g_user
      LET g_bxdj_m.bxdjmoddt = cl_get_current()
      LET g_bxdj_m.bxdjstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bxdj_m.bxdjcnfid = ''
   LET g_bxdj_m.bxdjcnfdt = ''
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bxdj_m.bxdjstus 
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
      LET g_bxdj_m.bxdjdocno_desc = ''
   DISPLAY BY NAME g_bxdj_m.bxdjdocno_desc
 
   
   CALL abxt320_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bxdj_m.* TO NULL
      INITIALIZE g_bxdk_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abxt320_show()
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
   CALL abxt320_set_act_visible()   
   CALL abxt320_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " bxdjent = " ||g_enterprise|| " AND",
                      " bxdjdocno = '", g_bxdj_m.bxdjdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abxt320_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abxt320_idx_chk()
   
   LET g_data_owner = g_bxdj_m.bxdjownid      
   LET g_data_dept  = g_bxdj_m.bxdjowndp
   
   #功能已完成,通報訊息中心
   CALL abxt320_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abxt320_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bxdk_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_bxdk001    LIKE bxdk_t.bxdk001
   DEFINE l_bxdk002    LIKE bxdk_t.bxdk002
   DEFINE l_bxdk003    LIKE bxdk_t.bxdk003
   DEFINE l_bxdk003_2  LIKE bxdk_t.bxdk003   
   DEFINE l_bxdi003   LIKE  bxdi_t.bxdi003   #外送數量
   DEFINE l_bxdi006   LIKE  bxdi_t.bxdi006   #已回收數量
   DEFINE l_amount    LIKE  bxdk_t.bxdk003   #可收回輸量
   DEFINE l_success    LIKE type_t.num5 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abxt320_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bxdk_t
    WHERE bxdkent = g_enterprise AND bxdkdocno = g_bxdjdocno_t
 
    INTO TEMP abxt320_detail
 
   #將key修正為調整後   
   UPDATE abxt320_detail 
      #更新key欄位
      SET bxdkdocno = g_bxdj_m.bxdjdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #20160314 s983961--add(s)
   SELECT bxdk001,bxdk002,bxdk003 INTO l_bxdk001,l_bxdk002,l_bxdk003
     FROM abxt320_detail
    WHERE bxdkdocno = g_bxdj_m.bxdjdocno
    
   IF NOT cl_null(l_bxdk001) AND NOT cl_null(l_bxdk002) AND NOT cl_null(l_bxdk003) THEN
      SELECT bxdi003,bxdi006 INTO l_bxdi003,l_bxdi006
        FROM bxdi_t 
       WHERE bxdidocno = l_bxdk001 AND bxdiseq = l_bxdk002 AND bxdient = g_enterprise
      
      SELECT SUM(bxdk003) INTO l_bxdk003_2
           FROM bxdk_t,bxdj_t     
          WHERE bxdkent = bxdjent
            AND bxdkdocno = bxdjdocno
            AND bxdk001 = l_bxdk001
            AND bxdk002 = l_bxdk002
            AND bxdjstus = 'N'
            
      LET l_bxdk003 = l_bxdk003 + l_bxdk003_2  
      
      
      LET l_amount = l_bxdi003 - l_bxdi006   
      IF l_bxdk003 > l_amount THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'abx-00013'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN                  

      END IF
   END IF  
   #20160314 s983961--add(e)
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bxdk_t SELECT * FROM abxt320_detail
   
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
   DROP TABLE abxt320_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abxt320_delete()
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
   
   IF g_bxdj_m.bxdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abxt320_cl USING g_enterprise,g_bxdj_m.bxdjdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxt320_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abxt320_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
       g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
       g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT abxt320_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bxdj_m_mask_o.* =  g_bxdj_m.*
   CALL abxt320_bxdj_t_mask()
   LET g_bxdj_m_mask_n.* =  g_bxdj_m.*
   
   CALL abxt320_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abxt320_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bxdjdocno_t = g_bxdj_m.bxdjdocno
 
 
      DELETE FROM bxdj_t
       WHERE bxdjent = g_enterprise AND bxdjdocno = g_bxdj_m.bxdjdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bxdj_m.bxdjdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bxdk_t
       WHERE bxdkent = g_enterprise AND bxdkdocno = g_bxdj_m.bxdjdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bxdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bxdj_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abxt320_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bxdk_d.clear() 
 
     
      CALL abxt320_ui_browser_refresh()  
      #CALL abxt320_ui_headershow()  
      #CALL abxt320_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abxt320_browser_fill("")
         CALL abxt320_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abxt320_cl
 
   #功能已完成,通報訊息中心
   CALL abxt320_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abxt320.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abxt320_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_bxdisite LIKE bxdi_t.bxdisite
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bxdk_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abxt320_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bxdkseq,bxdk001,bxdk002,bxdk003,bxdk004,bxdksite  FROM bxdk_t", 
                
                     " INNER JOIN bxdj_t ON bxdjent = " ||g_enterprise|| " AND bxdjdocno = bxdkdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE bxdkent=? AND bxdkdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bxdk_t.bxdkseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abxt320_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abxt320_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bxdj_m.bxdjdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bxdj_m.bxdjdocno INTO g_bxdk_d[l_ac].bxdkseq,g_bxdk_d[l_ac].bxdk001, 
          g_bxdk_d[l_ac].bxdk002,g_bxdk_d[l_ac].bxdk003,g_bxdk_d[l_ac].bxdk004,g_bxdk_d[l_ac].bxdksite  
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
         CALL abxt320_bxdk001_init(g_bxdk_d[l_ac].bxdk001,g_bxdk_d[l_ac].bxdk002)        
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
   
   CALL g_bxdk_d.deleteElement(g_bxdk_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abxt320_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bxdk_d.getLength()
      LET g_bxdk_d_mask_o[l_ac].* =  g_bxdk_d[l_ac].*
      CALL abxt320_bxdk_t_mask()
      LET g_bxdk_d_mask_n[l_ac].* =  g_bxdk_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abxt320_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bxdk_t
       WHERE bxdkent = g_enterprise AND
         bxdkdocno = ps_keys_bak[1] AND bxdkseq = ps_keys_bak[2]
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
         CALL g_bxdk_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abxt320_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO bxdk_t
                  (bxdkent,
                   bxdkdocno,
                   bxdkseq
                   ,bxdk001,bxdk002,bxdk003,bxdk004,bxdksite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_bxdk_d[g_detail_idx].bxdk001,g_bxdk_d[g_detail_idx].bxdk002,g_bxdk_d[g_detail_idx].bxdk003, 
                       g_bxdk_d[g_detail_idx].bxdk004,g_bxdk_d[g_detail_idx].bxdksite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bxdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bxdk_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abxt320_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bxdk_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abxt320_bxdk_t_mask_restore('restore_mask_o')
               
      UPDATE bxdk_t 
         SET (bxdkdocno,
              bxdkseq
              ,bxdk001,bxdk002,bxdk003,bxdk004,bxdksite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_bxdk_d[g_detail_idx].bxdk001,g_bxdk_d[g_detail_idx].bxdk002,g_bxdk_d[g_detail_idx].bxdk003, 
                  g_bxdk_d[g_detail_idx].bxdk004,g_bxdk_d[g_detail_idx].bxdksite) 
         WHERE bxdkent = g_enterprise AND bxdkdocno = ps_keys_bak[1] AND bxdkseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bxdk_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bxdk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abxt320_bxdk_t_mask_restore('restore_mask_n')
               
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
 
{<section id="abxt320.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abxt320_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="abxt320.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abxt320_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abxt320.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abxt320_lock_b(ps_table,ps_page)
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
   #CALL abxt320_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bxdk_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abxt320_bcl USING g_enterprise,
                                       g_bxdj_m.bxdjdocno,g_bxdk_d[g_detail_idx].bxdkseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abxt320_bcl:",SQLERRMESSAGE 
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
 
{<section id="abxt320.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abxt320_unlock_b(ps_table,ps_page)
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
      CLOSE abxt320_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abxt320_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("bxdjdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bxdjdocno",TRUE)
      CALL cl_set_comp_entry("bxdjdocdt",TRUE)
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
 
{<section id="abxt320.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abxt320_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bxdjdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("bxdjdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("bxdjdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abxt320.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abxt320_set_entry_b(p_cmd)
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
 
{<section id="abxt320.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abxt320_set_no_entry_b(p_cmd)
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
 
{<section id="abxt320.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abxt320_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("signing,withdraw",TRUE)
   CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abxt320_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_bxdj_m.bxdjstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   CASE g_bxdj_m.bxdjstus
      WHEN "N"
         CALL cl_set_act_visible("unconfirmed",FALSE)
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed",FALSE)
         END IF
      WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
         CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         END IF         
      WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
         CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         IF cl_bpm_chk() THEN   #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         END IF         
      WHEN "X"
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
      WHEN "Y"
         CALL cl_set_act_visible("invalid,confirmed",FALSE)
      WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)      
      WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
          CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
   END CASE

   IF NOT cl_bpm_chk() THEN   #不需提交至BPM時
      CALL cl_set_act_visible("signing,withdraw",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abxt320_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abxt320_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abxt320_default_search()
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
      LET ls_wc = ls_wc, " bxdjdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "bxdj_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bxdk_t" 
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
 
{<section id="abxt320.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abxt320_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success         LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bxdj_m.bxdjdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abxt320_cl USING g_enterprise,g_bxdj_m.bxdjdocno
   IF STATUS THEN
      CLOSE abxt320_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abxt320_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
       g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
       g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT abxt320_action_chk() THEN
      CLOSE abxt320_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocno_desc,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001,g_bxdj_m.bxdj001_desc, 
       g_bxdj_m.bxdj002,g_bxdj_m.bxdj002_desc,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
       g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtid_desc, 
       g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdp_desc,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmodid_desc, 
       g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfid_desc,g_bxdj_m.bxdjcnfdt
 
   CASE g_bxdj_m.bxdjstus
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
         CASE g_bxdj_m.bxdjstus
            
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
      CALL abxt320_set_act_visible()   
      CALL abxt320_set_act_no_visible()
      
      CASE g_bxdj_m.bxdjstus
         WHEN "X"
            CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
            RETURN
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT abxt320_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abxt320_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abxt320_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abxt320_cl
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
      g_bxdj_m.bxdjstus = lc_state OR cl_null(lc_state) THEN
      CLOSE abxt320_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   IF lc_state = 'Y' THEN   
      IF NOT s_abxt320_conf_chk(g_bxdj_m.bxdjdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
         RETURN
      ELSE          
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
            RETURN
         ELSE
            IF NOT s_abxt320_conf_upd(g_bxdj_m.bxdjdocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   
   IF lc_state = 'N' THEN
      IF NOT s_abxt320_unconf_chk(g_bxdj_m.bxdjdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
            RETURN
         ELSE
            IF NOT s_abxt320_unconf_upd(g_bxdj_m.bxdjdocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   
   IF lc_state = 'X' THEN
      IF NOT s_abxt320_invalid_chk(g_bxdj_m.bxdjdocno) THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#14 by 08209 add
            RETURN
         ELSE
            IF NOT s_abxt320_invalid_upd(g_bxdj_m.bxdjdocno)  THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_bxdj_m.bxdjmodid = g_user
   LET g_bxdj_m.bxdjmoddt = cl_get_current()
   LET g_bxdj_m.bxdjstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bxdj_t 
      SET (bxdjstus,bxdjmodid,bxdjmoddt) 
        = (g_bxdj_m.bxdjstus,g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmoddt)     
    WHERE bxdjent = g_enterprise AND bxdjdocno = g_bxdj_m.bxdjdocno
 
    
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
      EXECUTE abxt320_master_referesh USING g_bxdj_m.bxdjdocno INTO g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocdt, 
          g_bxdj_m.bxdj001,g_bxdj_m.bxdj002,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus,g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid, 
          g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdt,g_bxdj_m.bxdjmodid, 
          g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfdt,g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002_desc, 
          g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp_desc,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp_desc, 
          g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bxdj_m.bxdjdocno,g_bxdj_m.bxdjdocno_desc,g_bxdj_m.bxdjdocdt,g_bxdj_m.bxdj001, 
          g_bxdj_m.bxdj001_desc,g_bxdj_m.bxdj002,g_bxdj_m.bxdj002_desc,g_bxdj_m.bxdjsite,g_bxdj_m.bxdjstus, 
          g_bxdj_m.bxdj010,g_bxdj_m.bxdjownid,g_bxdj_m.bxdjownid_desc,g_bxdj_m.bxdjowndp,g_bxdj_m.bxdjowndp_desc, 
          g_bxdj_m.bxdjcrtid,g_bxdj_m.bxdjcrtid_desc,g_bxdj_m.bxdjcrtdp,g_bxdj_m.bxdjcrtdp_desc,g_bxdj_m.bxdjcrtdt, 
          g_bxdj_m.bxdjmodid,g_bxdj_m.bxdjmodid_desc,g_bxdj_m.bxdjmoddt,g_bxdj_m.bxdjcnfid,g_bxdj_m.bxdjcnfid_desc, 
          g_bxdj_m.bxdjcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abxt320_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abxt320_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt320.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abxt320_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bxdk_d.getLength() THEN
         LET g_detail_idx = g_bxdk_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bxdk_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bxdk_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abxt320_b_fill2(pi_idx)
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
   
   CALL abxt320_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abxt320_fill_chk(ps_idx)
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
 
{<section id="abxt320.status_show" >}
PRIVATE FUNCTION abxt320_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abxt320.mask_functions" >}
&include "erp/abx/abxt320_mask.4gl"
 
{</section>}
 
{<section id="abxt320.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION abxt320_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL abxt320_show()
   CALL abxt320_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bxdj_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bxdk_d))
 
 
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
   #CALL abxt320_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abxt320_ui_headershow()
   CALL abxt320_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION abxt320_draw_out()
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
   CALL abxt320_ui_headershow()  
   CALL abxt320_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="abxt320.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abxt320_set_pk_array()
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
   LET g_pk_array[1].values = g_bxdj_m.bxdjdocno
   LET g_pk_array[1].column = 'bxdjdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt320.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abxt320.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abxt320_msgcentre_notify(lc_state)
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
   CALL abxt320_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bxdj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt320.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abxt320_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#4-s
   SELECT bxdjstus INTO g_bxdj_m.bxdjstus FROM bxdj_t
    WHERE bxdjent = g_enterprise
      AND bxdjsite = g_site
      AND bxdjdocno = g_bxdj_m.bxdjdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_bxdj_m.bxdjstus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_bxdj_m.bxdjdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL abxt320_set_act_visible()
        CALL abxt320_set_act_no_visible()
        CALL abxt320_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#4-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abxt320.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 外送單號校驗
# Memo...........:
# Usage..........: CALL abxt320_bxdk001_chk(p_bxdk001,p_bxdk002)
#                  RETURNING r_success,r_errno
# Input parameter: p_bxdk001   外送單號
#                : p_bxdk002   外送項次
# Return code....: r_success,r_errno
# Date & Author..: 160125 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdk001_chk(p_bxdk001,p_bxdk002)
   DEFINE p_bxdk001  LIKE  bxdk_t.bxdk001   
   DEFINE p_bxdk002  LIKE  bxdk_t.bxdk002
   DEFINE r_success  LIKE type_t.num5
   DEFINE r_errno    LIKE type_t.chr10 
   DEFINE l_cnt      LIKE type_t.num10
   
   #初始
   LET r_success= TRUE
   LET r_errno=''
   LET l_cnt = 0 
  
   IF cl_null(p_bxdk001) THEN
      LET r_success=FALSE
      LET r_errno = 'abx-00003'   #外送單號不可為空！
      RETURN r_success,r_errno
   ELSE
      SELECT COUNT(bxdhdocno) INTO l_cnt 
        FROM bxdh_t
       WHERE bxdhent = g_enterprise AND bxdhdocno = p_bxdk001 AND bxdhstus = 'Y' AND bxdhsite = g_site
      
      IF NOT l_cnt > 0 THEN
        LET r_success=FALSE
        LET r_errno = 'abx-00004'   #輸入的資料不存在於有效的[保稅機器設備外送單頭檔]中！
        RETURN r_success,r_errno
      END IF
      
      IF NOT cl_null(p_bxdk001) AND NOT cl_null(p_bxdk002) THEN 
        LET l_cnt = 0
        SELECT COUNT(bxdidocno) INTO l_cnt 
          FROM bxdi_t
         WHERE bxdient = g_enterprise AND bxdidocno = p_bxdk001 AND bxdiseq = p_bxdk002 AND bxdisite = g_site
      
        IF NOT l_cnt > 0 THEN
          LET r_success=FALSE
          LET r_errno = 'abx-00005'   #外送單號+項次，不存在於[保稅機器設備外送單身檔]中！
          RETURN r_success,r_errno
        END IF
        #檢查單身是否重複        
        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxdk_t WHERE "||"bxdkent = '" ||g_enterprise|| "' AND "||"bxdkdocno = '"||g_bxdj_m.bxdjdocno||"' AND "|| "bxdk001 = '"||p_bxdk001||"' AND "|| "bxdk002 = '"||p_bxdk002||"' ",'std-00004',0) THEN 
           LET r_success = FALSE
        END IF                
      END IF
   END IF
   
   RETURN r_success,r_errno


END FUNCTION

################################################################################
# Descriptions...: 外送項次校驗
# Memo...........:
# Usage..........: CALL abxt320_bxdk002_chk(p_bxdk001,p_bxdk002)
#                  RETURNING r_success,r_errno
# Input parameter: p_bxdk001   外送單號
#                : p_bxdk002   外送項次
# Return code....: r_success,r_errno
# Date & Author..: 160125 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdk002_chk(p_bxdk001,p_bxdk002)
   DEFINE p_bxdk001  LIKE  bxdk_t.bxdk001   
   DEFINE p_bxdk002  LIKE  bxdk_t.bxdk002
   DEFINE r_success  LIKE type_t.num5
   DEFINE r_errno    LIKE type_t.chr10 
   DEFINE l_cnt      LIKE type_t.num10
  
   #初始
   LET r_success= TRUE
   LET r_errno=''
   LET l_cnt = 0 
  
   IF cl_null(p_bxdk002) THEN
      LET r_success=FALSE
      LET r_errno = 'abx-00006'   #外送項次不可為空！
      RETURN r_success,r_errno
   ELSE
      IF NOT cl_null(p_bxdk001) AND NOT cl_null(p_bxdk002) THEN 
        LET l_cnt = 0
        SELECT COUNT(bxdidocno) INTO l_cnt 
          FROM bxdi_t
         WHERE bxdient = g_enterprise AND bxdidocno = p_bxdk001 AND bxdiseq = p_bxdk002 AND bxdisite = g_site
      
        IF NOT l_cnt > 0 THEN
          LET r_success=FALSE
          LET r_errno = 'abx-00005'   #外送單號+項次，不存在於[保稅機器設備外送單身檔]中！
          RETURN r_success,r_errno
        END IF       
        #檢查單身是否重複
        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxdk_t WHERE "||"bxdkent = '" ||g_enterprise|| "' AND "||"bxdkdocno = '"||g_bxdj_m.bxdjdocno||"' AND "|| "bxdk001 = '"||p_bxdk001||"' AND "|| "bxdk002 = '"||p_bxdk002||"' ",'std-00004',0) THEN 
           LET r_success = FALSE
        END IF 
      END IF
   END IF
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 帶出bxdi_t及bxdb_t、bxdc_t資料於後面欄位顯示
# Memo...........:
# Usage..........: CALL abxt320_bxdk001_init(p_bxdk001,p_bxdk002)
# Input parameter: p_bxdk001   外送單號
#                : p_bxdk002   外送項次
# Return code....: 
# Date & Author..: 160125 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdk001_init(p_bxdk001,p_bxdk002)
   DEFINE p_bxdk001  LIKE  bxdk_t.bxdk001   
   DEFINE p_bxdk002  LIKE  bxdk_t.bxdk002
   DEFINE l_bxdisite LIKE  bxdi_t.bxdisite
   DEFINE l_sql      STRING
   #初始
   LET l_bxdisite = ''
   
   IF NOT cl_null(p_bxdk001) AND NOT cl_null(p_bxdk002) THEN 
     #SELECT bxdi001,bxdi002,bxdisite INTO g_bxdk_d[l_ac].l_bxdi001,g_bxdk_d[l_ac].l_bxdi002,l_bxdisite 
     #  FROM bxdi_t
     # WHERE bxdient = g_enterprise AND bxdidocno = p_bxdk001 AND bxdiseq = p_bxdk002  
     #
     #SELECT bxdb002,bxdb003,bxdb004 INTO g_bxdk_d[l_ac].l_bxdb002,g_bxdk_d[l_ac].l_bxdb003,g_bxdk_d[l_ac].l_bxdb004
     #  FROM bxdb_t
     # WHERE bxdbent = g_enterprise AND bxdb001 = g_bxdk_d[l_ac].l_bxdi001 AND bxdbsite = l_bxdisite    
     
      
     EXECUTE b_fill_bxdi USING p_bxdk001,p_bxdk002
                          INTO g_bxdk_d[l_ac].l_bxdi001,g_bxdk_d[l_ac].l_bxdi002,l_bxdisite 
                                              
     EXECUTE b_fill_bxdb USING g_site,g_bxdk_d[l_ac].l_bxdi001 
                          INTO g_bxdk_d[l_ac].l_bxdb002,g_bxdk_d[l_ac].l_bxdb003,g_bxdk_d[l_ac].l_bxdb004  
      
     EXECUTE b_fill_bxdc USING g_site,g_bxdk_d[l_ac].l_bxdi001,g_bxdk_d[l_ac].l_bxdi002
                          INTO g_bxdk_d[l_ac].l_bxdc003,g_bxdk_d[l_ac].bxdc003_desc,g_bxdk_d[l_ac].l_bxdc004,g_bxdk_d[l_ac].bxdc004_desc                               
   ELSE
     LET g_bxdk_d[l_ac].l_bxdi001 = ''
     LET g_bxdk_d[l_ac].l_bxdi002 = ''
     LET g_bxdk_d[l_ac].l_bxdb002 = ''
     LET g_bxdk_d[l_ac].l_bxdb003 = ''
     LET g_bxdk_d[l_ac].l_bxdb004 = ''
     LET g_bxdk_d[l_ac].l_bxdc003 = ''
     LET g_bxdk_d[l_ac].bxdc003_desc = ''
     LET g_bxdk_d[l_ac].l_bxdc004 = ''
     LET g_bxdk_d[l_ac].bxdc004_desc = ''
   END IF
   
   
   
   
END FUNCTION

################################################################################
# Descriptions...: 本次收回數量校驗
# Memo...........:
# Usage..........: CALL abxt320_bxdk003_chk(p_bxdk001,p_bxdk002,p_bxdk003,p_bxdjdocno)
#                  RETURNING r_success,r_errno
# Input parameter: p_bxdk001   外送單號
#                : p_bxdk002   外送項次
#                : p_bxdk003   本次收回數量
#                : p_bxdjdocno 本次單據單號
# Return code....: r_success,r_errno
# Date & Author..: 160125 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdk003_chk(p_bxdk001,p_bxdk002,p_bxdk003,p_bxdjdocno)
   DEFINE p_bxdk001   LIKE  bxdk_t.bxdk001   
   DEFINE p_bxdk002   LIKE  bxdk_t.bxdk002
   DEFINE p_bxdk003   LIKE  bxdk_t.bxdk003
   DEFINE p_bxdjdocno LIKE  bxdj_t.bxdjdocno 
   DEFINE r_success   LIKE  type_t.num5
   DEFINE r_errno     LIKE  type_t.chr10 
   DEFINE l_bxdi003   LIKE  bxdi_t.bxdi003   #外送數量
   DEFINE l_bxdk003   LIKE  bxdk_t.bxdk003   #本次回收數量
   DEFINE l_bxdi006   LIKE  bxdi_t.bxdi006   #已回收數量
   DEFINE l_amount    LIKE  bxdk_t.bxdk003   #可收回輸量
   
   #初始
   LET r_success= TRUE
   LET r_errno=''
   LET l_bxdi003 = 0
   LET l_bxdk003 = 0
   LET l_bxdi006 = 0
   LET l_amount = 0 
   
   IF cl_null(p_bxdk001) OR cl_null(p_bxdk002) THEN
     LET r_success=FALSE
     LET r_errno = 'abx-00021'   #外送單號+項次不可為空!!
     RETURN r_success,r_errno
   END IF
   
   SELECT bxdi003,bxdi006 INTO l_bxdi003,l_bxdi006
     FROM bxdi_t 
    WHERE bxdidocno = p_bxdk001 AND bxdiseq = p_bxdk002 AND bxdient = g_enterprise
    
   IF cl_null(l_bxdi003) THEN LET l_bxdi003 = 0 END IF
   IF cl_null(l_bxdi006) THEN LET l_bxdi006 = 0 END IF    
   #20160314 s983961--add(s)
   SELECT SUM(bxdk003) INTO l_bxdk003
        FROM bxdk_t,bxdj_t     
       WHERE bxdkent = bxdjent
         AND bxdkdocno = bxdjdocno
         AND bxdk001 = p_bxdk001
         AND bxdk002 = p_bxdk002
         AND bxdjstus = 'N'
         AND bxdjdocno != p_bxdjdocno
         
   IF cl_null(l_bxdk003) THEN LET l_bxdk003 = 0 END IF     
   LET p_bxdk003 = p_bxdk003 + l_bxdk003  
   #20160314 s983961--add(e)
   
   LET l_amount = l_bxdi003 - l_bxdi006   
   IF p_bxdk003 > l_amount THEN 
     LET r_success=FALSE
     LET r_errno = 'abx-00013'   #輸入值不可超出剩餘之可收回輸量!
     RETURN r_success,r_errno
   END IF
      
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 檢查單身有無資料
# Memo...........:
# Usage..........: CALL abxt320_bxdk_chk(p_bxdkdocno)
#                  RETURNING r_success
# Input parameter: p_bxdkdocno
# Return code....: r_success
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdk_chk(p_bxdkdocno)
   DEFINE p_bxdkdocno      LIKE bxdk_t.bxdkdocno
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(bxdjdocno) INTO l_cnt
     FROM bxdj_t
    WHERE bxdjent = g_enterprise
      AND bxdjdocno = p_bxdkdocno
      
   IF l_cnt > 0 THEN         
      SELECT COUNT(bxdkdocno) INTO l_cnt
        FROM bxdk_t
       WHERE bxdkent = g_enterprise
         AND bxdkdocno = p_bxdkdocno
         
      IF l_cnt = 0  THEN
         LET r_success = FALSE
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身沒資料時，刪除單頭資料
# Memo...........:
# Usage..........: CALL abxt320_bxdj_del(p_bxdjdocno)
#                  RETURNING r_success
# Input parameter: p_bxdjdocno
# Return code....: r_success
# Date & Author..: 20160128 by s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdj_del(p_bxdjdocno)
   DEFINE p_bxdjdocno      LIKE bxdj_t.bxdjdocno
   DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM bxdj_t 
    WHERE bxdjent = g_enterprise
      AND bxdjdocno = p_bxdjdocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE   
      RETURN r_success
   END IF    
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單別說明
# Memo...........:
# Usage..........: CALL abxt320_bxdjdocno_ref()
# Date & Author..: 20160330 BY s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION abxt320_bxdjdocno_ref()
DEFINE l_flag            LIKE type_t.num5
DEFINE l_site            LIKE ooef_t.ooef005
DEFINE l_ooef004         LIKE ooef_t.ooef004
DEFINE l_success         LIKE type_t.num5
DEFINE l_slip            LIKE oobal_t.oobal002
   LET g_bxdj_m.bxdjdocno_desc = ''
   IF cl_null(g_bxdj_m.bxdjdocno) THEN
      RETURN
   END IF   
   #抓取單據別
   LET l_slip = ''
   CALL s_aooi200_get_slip(g_bxdj_m.bxdjdocno) RETURNING l_success,l_slip
   IF NOT l_success THEN
      RETURN
   END IF

   #抓取單據別說明
   SELECT oobxl003 INTO g_bxdj_m.bxdjdocno_desc
     FROM oobxl_t
    WHERE oobxlent = g_enterprise
      AND oobxl001 = l_slip
      AND oobxl002 = g_dlang

   DISPLAY BY NAME g_bxdj_m.bxdjdocno_desc
END FUNCTION

 
{</section>}
 
