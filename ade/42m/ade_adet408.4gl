#該程式未解開Section, 採用最新樣板產出!
{<section id="adet408.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-10-21 11:24:09), PR版次:0010(2016-10-21 11:36:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000102
#+ Filename...: adet408
#+ Description: 銀行卡及第三方卡對帳作業
#+ Creator....: 02749(2014-06-30 20:59:13)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="adet408.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: 160318-00025#28  2016/04/05  By pengxin  修正azzi920重复定义之错误讯息
#160727-00019#10 2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   adet408_rtjf_tmp -->adet408_tmp01
#160818-00017#8   2016/08/24    by 08172  修改删除时重新检查状态
#160824-00007#73  2016/10/11    by 06137  修正舊值備份寫法
#161006-00008#10  2016/10/17    by lori   對上部門加上aooi500的管控
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
PRIVATE type type_g_deay_m        RECORD
       deaysite LIKE deay_t.deaysite, 
   deaysite_desc LIKE type_t.chr80, 
   deaydocdt LIKE deay_t.deaydocdt, 
   deaydocno LIKE deay_t.deaydocno, 
   deay001 LIKE deay_t.deay001, 
   deay002 LIKE deay_t.deay002, 
   deay002_desc LIKE type_t.chr80, 
   deay003 LIKE deay_t.deay003, 
   deay006 LIKE deay_t.deay006, 
   deay006_desc LIKE type_t.chr80, 
   deay005 LIKE deay_t.deay005, 
   deay005_desc LIKE type_t.chr80, 
   deay004 LIKE deay_t.deay004, 
   deay004_desc LIKE type_t.chr80, 
   deayunit LIKE deay_t.deayunit, 
   deaystus LIKE deay_t.deaystus, 
   deayownid LIKE deay_t.deayownid, 
   deayownid_desc LIKE type_t.chr80, 
   deayowndp LIKE deay_t.deayowndp, 
   deayowndp_desc LIKE type_t.chr80, 
   deaycrtid LIKE deay_t.deaycrtid, 
   deaycrtid_desc LIKE type_t.chr80, 
   deaycrtdp LIKE deay_t.deaycrtdp, 
   deaycrtdp_desc LIKE type_t.chr80, 
   deaycrtdt LIKE deay_t.deaycrtdt, 
   deaymodid LIKE deay_t.deaymodid, 
   deaymodid_desc LIKE type_t.chr80, 
   deaymoddt LIKE deay_t.deaymoddt, 
   deaycnfid LIKE deay_t.deaycnfid, 
   deaycnfid_desc LIKE type_t.chr80, 
   deaycnfdt LIKE deay_t.deaycnfdt, 
   deaypstid LIKE deay_t.deaypstid, 
   deaypstid_desc LIKE type_t.chr80, 
   deaypstdt LIKE deay_t.deaypstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_deaa_d        RECORD
       deaaseq LIKE deaa_t.deaaseq, 
   deaaseq1 LIKE deaa_t.deaaseq1, 
   deaa003 LIKE deaa_t.deaa003, 
   deaa015 LIKE deaa_t.deaa015, 
   deaa012 LIKE deaa_t.deaa012, 
   deaa004 LIKE deaa_t.deaa004, 
   deaa005 LIKE deaa_t.deaa005, 
   deaa006 LIKE deaa_t.deaa006, 
   deaa007 LIKE deaa_t.deaa007, 
   deaa008 LIKE deaa_t.deaa008, 
   deaa008_desc LIKE type_t.chr500, 
   deaa010 LIKE deaa_t.deaa010, 
   deaa010_desc LIKE type_t.chr500, 
   deaa009 LIKE deaa_t.deaa009, 
   deaa009_desc LIKE type_t.chr500, 
   deaa011 LIKE deaa_t.deaa011, 
   deaa014 LIKE deaa_t.deaa014, 
   deaa013 LIKE deaa_t.deaa013, 
   deaa016 LIKE deaa_t.deaa016, 
   deaasite LIKE deaa_t.deaasite, 
   deaasite_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_deaa2_d RECORD
       deazseq LIKE deaz_t.deazseq, 
   deaz001 LIKE deaz_t.deaz001, 
   deaz002 LIKE deaz_t.deaz002, 
   deaz003 LIKE deaz_t.deaz003, 
   deaz004 LIKE deaz_t.deaz004, 
   deaz005 LIKE deaz_t.deaz005, 
   deaz006 LIKE deaz_t.deaz006, 
   deazsite LIKE deaz_t.deazsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_deaydocno LIKE deay_t.deaydocno,
      b_deay001 LIKE deay_t.deay001,
      b_deay002 LIKE deay_t.deay002,
   b_deay002_desc LIKE type_t.chr80,
      b_deay003 LIKE deay_t.deay003,
      b_deay004 LIKE deay_t.deay004,
      b_deay005 LIKE deay_t.deay005,
      b_deaydocdt LIKE deay_t.deaydocdt,
      b_deaysite LIKE deay_t.deaysite,
   b_deaysite_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_rtjf_d DYNAMIC ARRAY OF RECORD
          rtjfsite           LIKE rtjf_t.rtjfsite,
          rtjfdocno          LIKE rtjf_t.rtjfdocno,
          rtjfseq            LIKE rtjf_t.rtjfseq,
          rtjfseq1           LIKE rtjf_t.rtjfseq1,
          rtjf001            LIKE rtjf_t.rtjf001,
          rtjf002            LIKE rtjf_t.rtjf002,
          rtjf004            LIKE rtjf_t.rtjf004,          
          rtjf025            LIKE rtjf_t.rtjf025,
          rtjf026            LIKE rtjf_t.rtjf026,
          rtjf031            LIKE rtjf_t.rtjf031,
          rtjf027            LIKE rtjf_t.rtjf027,
          rtjf028            LIKE rtjf_t.rtjf028,
          rtjf028_desc       LIKE oogd_t.oogd002,
          rtjf029            LIKE rtjf_t.rtjf029,
          rtjf029_desc       LIKE pcaal_t.pcaal003,
          rtjf030            LIKE rtjf_t.rtjf030,
          rtjf030_desc       LIKE ooag_t.ooag011,
          rtjf005            LIKE rtjf_t.rtjf005
                END RECORD
DEFINE g_ins_site_flag       LIKE type_t.chr1    #紀錄deaysite 有無輸入資料, 作為欄位entry控制判斷              
#end add-point
       
#模組變數(Module Variables)
DEFINE g_deay_m          type_g_deay_m
DEFINE g_deay_m_t        type_g_deay_m
DEFINE g_deay_m_o        type_g_deay_m
DEFINE g_deay_m_mask_o   type_g_deay_m #轉換遮罩前資料
DEFINE g_deay_m_mask_n   type_g_deay_m #轉換遮罩後資料
 
   DEFINE g_deaydocno_t LIKE deay_t.deaydocno
 
 
DEFINE g_deaa_d          DYNAMIC ARRAY OF type_g_deaa_d
DEFINE g_deaa_d_t        type_g_deaa_d
DEFINE g_deaa_d_o        type_g_deaa_d
DEFINE g_deaa_d_mask_o   DYNAMIC ARRAY OF type_g_deaa_d #轉換遮罩前資料
DEFINE g_deaa_d_mask_n   DYNAMIC ARRAY OF type_g_deaa_d #轉換遮罩後資料
DEFINE g_deaa2_d          DYNAMIC ARRAY OF type_g_deaa2_d
DEFINE g_deaa2_d_t        type_g_deaa2_d
DEFINE g_deaa2_d_o        type_g_deaa2_d
DEFINE g_deaa2_d_mask_o   DYNAMIC ARRAY OF type_g_deaa2_d #轉換遮罩前資料
DEFINE g_deaa2_d_mask_n   DYNAMIC ARRAY OF type_g_deaa2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
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
 
{<section id="adet408.main" >}
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
   CALL cl_ap_init("ade","")
 
   #add-point:作業初始化 name="main.init"
   CALL adet408_create_tmp()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT deaysite,'',deaydocdt,deaydocno,deay001,deay002,'',deay003,deay006,'', 
       deay005,'',deay004,'',deayunit,deaystus,deayownid,'',deayowndp,'',deaycrtid,'',deaycrtdp,'',deaycrtdt, 
       deaymodid,'',deaymoddt,deaycnfid,'',deaycnfdt,deaypstid,'',deaypstdt", 
                      " FROM deay_t",
                      " WHERE deayent= ? AND deaydocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet408_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.deaysite,t0.deaydocdt,t0.deaydocno,t0.deay001,t0.deay002,t0.deay003, 
       t0.deay006,t0.deay005,t0.deay004,t0.deayunit,t0.deaystus,t0.deayownid,t0.deayowndp,t0.deaycrtid, 
       t0.deaycrtdp,t0.deaycrtdt,t0.deaymodid,t0.deaymoddt,t0.deaycnfid,t0.deaycnfdt,t0.deaypstid,t0.deaypstdt, 
       t1.ooefl003 ,t2.ooial003 ,t3.ooail003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 , 
       t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM deay_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deaysite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooial_t t2 ON t2.ooialent="||g_enterprise||" AND t2.ooial001=t0.deay002 AND t2.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.deay006 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.deay005  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.deay004 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.deayownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.deayowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.deaycrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.deaycrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.deaymodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.deaycnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.deaypstid  ",
 
               " WHERE t0.deayent = " ||g_enterprise|| " AND t0.deaydocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adet408_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adet408 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adet408_init()   
 
      #進入選單 Menu (="N")
      CALL adet408_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adet408
      
   END IF 
   
   CLOSE adet408_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   CALL adet408_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adet408.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adet408_init()
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('deaystus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('deay001','8310') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   CALL cl_set_combo_scc('rtjf001','8310') 
   #end add-point
   
   #初始化搜尋條件
   CALL adet408_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adet408.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adet408_ui_dialog()
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
            CALL adet408_insert()
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
         INITIALIZE g_deay_m.* TO NULL
         CALL g_deaa_d.clear()
         CALL g_deaa2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adet408_init()
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
               
               CALL adet408_fetch('') # reload data
               LET l_ac = 1
               CALL adet408_ui_detailshow() #Setting the current row 
         
               CALL adet408_idx_chk()
               #NEXT FIELD deaaseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_deaa_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet408_idx_chk()
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
               CALL adet408_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_deaa2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet408_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL adet408_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_rtjf_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)      
            BEFORE ROW
               CALL adet408_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
            BEFORE DISPLAY
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               CALL adet408_idx_chk()
         
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL adet408_browser_fill("")
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
               CALL adet408_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adet408_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adet408_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adet408_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adet408_set_act_visible()   
            CALL adet408_set_act_no_visible()
            IF NOT (g_deay_m.deaydocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " deayent = " ||g_enterprise|| " AND",
                                  " deaydocno = '", g_deay_m.deaydocno, "' "
 
               #填到對應位置
               CALL adet408_browser_fill("")
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
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "deay_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deaa_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deaz_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL adet408_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "deay_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deaa_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deaz_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL adet408_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adet408_fetch("F")
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
               CALL adet408_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adet408_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet408_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adet408_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet408_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adet408_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet408_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adet408_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet408_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adet408_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet408_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_deaa_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_deaa2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #ken---add---s 需求單號：150107-00009 項次：7
                  LET g_export_node[3] = base.typeInfo.create(g_rtjf_d)
                  LET g_export_id[3]   = "s_detail3"
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
               NEXT FIELD deaaseq
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
               CALL adet408_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#8 -s by 08172
               CALL adet408_set_act_visible()   
               CALL adet408_set_act_no_visible()
               #160818-00017#8 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adet408_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#8 -s by 08172
               CALL adet408_set_act_visible()   
               CALL adet408_set_act_no_visible()
               #160818-00017#8 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s01
            LET g_action_choice="open_s01"
            IF cl_auth_chk_act("open_s01") THEN
               
               #add-point:ON ACTION open_s01 name="menu.open_s01"
               CALL adet408_open_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adet408_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#8 -s by 08172
               CALL adet408_set_act_visible()   
               CALL adet408_set_act_no_visible()
               #160818-00017#8 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adet408_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ade/adet408_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ade/adet408_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adet408_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adet408_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adet408_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adet408_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adet408_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_deay_m.deaydocdt)
 
 
 
         
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
 
{<section id="adet408.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adet408_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'deaysite') RETURNING l_where
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
      LET l_sub_sql = " SELECT DISTINCT deaydocno ",
                      " FROM deay_t ",
                      " ",
                      " LEFT JOIN deaa_t ON deaaent = deayent AND deaydocno = deaadocno ", "  ",
                      #add-point:browser_fill段sql(deaa_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN deaz_t ON deazent = deayent AND deaydocno = deazdocno", "  ",
                      #add-point:browser_fill段sql(deaz_t1) name="browser_fill.cnt.join.deaz_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE deayent = " ||g_enterprise|| " AND deaaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("deay_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deaydocno ",
                      " FROM deay_t ", 
                      "  ",
                      "  ",
                      " WHERE deayent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("deay_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ",l_where
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
      INITIALIZE g_deay_m.* TO NULL
      CALL g_deaa_d.clear()        
      CALL g_deaa2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.deaydocno,t0.deay001,t0.deay002,t0.deay003,t0.deay004,t0.deay005,t0.deaydocdt,t0.deaysite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deaystus,t0.deaydocno,t0.deay001,t0.deay002,t0.deay003,t0.deay004, 
          t0.deay005,t0.deaydocdt,t0.deaysite,t1.ooial003 ,t2.ooefl003 ",
                  " FROM deay_t t0",
                  "  ",
                  "  LEFT JOIN deaa_t ON deaaent = deayent AND deaydocno = deaadocno ", "  ", 
                  #add-point:browser_fill段sql(deaa_t1) name="browser_fill.join.deaa_t1"
                  
                  #end add-point
                  "  LEFT JOIN deaz_t ON deazent = deayent AND deaydocno = deazdocno", "  ", 
                  #add-point:browser_fill段sql(deaz_t1) name="browser_fill.join.deaz_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=t0.deay002 AND t1.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.deaysite AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.deayent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("deay_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deaystus,t0.deaydocno,t0.deay001,t0.deay002,t0.deay003,t0.deay004, 
          t0.deay005,t0.deaydocdt,t0.deaysite,t1.ooial003 ,t2.ooefl003 ",
                  " FROM deay_t t0",
                  "  ",
                                 " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=t0.deay002 AND t1.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.deaysite AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.deayent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("deay_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ",l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY deaydocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"deay_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_deaydocno,g_browser[g_cnt].b_deay001, 
          g_browser[g_cnt].b_deay002,g_browser[g_cnt].b_deay003,g_browser[g_cnt].b_deay004,g_browser[g_cnt].b_deay005, 
          g_browser[g_cnt].b_deaydocdt,g_browser[g_cnt].b_deaysite,g_browser[g_cnt].b_deay002_desc,g_browser[g_cnt].b_deaysite_desc 
 
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
         CALL adet408_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_deaydocno) THEN
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
 
{<section id="adet408.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adet408_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_deay_m.deaydocno = g_browser[g_current_idx].b_deaydocno   
 
   EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
       g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
       g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
       g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc,g_deay_m.deay002_desc, 
       g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaypstid_desc
   
   CALL adet408_deay_t_mask()
   CALL adet408_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adet408.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adet408_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adet408_ui_browser_refresh()
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
      IF g_browser[l_i].b_deaydocno = g_deay_m.deaydocno 
 
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
 
{<section id="adet408.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adet408_construct()
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
   INITIALIZE g_deay_m.* TO NULL
   CALL g_deaa_d.clear()        
   CALL g_deaa2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON deaysite,deaydocdt,deaydocno,deay001,deay002,deay003,deay006,deay005, 
          deay004,deayunit,deaystus,deayownid,deayowndp,deaycrtid,deaycrtdp,deaycrtdt,deaymodid,deaymoddt, 
          deaycnfid,deaycnfdt,deaypstid,deaypstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<deaycrtdt>>----
         AFTER FIELD deaycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<deaymoddt>>----
         AFTER FIELD deaymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deaycnfdt>>----
         AFTER FIELD deaycnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deaypstdt>>----
         AFTER FIELD deaypstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.deaysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaysite
            #add-point:ON ACTION controlp INFIELD deaysite name="construct.c.deaysite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaysite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()                     
            DISPLAY g_qryparam.return1 TO deaysite  #顯示到畫面上
            NEXT FIELD deaysite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaysite
            #add-point:BEFORE FIELD deaysite name="construct.b.deaysite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaysite
            
            #add-point:AFTER FIELD deaysite name="construct.a.deaysite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaydocdt
            #add-point:BEFORE FIELD deaydocdt name="construct.b.deaydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaydocdt
            
            #add-point:AFTER FIELD deaydocdt name="construct.a.deaydocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaydocdt
            #add-point:ON ACTION controlp INFIELD deaydocdt name="construct.c.deaydocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaydocno
            #add-point:ON ACTION controlp INFIELD deaydocno name="construct.c.deaydocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_deaydocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaydocno  #顯示到畫面上
            NEXT FIELD deaydocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaydocno
            #add-point:BEFORE FIELD deaydocno name="construct.b.deaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaydocno
            
            #add-point:AFTER FIELD deaydocno name="construct.a.deaydocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay001
            #add-point:BEFORE FIELD deay001 name="construct.b.deay001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay001
            
            #add-point:AFTER FIELD deay001 name="construct.a.deay001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deay001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay001
            #add-point:ON ACTION controlp INFIELD deay001 name="construct.c.deay001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deay002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay002
            #add-point:ON ACTION controlp INFIELD deay002 name="construct.c.deay002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_deay_m.deay001
#            LET g_qryparam.arg2 = g_deay_m.deaysite
#            CALL q_ooie001_4()                           #呼叫開窗
            CALL q_ooia001()
            DISPLAY g_qryparam.return1 TO deay002  #顯示到畫面上
            NEXT FIELD deay002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay002
            #add-point:BEFORE FIELD deay002 name="construct.b.deay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay002
            
            #add-point:AFTER FIELD deay002 name="construct.a.deay002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay003
            #add-point:BEFORE FIELD deay003 name="construct.b.deay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay003
            
            #add-point:AFTER FIELD deay003 name="construct.a.deay003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay003
            #add-point:ON ACTION controlp INFIELD deay003 name="construct.c.deay003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deay006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay006
            #add-point:ON ACTION controlp INFIELD deay006 name="construct.c.deay006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site 
            CALL q_ooaj002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO deay006  #顯示到畫面上
            NEXT FIELD deay006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay006
            #add-point:BEFORE FIELD deay006 name="construct.b.deay006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay006
            
            #add-point:AFTER FIELD deay006 name="construct.a.deay006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deay005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay005
            #add-point:ON ACTION controlp INFIELD deay005 name="construct.c.deay005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooag001_2()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            CALL q_ooag001_4()                           #呼叫開窗    #151228-00009#1 20151230 add by beckxie
            DISPLAY g_qryparam.return1 TO deay005  #顯示到畫面上
            NEXT FIELD deay005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay005
            #add-point:BEFORE FIELD deay005 name="construct.b.deay005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay005
            
            #add-point:AFTER FIELD deay005 name="construct.a.deay005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay004
            #add-point:ON ACTION controlp INFIELD deay004 name="construct.c.deay004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
           #CALL q_ooef001_9()    #161006-00008#10 161017 by lori mark
            #161006-00008#10 161017 by lori add---(S)
            IF s_aooi500_setpoint(g_prog,'deay004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'deay004',g_site,'c')
               CALL q_ooef001_24()                   
            ELSE            
               CALL q_ooef001_9() 
            END IF    
            #161006-00008#10 161017 by lori add---(S)
            
            DISPLAY g_qryparam.return1 TO deay004  
            NEXT FIELD deay004                     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay004
            #add-point:BEFORE FIELD deay004 name="construct.b.deay004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay004
            
            #add-point:AFTER FIELD deay004 name="construct.a.deay004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deayunit
            #add-point:BEFORE FIELD deayunit name="construct.b.deayunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deayunit
            
            #add-point:AFTER FIELD deayunit name="construct.a.deayunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deayunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deayunit
            #add-point:ON ACTION controlp INFIELD deayunit name="construct.c.deayunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaystus
            #add-point:BEFORE FIELD deaystus name="construct.b.deaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaystus
            
            #add-point:AFTER FIELD deaystus name="construct.a.deaystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaystus
            #add-point:ON ACTION controlp INFIELD deaystus name="construct.c.deaystus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deayownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deayownid
            #add-point:ON ACTION controlp INFIELD deayownid name="construct.c.deayownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deayownid  #顯示到畫面上
            NEXT FIELD deayownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deayownid
            #add-point:BEFORE FIELD deayownid name="construct.b.deayownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deayownid
            
            #add-point:AFTER FIELD deayownid name="construct.a.deayownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deayowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deayowndp
            #add-point:ON ACTION controlp INFIELD deayowndp name="construct.c.deayowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deayowndp  #顯示到畫面上
            NEXT FIELD deayowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deayowndp
            #add-point:BEFORE FIELD deayowndp name="construct.b.deayowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deayowndp
            
            #add-point:AFTER FIELD deayowndp name="construct.a.deayowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaycrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaycrtid
            #add-point:ON ACTION controlp INFIELD deaycrtid name="construct.c.deaycrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaycrtid  #顯示到畫面上
            NEXT FIELD deaycrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaycrtid
            #add-point:BEFORE FIELD deaycrtid name="construct.b.deaycrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaycrtid
            
            #add-point:AFTER FIELD deaycrtid name="construct.a.deaycrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaycrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaycrtdp
            #add-point:ON ACTION controlp INFIELD deaycrtdp name="construct.c.deaycrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaycrtdp  #顯示到畫面上
            NEXT FIELD deaycrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaycrtdp
            #add-point:BEFORE FIELD deaycrtdp name="construct.b.deaycrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaycrtdp
            
            #add-point:AFTER FIELD deaycrtdp name="construct.a.deaycrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaycrtdt
            #add-point:BEFORE FIELD deaycrtdt name="construct.b.deaycrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaymodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaymodid
            #add-point:ON ACTION controlp INFIELD deaymodid name="construct.c.deaymodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaymodid  #顯示到畫面上
            NEXT FIELD deaymodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaymodid
            #add-point:BEFORE FIELD deaymodid name="construct.b.deaymodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaymodid
            
            #add-point:AFTER FIELD deaymodid name="construct.a.deaymodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaymoddt
            #add-point:BEFORE FIELD deaymoddt name="construct.b.deaymoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaycnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaycnfid
            #add-point:ON ACTION controlp INFIELD deaycnfid name="construct.c.deaycnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaycnfid  #顯示到畫面上
            NEXT FIELD deaycnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaycnfid
            #add-point:BEFORE FIELD deaycnfid name="construct.b.deaycnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaycnfid
            
            #add-point:AFTER FIELD deaycnfid name="construct.a.deaycnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaycnfdt
            #add-point:BEFORE FIELD deaycnfdt name="construct.b.deaycnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deaypstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaypstid
            #add-point:ON ACTION controlp INFIELD deaypstid name="construct.c.deaypstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deaypstid  #顯示到畫面上
            NEXT FIELD deaypstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaypstid
            #add-point:BEFORE FIELD deaypstid name="construct.b.deaypstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaypstid
            
            #add-point:AFTER FIELD deaypstid name="construct.a.deaypstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaypstdt
            #add-point:BEFORE FIELD deaypstdt name="construct.b.deaypstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON deaaseq,deaaseq1,deaa003,deaa015,deaa012,deaa004,deaa005,deaa006,deaa007, 
          deaa008,deaa010,deaa009,deaa011,deaa014,deaa013,deaa016,deaasite
           FROM s_detail1[1].deaaseq,s_detail1[1].deaaseq1,s_detail1[1].deaa003,s_detail1[1].deaa015, 
               s_detail1[1].deaa012,s_detail1[1].deaa004,s_detail1[1].deaa005,s_detail1[1].deaa006,s_detail1[1].deaa007, 
               s_detail1[1].deaa008,s_detail1[1].deaa010,s_detail1[1].deaa009,s_detail1[1].deaa011,s_detail1[1].deaa014, 
               s_detail1[1].deaa013,s_detail1[1].deaa016,s_detail1[1].deaasite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaaseq
            #add-point:BEFORE FIELD deaaseq name="construct.b.page1.deaaseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaaseq
            
            #add-point:AFTER FIELD deaaseq name="construct.a.page1.deaaseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaaseq
            #add-point:ON ACTION controlp INFIELD deaaseq name="construct.c.page1.deaaseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaaseq1
            #add-point:BEFORE FIELD deaaseq1 name="construct.b.page1.deaaseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaaseq1
            
            #add-point:AFTER FIELD deaaseq1 name="construct.a.page1.deaaseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaaseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaaseq1
            #add-point:ON ACTION controlp INFIELD deaaseq1 name="construct.c.page1.deaaseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa003
            #add-point:BEFORE FIELD deaa003 name="construct.b.page1.deaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa003
            
            #add-point:AFTER FIELD deaa003 name="construct.a.page1.deaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa003
            #add-point:ON ACTION controlp INFIELD deaa003 name="construct.c.page1.deaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa015
            #add-point:BEFORE FIELD deaa015 name="construct.b.page1.deaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa015
            
            #add-point:AFTER FIELD deaa015 name="construct.a.page1.deaa015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa015
            #add-point:ON ACTION controlp INFIELD deaa015 name="construct.c.page1.deaa015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa012
            #add-point:BEFORE FIELD deaa012 name="construct.b.page1.deaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa012
            
            #add-point:AFTER FIELD deaa012 name="construct.a.page1.deaa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa012
            #add-point:ON ACTION controlp INFIELD deaa012 name="construct.c.page1.deaa012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa004
            #add-point:BEFORE FIELD deaa004 name="construct.b.page1.deaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa004
            
            #add-point:AFTER FIELD deaa004 name="construct.a.page1.deaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa004
            #add-point:ON ACTION controlp INFIELD deaa004 name="construct.c.page1.deaa004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa005
            #add-point:BEFORE FIELD deaa005 name="construct.b.page1.deaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa005
            
            #add-point:AFTER FIELD deaa005 name="construct.a.page1.deaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa005
            #add-point:ON ACTION controlp INFIELD deaa005 name="construct.c.page1.deaa005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa006
            #add-point:BEFORE FIELD deaa006 name="construct.b.page1.deaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa006
            
            #add-point:AFTER FIELD deaa006 name="construct.a.page1.deaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa006
            #add-point:ON ACTION controlp INFIELD deaa006 name="construct.c.page1.deaa006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa007
            #add-point:BEFORE FIELD deaa007 name="construct.b.page1.deaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa007
            
            #add-point:AFTER FIELD deaa007 name="construct.a.page1.deaa007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa007
            #add-point:ON ACTION controlp INFIELD deaa007 name="construct.c.page1.deaa007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deaa008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa008
            #add-point:ON ACTION controlp INFIELD deaa008 name="construct.c.page1.deaa008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oogd001()                     
            DISPLAY g_qryparam.return1 TO deaa010  #顯示到畫面上
            NEXT FIELD deaa010 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa008
            #add-point:BEFORE FIELD deaa008 name="construct.b.page1.deaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa008
            
            #add-point:AFTER FIELD deaa008 name="construct.a.page1.deaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa010
            #add-point:ON ACTION controlp INFIELD deaa010 name="construct.c.page1.deaa010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pcaa001()                     
            DISPLAY g_qryparam.return1 TO deaa010  #顯示到畫面上
            NEXT FIELD deaa010 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa010
            #add-point:BEFORE FIELD deaa010 name="construct.b.page1.deaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa010
            
            #add-point:AFTER FIELD deaa010 name="construct.a.page1.deaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa009
            #add-point:ON ACTION controlp INFIELD deaa009 name="construct.c.page1.deaa009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001()                     
            DISPLAY g_qryparam.return1 TO deaa009  #顯示到畫面上
            NEXT FIELD deaa009 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa009
            #add-point:BEFORE FIELD deaa009 name="construct.b.page1.deaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa009
            
            #add-point:AFTER FIELD deaa009 name="construct.a.page1.deaa009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa011
            #add-point:BEFORE FIELD deaa011 name="construct.b.page1.deaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa011
            
            #add-point:AFTER FIELD deaa011 name="construct.a.page1.deaa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa011
            #add-point:ON ACTION controlp INFIELD deaa011 name="construct.c.page1.deaa011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa014
            #add-point:BEFORE FIELD deaa014 name="construct.b.page1.deaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa014
            
            #add-point:AFTER FIELD deaa014 name="construct.a.page1.deaa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa014
            #add-point:ON ACTION controlp INFIELD deaa014 name="construct.c.page1.deaa014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.deaa013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa013
            #add-point:ON ACTION controlp INFIELD deaa013 name="construct.c.page1.deaa013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_deaz005()                     
            DISPLAY g_qryparam.return1 TO deaa013  #顯示到畫面上
            NEXT FIELD deaa013 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa013
            #add-point:BEFORE FIELD deaa013 name="construct.b.page1.deaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa013
            
            #add-point:AFTER FIELD deaa013 name="construct.a.page1.deaa013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa016
            #add-point:BEFORE FIELD deaa016 name="construct.b.page1.deaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa016
            
            #add-point:AFTER FIELD deaa016 name="construct.a.page1.deaa016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa016
            #add-point:ON ACTION controlp INFIELD deaa016 name="construct.c.page1.deaa016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaasite
            #add-point:BEFORE FIELD deaasite name="construct.b.page1.deaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaasite
            
            #add-point:AFTER FIELD deaasite name="construct.a.page1.deaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaasite
            #add-point:ON ACTION controlp INFIELD deaasite name="construct.c.page1.deaasite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON deazseq,deaz001,deaz002,deaz003,deaz004,deaz005,deaz006,deazsite
           FROM s_detail2[1].deazseq,s_detail2[1].deaz001,s_detail2[1].deaz002,s_detail2[1].deaz003, 
               s_detail2[1].deaz004,s_detail2[1].deaz005,s_detail2[1].deaz006,s_detail2[1].deazsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deazseq
            #add-point:BEFORE FIELD deazseq name="construct.b.page2.deazseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deazseq
            
            #add-point:AFTER FIELD deazseq name="construct.a.page2.deazseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deazseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deazseq
            #add-point:ON ACTION controlp INFIELD deazseq name="construct.c.page2.deazseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaz001
            #add-point:BEFORE FIELD deaz001 name="construct.b.page2.deaz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaz001
            
            #add-point:AFTER FIELD deaz001 name="construct.a.page2.deaz001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deaz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaz001
            #add-point:ON ACTION controlp INFIELD deaz001 name="construct.c.page2.deaz001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaz002
            #add-point:BEFORE FIELD deaz002 name="construct.b.page2.deaz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaz002
            
            #add-point:AFTER FIELD deaz002 name="construct.a.page2.deaz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deaz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaz002
            #add-point:ON ACTION controlp INFIELD deaz002 name="construct.c.page2.deaz002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaz003
            #add-point:BEFORE FIELD deaz003 name="construct.b.page2.deaz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaz003
            
            #add-point:AFTER FIELD deaz003 name="construct.a.page2.deaz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deaz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaz003
            #add-point:ON ACTION controlp INFIELD deaz003 name="construct.c.page2.deaz003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaz004
            #add-point:BEFORE FIELD deaz004 name="construct.b.page2.deaz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaz004
            
            #add-point:AFTER FIELD deaz004 name="construct.a.page2.deaz004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deaz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaz004
            #add-point:ON ACTION controlp INFIELD deaz004 name="construct.c.page2.deaz004"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.deaz005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaz005
            #add-point:ON ACTION controlp INFIELD deaz005 name="construct.c.page2.deaz005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_deaz005()                     
            DISPLAY g_qryparam.return1 TO deaz005  #顯示到畫面上
            NEXT FIELD deaz005 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaz005
            #add-point:BEFORE FIELD deaz005 name="construct.b.page2.deaz005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaz005
            
            #add-point:AFTER FIELD deaz005 name="construct.a.page2.deaz005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaz006
            #add-point:BEFORE FIELD deaz006 name="construct.b.page2.deaz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaz006
            
            #add-point:AFTER FIELD deaz006 name="construct.a.page2.deaz006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deaz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaz006
            #add-point:ON ACTION controlp INFIELD deaz006 name="construct.c.page2.deaz006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deazsite
            #add-point:BEFORE FIELD deazsite name="construct.b.page2.deazsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deazsite
            
            #add-point:AFTER FIELD deazsite name="construct.a.page2.deazsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.deazsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deazsite
            #add-point:ON ACTION controlp INFIELD deazsite name="construct.c.page2.deazsite"
            
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
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "deay_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "deaa_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "deaz_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adet408_filter()
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
      CONSTRUCT g_wc_filter ON deaydocno,deay001,deay002,deay003,deay004,deay005,deaydocdt,deaysite
                          FROM s_browse[1].b_deaydocno,s_browse[1].b_deay001,s_browse[1].b_deay002,s_browse[1].b_deay003, 
                              s_browse[1].b_deay004,s_browse[1].b_deay005,s_browse[1].b_deaydocdt,s_browse[1].b_deaysite 
 
 
         BEFORE CONSTRUCT
               DISPLAY adet408_filter_parser('deaydocno') TO s_browse[1].b_deaydocno
            DISPLAY adet408_filter_parser('deay001') TO s_browse[1].b_deay001
            DISPLAY adet408_filter_parser('deay002') TO s_browse[1].b_deay002
            DISPLAY adet408_filter_parser('deay003') TO s_browse[1].b_deay003
            DISPLAY adet408_filter_parser('deay004') TO s_browse[1].b_deay004
            DISPLAY adet408_filter_parser('deay005') TO s_browse[1].b_deay005
            DISPLAY adet408_filter_parser('deaydocdt') TO s_browse[1].b_deaydocdt
            DISPLAY adet408_filter_parser('deaysite') TO s_browse[1].b_deaysite
      
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
 
      CALL adet408_filter_show('deaydocno')
   CALL adet408_filter_show('deay001')
   CALL adet408_filter_show('deay002')
   CALL adet408_filter_show('deay003')
   CALL adet408_filter_show('deay004')
   CALL adet408_filter_show('deay005')
   CALL adet408_filter_show('deaydocdt')
   CALL adet408_filter_show('deaysite')
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adet408_filter_parser(ps_field)
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
 
{<section id="adet408.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adet408_filter_show(ps_field)
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
   LET ls_condition = adet408_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adet408_query()
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
   CALL g_deaa_d.clear()
   CALL g_deaa2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adet408_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adet408_browser_fill("")
      CALL adet408_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL adet408_filter_show('deaydocno')
   CALL adet408_filter_show('deay001')
   CALL adet408_filter_show('deay002')
   CALL adet408_filter_show('deay003')
   CALL adet408_filter_show('deay004')
   CALL adet408_filter_show('deay005')
   CALL adet408_filter_show('deaydocdt')
   CALL adet408_filter_show('deaysite')
   CALL adet408_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adet408_fetch("F") 
      #顯示單身筆數
      CALL adet408_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adet408_fetch(p_flag)
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
   
   LET g_deay_m.deaydocno = g_browser[g_current_idx].b_deaydocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
       g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
       g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
       g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc,g_deay_m.deay002_desc, 
       g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaypstid_desc
   
   #遮罩相關處理
   LET g_deay_m_mask_o.* =  g_deay_m.*
   CALL adet408_deay_t_mask()
   LET g_deay_m_mask_n.* =  g_deay_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet408_set_act_visible()   
   CALL adet408_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_deay_m_t.* = g_deay_m.*
   LET g_deay_m_o.* = g_deay_m.*
   
   LET g_data_owner = g_deay_m.deayownid      
   LET g_data_dept  = g_deay_m.deayowndp
   
   #重新顯示   
   CALL adet408_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.insert" >}
#+ 資料新增
PRIVATE FUNCTION adet408_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004
   DEFINE l_insert        LIKE type_t.num5 
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_deaa_d.clear()   
   CALL g_deaa2_d.clear()  
 
 
   INITIALIZE g_deay_m.* TO NULL             #DEFAULT 設定
   
   LET g_deaydocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deay_m.deayownid = g_user
      LET g_deay_m.deayowndp = g_dept
      LET g_deay_m.deaycrtid = g_user
      LET g_deay_m.deaycrtdp = g_dept 
      LET g_deay_m.deaycrtdt = cl_get_current()
      LET g_deay_m.deaymodid = g_user
      LET g_deay_m.deaymoddt = cl_get_current()
      LET g_deay_m.deaystus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_deay_m.deay001 = "50"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'deaysite',g_deay_m.deaysite)
         RETURNING l_insert,g_deay_m.deaysite
      IF l_insert = FALSE THEN
         RETURN
      END IF      
      LET g_deay_m.deaysite_desc = s_desc_get_department_desc(g_deay_m.deaysite)
      
      #預設單別
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_deay_m.deaysite,g_prog,'1')
         RETURNING l_success,l_doctype
      LET g_deay_m.deaydocno = l_doctype
      
      LET g_deay_m.deaydocdt =  cl_get_current()
      LET g_deay_m.deay004 = g_dept
      LET g_deay_m.deay004_desc = s_desc_get_department_desc(g_deay_m.deay004)
      LET g_deay_m.deay005 = g_user
      LET g_deay_m.deay005_desc = s_desc_get_person_desc(g_deay_m.deay005)
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_deay_m_t.* = g_deay_m.*
      LET g_deay_m_o.* = g_deay_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deay_m.deaystus 
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
 
 
 
    
      CALL adet408_input("a")
      
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
         INITIALIZE g_deay_m.* TO NULL
         INITIALIZE g_deaa_d TO NULL
         INITIALIZE g_deaa2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adet408_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_deaa_d.clear()
      #CALL g_deaa2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet408_set_act_visible()   
   CALL adet408_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deaydocno_t = g_deay_m.deaydocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deayent = " ||g_enterprise|| " AND",
                      " deaydocno = '", g_deay_m.deaydocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet408_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adet408_cl
   
   CALL adet408_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
       g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
       g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
       g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc,g_deay_m.deay002_desc, 
       g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaypstid_desc
   
   
   #遮罩相關處理
   LET g_deay_m_mask_o.* =  g_deay_m.*
   CALL adet408_deay_t_mask()
   LET g_deay_m_mask_n.* =  g_deay_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001, 
       g_deay_m.deay002,g_deay_m.deay002_desc,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay006_desc, 
       g_deay_m.deay005,g_deay_m.deay005_desc,g_deay_m.deay004,g_deay_m.deay004_desc,g_deay_m.deayunit, 
       g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayownid_desc,g_deay_m.deayowndp,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid,g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp,g_deay_m.deaycrtdp_desc,g_deay_m.deaycrtdt, 
       g_deay_m.deaymodid,g_deay_m.deaymodid_desc,g_deay_m.deaymoddt,g_deay_m.deaycnfid,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstid_desc,g_deay_m.deaypstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_deay_m.deayownid      
   LET g_data_dept  = g_deay_m.deayowndp
   
   #功能已完成,通報訊息中心
   CALL adet408_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.modify" >}
#+ 資料修改
PRIVATE FUNCTION adet408_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_deay_m_t.* = g_deay_m.*
   LET g_deay_m_o.* = g_deay_m.*
   
   IF g_deay_m.deaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_deaydocno_t = g_deay_m.deaydocno
 
   CALL s_transaction_begin()
   
   OPEN adet408_cl USING g_enterprise,g_deay_m.deaydocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet408_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet408_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
       g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
       g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
       g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc,g_deay_m.deay002_desc, 
       g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaypstid_desc
   
   #檢查是否允許此動作
   IF NOT adet408_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deay_m_mask_o.* =  g_deay_m.*
   CALL adet408_deay_t_mask()
   LET g_deay_m_mask_n.* =  g_deay_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL adet408_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_deaydocno_t = g_deay_m.deaydocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_deay_m.deaymodid = g_user 
LET g_deay_m.deaymoddt = cl_get_current()
LET g_deay_m.deaymodid_desc = cl_get_username(g_deay_m.deaymodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adet408_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE deay_t SET (deaymodid,deaymoddt) = (g_deay_m.deaymodid,g_deay_m.deaymoddt)
          WHERE deayent = g_enterprise AND deaydocno = g_deaydocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_deay_m.* = g_deay_m_t.*
            CALL adet408_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_deay_m.deaydocno != g_deay_m_t.deaydocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE deaa_t SET deaadocno = g_deay_m.deaydocno
 
          WHERE deaaent = g_enterprise AND deaadocno = g_deay_m_t.deaydocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "deaa_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deaa_t:",SQLERRMESSAGE 
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
         
         UPDATE deaz_t
            SET deazdocno = g_deay_m.deaydocno
 
          WHERE deazent = g_enterprise AND
                deazdocno = g_deaydocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "deaz_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deaz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet408_set_act_visible()   
   CALL adet408_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " deayent = " ||g_enterprise|| " AND",
                      " deaydocno = '", g_deay_m.deaydocno, "' "
 
   #填到對應位置
   CALL adet408_browser_fill("")
 
   CLOSE adet408_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet408_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adet408.input" >}
#+ 資料輸入
PRIVATE FUNCTION adet408_input(p_cmd)
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
   DEFINE  l_no                  LIKE type_t.chr10
   DEFINE  l_ooia002             LIKE ooia_t.ooia002   
   DEFINE  l_str                 STRING 
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
   DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001, 
       g_deay_m.deay002,g_deay_m.deay002_desc,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay006_desc, 
       g_deay_m.deay005,g_deay_m.deay005_desc,g_deay_m.deay004,g_deay_m.deay004_desc,g_deay_m.deayunit, 
       g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayownid_desc,g_deay_m.deayowndp,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid,g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp,g_deay_m.deaycrtdp_desc,g_deay_m.deaycrtdt, 
       g_deay_m.deaymodid,g_deay_m.deaymodid_desc,g_deay_m.deaymoddt,g_deay_m.deaycnfid,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstid_desc,g_deay_m.deaypstdt
   
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
   LET g_forupd_sql = "SELECT deaaseq,deaaseq1,deaa003,deaa015,deaa012,deaa004,deaa005,deaa006,deaa007, 
       deaa008,deaa010,deaa009,deaa011,deaa014,deaa013,deaa016,deaasite FROM deaa_t WHERE deaaent=?  
       AND deaadocno=? AND deaaseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet408_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT deazseq,deaz001,deaz002,deaz003,deaz004,deaz005,deaz006,deazsite FROM  
       deaz_t WHERE deazent=? AND deazdocno=? AND deazseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet408_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adet408_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adet408_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002, 
       g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005,g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adet408.input.head" >}
      #單頭段
      INPUT BY NAME g_deay_m.deaysite,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002, 
          g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005,g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adet408_cl USING g_enterprise,g_deay_m.deaydocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet408_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet408_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adet408_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_ins_site_flag = ''
            #end add-point
            CALL adet408_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaysite
            
            #add-point:AFTER FIELD deaysite name="input.a.deaysite"
            LET g_deay_m.deaysite_desc = ' '
            DISPLAY BY NAME g_deay_m.deaysite_desc
            IF NOT cl_null(g_deay_m.deaysite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deay_m.deaysite != g_deay_m_t.deaysite OR g_deay_m_t.deaysite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'deaysite',g_deay_m.deaysite,g_deay_m.deaysite)
                  RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err() 
                  
                     LET g_deay_m.deaysite = g_deay_m_t.deaysite
                     LET g_deay_m.deaysite_desc = s_desc_get_department_desc(g_deay_m.deaysite)
                     DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc
                     
                  ELSE
                     LET g_ins_site_flag = 'Y'
                  END IF
               END IF
               IF NOT cl_null(g_deay_m.deaydocdt) AND NOT cl_null(g_deay_m.deaysite) THEN
                 IF NOT s_settledate_chk(g_deay_m.deaysite,g_deay_m.deaydocdt) THEN
                     LET g_deay_m.deaysite = g_deay_m_t.deaysite
                     LET g_deay_m.deaysite_desc = s_desc_get_department_desc(g_deay_m.deaysite)
                     DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc
                     NEXT FIELD CURRENT
                 END IF
               END IF
               IF NOT cl_null(g_deay_m.deay003) AND NOT cl_null(g_deay_m.deaysite) THEN
                  IF NOT s_settledate_chk(g_deay_m.deaysite,g_deay_m.deay003) THEN
                     LET g_deay_m.deaysite = g_deay_m_t.deaysite
                     LET g_deay_m.deaysite_desc = s_desc_get_department_desc(g_deay_m.deaysite)
                     DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'sub-00507'
               LET g_errparam.popup  = TRUE
               CALL cl_err() 
               NEXT FIELD CURRENT                
            END IF
            LET g_deay_m.deaysite_desc = s_desc_get_department_desc(g_deay_m.deaysite)
            DISPLAY BY NAME g_deay_m.deaysite_desc  

            CALL adet408_set_entry(p_cmd)
            CALL adet408_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaysite
            #add-point:BEFORE FIELD deaysite name="input.b.deaysite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaysite
            #add-point:ON CHANGE deaysite name="input.g.deaysite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaydocdt
            #add-point:BEFORE FIELD deaydocdt name="input.b.deaydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaydocdt
            
            #add-point:AFTER FIELD deaydocdt name="input.a.deaydocdt"
            IF NOT cl_null(g_deay_m.deaydocdt) AND NOT cl_null(g_deay_m.deaysite) THEN
               IF NOT s_settledate_chk(g_deay_m.deaysite,g_deay_m.deaydocdt) THEN
                   LET g_deay_m.deaydocdt = g_deay_m_t.deaydocdt
                   DISPLAY BY NAME g_deay_m.deaydocdt
                   NEXT FIELD CURRENT
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaydocdt
            #add-point:ON CHANGE deaydocdt name="input.g.deaydocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaydocno
            #add-point:BEFORE FIELD deaydocno name="input.b.deaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaydocno
            
            #add-point:AFTER FIELD deaydocno name="input.a.deaydocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_deay_m.deaydocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_deay_m.deaydocno != g_deaydocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deay_t WHERE "||"deayent = '" ||g_enterprise|| "' AND "||"deaydocno = '"||g_deay_m.deaydocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT s_aooi200_chk_slip(g_deay_m.deaysite,'',g_deay_m.deaydocno,g_prog) THEN
                        LET g_deay_m.deaydocno = g_deaydocno_t
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaydocno
            #add-point:ON CHANGE deaydocno name="input.g.deaydocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay001
            #add-point:BEFORE FIELD deay001 name="input.b.deay001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay001
            
            #add-point:AFTER FIELD deay001 name="input.a.deay001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deay001
            #add-point:ON CHANGE deay001 name="input.g.deay001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay002
            
            #add-point:AFTER FIELD deay002 name="input.a.deay002"
            LET g_deay_m.deay002_desc = ' '
            DISPLAY BY NAME g_deay_m.deay002_desc
            IF NOT cl_null(g_deay_m.deay002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deay_m.deay002 != g_deay_m_t.deay002 OR g_deay_m_t.deay002 IS NULL )) THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_deay_m.deay002
#                  LET g_chkparam.arg2 = g_deay_m.deay001
#                  LET g_chkparam.arg3 = g_deay_m.deaysite
#                  IF NOT cl_chk_exist("v_ooie001_1") THEN
#                     LET g_deay_m.deay002 = g_deay_m_t.deay002
#                     LET g_deay_m.deay002_desc = s_desc_get_ooial_desc(g_deay_m.deay002)
#                     DISPLAY BY NAME g_deay_m.deay002,g_deay_m.deay002_desc                     
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_money_chk('2',g_deay_m.deaysite,g_deay_m.deay002) RETURNING l_success,g_errno,l_no,l_ooia002
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_deay_m.deay002 = g_deay_m_t.deay002
                     LET g_deay_m.deay002_desc = s_desc_get_ooial_desc(g_deay_m.deay002)
                     DISPLAY BY NAME g_deay_m.deay002,g_deay_m.deay002_desc                     
                     NEXT FIELD CURRENT
                  END IF
                  IF l_ooia002 != g_deay_m.deay001 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deay_m.deay002
                     LET g_errparam.code   = "aoo-00402"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_deay_m.deay002 = g_deay_m_t.deay002
                     LET g_deay_m.deay002_desc = s_desc_get_ooial_desc(g_deay_m.deay002)
                     DISPLAY BY NAME g_deay_m.deay002,g_deay_m.deay002_desc                     
                     NEXT FIELD CURRENT
                  END IF 
               END IF
            END IF
            LET g_deay_m.deay002_desc = s_desc_get_ooial_desc(g_deay_m.deay002)
            DISPLAY BY NAME g_deay_m.deay002,g_deay_m.deay002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay002
            #add-point:BEFORE FIELD deay002 name="input.b.deay002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deay002
            #add-point:ON CHANGE deay002 name="input.g.deay002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay003
            #add-point:BEFORE FIELD deay003 name="input.b.deay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay003
            
            #add-point:AFTER FIELD deay003 name="input.a.deay003"
            IF NOT cl_null(g_deay_m.deay003) AND NOT cl_null(g_deay_m.deaysite) THEN
               IF NOT s_settledate_chk(g_deay_m.deaysite,g_deay_m.deay003) THEN
                   LET g_deay_m.deay003 = g_deay_m_t.deay003
                   DISPLAY BY NAME g_deay_m.deay003
                   NEXT FIELD CURRENT
               END IF
            END IF    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deay003
            #add-point:ON CHANGE deay003 name="input.g.deay003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay006
            
            #add-point:AFTER FIELD deay006 name="input.a.deay006"
            LET g_deay_m.deay006_desc = ' '
            DISPLAY BY NAME g_deay_m.deay006_desc
            IF NOT cl_null(g_deay_m.deay006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deay_m.deay006 != g_deay_m_t.deay006 OR g_deay_m_t.deay006 IS NULL )) THEN
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                  LET g_chkparam.arg1 = g_deay_m.deaysite
                  LET g_chkparam.arg2 = g_deay_m.deay006
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"#要執行的建議程式待補#160318-00025#28  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     #檢查失敗時後續處理
                     LET g_deay_m.deay006 = g_deay_m_t.deay006
                     LET g_deay_m.deay006_desc = s_desc_get_currency_desc(g_deay_m.deay006)
                     DISPLAY BY NAME g_deay_m.deay006,g_deay_m.deay006_desc
                     NEXT FIELD CURRENT
                  END IF  
               END IF
            END IF
            LET g_deay_m.deay006_desc = s_desc_get_currency_desc(g_deay_m.deay006)
            DISPLAY BY NAME g_deay_m.deay006_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay006
            #add-point:BEFORE FIELD deay006 name="input.b.deay006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deay006
            #add-point:ON CHANGE deay006 name="input.g.deay006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay005
            
            #add-point:AFTER FIELD deay005 name="input.a.deay005"
            LET g_deay_m.deay005_desc = ' '
            DISPLAY BY NAME g_deay_m.deay005_desc
            IF NOT cl_null(g_deay_m.deay005) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deay_m.deay005 != g_deay_m_t.deay005 OR g_deay_m_t.deay005 IS NULL )) THEN   #160824-00007#73 Mark By Ken 161011
               IF (g_deay_m.deay005 != g_deay_m_o.deay005 OR g_deay_m_o.deay005 IS NULL ) THEN    #160824-00007#73 Add By Ken 161011
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                  LET g_chkparam.arg1 = g_deay_m.deay005
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補#160318-00025#28  add
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_deay_m.deay005 = g_deay_m_t.deay005  #160824-00007#73 Mark By Ken 161011
                     LET g_deay_m.deay005 = g_deay_m_o.deay005   #160824-00007#73 Add By Ken 161011
                     LET g_deay_m.deay005_desc = s_desc_get_person_desc(g_deay_m.deay005)
                     DISPLAY BY NAME g_deay_m.deay005,g_deay_m.deay005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #帶出歸屬部門ooag003
            SELECT ooag003 INTO g_deay_m.deay004
              FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_xmdk_m.xmdk003
               
            LET g_deay_m.deay004_desc = s_desc_get_department_desc(g_deay_m.deay004)
            LET g_deay_m.deay005_desc = s_desc_get_person_desc(g_deay_m.deay005)
            DISPLAY BY NAME g_deay_m.deay004,g_deay_m.deay004_desc,g_deay_m.deay005_desc
            LET g_deay_m_o.* = g_deay_m.*   #160824-00007#73 Add By Ken 161011
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay005
            #add-point:BEFORE FIELD deay005 name="input.b.deay005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deay005
            #add-point:ON CHANGE deay005 name="input.g.deay005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deay004
            
            #add-point:AFTER FIELD deay004 name="input.a.deay004"
            LET g_deay_m.deay004_desc = ' '
            DISPLAY BY NAME g_deay_m.deay004_desc
            IF NOT cl_null(g_deay_m.deay004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_deay_m.deay004 != g_deay_m_t.deay004 OR g_deay_m_t.deay004 IS NULL )) THEN     #160824-00007#73 Mark By Ken 161011
               IF (g_deay_m.deay004 != g_deay_m_o.deay004 OR g_deay_m_o.deay004 IS NULL ) THEN                #160824-00007#73 Add By Ken 161011
                  #161006-00008#10 161017 by lori add---(S)
                  IF s_aooi500_setpoint(g_prog,'deay004') THEN
                     LET l_success = ''
                     LET l_errno = ''
                                       
                     CALL s_aooi500_chk(g_prog,'deay004',g_deay_m.deay004,g_deay_m.deaysite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = g_deay_m.deay004
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                  
                        NEXT FIELD CURRENT
                     END IF
                  ELSE                  
                  #161006-00008#10 161017 by lori add---(E)
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = TRUE #是否開窗 #160318-00025#28  add
                     LET g_chkparam.arg1 = g_deay_m.deay004
                     LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補#160318-00025#28  add
                     IF NOT cl_chk_exist("v_ooef001_14") THEN
                        #LET g_deay_m.deay004 = g_deay_m_t.deay004  #160824-00007#73 Mark By Ken 161011
                        LET g_deay_m.deay004 = g_deay_m_o.deay004   #160824-00007#73 Add By Ken 161011
                        LET g_deay_m.deay004_desc = s_desc_get_department_desc(g_deay_m.deay004)
                        DISPLAY BY NAME g_deay_m.deay004,g_deay_m.deay004_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF    #161006-00008#10 161017 by lori add    
               END IF
            END IF
            LET g_deay_m.deay004_desc = s_desc_get_department_desc(g_deay_m.deay004)
            DISPLAY BY NAME g_deay_m.deay004_desc
            LET g_deay_m_o.* = g_deay_m.*   #160824-00007#73 Add By Ken 161011
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deay004
            #add-point:BEFORE FIELD deay004 name="input.b.deay004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deay004
            #add-point:ON CHANGE deay004 name="input.g.deay004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deayunit
            #add-point:BEFORE FIELD deayunit name="input.b.deayunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deayunit
            
            #add-point:AFTER FIELD deayunit name="input.a.deayunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deayunit
            #add-point:ON CHANGE deayunit name="input.g.deayunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaystus
            #add-point:BEFORE FIELD deaystus name="input.b.deaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaystus
            
            #add-point:AFTER FIELD deaystus name="input.a.deaystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaystus
            #add-point:ON CHANGE deaystus name="input.g.deaystus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deaysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaysite
            #add-point:ON ACTION controlp INFIELD deaysite name="input.c.deaysite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_deay_m.deaysite             #給予default值
            LET g_qryparam.default2 = "" #g_deay_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deaysite',g_deay_m.deaysite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()                               

            LET g_deay_m.deaysite = g_qryparam.return1   
            LET g_deay_m.deaysite_desc = s_desc_get_department_desc(g_deay_m.deaysite)
            DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc
                     
            NEXT FIELD deaysite                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.deaydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaydocdt
            #add-point:ON ACTION controlp INFIELD deaydocdt name="input.c.deaydocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.deaydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaydocno
            #add-point:ON ACTION controlp INFIELD deaydocno name="input.c.deaydocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deay_m.deaydocno             #給予default值

            #給予arg
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooef001 = g_deay_m.deaysite
               AND ooefent = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_deay_m.deaydocno = g_qryparam.return1    
            DISPLAY g_deay_m.deaydocno TO deaydocno              #

            NEXT FIELD deaydocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.deay001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay001
            #add-point:ON ACTION controlp INFIELD deay001 name="input.c.deay001"
            
            #END add-point
 
 
         #Ctrlp:input.c.deay002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay002
            #add-point:ON ACTION controlp INFIELD deay002 name="input.c.deay002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deay_m.deay002             #給予default值
            CALL s_money_where(g_deay_m.deaysite) RETURNING l_str
            LET g_qryparam.where = l_str," AND ooia002 = '",g_deay_m.deay001 ,"'"
            CALL q_ooia001()
            LET g_deay_m.deay002 = g_qryparam.return1    
            LET g_deay_m.deay002_desc = s_desc_get_ooial_desc(g_deay_m.deay002)
            DISPLAY BY NAME g_deay_m.deay002,g_deay_m.deay002_desc 
            NEXT FIELD deay002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.deay003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay003
            #add-point:ON ACTION controlp INFIELD deay003 name="input.c.deay003"
            
            #END add-point
 
 
         #Ctrlp:input.c.deay006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay006
            #add-point:ON ACTION controlp INFIELD deay006 name="input.c.deay006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deay_m.deay006      #給予default值
            LET g_qryparam.arg1 = g_deay_m.deaysite 
            CALL q_ooaj002_1()                              #呼叫開窗
            LET g_deay_m.deay006 = g_qryparam.return1    
            LET g_deay_m.deay006_desc = s_desc_get_currency_desc(g_deay_m.deay006)
            DISPLAY BY NAME g_deay_m.deay006,g_deay_m.deay006_desc
            NEXT FIELD deay006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deay005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay005
            #add-point:ON ACTION controlp INFIELD deay005 name="input.c.deay005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deay_m.deay005       
            #CALL q_ooag001_2()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            CALL q_ooag001_4()                           #呼叫開窗    #151228-00009#1 20151230 add by beckxie
            LET g_deay_m.deay005 = g_qryparam.return1          
            LET g_deay_m.deay005_desc = s_desc_get_person_desc(g_deay_m.deay005)
            DISPLAY BY NAME g_deay_m.deay005,g_deay_m.deay005_desc            
            NEXT FIELD deay005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.deay004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deay004
            #add-point:ON ACTION controlp INFIELD deay004 name="input.c.deay004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deay_m.deay004  
            
           #CALL q_ooef001_9()   #161006-00008#10 161017 by lori mark

            #161006-00008#10 161017 by lori add---(S)
            IF s_aooi500_setpoint(g_prog,'deay004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'deay004',g_deay_m.deaysite,'i')
               CALL q_ooef001_24()                   
            ELSE            
               CALL q_ooef001_9() 
            END IF    
            #161006-00008#10 161017 by lori add---(S)
            
            LET g_deay_m.deay004 = g_qryparam.return1  
            LET g_deay_m.deay004_desc = s_desc_get_department_desc(g_deay_m.deay004)
            DISPLAY BY NAME g_deay_m.deay004,g_deay_m.deay004_desc
            NEXT FIELD deay004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.deayunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deayunit
            #add-point:ON ACTION controlp INFIELD deayunit name="input.c.deayunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.deaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaystus
            #add-point:ON ACTION controlp INFIELD deaystus name="input.c.deaystus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_deay_m.deaydocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               LET g_deay_m.deayunit = g_deay_m.deaysite
               #自動產生單號
               CALL s_aooi200_gen_docno(g_deay_m.deaysite,g_deay_m.deaydocno,g_deay_m.deaydocdt,'adet408')
               RETURNING l_success,g_deay_m.deaydocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_deay_m.deaydocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN l_success
               END IF               
               #end add-point
               
               INSERT INTO deay_t (deayent,deaysite,deaydocdt,deaydocno,deay001,deay002,deay003,deay006, 
                   deay005,deay004,deayunit,deaystus,deayownid,deayowndp,deaycrtid,deaycrtdp,deaycrtdt, 
                   deaymodid,deaymoddt,deaycnfid,deaycnfdt,deaypstid,deaypstdt)
               VALUES (g_enterprise,g_deay_m.deaysite,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001, 
                   g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005,g_deay_m.deay004, 
                   g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
                   g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
                   g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_deay_m:",SQLERRMESSAGE 
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
                  CALL adet408_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adet408_b_fill()
                  CALL adet408_b_fill2('0')
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
               CALL adet408_deay_t_mask_restore('restore_mask_o')
               
               UPDATE deay_t SET (deaysite,deaydocdt,deaydocno,deay001,deay002,deay003,deay006,deay005, 
                   deay004,deayunit,deaystus,deayownid,deayowndp,deaycrtid,deaycrtdp,deaycrtdt,deaymodid, 
                   deaymoddt,deaycnfid,deaycnfdt,deaypstid,deaypstdt) = (g_deay_m.deaysite,g_deay_m.deaydocdt, 
                   g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006, 
                   g_deay_m.deay005,g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid, 
                   g_deay_m.deayowndp,g_deay_m.deaycrtid,g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid, 
                   g_deay_m.deaymoddt,g_deay_m.deaycnfid,g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt) 
 
                WHERE deayent = g_enterprise AND deaydocno = g_deaydocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "deay_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adet408_deay_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_deay_m_t)
               LET g_log2 = util.JSON.stringify(g_deay_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_deaydocno_t = g_deay_m.deaydocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adet408.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_deaa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_deaa_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adet408_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_deaa_d.getLength()
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
            OPEN adet408_cl USING g_enterprise,g_deay_m.deaydocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet408_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet408_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_deaa_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_deaa_d[l_ac].deaaseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_deaa_d_t.* = g_deaa_d[l_ac].*  #BACKUP
               LET g_deaa_d_o.* = g_deaa_d[l_ac].*  #BACKUP
               CALL adet408_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adet408_set_no_entry_b(l_cmd)
               IF NOT adet408_lock_b("deaa_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adet408_bcl INTO g_deaa_d[l_ac].deaaseq,g_deaa_d[l_ac].deaaseq1,g_deaa_d[l_ac].deaa003, 
                      g_deaa_d[l_ac].deaa015,g_deaa_d[l_ac].deaa012,g_deaa_d[l_ac].deaa004,g_deaa_d[l_ac].deaa005, 
                      g_deaa_d[l_ac].deaa006,g_deaa_d[l_ac].deaa007,g_deaa_d[l_ac].deaa008,g_deaa_d[l_ac].deaa010, 
                      g_deaa_d[l_ac].deaa009,g_deaa_d[l_ac].deaa011,g_deaa_d[l_ac].deaa014,g_deaa_d[l_ac].deaa013, 
                      g_deaa_d[l_ac].deaa016,g_deaa_d[l_ac].deaasite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deaa_d_t.deaaseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_deaa_d_mask_o[l_ac].* =  g_deaa_d[l_ac].*
                  CALL adet408_deaa_t_mask()
                  LET g_deaa_d_mask_n[l_ac].* =  g_deaa_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adet408_show()
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
            INITIALIZE g_deaa_d[l_ac].* TO NULL 
            INITIALIZE g_deaa_d_t.* TO NULL 
            INITIALIZE g_deaa_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_deaa_d[l_ac].deaa005 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_deaa_d_t.* = g_deaa_d[l_ac].*     #新輸入資料
            LET g_deaa_d_o.* = g_deaa_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adet408_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adet408_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_deaa_d[li_reproduce_target].* = g_deaa_d[li_reproduce].*
 
               LET g_deaa_d[li_reproduce_target].deaaseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM deaa_t 
             WHERE deaaent = g_enterprise AND deaadocno = g_deay_m.deaydocno
 
               AND deaaseq = g_deaa_d[l_ac].deaaseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deay_m.deaydocno
               LET gs_keys[2] = g_deaa_d[g_detail_idx].deaaseq
               CALL adet408_insert_b('deaa_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_deaa_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deaa_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adet408_b_fill()
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
               LET gs_keys[01] = g_deay_m.deaydocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_deaa_d_t.deaaseq
 
            
               #刪除同層單身
               IF NOT adet408_delete_b('deaa_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet408_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adet408_key_delete_b(gs_keys,'deaa_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet408_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adet408_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_deaa_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_deaa_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaaseq
            #add-point:BEFORE FIELD deaaseq name="input.b.page1.deaaseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaaseq
            
            #add-point:AFTER FIELD deaaseq name="input.a.page1.deaaseq"
            #此段落由子樣板a05產生
            IF  g_deay_m.deaydocno IS NOT NULL AND g_deaa_d[g_detail_idx].deaaseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_deay_m.deaydocno != g_deaydocno_t OR g_deaa_d[g_detail_idx].deaaseq != g_deaa_d_t.deaaseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deaa_t WHERE "||"deaaent = '" ||g_enterprise|| "' AND "||"deaadocno = '"||g_deay_m.deaydocno ||"' AND "|| "deaaseq = '"||g_deaa_d[g_detail_idx].deaaseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaaseq
            #add-point:ON CHANGE deaaseq name="input.g.page1.deaaseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaaseq1
            #add-point:BEFORE FIELD deaaseq1 name="input.b.page1.deaaseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaaseq1
            
            #add-point:AFTER FIELD deaaseq1 name="input.a.page1.deaaseq1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaaseq1
            #add-point:ON CHANGE deaaseq1 name="input.g.page1.deaaseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa003
            #add-point:BEFORE FIELD deaa003 name="input.b.page1.deaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa003
            
            #add-point:AFTER FIELD deaa003 name="input.a.page1.deaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa003
            #add-point:ON CHANGE deaa003 name="input.g.page1.deaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa015
            #add-point:BEFORE FIELD deaa015 name="input.b.page1.deaa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa015
            
            #add-point:AFTER FIELD deaa015 name="input.a.page1.deaa015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa015
            #add-point:ON CHANGE deaa015 name="input.g.page1.deaa015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa012
            #add-point:BEFORE FIELD deaa012 name="input.b.page1.deaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa012
            
            #add-point:AFTER FIELD deaa012 name="input.a.page1.deaa012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa012
            #add-point:ON CHANGE deaa012 name="input.g.page1.deaa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa004
            #add-point:BEFORE FIELD deaa004 name="input.b.page1.deaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa004
            
            #add-point:AFTER FIELD deaa004 name="input.a.page1.deaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa004
            #add-point:ON CHANGE deaa004 name="input.g.page1.deaa004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa005
            #add-point:BEFORE FIELD deaa005 name="input.b.page1.deaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa005
            
            #add-point:AFTER FIELD deaa005 name="input.a.page1.deaa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa005
            #add-point:ON CHANGE deaa005 name="input.g.page1.deaa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa006
            #add-point:BEFORE FIELD deaa006 name="input.b.page1.deaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa006
            
            #add-point:AFTER FIELD deaa006 name="input.a.page1.deaa006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa006
            #add-point:ON CHANGE deaa006 name="input.g.page1.deaa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa007
            #add-point:BEFORE FIELD deaa007 name="input.b.page1.deaa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa007
            
            #add-point:AFTER FIELD deaa007 name="input.a.page1.deaa007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa007
            #add-point:ON CHANGE deaa007 name="input.g.page1.deaa007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa008
            
            #add-point:AFTER FIELD deaa008 name="input.a.page1.deaa008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaa_d[l_ac].deaasite
            LET g_ref_fields[2] = g_deaa_d[l_ac].deaa008
            CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogdsite=? AND oogd001=? ","") RETURNING g_rtn_fields
            LET g_deaa_d[l_ac].deaa008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaa_d[l_ac].deaa008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa008
            #add-point:BEFORE FIELD deaa008 name="input.b.page1.deaa008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa008
            #add-point:ON CHANGE deaa008 name="input.g.page1.deaa008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa010
            
            #add-point:AFTER FIELD deaa010 name="input.a.page1.deaa010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaa_d[l_ac].deaa010
            CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_deaa_d[l_ac].deaa010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaa_d[l_ac].deaa010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa010
            #add-point:BEFORE FIELD deaa010 name="input.b.page1.deaa010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa010
            #add-point:ON CHANGE deaa010 name="input.g.page1.deaa010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa009
            
            #add-point:AFTER FIELD deaa009 name="input.a.page1.deaa009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaa_d[l_ac].deaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_deaa_d[l_ac].deaa009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaa_d[l_ac].deaa009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa009
            #add-point:BEFORE FIELD deaa009 name="input.b.page1.deaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa009
            #add-point:ON CHANGE deaa009 name="input.g.page1.deaa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa011
            #add-point:BEFORE FIELD deaa011 name="input.b.page1.deaa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa011
            
            #add-point:AFTER FIELD deaa011 name="input.a.page1.deaa011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa011
            #add-point:ON CHANGE deaa011 name="input.g.page1.deaa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa014
            #add-point:BEFORE FIELD deaa014 name="input.b.page1.deaa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa014
            
            #add-point:AFTER FIELD deaa014 name="input.a.page1.deaa014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa014
            #add-point:ON CHANGE deaa014 name="input.g.page1.deaa014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa013
            #add-point:BEFORE FIELD deaa013 name="input.b.page1.deaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa013
            
            #add-point:AFTER FIELD deaa013 name="input.a.page1.deaa013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa013
            #add-point:ON CHANGE deaa013 name="input.g.page1.deaa013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaa016
            #add-point:BEFORE FIELD deaa016 name="input.b.page1.deaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaa016
            
            #add-point:AFTER FIELD deaa016 name="input.a.page1.deaa016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaa016
            #add-point:ON CHANGE deaa016 name="input.g.page1.deaa016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaasite
            
            #add-point:AFTER FIELD deaasite name="input.a.page1.deaasite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_deaa_d[l_ac].deaasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_deaa_d[l_ac].deaasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_deaa_d[l_ac].deaasite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaasite
            #add-point:BEFORE FIELD deaasite name="input.b.page1.deaasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaasite
            #add-point:ON CHANGE deaasite name="input.g.page1.deaasite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.deaaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaaseq
            #add-point:ON ACTION controlp INFIELD deaaseq name="input.c.page1.deaaseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaaseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaaseq1
            #add-point:ON ACTION controlp INFIELD deaaseq1 name="input.c.page1.deaaseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa003
            #add-point:ON ACTION controlp INFIELD deaa003 name="input.c.page1.deaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa015
            #add-point:ON ACTION controlp INFIELD deaa015 name="input.c.page1.deaa015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa012
            #add-point:ON ACTION controlp INFIELD deaa012 name="input.c.page1.deaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa004
            #add-point:ON ACTION controlp INFIELD deaa004 name="input.c.page1.deaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa005
            #add-point:ON ACTION controlp INFIELD deaa005 name="input.c.page1.deaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa006
            #add-point:ON ACTION controlp INFIELD deaa006 name="input.c.page1.deaa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa007
            #add-point:ON ACTION controlp INFIELD deaa007 name="input.c.page1.deaa007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa008
            #add-point:ON ACTION controlp INFIELD deaa008 name="input.c.page1.deaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa010
            #add-point:ON ACTION controlp INFIELD deaa010 name="input.c.page1.deaa010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa009
            #add-point:ON ACTION controlp INFIELD deaa009 name="input.c.page1.deaa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa011
            #add-point:ON ACTION controlp INFIELD deaa011 name="input.c.page1.deaa011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa014
            #add-point:ON ACTION controlp INFIELD deaa014 name="input.c.page1.deaa014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa013
            #add-point:ON ACTION controlp INFIELD deaa013 name="input.c.page1.deaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaa016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaa016
            #add-point:ON ACTION controlp INFIELD deaa016 name="input.c.page1.deaa016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaasite
            #add-point:ON ACTION controlp INFIELD deaasite name="input.c.page1.deaasite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_deaa_d[l_ac].* = g_deaa_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adet408_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_deaa_d[l_ac].deaaseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_deaa_d[l_ac].* = g_deaa_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adet408_deaa_t_mask_restore('restore_mask_o')
      
               UPDATE deaa_t SET (deaadocno,deaaseq,deaaseq1,deaa003,deaa015,deaa012,deaa004,deaa005, 
                   deaa006,deaa007,deaa008,deaa010,deaa009,deaa011,deaa014,deaa013,deaa016,deaasite) = (g_deay_m.deaydocno, 
                   g_deaa_d[l_ac].deaaseq,g_deaa_d[l_ac].deaaseq1,g_deaa_d[l_ac].deaa003,g_deaa_d[l_ac].deaa015, 
                   g_deaa_d[l_ac].deaa012,g_deaa_d[l_ac].deaa004,g_deaa_d[l_ac].deaa005,g_deaa_d[l_ac].deaa006, 
                   g_deaa_d[l_ac].deaa007,g_deaa_d[l_ac].deaa008,g_deaa_d[l_ac].deaa010,g_deaa_d[l_ac].deaa009, 
                   g_deaa_d[l_ac].deaa011,g_deaa_d[l_ac].deaa014,g_deaa_d[l_ac].deaa013,g_deaa_d[l_ac].deaa016, 
                   g_deaa_d[l_ac].deaasite)
                WHERE deaaent = g_enterprise AND deaadocno = g_deay_m.deaydocno 
 
                  AND deaaseq = g_deaa_d_t.deaaseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_deaa_d[l_ac].* = g_deaa_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deaa_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_deaa_d[l_ac].* = g_deaa_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deaa_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_deay_m.deaydocno
               LET gs_keys_bak[1] = g_deaydocno_t
               LET gs_keys[2] = g_deaa_d[g_detail_idx].deaaseq
               LET gs_keys_bak[2] = g_deaa_d_t.deaaseq
               CALL adet408_update_b('deaa_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adet408_deaa_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_deaa_d[g_detail_idx].deaaseq = g_deaa_d_t.deaaseq 
 
                  ) THEN
                  LET gs_keys[01] = g_deay_m.deaydocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_deaa_d_t.deaaseq
 
                  CALL adet408_key_update_b(gs_keys,'deaa_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_deay_m),util.JSON.stringify(g_deaa_d_t)
               LET g_log2 = util.JSON.stringify(g_deay_m),util.JSON.stringify(g_deaa_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL adet408_unlock_b("deaa_t","'1'")
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
               LET g_deaa_d[li_reproduce_target].* = g_deaa_d[li_reproduce].*
 
               LET g_deaa_d[li_reproduce_target].deaaseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_deaa_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_deaa_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_deaa2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL adet408_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL adet408_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="adet408.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD deaysite 
            #end add-point  
            NEXT FIELD deaydocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD deaaseq
               WHEN "s_detail2"
                  NEXT FIELD deazseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adet408_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF NOT cl_null(g_deay_m.deaydocno) THEN
      CALL adet408_get_rtjf() 
   END IF   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adet408_b_fill() #單身填充
      CALL adet408_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adet408_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_deay_m_mask_o.* =  g_deay_m.*
   CALL adet408_deay_t_mask()
   LET g_deay_m_mask_n.* =  g_deay_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001, 
       g_deay_m.deay002,g_deay_m.deay002_desc,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay006_desc, 
       g_deay_m.deay005,g_deay_m.deay005_desc,g_deay_m.deay004,g_deay_m.deay004_desc,g_deay_m.deayunit, 
       g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayownid_desc,g_deay_m.deayowndp,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid,g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp,g_deay_m.deaycrtdp_desc,g_deay_m.deaycrtdt, 
       g_deay_m.deaymodid,g_deay_m.deaymodid_desc,g_deay_m.deaymoddt,g_deay_m.deaycnfid,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstid_desc,g_deay_m.deaypstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deay_m.deaystus 
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
   FOR l_ac = 1 TO g_deaa_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_deaa2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adet408_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adet408_detail_show()
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
 
{<section id="adet408.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adet408_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE deay_t.deaydocno 
   DEFINE l_oldno     LIKE deay_t.deaydocno 
 
   DEFINE l_master    RECORD LIKE deay_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE deaa_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE deaz_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert        LIKE type_t.num5
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
   
   IF g_deay_m.deaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_deaydocno_t = g_deay_m.deaydocno
 
    
   LET g_deay_m.deaydocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_deay_m.deayownid = g_user
      LET g_deay_m.deayowndp = g_dept
      LET g_deay_m.deaycrtid = g_user
      LET g_deay_m.deaycrtdp = g_dept 
      LET g_deay_m.deaycrtdt = cl_get_current()
      LET g_deay_m.deaymodid = g_user
      LET g_deay_m.deaymoddt = cl_get_current()
      LET g_deay_m.deaystus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL s_aooi500_default(g_prog,'deaysite',g_deay_m.deaysite)
      RETURNING l_insert,g_deay_m.deaysite
   IF l_insert = FALSE THEN
      RETURN
   END IF 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_deay_m.deaystus 
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
   
   
   CALL adet408_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_deay_m.* TO NULL
      INITIALIZE g_deaa_d TO NULL
      INITIALIZE g_deaa2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adet408_show()
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
   CALL adet408_set_act_visible()   
   CALL adet408_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deaydocno_t = g_deay_m.deaydocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deayent = " ||g_enterprise|| " AND",
                      " deaydocno = '", g_deay_m.deaydocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet408_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adet408_idx_chk()
   
   LET g_data_owner = g_deay_m.deayownid      
   LET g_data_dept  = g_deay_m.deayowndp
   
   #功能已完成,通報訊息中心
   CALL adet408_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adet408_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE deaa_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE deaz_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adet408_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM deaa_t
    WHERE deaaent = g_enterprise AND deaadocno = g_deaydocno_t
 
    INTO TEMP adet408_detail
 
   #將key修正為調整後   
   UPDATE adet408_detail 
      #更新key欄位
      SET deaadocno = g_deay_m.deaydocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO deaa_t SELECT * FROM adet408_detail
   
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
   DROP TABLE adet408_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM deaz_t 
    WHERE deazent = g_enterprise AND deazdocno = g_deaydocno_t
 
    INTO TEMP adet408_detail
 
   #將key修正為調整後   
   UPDATE adet408_detail SET deazdocno = g_deay_m.deaydocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO deaz_t SELECT * FROM adet408_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE adet408_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_deaydocno_t = g_deay_m.deaydocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adet408_delete()
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
   
   IF g_deay_m.deaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adet408_cl USING g_enterprise,g_deay_m.deaydocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet408_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet408_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
       g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
       g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
       g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc,g_deay_m.deay002_desc, 
       g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaypstid_desc
   
   
   #檢查是否允許此動作
   IF NOT adet408_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_deay_m_mask_o.* =  g_deay_m.*
   CALL adet408_deay_t_mask()
   LET g_deay_m_mask_n.* =  g_deay_m.*
   
   CALL adet408_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adet408_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_deaydocno_t = g_deay_m.deaydocno
 
 
      DELETE FROM deay_t
       WHERE deayent = g_enterprise AND deaydocno = g_deay_m.deaydocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_deay_m.deaydocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM deaa_t
       WHERE deaaent = g_enterprise AND deaadocno = g_deay_m.deaydocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deaa_t:",SQLERRMESSAGE 
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
      DELETE FROM deaz_t
       WHERE deazent = g_enterprise AND
             deazdocno = g_deay_m.deaydocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      CALL g_rtjf_d.clear() 
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_deay_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adet408_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_deaa_d.clear() 
      CALL g_deaa2_d.clear()       
 
     
      CALL adet408_ui_browser_refresh()  
      #CALL adet408_ui_headershow()  
      #CALL adet408_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adet408_browser_fill("")
         CALL adet408_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adet408_cl
 
   #功能已完成,通報訊息中心
   CALL adet408_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adet408.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adet408_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_deaa_d.clear()
   CALL g_deaa2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
  
   #end add-point
   
   #判斷是否填充
   IF adet408_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT deaaseq,deaaseq1,deaa003,deaa015,deaa012,deaa004,deaa005,deaa006, 
             deaa007,deaa008,deaa010,deaa009,deaa011,deaa014,deaa013,deaa016,deaasite ,t1.oogd002 ,t2.pcaal003 , 
             t3.ooag011 ,t4.ooefl003 FROM deaa_t",   
                     " INNER JOIN deay_t ON deayent = " ||g_enterprise|| " AND deaydocno = deaadocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oogd_t t1 ON t1.oogdent="||g_enterprise||" AND t1.oogdsite=deaasite AND t1.oogd001=deaa008  ",
               " LEFT JOIN pcaal_t t2 ON t2.pcaalent="||g_enterprise||" AND t2.pcaalsite=deaasite AND t2.pcaal001=deaa010 AND t2.pcaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=deaa009  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=deaasite AND t4.ooefl002='"||g_dlang||"' ",
 
                     " WHERE deaaent=? AND deaadocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY deaa_t.deaaseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet408_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adet408_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_deay_m.deaydocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_deay_m.deaydocno INTO g_deaa_d[l_ac].deaaseq,g_deaa_d[l_ac].deaaseq1, 
          g_deaa_d[l_ac].deaa003,g_deaa_d[l_ac].deaa015,g_deaa_d[l_ac].deaa012,g_deaa_d[l_ac].deaa004, 
          g_deaa_d[l_ac].deaa005,g_deaa_d[l_ac].deaa006,g_deaa_d[l_ac].deaa007,g_deaa_d[l_ac].deaa008, 
          g_deaa_d[l_ac].deaa010,g_deaa_d[l_ac].deaa009,g_deaa_d[l_ac].deaa011,g_deaa_d[l_ac].deaa014, 
          g_deaa_d[l_ac].deaa013,g_deaa_d[l_ac].deaa016,g_deaa_d[l_ac].deaasite,g_deaa_d[l_ac].deaa008_desc, 
          g_deaa_d[l_ac].deaa010_desc,g_deaa_d[l_ac].deaa009_desc,g_deaa_d[l_ac].deaasite_desc   #(ver:78) 
 
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
    
   #判斷是否填充
   IF adet408_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT deazseq,deaz001,deaz002,deaz003,deaz004,deaz005,deaz006,deazsite  FROM deaz_t", 
                
                     " INNER JOIN  deay_t ON deayent = " ||g_enterprise|| " AND deaydocno = deazdocno ",
 
                     "",
                     
                     
                     " WHERE deazent=? AND deazdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY deaz_t.deazseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet408_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR adet408_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_deay_m.deaydocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_deay_m.deaydocno INTO g_deaa2_d[l_ac].deazseq,g_deaa2_d[l_ac].deaz001, 
          g_deaa2_d[l_ac].deaz002,g_deaa2_d[l_ac].deaz003,g_deaa2_d[l_ac].deaz004,g_deaa2_d[l_ac].deaz005, 
          g_deaa2_d[l_ac].deaz006,g_deaa2_d[l_ac].deazsite   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   IF adet408_fill_chk(3) THEN
      CALL g_rtjf_d.clear()
      
      LET g_sql = "SELECT rtjfsite,rtjfdocno,rtjfseq,rtjfseq1,rtjf001, ",
                  "       rtjf002 ,rtjf004  ,rtjf025,rtjf026 ,rtjf031, ",
                  "       rtjf027 ,rtjf028  ,rtjf029,rtjf030 ,rtjf005 ",
                  "  FROM adet408_tmp01 ",                     #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
                  " WHERE docno = '",g_deay_m.deaydocno,"' ",    
                  " ORDER BY rtjfdocno,rtjfseq,rtjfseq1 "
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adet408_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR adet408_pb3
      
      LET l_ac = 1
      
      FOREACH b_fill_cs3 INTO g_rtjf_d[l_ac].rtjfsite,g_rtjf_d[l_ac].rtjfdocno,g_rtjf_d[l_ac].rtjfseq, g_rtjf_d[l_ac].rtjfseq1,g_rtjf_d[l_ac].rtjf001, 
                              g_rtjf_d[l_ac].rtjf002 ,g_rtjf_d[l_ac].rtjf004  ,g_rtjf_d[l_ac].rtjf025 ,g_rtjf_d[l_ac].rtjf026, g_rtjf_d[l_ac].rtjf031,
                              g_rtjf_d[l_ac].rtjf027 ,g_rtjf_d[l_ac].rtjf028  ,g_rtjf_d[l_ac].rtjf029, g_rtjf_d[l_ac].rtjf030 ,g_rtjf_d[l_ac].rtjf005  
                                   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         SELECT oogd002 INTO g_rtjf_d[l_ac].rtjf028_desc
           FROM oogd_t
          WHERE oogdent = g_enterprise
            AND oogdsite = g_rtjf_d[l_ac].rtjfsite
            AND oogd001 = g_rtjf_d[l_ac].rtjf028
            
         LET g_rtjf_d[l_ac].rtjf029_desc = adet408_rtjf029_ref()
         LET g_rtjf_d[l_ac].rtjf030_desc = s_desc_get_person_desc(g_rtjf_d[l_ac].rtjf030)
        
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH         
   END IF
   
   CALL g_rtjf_d.deleteElement(g_rtjf_d.getLength())
   #end add-point
   
   CALL g_deaa_d.deleteElement(g_deaa_d.getLength())
   CALL g_deaa2_d.deleteElement(g_deaa2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adet408_pb
   FREE adet408_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_deaa_d.getLength()
      LET g_deaa_d_mask_o[l_ac].* =  g_deaa_d[l_ac].*
      CALL adet408_deaa_t_mask()
      LET g_deaa_d_mask_n[l_ac].* =  g_deaa_d[l_ac].*
   END FOR
   
   LET g_deaa2_d_mask_o.* =  g_deaa2_d.*
   FOR l_ac = 1 TO g_deaa2_d.getLength()
      LET g_deaa2_d_mask_o[l_ac].* =  g_deaa2_d[l_ac].*
      CALL adet408_deaz_t_mask()
      LET g_deaa2_d_mask_n[l_ac].* =  g_deaa2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adet408_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM deaa_t
       WHERE deaaent = g_enterprise AND
         deaadocno = ps_keys_bak[1] AND deaaseq = ps_keys_bak[2]
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
         CALL g_deaa_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM deaz_t
       WHERE deazent = g_enterprise AND
             deazdocno = ps_keys_bak[1] AND deazseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_deaa2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adet408_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO deaa_t
                  (deaaent,
                   deaadocno,
                   deaaseq
                   ,deaaseq1,deaa003,deaa015,deaa012,deaa004,deaa005,deaa006,deaa007,deaa008,deaa010,deaa009,deaa011,deaa014,deaa013,deaa016,deaasite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_deaa_d[g_detail_idx].deaaseq1,g_deaa_d[g_detail_idx].deaa003,g_deaa_d[g_detail_idx].deaa015, 
                       g_deaa_d[g_detail_idx].deaa012,g_deaa_d[g_detail_idx].deaa004,g_deaa_d[g_detail_idx].deaa005, 
                       g_deaa_d[g_detail_idx].deaa006,g_deaa_d[g_detail_idx].deaa007,g_deaa_d[g_detail_idx].deaa008, 
                       g_deaa_d[g_detail_idx].deaa010,g_deaa_d[g_detail_idx].deaa009,g_deaa_d[g_detail_idx].deaa011, 
                       g_deaa_d[g_detail_idx].deaa014,g_deaa_d[g_detail_idx].deaa013,g_deaa_d[g_detail_idx].deaa016, 
                       g_deaa_d[g_detail_idx].deaasite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deaa_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_deaa_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO deaz_t
                  (deazent,
                   deazdocno,
                   deazseq
                   ,deaz001,deaz002,deaz003,deaz004,deaz005,deaz006,deazsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_deaa2_d[g_detail_idx].deaz001,g_deaa2_d[g_detail_idx].deaz002,g_deaa2_d[g_detail_idx].deaz003, 
                       g_deaa2_d[g_detail_idx].deaz004,g_deaa2_d[g_detail_idx].deaz005,g_deaa2_d[g_detail_idx].deaz006, 
                       g_deaa2_d[g_detail_idx].deazsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_deaa2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adet408_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "deaa_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adet408_deaa_t_mask_restore('restore_mask_o')
               
      UPDATE deaa_t 
         SET (deaadocno,
              deaaseq
              ,deaaseq1,deaa003,deaa015,deaa012,deaa004,deaa005,deaa006,deaa007,deaa008,deaa010,deaa009,deaa011,deaa014,deaa013,deaa016,deaasite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_deaa_d[g_detail_idx].deaaseq1,g_deaa_d[g_detail_idx].deaa003,g_deaa_d[g_detail_idx].deaa015, 
                  g_deaa_d[g_detail_idx].deaa012,g_deaa_d[g_detail_idx].deaa004,g_deaa_d[g_detail_idx].deaa005, 
                  g_deaa_d[g_detail_idx].deaa006,g_deaa_d[g_detail_idx].deaa007,g_deaa_d[g_detail_idx].deaa008, 
                  g_deaa_d[g_detail_idx].deaa010,g_deaa_d[g_detail_idx].deaa009,g_deaa_d[g_detail_idx].deaa011, 
                  g_deaa_d[g_detail_idx].deaa014,g_deaa_d[g_detail_idx].deaa013,g_deaa_d[g_detail_idx].deaa016, 
                  g_deaa_d[g_detail_idx].deaasite) 
         WHERE deaaent = g_enterprise AND deaadocno = ps_keys_bak[1] AND deaaseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deaa_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deaa_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet408_deaa_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "deaz_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL adet408_deaz_t_mask_restore('restore_mask_o')
               
      UPDATE deaz_t 
         SET (deazdocno,
              deazseq
              ,deaz001,deaz002,deaz003,deaz004,deaz005,deaz006,deazsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_deaa2_d[g_detail_idx].deaz001,g_deaa2_d[g_detail_idx].deaz002,g_deaa2_d[g_detail_idx].deaz003, 
                  g_deaa2_d[g_detail_idx].deaz004,g_deaa2_d[g_detail_idx].deaz005,g_deaa2_d[g_detail_idx].deaz006, 
                  g_deaa2_d[g_detail_idx].deazsite) 
         WHERE deazent = g_enterprise AND deazdocno = ps_keys_bak[1] AND deazseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deaz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deaz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet408_deaz_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adet408_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adet408.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adet408_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adet408.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adet408_lock_b(ps_table,ps_page)
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
   #CALL adet408_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "deaa_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adet408_bcl USING g_enterprise,
                                       g_deay_m.deaydocno,g_deaa_d[g_detail_idx].deaaseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet408_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "deaz_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN adet408_bcl2 USING g_enterprise,
                                             g_deay_m.deaydocno,g_deaa2_d[g_detail_idx].deazseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet408_bcl2:",SQLERRMESSAGE 
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
 
{<section id="adet408.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adet408_unlock_b(ps_table,ps_page)
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
      CLOSE adet408_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE adet408_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adet408_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("deaydocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("deaydocno",TRUE)
      CALL cl_set_comp_entry("deaydocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("deaysite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF (NOT s_aooi500_comp_entry(g_prog,'deaysite') OR g_ins_site_flag = 'Y') THEN
      CALL cl_set_comp_entry("deaysite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adet408_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("deaydocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("deaydocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("deaydocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adet408_set_entry_b(p_cmd)
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
 
{<section id="adet408.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adet408_set_no_entry_b(p_cmd)
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
 
{<section id="adet408.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adet408_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet408.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adet408_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_deay_m.deaystus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet408.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adet408_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet408.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adet408_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet408.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adet408_default_search()
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
      LET ls_wc = ls_wc, " deaydocno = '", g_argv[01], "' AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "deay_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "deaa_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "deaz_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="adet408.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adet408_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_deay_m.deaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adet408_cl USING g_enterprise,g_deay_m.deaydocno
   IF STATUS THEN
      CLOSE adet408_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet408_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
       g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
       g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp,g_deay_m.deaycrtid, 
       g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc,g_deay_m.deay002_desc, 
       g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaypstid_desc
   
 
   #檢查是否允許此動作
   IF NOT adet408_action_chk() THEN
      CLOSE adet408_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc,g_deay_m.deaydocdt,g_deay_m.deaydocno,g_deay_m.deay001, 
       g_deay_m.deay002,g_deay_m.deay002_desc,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay006_desc, 
       g_deay_m.deay005,g_deay_m.deay005_desc,g_deay_m.deay004,g_deay_m.deay004_desc,g_deay_m.deayunit, 
       g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayownid_desc,g_deay_m.deayowndp,g_deay_m.deayowndp_desc, 
       g_deay_m.deaycrtid,g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp,g_deay_m.deaycrtdp_desc,g_deay_m.deaycrtdt, 
       g_deay_m.deaymodid,g_deay_m.deaymodid_desc,g_deay_m.deaymoddt,g_deay_m.deaycnfid,g_deay_m.deaycnfid_desc, 
       g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstid_desc,g_deay_m.deaypstdt
 
   CASE g_deay_m.deaystus
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
         CASE g_deay_m.deaystus
            
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
      #open皆改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("open_adbt408_s01",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_deay_m.deaystus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            CALL cl_set_act_visible("open_adbt408_s01",TRUE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            CALL cl_set_act_visible("open_adbt408_s01",TRUE)

         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            CALL cl_set_act_visible("open_adbt408_s01",TRUE)

        #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
            CALL cl_set_act_visible("open_adbt408_s01",TRUE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            CALL cl_set_act_visible("open_adbt408_s01",TRUE)

      END CASE            
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT adet408_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet408_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT adet408_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adet408_cl
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
      g_deay_m.deaystus = lc_state OR cl_null(lc_state) THEN
      CLOSE adet408_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN adet408_cl USING g_enterprise,g_deay_m.deaydocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adet408_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE adet408_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CALL cl_showmsg_init()
   #未確認改確認(N->Y)
   IF lc_state = 'Y' AND g_deay_m.deaystus = 'N' THEN
      CALL s_adet408_conf_chk(g_deay_m.deaydocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00108') THEN
            CALL s_adet408_conf_upd(g_deay_m.deaydocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_showmsg()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         END IF
      END IF
   END IF
   #確認改未確認(Y->N)
   IF lc_state = 'N' AND g_deay_m.deaystus = 'Y' THEN
      CALL s_adet408_unconf_chk(g_deay_m.deaydocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00110') THEN
            CALL s_adet408_unconf_upd(g_deay_m.deaydocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_showmsg()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         END IF
      END IF
   END IF
   #未確認改作廢(N->X)
   IF lc_state = 'X' AND g_deay_m.deaystus = 'N' THEN
      CALL s_adet408_invalid_chk(g_deay_m.deaydocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00109') THEN
            CALL s_adet408_invalid_upd(g_deay_m.deaydocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_showmsg()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         END IF
      END IF
   END IF   
   #end add-point
   
   LET g_deay_m.deaymodid = g_user
   LET g_deay_m.deaymoddt = cl_get_current()
   LET g_deay_m.deaystus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE deay_t 
      SET (deaystus,deaymodid,deaymoddt) 
        = (g_deay_m.deaystus,g_deay_m.deaymodid,g_deay_m.deaymoddt)     
    WHERE deayent = g_enterprise AND deaydocno = g_deay_m.deaydocno
 
    
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
      EXECUTE adet408_master_referesh USING g_deay_m.deaydocno INTO g_deay_m.deaysite,g_deay_m.deaydocdt, 
          g_deay_m.deaydocno,g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay003,g_deay_m.deay006,g_deay_m.deay005, 
          g_deay_m.deay004,g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayowndp, 
          g_deay_m.deaycrtid,g_deay_m.deaycrtdp,g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymoddt, 
          g_deay_m.deaycnfid,g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstdt,g_deay_m.deaysite_desc, 
          g_deay_m.deay002_desc,g_deay_m.deay006_desc,g_deay_m.deay005_desc,g_deay_m.deay004_desc,g_deay_m.deayownid_desc, 
          g_deay_m.deayowndp_desc,g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp_desc,g_deay_m.deaymodid_desc, 
          g_deay_m.deaycnfid_desc,g_deay_m.deaypstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_deay_m.deaysite,g_deay_m.deaysite_desc,g_deay_m.deaydocdt,g_deay_m.deaydocno, 
          g_deay_m.deay001,g_deay_m.deay002,g_deay_m.deay002_desc,g_deay_m.deay003,g_deay_m.deay006, 
          g_deay_m.deay006_desc,g_deay_m.deay005,g_deay_m.deay005_desc,g_deay_m.deay004,g_deay_m.deay004_desc, 
          g_deay_m.deayunit,g_deay_m.deaystus,g_deay_m.deayownid,g_deay_m.deayownid_desc,g_deay_m.deayowndp, 
          g_deay_m.deayowndp_desc,g_deay_m.deaycrtid,g_deay_m.deaycrtid_desc,g_deay_m.deaycrtdp,g_deay_m.deaycrtdp_desc, 
          g_deay_m.deaycrtdt,g_deay_m.deaymodid,g_deay_m.deaymodid_desc,g_deay_m.deaymoddt,g_deay_m.deaycnfid, 
          g_deay_m.deaycnfid_desc,g_deay_m.deaycnfdt,g_deay_m.deaypstid,g_deay_m.deaypstid_desc,g_deay_m.deaypstdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adet408_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet408_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet408.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adet408_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_deaa_d.getLength() THEN
         LET g_detail_idx = g_deaa_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_deaa_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_deaa_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_deaa2_d.getLength() THEN
         LET g_detail_idx = g_deaa2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_deaa2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_deaa2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_rtjf_d.getLength() THEN
         LET g_detail_idx = g_rtjf_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtjf_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtjf_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adet408_b_fill2(pi_idx)
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
   
   CALL adet408_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adet408_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      CALL adet408_get_rtjf() 
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   IF ps_idx = 3 THEN
      CALL adet408_get_rtjf()   
      RETURN TRUE      
   END IF
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adet408.status_show" >}
PRIVATE FUNCTION adet408_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adet408.mask_functions" >}
&include "erp/ade/adet408_mask.4gl"
 
{</section>}
 
{<section id="adet408.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION adet408_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL adet408_show()
   CALL adet408_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_deay_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_deaa_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_deaa2_d))
 
 
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
   #CALL adet408_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adet408_ui_headershow()
   CALL adet408_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION adet408_draw_out()
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
   CALL adet408_ui_headershow()  
   CALL adet408_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="adet408.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adet408_set_pk_array()
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
   LET g_pk_array[1].values = g_deay_m.deaydocno
   LET g_pk_array[1].column = 'deaydocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet408.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adet408.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adet408_msgcentre_notify(lc_state)
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
   CALL adet408_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_deay_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet408.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adet408_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#8 -s by 08172
   SELECT deaystus  INTO g_deay_m.deaystus
     FROM deay_t
    WHERE deayent = g_enterprise
      AND deaydocno = g_deay_m.deaydocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_deay_m.deaystus
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
        LET g_errparam.extend = g_deay_m.deaydocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adet408_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#8 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet408.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 執行匯入資料
# Memo...........:
# Usage..........: CALL adet408_open_s01()
# Date & Author..: 2014/07/10 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_open_s01()
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_path      STRING
   
   LET l_cnt = 0   
   
   #1.檢查單頭資料是否有輸入
   #1.1.單據編號
   IF cl_null(g_deay_m.deaydocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00184'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF
   #1.2.帳款類型  #目前為固定的預設值,暫可略過檢查
   #1.3.帳款編號
   IF cl_null(g_deay_m.deay002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00048'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF
   #1.4.對帳日期
   IF cl_null(g_deay_m.deay003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00049'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF
   
   CALL s_transaction_begin()
   
   #2.匯入銀行卡或第三方卡資料   #匯入excel功能待研發統一後補上2.2~2.4功能
   #2.1.檢查是否已有資料存在
   SELECT COUNT(*) INTO l_cnt
     FROM deaz_t
    WHERE deazent = g_enterprise
      AND deazdocno = g_deay_m.deaydocno
   IF l_cnt > 0 THEN
      IF cl_ask_confirm('ade-00050') THEN
         #刪除銀行卡/第三方卡資料
         DELETE FROM deaz_t WHERE deazent = g_enterprise AND deazdocno = g_deay_m.deaydocno
         IF SQLCA.sqlcode THEN
            CALL s_transaction_end('N',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Delete deaz_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            RETURN 
         END IF       
         #刪除比對差異明細
         DELETE FROM deaa_t WHERE deaaent = g_enterprise AND deaadocno = g_deay_m.deaydocno
         IF SQLCA.sqlcode THEN
            CALL s_transaction_end('N',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Delete deaa_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            RETURN 
         END IF          
      ELSE   
         CALL s_transaction_end('N',1)
         RETURN          
      END IF   
   END IF   
   
   #2.2.開啟子畫面,輸入上傳檔案
   #畫面開啟 (identifier)
   OPEN WINDOW w_adet408_s01 WITH FORM cl_ap_formpath("ade","adet408_s01")
  
   #畫面初始化
   CALL cl_ui_init()   
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME l_path ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            LET l_path = NULL
      END INPUT
      
      #公用action
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
     
      ON ACTION scan
         CONTINUE DIALOG   
      
      ON ACTION import
         #2.3.檢查匯入資料是否正確
         IF NOT adet408_import_data() THEN
            CALL s_transaction_end('N',1)
            RETURN
         END IF
         #2.4.寫入對帳資料檔deaz_t      
        
         EXIT DIALOG
         
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG      
   END DIALOG
   
   CLOSE WINDOW w_adet408_s01
   
   #按下確認後
   IF NOT INT_FLAG THEN        
      #3.依單頭條件(營運組織/款別類型/款別編號/對帳日期)取系統收款明細rtjf_t
      CALL adet408_get_rtjf() 
      
      #4.差異比對
      IF NOT adet408_mapping() THEN
         CALL s_transaction_end('N',1)
         RETURN
      END IF
   END IF
   
   CALL s_transaction_end('Y',1)
END FUNCTION

################################################################################
# Descriptions...: 匯入對帳資料
# Memo...........:
# Usage..........: CALL adet408_import_data()
#                  RETURNING r_success
# Return Code....: r_success   處理狀態
# Date & Author..: 2014/07/03 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_import_data()
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   #1.檢查匯入資料是否正確
   #2.寫入對帳資料檔deaz_t

   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 建立暫存檔
# Memo...........:
# Usage..........: CALL adet408_create_tmp()
# Date & Author..: 2014/07/03 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_create_tmp()
   #rtjfsite -營運據點 
   #rtjfdocno-單據編號
   #rtjfseq  -收款項次
   #rtjfseq1 -收款序
   #rtjf001  -款別類型
   #rtjf002  -款別編號  
   #rtjf004  -款別類型對應憑證號
   #rtjf005  -刷卡機號
   #rtjf025  -收款日期 
   #rtjf026  -收款時間 
   #rtjf027  -專櫃編號 
   #rtjf028  -班別 
   #rtjf029  -收銀機編號
   #rtjf030  -收銀員編號 
   #rtjf031  -本幣收款金額
   #m_flag   -是否已比對過
   #docno    -比對單號
   CREATE TEMP TABLE adet408_tmp01(                          #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
          rtjfsite            VARCHAR(10),
          rtjfdocno           VARCHAR(20),
          rtjfseq             INTEGER,
          rtjfseq1            INTEGER,
          rtjf001             VARCHAR(10),
          rtjf002             VARCHAR(10),
          rtjf004             VARCHAR(40),
          rtjf005             VARCHAR(40),
          rtjf025             DATE,
          rtjf026             VARCHAR(8),
          rtjf027             VARCHAR(20),
          rtjf028             VARCHAR(10),
          rtjf029             VARCHAR(10),
          rtjf030             VARCHAR(20),          
          rtjf031             DECIMAL(20,6),
          m_flag              VARCHAR(1),
          docno               VARCHAR(20))         
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL adet408_drop_tmp()
# Date & Author..: 2014/07/03 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_drop_tmp()
   DROP TABLE adet408_tmp01            #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
END FUNCTION

################################################################################
# Descriptions...: 取得系統收款明細
# Memo...........:
# Usage..........: CALL adet408_get_rtjf()
# Date & Author..: 2014/07/04 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_get_rtjf()
   DEFINE l_sql   STRING
   DEFINE l_docno      LIKE deay_t.deaydocno
   
   LET l_docno = NULL
   
   #檢查暫存檔中有無資料,沒有時才新增
   SELECT DISTINCT docno INTO l_docno        
     FROM adet408_tmp01                 #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
    WHERE docno = g_deay_m.deaydocno 
   
   IF NOT cl_null(l_docno) THEN
     RETURN          
   END IF
      
   INSERT INTO adet408_tmp01          #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
   SELECT rtjfsite,rtjfdocno,rtjfseq,rtjfseq1,rtjf001,
          rtjf002,rtjf004,rtjf005,rtjf025,rtjf026,       
          rtjf027,rtjf028,rtjf029,rtjf030,rtjf031,
          'N',g_deay_m.deaydocno             
     FROM rtjf_t
    WHERE rtjfsite = g_deay_m.deaysite   #營運組織   
      AND rtjf001 =  g_deay_m.deay001    #款別類型   
      AND rtjf002 =  g_deay_m.deay002    #款別編號   
      AND rtjf025 =  g_deay_m.deay003    #對帳日期 
      AND rtjfent =  g_enterprise  #160905-00003#5 Add By Ken 160905       
                
END FUNCTION

################################################################################
# Descriptions...: 差異比對
# Usage..........: CALL adet408_mapping()
#                  RETURNING r_success
# Return.........: r_success   處理結果
# Date & Author..: 2014/07/08 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_mapping()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_sour1_sql   STRING
   DEFINE l_sour2_sql   STRING
   DEFINE l_seq_sql     STRING
   DEFINE l_deaaseq     LIKE deaa_t.deaaseq
   DEFINE l_deaa004     LIKE deaa_t.deaa004
   DEFINE l_deaa005     LIKE deaa_t.deaa005
   DEFINE l_deaa006     LIKE deaa_t.deaa006
   DEFINE l_deaz        RECORD
            deazent     LIKE deaz_t.deazent,
            deazsite    LIKE deaz_t.deazsite,
            deazdocno   LIKE deaz_t.deazdocno,
            deazseq     LIKE deaz_t.deazseq,
            deaz001     LIKE deaz_t.deaz001,
            deaz002     LIKE deaz_t.deaz002,
            deaz003     LIKE deaz_t.deaz003,
            deaz004     LIKE deaz_t.deaz004,
            deaz005     LIKE deaz_t.deaz005,
            deaz006     LIKE deaz_t.deaz006
                        END RECORD   
   DEFINE l_rtjf        RECORD
            rtjfdocno          LIKE rtjf_t.rtjfdocno,
            rtjfseq            LIKE rtjf_t.rtjfseq,
            rtjfseq1           LIKE rtjf_t.rtjfseq1,
            rtjf001            LIKE rtjf_t.rtjf001,
            rtjf002            LIKE rtjf_t.rtjf002,
            rtjf004            LIKE rtjf_t.rtjf004,
            rtjf005            LIKE rtjf_t.rtjf005,
            rtjf025            LIKE rtjf_t.rtjf025,
            rtjf026            LIKE rtjf_t.rtjf026,
            rtjf027            LIKE rtjf_t.rtjf027,
            rtjf028            LIKE rtjf_t.rtjf028,
            rtjf029            LIKE rtjf_t.rtjf029,
            rtjf030            LIKE rtjf_t.rtjf030,       
            rtjf031            LIKE rtjf_t.rtjf031
                        END RECORD    
   LET r_success = TRUE
   LET l_deaa004 = 0
   LET l_deaa005 = 'N'
   LET l_deaa006 = NULL
   
   #比對條件：卡號/交易日期/金額     #要注意未來的比對條件可能還包含：款別類型/款別編號/幣別
   #匯入資料或系統資料可能在比對條件下可能同時有多筆資料, 此時要用時間序為比對條件
   
   #1.以銀行卡/第三方卡資料為主,比對系統資料;金額沒有重複者
   LET l_sour1_sql = "SELECT deazent,deazsite,deazdocno,deazseq,deaz001, ",
                     "       deaz002,deaz003,deaz004,deaz005,deaz006 ",
                     "  FROM deaz_t z1 ",
                     " WHERE z1.deazdocno = '",g_deay_m.deaydocno,"' ",
                     "   AND z1.deazent = ",g_enterprise ,  #160905-00003#5 Add By Ken 160905
                     "   AND EXISTS(SELECT z2.deaz001,z2.deaz002,z2.deaz004,COUNT(z2.deaz004) ",
                     "                FROM deaz_t z2 ",
                     "               WHERE z2.deazdocno = z1.deazdocno ",
                     "                 AND z2.deazent = z1.deazent ",  #160905-00003#5 Add By Ken 160905
                     "                 AND z2.deaz001 = z1.deaz001 ",
                     "                 AND z2.deaz002 = z1.deaz002 ",
                     "                 AND z2.deaz004 = z1.deaz004 ", 
                     "               GROUP BY z2.deaz001,z2.deaz002,z2.deaz004 ",
                     "              HAVING COUNT(z2.deaz004) = 1) "
                 
   LET l_sour2_sql = "SELECT rtjfdocno,rtjfseq,rtjfseq1,rtjf004,rtjf005, ",
                     "       rtjf025,rtjf026,rtjf027,rtjf028,rtjf029, ",
                     "       rtjf030,rtjf031 ",
                     "  FROM adet408_tmp01 r1 ",                    #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
                     " WHERE r1.docno = '",g_deay_m.deaydocno,"' ",
                     "   AND EXISTS(SELECT r2.rtjf004,r2.rtjf025,r2.rtjf031,COUNT(r2.rtjf031) ",
                     "                FROM adet408_tmp01 r2 ",        #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
                     "               WHERE r2.docno   = r1.docno ",
                     "                 AND r2.rtjf004 = r1.rtjf004 ",
                     "                 AND r2.rtjf025 = r1.rtjf025 ",
                     "                 AND r2.rtjf031 = r1.rtjf031 ",
                     "              GROUP BY r2.rtjf004,r2.rtjf025,r2.rtjf031 ",
                     "             HAVING COUNT(r2.rtjf031) = 1 ) "          
   
   #FOREACH時使用    
   LET l_seq_sql = "SELECT COALESCE(MAX(deaaseq),0)+1 ",
                   "  FROM deaa_t ",
                   " WHERE deaaent = ",g_enterprise,
                   "   AND deaadocno = '",g_deay_m.deaydocno,"' "                   
   PREPARE adet408_get_seq FROM l_seq_sql    
   #整批寫入時使用
   LET l_seq_sql = "ROW_NUMBER() OVER (PARTITION BY '",g_deay_m.deaydocno,"' ORDER BY ?) + ",  #組SQL時,?取替代排序欄位名稱
                   "(SELECT COUNT(deaaseq) ",
                   "  FROM deaa_t ",
                   " WHERE deaaent = ",g_enterprise,
                   "   AND deaadocno = '",g_deay_m.deaydocno,"') "   
   
   LET l_sql = "INSERT INTO deaa_t(deaaent,deaasite,deaadocno,deaaseq,deaaseq1, ",
               "                   deaa003,deaa004 ,deaa005  ,deaa006,deaa007, ",
               "                   deaa008,deaa009 ,deaa010  ,deaa011,deaa012, ",
               "                   deaa013,deaa014 ,deaa015  ,deaa016) ",
               "     SELECT deazent,deazsite,deazdocno,(",cl_replace_str(l_seq_sql,"?","rtjf026"),"),deazseq, ",  
               "            deaz001,",l_deaa004,",'",l_deaa005,"','",l_deaa006,"',rtjf027, ",
               "            rtjf028,rtjf030,rtjf029,rtjf026,rtjf031, ",
               "            deaz005,deaz003,deaz004,deaz006 ",
               "       FROM (",l_sour1_sql,") import_data,(",l_sour2_sql,") sys_data ",
               "      WHERE import_data.deaz001 = sys_data.rtjf004 ",
               "        AND import_data.deaz002 = sys_data.rtjf025 ",
               "        AND import_data.deaz004 = sys_data.rtjf031 " 
   PREPARE adet408_ins_deaa_pre1 FROM l_sql
   EXECUTE adet408_ins_deaa_pre1 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adet408_ins_deaa_pre1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success      
   END IF   

   LET l_sql = "UPDATE adet408_tmp01 ",        #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
               "   SET m_flag = 'Y' ",
               " WHERE docno = '",g_deay_m.deaydocno,"' ",
               "   AND (rtjfdocno,rtjfseq,rtjfseq1) IN (SELECT rtjfdocno,rtjfseq,rtjfseq1 ",
               "                                          FROM (",l_sour1_sql,") import_data,(",l_sour2_sql,") sys_data ",
               "                                         WHERE import_data.deaz001 = sys_data.rtjf004 ",
               "                                           AND import_data.deaz002 = sys_data.rtjf025 ",
               "                                           AND import_data.deaz004 = sys_data.rtjf031) " 
   PREPARE adet408_upd_tmp_pre1 FROM l_sql
   EXECUTE adet408_upd_tmp_pre1
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adet408_upd_tmp_pre1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success      
   END IF
   
   #2.以銀行卡/第三方卡資料為主,比對系統資料;同金額有兩筆以上者
   LET l_sour1_sql = cl_replace_str(l_sour1_sql, "EXISTS", "NOT EXISTS")
   LET l_sql = l_sour1_sql,
               " ORDER BY deaz001,deaz002,deaz004,deaz003 "
   PREPARE adet408_sel_deaa_pre1 FROM l_sql
   DECLARE adet408_sel_deaa_cur1 CURSOR FOR adet408_sel_deaa_pre1
   
   LET l_sql = "SELECT rtjfdocno,rtjfseq,rtjfseq1,rtjf004,rtjf005, ",
               "       rtjf025,rtjf026,rtjf027,rtjf028,rtjf029, ",
               "       rtjf030,rtjf031 ",
               "  FROM adet408_tmp01 ",             #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
               " WHERE docno = '",g_deay_m.deaydocno,"' ",
               "   AND rtjf004 = ? ",
               "   AND rtjf025 = ? ",
               "   AND rtjf031 = ? ",
               "   AND m_flag = 'N' ",
               " ORDER BY rtjf004,rtjf025,rtjf031,rtjf026 "
   PREPARE adet408_sel_tmp_pre1 FROM l_sql
   DECLARE adet408_sel_tmp_pre2 SCROLL CURSOR FOR adet408_sel_tmp_pre1
   
   FOREACH adet408_sel_deaa_cur1 INTO l_deaz.deazent,l_deaz.deazsite,l_deaz.deazdocno,l_deaz.deazseq,l_deaz.deaz001,
                                      l_deaz.deaz002,l_deaz.deaz003 ,l_deaz.deaz004  ,l_deaz.deaz005,l_deaz.deaz006
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adet408_sel_deaa_cur1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN r_success      
      END IF 
      
      LET l_deaaseq = NULL
      INITIALIZE l_rtjf.* TO NULL
      
      OPEN adet408_sel_tmp_pre2 USING l_deaz.deaz001,l_deaz.deaz002,l_deaz.deaz004
      FETCH FIRST adet408_sel_tmp_pre2 INTO l_rtjf.rtjfdocno,l_rtjf.rtjfseq,l_rtjf.rtjfseq1,l_rtjf.rtjf004,l_rtjf.rtjf005,
                                            l_rtjf.rtjf025  ,l_rtjf.rtjf026,l_rtjf.rtjf027 ,l_rtjf.rtjf028,l_rtjf.rtjf029,
                                            l_rtjf.rtjf030  ,l_rtjf.rtjf031
      EXECUTE adet408_get_seq INTO l_deaaseq
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adet408_get_seq"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN r_success      
      END IF 
   
      LET l_deaa004 = l_deaz.deaz004 - l_rtjf.rtjf031
      
      INSERT INTO deaa_t(deaaent,deaasite,deaadocno,deaaseq,deaaseq1, 
                         deaa003,deaa004 ,deaa005  ,deaa006,deaa007,
                         deaa008,deaa009 ,deaa010  ,deaa011,deaa012,
                         deaa013,deaa014 ,deaa015  ,deaa016)
           VALUES(l_deaz.deazent,l_deaz.deazsite,l_deaz.deazdocno,l_deaaseq     ,l_deaz.deazseq,  
                  l_deaz.deaz001,l_deaa004      ,l_deaa005       ,l_deaa006     ,l_rtjf.rtjf027,
                  l_rtjf.rtjf028,l_rtjf.rtjf030 ,l_rtjf.rtjf029  ,l_rtjf.rtjf026,l_rtjf.rtjf031,
                  l_deaz.deaz005,l_deaz.deaz003,l_deaz.deaz004   ,l_deaz.deaz006)
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert deaa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
         RETURN r_success      
      END IF 
      
      UPDATE adet408_tmp01             #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
         SET m_flag = 'Y' 
       WHERE docno = g_deay_m.deaydocno
         AND rtjfdocno = l_rtjf.rtjfdocno
         AND rtjfseq = l_rtjf.rtjfseq
         AND rtjfseq1 = l_rtjf.rtjfseq1 
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Update adet408_tmp01(1)"    #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH         
         RETURN r_success      
      END IF          
   END FOREACH
   
   #3.有銀行卡/第三方卡資料,無對系統資料者
   LET l_sql = "INSERT INTO deaa_t(deaaent,deaasite,deaadocno,deaaseq,deaaseq1, ",
               "                   deaa003,deaa004 ,deaa005  ,deaa006,deaa007, ",
               "                   deaa008,deaa009 ,deaa010  ,deaa011,deaa012, ",
               "                   deaa013,deaa014 ,deaa015  ,deaa016) ",
               "     SELECT deazent,deazsite,deazdocno,(",cl_replace_str(l_seq_sql,"?","deaz003"),"),deazseq, ",
               "            deaz001,deaz004,'",l_deaa005,"','",l_deaa006,"',0, ",
               "            '','','','','', ",
               "            deaz005,deaz003,deaz004,deaz006 ",
               "       FROM deaz_t ",
               "      WHERE deazdocno = '",g_deay_m.deaydocno,"' ",
               "        AND deazent = ",g_enterprise ,  #160905-00003#5 Add By Ken 160905
               "        AND NOT EXISTS(SELECT deaaseq1 FROM deaa_t  ",
               "                        WHERE deaadocno = deazdocno ",
               "                          AND deaaent = deazent ", #160905-00003#5 Add By Ken 160905
               "                          AND deaaseq1 = deazseq) "               
   PREPARE adet408_ins_deaa_pre2 FROM l_sql
   EXECUTE adet408_ins_deaa_pre2 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adet408_ins_deaa_pre2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success      
   END IF
      
   #4.無銀行卡/第三方卡資料,有對系統資料者
   LET l_sql = "INSERT INTO deaa_t(deaaent,deaasite,deaadocno,deaaseq,deaaseq1, ",
               "                   deaa003,deaa004 ,deaa005  ,deaa006,deaa007, ",
               "                   deaa008,deaa009 ,deaa010  ,deaa011,deaa012, ",
               "                   deaa013,deaa014 ,deaa015  ,deaa016) ",
               "     SELECT ",g_enterprise,",'",g_deay_m.deaysite,"','",g_deay_m.deaydocno,"',(",cl_replace_str(l_seq_sql,"?","rtjf026"),"),'', ",
               "            rtjf004,0-rtjf031,'",l_deaa005,"','",l_deaa006,"',rtjf027, ",
               "            rtjf028,rtjf030,rtjf029,rtjf026,rtjf031, ",
               "            '','',0,'' ",
               "       FROM adet408_tmp01 ",        #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
               "      WHERE docno = '",g_deay_m.deaydocno,"' ",
               "        AND m_flag = 'N' " 
   PREPARE adet408_ins_deaa_pre3 FROM l_sql
   EXECUTE adet408_ins_deaa_pre3
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adet408_ins_deaa_pre3"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success      
   END IF
   
   UPDATE adet408_tmp01           #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
      SET m_flag = 'Y'
    WHERE m_flag = 'N'  
      AND docno = g_deay_m.deaydocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Update adet408_tmp01(2)"   #160727-00019#10 Mod   adet408_rtjf_tmp -->adet408_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success      
   END IF

   RETURN r_success      
END FUNCTION

################################################################################
# Descriptions...: 取收銀機名稱
# Memo...........:
# Usage..........: CALL adet408_rtjf029_ref()
#                  RETURNING r_pcaal003
# Return.........: r_pcaal003
# Date & Author..: 2014/07/08 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adet408_rtjf029_ref()
   DEFINE r_pcaal003   LIKE pcaal_t.pcaal003
   
   LET r_pcaal003 = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtjf_d[l_ac].rtjf029
   CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaalsite='"||g_deay_m.deaysite||"' AND pcaal001=?  AND pcaal002='"||g_dlang||"' ","") RETURNING g_rtn_fields
   LET r_pcaal003 = '', g_rtn_fields[1] , ''
   
   RETURN r_pcaal003
END FUNCTION

 
{</section>}
 
