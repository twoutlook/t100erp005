#該程式未解開Section, 採用最新樣板產出!
{<section id="artt409.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-07-02 20:56:55), PR版次:0015(2016-10-27 17:49:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: artt409
#+ Description: 商戶商品引進單
#+ Creator....: 06137(2016-04-20 15:15:32)
#+ Modifier...: 06814 -SD/PR- 08742
 
{</section>}
 
{<section id="artt409.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160604-00009#50  2016/07/22  by 08172    库区预设值
#160816-00068#09  2016/08/17  By 08209    調整transaction
#160818-00017#35  2016-08-24  By 08734    删除修改未重新判断状态码
#160913-00034#5   2016/09/18  by 08742    q_pmaa001開窗改成 q_pmaa001_1 抓类型= 3，同时修改栏位控管
#161024-00025#9   2016/10/27  by 08742    组织开窗调整
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
PRIVATE type type_g_rtek_m        RECORD
       rteksite LIKE rtek_t.rteksite, 
   rteksite_desc LIKE type_t.chr80, 
   rtekdocdt LIKE rtek_t.rtekdocdt, 
   rtekdocno LIKE rtek_t.rtekdocno, 
   rtek001 LIKE rtek_t.rtek001, 
   rtek002 LIKE rtek_t.rtek002, 
   rtek002_desc LIKE type_t.chr80, 
   rtek003 LIKE rtek_t.rtek003, 
   rtek003_desc LIKE type_t.chr80, 
   rtek008 LIKE rtek_t.rtek008, 
   rtek004 LIKE rtek_t.rtek004, 
   rtek005 LIKE rtek_t.rtek005, 
   rtek005_desc LIKE type_t.chr80, 
   rtek006 LIKE rtek_t.rtek006, 
   rtek006_desc LIKE type_t.chr80, 
   rtek007 LIKE rtek_t.rtek007, 
   rtekstus LIKE rtek_t.rtekstus, 
   rtekownid LIKE rtek_t.rtekownid, 
   rtekownid_desc LIKE type_t.chr80, 
   rtekowndp LIKE rtek_t.rtekowndp, 
   rtekowndp_desc LIKE type_t.chr80, 
   rtekcrtid LIKE rtek_t.rtekcrtid, 
   rtekcrtid_desc LIKE type_t.chr80, 
   rtekcrtdp LIKE rtek_t.rtekcrtdp, 
   rtekcrtdp_desc LIKE type_t.chr80, 
   rtekcrtdt LIKE rtek_t.rtekcrtdt, 
   rtekmodid LIKE rtek_t.rtekmodid, 
   rtekmodid_desc LIKE type_t.chr80, 
   rtekmoddt LIKE rtek_t.rtekmoddt, 
   rtekcnfid LIKE rtek_t.rtekcnfid, 
   rtekcnfid_desc LIKE type_t.chr80, 
   rtekcnfdt LIKE rtek_t.rtekcnfdt, 
   rtekpstid_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtel_d        RECORD
       rtelacti LIKE rtel_t.rtelacti, 
   rtelseq LIKE rtel_t.rtelseq, 
   rtel001 LIKE rtel_t.rtel001, 
   rtel023 LIKE rtel_t.rtel023, 
   rtel002 LIKE rtel_t.rtel002, 
   rtel003 LIKE rtel_t.rtel003, 
   rtell002 LIKE rtell_t.rtell002, 
   rtell003 LIKE rtell_t.rtell003, 
   rtell004 LIKE rtell_t.rtell004, 
   rtel004 LIKE rtel_t.rtel004, 
   rtel004_desc LIKE type_t.chr500, 
   rtel005 LIKE rtel_t.rtel005, 
   rtel005_desc LIKE type_t.chr500, 
   rtel006 LIKE rtel_t.rtel006, 
   rtel007 LIKE rtel_t.rtel007, 
   rtel007_desc LIKE type_t.chr500, 
   rtel008 LIKE rtel_t.rtel008, 
   rtel008_desc LIKE type_t.chr500, 
   rtel009 LIKE rtel_t.rtel009, 
   rtel009_desc LIKE type_t.chr500, 
   rtel010 LIKE rtel_t.rtel010, 
   rtel010_desc LIKE type_t.chr500, 
   rtel011 LIKE rtel_t.rtel011, 
   rtel011_desc LIKE type_t.chr500, 
   rtel012 LIKE rtel_t.rtel012, 
   rtel018 LIKE rtel_t.rtel018, 
   rtel020 LIKE rtel_t.rtel020, 
   rtel021 LIKE rtel_t.rtel021, 
   rtel022 LIKE rtel_t.rtel022, 
   rtel013 LIKE rtel_t.rtel013, 
   rtel014 LIKE rtel_t.rtel014, 
   rtel015 LIKE rtel_t.rtel015, 
   rtel016 LIKE rtel_t.rtel016, 
   rtel017 LIKE rtel_t.rtel017, 
   rtel019 LIKE rtel_t.rtel019, 
   rtel019_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rteksite LIKE rtek_t.rteksite,
   b_rteksite_desc LIKE type_t.chr80,
      b_rtekdocdt LIKE rtek_t.rtekdocdt,
      b_rtekdocno LIKE rtek_t.rtekdocno,
      b_rtek001 LIKE rtek_t.rtek001,
      b_rtek003 LIKE rtek_t.rtek003,
   b_rtek003_desc LIKE type_t.chr80,
      b_rtek002 LIKE rtek_t.rtek002,
   b_rtek002_desc LIKE type_t.chr80,
      b_rtek005 LIKE rtek_t.rtek005,
   b_rtek005_desc LIKE type_t.chr80,
      b_rtek006 LIKE rtek_t.rtek006,
   b_rtek006_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004           LIKE ooef_t.ooef004
DEFINE g_site_flag         LIKE type_t.num5
DEFINE g_ooef127           LIKE ooef_t.ooef127   #預設庫區   #160513-00037#3 160517 lori add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtek_m          type_g_rtek_m
DEFINE g_rtek_m_t        type_g_rtek_m
DEFINE g_rtek_m_o        type_g_rtek_m
DEFINE g_rtek_m_mask_o   type_g_rtek_m #轉換遮罩前資料
DEFINE g_rtek_m_mask_n   type_g_rtek_m #轉換遮罩後資料
 
   DEFINE g_rtekdocno_t LIKE rtek_t.rtekdocno
 
 
DEFINE g_rtel_d          DYNAMIC ARRAY OF type_g_rtel_d
DEFINE g_rtel_d_t        type_g_rtel_d
DEFINE g_rtel_d_o        type_g_rtel_d
DEFINE g_rtel_d_mask_o   DYNAMIC ARRAY OF type_g_rtel_d #轉換遮罩前資料
DEFINE g_rtel_d_mask_n   DYNAMIC ARRAY OF type_g_rtel_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_detail_multi_table_t    RECORD
      rtelldocno LIKE rtell_t.rtelldocno,
      rtellseq LIKE rtell_t.rtellseq,
      rtell001 LIKE rtell_t.rtell001,
      rtell002 LIKE rtell_t.rtell002,
      rtell003 LIKE rtell_t.rtell003,
      rtell004 LIKE rtell_t.rtell004
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
 
{<section id="artt409.main" >}
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
   LET g_forupd_sql = " SELECT rteksite,'',rtekdocdt,rtekdocno,rtek001,rtek002,'',rtek003,'',rtek008, 
       rtek004,rtek005,'',rtek006,'',rtek007,rtekstus,rtekownid,'',rtekowndp,'',rtekcrtid,'',rtekcrtdp, 
       '',rtekcrtdt,rtekmodid,'',rtekmoddt,rtekcnfid,'',rtekcnfdt,''", 
                      " FROM rtek_t",
                      " WHERE rtekent= ? AND rtekdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt409_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rteksite,t0.rtekdocdt,t0.rtekdocno,t0.rtek001,t0.rtek002,t0.rtek003, 
       t0.rtek008,t0.rtek004,t0.rtek005,t0.rtek006,t0.rtek007,t0.rtekstus,t0.rtekownid,t0.rtekowndp, 
       t0.rtekcrtid,t0.rtekcrtdp,t0.rtekcrtdt,t0.rtekmodid,t0.rtekmoddt,t0.rtekcnfid,t0.rtekcnfdt,t1.ooefl003 , 
       t2.pmaal003 ,t3.mhbel003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM rtek_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rteksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.rtek002 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t3 ON t3.mhbelent="||g_enterprise||" AND t3.mhbel001=t0.rtek003 AND t3.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtek005  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtek006 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.rtekownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.rtekowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.rtekcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.rtekcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.rtekmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rtekcnfid  ",
 
               " WHERE t0.rtekent = " ||g_enterprise|| " AND t0.rtekdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt409_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt409 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt409_init()   
 
      #進入選單 Menu (="N")
      CALL artt409_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt409
      
   END IF 
   
   CLOSE artt409_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success  
   CALL s_aooi390_drop_tmp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt409.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt409_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004    
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
      CALL cl_set_combo_scc_part('rtekstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('rtek001','6780') 
   CALL cl_set_combo_scc('rtel001','2003') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_rtek001','6780')
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   LET g_errshow = 1
   CALL s_desc_gzcbl004_desc('6899','7') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtel015",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','8') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtel016",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','9') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("rtel017",l_gzcbl004)
   CALL cl_set_combo_scc_part('rtel001','2003','1,2') #add by geza 20160607  
   #CALL cl_set_combo_scc_part('rtel023','2004','1') #add by geza 20160607 #mark by geza 20160621
   CALL cl_set_combo_scc_part('rtel023','6553','1,8') #add by geza 20160621    
   #end add-point
   
   #初始化搜尋條件
   CALL artt409_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt409.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt409_ui_dialog()
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
            CALL artt409_insert()
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
         INITIALIZE g_rtek_m.* TO NULL
         CALL g_rtel_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt409_init()
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
               
               CALL artt409_fetch('') # reload data
               LET l_ac = 1
               CALL artt409_ui_detailshow() #Setting the current row 
         
               CALL artt409_idx_chk()
               #NEXT FIELD rtelseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtel_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt409_idx_chk()
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
               CALL artt409_idx_chk()
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
            CALL artt409_browser_fill("")
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
               CALL artt409_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt409_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt409_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt409_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt409_set_act_visible()   
            CALL artt409_set_act_no_visible()
            IF NOT (g_rtek_m.rtekdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtekent = " ||g_enterprise|| " AND",
                                  " rtekdocno = '", g_rtek_m.rtekdocno, "' "
 
               #填到對應位置
               CALL artt409_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "rtek_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtel_t" 
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
               CALL artt409_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rtek_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtel_t" 
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
                  CALL artt409_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt409_fetch("F")
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
               CALL artt409_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt409_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt409_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt409_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt409_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt409_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt409_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt409_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt409_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt409_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt409_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtel_d)
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
               NEXT FIELD rtelseq
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
               CALL artt409_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt409_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION yjsp
            LET g_action_choice="yjsp"
            IF cl_auth_chk_act("yjsp") THEN
               
               #add-point:ON ACTION yjsp name="menu.yjsp"
             if cl_null(g_rtek_m.rtekdocno) or  g_rtek_m.rtek001='U' then 
             
             else
                call artt409_02(g_rtek_m.rtekdocno)
                #call artt409_b_fill()
                call artt409_show()
             end if 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt409_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt409_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/art/artt409_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/art/artt409_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt409_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt409_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt409_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt409_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt409_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtek_m.rtekdocdt)
 
 
 
         
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
 
{<section id="artt409.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt409_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'rteksite') RETURNING l_where
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
      LET l_sub_sql = " SELECT DISTINCT rtekdocno ",
                      " FROM rtek_t ",
                      " ",
                      " LEFT JOIN rtel_t ON rtelent = rtekent AND rtekdocno = rteldocno ", "  ",
                      #add-point:browser_fill段sql(rtel_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " LEFT JOIN rtell_t ON rtellent = "||g_enterprise||" AND rtekdocno = rtelldocno AND rtelseq = rtellseq AND rtell001 = '",g_dlang,"' ", 
 
 
                      " WHERE rtekent = " ||g_enterprise|| " AND rtelent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtek_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtekdocno ",
                      " FROM rtek_t ", 
                      "  ",
                      "  ",
                      " WHERE rtekent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtek_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where
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
      INITIALIZE g_rtek_m.* TO NULL
      CALL g_rtel_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rteksite,t0.rtekdocdt,t0.rtekdocno,t0.rtek001,t0.rtek003,t0.rtek002,t0.rtek005,t0.rtek006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtekstus,t0.rteksite,t0.rtekdocdt,t0.rtekdocno,t0.rtek001,t0.rtek003, 
          t0.rtek002,t0.rtek005,t0.rtek006,t1.ooefl003 ,t2.mhbel003 ,t3.pmaal003 ,t4.ooag011 ,t5.ooefl003 ", 
 
                  " FROM rtek_t t0",
                  "  ",
                  "  LEFT JOIN rtel_t ON rtelent = rtekent AND rtekdocno = rteldocno ", "  ", 
                  #add-point:browser_fill段sql(rtel_t1) name="browser_fill.join.rtel_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN rtell_t ON rtellent = "||g_enterprise||" AND rtekdocno = rtelldocno AND rtelseq = rtellseq AND rtell001 = '",g_dlang,"' ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rteksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent="||g_enterprise||" AND t2.mhbel001=t0.rtek003 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rtek002 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtek005  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtek006 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtekent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtek_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtekstus,t0.rteksite,t0.rtekdocdt,t0.rtekdocno,t0.rtek001,t0.rtek003, 
          t0.rtek002,t0.rtek005,t0.rtek006,t1.ooefl003 ,t2.mhbel003 ,t3.pmaal003 ,t4.ooag011 ,t5.ooefl003 ", 
 
                  " FROM rtek_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rteksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent="||g_enterprise||" AND t2.mhbel001=t0.rtek003 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.rtek002 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.rtek005  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.rtek006 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtekent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtek_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtekdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtek_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rteksite,g_browser[g_cnt].b_rtekdocdt, 
          g_browser[g_cnt].b_rtekdocno,g_browser[g_cnt].b_rtek001,g_browser[g_cnt].b_rtek003,g_browser[g_cnt].b_rtek002, 
          g_browser[g_cnt].b_rtek005,g_browser[g_cnt].b_rtek006,g_browser[g_cnt].b_rteksite_desc,g_browser[g_cnt].b_rtek003_desc, 
          g_browser[g_cnt].b_rtek002_desc,g_browser[g_cnt].b_rtek005_desc,g_browser[g_cnt].b_rtek006_desc 
 
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
         CALL artt409_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_rtekdocno) THEN
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
 
{<section id="artt409.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt409_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtek_m.rtekdocno = g_browser[g_current_idx].b_rtekdocno   
 
   EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
       g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
       g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
       g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
       g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid_desc, 
       g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc
   
   CALL artt409_rtek_t_mask()
   CALL artt409_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt409.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt409_ui_detailshow()
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
 
{<section id="artt409.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt409_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtekdocno = g_rtek_m.rtekdocno 
 
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
 
{<section id="artt409.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt409_construct()
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
   INITIALIZE g_rtek_m.* TO NULL
   CALL g_rtel_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON rteksite,rtekdocdt,rtekdocno,rtek001,rtek002,rtek003,rtek008,rtek004, 
          rtek005,rtek006,rtek007,rtekstus,rtekownid,rtekowndp,rtekcrtid,rtekcrtdp,rtekcrtdt,rtekmodid, 
          rtekmoddt,rtekcnfid,rtekcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtekcrtdt>>----
         AFTER FIELD rtekcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtekmoddt>>----
         AFTER FIELD rtekmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtekcnfdt>>----
         AFTER FIELD rtekcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtekpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rteksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteksite
            #add-point:ON ACTION controlp INFIELD rteksite name="construct.c.rteksite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rteksite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rteksite  #顯示到畫面上
            NEXT FIELD rteksite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteksite
            #add-point:BEFORE FIELD rteksite name="construct.b.rteksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteksite
            
            #add-point:AFTER FIELD rteksite name="construct.a.rteksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekdocdt
            #add-point:BEFORE FIELD rtekdocdt name="construct.b.rtekdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekdocdt
            
            #add-point:AFTER FIELD rtekdocdt name="construct.a.rtekdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtekdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekdocdt
            #add-point:ON ACTION controlp INFIELD rtekdocdt name="construct.c.rtekdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtekdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekdocno
            #add-point:ON ACTION controlp INFIELD rtekdocno name="construct.c.rtekdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtekdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekdocno  #顯示到畫面上
            NEXT FIELD rtekdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekdocno
            #add-point:BEFORE FIELD rtekdocno name="construct.b.rtekdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekdocno
            
            #add-point:AFTER FIELD rtekdocno name="construct.a.rtekdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek001
            #add-point:BEFORE FIELD rtek001 name="construct.b.rtek001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek001
            
            #add-point:AFTER FIELD rtek001 name="construct.a.rtek001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtek001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek001
            #add-point:ON ACTION controlp INFIELD rtek001 name="construct.c.rtek001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtek002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek002
            #add-point:ON ACTION controlp INFIELD rtek002 name="construct.c.rtek002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#5 -S
            #CALL q_pmaa001()                           窗            
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                          #呼叫開窗
            #160913-00034#5 -E
            DISPLAY g_qryparam.return1 TO rtek002  #顯示到畫面上
            NEXT FIELD rtek002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek002
            #add-point:BEFORE FIELD rtek002 name="construct.b.rtek002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek002
            
            #add-point:AFTER FIELD rtek002 name="construct.a.rtek002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtek003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek003
            #add-point:ON ACTION controlp INFIELD rtek003 name="construct.c.rtek003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbe001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtek003  #顯示到畫面上
            NEXT FIELD rtek003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek003
            #add-point:BEFORE FIELD rtek003 name="construct.b.rtek003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek003
            
            #add-point:AFTER FIELD rtek003 name="construct.a.rtek003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtek008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek008
            #add-point:ON ACTION controlp INFIELD rtek008 name="construct.c.rtek008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160513-00037#3 160517 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =  " stje012 >= '",g_today,"' "
            CALL q_stje001_1()      
            
            DISPLAY g_qryparam.return1 TO rtek008 
            NEXT FIELD rtek008                    
            #160513-00037#3 160517 by lori add---(S)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek008
            #add-point:BEFORE FIELD rtek008 name="construct.b.rtek008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek008
            
            #add-point:AFTER FIELD rtek008 name="construct.a.rtek008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek004
            #add-point:BEFORE FIELD rtek004 name="construct.b.rtek004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek004
            
            #add-point:AFTER FIELD rtek004 name="construct.a.rtek004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtek004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek004
            #add-point:ON ACTION controlp INFIELD rtek004 name="construct.c.rtek004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtek005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek005
            #add-point:ON ACTION controlp INFIELD rtek005 name="construct.c.rtek005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtek005  #顯示到畫面上
            NEXT FIELD rtek005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek005
            #add-point:BEFORE FIELD rtek005 name="construct.b.rtek005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek005
            
            #add-point:AFTER FIELD rtek005 name="construct.a.rtek005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtek006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek006
            #add-point:ON ACTION controlp INFIELD rtek006 name="construct.c.rtek006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtek006  #顯示到畫面上
            NEXT FIELD rtek006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek006
            #add-point:BEFORE FIELD rtek006 name="construct.b.rtek006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek006
            
            #add-point:AFTER FIELD rtek006 name="construct.a.rtek006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek007
            #add-point:BEFORE FIELD rtek007 name="construct.b.rtek007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek007
            
            #add-point:AFTER FIELD rtek007 name="construct.a.rtek007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtek007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek007
            #add-point:ON ACTION controlp INFIELD rtek007 name="construct.c.rtek007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekstus
            #add-point:BEFORE FIELD rtekstus name="construct.b.rtekstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekstus
            
            #add-point:AFTER FIELD rtekstus name="construct.a.rtekstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtekstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekstus
            #add-point:ON ACTION controlp INFIELD rtekstus name="construct.c.rtekstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtekownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekownid
            #add-point:ON ACTION controlp INFIELD rtekownid name="construct.c.rtekownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekownid  #顯示到畫面上
            NEXT FIELD rtekownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekownid
            #add-point:BEFORE FIELD rtekownid name="construct.b.rtekownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekownid
            
            #add-point:AFTER FIELD rtekownid name="construct.a.rtekownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtekowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekowndp
            #add-point:ON ACTION controlp INFIELD rtekowndp name="construct.c.rtekowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekowndp  #顯示到畫面上
            NEXT FIELD rtekowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekowndp
            #add-point:BEFORE FIELD rtekowndp name="construct.b.rtekowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekowndp
            
            #add-point:AFTER FIELD rtekowndp name="construct.a.rtekowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtekcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekcrtid
            #add-point:ON ACTION controlp INFIELD rtekcrtid name="construct.c.rtekcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekcrtid  #顯示到畫面上
            NEXT FIELD rtekcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekcrtid
            #add-point:BEFORE FIELD rtekcrtid name="construct.b.rtekcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekcrtid
            
            #add-point:AFTER FIELD rtekcrtid name="construct.a.rtekcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtekcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekcrtdp
            #add-point:ON ACTION controlp INFIELD rtekcrtdp name="construct.c.rtekcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekcrtdp  #顯示到畫面上
            NEXT FIELD rtekcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekcrtdp
            #add-point:BEFORE FIELD rtekcrtdp name="construct.b.rtekcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekcrtdp
            
            #add-point:AFTER FIELD rtekcrtdp name="construct.a.rtekcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekcrtdt
            #add-point:BEFORE FIELD rtekcrtdt name="construct.b.rtekcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtekmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekmodid
            #add-point:ON ACTION controlp INFIELD rtekmodid name="construct.c.rtekmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekmodid  #顯示到畫面上
            NEXT FIELD rtekmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekmodid
            #add-point:BEFORE FIELD rtekmodid name="construct.b.rtekmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekmodid
            
            #add-point:AFTER FIELD rtekmodid name="construct.a.rtekmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekmoddt
            #add-point:BEFORE FIELD rtekmoddt name="construct.b.rtekmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtekcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekcnfid
            #add-point:ON ACTION controlp INFIELD rtekcnfid name="construct.c.rtekcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtekcnfid  #顯示到畫面上
            NEXT FIELD rtekcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekcnfid
            #add-point:BEFORE FIELD rtekcnfid name="construct.b.rtekcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekcnfid
            
            #add-point:AFTER FIELD rtekcnfid name="construct.a.rtekcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekcnfdt
            #add-point:BEFORE FIELD rtekcnfdt name="construct.b.rtekcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtelacti,rtelseq,rtel001,rtel023,rtel002,rtel003,rtell002,rtell003,rtell004, 
          rtel004,rtel005,rtel006,rtel007,rtel008,rtel009,rtel010,rtel011,rtel012,rtel018,rtel020,rtel021, 
          rtel022,rtel013,rtel014,rtel015,rtel016,rtel017,rtel019
           FROM s_detail1[1].rtelacti,s_detail1[1].rtelseq,s_detail1[1].rtel001,s_detail1[1].rtel023, 
               s_detail1[1].rtel002,s_detail1[1].rtel003,s_detail1[1].rtell002,s_detail1[1].rtell003, 
               s_detail1[1].rtell004,s_detail1[1].rtel004,s_detail1[1].rtel005,s_detail1[1].rtel006, 
               s_detail1[1].rtel007,s_detail1[1].rtel008,s_detail1[1].rtel009,s_detail1[1].rtel010,s_detail1[1].rtel011, 
               s_detail1[1].rtel012,s_detail1[1].rtel018,s_detail1[1].rtel020,s_detail1[1].rtel021,s_detail1[1].rtel022, 
               s_detail1[1].rtel013,s_detail1[1].rtel014,s_detail1[1].rtel015,s_detail1[1].rtel016,s_detail1[1].rtel017, 
               s_detail1[1].rtel019
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtelacti
            #add-point:BEFORE FIELD rtelacti name="construct.b.page1.rtelacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtelacti
            
            #add-point:AFTER FIELD rtelacti name="construct.a.page1.rtelacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtelacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtelacti
            #add-point:ON ACTION controlp INFIELD rtelacti name="construct.c.page1.rtelacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtelseq
            #add-point:BEFORE FIELD rtelseq name="construct.b.page1.rtelseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtelseq
            
            #add-point:AFTER FIELD rtelseq name="construct.a.page1.rtelseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtelseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtelseq
            #add-point:ON ACTION controlp INFIELD rtelseq name="construct.c.page1.rtelseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel001
            #add-point:BEFORE FIELD rtel001 name="construct.b.page1.rtel001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel001
            
            #add-point:AFTER FIELD rtel001 name="construct.a.page1.rtel001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel001
            #add-point:ON ACTION controlp INFIELD rtel001 name="construct.c.page1.rtel001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel023
            #add-point:BEFORE FIELD rtel023 name="construct.b.page1.rtel023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel023
            
            #add-point:AFTER FIELD rtel023 name="construct.a.page1.rtel023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel023
            #add-point:ON ACTION controlp INFIELD rtel023 name="construct.c.page1.rtel023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtel002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel002
            #add-point:ON ACTION controlp INFIELD rtel002 name="construct.c.page1.rtel002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel002  #顯示到畫面上
            NEXT FIELD rtel002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel002
            #add-point:BEFORE FIELD rtel002 name="construct.b.page1.rtel002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel002
            
            #add-point:AFTER FIELD rtel002 name="construct.a.page1.rtel002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel003
            #add-point:ON ACTION controlp INFIELD rtel003 name="construct.c.page1.rtel003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel003  #顯示到畫面上
            NEXT FIELD rtel003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel003
            #add-point:BEFORE FIELD rtel003 name="construct.b.page1.rtel003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel003
            
            #add-point:AFTER FIELD rtel003 name="construct.a.page1.rtel003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtell002
            #add-point:BEFORE FIELD rtell002 name="construct.b.page1.rtell002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtell002
            
            #add-point:AFTER FIELD rtell002 name="construct.a.page1.rtell002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtell002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtell002
            #add-point:ON ACTION controlp INFIELD rtell002 name="construct.c.page1.rtell002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtell003
            #add-point:BEFORE FIELD rtell003 name="construct.b.page1.rtell003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtell003
            
            #add-point:AFTER FIELD rtell003 name="construct.a.page1.rtell003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtell003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtell003
            #add-point:ON ACTION controlp INFIELD rtell003 name="construct.c.page1.rtell003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtell004
            #add-point:BEFORE FIELD rtell004 name="construct.b.page1.rtell004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtell004
            
            #add-point:AFTER FIELD rtell004 name="construct.a.page1.rtell004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtell004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtell004
            #add-point:ON ACTION controlp INFIELD rtell004 name="construct.c.page1.rtell004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtel004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel004
            #add-point:ON ACTION controlp INFIELD rtel004 name="construct.c.page1.rtel004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel004  #顯示到畫面上
            NEXT FIELD rtel004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel004
            #add-point:BEFORE FIELD rtel004 name="construct.b.page1.rtel004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel004
            
            #add-point:AFTER FIELD rtel004 name="construct.a.page1.rtel004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel005
            #add-point:ON ACTION controlp INFIELD rtel005 name="construct.c.page1.rtel005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel005  #顯示到畫面上
            NEXT FIELD rtel005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel005
            #add-point:BEFORE FIELD rtel005 name="construct.b.page1.rtel005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel005
            
            #add-point:AFTER FIELD rtel005 name="construct.a.page1.rtel005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel006
            #add-point:BEFORE FIELD rtel006 name="construct.b.page1.rtel006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel006
            
            #add-point:AFTER FIELD rtel006 name="construct.a.page1.rtel006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel006
            #add-point:ON ACTION controlp INFIELD rtel006 name="construct.c.page1.rtel006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtel007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel007
            #add-point:ON ACTION controlp INFIELD rtel007 name="construct.c.page1.rtel007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel007  #顯示到畫面上
            NEXT FIELD rtel007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel007
            #add-point:BEFORE FIELD rtel007 name="construct.b.page1.rtel007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel007
            
            #add-point:AFTER FIELD rtel007 name="construct.a.page1.rtel007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel008
            #add-point:ON ACTION controlp INFIELD rtel008 name="construct.c.page1.rtel008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel008  #顯示到畫面上
            NEXT FIELD rtel008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel008
            #add-point:BEFORE FIELD rtel008 name="construct.b.page1.rtel008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel008
            
            #add-point:AFTER FIELD rtel008 name="construct.a.page1.rtel008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel009
            #add-point:ON ACTION controlp INFIELD rtel009 name="construct.c.page1.rtel009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel009  #顯示到畫面上
            NEXT FIELD rtel009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel009
            #add-point:BEFORE FIELD rtel009 name="construct.b.page1.rtel009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel009
            
            #add-point:AFTER FIELD rtel009 name="construct.a.page1.rtel009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel010
            #add-point:ON ACTION controlp INFIELD rtel010 name="construct.c.page1.rtel010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel010  #顯示到畫面上
            NEXT FIELD rtel010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel010
            #add-point:BEFORE FIELD rtel010 name="construct.b.page1.rtel010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel010
            
            #add-point:AFTER FIELD rtel010 name="construct.a.page1.rtel010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel011
            #add-point:ON ACTION controlp INFIELD rtel011 name="construct.c.page1.rtel011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtel011  #顯示到畫面上
            NEXT FIELD rtel011                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel011
            #add-point:BEFORE FIELD rtel011 name="construct.b.page1.rtel011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel011
            
            #add-point:AFTER FIELD rtel011 name="construct.a.page1.rtel011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel012
            #add-point:BEFORE FIELD rtel012 name="construct.b.page1.rtel012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel012
            
            #add-point:AFTER FIELD rtel012 name="construct.a.page1.rtel012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel012
            #add-point:ON ACTION controlp INFIELD rtel012 name="construct.c.page1.rtel012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel018
            #add-point:BEFORE FIELD rtel018 name="construct.b.page1.rtel018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel018
            
            #add-point:AFTER FIELD rtel018 name="construct.a.page1.rtel018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel018
            #add-point:ON ACTION controlp INFIELD rtel018 name="construct.c.page1.rtel018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel020
            #add-point:BEFORE FIELD rtel020 name="construct.b.page1.rtel020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel020
            
            #add-point:AFTER FIELD rtel020 name="construct.a.page1.rtel020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel020
            #add-point:ON ACTION controlp INFIELD rtel020 name="construct.c.page1.rtel020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel021
            #add-point:BEFORE FIELD rtel021 name="construct.b.page1.rtel021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel021
            
            #add-point:AFTER FIELD rtel021 name="construct.a.page1.rtel021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel021
            #add-point:ON ACTION controlp INFIELD rtel021 name="construct.c.page1.rtel021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel022
            #add-point:BEFORE FIELD rtel022 name="construct.b.page1.rtel022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel022
            
            #add-point:AFTER FIELD rtel022 name="construct.a.page1.rtel022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel022
            #add-point:ON ACTION controlp INFIELD rtel022 name="construct.c.page1.rtel022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel013
            #add-point:BEFORE FIELD rtel013 name="construct.b.page1.rtel013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel013
            
            #add-point:AFTER FIELD rtel013 name="construct.a.page1.rtel013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel013
            #add-point:ON ACTION controlp INFIELD rtel013 name="construct.c.page1.rtel013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel014
            #add-point:BEFORE FIELD rtel014 name="construct.b.page1.rtel014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel014
            
            #add-point:AFTER FIELD rtel014 name="construct.a.page1.rtel014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel014
            #add-point:ON ACTION controlp INFIELD rtel014 name="construct.c.page1.rtel014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel015
            #add-point:BEFORE FIELD rtel015 name="construct.b.page1.rtel015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel015
            
            #add-point:AFTER FIELD rtel015 name="construct.a.page1.rtel015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel015
            #add-point:ON ACTION controlp INFIELD rtel015 name="construct.c.page1.rtel015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel016
            #add-point:BEFORE FIELD rtel016 name="construct.b.page1.rtel016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel016
            
            #add-point:AFTER FIELD rtel016 name="construct.a.page1.rtel016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel016
            #add-point:ON ACTION controlp INFIELD rtel016 name="construct.c.page1.rtel016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel017
            #add-point:BEFORE FIELD rtel017 name="construct.b.page1.rtel017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel017
            
            #add-point:AFTER FIELD rtel017 name="construct.a.page1.rtel017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtel017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel017
            #add-point:ON ACTION controlp INFIELD rtel017 name="construct.c.page1.rtel017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtel019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel019
            #add-point:ON ACTION controlp INFIELD rtel019 name="construct.c.page1.rtel019"
            #160513-00037#3 160517 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_inaa001_6()  
            
            DISPLAY g_qryparam.return1 TO rtel019
            NEXT FIELD rtel019  
            #160513-00037#3 160517 by lori add---(S)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel019
            #add-point:BEFORE FIELD rtel019 name="construct.b.page1.rtel019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel019
            
            #add-point:AFTER FIELD rtel019 name="construct.a.page1.rtel019"
            
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
                  WHEN la_wc[li_idx].tableid = "rtek_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtel_t" 
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
 
{<section id="artt409.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt409_filter()
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
      CONSTRUCT g_wc_filter ON rteksite,rtekdocdt,rtekdocno,rtek001,rtek003,rtek002,rtek005,rtek006
                          FROM s_browse[1].b_rteksite,s_browse[1].b_rtekdocdt,s_browse[1].b_rtekdocno, 
                              s_browse[1].b_rtek001,s_browse[1].b_rtek003,s_browse[1].b_rtek002,s_browse[1].b_rtek005, 
                              s_browse[1].b_rtek006
 
         BEFORE CONSTRUCT
               DISPLAY artt409_filter_parser('rteksite') TO s_browse[1].b_rteksite
            DISPLAY artt409_filter_parser('rtekdocdt') TO s_browse[1].b_rtekdocdt
            DISPLAY artt409_filter_parser('rtekdocno') TO s_browse[1].b_rtekdocno
            DISPLAY artt409_filter_parser('rtek001') TO s_browse[1].b_rtek001
            DISPLAY artt409_filter_parser('rtek003') TO s_browse[1].b_rtek003
            DISPLAY artt409_filter_parser('rtek002') TO s_browse[1].b_rtek002
            DISPLAY artt409_filter_parser('rtek005') TO s_browse[1].b_rtek005
            DISPLAY artt409_filter_parser('rtek006') TO s_browse[1].b_rtek006
      
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
 
      CALL artt409_filter_show('rteksite')
   CALL artt409_filter_show('rtekdocdt')
   CALL artt409_filter_show('rtekdocno')
   CALL artt409_filter_show('rtek001')
   CALL artt409_filter_show('rtek003')
   CALL artt409_filter_show('rtek002')
   CALL artt409_filter_show('rtek005')
   CALL artt409_filter_show('rtek006')
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt409_filter_parser(ps_field)
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
 
{<section id="artt409.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt409_filter_show(ps_field)
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
   LET ls_condition = artt409_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt409_query()
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
   CALL g_rtel_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt409_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt409_browser_fill("")
      CALL artt409_fetch("")
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
      CALL artt409_filter_show('rteksite')
   CALL artt409_filter_show('rtekdocdt')
   CALL artt409_filter_show('rtekdocno')
   CALL artt409_filter_show('rtek001')
   CALL artt409_filter_show('rtek003')
   CALL artt409_filter_show('rtek002')
   CALL artt409_filter_show('rtek005')
   CALL artt409_filter_show('rtek006')
   CALL artt409_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt409_fetch("F") 
      #顯示單身筆數
      CALL artt409_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt409_fetch(p_flag)
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
   
   LET g_rtek_m.rtekdocno = g_browser[g_current_idx].b_rtekdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
       g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
       g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
       g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
       g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid_desc, 
       g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc
   
   #遮罩相關處理
   LET g_rtek_m_mask_o.* =  g_rtek_m.*
   CALL artt409_rtek_t_mask()
   LET g_rtek_m_mask_n.* =  g_rtek_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt409_set_act_visible()   
   CALL artt409_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtek_m_t.* = g_rtek_m.*
   LET g_rtek_m_o.* = g_rtek_m.*
   
   LET g_data_owner = g_rtek_m.rtekownid      
   LET g_data_dept  = g_rtek_m.rtekowndp
   
   #重新顯示   
   CALL artt409_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt409_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_insert      LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtel_d.clear()   
 
 
   INITIALIZE g_rtek_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtekdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtek_m.rtekownid = g_user
      LET g_rtek_m.rtekowndp = g_dept
      LET g_rtek_m.rtekcrtid = g_user
      LET g_rtek_m.rtekcrtdp = g_dept 
      LET g_rtek_m.rtekcrtdt = cl_get_current()
      LET g_rtek_m.rtekmodid = g_user
      LET g_rtek_m.rtekmoddt = cl_get_current()
      LET g_rtek_m.rtekstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rtek_m.rtek001 = "I"
      LET g_rtek_m.rtek004 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      #單據日期  
      LET g_rtek_m.rtekdocdt = g_today   
      
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'rteksite',g_rtek_m.rteksite)
         RETURNING l_insert,g_rtek_m.rteksite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_rtek_m.rteksite) RETURNING g_rtek_m.rteksite_desc
      DISPLAY BY NAME g_rtek_m.rteksite_desc       
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtek_m.rteksite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_rtek_m.rtekdocno = r_doctype
      
      #業務員
      LET g_rtek_m.rtek005 = g_user          
      CALL s_desc_get_person_desc(g_rtek_m.rtek005) RETURNING g_rtek_m.rtek005_desc
      DISPLAY BY NAME g_rtek_m.rtek005_desc    

      #業務部門
      LET g_rtek_m.rtek006 = g_dept
      CALL s_desc_get_department_desc(g_rtek_m.rtek006) RETURNING g_rtek_m.rtek006_desc
      DISPLAY BY NAME g_rtek_m.rtek006_desc 

      IF g_rtek_m.rtek001 = 'I' THEN
         LET g_rtek_m.rtek004 = 'Y'
      ELSE
         LET g_rtek_m.rtek004 = 'N'
      END IF
      DISPLAY BY NAME g_rtek_m.rtek004 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtek_m_t.* = g_rtek_m.*
      LET g_rtek_m_o.* = g_rtek_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtek_m.rtekstus 
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
 
 
 
    
      CALL artt409_input("a")
      
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
         INITIALIZE g_rtek_m.* TO NULL
         INITIALIZE g_rtel_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt409_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtel_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt409_set_act_visible()   
   CALL artt409_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtekent = " ||g_enterprise|| " AND",
                      " rtekdocno = '", g_rtek_m.rtekdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt409_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt409_cl
   
   CALL artt409_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
       g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
       g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
       g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
       g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid_desc, 
       g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc
   
   
   #遮罩相關處理
   LET g_rtek_m_mask_o.* =  g_rtek_m.*
   CALL artt409_rtek_t_mask()
   LET g_rtek_m_mask_n.* =  g_rtek_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001, 
       g_rtek_m.rtek002,g_rtek_m.rtek002_desc,g_rtek_m.rtek003,g_rtek_m.rtek003_desc,g_rtek_m.rtek008, 
       g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek005_desc,g_rtek_m.rtek006,g_rtek_m.rtek006_desc, 
       g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtid_desc,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdp_desc, 
       g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekmoddt,g_rtek_m.rtekcnfid, 
       g_rtek_m.rtekcnfid_desc,g_rtek_m.rtekcnfdt,g_rtek_m.rtekpstid_desc
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtek_m.rtekownid      
   LET g_data_dept  = g_rtek_m.rtekowndp
   
   #功能已完成,通報訊息中心
   CALL artt409_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt409_modify()
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
   LET g_rtek_m_t.* = g_rtek_m.*
   LET g_rtek_m_o.* = g_rtek_m.*
   
   IF g_rtek_m.rtekdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
   CALL s_transaction_begin()
   
   OPEN artt409_cl USING g_enterprise,g_rtek_m.rtekdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt409_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt409_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
       g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
       g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
       g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
       g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid_desc, 
       g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc
   
   #檢查是否允許此動作
   IF NOT artt409_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtek_m_mask_o.* =  g_rtek_m.*
   CALL artt409_rtek_t_mask()
   LET g_rtek_m_mask_n.* =  g_rtek_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL artt409_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtek_m.rtekmodid = g_user 
LET g_rtek_m.rtekmoddt = cl_get_current()
LET g_rtek_m.rtekmodid_desc = cl_get_username(g_rtek_m.rtekmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt409_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtek_t SET (rtekmodid,rtekmoddt) = (g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt)
          WHERE rtekent = g_enterprise AND rtekdocno = g_rtekdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtek_m.* = g_rtek_m_t.*
            CALL artt409_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtek_m.rtekdocno != g_rtek_m_t.rtekdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rtel_t SET rteldocno = g_rtek_m.rtekdocno
 
          WHERE rtelent = g_enterprise AND rteldocno = g_rtek_m_t.rtekdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtel_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtel_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'rtellent'
LET l_new_key[02] = g_rtek_m.rtekdocno
LET l_old_key[02] = g_rtekdocno_t
LET l_field_key[02] = 'rtelldocno'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'rtell_t')
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt409_set_act_visible()   
   CALL artt409_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtekent = " ||g_enterprise|| " AND",
                      " rtekdocno = '", g_rtek_m.rtekdocno, "' "
 
   #填到對應位置
   CALL artt409_browser_fill("")
 
   CLOSE artt409_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt409_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt409.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt409_input(p_cmd)
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
   DEFINE  l_success       LIKE type_t.num5 
   DEFINE  l_errno         LIKE type_t.chr10
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
         oofg019           LIKE oofg_t.oofg019,  #field
         oofg020           LIKE oofg_t.oofg020   #value
                            END RECORD
   DEFINE l_count_chk      LIKE type_t.num5       
   DEFINE l_mhbe012        LIKE mhbe_t.mhbe012  
   DEFINE l_where          STRING                #160513-00037#3 160517 by lori add
   DEFINE l_str            STRING                #add by geza 20160610
   DEFINE l_sys            LIKE type_t.chr1 #add by geza 20160613   
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
   DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001, 
       g_rtek_m.rtek002,g_rtek_m.rtek002_desc,g_rtek_m.rtek003,g_rtek_m.rtek003_desc,g_rtek_m.rtek008, 
       g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek005_desc,g_rtek_m.rtek006,g_rtek_m.rtek006_desc, 
       g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtid_desc,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdp_desc, 
       g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekmoddt,g_rtek_m.rtekcnfid, 
       g_rtek_m.rtekcnfid_desc,g_rtek_m.rtekcnfdt,g_rtek_m.rtekpstid_desc
   
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
   LET g_forupd_sql = "SELECT rtelacti,rtelseq,rtel001,rtel023,rtel002,rtel003,rtel004,rtel005,rtel006, 
       rtel007,rtel008,rtel009,rtel010,rtel011,rtel012,rtel018,rtel020,rtel021,rtel022,rtel013,rtel014, 
       rtel015,rtel016,rtel017,rtel019 FROM rtel_t WHERE rtelent=? AND rteldocno=? AND rtelseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt409_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt409_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL artt409_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002, 
       g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007, 
       g_rtek_m.rtekstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   SELECT ooef004 
     INTO g_ooef004 
     FROM ooef_t 
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_site 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt409.input.head" >}
      #單頭段
      INPUT BY NAME g_rtek_m.rteksite,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002, 
          g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007, 
          g_rtek_m.rtekstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt409_cl USING g_enterprise,g_rtek_m.rtekdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt409_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt409_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt409_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL artt409_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rteksite
            
            #add-point:AFTER FIELD rteksite name="input.a.rteksite"
            IF NOT cl_null(g_rtek_m.rteksite) THEN
               CALL s_aooi500_chk(g_prog,'rteksite',g_rtek_m.rteksite,g_rtek_m.rteksite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
                  LET g_rtek_m.rteksite = g_rtek_m_t.rteksite
                  CALL s_desc_get_department_desc(g_rtek_m.rteksite)
                     RETURNING g_rtek_m.rteksite_desc
                  DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc
                  NEXT FIELD CURRENT
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET g_rtek_m.rteksite = g_rtek_m_t.rteksite
               CALL s_desc_get_department_desc(g_rtek_m.rteksite)
                  RETURNING g_rtek_m.rteksite_desc
               DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc
               NEXT FIELD CURRENT            

            END IF 
            
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_rtek_m.rteksite)
               RETURNING g_rtek_m.rteksite_desc
            DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc
            
            CALL artt409_rtel019_def()   #160513-00037#3 160517 by lori add
            CALL artt409_set_entry(p_cmd)
            CALL artt409_set_no_entry(p_cmd)          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rteksite
            #add-point:BEFORE FIELD rteksite name="input.b.rteksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rteksite
            #add-point:ON CHANGE rteksite name="input.g.rteksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekdocdt
            #add-point:BEFORE FIELD rtekdocdt name="input.b.rtekdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekdocdt
            
            #add-point:AFTER FIELD rtekdocdt name="input.a.rtekdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtekdocdt
            #add-point:ON CHANGE rtekdocdt name="input.g.rtekdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekdocno
            #add-point:BEFORE FIELD rtekdocno name="input.b.rtekdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekdocno
            
            #add-point:AFTER FIELD rtekdocno name="input.a.rtekdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_rtek_m.rtekdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtek_m.rtekdocno != g_rtekdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtek_t WHERE "||"rtekent = '" ||g_enterprise|| "' AND "||"rtekdocno = '"||g_rtek_m.rtekdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_chk_slip(g_rtek_m.rteksite,g_ooef004,g_rtek_m.rtekdocno,g_prog) RETURNING l_success 
                  IF NOT l_success THEN
                     LET g_rtek_m.rtekdocno = g_rtek_m_t.rtekdocno
                     NEXT FIELD rtekdocno
                  END IF                  
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtekdocno
            #add-point:ON CHANGE rtekdocno name="input.g.rtekdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek001
            #add-point:BEFORE FIELD rtek001 name="input.b.rtek001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek001
            
            #add-point:AFTER FIELD rtek001 name="input.a.rtek001"
            IF g_rtek_m.rtek001 = 'I' THEN
               LET g_rtek_m.rtek004 = 'Y'
            ELSE
               LET g_rtek_m.rtek004 = 'N'
            END IF
            DISPLAY BY NAME g_rtek_m.rtek004            
            CALL artt409_set_entry(p_cmd)  
            CALL artt409_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek001
            #add-point:ON CHANGE rtek001 name="input.g.rtek001"
            IF g_rtek_m.rtek001 = 'I' THEN
               LET g_rtek_m.rtek004 = 'Y'
            ELSE
               LET g_rtek_m.rtek004 = 'N'
            END IF
            DISPLAY BY NAME g_rtek_m.rtek004            
            CALL artt409_set_entry(p_cmd)  
            CALL artt409_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek002
            
            #add-point:AFTER FIELD rtek002 name="input.a.rtek002"
            LET g_rtek_m.rtek002_desc = ' '
            DISPLAY BY NAME g_rtek_m.rtek002_desc
            IF NOT cl_null(g_rtek_m.rtek002) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtek_m.rtek002 != g_rtek_m_t.rtek002 OR g_rtek_m_t.rtek002 IS NULL )) THEN   #160513-00037#3 160517 by lori mark
               IF g_rtek_m.rtek002 != g_rtek_m_o.rtek002 OR cl_null(g_rtek_m_t.rtek002) THEN                                      #160513-00037#3 160517 by lori add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtek_m.rtek002
                  IF NOT cl_chk_exist("v_pmaa001_26") THEN   
                     LET g_rtek_m.rtek002 = g_rtek_m_o.rtek002        #160513-00037#3 160517 by lori mod
                     CALL artt409_rtek002_ref()
                     NEXT FIELD CURRENT
                  END IF
                  IF g_rtek_m.rtek003 IS NOT NULL THEN #add by geza
                     IF NOT artt409_rtek002_chk() THEN
                        LET g_rtek_m.rtek002 = g_rtek_m_o.rtek002        #160513-00037#3 160517 by lori mod
                        CALL artt409_rtek002_ref()
                        NEXT FIELD CURRENT                  
                     END IF
                  END IF
                  LET g_rtek_m.rtek008 = NULL                         #160513-00037#3 160517 by lori add     
                  DISPLAY BY NAME g_rtek_m.rtek008                   #160513-00037#3 160517 by lori add
                  #add by geza 20160607 #160513-00037#22(S)               
                  CALL artt409_rtek002_default()          
                  #add by geza 20160607 #160513-00037#22(E)                  
               END IF

            END IF
            CALL artt409_rtek002_ref()
            
            LET g_rtek_m_o.rtek002 = g_rtek_m.rtek002                 #160513-00037#3 160517 by lori add
            LET g_rtek_m_o.rtek003 = g_rtek_m.rtek003                 #160513-00037#3 160517 by lori add
            LET g_rtek_m_o.rtek008 = g_rtek_m.rtek008                 #160513-00037#3 160517 by lori add            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek002
            #add-point:BEFORE FIELD rtek002 name="input.b.rtek002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek002
            #add-point:ON CHANGE rtek002 name="input.g.rtek002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek003
            
            #add-point:AFTER FIELD rtek003 name="input.a.rtek003"
            LET g_rtek_m.rtek003_desc = ' '
            DISPLAY BY NAME g_rtek_m.rtek003_desc
            IF NOT cl_null(g_rtek_m.rtek003) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtek_m.rtek003 != g_rtek_m_t.rtek003 OR g_rtek_m_t.rtek003 IS NULL )) THEN   #160513-00037#3 160517 by lori mark
               IF g_rtek_m.rtek003 != g_rtek_m_o.rtek003 OR cl_null(g_rtek_m_o.rtek003) THEN                                      #160513-00037#3 160517 by lori add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtek_m.rtek003
                  LET g_chkparam.err_str[1] = "amh-00630|",g_rtek_m.rtek003
                  IF NOT cl_chk_exist("v_mhbe001") THEN
                     LET g_rtek_m.rtek003 = g_rtek_m_o.rtek003   #160513-00037#3 160517 by lori mod
                     CALL artt409_rtek003_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #mark by geza 20160610(S)
                  #檢查鋪位狀態是否為2、3
#                  SELECT mhbe012 INTO l_mhbe012
#                    FROM mhbe_t
#                   WHERE mhbeent = g_enterprise
#                     AND mhbe001 = g_rtek_m.rtek003
#                  IF l_mhbe012 ='1' OR cl_null(l_mhbe012) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = ""
#                     LET g_errparam.code   = "art-00759"     
#                     LET g_errparam.popup  = TRUE            
#                     LET g_errparam.replace[1] = g_rtek_m.rtek003 
#                     CALL cl_err()  
#                     LET g_rtek_m.rtek003 = g_rtek_m_o.rtek003  #160513-00037#3 160517 by lori mod
#                     CALL artt409_rtek003_ref()
#                     NEXT FIELD CURRENT                     
#                  END IF                                  
                  #mark by geza 20160610(E)
                  LET g_rtek_m.rtek008 = NULL                   #160513-00037#3 160517 by lori add
                  DISPLAY BY NAME g_rtek_m.rtek008              #160513-00037#3 160517 by lori add
                  #add by geza 20160607 #160513-00037#22(S)              
                  IF NOT cl_null(g_rtek_m.rtek002) OR NOT cl_null(g_rtek_m.rtek008) THEN
                     IF NOT artt409_rtek003_chk() THEN
                        LET g_rtek_m.rtek003 = g_rtek_m_o.rtek003        
                        CALL artt409_rtek003_ref()
                        NEXT FIELD CURRENT                  
                     END IF                  
                  END IF
                  CALL artt409_rtek003_default()                
                  #add by geza 20160607 #160513-00037#22(E)
               END IF               
            END IF            
           
            LET g_rtek_m_o.rtek003 = g_rtek_m.rtek003           #160513-00037#3 160517 by lori add
            LET g_rtek_m_o.rtek008 = g_rtek_m.rtek008           #160513-00037#3 160517 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek003
            #add-point:BEFORE FIELD rtek003 name="input.b.rtek003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek003
            #add-point:ON CHANGE rtek003 name="input.g.rtek003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek008
            #add-point:BEFORE FIELD rtek008 name="input.b.rtek008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek008
            
            #add-point:AFTER FIELD rtek008 name="input.a.rtek008"
            #160513-00037#3 160517 by lori add---(S)
            IF NOT cl_null(g_rtek_m.rtek008) THEN
               IF g_rtek_m.rtek008 != g_rtek_m_o.rtek008 OR cl_null(g_rtek_m_o.rtek008) THEN
                  IF NOT artt409_rtek008_chk_and_def() THEN
                     LET g_rtek_m.rtek008 = g_rtek_m_o.rtek008
                     DISPLAY BY NAME g_rtek_m.rtek008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160513-00037#3 160517 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek008
            #add-point:ON CHANGE rtek008 name="input.g.rtek008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek004
            #add-point:BEFORE FIELD rtek004 name="input.b.rtek004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek004
            
            #add-point:AFTER FIELD rtek004 name="input.a.rtek004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek004
            #add-point:ON CHANGE rtek004 name="input.g.rtek004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek005
            
            #add-point:AFTER FIELD rtek005 name="input.a.rtek005"
            LET g_rtek_m.rtek005_desc = ''
            DISPLAY BY NAME g_rtek_m.rtek005_desc
            IF NOT cl_null(g_rtek_m.rtek005) THEN
               IF g_rtek_m.rtek005 != g_rtek_m_o.rtek005 OR cl_null(g_rtek_m_o.rtek005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtek_m.rtek005
                  IF cl_chk_exist("v_ooag001") THEN
                     CALL s_apmt840_get_dep(g_rtek_m.rtek005) RETURNING g_rtek_m.rtek006
                     CALL s_desc_get_person_desc(g_rtek_m.rtek006) RETURNING g_rtek_m.rtek006_desc
                     DISPLAY BY NAME g_rtek_m.rtek006_desc   
                  ELSE
                     LET g_rtek_m.rtek005 = g_rtek_m_o.rtek005
                     CALL s_desc_get_person_desc(g_rtek_m.rtek005) RETURNING g_rtek_m.rtek005_desc
                     DISPLAY BY NAME g_rtek_m.rtek005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_rtek_m.rtek005) RETURNING g_rtek_m.rtek005_desc
            DISPLAY BY NAME g_rtek_m.rtek005_desc
            LET g_rtek_m_o.rtek005 = g_rtek_m.rtek005
            LET g_rtek_m_o.rtek006 = g_rtek_m.rtek006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek005
            #add-point:BEFORE FIELD rtek005 name="input.b.rtek005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek005
            #add-point:ON CHANGE rtek005 name="input.g.rtek005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek006
            
            #add-point:AFTER FIELD rtek006 name="input.a.rtek006"
            LET g_rtek_m.rtek006_desc = ''
            DISPLAY BY NAME g_rtek_m.rtek006_desc
            IF NOT cl_null(g_rtek_m.rtek006) THEN
               IF g_rtek_m.rtek006 != g_rtek_m_t.rtek006 OR cl_null(g_rtek_m.rtek006) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtek_m.rtek006
                  LET g_chkparam.arg2 = g_rtek_m.rtekdocdt
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_rtek_m.rtek006 = g_rtek_m_t.rtek006
                     CALL s_desc_get_department_desc(g_rtek_m.rtek006) RETURNING g_rtek_m.rtek006_desc
                     DISPLAY BY NAME g_rtek_m.rtek006_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_rtek_m.rtek006) RETURNING g_rtek_m.rtek006_desc
            DISPLAY BY NAME g_rtek_m.rtek006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek006
            #add-point:BEFORE FIELD rtek006 name="input.b.rtek006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek006
            #add-point:ON CHANGE rtek006 name="input.g.rtek006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtek007
            #add-point:BEFORE FIELD rtek007 name="input.b.rtek007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtek007
            
            #add-point:AFTER FIELD rtek007 name="input.a.rtek007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtek007
            #add-point:ON CHANGE rtek007 name="input.g.rtek007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtekstus
            #add-point:BEFORE FIELD rtekstus name="input.b.rtekstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtekstus
            
            #add-point:AFTER FIELD rtekstus name="input.a.rtekstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtekstus
            #add-point:ON CHANGE rtekstus name="input.g.rtekstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rteksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rteksite
            #add-point:ON ACTION controlp INFIELD rteksite name="input.c.rteksite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtek_m.rteksite             #給予default值

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rteksite','','i') 
            CALL q_ooef001_24()                                #呼叫開窗
            LET g_rtek_m.rteksite = g_qryparam.return1              
            DISPLAY g_rtek_m.rteksite TO rteksite              
            CALL s_desc_get_department_desc(g_rtek_m.rteksite) RETURNING g_rtek_m.rteksite_desc
            DISPLAY BY NAME g_rtek_m.rteksite_desc
            NEXT FIELD rteksite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtekdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekdocdt
            #add-point:ON ACTION controlp INFIELD rtekdocdt name="input.c.rtekdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtekdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekdocno
            #add-point:ON ACTION controlp INFIELD rtekdocno name="input.c.rtekdocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtek_m.rtekdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = g_prog 
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_rtek_m.rtekdocno = g_qryparam.return1              
            DISPLAY g_rtek_m.rtekdocno TO rtekdocno              #
            NEXT FIELD rtekdocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtek001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek001
            #add-point:ON ACTION controlp INFIELD rtek001 name="input.c.rtek001"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtek002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek002
            #add-point:ON ACTION controlp INFIELD rtek002 name="input.c.rtek002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtek_m.rtek002             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where  = " pmaa002 = '3' "
 
            #160913-00034#5 -S
            #CALL q_pmaa001()                           #呼叫開窗            
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                          #呼叫開窗
            #160913-00034#5 -E
 
            LET g_rtek_m.rtek002 = g_qryparam.return1              

            DISPLAY g_rtek_m.rtek002 TO rtek002              #

            NEXT FIELD rtek002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtek003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek003
            #add-point:ON ACTION controlp INFIELD rtek003 name="input.c.rtek003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtek_m.rtek003             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #s
            #LET g_qryparam.where = " mhbe012 IN ('2','3') "
            IF g_rtek_m.rtek002 IS NOT NULL THEN
               LET g_qryparam.where = " stje007 = '",g_rtek_m.rtek002,"' "
            END IF
            
            CALL q_mhbe001_1()                                #呼叫開窗
 
            LET g_rtek_m.rtek003 = g_qryparam.return1              

            DISPLAY g_rtek_m.rtek003 TO rtek003              #

            NEXT FIELD rtek003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtek008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek008
            #add-point:ON ACTION controlp INFIELD rtek008 name="input.c.rtek008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160513-00037#3 160517 by lori add---(S)
            LET l_where = ''
            #商戶
            IF NOT cl_null(g_rtek_m.rtek002) THEN
               LET l_where = " stje007 = '",g_rtek_m.rtek002,"' "
            END IF
            #鋪位
            IF NOT cl_null(g_rtek_m.rtek003) THEN
               IF NOT cl_null(l_where) THEN
                  LET l_where = l_where, " AND "
               END IF   
               
               LET l_where = l_where," stje008 = '",g_rtek_m.rtek003,"' "
            END IF
            IF NOT cl_null(l_where) THEN
               LET l_where = l_where, " AND stje012 >= '",g_today,"' "
            ELSE
               LET l_where =  " stje012 >= '",g_today,"' "         
            END IF 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_rtek_m.rtek008 
            LET g_qryparam.where = l_where
                         
            CALL q_stje001_1()                       
            
            LET g_rtek_m.rtek008 = g_qryparam.return1              
            DISPLAY g_rtek_m.rtek008 TO rtek008   
            NEXT FIELD rtek008 
            #160513-00037#3 160517 by lori add---(E)
            #END add-point
 
 
         #Ctrlp:input.c.rtek004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek004
            #add-point:ON ACTION controlp INFIELD rtek004 name="input.c.rtek004"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtek005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek005
            #add-point:ON ACTION controlp INFIELD rtek005 name="input.c.rtek005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtek_m.rtek005             #給予default值

          
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_rtek_m.rtek005 = g_qryparam.return1              

            DISPLAY g_rtek_m.rtek005 TO rtek005              #
            CALL s_desc_get_person_desc(g_rtek_m.rtek005) RETURNING g_rtek_m.rtek005_desc
            DISPLAY BY NAME g_rtek_m.rtek005_desc
            NEXT FIELD rtek005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtek006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek006
            #add-point:ON ACTION controlp INFIELD rtek006 name="input.c.rtek006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtek_m.rtek006             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_rtek_m.rtekdocdt

 
            CALL q_ooeg001()                                #呼叫開窗
 
            LET g_rtek_m.rtek006 = g_qryparam.return1              
            #LET g_rtek_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_rtek_m.rtek006 TO rtek006              #
            CALL s_desc_get_department_desc(g_rtek_m.rtek006) RETURNING g_rtek_m.rtek006_desc
            DISPLAY BY NAME g_rtek_m.rtek006_desc
            NEXT FIELD rtek006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtek007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtek007
            #add-point:ON ACTION controlp INFIELD rtek007 name="input.c.rtek007"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtekstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtekstus
            #add-point:ON ACTION controlp INFIELD rtekstus name="input.c.rtekstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtek_m.rtekdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                 IF NOT cl_null(g_rtek_m.rtekdocno) THEN
                    CALL s_aooi200_gen_docno(g_rtek_m.rteksite,g_rtek_m.rtekdocno,g_rtek_m.rtekdocdt,g_prog)
                    RETURNING  g_success,g_rtek_m.rtekdocno
                    IF g_success<>'1' THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = "amm-00001"
                       LET g_errparam.extend = g_rtek_m.rtekdocno
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                    
                       NEXT FIELD rtekdocno
                    ELSE
                       IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtek_t WHERE "||"rtekent = '" ||g_enterprise|| "' AND "||"rtekdocno = '"||g_rtek_m.rtekdocno ||"'",'std-00004',0) THEN 
                          LET g_rtek_m.rtekdocno = g_rtek_m_t.rtekdocno
                          NEXT FIELD CURRENT
                       END IF    
                                     
                    END IF
                    LET g_rtek_m_t.rtekdocno = g_rtek_m.rtekdocno
                 END IF 
               #end add-point
               
               INSERT INTO rtek_t (rtekent,rteksite,rtekdocdt,rtekdocno,rtek001,rtek002,rtek003,rtek008, 
                   rtek004,rtek005,rtek006,rtek007,rtekstus,rtekownid,rtekowndp,rtekcrtid,rtekcrtdp, 
                   rtekcrtdt,rtekmodid,rtekmoddt,rtekcnfid,rtekcnfdt)
               VALUES (g_enterprise,g_rtek_m.rteksite,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001, 
                   g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004,g_rtek_m.rtek005, 
                   g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
                   g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
                   g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtek_m:",SQLERRMESSAGE 
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
                  CALL artt409_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt409_b_fill()
                  CALL artt409_b_fill2('0')
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
               CALL artt409_rtek_t_mask_restore('restore_mask_o')
               
               UPDATE rtek_t SET (rteksite,rtekdocdt,rtekdocno,rtek001,rtek002,rtek003,rtek008,rtek004, 
                   rtek005,rtek006,rtek007,rtekstus,rtekownid,rtekowndp,rtekcrtid,rtekcrtdp,rtekcrtdt, 
                   rtekmodid,rtekmoddt,rtekcnfid,rtekcnfdt) = (g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
                   g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008, 
                   g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus, 
                   g_rtek_m.rtekownid,g_rtek_m.rtekowndp,g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt, 
                   g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt,g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt)
                WHERE rtekent = g_enterprise AND rtekdocno = g_rtekdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtek_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artt409_rtek_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtek_m_t)
               LET g_log2 = util.JSON.stringify(g_rtek_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt409.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtel_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
               IF NOT cl_null(g_rtel_d[l_ac].rtel003)  THEN
                  CALL n_rtell(g_rtek_m.rtekdocno,g_rtel_d[l_ac].rtelseq)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_rtek_m.rtekdocno
                  LET g_ref_fields[2] = g_rtel_d[l_ac].rtelseq
                  CALL ap_ref_array2(g_ref_fields," SELECT rtell002,rtell003,rtell004 FROM rtell_t WHERE rtellent = '"
                      ||g_enterprise||"' AND rtelldocno = ? AND rtellseq = ? AND rtell001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_rtel_d[l_ac].rtell002 = g_rtn_fields[1]
                  LET g_rtel_d[l_ac].rtell003 = g_rtn_fields[2]
                  LET g_rtel_d[l_ac].rtell004 = g_rtn_fields[3]
               
                  DISPLAY BY NAME g_rtel_d[l_ac].rtell002
                  DISPLAY BY NAME g_rtel_d[l_ac].rtell003
                  DISPLAY BY NAME g_rtel_d[l_ac].rtell004                  
               END IF           
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtel_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt409_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtel_d.getLength()
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
            OPEN artt409_cl USING g_enterprise,g_rtek_m.rtekdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt409_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt409_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtel_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtel_d[l_ac].rtelseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtel_d_t.* = g_rtel_d[l_ac].*  #BACKUP
               LET g_rtel_d_o.* = g_rtel_d[l_ac].*  #BACKUP
               CALL artt409_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL artt409_set_no_entry_b(l_cmd)
               IF NOT artt409_lock_b("rtel_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt409_bcl INTO g_rtel_d[l_ac].rtelacti,g_rtel_d[l_ac].rtelseq,g_rtel_d[l_ac].rtel001, 
                      g_rtel_d[l_ac].rtel023,g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtel003,g_rtel_d[l_ac].rtel004, 
                      g_rtel_d[l_ac].rtel005,g_rtel_d[l_ac].rtel006,g_rtel_d[l_ac].rtel007,g_rtel_d[l_ac].rtel008, 
                      g_rtel_d[l_ac].rtel009,g_rtel_d[l_ac].rtel010,g_rtel_d[l_ac].rtel011,g_rtel_d[l_ac].rtel012, 
                      g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel020,g_rtel_d[l_ac].rtel021,g_rtel_d[l_ac].rtel022, 
                      g_rtel_d[l_ac].rtel013,g_rtel_d[l_ac].rtel014,g_rtel_d[l_ac].rtel015,g_rtel_d[l_ac].rtel016, 
                      g_rtel_d[l_ac].rtel017,g_rtel_d[l_ac].rtel019
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtel_d_t.rtelseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtel_d_mask_o[l_ac].* =  g_rtel_d[l_ac].*
                  CALL artt409_rtel_t_mask()
                  LET g_rtel_d_mask_n[l_ac].* =  g_rtel_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt409_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.rtelldocno = g_rtek_m.rtekdocno
LET g_detail_multi_table_t.rtellseq = g_rtel_d[l_ac].rtelseq
LET g_detail_multi_table_t.rtell001 = g_dlang
LET g_detail_multi_table_t.rtell002 = g_rtel_d[l_ac].rtell002
LET g_detail_multi_table_t.rtell003 = g_rtel_d[l_ac].rtell003
LET g_detail_multi_table_t.rtell004 = g_rtel_d[l_ac].rtell004
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'rtellent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'rtelldocno'
            LET l_var_keys[02] = g_rtek_m.rtekdocno
            LET l_field_keys[03] = 'rtellseq'
            LET l_var_keys[03] = g_rtel_d[l_ac].rtelseq
            LET l_field_keys[04] = 'rtell001'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'rtell_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtel_d[l_ac].* TO NULL 
            INITIALIZE g_rtel_d_t.* TO NULL 
            INITIALIZE g_rtel_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtel_d[l_ac].rtel001 = "1"
      LET g_rtel_d[l_ac].rtel023 = "1"
      LET g_rtel_d[l_ac].rtel013 = "0"
      LET g_rtel_d[l_ac].rtel014 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_rtel_d[l_ac].rtel023 = "8" #add by geza 20160622
            LET g_rtel_d[l_ac].rtel013 = ""
            LET g_rtel_d[l_ac].rtel014 = ""
            #項次加1
            SELECT MAX(rtelseq)+1 INTO g_rtel_d[l_ac].rtelseq
              FROM rtel_t
             WHERE rtelent = g_enterprise
               AND rteldocno = g_rtek_m.rtekdocno
            IF cl_null(g_rtel_d[l_ac].rtelseq) OR g_rtel_d[l_ac].rtelseq = 0 THEN
               LET g_rtel_d[l_ac].rtelseq = 1
            END IF
            
            #有效
            LET g_rtel_d[l_ac].rtelacti = 'Y'
            
            #160513-00037#3 160517 by lori add---(S)
            #庫區
            IF cl_null(g_ooef127) THEN
               CALL artt409_rtel019_def()                            
            END IF
            
            LET g_rtel_d[l_ac].rtel019 = g_ooef127
            LET g_rtel_d[l_ac].rtel019_desc = s_desc_get_stock_desc(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel019)
            #160513-00037#3 160517 by lori add---(E)
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_rtek_m.rteksite,'4')  RETURNING l_success,g_rtel_d[l_ac].rtel019
            LET g_rtel_d[l_ac].rtel019_desc = s_desc_get_stock_desc(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel019)
            #160604-00009#50 -e by 08172            
            #add by geza 20160607 #160604-00009#11(S)
            IF g_rtek_m.rtek004 = 'N' THEN
               LET g_rtel_d[l_ac].rtel001 = ""
            ELSE   
               LET g_rtel_d[l_ac].rtel001 = "1"   
            END IF
            #add by geza 20160607 #160604-00009#11(S)
            #end add-point
            LET g_rtel_d_t.* = g_rtel_d[l_ac].*     #新輸入資料
            LET g_rtel_d_o.* = g_rtel_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt409_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL artt409_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtel_d[li_reproduce_target].* = g_rtel_d[li_reproduce].*
 
               LET g_rtel_d[li_reproduce_target].rtelseq = NULL
 
            END IF
            
LET g_detail_multi_table_t.rtelldocno = g_rtek_m.rtekdocno
LET g_detail_multi_table_t.rtellseq = g_rtel_d[l_ac].rtelseq
LET g_detail_multi_table_t.rtell001 = g_dlang
LET g_detail_multi_table_t.rtell002 = g_rtel_d[l_ac].rtell002
LET g_detail_multi_table_t.rtell003 = g_rtel_d[l_ac].rtell003
LET g_detail_multi_table_t.rtell004 = g_rtel_d[l_ac].rtell004
 
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
            IF g_rtek_m.rtek004 = 'Y' AND g_rtel_d[l_ac].rtel001 = '2' THEN
               IF NOT artt409_rtel003_chk(g_rtel_d[l_ac].rtel003) THEN 
                  #CALL s_auto_barcode('1') RETURNING g_rtel_d[l_ac].rtel002,l_success #mark by geza 20160621
                  CALL s_auto_barcode( g_rtel_d[l_ac].rtel023) RETURNING g_rtel_d[l_ac].rtel002,l_success #add by geza 20160621
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT  
                  END IF
                  #DISPLAY g_rtel_d[l_ac].rtel002 TO s_detail1.rtel002
                  DISPLAY g_rtel_d[l_ac].rtel002 TO rtel002  
               END IF
            END IF
            #add by geza 20160613(S)
            LET l_sys = cl_get_para(g_enterprise,g_rtek_m.rteksite,"S-CIR-2031")
            IF l_sys = 'N' THEN
#               IF g_rtek_m.rtek004 = 'Y' THEN
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt
#                    FROM oofg_t
#                   WHERE oofgent = g_enterprise
#                     AND oofg002 = '1'    
#                     AND oofgstus = 'Y'
#                  IF l_cnt = 0 THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = '' 
#                     LET g_errparam.code   = "art-00782" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     INITIALIZE g_rtel_d[l_ac].* TO NULL
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  ELSE
#                     CALL s_aooi390_gen('1') RETURNING l_success,g_rtel_d[l_ac].rtel003,l_oofg_return
#                  END IF              
#               END IF
               CALL s_aooi390_get_auto_no('1',g_rtel_d[l_ac].rtel003) RETURNING l_success,g_rtel_d[l_ac].rtel003            
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_aooi390_oofi_upd('1',g_rtel_d[l_ac].rtel003) RETURNING l_success
            ELSE
               LET g_rtel_d[l_ac].rtel003 = g_rtel_d[l_ac].rtel002 
            END IF            
            #检查商品是否重复
            IF g_rtek_m.rtek001 = 'I' THEN
               IF artt409_rtel003_chk(g_rtel_d[l_ac].rtel003) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = "art-00072" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  INITIALIZE g_rtel_d[l_ac].* TO NULL
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               IF NOT s_artt409_rtel003_chk('1','',g_rtel_d[l_ac].rtel003) THEN
                  INITIALIZE g_rtel_d[l_ac].* TO NULL
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT                      
               END IF
            END IF   
            IF NOT artt409_rtel003_chk1(g_rtel_d[l_ac].rtel003,g_rtel_d[l_ac].rtelseq) THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = "art-00072" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_rtel_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT  
            END IF
            #add by geza 20160613(E)
            #mark by geza 20160613(S)
#               IF g_rtek_m.rtek004 = 'Y' THEN
#                  LET l_cnt = 0
#                  SELECT COUNT(*) INTO l_cnt
#                    FROM oofg_t
#                   WHERE oofgent = g_enterprise
#                     AND oofg002 = '1'    
#                     AND oofgstus = 'Y'
#                  IF l_cnt = 0 THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = '' 
#                     LET g_errparam.code   = "art-00782" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     INITIALIZE g_rtel_d[l_ac].* TO NULL
#                     CALL s_transaction_end('N','0')
#                     CANCEL INSERT
#                  ELSE
#                     CALL s_aooi390_gen('1') RETURNING l_success,g_rtel_d[l_ac].rtel003,l_oofg_return
#                  END IF              
#               END IF
#            #add by geza 20160610(E)
#            CALL s_aooi390_get_auto_no('1',g_rtel_d[l_ac].rtel003) RETURNING l_success,g_rtel_d[l_ac].rtel003            
#            IF NOT l_success THEN
#               CALL s_transaction_end('N','0')
#               NEXT FIELD CURRENT
#            END IF
#            
#            CALL s_aooi390_oofi_upd('1',g_rtel_d[l_ac].rtel003) RETURNING l_success
            #mark by geza 20160613(E)
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtel_t 
             WHERE rtelent = g_enterprise AND rteldocno = g_rtek_m.rtekdocno
 
               AND rtelseq = g_rtel_d[l_ac].rtelseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtek_m.rtekdocno
               LET gs_keys[2] = g_rtel_d[g_detail_idx].rtelseq
               CALL artt409_insert_b('rtel_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtel_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtel_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt409_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtek_m.rtekdocno = g_detail_multi_table_t.rtelldocno AND
         g_rtel_d[l_ac].rtelseq = g_detail_multi_table_t.rtellseq AND
         g_rtel_d[l_ac].rtell002 = g_detail_multi_table_t.rtell002 AND
         g_rtel_d[l_ac].rtell003 = g_detail_multi_table_t.rtell003 AND
         g_rtel_d[l_ac].rtell004 = g_detail_multi_table_t.rtell004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtellent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtek_m.rtekdocno
            LET l_field_keys[02] = 'rtelldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtelldocno
            LET l_var_keys[03] = g_rtel_d[l_ac].rtelseq
            LET l_field_keys[03] = 'rtellseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtellseq
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'rtell001'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.rtell001
            LET l_vars[01] = g_rtel_d[l_ac].rtell002
            LET l_fields[01] = 'rtell002'
            LET l_vars[02] = g_rtel_d[l_ac].rtell003
            LET l_fields[02] = 'rtell003'
            LET l_vars[03] = g_rtel_d[l_ac].rtell004
            LET l_fields[03] = 'rtell004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtell_t')
         END IF 
 
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
               LET gs_keys[01] = g_rtek_m.rtekdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtel_d_t.rtelseq
 
            
               #刪除同層單身
               IF NOT artt409_delete_b('rtel_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt409_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt409_key_delete_b(gs_keys,'rtel_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt409_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'rtellent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'rtelldocno'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.rtelldocno
                  LET l_field_keys[03] = 'rtellseq'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.rtellseq
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtell_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt409_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rtel_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtel_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtelacti
            #add-point:BEFORE FIELD rtelacti name="input.b.page1.rtelacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtelacti
            
            #add-point:AFTER FIELD rtelacti name="input.a.page1.rtelacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtelacti
            #add-point:ON CHANGE rtelacti name="input.g.page1.rtelacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtelseq
            #add-point:BEFORE FIELD rtelseq name="input.b.page1.rtelseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtelseq
            
            #add-point:AFTER FIELD rtelseq name="input.a.page1.rtelseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_rtek_m.rtekdocno IS NOT NULL AND g_rtel_d[g_detail_idx].rtelseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtek_m.rtekdocno != g_rtekdocno_t OR g_rtel_d[g_detail_idx].rtelseq != g_rtel_d_t.rtelseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtel_t WHERE "||"rtelent = '" ||g_enterprise|| "' AND "||"rteldocno = '"||g_rtek_m.rtekdocno ||"' AND "|| "rtelseq = '"||g_rtel_d[g_detail_idx].rtelseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtelseq
            #add-point:ON CHANGE rtelseq name="input.g.page1.rtelseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel001
            #add-point:BEFORE FIELD rtel001 name="input.b.page1.rtel001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel001
            
            #add-point:AFTER FIELD rtel001 name="input.a.page1.rtel001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel001
            #add-point:ON CHANGE rtel001 name="input.g.page1.rtel001"
            #add by geza 20160613(S)
            LET g_rtel_d[l_ac].rtel002 = ''
            LET g_rtel_d[l_ac].rtel003 = ''
            #add by geza 20160613(E)
            CALL artt409_set_entry_b(l_cmd)
            CALL artt409_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel023
            #add-point:BEFORE FIELD rtel023 name="input.b.page1.rtel023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel023
            
            #add-point:AFTER FIELD rtel023 name="input.a.page1.rtel023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel023
            #add-point:ON CHANGE rtel023 name="input.g.page1.rtel023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel002
            #add-point:BEFORE FIELD rtel002 name="input.b.page1.rtel002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel002
            
            #add-point:AFTER FIELD rtel002 name="input.a.page1.rtel002"
            IF NOT cl_null(g_rtel_d[l_ac].rtel002) THEN
               IF g_rtel_d[l_ac].rtel002 != g_rtel_d_o.rtel002 OR cl_null(g_rtel_d_o.rtel002) THEN
                  IF g_rtek_m.rtek001 = 'I' AND g_rtek_m.rtek004 = 'N' THEN #類型為引進時需檢查商品不可存在門店清單
                     CALL artt409_get_imay001(g_rtel_d[l_ac].rtel002) RETURNING g_rtel_d[l_ac].rtel003
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_rtel_d[l_ac].rtel003
                     LET g_chkparam.err_str[1] = "aim-00001:art-00691" 
                     LET g_chkparam.err_str[2] = "aim-00101:art-00212"                     
                     IF NOT cl_chk_exist("v_imaa001") THEN                     
                        LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                        NEXT FIELD CURRENT
                     END IF                     
                     IF NOT artt409_rtdx001_chk1(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel003) THEN                      
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "art-00531"
                        LET g_errparam.extend = g_rtel_d[l_ac].rtel003
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                        
                        LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                        NEXT FIELD CURRENT                        
                     END IF   
                  END IF
                  IF g_rtek_m.rtek004 = 'Y' THEN  #自動建立商品
                     CALL artt409_chk_barcode(g_rtel_d[l_ac].rtel002)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_rtel_d[l_ac].rtel002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        IF NOT cl_null(g_rtel_d_o.rtel002) THEN
                           LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        END IF
                        NEXT FIELD CURRENT
                     END IF 
                     IF g_rtel_d[l_ac].rtel001 = '1' THEN
                        CALL s_chk_barcode(g_rtel_d[l_ac].rtel002) RETURNING g_success
                        IF g_success = 'N' THEN
                           IF NOT cl_null(g_rtel_d_o.rtel002) THEN
                              LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                           END IF
                           NEXT FIELD CURRENT
                        END IF
                     END IF                     
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_rtel_d[l_ac].rtel002
                     IF NOT cl_chk_exist("v_imay003_1") THEN
                        LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        NEXT FIELD CURRENT
                     END IF
                     CALL artt409_get_imay001(g_rtel_d[l_ac].rtel002) RETURNING g_rtel_d[l_ac].rtel003
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_rtel_d[l_ac].rtel003
                     LET g_chkparam.err_str[1] = "aim-00001:art-00691" 
                     LET g_chkparam.err_str[2] = "aim-00101:art-00212"                     
                     IF NOT cl_chk_exist("v_imaa001") THEN                     
                        LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                        NEXT FIELD CURRENT
                     END IF
                     IF g_rtek_m.rtek001 = 'U' THEN #類型為修改時，需檢查商品是否存在門店清單
                        IF NOT artt409_rtdx001_chk(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel003) THEN #如商品不存在門店清單的話                     
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "art-00530"
                           LET g_errparam.extend = g_rtel_d[l_ac].rtel003
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                        
                           LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                           LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                           NEXT FIELD CURRENT                        
                        END IF 
                     END IF                        
                  END IF
                  #add by geza 2016013(S)
                  #商品条码在单身不能重复
                  IF NOT artt409_rtel002_chk1(g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtelseq) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = "art-00783" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_rtel_d[l_ac].rtel003 = g_rtel_d_t.rtel003
                     NEXT FIELD CURRENT   
                  END IF
                  #add by geza 2016013(E)
                  CALL artt409_rtel003_default()   #mark by geza 20160618 #160604-00009#11 
               END IF
            END IF
            LET g_rtel_d_o.rtel002 = g_rtel_d[l_ac].rtel002
            LET g_rtel_d_o.rtel003 = g_rtel_d[l_ac].rtel003

            #CALL artt409_rtel003_default()   #mark by geza 20160618 #160604-00009#11 
            CALL artt409_set_entry_b(l_cmd)
            CALL artt409_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel002
            #add-point:ON CHANGE rtel002 name="input.g.page1.rtel002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel003
            #add-point:BEFORE FIELD rtel003 name="input.b.page1.rtel003"
            IF cl_null(g_rtel_d[l_ac].rtel003) AND g_rtek_m.rtek004 = 'Y' THEN    
               CALL s_aooi390_gen('1') RETURNING l_success,g_rtel_d[l_ac].rtel003,l_oofg_return              
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel003
            
            #add-point:AFTER FIELD rtel003 name="input.a.page1.rtel003"
            #mark by geza 20160618 #160604-00009#11(S)
#            LET g_rtel_d[l_ac].rtell002 = ''
#            LET g_rtel_d[l_ac].rtell003 = ''
#            LET g_rtel_d[l_ac].rtell004 = ''
            #mark by geza 20160618 #160604-00009#11(E)
            DISPLAY BY NAME g_rtel_d[l_ac].rtell002,g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004
            IF NOT cl_null(g_rtel_d[l_ac].rtel003) THEN 
               IF g_rtel_d[l_ac].rtel003 != g_rtel_d_o.rtel003 OR cl_null(g_rtel_d_o.rtel003) THEN
                  IF g_rtek_m.rtek001 = 'I' THEN #類型為引進時需檢查商品不可存在門店清單                  
                     IF NOT artt409_rtdx001_chk1(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel003) THEN                      
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "art-00531"
                        LET g_errparam.extend = g_rtel_d[l_ac].rtel003
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                        
                        LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                        NEXT FIELD CURRENT                        
                     END IF   
                  END IF                  
                  IF g_rtek_m.rtek004 = 'Y' THEN
                     IF NOT artt409_rtel003_chk(g_rtel_d[l_ac].rtel003) THEN                     
                        IF NOT s_aooi390_chk('1',g_rtel_d[l_ac].rtel003) THEN
                           LET g_rtel_d[l_ac].rtel003 = g_rtel_d_t.rtel003
                           NEXT FIELD CURRENT
                        END IF
                        #mark by geza 20160613(S)
#                        IF NOT s_artt409_rtel003_chk('1','',g_rtel_d[l_ac].rtel003) THEN
#                           LET g_rtel_d[l_ac].rtel003 = g_rtel_d_t.rtel003
#                           NEXT FIELD CURRENT                        
#                        END IF
                        #mark by geza 20160613(E)
                        #add by geza 20160613(S)
                        IF g_rtek_m.rtek001 = 'I' THEN
                           IF NOT s_artt409_rtel003_chk('1','',g_rtel_d[l_ac].rtel003) THEN
                              LET g_rtel_d[l_ac].rtel003 = g_rtel_d_t.rtel003
                              NEXT FIELD CURRENT                        
                           END IF
                        END IF
                        IF NOT artt409_rtel003_chk1(g_rtel_d[l_ac].rtel003,g_rtel_d[l_ac].rtelseq) THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = '' 
                           LET g_errparam.code   = "art-00072" 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_rtel_d[l_ac].rtel003 = g_rtel_d_t.rtel003
                           NEXT FIELD CURRENT   
                        END IF
                        #add by geza 20160613(E)
                     ELSE 
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_rtel_d[l_ac].rtel003
                        LET g_chkparam.err_str[1] = "aim-00001:art-00691"   
                        LET g_chkparam.err_str[2] = "aim-00101:art-00125"
                        IF NOT cl_chk_exist("v_imaa001") THEN                     
                           LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                           LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                           NEXT FIELD CURRENT
                        END IF                       
                     END IF                        
                  ELSE                   
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_rtel_d[l_ac].rtel003
                     LET g_chkparam.err_str[1] = "aim-00001:art-00691" 
                     LET g_chkparam.err_str[2] = "aim-00101:art-00125"                     
                     IF NOT cl_chk_exist("v_imaa001") THEN                     
                        LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                        LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                        NEXT FIELD CURRENT
                     END IF
                     IF g_rtek_m.rtek001 = 'U' THEN #類型為修改時需檢查商品需存在門店清單                      
                        IF NOT artt409_rtdx001_chk(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel003) THEN #如商品不存在門店清單的話                     
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "art-00530"
                           LET g_errparam.extend = g_rtel_d[l_ac].rtel003
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                        
                           LET g_rtel_d[l_ac].rtel002 = g_rtel_d_o.rtel002
                           LET g_rtel_d[l_ac].rtel003 = g_rtel_d_o.rtel003
                           NEXT FIELD CURRENT                        
                        END IF
                     END IF
                  END IF
                  CALL artt409_rtel003_default()   #mark by geza 20160618 #160604-00009#11   
               END IF    
            END IF 
            LET g_rtel_d_o.rtel002 = g_rtel_d[l_ac].rtel002
            LET g_rtel_d_o.rtel003 = g_rtel_d[l_ac].rtel003
            #CALL artt409_rtel003_default()  #mark by geza 20160618 #160604-00009#11 
            CALL artt409_set_entry_b(l_cmd)
            CALL artt409_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel003
            #add-point:ON CHANGE rtel003 name="input.g.page1.rtel003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtell002
            #add-point:BEFORE FIELD rtell002 name="input.b.page1.rtell002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtell002
            
            #add-point:AFTER FIELD rtell002 name="input.a.page1.rtell002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtell002
            #add-point:ON CHANGE rtell002 name="input.g.page1.rtell002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtell003
            #add-point:BEFORE FIELD rtell003 name="input.b.page1.rtell003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtell003
            
            #add-point:AFTER FIELD rtell003 name="input.a.page1.rtell003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtell003
            #add-point:ON CHANGE rtell003 name="input.g.page1.rtell003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtell004
            #add-point:BEFORE FIELD rtell004 name="input.b.page1.rtell004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtell004
            
            #add-point:AFTER FIELD rtell004 name="input.a.page1.rtell004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtell004
            #add-point:ON CHANGE rtell004 name="input.g.page1.rtell004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel004
            
            #add-point:AFTER FIELD rtel004 name="input.a.page1.rtel004"
            LET g_rtel_d[l_ac].rtel004_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel004_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_rtel_d[l_ac].rtel004 != g_rtel_d_t.rtel004 OR cl_null(g_rtel_d_t.rtel004) )) THEN   #150427-00012#6 20150707 add by beckxie
                  CALL artt409_chk_unit(g_rtel_d[l_ac].rtel004) 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtel_d[l_ac].rtel004
                     CASE g_errno
                        WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'aooi250'
                           LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                           LET g_errparam.exeprog = 'aooi250'
                     END CASE
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rtel_d[l_ac].rtel004 = g_rtel_d_t.rtel004
                     CALL artt409_rtel004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL artt409_rtel004_ref()            
            
            



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel004
            #add-point:BEFORE FIELD rtel004 name="input.b.page1.rtel004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel004
            #add-point:ON CHANGE rtel004 name="input.g.page1.rtel004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel005
            
            #add-point:AFTER FIELD rtel005 name="input.a.page1.rtel005"
            LET g_rtel_d[l_ac].rtel005_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel005_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_rtel_d[l_ac].rtel005 != g_rtel_d_t.rtel005 OR cl_null(g_rtel_d_t.rtel005))) THEN  
                  IF NOT s_azzi650_chk_exist('2000',g_rtel_d[l_ac].rtel005) THEN
                     LET g_rtel_d[l_ac].rtel005 = g_rtel_d_t.rtel005
                     CALL s_desc_get_acc_desc('2000',g_rtel_d[l_ac].rtel005) RETURNING g_rtel_d[l_ac].rtel005_desc
                     DISPLAY BY NAME g_rtel_d[l_ac].rtel005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2000',g_rtel_d[l_ac].rtel005) RETURNING g_rtel_d[l_ac].rtel005_desc
            DISPLAY BY NAME g_rtel_d[l_ac].rtel005_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel005
            #add-point:BEFORE FIELD rtel005 name="input.b.page1.rtel005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel005
            #add-point:ON CHANGE rtel005 name="input.g.page1.rtel005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel006
            #add-point:BEFORE FIELD rtel006 name="input.b.page1.rtel006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel006
            
            #add-point:AFTER FIELD rtel006 name="input.a.page1.rtel006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel006
            #add-point:ON CHANGE rtel006 name="input.g.page1.rtel006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel007
            
            #add-point:AFTER FIELD rtel007 name="input.a.page1.rtel007"
            LET g_rtel_d[l_ac].rtel007_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel007_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel007) THEN
               IF (g_rtel_d[l_ac].rtel007 != g_rtel_d_o.rtel007) OR cl_null(g_rtel_d_o.rtel007) THEN   
                  CALL artt409_rtel007_chk() 
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtel_d[l_ac].rtel007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_rtel_d[l_ac].rtel007 = g_rtel_d_o.rtel007
                     CALL artt409_rtel007_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtel_d_o.rtel007 = g_rtel_d[l_ac].rtel007    
            CALL artt409_rtel007_ref()            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel007
            #add-point:BEFORE FIELD rtel007 name="input.b.page1.rtel007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel007
            #add-point:ON CHANGE rtel007 name="input.g.page1.rtel007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel008
            
            #add-point:AFTER FIELD rtel008 name="input.a.page1.rtel008"
            LET g_rtel_d[l_ac].rtel008_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel008_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_rtel_d[l_ac].rtel008 != g_rtel_d_t.rtel008 OR cl_null(g_rtel_d_t.rtel008))) THEN  
                  IF NOT s_azzi650_chk_exist('2002',g_rtel_d[l_ac].rtel008) THEN
                     LET g_rtel_d[l_ac].rtel008 = g_rtel_d_t.rtel008
                     CALL s_desc_get_acc_desc('2002',g_rtel_d[l_ac].rtel008) RETURNING g_rtel_d[l_ac].rtel008_desc
                     DISPLAY BY NAME g_rtel_d[l_ac].rtel008_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2002',g_rtel_d[l_ac].rtel008) RETURNING g_rtel_d[l_ac].rtel008_desc
            DISPLAY BY NAME g_rtel_d[l_ac].rtel008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel008
            #add-point:BEFORE FIELD rtel008 name="input.b.page1.rtel008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel008
            #add-point:ON CHANGE rtel008 name="input.g.page1.rtel008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel009
            
            #add-point:AFTER FIELD rtel009 name="input.a.page1.rtel009"
            LET g_rtel_d[l_ac].rtel009_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel009_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel009) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_rtel_d[l_ac].rtel009 != g_rtel_d_t.rtel009 OR cl_null(g_rtel_d_t.rtel009))) THEN  
                  IF NOT s_azzi650_chk_exist('2003',g_rtel_d[l_ac].rtel009) THEN
                     LET g_rtel_d[l_ac].rtel009 = g_rtel_d_t.rtel009
                     CALL s_desc_get_acc_desc('2003',g_rtel_d[l_ac].rtel009) RETURNING g_rtel_d[l_ac].rtel009_desc
                     DISPLAY BY NAME g_rtel_d[l_ac].rtel009_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2003',g_rtel_d[l_ac].rtel009) RETURNING g_rtel_d[l_ac].rtel009_desc
            DISPLAY BY NAME g_rtel_d[l_ac].rtel009_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel009
            #add-point:BEFORE FIELD rtel009 name="input.b.page1.rtel009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel009
            #add-point:ON CHANGE rtel009 name="input.g.page1.rtel009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel010
            
            #add-point:AFTER FIELD rtel010 name="input.a.page1.rtel010"
            LET g_rtel_d[l_ac].rtel010_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel010_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel010) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_rtel_d[l_ac].rtel010 != g_rtel_d_t.rtel010 OR cl_null(g_rtel_d_t.rtel010))) THEN  
                  IF NOT s_azzi650_chk_exist('2004',g_rtel_d[l_ac].rtel010) THEN
                     LET g_rtel_d[l_ac].rtel010 = g_rtel_d_t.rtel010
                     CALL s_desc_get_acc_desc('2004',g_rtel_d[l_ac].rtel010) RETURNING g_rtel_d[l_ac].rtel010_desc
                     DISPLAY BY NAME g_rtel_d[l_ac].rtel010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2004',g_rtel_d[l_ac].rtel010) RETURNING g_rtel_d[l_ac].rtel010_desc
            DISPLAY BY NAME g_rtel_d[l_ac].rtel010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel010
            #add-point:BEFORE FIELD rtel010 name="input.b.page1.rtel010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel010
            #add-point:ON CHANGE rtel010 name="input.g.page1.rtel010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel011
            
            #add-point:AFTER FIELD rtel011 name="input.a.page1.rtel011"
            LET g_rtel_d[l_ac].rtel011_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel011_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel011) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_rtel_d[l_ac].rtel011 != g_rtel_d_t.rtel011 OR cl_null(g_rtel_d_t.rtel011))) THEN  
                  IF NOT s_azzi650_chk_exist('2005',g_rtel_d[l_ac].rtel011) THEN
                     LET g_rtel_d[l_ac].rtel011 = g_rtel_d_t.rtel011
                     CALL s_desc_get_acc_desc('2005',g_rtel_d[l_ac].rtel011) RETURNING g_rtel_d[l_ac].rtel011_desc
                     DISPLAY BY NAME g_rtel_d[l_ac].rtel011_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_acc_desc('2005',g_rtel_d[l_ac].rtel011) RETURNING g_rtel_d[l_ac].rtel011_desc
            DISPLAY BY NAME g_rtel_d[l_ac].rtel011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel011
            #add-point:BEFORE FIELD rtel011 name="input.b.page1.rtel011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel011
            #add-point:ON CHANGE rtel011 name="input.g.page1.rtel011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel012
            #add-point:BEFORE FIELD rtel012 name="input.b.page1.rtel012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel012
            
            #add-point:AFTER FIELD rtel012 name="input.a.page1.rtel012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel012
            #add-point:ON CHANGE rtel012 name="input.g.page1.rtel012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel018
            #add-point:BEFORE FIELD rtel018 name="input.b.page1.rtel018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel018
            
            #add-point:AFTER FIELD rtel018 name="input.a.page1.rtel018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel018
            #add-point:ON CHANGE rtel018 name="input.g.page1.rtel018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel020
            #add-point:BEFORE FIELD rtel020 name="input.b.page1.rtel020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel020
            
            #add-point:AFTER FIELD rtel020 name="input.a.page1.rtel020"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel020
            #add-point:ON CHANGE rtel020 name="input.g.page1.rtel020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel021
            #add-point:BEFORE FIELD rtel021 name="input.b.page1.rtel021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel021
            
            #add-point:AFTER FIELD rtel021 name="input.a.page1.rtel021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel021
            #add-point:ON CHANGE rtel021 name="input.g.page1.rtel021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel022
            #add-point:BEFORE FIELD rtel022 name="input.b.page1.rtel022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel022
            
            #add-point:AFTER FIELD rtel022 name="input.a.page1.rtel022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel022
            #add-point:ON CHANGE rtel022 name="input.g.page1.rtel022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel013
            #add-point:BEFORE FIELD rtel013 name="input.b.page1.rtel013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel013
            
            #add-point:AFTER FIELD rtel013 name="input.a.page1.rtel013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel013
            #add-point:ON CHANGE rtel013 name="input.g.page1.rtel013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel014
            #add-point:BEFORE FIELD rtel014 name="input.b.page1.rtel014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel014
            
            #add-point:AFTER FIELD rtel014 name="input.a.page1.rtel014"
            IF NOT cl_null(g_rtel_d[l_ac].rtel014) AND cl_null(g_rtel_d[l_ac].rtel015) AND cl_null(g_rtel_d[l_ac].rtel016) AND cl_null(g_rtel_d[l_ac].rtel017) THEN
               LET g_rtel_d[l_ac].rtel015 = g_rtel_d[l_ac].rtel014
               LET g_rtel_d[l_ac].rtel016 = g_rtel_d[l_ac].rtel014
               LET g_rtel_d[l_ac].rtel017 = g_rtel_d[l_ac].rtel014
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel014
            #add-point:ON CHANGE rtel014 name="input.g.page1.rtel014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel015
            #add-point:BEFORE FIELD rtel015 name="input.b.page1.rtel015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel015
            
            #add-point:AFTER FIELD rtel015 name="input.a.page1.rtel015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel015
            #add-point:ON CHANGE rtel015 name="input.g.page1.rtel015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel016
            #add-point:BEFORE FIELD rtel016 name="input.b.page1.rtel016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel016
            
            #add-point:AFTER FIELD rtel016 name="input.a.page1.rtel016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel016
            #add-point:ON CHANGE rtel016 name="input.g.page1.rtel016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel017
            #add-point:BEFORE FIELD rtel017 name="input.b.page1.rtel017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel017
            
            #add-point:AFTER FIELD rtel017 name="input.a.page1.rtel017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel017
            #add-point:ON CHANGE rtel017 name="input.g.page1.rtel017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtel019
            
            #add-point:AFTER FIELD rtel019 name="input.a.page1.rtel019"
            #160513-00037#3 160517 by lori add---(S)
            LET g_rtel_d[l_ac].rtel019_desc = ' '
            DISPLAY BY NAME g_rtel_d[l_ac].rtel019_desc
            IF NOT cl_null(g_rtel_d[l_ac].rtel019) THEN
               IF g_rtel_d[l_ac].rtel019 != g_rtel_d_o.rtel019 OR g_rtel_d_o.rtel019 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_rtek_m.rteksite
                  LET g_chkparam.arg2 = g_rtel_d[l_ac].rtel019
                  LET g_chkparam.arg3 = 'N'
                  
                  IF NOT cl_chk_exist("v_inaa001_6") THEN
                     LET g_rtel_d[l_ac].rtel019 = g_rtel_d_o.rtel019
                     LET g_rtel_d[l_ac].rtel019_desc = s_desc_get_stock_desc(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel019)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_rtel_d[l_ac].rtel019_desc = s_desc_get_stock_desc(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel019)
            
            LET g_rtel_d_o.rtel019 = g_rtel_d[l_ac].rtel019
            #160513-00037#3 160517 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtel019
            #add-point:BEFORE FIELD rtel019 name="input.b.page1.rtel019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtel019
            #add-point:ON CHANGE rtel019 name="input.g.page1.rtel019"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtelacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtelacti
            #add-point:ON ACTION controlp INFIELD rtelacti name="input.c.page1.rtelacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtelseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtelseq
            #add-point:ON ACTION controlp INFIELD rtelseq name="input.c.page1.rtelseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel001
            #add-point:ON ACTION controlp INFIELD rtel001 name="input.c.page1.rtel001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel023
            #add-point:ON ACTION controlp INFIELD rtel023 name="input.c.page1.rtel023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel002
            #add-point:ON ACTION controlp INFIELD rtel002 name="input.c.page1.rtel002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF g_rtek_m.rtek004 = 'N' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_rtel_d[l_ac].rtel002             #給予default值
               
               #給予arg
               LET g_qryparam.arg1 = g_rtek_m.rteksite #s
               
               
               CALL q_imay003_11()                                #呼叫開窗
               
               LET g_rtel_d[l_ac].rtel002 = g_qryparam.return1              
               
               DISPLAY g_rtel_d[l_ac].rtel002 TO rtel002              #
               
               NEXT FIELD rtel002                          #返回原欄位
            END IF 



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel003
            #add-point:ON ACTION controlp INFIELD rtel003 name="input.c.page1.rtel003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            IF g_rtek_m.rtek004 = 'N' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_rtel_d[l_ac].rtel003             #給予default值 
               CALL q_imaa001()                                #呼叫開窗
               
               LET g_rtel_d[l_ac].rtel003 = g_qryparam.return1              
               
               DISPLAY g_rtel_d[l_ac].rtel003 TO rtel003              #
               
               NEXT FIELD rtel003                          #返回原欄位
            END IF



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtell002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtell002
            #add-point:ON ACTION controlp INFIELD rtell002 name="input.c.page1.rtell002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtell003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtell003
            #add-point:ON ACTION controlp INFIELD rtell003 name="input.c.page1.rtell003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtell004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtell004
            #add-point:ON ACTION controlp INFIELD rtell004 name="input.c.page1.rtell004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel004
            #add-point:ON ACTION controlp INFIELD rtel004 name="input.c.page1.rtel004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel004 = g_qryparam.return1              

            DISPLAY g_rtel_d[l_ac].rtel004 TO rtel004              #

            NEXT FIELD rtel004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel005
            #add-point:ON ACTION controlp INFIELD rtel005 name="input.c.page1.rtel005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel005             #給予default值
            LET g_qryparam.default2 = "" #g_rtel_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2000" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel005 = g_qryparam.return1              
            DISPLAY g_rtel_d[l_ac].rtel005 TO rtel005              
            CALL s_desc_get_acc_desc('2000',g_rtel_d[l_ac].rtel005) RETURNING g_rtel_d[l_ac].rtel005_desc     #產地分類            
            NEXT FIELD rtel005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel006
            #add-point:ON ACTION controlp INFIELD rtel006 name="input.c.page1.rtel006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel007
            #add-point:ON ACTION controlp INFIELD rtel007 name="input.c.page1.rtel007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " (( EXISTS (SELECT 1 FROM stjk_t,rtaw_t WHERE rtaxent = stjkent AND rtawent = stjkent AND rtaw001 = stjk002 AND rtaw002 = rtax001 AND stjk001 = '",g_rtek_m.rtek008,"')) OR
                                      ( EXISTS (SELECT 1 FROM stic_t,rtaw_t WHERE rtaxent = sticent AND rtawent = sticent AND rtaw001 = stic014 AND rtaw002 = rtax001 AND sticdocno = '",g_rtek_m.rtek008,"')))" #s
                                    
            
            CALL q_rtax001()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel007 = g_qryparam.return1              

            DISPLAY g_rtel_d[l_ac].rtel007 TO rtel007              #
            CALL s_desc_get_rtaxl003_desc(g_rtel_d[l_ac].rtel007) RETURNING g_rtel_d[l_ac].rtel007_desc
            NEXT FIELD rtel007                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel008
            #add-point:ON ACTION controlp INFIELD rtel008 name="input.c.page1.rtel008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel008             #給予default值
            LET g_qryparam.default2 = "" #g_rtel_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2002" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel008 = g_qryparam.return1              
            DISPLAY g_rtel_d[l_ac].rtel008 TO rtel008              
            CALL s_desc_get_acc_desc('2002',g_rtel_d[l_ac].rtel008) RETURNING g_rtel_d[l_ac].rtel008_desc     #品牌            
            NEXT FIELD rtel008                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel009
            #add-point:ON ACTION controlp INFIELD rtel009 name="input.c.page1.rtel009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel009             #給予default值
            LET g_qryparam.default2 = "" #g_rtel_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2003" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel009 = g_qryparam.return1              
            DISPLAY g_rtel_d[l_ac].rtel009 TO rtel009              
            CALL s_desc_get_acc_desc('2003',g_rtel_d[l_ac].rtel009) RETURNING g_rtel_d[l_ac].rtel009_desc     #系列
            NEXT FIELD rtel009                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel010
            #add-point:ON ACTION controlp INFIELD rtel010 name="input.c.page1.rtel010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel010             #給予default值
            LET g_qryparam.default2 = "" #g_rtel_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2004" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel010 = g_qryparam.return1               
            DISPLAY g_rtel_d[l_ac].rtel010 TO rtel010              
            CALL s_desc_get_acc_desc('2004',g_rtel_d[l_ac].rtel010) RETURNING g_rtel_d[l_ac].rtel010_desc     #類型
            NEXT FIELD rtel010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel011
            #add-point:ON ACTION controlp INFIELD rtel011 name="input.c.page1.rtel011"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel011             #給予default值
            LET g_qryparam.default2 = "" #g_rtel_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2005" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_rtel_d[l_ac].rtel011 = g_qryparam.return1              
            DISPLAY g_rtel_d[l_ac].rtel011 TO rtel011              
            CALL s_desc_get_acc_desc('2005',g_rtel_d[l_ac].rtel011) RETURNING g_rtel_d[l_ac].rtel011_desc     #功能
            NEXT FIELD rtel011                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel012
            #add-point:ON ACTION controlp INFIELD rtel012 name="input.c.page1.rtel012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel018
            #add-point:ON ACTION controlp INFIELD rtel018 name="input.c.page1.rtel018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel020
            #add-point:ON ACTION controlp INFIELD rtel020 name="input.c.page1.rtel020"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段

            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel021
            #add-point:ON ACTION controlp INFIELD rtel021 name="input.c.page1.rtel021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel022
            #add-point:ON ACTION controlp INFIELD rtel022 name="input.c.page1.rtel022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel013
            #add-point:ON ACTION controlp INFIELD rtel013 name="input.c.page1.rtel013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel014
            #add-point:ON ACTION controlp INFIELD rtel014 name="input.c.page1.rtel014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel015
            #add-point:ON ACTION controlp INFIELD rtel015 name="input.c.page1.rtel015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel016
            #add-point:ON ACTION controlp INFIELD rtel016 name="input.c.page1.rtel016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel017
            #add-point:ON ACTION controlp INFIELD rtel017 name="input.c.page1.rtel017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtel019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtel019
            #add-point:ON ACTION controlp INFIELD rtel019 name="input.c.page1.rtel019"
            #160513-00037#3 160517 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.where = " inaa010 = 'N'"
            LET g_qryparam.default1 = g_rtel_d[l_ac].rtel019 
            LET g_qryparam.arg1 = g_rtek_m.rteksite
            
            CALL q_inaa001_6()    
            
            LET g_rtel_d[l_ac].rtel019 = g_qryparam.return1              
            LET g_rtel_d[l_ac].rtel019_desc = s_desc_get_stock_desc(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel019)
            DISPLAY BY NAME g_rtel_d[l_ac].rtel019,g_rtel_d[l_ac].rtel019_desc
            
            #NEXT FIELD rtel019_desc  #mark by geza 20160613
            NEXT FIELD rtel019  #add by geza 20160613
            #160513-00037#3 160517 by lori add---(E)
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtel_d[l_ac].* = g_rtel_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt409_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtel_d[l_ac].rtelseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtel_d[l_ac].* = g_rtel_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt409_rtel_t_mask_restore('restore_mask_o')
      
               UPDATE rtel_t SET (rteldocno,rtelacti,rtelseq,rtel001,rtel023,rtel002,rtel003,rtel004, 
                   rtel005,rtel006,rtel007,rtel008,rtel009,rtel010,rtel011,rtel012,rtel018,rtel020,rtel021, 
                   rtel022,rtel013,rtel014,rtel015,rtel016,rtel017,rtel019) = (g_rtek_m.rtekdocno,g_rtel_d[l_ac].rtelacti, 
                   g_rtel_d[l_ac].rtelseq,g_rtel_d[l_ac].rtel001,g_rtel_d[l_ac].rtel023,g_rtel_d[l_ac].rtel002, 
                   g_rtel_d[l_ac].rtel003,g_rtel_d[l_ac].rtel004,g_rtel_d[l_ac].rtel005,g_rtel_d[l_ac].rtel006, 
                   g_rtel_d[l_ac].rtel007,g_rtel_d[l_ac].rtel008,g_rtel_d[l_ac].rtel009,g_rtel_d[l_ac].rtel010, 
                   g_rtel_d[l_ac].rtel011,g_rtel_d[l_ac].rtel012,g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel020, 
                   g_rtel_d[l_ac].rtel021,g_rtel_d[l_ac].rtel022,g_rtel_d[l_ac].rtel013,g_rtel_d[l_ac].rtel014, 
                   g_rtel_d[l_ac].rtel015,g_rtel_d[l_ac].rtel016,g_rtel_d[l_ac].rtel017,g_rtel_d[l_ac].rtel019) 
 
                WHERE rtelent = g_enterprise AND rteldocno = g_rtek_m.rtekdocno 
 
                  AND rtelseq = g_rtel_d_t.rtelseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtel_d[l_ac].* = g_rtel_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtel_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtel_d[l_ac].* = g_rtel_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtel_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_rtek_m.rtekdocno = g_detail_multi_table_t.rtelldocno AND
         g_rtel_d[l_ac].rtelseq = g_detail_multi_table_t.rtellseq AND
         g_rtel_d[l_ac].rtell002 = g_detail_multi_table_t.rtell002 AND
         g_rtel_d[l_ac].rtell003 = g_detail_multi_table_t.rtell003 AND
         g_rtel_d[l_ac].rtell004 = g_detail_multi_table_t.rtell004 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'rtellent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_rtek_m.rtekdocno
            LET l_field_keys[02] = 'rtelldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.rtelldocno
            LET l_var_keys[03] = g_rtel_d[l_ac].rtelseq
            LET l_field_keys[03] = 'rtellseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.rtellseq
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'rtell001'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.rtell001
            LET l_vars[01] = g_rtel_d[l_ac].rtell002
            LET l_fields[01] = 'rtell002'
            LET l_vars[02] = g_rtel_d[l_ac].rtell003
            LET l_fields[02] = 'rtell003'
            LET l_vars[03] = g_rtel_d[l_ac].rtell004
            LET l_fields[03] = 'rtell004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'rtell_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtek_m.rtekdocno
               LET gs_keys_bak[1] = g_rtekdocno_t
               LET gs_keys[2] = g_rtel_d[g_detail_idx].rtelseq
               LET gs_keys_bak[2] = g_rtel_d_t.rtelseq
               CALL artt409_update_b('rtel_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt409_rtel_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtel_d[g_detail_idx].rtelseq = g_rtel_d_t.rtelseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtek_m.rtekdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtel_d_t.rtelseq
 
                  CALL artt409_key_update_b(gs_keys,'rtel_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtek_m),util.JSON.stringify(g_rtel_d_t)
               LET g_log2 = util.JSON.stringify(g_rtek_m),util.JSON.stringify(g_rtel_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL artt409_unlock_b("rtel_t","'1'")
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
               LET g_rtel_d[li_reproduce_target].* = g_rtel_d[li_reproduce].*
 
               LET g_rtel_d[li_reproduce_target].rtelseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtel_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtel_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="artt409.input.other" >}
      
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
            NEXT FIELD rteksite
            #end add-point  
            NEXT FIELD rtekdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtelacti
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
      ON ACTION yjsp
         IF cl_null(g_rtek_m.rtekdocno) OR  g_rtek_m.rtek001='U' THEN             
         ELSE
            CALL artt409_02(g_rtek_m.rtekdocno)
            CALL artt409_show()
            #let p_cmd='u'
            #let l_cmd='u'
            LET INT_FLAG = 0
            EXIT DIALOG            
         END IF
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
 
{<section id="artt409.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt409_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt409_b_fill() #單身填充
      CALL artt409_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt409_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_rtek_m_mask_o.* =  g_rtek_m.*
   CALL artt409_rtek_t_mask()
   LET g_rtek_m_mask_n.* =  g_rtek_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001, 
       g_rtek_m.rtek002,g_rtek_m.rtek002_desc,g_rtek_m.rtek003,g_rtek_m.rtek003_desc,g_rtek_m.rtek008, 
       g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek005_desc,g_rtek_m.rtek006,g_rtek_m.rtek006_desc, 
       g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtid_desc,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdp_desc, 
       g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekmoddt,g_rtek_m.rtekcnfid, 
       g_rtek_m.rtekcnfid_desc,g_rtek_m.rtekcnfdt,g_rtek_m.rtekpstid_desc
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtek_m.rtekstus 
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
   FOR l_ac = 1 TO g_rtel_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      IF g_rtek_m.rtek004 = 'Y' THEN
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_rtek_m.rtekdocno
         LET g_ref_fields[2] = g_rtel_d[l_ac].rtelseq
         CALL ap_ref_array2(g_ref_fields," SELECT rtell002,rtell003,rtell004 FROM rtell_t WHERE rtellent = '"
             ||g_enterprise||"' AND rtelldocno = ? AND rtellseq = ? AND rtell001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_rtel_d[l_ac].rtell002 = g_rtn_fields[1]
         LET g_rtel_d[l_ac].rtell003 = g_rtn_fields[2]
         LET g_rtel_d[l_ac].rtell004 = g_rtn_fields[3]
         DISPLAY BY NAME g_rtel_d[l_ac].rtell002,g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004 
      ELSE
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_rtel_d[l_ac].rtel003
         CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004,imaal005 FROM imaal_t WHERE imaalent = '"
             ||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_rtel_d[l_ac].rtell002 = g_rtn_fields[1]
         LET g_rtel_d[l_ac].rtell003 = g_rtn_fields[2]
         LET g_rtel_d[l_ac].rtell004 = g_rtn_fields[3]
         DISPLAY BY NAME g_rtel_d[l_ac].rtell002,g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004      
      END IF
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt409_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt409_detail_show()
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
 
{<section id="artt409.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt409_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtek_t.rtekdocno 
   DEFINE l_oldno     LIKE rtek_t.rtekdocno 
 
   DEFINE l_master    RECORD LIKE rtek_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtel_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_insert      LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
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
   
   IF g_rtek_m.rtekdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
    
   LET g_rtek_m.rtekdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtek_m.rtekownid = g_user
      LET g_rtek_m.rtekowndp = g_dept
      LET g_rtek_m.rtekcrtid = g_user
      LET g_rtek_m.rtekcrtdp = g_dept 
      LET g_rtek_m.rtekcrtdt = cl_get_current()
      LET g_rtek_m.rtekmodid = g_user
      LET g_rtek_m.rtekmoddt = cl_get_current()
      LET g_rtek_m.rtekstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #單據日期  
   LET g_rtek_m.rtekdocdt = g_today   
   
   LET g_site_flag = FALSE
   CALL s_aooi500_default(g_prog,'rteksite',g_rtek_m.rteksite)
      RETURNING l_insert,g_rtek_m.rteksite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_rtek_m.rteksite) RETURNING g_rtek_m.rteksite_desc
   DISPLAY BY NAME g_rtek_m.rteksite_desc 
      
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_rtek_m.rteksite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_rtek_m.rtekdocno = r_doctype
   
   #業務員
   LET g_rtek_m.rtek005 = g_user          
   CALL s_desc_get_person_desc(g_rtek_m.rtek005) RETURNING g_rtek_m.rtek005_desc
   DISPLAY BY NAME g_rtek_m.rtek005_desc    
  
   #業務部門
   LET g_rtek_m.rtek006 = g_dept
   CALL s_desc_get_department_desc(g_rtek_m.rtek006) RETURNING g_rtek_m.rtek006_desc
   DISPLAY BY NAME g_rtek_m.rtek006_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtek_m.rtekstus 
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
   
   
   CALL artt409_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtek_m.* TO NULL
      INITIALIZE g_rtel_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt409_show()
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
   CALL artt409_set_act_visible()   
   CALL artt409_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtekent = " ||g_enterprise|| " AND",
                      " rtekdocno = '", g_rtek_m.rtekdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt409_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt409_idx_chk()
   
   LET g_data_owner = g_rtek_m.rtekownid      
   LET g_data_dept  = g_rtek_m.rtekowndp
   
   #功能已完成,通報訊息中心
   CALL artt409_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt409_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtel_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_rteksite   LIKE rtek_t.rteksite   #160513-00037#3 160517 by lori add
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt409_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtel_t
    WHERE rtelent = g_enterprise AND rteldocno = g_rtekdocno_t
 
    INTO TEMP artt409_detail
 
   #將key修正為調整後   
   UPDATE artt409_detail 
      #更新key欄位
      SET rteldocno = g_rtek_m.rtekdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #160513-00037#3 160517 by lori add---(S)
   LET l_rteksite = ''
   SELECT rteksite INTO l_rteksite
     FROM rtek_t
    WHERE rtekent = g_enterprise
      AND rteksite = g_rtekdocno_t     
      
   IF l_rteksite <> g_rtek_m.rteksite THEN
      CALL artt409_rtel019_def()
      
      UPDATE artt409_detail 
         SET rtel019 = g_ooef127
   END IF   
   #160513-00037#3 160517 by lori add---(E)
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtel_t SELECT * FROM artt409_detail
   
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
   DROP TABLE artt409_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE artt409_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM rtell_t 
    WHERE rtellent = g_enterprise AND rtelldocno = g_rtekdocno_t
 
     INTO TEMP artt409_detail_lang
 
   #將key修正為調整後   
   UPDATE artt409_detail_lang 
      #更新key欄位
      SET rtelldocno = g_rtek_m.rtekdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO rtell_t SELECT * FROM artt409_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt409_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
   
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt409_delete()
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
   
   IF g_rtek_m.rtekdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artt409_cl USING g_enterprise,g_rtek_m.rtekdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt409_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt409_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
       g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
       g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
       g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
       g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid_desc, 
       g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT artt409_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtek_m_mask_o.* =  g_rtek_m.*
   CALL artt409_rtek_t_mask()
   LET g_rtek_m_mask_n.* =  g_rtek_m.*
   
   CALL artt409_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt409_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtekdocno_t = g_rtek_m.rtekdocno
 
 
      DELETE FROM rtek_t
       WHERE rtekent = g_enterprise AND rtekdocno = g_rtek_m.rtekdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtek_m.rtekdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_rtek_m.rtekdocno,g_rtek_m.rtekdocdt) THEN 
         CALL s_transaction_end('N','0') RETURN 
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rtel_t
       WHERE rtelent = g_enterprise AND rteldocno = g_rtek_m.rtekdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtel_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtek_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt409_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtel_d.clear() 
 
     
      CALL artt409_ui_browser_refresh()  
      #CALL artt409_ui_headershow()  
      #CALL artt409_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'rtellent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'rtelldocno'
         LET l_var_keys_bak[02] = g_rtek_m.rtekdocno
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'rtell_t')
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt409_browser_fill("")
         CALL artt409_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt409_cl
 
   #功能已完成,通報訊息中心
   CALL artt409_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt409.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt409_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtel_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF artt409_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtelacti,rtelseq,rtel001,rtel023,rtel002,rtel003,rtel004,rtel005, 
             rtel006,rtel007,rtel008,rtel009,rtel010,rtel011,rtel012,rtel018,rtel020,rtel021,rtel022, 
             rtel013,rtel014,rtel015,rtel016,rtel017,rtel019 ,t1.oocal003 ,t2.oocql004 ,t3.rtaxl003 , 
             t4.oocql004 ,t5.oocql004 ,t6.oocql004 ,t7.oocql004 ,t8.inayl003 FROM rtel_t",   
                     " INNER JOIN rtek_t ON rtekent = " ||g_enterprise|| " AND rtekdocno = rteldocno ",
 
                     #" LEFT JOIN rtell_t ON rtellent = "||g_enterprise||" AND rtekdocno = rtelldocno AND rtelseq = rtellseq AND rtell001 = '",g_dlang,"'",
                     
                     " LEFT JOIN rtell_t ON rtellent = "||g_enterprise||" AND rtekdocno = rtelldocno AND rtelseq = rtellseq AND rtell001 = '",g_dlang,"'",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocal_t t1 ON t1.oocalent="||g_enterprise||" AND t1.oocal001=rtel004 AND t1.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2000' AND t2.oocql002=rtel005 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=rtel007 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2002' AND t4.oocql002=rtel008 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2003' AND t5.oocql002=rtel009 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2004' AND t6.oocql002=rtel010 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2005' AND t7.oocql002=rtel011 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=rtel019 AND t8.inayl002='"||g_dlang||"' ",
 
                     " WHERE rtelent=? AND rteldocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtel_t.rtelseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt409_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt409_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtek_m.rtekdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtek_m.rtekdocno INTO g_rtel_d[l_ac].rtelacti,g_rtel_d[l_ac].rtelseq, 
          g_rtel_d[l_ac].rtel001,g_rtel_d[l_ac].rtel023,g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtel003, 
          g_rtel_d[l_ac].rtel004,g_rtel_d[l_ac].rtel005,g_rtel_d[l_ac].rtel006,g_rtel_d[l_ac].rtel007, 
          g_rtel_d[l_ac].rtel008,g_rtel_d[l_ac].rtel009,g_rtel_d[l_ac].rtel010,g_rtel_d[l_ac].rtel011, 
          g_rtel_d[l_ac].rtel012,g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel020,g_rtel_d[l_ac].rtel021, 
          g_rtel_d[l_ac].rtel022,g_rtel_d[l_ac].rtel013,g_rtel_d[l_ac].rtel014,g_rtel_d[l_ac].rtel015, 
          g_rtel_d[l_ac].rtel016,g_rtel_d[l_ac].rtel017,g_rtel_d[l_ac].rtel019,g_rtel_d[l_ac].rtel004_desc, 
          g_rtel_d[l_ac].rtel005_desc,g_rtel_d[l_ac].rtel007_desc,g_rtel_d[l_ac].rtel008_desc,g_rtel_d[l_ac].rtel009_desc, 
          g_rtel_d[l_ac].rtel010_desc,g_rtel_d[l_ac].rtel011_desc,g_rtel_d[l_ac].rtel019_desc   #(ver:78) 
 
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
   
   CALL g_rtel_d.deleteElement(g_rtel_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt409_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtel_d.getLength()
      LET g_rtel_d_mask_o[l_ac].* =  g_rtel_d[l_ac].*
      CALL artt409_rtel_t_mask()
      LET g_rtel_d_mask_n[l_ac].* =  g_rtel_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt409_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rtel_t
       WHERE rtelent = g_enterprise AND
         rteldocno = ps_keys_bak[1] AND rtelseq = ps_keys_bak[2]
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
         CALL g_rtel_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt409_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rtel_t
                  (rtelent,
                   rteldocno,
                   rtelseq
                   ,rtelacti,rtel001,rtel023,rtel002,rtel003,rtel004,rtel005,rtel006,rtel007,rtel008,rtel009,rtel010,rtel011,rtel012,rtel018,rtel020,rtel021,rtel022,rtel013,rtel014,rtel015,rtel016,rtel017,rtel019) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtel_d[g_detail_idx].rtelacti,g_rtel_d[g_detail_idx].rtel001,g_rtel_d[g_detail_idx].rtel023, 
                       g_rtel_d[g_detail_idx].rtel002,g_rtel_d[g_detail_idx].rtel003,g_rtel_d[g_detail_idx].rtel004, 
                       g_rtel_d[g_detail_idx].rtel005,g_rtel_d[g_detail_idx].rtel006,g_rtel_d[g_detail_idx].rtel007, 
                       g_rtel_d[g_detail_idx].rtel008,g_rtel_d[g_detail_idx].rtel009,g_rtel_d[g_detail_idx].rtel010, 
                       g_rtel_d[g_detail_idx].rtel011,g_rtel_d[g_detail_idx].rtel012,g_rtel_d[g_detail_idx].rtel018, 
                       g_rtel_d[g_detail_idx].rtel020,g_rtel_d[g_detail_idx].rtel021,g_rtel_d[g_detail_idx].rtel022, 
                       g_rtel_d[g_detail_idx].rtel013,g_rtel_d[g_detail_idx].rtel014,g_rtel_d[g_detail_idx].rtel015, 
                       g_rtel_d[g_detail_idx].rtel016,g_rtel_d[g_detail_idx].rtel017,g_rtel_d[g_detail_idx].rtel019) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtel_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtel_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt409_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtel_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt409_rtel_t_mask_restore('restore_mask_o')
               
      UPDATE rtel_t 
         SET (rteldocno,
              rtelseq
              ,rtelacti,rtel001,rtel023,rtel002,rtel003,rtel004,rtel005,rtel006,rtel007,rtel008,rtel009,rtel010,rtel011,rtel012,rtel018,rtel020,rtel021,rtel022,rtel013,rtel014,rtel015,rtel016,rtel017,rtel019) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtel_d[g_detail_idx].rtelacti,g_rtel_d[g_detail_idx].rtel001,g_rtel_d[g_detail_idx].rtel023, 
                  g_rtel_d[g_detail_idx].rtel002,g_rtel_d[g_detail_idx].rtel003,g_rtel_d[g_detail_idx].rtel004, 
                  g_rtel_d[g_detail_idx].rtel005,g_rtel_d[g_detail_idx].rtel006,g_rtel_d[g_detail_idx].rtel007, 
                  g_rtel_d[g_detail_idx].rtel008,g_rtel_d[g_detail_idx].rtel009,g_rtel_d[g_detail_idx].rtel010, 
                  g_rtel_d[g_detail_idx].rtel011,g_rtel_d[g_detail_idx].rtel012,g_rtel_d[g_detail_idx].rtel018, 
                  g_rtel_d[g_detail_idx].rtel020,g_rtel_d[g_detail_idx].rtel021,g_rtel_d[g_detail_idx].rtel022, 
                  g_rtel_d[g_detail_idx].rtel013,g_rtel_d[g_detail_idx].rtel014,g_rtel_d[g_detail_idx].rtel015, 
                  g_rtel_d[g_detail_idx].rtel016,g_rtel_d[g_detail_idx].rtel017,g_rtel_d[g_detail_idx].rtel019)  
 
         WHERE rtelent = g_enterprise AND rteldocno = ps_keys_bak[1] AND rtelseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtel_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtel_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt409_rtel_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'rtellent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'rtelldocno'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'rtellseq'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'rtell001'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'rtell_t')
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt409_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="artt409.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt409_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="artt409.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt409_lock_b(ps_table,ps_page)
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
   #CALL artt409_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtel_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt409_bcl USING g_enterprise,
                                       g_rtek_m.rtekdocno,g_rtel_d[g_detail_idx].rtelseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt409_bcl:",SQLERRMESSAGE 
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
 
{<section id="artt409.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt409_unlock_b(ps_table,ps_page)
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
      CLOSE artt409_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt409_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtekdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtekdocno",TRUE)
      CALL cl_set_comp_entry("rtekdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("rteksite",TRUE)   #161024-00025#9   2016/10/27  by 08742 add
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("rtek004",TRUE)
   CALL cl_set_comp_entry("rtek002",TRUE) #add by geza 20160613
   CALL cl_set_comp_entry("rtek003",TRUE) #add by geza 20160613
   CALL cl_set_comp_entry("rtek008",TRUE) #add by geza 20160613
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt409_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE  l_cnt                 LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtekdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtekdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtekdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_rtek_m.rtek001 = 'U' THEN
      CALL cl_set_comp_entry("rtek004",FALSE)
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'rteksite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rteksite",FALSE)
   END IF    
   #add by geza 20160613(S)
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM rtel_t
    WHERE rtelent = g_enterprise
      AND rteldocno = g_rtek_m.rtekdocno
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("rtek002,rtek003,rtek004,rtek008",FALSE)   
   END IF
   #add by geza 20160613(E)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt409_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("rtel001",TRUE)
   CALL cl_set_comp_entry("rtel002",TRUE)
   CALL cl_set_comp_entry("rtel004",TRUE)
   CALL cl_set_comp_entry("rtel005",TRUE)
   CALL cl_set_comp_entry("rtel006",TRUE)
   CALL cl_set_comp_entry("rtel007",TRUE)
   CALL cl_set_comp_entry("rtel008",TRUE)
   CALL cl_set_comp_entry("rtel009",TRUE)
   CALL cl_set_comp_entry("rtel010",TRUE)
   CALL cl_set_comp_entry("rtel011",TRUE)
   CALL cl_set_comp_entry("rtel012",TRUE) 
   CALL cl_set_comp_entry("rtell002",TRUE)
   CALL cl_set_comp_entry("rtell003",TRUE)
   CALL cl_set_comp_entry("rtell004",TRUE)   
   CALL cl_set_comp_entry("rtel023",TRUE) #add by geza 20160607
   #add by geza 20160607 #160604-00009#11(S)
   CALL cl_set_comp_entry("rtel018",TRUE)
   CALL cl_set_comp_entry("rtel020",TRUE)
   CALL cl_set_comp_entry("rtel021",TRUE)
   CALL cl_set_comp_entry("rtel022",TRUE)
   CALL cl_set_comp_entry("rtel003",TRUE)
   #add by geza 20160607 #160604-00009#11(E)
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt409_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_sys   LIKE type_t.chr1 #add by geza 20160613
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_rtel_d[l_ac].rtel001 = '2' AND g_rtek_m.rtek004 = 'Y' THEN
      CALL cl_set_comp_entry("rtel002",FALSE)
   END IF
   IF g_rtek_m.rtek004 = 'N' THEN
      CALL cl_set_comp_entry("rtel001",FALSE)
      CALL cl_set_comp_entry("rtel004",FALSE)
      CALL cl_set_comp_entry("rtel005",FALSE)
      CALL cl_set_comp_entry("rtel006",FALSE)
      CALL cl_set_comp_entry("rtel007",FALSE)
      CALL cl_set_comp_entry("rtel008",FALSE)
      CALL cl_set_comp_entry("rtel009",FALSE)
      CALL cl_set_comp_entry("rtel010",FALSE)
      CALL cl_set_comp_entry("rtel011",FALSE)
      CALL cl_set_comp_entry("rtel012",FALSE)
      CALL cl_set_comp_entry("rtell002",FALSE)
      CALL cl_set_comp_entry("rtell003",FALSE)
      CALL cl_set_comp_entry("rtell004",FALSE)
      CALL cl_set_comp_entry("rtel023",FALSE)  #add by geza 20160607
      #add by geza 20160607 #160604-00009#11(S)
      CALL cl_set_comp_entry("rtel018",FALSE)
      CALL cl_set_comp_entry("rtel020",FALSE)
      CALL cl_set_comp_entry("rtel021",FALSE)
      CALL cl_set_comp_entry("rtel022",FALSE)
      #add by geza 20160607 #160604-00009#11(E)
   END IF
   
   IF artt409_rtel003_chk(g_rtel_d[l_ac].rtel003) THEN
      CALL cl_set_comp_entry("rtel001",FALSE)
      CALL cl_set_comp_entry("rtel004",FALSE)
      CALL cl_set_comp_entry("rtel005",FALSE)
      CALL cl_set_comp_entry("rtel006",FALSE)
      CALL cl_set_comp_entry("rtel007",FALSE)
      CALL cl_set_comp_entry("rtel008",FALSE)
      CALL cl_set_comp_entry("rtel009",FALSE)
      CALL cl_set_comp_entry("rtel010",FALSE)
      CALL cl_set_comp_entry("rtel011",FALSE)
      CALL cl_set_comp_entry("rtel012",FALSE)   
      CALL cl_set_comp_entry("rtell002",FALSE)
      CALL cl_set_comp_entry("rtell003",FALSE)
      CALL cl_set_comp_entry("rtell004",FALSE)
      CALL cl_set_comp_entry("rtel023",FALSE)  #add by geza 20160607
      #add by geza 20160607 #160604-00009#11(S)
      CALL cl_set_comp_entry("rtel018",FALSE)
      CALL cl_set_comp_entry("rtel020",FALSE)
      CALL cl_set_comp_entry("rtel021",FALSE)
      CALL cl_set_comp_entry("rtel022",FALSE)
      #add by geza 20160607 #160604-00009#11(E)      
   END IF
   #add by geza 20160612 #160604-00009#11(S)
   LET l_sys = cl_get_para(g_enterprise,g_rtek_m.rteksite,"S-CIR-2031")
   IF g_rtek_m.rtek004 = 'Y' AND l_sys = 'Y' THEN
      CALL cl_set_comp_entry("rtel003",FALSE)
   END IF
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("rtel001,rtel023,rtel002,rtel003",FALSE)
   END IF
   #add by geza 20160612 #160604-00009#11(E)   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt409_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt409_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_rtek_m.rtekstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt409_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt409.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt409_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt409.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt409_default_search()
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
      LET ls_wc = ls_wc, " rtekdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rtek_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtel_t" 
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
 
{<section id="artt409.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt409_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_rtek_m.rtekstus = 'Y' OR g_rtek_m.rtekstus = 'X' THEN #確認,作廢狀態
      RETURN
   END IF
   IF g_rtek_m.rtekstus = 'C' THEN  #結案狀態
      RETURN
   END IF   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtek_m.rtekdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt409_cl USING g_enterprise,g_rtek_m.rtekdocno
   IF STATUS THEN
      CLOSE artt409_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt409_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
       g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
       g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
       g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
       g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid_desc, 
       g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT artt409_action_chk() THEN
      CLOSE artt409_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno,g_rtek_m.rtek001, 
       g_rtek_m.rtek002,g_rtek_m.rtek002_desc,g_rtek_m.rtek003,g_rtek_m.rtek003_desc,g_rtek_m.rtek008, 
       g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek005_desc,g_rtek_m.rtek006,g_rtek_m.rtek006_desc, 
       g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp, 
       g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtid_desc,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdp_desc, 
       g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekmoddt,g_rtek_m.rtekcnfid, 
       g_rtek_m.rtekcnfid_desc,g_rtek_m.rtekcnfdt,g_rtek_m.rtekpstid_desc
 
   CASE g_rtek_m.rtekstus
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
         CASE g_rtek_m.rtekstus
            
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
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_rtek_m.rtekstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

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
            IF NOT artt409_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt409_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt409_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt409_cl
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
      g_rtek_m.rtekstus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt409_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CALL cl_err_collect_init()   
   CASE lc_state 
      WHEN 'Y'       
         CALL s_artt409_conf_chk(g_rtek_m.rtekdocno) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN      
               CALL s_transaction_begin()   
               CALL s_artt409_conf_upd(g_rtek_m.rtekdocno) RETURNING l_success
               CALL cl_err_collect_show() 
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN            
            END IF
         ELSE
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add            
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_artt409_void_chk(g_rtek_m.rtekdocno) RETURNING l_success          
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_artt409_void_upd(g_rtek_m.rtekdocno) RETURNING l_success
               CALL cl_err_collect_show()   
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN
            END IF
         ELSE
            CALL cl_err_collect_show() 
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN    
         END IF
     
   END CASE
   #end add-point
   
   LET g_rtek_m.rtekmodid = g_user
   LET g_rtek_m.rtekmoddt = cl_get_current()
   LET g_rtek_m.rtekstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtek_t 
      SET (rtekstus,rtekmodid,rtekmoddt) 
        = (g_rtek_m.rtekstus,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt)     
    WHERE rtekent = g_enterprise AND rtekdocno = g_rtek_m.rtekdocno
 
    
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
      EXECUTE artt409_master_referesh USING g_rtek_m.rtekdocno INTO g_rtek_m.rteksite,g_rtek_m.rtekdocdt, 
          g_rtek_m.rtekdocno,g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek003,g_rtek_m.rtek008,g_rtek_m.rtek004, 
          g_rtek_m.rtek005,g_rtek_m.rtek006,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekowndp, 
          g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtdp,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmoddt, 
          g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfdt,g_rtek_m.rteksite_desc,g_rtek_m.rtek002_desc,g_rtek_m.rtek003_desc, 
          g_rtek_m.rtek005_desc,g_rtek_m.rtek006_desc,g_rtek_m.rtekownid_desc,g_rtek_m.rtekowndp_desc, 
          g_rtek_m.rtekcrtid_desc,g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtek_m.rteksite,g_rtek_m.rteksite_desc,g_rtek_m.rtekdocdt,g_rtek_m.rtekdocno, 
          g_rtek_m.rtek001,g_rtek_m.rtek002,g_rtek_m.rtek002_desc,g_rtek_m.rtek003,g_rtek_m.rtek003_desc, 
          g_rtek_m.rtek008,g_rtek_m.rtek004,g_rtek_m.rtek005,g_rtek_m.rtek005_desc,g_rtek_m.rtek006, 
          g_rtek_m.rtek006_desc,g_rtek_m.rtek007,g_rtek_m.rtekstus,g_rtek_m.rtekownid,g_rtek_m.rtekownid_desc, 
          g_rtek_m.rtekowndp,g_rtek_m.rtekowndp_desc,g_rtek_m.rtekcrtid,g_rtek_m.rtekcrtid_desc,g_rtek_m.rtekcrtdp, 
          g_rtek_m.rtekcrtdp_desc,g_rtek_m.rtekcrtdt,g_rtek_m.rtekmodid,g_rtek_m.rtekmodid_desc,g_rtek_m.rtekmoddt, 
          g_rtek_m.rtekcnfid,g_rtek_m.rtekcnfid_desc,g_rtek_m.rtekcnfdt,g_rtek_m.rtekpstid_desc
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE artt409_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt409_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt409.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt409_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtel_d.getLength() THEN
         LET g_detail_idx = g_rtel_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtel_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtel_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt409_b_fill2(pi_idx)
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
   
   CALL artt409_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt409_fill_chk(ps_idx)
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
 
{<section id="artt409.status_show" >}
PRIVATE FUNCTION artt409_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt409.mask_functions" >}
&include "erp/art/artt409_mask.4gl"
 
{</section>}
 
{<section id="artt409.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt409_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL artt409_show()
   CALL artt409_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtek_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtel_d))
 
 
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
   #CALL artt409_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt409_ui_headershow()
   CALL artt409_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt409_draw_out()
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
   CALL artt409_ui_headershow()  
   CALL artt409_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt409.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt409_set_pk_array()
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
   LET g_pk_array[1].values = g_rtek_m.rtekdocno
   LET g_pk_array[1].column = 'rtekdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt409.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt409.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt409_msgcentre_notify(lc_state)
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
   CALL artt409_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtek_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt409.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt409_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#35 add-S
   SELECT rtekstus  INTO g_rtek_m.rtekstus
     FROM rtek_t
    WHERE rtekent = g_enterprise
      AND rtekdocno = g_rtek_m.rtekdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rtek_m.rtekstus
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
        LET g_errparam.extend = g_rtek_m.rtekdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL artt409_set_act_visible()
        CALL artt409_set_act_no_visible()
        CALL artt409_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#35 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt409.other_function" readonly="Y" >}

################################################################################
# Descriptions...: Barcode編碼檢查
# Memo...........:
# Usage..........: CALL artt409_chk_barcode(p_barcode)
# Input parameter: p_barcode      條碼
# Return code....: 
#                : 
# Date & Author..: 2016-04-21 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_chk_barcode(p_barcode)
   DEFINE p_barcode  LIKE imaa_t.imaa014
   DEFINE l_cnt      LIKE type_t.num5
   
   LET g_errno = ''
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM imay_t
    WHERE imayent = g_enterprise
      #AND imay001 != g_rtel_m.rtel003   #160531-00008#1 160601 by sakura mark
      AND imay003 = p_barcode
   IF l_cnt = 0 THEN
      SELECT COUNT(*) INTO l_cnt FROM imby_t
       WHERE imbyent = g_enterprise
         #AND imby001 != g_rtel_m.rtel003   #160531-00008#1 160601 by sakura mark 
         AND imby003 = p_barcode
   END IF
   IF l_cnt > 0 THEN
      LET g_errno = 'art-00032'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_chk_unit(p_unit)
   DEFINE p_unit     LIKE type_t.chr10
   DEFINE l_stus     LIKE type_t.chr10

   LET g_errno = '' LET l_stus = ''

   SELECT oocastus INTO l_stus FROM ooca_t
    WHERE ooca001 = p_unit
      AND oocaent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00003'
        WHEN l_stus='N'            LET g_errno = 'sub-01302'      
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 由商品條碼找出商品編號
# Memo...........:
# Usage..........: CALL artt409_get_imay001(p_imay003)
#                  RETURNING r_imay001
# Input parameter: p_imay003      商品條碼
# Return code....: r_imay001      商品編號
# Date & Author..: 2016/04/21 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_get_imay001(p_imay003)
DEFINE p_imay003          LIKE imay_t.imay003
DEFINE r_imay001          LIKE imay_t.imay001

   WHENEVER ERROR CONTINUE
   LET r_imay001 = ''
   #商品條碼找出商品編號
   SELECT imay001 INTO r_imay001
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay003 = p_imay003
      
   RETURN r_imay001
END FUNCTION

################################################################################
# Descriptions...: 商戶檢核
# Memo...........:
# Usage..........: CALL artt409_rtek002_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek002_chk()
DEFINE l_mhbe012        LIKE mhbe_t.mhbe012
DEFINE l_stic002        LIKE stic_t.stic002
DEFINE l_sql            STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_cnt1           LIKE type_t.num5   #add by geza 20160610
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   #mark by geza 20160610(S)
#   LET l_mhbe012 = ''
#   SELECT mhbe012 INTO l_mhbe012
#     FROM mhbe_t
#    WHERE mhbeent = g_enterprise
#      AND mhbe001 = g_rtek_m.rtek003
#      
#   IF l_mhbe012 ='2' THEN
#     SELECT COUNT(*) INTO l_cnt
#       FROM stic_t 
#      WHERE sticent = g_enterprise
#        AND sticsite = g_rtek_m.rteksite
#        AND stic010 = g_rtek_m.rtek003
#        AND stic002 = g_rtek_m.rtek002
#        AND stic004 <= g_rtek_m.rtekdocdt
#        AND stic005 >= g_rtek_m.rtekdocdt
#        AND sticstus = 'Y' 
#      IF l_cnt = 0  THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'art-00760'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         LET g_errparam.replace[1] = g_rtek_m.rtekdocdt
#         LET g_errparam.replace[2] = g_rtek_m.rtek002
#         LET g_errparam.replace[3] = g_rtek_m.rtek003
#         CALL cl_err()      
#         LET r_success = FALSE
#         RETURN r_success
#      END IF
#   END IF
#         
#   IF l_mhbe012 = '3' THEN
#     #160518-00011#1 20160531 mark by beckxie---S
#     #SELECT COUNT(*) INTO l_cnt
#     #  FROM stie_t 
#     # WHERE stieent = g_enterprise
#     #   AND stiesite = g_rtek_m.rteksite
#     #   AND stie008 = g_rtek_m.rtek003
#     #   AND stie007 = g_rtek_m.rtek002
#     #   AND stie011 <= g_rtek_m.rtekdocdt
#     #   AND stie012 >= g_rtek_m.rtekdocdt
#     #   AND stiestus = 'Y' 
#     #160518-00011#1 20160531 mark by beckxie---E   
#     #160518-00011#1 20160531 add by beckxie---S
#     SELECT COUNT(*) INTO l_cnt
#       FROM stje_t 
#      WHERE stjeent = g_enterprise
#        AND stjesite = g_rtek_m.rteksite
#        AND stje005 IN ('2','3','4','5')   
#        AND stje008 = g_rtek_m.rtek003
#        AND stje007 = g_rtek_m.rtek002
#        AND stje011 <= g_rtek_m.rtekdocdt
#        AND stje012 >= g_rtek_m.rtekdocdt
#        AND stjestus = 'Y' 
#     #160518-00011#1 20160531 add by beckxie---E
#      IF l_cnt = 0  THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'art-00761'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         LET g_errparam.replace[1] = g_rtek_m.rtekdocdt
#         LET g_errparam.replace[2] = g_rtek_m.rtek002
#         LET g_errparam.replace[3] = g_rtek_m.rtek003         
#         CALL cl_err()      
#         LET r_success = FALSE
#         RETURN r_success
#      END IF    
#   END IF  
#   #mark by geza 20160610(E)
   #add by geza 20160610(S)
   #预租协议
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt
     FROM stic_t 
    WHERE sticent = g_enterprise
      AND sticsite = g_rtek_m.rteksite
      AND stic010 = g_rtek_m.rtek003
      AND stic002 = g_rtek_m.rtek002
      AND stic005 >= g_rtek_m.rtekdocdt
      AND sticstus = 'Y'
   #合同
   SELECT COUNT(*) INTO l_cnt1
     FROM stje_t 
    WHERE stjeent = g_enterprise
      AND stjesite = g_rtek_m.rteksite
      AND stje005 IN ('2','3','4','5')   
      AND stje008 = g_rtek_m.rtek003
      AND stje007 = g_rtek_m.rtek002
      AND stje012 >= g_rtek_m.rtekdocdt
      AND stjestus = 'Y'       
   IF l_cnt = 0 AND l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00781'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_rtek_m.rtekdocdt
      LET g_errparam.replace[2] = g_rtek_m.rtek002
      LET g_errparam.replace[3] = g_rtek_m.rtek003
      CALL cl_err()      
      LET r_success = FALSE
      RETURN r_success
   END IF
    
   #add by geza 20160610(E)
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 商戶說明
# Memo...........:
# Usage..........: CALL artt409_rtek002_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtek_m.rtek002
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtek_m.rtek002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtek_m.rtek002_desc
END FUNCTION

################################################################################
# Descriptions...: 帶出鋪位相關資料
# Memo...........:
# Usage..........: CALL artt409_rtek003_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek003_default()
DEFINE l_mhbe012        LIKE mhbe_t.mhbe012
DEFINE l_stic002        LIKE stic_t.stic002
DEFINE l_sql            STRING
DEFINE l_cnt1           LIKE type_t.num5   
DEFINE l_cnt            LIKE type_t.num5 
   #mark by geza 20160610(S)   
#   SELECT mhbe012 INTO l_mhbe012
#     FROM mhbe_t
#    WHERE mhbeent = g_enterprise
#      AND mhbe001 = g_rtek_m.rtek003
#      
#   IF l_mhbe012 ='2' THEN
#     #LET l_sql = "SELECT stic002 ", #mark by geza 20160607 #160513-00037#22
#     LET l_sql = "SELECT stic002,sticdocno ", #add by geza 20160607 #160513-00037#22
#                "  FROM stic_t ",
#                " WHERE sticent = ",g_enterprise,
#                "   AND sticsite = '",g_rtek_m.rteksite,"'",
#                "   AND stic010 = '",g_rtek_m.rtek003,"'",
#                #"   AND stic004 <=' ",g_rtek_m.rtekdocdt,"'", #mark by geza 20160607
#                "   AND stic005 >=' ",g_rtek_m.rtekdocdt,"'",
#                "   AND sticstus = 'Y' "
#                
#         PREPARE artt409_mhbe012_pre FROM l_sql
#         DECLARE artt409_mhbe012_cur SCROLL CURSOR FOR artt409_mhbe012_pre
#         OPEN artt409_mhbe012_cur 
#         #FETCH FIRST artt409_mhbe012_cur INTO l_stic002, #mark by geza 20160607 #160513-00037#22
#         FETCH FIRST artt409_mhbe012_cur INTO l_stic002,g_rtek_m.rtek008 #add by geza 20160607 #160513-00037#22
#         IF NOT cl_null(l_stic002) THEN
#            LET g_rtek_m.rtek002 = l_stic002
#            DISPLAY BY NAME g_rtek_m.rtek002
#         END IF
#         
#   END IF
#   IF l_mhbe012 = '3' THEN
#      LET l_sql = "SELECT stje007,stje001 ",   #160518-00011#1 20160531 modify (add stje001) by beckxie
#                "  FROM stje_t ",
#                " WHERE stjeent = ",g_enterprise,
#                "   AND stjesite = '",g_rtek_m.rteksite,"'",
#                "   AND stje008 = '",g_rtek_m.rtek003,"'",
#                #"   AND stje011 <=' ",g_rtek_m.rtekdocdt,"'",#mark by geza 20160607
#                "   AND stje012 >=' ",g_rtek_m.rtekdocdt,"'",
#                "   AND stjestus = 'Y' ",
#                "   AND stje005 IN ('2','3','4','5') "
#                
#         PREPARE artt409_mhbe012_pre1 FROM l_sql
#         DECLARE artt409_mhbe012_cur1 SCROLL CURSOR FOR artt409_mhbe012_pre1
#         OPEN artt409_mhbe012_cur1 
#         FETCH FIRST artt409_mhbe012_cur1 INTO l_stic002,g_rtek_m.rtek008  #160518-00011#1 20160531 modify (add rtek008) by beckxie
#         IF NOT cl_null(l_stic002) THEN
#            LET g_rtek_m.rtek002 = l_stic002
#            LET g_rtek_m_t.rtek002 = g_rtek_m.rtek002   #160602-00005#1 20160602 add by beckxie
#            DISPLAY BY NAME g_rtek_m.rtek002
#         END IF     
#         LET g_rtek_m_o.rtek008 = g_rtek_m.rtek008   #160602-00005#1 20160602 add by beckxie
#         DISPLAY BY NAME g_rtek_m.rtek008   #160518-00011#1 20160531 modify (add stje008) by beckxie
#   END IF  
   #mark by geza 20160610(E)
   #add by geza 20160610(S)
   #如果商户只有一个预租协议或者合同，自动带出 （不管铺位和合同是否有值）；否则，清空铺位和合同栏位
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET l_sql =" SELECT COUNT(*) 
                  FROM stic_t 
                 WHERE sticent = ",g_enterprise,"
                   AND sticsite = '",g_rtek_m.rteksite,"'
                   AND stic010 = '",g_rtek_m.rtek003,"'                     
                   AND stic005 >= '",g_rtek_m.rtekdocdt,"'
                   AND sticstus = 'Y' "
   IF g_rtek_m.rtek002 IS NOT NULL THEN 
      LET l_sql = l_sql," AND stic002 = '",g_rtek_m.rtek002,"' "
   END IF      
   IF g_rtek_m.rtek008 IS NOT NULL THEN 
      LET l_sql = l_sql," AND sticdocno = '",g_rtek_m.rtek008,"' "
   END IF    
                       
   PREPARE artt409_stic_pre3 FROM l_sql
   DECLARE artt409_stic_cur3 SCROLL CURSOR FOR artt409_stic_pre3
   EXECUTE artt409_stic_cur3 INTO l_cnt 
   #抓预租协议    
   LET l_sql = "SELECT COUNT(*) ",   
               "  FROM stje_t ",
               " WHERE stjeent = ",g_enterprise,
               "   AND stjesite = '",g_rtek_m.rteksite,"'",
               "   AND stje008 = '",g_rtek_m.rtek003,"'",
               "   AND stje012 >=' ",g_rtek_m.rtekdocdt,"'",
               "   AND stjestus = 'Y' ",
               "   AND stje005 IN ('2','3','4','5') "
   IF g_rtek_m.rtek002 IS NOT NULL THEN 
      LET l_sql = l_sql," AND stje007 = '",g_rtek_m.rtek002,"' "
   END IF      
   IF g_rtek_m.rtek008 IS NOT NULL THEN 
      LET l_sql = l_sql," AND stje001 = '",g_rtek_m.rtek008,"' "
   END IF
   PREPARE artt409_stic_pre4 FROM l_sql
   DECLARE artt409_stic_cur4 SCROLL CURSOR FOR artt409_stic_pre4
   EXECUTE artt409_stic_cur4 INTO l_cnt1          
   IF (l_cnt = 1 AND l_cnt1 = 0 ) OR (l_cnt1 = 1 AND l_cnt = 0) THEN  
      IF l_cnt1 = 1 THEN
         #先抓合同
         LET l_sql = "SELECT stje007,stje001 ",   
                     "  FROM stje_t ",
                     " WHERE stjeent = ",g_enterprise,
                     "   AND stjesite = '",g_rtek_m.rteksite,"'",
                     "   AND stje008 = '",g_rtek_m.rtek003,"'",
                     "   AND stje012 >=' ",g_rtek_m.rtekdocdt,"'",
                     "   AND stjestus = 'Y' ",
                     "   AND stje005 IN ('2','3','4','5') " 
         IF g_rtek_m.rtek002 IS NOT NULL THEN 
            LET l_sql = l_sql," AND stje007 = '",g_rtek_m.rtek002,"' "
         END IF      
         IF g_rtek_m.rtek008 IS NOT NULL THEN 
            LET l_sql = l_sql," AND stje001 = '",g_rtek_m.rtek008,"' "
         END IF                     
         PREPARE artt409_stje_pre5 FROM l_sql
         DECLARE artt409_stje_cur5 SCROLL CURSOR FOR artt409_stje_pre5
         OPEN artt409_stje_cur5 
         FETCH FIRST artt409_stje_cur5 INTO l_stic002,g_rtek_m.rtek008 
         IF NOT cl_null(l_stic002) THEN
            LET g_rtek_m.rtek002 = l_stic002
            LET g_rtek_m_t.rtek002 = g_rtek_m.rtek002   
            DISPLAY BY NAME g_rtek_m.rtek002
         END IF     
         LET g_rtek_m_o.rtek008 = g_rtek_m.rtek008  
         DISPLAY BY NAME g_rtek_m.rtek008  
      END IF         
      #抓预租协议
      IF l_cnt = 1 THEN
         LET l_sql = "SELECT stic002,sticdocno ", 
                    "  FROM stic_t ",
                    " WHERE sticent = ",g_enterprise,
                    "   AND sticsite = '",g_rtek_m.rteksite,"'",
                    "   AND stic010 = '",g_rtek_m.rtek003,"' ",
                    "   AND stic005 >=' ",g_rtek_m.rtekdocdt,"'",
                    "   AND sticstus = 'Y' "
        IF g_rtek_m.rtek002 IS NOT NULL THEN 
           LET l_sql = l_sql," AND stic002 = '",g_rtek_m.rtek002,"' "
        END IF      
        IF g_rtek_m.rtek008 IS NOT NULL THEN 
           LET l_sql = l_sql," AND sticdocno = '",g_rtek_m.rtek008,"' "
        END IF                        
        PREPARE artt409_stje_pre6 FROM l_sql
        DECLARE artt409_stje_cur6 SCROLL CURSOR FOR artt409_stje_pre6
        OPEN artt409_stje_cur6 
        FETCH FIRST artt409_stje_cur6 INTO l_stic002,g_rtek_m.rtek008  
        IF NOT cl_null(l_stic002) THEN
           LET g_rtek_m.rtek002 = l_stic002
           DISPLAY BY NAME g_rtek_m.rtek002
        END IF
             
      END IF      
   END IF
   #add by geza 20160610(E)
   CALL artt409_rtek003_ref()
   CALL artt409_rtek002_ref()
END FUNCTION

################################################################################
# Descriptions...: 鋪位说明
# Memo...........:
# Usage..........: CALL artt409_rtek003_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtek_m.rtek003
   CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtek_m.rtek003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtek_m.rtek003_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查租賃合約/預租協議編號
# Memo...........:
# Usage..........: CALL artt409_rtek008_chk_and_def()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success
# Date & Author..: 2016/05/17 By Lori      #160513-00037#3  
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek008_chk_and_def()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_type          LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_rtek002       LIKE rtek_t.rtek002
   DEFINE l_rtek003       LIKE rtek_t.rtek003
   
   LET r_success = TRUE
   LET l_type = 0
   LET l_rtek002 = NULL
   LET l_rtek003 = NULL
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = g_rtek_m.rtek008
      
   IF l_cnt > 0 THEN
      LET l_type = 1
   ELSE      
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM stic_t
       WHERE sticent = g_enterprise 
         AND sticdocno = g_rtek_m.rtek008
      
      IF l_cnt > 0 THEN      
         LET l_type = 2
      END IF   
   END IF   
          
   IF l_cnt = 0 THEN
      #輸入的資料不存在於租賃合約或預租協議中！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00765'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE        
      CALL cl_err()
         
      LET r_success = FALSE
      RETURN r_success
   ELSE
      CASE l_type
         WHEN 1    #來源=租賃合約
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_rtek_m.rtek008
            #LET g_chkparam.arg1 = g_rtek_m.rteksite   #160602-00005#1 20160602 mark by beckxie
            LET g_chkparam.arg2 = g_rtek_m.rteksite   #160602-00005#1 20160602 add by beckxie
            IF NOT cl_chk_exist("v_stje001") THEN
               LET r_success = FALSE
               RETURN r_success
            ELSE
               #add by geza 20160607 #160513-00037#22(S)
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM stje_t
                WHERE stjeent = g_enterprise
                  AND stje001 = g_rtek_m.rtek008
                  AND stje012 >= g_rtek_m.rtekdocdt 
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00807'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE        
                  CALL cl_err()
                     
                  LET r_success = FALSE
                  RETURN r_success
               END IF
               #add by geza 20160607 #160513-00037#22(E)
               SELECT stje007,stje008
                 INTO l_rtek002,l_rtek003
                 FROM stje_t
                WHERE stjeent = g_enterprise
                  AND stje001 = g_rtek_m.rtek008
                  AND stje012 >= g_rtek_m.rtekdocdt   #add by geza 20160607 #160513-00037#22
                  #add by geza 20160610(S)
                  LET g_rtek_m.rtek002 = l_rtek002 
                  DISPLAY g_rtek_m.rtek002 TO rtek002
                  LET g_rtek_m.rtek003 = l_rtek003         
                  DISPLAY g_rtek_m.rtek003 TO rtek003
                  #add by geza 20160610(E)                  
            END IF    
            
         WHEN 2    #來源=預租協議
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_rtek_m.rtek008
            IF NOT cl_chk_exist("v_sticdocno") THEN
               LET r_success = FALSE
               RETURN r_success
            ELSE
               #add by geza 20160607 #160513-00037#22(S)
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM stic_t
                WHERE sticent = g_enterprise
                  AND sticdocno = g_rtek_m.rtek008      
                  AND stic005 >= g_rtek_m.rtekdocdt 
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00808'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE        
                  CALL cl_err()
                     
                  LET r_success = FALSE
                  RETURN r_success
               END IF
               #add by geza 20160607 #160513-00037#22(E)
               SELECT stic002,stic010
                 INTO l_rtek002,l_rtek003
                 FROM stic_t
                WHERE sticent = g_enterprise
                  AND sticdocno = g_rtek_m.rtek008 
                  AND stic005 >= g_rtek_m.rtekdocdt #add by geza 20160607 #160513-00037#22 
                  #add by geza 20160610(S)
                  LET g_rtek_m.rtek002 = l_rtek002 
                  DISPLAY g_rtek_m.rtek002 TO rtek002
                  LET g_rtek_m.rtek003 = l_rtek003         
                  DISPLAY g_rtek_m.rtek003 TO rtek003
                  #add by geza 20160610(E)
            END IF           
      END CASE  
      #mark by geza 20160610(S)
      #商戶
#      IF cl_null(g_rtek_m.rtek002) THEN
#         LET g_rtek_m.rtek002 = l_rtek002 
#         DISPLAY g_rtek_m.rtek002 TO rtek002
#         CALL artt409_rtek002_ref()
#      ELSE
#         IF g_rtek_m.rtek002 <> l_rtek002 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE  
#            
#            CASE l_type
#               WHEN 1   #租賃合約
#                  LET g_errparam.code = 'art-00767'                  
#               WHEN 2   #預租協議
#                  LET g_errparam.code = 'art-00769'
#            END CASE     
#            
#            LET g_errparam.replace[1] = l_rtek002   
#            LET g_errparam.replace[2] = g_rtek_m.rtek002             
#            CALL cl_err()
#      
#            LET r_success = FALSE
#            RETURN r_success
#         END IF   
#      END IF
#      #鋪位
#      IF cl_null(g_rtek_m.rtek003) THEN
#         LET g_rtek_m.rtek003 = l_rtek003         
#         DISPLAY g_rtek_m.rtek003 TO rtek003
#         CALL artt409_rtek003_ref()
#      ELSE
#         IF g_rtek_m.rtek003 <> l_rtek003 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE  
#            
#            CASE l_type
#               WHEN 1   #租賃合約
#                  LET g_errparam.code = 'art-00768'                  
#               WHEN 2   #預租協議
#                  LET g_errparam.code = 'art-00770'
#            END CASE     
#            
#            LET g_errparam.replace[1] = l_rtek003   
#            LET g_errparam.replace[2] = g_rtek_m.rtek003            
#            CALL cl_err()
#            
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      END IF
      #mark by geza 20160610(E)
      LET g_rtek_m_o.rtek002 = g_rtek_m.rtek002
      LET g_rtek_m_o.rtek003 = g_rtek_m.rtek003
      LET g_rtek_m_o.rtek008 = g_rtek_m.rtek008    
   END IF
   CALL artt409_rtek003_ref()
   CALL artt409_rtek002_ref()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 商品編號檢查是否存在商品主檔
# Memo...........:
# Usage..........: CALL artt409_rtel003_chk(p_rtel003)
#                  RETURNING r_success
# Input parameter: p_rtel003      商品編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel003_chk(p_rtel003)
DEFINE p_rtel003        LIKE rtel_t.rtel003
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_rtel003
      
   IF l_cnt = 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 帶商品編號相關資料
# Memo...........:
# Usage..........: CALL artt409_rtel003_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/21 By Ken
# Modify.........: 2016/05/17 By Lori    #帶值增加主材,輔材
################################################################################
PRIVATE FUNCTION artt409_rtel003_default()
DEFINE l_cnt          LIKE type_t.num10   
   #帶條碼(如條碼為空時)
   IF cl_null(g_rtel_d[l_ac].rtel002) THEN
      SELECT imaa014,imaa100,imaa130,imaa150,imaa109              #160513-00037#3 160517 by lori add imaa130,imaa150 #add by geza 20160607 add imaa109
        INTO g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtel001,       
             #g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel019       #160513-00037#3 160517 by lori add  #160518-00011#1 20160531 mark by beckxie
             g_rtel_d[l_ac].rtel012,g_rtel_d[l_ac].rtel018,       #160518-00011#1 20160531 add by beckxie
             g_rtel_d[l_ac].rtel023 #add by geza 20160607 add imaa109
        FROM imaa_t  
       WHERE imaaent = g_enterprise
         AND imaa001 = g_rtel_d[l_ac].rtel003
   END IF
   #add by geza 20160607  #160604-00009#11 (S)
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_rtel_d[l_ac].rtel003 
   IF g_rtek_m.rtek004 = 'Y' AND l_cnt > 0 AND NOT cl_null(g_rtel_d[l_ac].rtel003) THEN     
      SELECT imaa014,imaa100,imaa130,imaa150,imaa109                  
        INTO g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtel001,
             g_rtel_d[l_ac].rtel012,g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel023       
        FROM imaa_t  
       WHERE imaaent = g_enterprise
         AND imaa001 = g_rtel_d[l_ac].rtel003
   END IF
   #add by geza 20160607  #160604-00009#11 (E)
   #銷售單位，品類，產地分類，原產地，品牌
   #系列，類型，功能，成份
   #輔材，等級，顏色，型號   #160604-00009#123 20160702 add by beckxie
   SELECT imaa105,imaa009,imaa122,imaa123,imaa126,
          imaa127,imaa128,imaa129,imaa130,
          imaa150,imaa151,imaa152,imaa153   #160604-00009#123 20160702 add by beckxie
     INTO g_rtel_d[l_ac].rtel004,g_rtel_d[l_ac].rtel007,g_rtel_d[l_ac].rtel005,g_rtel_d[l_ac].rtel006,g_rtel_d[l_ac].rtel008,
          g_rtel_d[l_ac].rtel009,g_rtel_d[l_ac].rtel010,g_rtel_d[l_ac].rtel011,g_rtel_d[l_ac].rtel012,
          g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel020,g_rtel_d[l_ac].rtel021,g_rtel_d[l_ac].rtel022   #160604-00009#123 20160702 add by beckxie
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_rtel_d[l_ac].rtel003
      
    CALL s_desc_get_unit_desc(g_rtel_d[l_ac].rtel004) RETURNING g_rtel_d[l_ac].rtel004_desc
    CALL s_desc_get_rtaxl003_desc(g_rtel_d[l_ac].rtel007) RETURNING g_rtel_d[l_ac].rtel007_desc
    CALL s_desc_get_acc_desc('2000',g_rtel_d[l_ac].rtel005) RETURNING g_rtel_d[l_ac].rtel005_desc     #產地分類
    CALL s_desc_get_acc_desc('2002',g_rtel_d[l_ac].rtel008) RETURNING g_rtel_d[l_ac].rtel008_desc     #品牌
    CALL s_desc_get_acc_desc('2003',g_rtel_d[l_ac].rtel009) RETURNING g_rtel_d[l_ac].rtel009_desc     #系列
    CALL s_desc_get_acc_desc('2004',g_rtel_d[l_ac].rtel010) RETURNING g_rtel_d[l_ac].rtel010_desc     #類型
    CALL s_desc_get_acc_desc('2005',g_rtel_d[l_ac].rtel011) RETURNING g_rtel_d[l_ac].rtel011_desc     #功能
    
   

    #IF g_rtek_m.rtek004 = 'Y' THEN   #自動建立商品 #mark by geza 20160607 #160604-00009#11
    #add by geza 20160607  #160604-00009#11 (S)
    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt
      FROM imaa_t
     WHERE imaaent = g_enterprise
       AND imaa001 = g_rtel_d[l_ac].rtel003 
    IF g_rtek_m.rtek004 = 'Y' AND l_cnt = 0 THEN   #自動建立商品 
    #add by geza 20160607  #160604-00009#11 (E)
       INITIALIZE g_ref_fields TO NULL 
       LET g_ref_fields[1] = g_rtek_m.rtekdocno
       LET g_ref_fields[2] = g_rtel_d[l_ac].rtelseq
       CALL ap_ref_array2(g_ref_fields," SELECT rtell002,rtell003,rtell004 FROM rtell_t WHERE rtellent = '"
           ||g_enterprise||"' AND rtelldocno = ? AND rtellseq = ? AND rtell001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_rtel_d[l_ac].rtell002 = g_rtn_fields[1]
       LET g_rtel_d[l_ac].rtell003 = g_rtn_fields[2]
       LET g_rtel_d[l_ac].rtell004 = g_rtn_fields[3]
       DISPLAY BY NAME g_rtel_d[l_ac].rtell002,g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004 
    ELSE
       INITIALIZE g_ref_fields TO NULL 
       LET g_ref_fields[1] = g_rtel_d[l_ac].rtel003
       CALL ap_ref_array2(g_ref_fields," SELECT imaal003,imaal004,imaal005 FROM imaal_t WHERE imaalent = '"
           ||g_enterprise||"' AND imaal001 = ? AND imaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_rtel_d[l_ac].rtell002 = g_rtn_fields[1]
       LET g_rtel_d[l_ac].rtell003 = g_rtn_fields[2]
       LET g_rtel_d[l_ac].rtell004 = g_rtn_fields[3]
       DISPLAY BY NAME g_rtel_d[l_ac].rtell002,g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004   
       

    END IF 
    
    IF artt409_rtdx001_chk(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel003) THEN #如商品存在門店清單的話
    #取出原門店清單的售價、進價、會員價一、二、三
    #加取出庫位資料                                               #160513-00037#3 160517 by lori add
       SELECT rtdx016,rtdx017,rtdx018,rtdx019,rtdx034,
              rtdx044                                            #160513-00037#3 160517 by lori add rtdx044        
         INTO g_rtel_d[l_ac].rtel014,g_rtel_d[l_ac].rtel015,
              g_rtel_d[l_ac].rtel016,g_rtel_d[l_ac].rtel017,
              g_rtel_d[l_ac].rtel013,g_rtel_d[l_ac].rtel019      #160513-00037#3 160517 by lori add rtel019
         FROM rtdx_t
        WHERE rtdxent = g_enterprise
          AND rtdxsite = g_rtek_m.rteksite
          AND rtdx001  = g_rtel_d[l_ac].rtel003
          
       LET g_rtel_d[l_ac].rtel019_desc = s_desc_get_stock_desc(g_rtek_m.rteksite,g_rtel_d[l_ac].rtel019)   #160513-00037#3 160517 by lori add
    END IF  
END FUNCTION

################################################################################
# Descriptions...: 銷售單位说明
# Memo...........:
# Usage..........: CALL artt409_rtel004_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtel_d[l_ac].rtel004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtel_d[l_ac].rtel004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtel_d[l_ac].rtel004_desc
END FUNCTION

################################################################################
# Descriptions...: 產地分類说明
# Memo...........:
# Usage..........: CALL artt409_rtel005()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtel_d[l_ac].rtel005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtel_d[l_ac].rtel005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtel_d[l_ac].rtel005_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查商品品類
# Memo...........:
# Usage..........: CALL artt409_rtel007_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel007_chk()
DEFINE l_stus        LIKE type_t.chr1
DEFINE l_rtax005     LIKE rtax_t.rtax005
DEFINE l_type        LIKE type_t.num5 #add by geza 20160607 
DEFINE l_cnt         LIKE type_t.num5 #add by geza 20160607 
   LET g_errno = '' LET l_stus = ''

   SELECT rtaxstus,rtax005 INTO l_stus,l_rtax005 FROM rtax_t
    WHERE rtax001 = g_rtel_d[l_ac].rtel007
      AND rtaxent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00002'
        WHEN l_stus='N'            LET g_errno = 'art-00048'
        WHEN l_rtax005 != 0        LET g_errno = 'art-00003'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
   #add by geza 20160607 #160604-00009#11(S)
   #单身品类控管在合同里面或者供应商品类下（来源预租协议）
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = g_rtek_m.rtek008
      
   IF l_cnt > 0 THEN
      LET l_type = 1
   ELSE      
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM stic_t
       WHERE sticent = g_enterprise 
         AND sticdocno = g_rtek_m.rtek008
      
      IF l_cnt > 0 THEN      
         LET l_type = 2
      END IF   
   END IF 
   CASE l_type
      WHEN 1    #來源=租賃合約
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt          
           FROM stjk_t
          WHERE stjkent = g_enterprise
            AND stjk001 = g_rtek_m.rtek008                  
            AND EXISTS (SELECT 1 FROM rtaw_t WHERE rtawent = stjkent AND rtaw001 = stjk002 AND rtaw002 = g_rtel_d[l_ac].rtel007)
         IF l_cnt = 0 THEN
            LET g_errno = 'ast-00804'
         END IF
      WHEN 2    #來源=預租協議
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt          
           FROM stic_t
          WHERE sticent = g_enterprise
            AND stic001 = g_rtek_m.rtek008                  
            AND EXISTS (SELECT 1 FROM rtaw_t WHERE rtawent = sticent AND rtaw001 = stic014 AND rtaw002 = g_rtel_d[l_ac].rtel007)
         IF l_cnt = 0 THEN
            LET g_errno = 'ast-00805'
         END IF         
   END CASE  
   #add by geza 20160607 #160604-00009#11 (E)
   
END FUNCTION

################################################################################
# Descriptions...: 品類说明
# Memo...........:
# Usage..........: CALL artt409_rtel007_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtel_d[l_ac].rtel007
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtel_d[l_ac].rtel007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtel_d[l_ac].rtel007_desc
END FUNCTION

################################################################################
# Descriptions...: 取營運組織預設出貨非成本倉
# Memo...........:
# Usage..........: CALL artt409_rtel019_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/05/17 By Lori      #160513-00037#3
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel019_def()
   
   LET g_ooef127 = ''
   
   SELECT ooef127 INTO g_ooef127 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_rtek_m.rteksite   
   
END FUNCTION

################################################################################
# Descriptions...: 檢查商品是否存在門店清單
# Memo...........: 型態為修改時需存在門店清單且經營類型為租賃
# Usage..........: CALL artt409_rtdx001_chk(p_rteksite,p_rtel003)
#                  RETURNING r_success
# Input parameter: p_rteksite     門店組織
#                : p_rtel003      商品編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtdx001_chk(p_rteksite,p_rtel003)
DEFINE p_rteksite       LIKE rtek_t.rteksite
DEFINE p_rtel003        LIKE rtel_t.rtel003
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = p_rteksite
      AND rtdx001 = p_rtel003
      AND rtdx003 = '5'
      
   IF l_cnt = 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查商品是否存在門店清單
# Memo...........: 型態為引進時不可存在門店清單
# Usage..........: CALL artt409_rtdx001_chk(p_rteksite,p_rtel003)
#                  RETURNING r_success
# Input parameter: p_rteksite     門店組織
#                : p_rtel003      商品編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016-04-22 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtdx001_chk1(p_rteksite,p_rtel003)
DEFINE p_rteksite       LIKE rtek_t.rteksite
DEFINE p_rtel003        LIKE rtel_t.rtel003
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = p_rteksite
      AND rtdx001 = p_rtel003
      
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 铺位檢核
# Memo...........:
# Usage..........: CALL artt409_rtek003_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 2016-06-07 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek003_chk()
DEFINE l_mhbe012        LIKE mhbe_t.mhbe012
DEFINE l_stic002        LIKE stic_t.stic002
DEFINE l_sql            STRING
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_cnt1           LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
   LET r_success = TRUE
   LET l_cnt = 0
   LET l_cnt1 = 0
   #抓合同
   LET l_sql =" SELECT COUNT(*) 
                  FROM stic_t 
                 WHERE sticent = ",g_enterprise,"
                   AND sticsite = '",g_rtek_m.rteksite,"'
                   AND stic010 = '",g_rtek_m.rtek003,"'                     
                   AND stic005 >= '",g_rtek_m.rtekdocdt,"'
                   AND sticstus = 'Y' "
   IF g_rtek_m.rtek002 IS NOT NULL THEN 
      LET l_sql = l_sql," AND stic002 = '",g_rtek_m.rtek002,"' "
   END IF      
   IF g_rtek_m.rtek008 IS NOT NULL THEN 
      LET l_sql = l_sql," AND sticdocno = '",g_rtek_m.rtek008,"' "
   END IF    
                       
   PREPARE artt409_stic_pre1 FROM l_sql
   DECLARE artt409_stic_cur1 SCROLL CURSOR FOR artt409_stic_pre1
   EXECUTE artt409_stic_cur1 INTO l_cnt 
   #抓预租协议    
   LET l_sql = "SELECT COUNT(*) ",   
               "  FROM stje_t ",
               " WHERE stjeent = ",g_enterprise,
               "   AND stjesite = '",g_rtek_m.rteksite,"'",
               "   AND stje008 = '",g_rtek_m.rtek003,"'",
               "   AND stje012 >=' ",g_rtek_m.rtekdocdt,"'",
               "   AND stjestus = 'Y' ",
               "   AND stje005 IN ('2','3','4','5') "
   IF g_rtek_m.rtek002 IS NOT NULL THEN 
      LET l_sql = l_sql," AND stje007 = '",g_rtek_m.rtek002,"' "
   END IF      
   IF g_rtek_m.rtek008 IS NOT NULL THEN 
      LET l_sql = l_sql," AND stje001 = '",g_rtek_m.rtek008,"' "
   END IF
   PREPARE artt409_stic_pre2 FROM l_sql
   DECLARE artt409_stic_cur2 SCROLL CURSOR FOR artt409_stic_pre2
   EXECUTE artt409_stic_cur2 INTO l_cnt1       
           
   IF l_cnt = 0 AND l_cnt1 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00781'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_rtek_m.rtekdocdt
      LET g_errparam.replace[2] = g_rtek_m.rtek002
      LET g_errparam.replace[3] = g_rtek_m.rtek003
      CALL cl_err()      
      LET r_success = FALSE
      RETURN r_success
   END IF
    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 帶出商户相關資料
# Memo...........:
# Usage..........: CALL artt409_rtek002_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016-06-07 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtek002_default()
DEFINE l_mhbe012        LIKE mhbe_t.mhbe012
DEFINE l_stic010        LIKE stic_t.stic010
DEFINE l_sql            STRING
DEFINE l_cnt1           LIKE type_t.num5   
DEFINE l_cnt            LIKE type_t.num5   
   #如果商户只有一个预租协议或者合同，自动带出 （不管铺位和合同是否有值）；否则，清空铺位和合同栏位
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM stje_t  
    WHERE stjeent = g_enterprise
      AND stjesite = g_rtek_m.rteksite
      AND stje007 = g_rtek_m.rtek002
      AND stje012 >= g_rtek_m.rtekdocdt
      AND stjestus = 'Y' 
      AND stje005 IN ('2','3','4','5') 
   SELECT COUNT(*) INTO l_cnt1  
     FROM stic_t 
    WHERE sticent = g_enterprise
      AND sticsite = g_rtek_m.rteksite
      AND stic002 = g_rtek_m.rtek002
      AND stic005 >= g_rtek_m.rtekdocdt 
      AND sticstus = 'Y'    
   IF (l_cnt = 1 AND l_cnt1 = 0 ) OR (l_cnt1 = 1 AND l_cnt = 0) THEN  
      IF l_cnt = 1 THEN
         #先抓合同
         LET l_sql = "SELECT stje008,stje001 ",   
                     "  FROM stje_t ",
                     " WHERE stjeent = ",g_enterprise,
                     "   AND stjesite = '",g_rtek_m.rteksite,"'",
                     "   AND stje007 = '",g_rtek_m.rtek002,"'",
                     "   AND stje012 >=' ",g_rtek_m.rtekdocdt,"'",
                     "   AND stjestus = 'Y' ",
                     "   AND stje005 IN ('2','3','4','5') "                 
         PREPARE artt409_stje_pre1 FROM l_sql
         DECLARE artt409_stje_cur1 SCROLL CURSOR FOR artt409_stje_pre1
         OPEN artt409_stje_cur1 
         FETCH FIRST artt409_stje_cur1 INTO l_stic010,g_rtek_m.rtek008 
         IF NOT cl_null(l_stic010) THEN
            LET g_rtek_m.rtek003 = l_stic010
            LET g_rtek_m_t.rtek003 = g_rtek_m.rtek003   
            DISPLAY BY NAME g_rtek_m.rtek003
         END IF     
         LET g_rtek_m_o.rtek008 = g_rtek_m.rtek008  
         DISPLAY BY NAME g_rtek_m.rtek008  
      END IF         
      #抓预租协议
      IF l_cnt1 = 1 THEN
         LET l_sql = "SELECT stic010,sticdocno ", 
                    "  FROM stic_t ",
                    " WHERE sticent = ",g_enterprise,
                    "   AND sticsite = '",g_rtek_m.rteksite,"'",
                    "   AND stic002 = '",g_rtek_m.rtek002,"'",
                    "   AND stic005 >=' ",g_rtek_m.rtekdocdt,"'",
                    "   AND sticstus = 'Y' "
                    
        PREPARE artt409_stje_pre2 FROM l_sql
        DECLARE artt409_stje_cur2 SCROLL CURSOR FOR artt409_stje_pre2
        OPEN artt409_stje_cur2 
        FETCH FIRST artt409_stje_cur2 INTO l_stic010,g_rtek_m.rtek008  
        IF NOT cl_null(l_stic010) THEN
           LET g_rtek_m.rtek003 = l_stic010
           DISPLAY BY NAME g_rtek_m.rtek003
        END IF
             
      END IF 
   ELSE
      LET g_rtek_m.rtek003 = ''
      LET g_rtek_m.rtek008 = ''      
   END IF
   CALL artt409_rtek003_ref()
   CALL artt409_rtek002_ref()
END FUNCTION

################################################################################
# Descriptions...: 商品編號檢查是否存在商品引进单单身
# Memo...........:
# Usage..........: CALL artt409_rtel003_chk1(p_rtel003,p_rtelseq)
#                  RETURNING r_success
# Input parameter: p_rtel003      商品編號
# Input parameter: p_rtelseq      项次
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016-06-13 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel003_chk1(p_rtel003,p_rtelseq)
DEFINE p_rtel003        LIKE rtel_t.rtel003
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
DEFINE p_rtelseq        LIKE rtel_t.rtelseq
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rtel_t
    WHERE rtelent = g_enterprise
      AND rtel003 = p_rtel003
      AND rtelseq <> p_rtelseq
      AND rteldocno = g_rtek_m.rtekdocno
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 商品編號檢查是否存在商品引进单单身
# Memo...........:
# Usage..........: CALL artt409_rtel002_chk1(p_rtel002,p_rtelseq)
#                  RETURNING r_success
# Input parameter: p_rtel002      商品条码
# Input parameter: p_rtelseq      项次
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016-06-13 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_rtel002_chk1(p_rtel002,p_rtelseq)
DEFINE p_rtel002        LIKE rtel_t.rtel002
DEFINE l_cnt            LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5
DEFINE p_rtelseq        LIKE rtel_t.rtelseq
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rtel_t
    WHERE rtelent = g_enterprise
      AND rtel002 = p_rtel002
      AND rtelseq <> p_rtelseq
      AND rteldocno = g_rtek_m.rtekdocno
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
