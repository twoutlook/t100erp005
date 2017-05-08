#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt122.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-06-17 14:07:17), PR版次:0006(2016-09-06 09:51:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: aprt122
#+ Description: 生鮮價格調整作業
#+ Creator....: 01251(2015-06-17 10:34:33)
#+ Modifier...: 01251 -SD/PR- 08742
 
{</section>}
 
{<section id="aprt122.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...:   No.160318-00025#32  2016/04/12  By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#  Modify.....:   NO.160816-00068#12  2016/08/17  By 08209     調整transaction
#+ Modify.....:   NO.160818-00017#29  2016/08/30  By 08742     删除修改未重新判断状态码
#+ Modify.....:   NO.160905-00007#12  2016/09/05  by 08742     调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_prbi_m        RECORD
       prbisite LIKE prbi_t.prbisite, 
   prbisite_desc LIKE type_t.chr80, 
   prbidocdt LIKE prbi_t.prbidocdt, 
   prbidocno LIKE prbi_t.prbidocno, 
   prbiunit LIKE prbi_t.prbiunit, 
   prbi001 LIKE prbi_t.prbi001, 
   prbi001_desc LIKE type_t.chr80, 
   prbi002 LIKE prbi_t.prbi002, 
   prbi002_desc LIKE type_t.chr80, 
   prbi003 LIKE prbi_t.prbi003, 
   prbi000 LIKE prbi_t.prbi000, 
   prbi004 LIKE prbi_t.prbi004, 
   prbi004_desc LIKE type_t.chr80, 
   prbi005 LIKE prbi_t.prbi005, 
   prbi005_desc LIKE type_t.chr80, 
   prbi006 LIKE prbi_t.prbi006, 
   prbistus LIKE prbi_t.prbistus, 
   prbiownid LIKE prbi_t.prbiownid, 
   prbiownid_desc LIKE type_t.chr80, 
   prbiowndp LIKE prbi_t.prbiowndp, 
   prbiowndp_desc LIKE type_t.chr80, 
   prbicrtid LIKE prbi_t.prbicrtid, 
   prbicrtid_desc LIKE type_t.chr80, 
   prbicrtdp LIKE prbi_t.prbicrtdp, 
   prbicrtdp_desc LIKE type_t.chr80, 
   prbicrtdt LIKE prbi_t.prbicrtdt, 
   prbimodid LIKE prbi_t.prbimodid, 
   prbimodid_desc LIKE type_t.chr80, 
   prbimoddt LIKE prbi_t.prbimoddt, 
   prbicnfid LIKE prbi_t.prbicnfid, 
   prbicnfid_desc LIKE type_t.chr80, 
   prbicnfdt LIKE prbi_t.prbicnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prbj_d        RECORD
       prbjseq LIKE prbj_t.prbjseq, 
   prbjsite LIKE prbj_t.prbjsite, 
   prbjsite_desc LIKE type_t.chr500, 
   prbj002 LIKE prbj_t.prbj002, 
   prbj001 LIKE prbj_t.prbj001, 
   prbj004 LIKE prbj_t.prbj004, 
   prbj001_desc LIKE type_t.chr500, 
   prbj001_desc_desc LIKE type_t.chr500, 
   prbj001_desc_desc_desc LIKE type_t.chr10, 
   rtaxl003 LIKE type_t.chr500, 
   prbj003 LIKE prbj_t.prbj003, 
   prbj005 LIKE prbj_t.prbj005, 
   prbj005_desc LIKE type_t.chr500, 
   prbj006 LIKE prbj_t.prbj006, 
   prbj007 LIKE prbj_t.prbj007, 
   prbjseq1 LIKE prbj_t.prbjseq1, 
   prbj0081 LIKE type_t.chr10, 
   prbj0081_desc LIKE type_t.chr500, 
   prbj008 LIKE prbj_t.prbj008, 
   prbj008_desc LIKE type_t.chr500, 
   prbj0091 LIKE type_t.num20_6, 
   prbj009 LIKE prbj_t.prbj009, 
   prbj0161 LIKE type_t.dat, 
   prbj0171 LIKE type_t.dat, 
   prbj016 LIKE prbj_t.prbj016, 
   prbj017 LIKE prbj_t.prbj017, 
   prbj0101 LIKE type_t.chr10, 
   prbj0101_desc LIKE type_t.chr500, 
   prbj010 LIKE prbj_t.prbj010, 
   prbj010_desc LIKE type_t.chr500, 
   prbj0111 LIKE type_t.num20_6, 
   prbj011 LIKE prbj_t.prbj011, 
   prbj0181 LIKE type_t.dat, 
   prbj0191 LIKE type_t.dat, 
   prbj018 LIKE prbj_t.prbj018, 
   prbj019 LIKE prbj_t.prbj019, 
   prbj0121 LIKE type_t.num20_6, 
   prbj0131 LIKE type_t.num20_6, 
   prbj0141 LIKE type_t.num20_6, 
   prbj012 LIKE prbj_t.prbj012, 
   prbj013 LIKE prbj_t.prbj013, 
   prbj014 LIKE prbj_t.prbj014, 
   prbj0151 LIKE type_t.num20_6, 
   prbj015 LIKE prbj_t.prbj015, 
   prbjunit LIKE prbj_t.prbjunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prbisite LIKE prbi_t.prbisite,
   b_prbisite_desc LIKE type_t.chr80,
      b_prbidocdt LIKE prbi_t.prbidocdt,
      b_prbidocno LIKE prbi_t.prbidocno,
      b_prbi001 LIKE prbi_t.prbi001,
   b_prbi001_desc LIKE type_t.chr80,
      b_prbi002 LIKE prbi_t.prbi002,
   b_prbi002_desc LIKE type_t.chr80,
      b_prbi003 LIKE prbi_t.prbi003,
      b_prbi004 LIKE prbi_t.prbi004,
   b_prbi004_desc LIKE type_t.chr80,
      b_prbi005 LIKE prbi_t.prbi005,
   b_prbi005_desc LIKE type_t.chr80,
      b_prbi006 LIKE prbi_t.prbi006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_cmd         STRING
DEFINE g_errno       STRING
DEFINE g_num1        LIKE type_t.num5
DEFINE g_site_flag   LIKE type_t.num5
DEFINE g_flag1       LIKE type_t.chr1     #  #控制栏位是否带默认值，'N'时带值，'Y'不带值
DEFINE g_flag2       LIKE type_t.chr1     #  #控制栏位是否带默认值，'N'时带值，'Y'不带值
DEFINE g_prbi000     LIKE prbi_t.prbi000  
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prbi_m          type_g_prbi_m
DEFINE g_prbi_m_t        type_g_prbi_m
DEFINE g_prbi_m_o        type_g_prbi_m
DEFINE g_prbi_m_mask_o   type_g_prbi_m #轉換遮罩前資料
DEFINE g_prbi_m_mask_n   type_g_prbi_m #轉換遮罩後資料
 
   DEFINE g_prbidocno_t LIKE prbi_t.prbidocno
 
 
DEFINE g_prbj_d          DYNAMIC ARRAY OF type_g_prbj_d
DEFINE g_prbj_d_t        type_g_prbj_d
DEFINE g_prbj_d_o        type_g_prbj_d
DEFINE g_prbj_d_mask_o   DYNAMIC ARRAY OF type_g_prbj_d #轉換遮罩前資料
DEFINE g_prbj_d_mask_n   DYNAMIC ARRAY OF type_g_prbj_d #轉換遮罩後資料
 
 
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
 
{<section id="aprt122.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_prbi000 = g_argv[1]  
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prbisite,'',prbidocdt,prbidocno,prbiunit,prbi001,'',prbi002,'',prbi003, 
       prbi000,prbi004,'',prbi005,'',prbi006,prbistus,prbiownid,'',prbiowndp,'',prbicrtid,'',prbicrtdp, 
       '',prbicrtdt,prbimodid,'',prbimoddt,prbicnfid,'',prbicnfdt", 
                      " FROM prbi_t",
                      " WHERE prbient= ? AND prbidocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt122_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prbisite,t0.prbidocdt,t0.prbidocno,t0.prbiunit,t0.prbi001,t0.prbi002, 
       t0.prbi003,t0.prbi000,t0.prbi004,t0.prbi005,t0.prbi006,t0.prbistus,t0.prbiownid,t0.prbiowndp, 
       t0.prbicrtid,t0.prbicrtdp,t0.prbicrtdt,t0.prbimodid,t0.prbimoddt,t0.prbicnfid,t0.prbicnfdt,t1.ooefl003 , 
       t2.pmaal004 ,t3.rtaxl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM prbi_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbisite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prbi001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.prbi002 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prbi004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prbi005 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.prbiownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.prbiowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prbicrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.prbicrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.prbimodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prbicnfid  ",
 
               " WHERE t0.prbient = " ||g_enterprise|| " AND t0.prbidocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt122_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt122 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt122_init()   
 
      #進入選單 Menu (="N")
      CALL aprt122_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt122
      
   END IF 
   
   CLOSE aprt122_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt122.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt122_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 #add by geza 20160304
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
      CALL cl_set_combo_scc_part('prbistus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prbjseq1','6032') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success  
   CALL cl_set_comp_visible("prbi003",FALSE)        
   LET g_errshow = '1'
   CALL cl_set_comp_visible("prbj017,prbj019,prbj0171,prbj0191",FALSE) 
   #20150704--add by dongsz--s
   IF g_prbi000 = '4' THEN
      CALL cl_set_comp_required("prbi001",TRUE)
   ELSE
      CALL cl_set_comp_required("prbi001",FALSE)
   END IF
   #20150704--add by dongsz--e
   #IF g_prbi000='2' THEN     #20150704--mark by dongsz
   IF g_prbi000 = '5' THEN     #20150704--add by dongsz
      CALL cl_set_comp_visible("prbj008,prbj008_desc,prbj009,prbj016,prbj017",FALSE)    
      CALL cl_set_comp_visible("prbj0081,prbj0081_desc,prbj0091,prbj0161,prbj0171",FALSE)      
   END IF
   #add by geza 20160304(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','10') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbj0121",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','11') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbj0131",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','12') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbj0141",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','13') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbj012",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','14') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbj013",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','15') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbj014",l_gzcbl004)
   #add by geza 20160304(E) 
   #end add-point
   
   #初始化搜尋條件
   CALL aprt122_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt122.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt122_ui_dialog()
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
            CALL aprt122_insert()
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
         INITIALIZE g_prbi_m.* TO NULL
         CALL g_prbj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt122_init()
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
               
               CALL aprt122_fetch('') # reload data
               LET l_ac = 1
               CALL aprt122_ui_detailshow() #Setting the current row 
         
               CALL aprt122_idx_chk()
               #NEXT FIELD prbjseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prbj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt122_idx_chk()
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
               CALL aprt122_idx_chk()
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
            CALL aprt122_browser_fill("")
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
               CALL aprt122_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt122_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt122_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt122_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt122_set_act_visible()   
            CALL aprt122_set_act_no_visible()
            IF NOT (g_prbi_m.prbidocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prbient = " ||g_enterprise|| " AND",
                                  " prbidocno = '", g_prbi_m.prbidocno, "' "
 
               #填到對應位置
               CALL aprt122_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prbi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbj_t" 
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
               CALL aprt122_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prbi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbj_t" 
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
                  CALL aprt122_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt122_fetch("F")
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
               CALL aprt122_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt122_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt122_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt122_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt122_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt122_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt122_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt122_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt122_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt122_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt122_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prbj_d)
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
               NEXT FIELD prbjseq
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
               CALL aprt122_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt122_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aprq124
            LET g_action_choice="open_aprq124"
            IF cl_auth_chk_act("open_aprq124") THEN
               
               #add-point:ON ACTION open_aprq124 name="menu.open_aprq124"
               IF NOT cl_null(g_detail_idx) AND g_detail_idx <> 0 THEN
                  IF NOT cl_null(g_prbj_d[g_detail_idx].prbj001) THEN
                     LET la_param.prog = "aprq124"
                     LET la_param.param[1] = g_prbj_d[g_detail_idx].prbj001
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun_wait(ls_js)
                  ELSE
                     LET l_cmd = "aprq124"
                     CALL cl_cmdrun_wait(l_cmd)
                  END IF
               ELSE
                  LET l_cmd = "aprq124"
                  CALL cl_cmdrun_wait(l_cmd)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt122_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt122_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt122_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt122_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt122_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               #20150716 add by dongsz--s
               LET g_etlparam[1].para_id = "g_docno"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_prbi_m.prbidocno
               
               #20150729-add by dongsz-s
               LET g_etlparam[2].para_id = "g_site"
               LET g_etlparam[2].type = "string"
               LET g_etlparam[2].value = g_prbi_m.prbisite

               LET g_etlparam[3].para_id = "g_sdate"
               LET g_etlparam[3].type = "date"
               LET g_etlparam[3].value = g_prbi_m.prbi003
               #20150729-add by dongsz-e
               
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)

               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)

               CALL aprt122_b_fill()
               #20150716 add by dongsz--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN
               
               #add-point:ON ACTION excel_example name="menu.excel_example"
               #20150716 add by dongsz--s
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #20150716 add by dongsz--e
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt122_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt122_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt122_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prbi_m.prbidocdt)
 
 
 
         
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
 
{<section id="aprt122.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt122_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prbisite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where," AND prbi000 = '",g_prbi000,"' "
   LET l_wc  = g_wc.trim() 
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prbidocno ",
                      " FROM prbi_t ",
                      " ",
                      " LEFT JOIN prbj_t ON prbjent = prbient AND prbidocno = prbjdocno ", "  ",
                      #add-point:browser_fill段sql(prbj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE prbient = " ||g_enterprise|| " AND prbjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prbi_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prbidocno ",
                      " FROM prbi_t ", 
                      "  ",
                      "  ",
                      " WHERE prbient = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prbi_t")
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
      INITIALIZE g_prbi_m.* TO NULL
      CALL g_prbj_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prbisite,t0.prbidocdt,t0.prbidocno,t0.prbi001,t0.prbi002,t0.prbi003,t0.prbi004,t0.prbi005,t0.prbi006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prbistus,t0.prbisite,t0.prbidocdt,t0.prbidocno,t0.prbi001,t0.prbi002, 
          t0.prbi003,t0.prbi004,t0.prbi005,t0.prbi006,t1.ooefl003 ,t2.pmaal004 ,t3.rtaxl003 ,t4.ooag011 , 
          t5.ooefl003 ",
                  " FROM prbi_t t0",
                  "  ",
                  "  LEFT JOIN prbj_t ON prbjent = prbient AND prbidocno = prbjdocno ", "  ", 
                  #add-point:browser_fill段sql(prbj_t1) name="browser_fill.join.prbj_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbisite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prbi001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.prbi002 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prbi004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prbi005 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prbient = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prbi_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prbistus,t0.prbisite,t0.prbidocdt,t0.prbidocno,t0.prbi001,t0.prbi002, 
          t0.prbi003,t0.prbi004,t0.prbi005,t0.prbi006,t1.ooefl003 ,t2.pmaal004 ,t3.rtaxl003 ,t4.ooag011 , 
          t5.ooefl003 ",
                  " FROM prbi_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbisite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prbi001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.prbi002 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prbi004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prbi005 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prbient = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prbi_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prbidocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prbi_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prbisite,g_browser[g_cnt].b_prbidocdt, 
          g_browser[g_cnt].b_prbidocno,g_browser[g_cnt].b_prbi001,g_browser[g_cnt].b_prbi002,g_browser[g_cnt].b_prbi003, 
          g_browser[g_cnt].b_prbi004,g_browser[g_cnt].b_prbi005,g_browser[g_cnt].b_prbi006,g_browser[g_cnt].b_prbisite_desc, 
          g_browser[g_cnt].b_prbi001_desc,g_browser[g_cnt].b_prbi002_desc,g_browser[g_cnt].b_prbi004_desc, 
          g_browser[g_cnt].b_prbi005_desc
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
         CALL aprt122_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prbidocno) THEN
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
 
{<section id="aprt122.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt122_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prbi_m.prbidocno = g_browser[g_current_idx].b_prbidocno   
 
   EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
       g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
       g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
       g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
       g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
       g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid_desc, 
       g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc
   
   CALL aprt122_prbi_t_mask()
   CALL aprt122_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt122.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt122_ui_detailshow()
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
 
{<section id="aprt122.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt122_ui_browser_refresh()
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
      IF g_browser[l_i].b_prbidocno = g_prbi_m.prbidocno 
 
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
 
{<section id="aprt122.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt122_construct()
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
   INITIALIZE g_prbi_m.* TO NULL
   CALL g_prbj_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON prbisite,prbidocdt,prbidocno,prbiunit,prbi001,prbi002,prbi003,prbi000, 
          prbi004,prbi005,prbi006,prbistus,prbiownid,prbiowndp,prbicrtid,prbicrtdp,prbicrtdt,prbimodid, 
          prbimoddt,prbicnfid,prbicnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbicrtdt>>----
         AFTER FIELD prbicrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbimoddt>>----
         AFTER FIELD prbimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbicnfdt>>----
         AFTER FIELD prbicnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbipstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prbisite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbisite
            #add-point:ON ACTION controlp INFIELD prbisite name="construct.c.prbisite"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbisite',g_site,'i')   
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prbisite  #顯示到畫面上

            NEXT FIELD prbisite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbisite
            #add-point:BEFORE FIELD prbisite name="construct.b.prbisite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbisite
            
            #add-point:AFTER FIELD prbisite name="construct.a.prbisite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbidocdt
            #add-point:BEFORE FIELD prbidocdt name="construct.b.prbidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbidocdt
            
            #add-point:AFTER FIELD prbidocdt name="construct.a.prbidocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbidocdt
            #add-point:ON ACTION controlp INFIELD prbidocdt name="construct.c.prbidocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbidocno
            #add-point:ON ACTION controlp INFIELD prbidocno name="construct.c.prbidocno"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.where=" prbi000='",g_prbi000,"'"
            CALL q_prbidocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbidocno  #顯示到畫面上


            NEXT FIELD prbidocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbidocno
            #add-point:BEFORE FIELD prbidocno name="construct.b.prbidocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbidocno
            
            #add-point:AFTER FIELD prbidocno name="construct.a.prbidocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbiunit
            #add-point:BEFORE FIELD prbiunit name="construct.b.prbiunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbiunit
            
            #add-point:AFTER FIELD prbiunit name="construct.a.prbiunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbiunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbiunit
            #add-point:ON ACTION controlp INFIELD prbiunit name="construct.c.prbiunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi001
            #add-point:ON ACTION controlp INFIELD prbi001 name="construct.c.prbi001"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbi001  #顯示到畫面上

            NEXT FIELD prbi001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi001
            #add-point:BEFORE FIELD prbi001 name="construct.b.prbi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi001
            
            #add-point:AFTER FIELD prbi001 name="construct.a.prbi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi002
            #add-point:ON ACTION controlp INFIELD prbi002 name="construct.c.prbi002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_rtax001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbi002  #顯示到畫面上

            NEXT FIELD prbi002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi002
            #add-point:BEFORE FIELD prbi002 name="construct.b.prbi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi002
            
            #add-point:AFTER FIELD prbi002 name="construct.a.prbi002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi003
            #add-point:BEFORE FIELD prbi003 name="construct.b.prbi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi003
            
            #add-point:AFTER FIELD prbi003 name="construct.a.prbi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi003
            #add-point:ON ACTION controlp INFIELD prbi003 name="construct.c.prbi003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi000
            #add-point:BEFORE FIELD prbi000 name="construct.b.prbi000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi000
            
            #add-point:AFTER FIELD prbi000 name="construct.a.prbi000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbi000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi000
            #add-point:ON ACTION controlp INFIELD prbi000 name="construct.c.prbi000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbi004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi004
            #add-point:ON ACTION controlp INFIELD prbi004 name="construct.c.prbi004"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbi004  #顯示到畫面上

            NEXT FIELD prbi004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi004
            #add-point:BEFORE FIELD prbi004 name="construct.b.prbi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi004
            
            #add-point:AFTER FIELD prbi004 name="construct.a.prbi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi005
            #add-point:ON ACTION controlp INFIELD prbi005 name="construct.c.prbi005"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbi005  #顯示到畫面上

            NEXT FIELD prbi005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi005
            #add-point:BEFORE FIELD prbi005 name="construct.b.prbi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi005
            
            #add-point:AFTER FIELD prbi005 name="construct.a.prbi005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi006
            #add-point:BEFORE FIELD prbi006 name="construct.b.prbi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi006
            
            #add-point:AFTER FIELD prbi006 name="construct.a.prbi006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbi006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi006
            #add-point:ON ACTION controlp INFIELD prbi006 name="construct.c.prbi006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbistus
            #add-point:BEFORE FIELD prbistus name="construct.b.prbistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbistus
            
            #add-point:AFTER FIELD prbistus name="construct.a.prbistus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbistus
            #add-point:ON ACTION controlp INFIELD prbistus name="construct.c.prbistus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbiownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbiownid
            #add-point:ON ACTION controlp INFIELD prbiownid name="construct.c.prbiownid"
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbiownid  #顯示到畫面上

            NEXT FIELD prbiownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbiownid
            #add-point:BEFORE FIELD prbiownid name="construct.b.prbiownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbiownid
            
            #add-point:AFTER FIELD prbiownid name="construct.a.prbiownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbiowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbiowndp
            #add-point:ON ACTION controlp INFIELD prbiowndp name="construct.c.prbiowndp"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbiowndp  #顯示到畫面上

            NEXT FIELD prbiowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbiowndp
            #add-point:BEFORE FIELD prbiowndp name="construct.b.prbiowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbiowndp
            
            #add-point:AFTER FIELD prbiowndp name="construct.a.prbiowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbicrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbicrtid
            #add-point:ON ACTION controlp INFIELD prbicrtid name="construct.c.prbicrtid"
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbicrtid  #顯示到畫面上

            NEXT FIELD prbicrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbicrtid
            #add-point:BEFORE FIELD prbicrtid name="construct.b.prbicrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbicrtid
            
            #add-point:AFTER FIELD prbicrtid name="construct.a.prbicrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbicrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbicrtdp
            #add-point:ON ACTION controlp INFIELD prbicrtdp name="construct.c.prbicrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbicrtdp  #顯示到畫面上

            NEXT FIELD prbicrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbicrtdp
            #add-point:BEFORE FIELD prbicrtdp name="construct.b.prbicrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbicrtdp
            
            #add-point:AFTER FIELD prbicrtdp name="construct.a.prbicrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbicrtdt
            #add-point:BEFORE FIELD prbicrtdt name="construct.b.prbicrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbimodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbimodid
            #add-point:ON ACTION controlp INFIELD prbimodid name="construct.c.prbimodid"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbimodid  #顯示到畫面上

            NEXT FIELD prbimodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbimodid
            #add-point:BEFORE FIELD prbimodid name="construct.b.prbimodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbimodid
            
            #add-point:AFTER FIELD prbimodid name="construct.a.prbimodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbimoddt
            #add-point:BEFORE FIELD prbimoddt name="construct.b.prbimoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbicnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbicnfid
            #add-point:ON ACTION controlp INFIELD prbicnfid name="construct.c.prbicnfid"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbicnfid  #顯示到畫面上

            NEXT FIELD prbicnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbicnfid
            #add-point:BEFORE FIELD prbicnfid name="construct.b.prbicnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbicnfid
            
            #add-point:AFTER FIELD prbicnfid name="construct.a.prbicnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbicnfdt
            #add-point:BEFORE FIELD prbicnfdt name="construct.b.prbicnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prbjseq,prbjsite,prbj002,prbj001,prbj004,rtaxl003,prbj003,prbj005,prbj006, 
          prbj007,prbjseq1,prbj0081_desc,prbj008,prbj008_desc,prbj009,prbj016,prbj017,prbj0101_desc, 
          prbj010,prbj010_desc,prbj011,prbj018,prbj019,prbj012,prbj013,prbj014,prbj015,prbjunit
           FROM s_detail1[1].prbjseq,s_detail1[1].prbjsite,s_detail1[1].prbj002,s_detail1[1].prbj001, 
               s_detail1[1].prbj004,s_detail1[1].rtaxl003,s_detail1[1].prbj003,s_detail1[1].prbj005, 
               s_detail1[1].prbj006,s_detail1[1].prbj007,s_detail1[1].prbjseq1,s_detail1[1].prbj0081_desc, 
               s_detail1[1].prbj008,s_detail1[1].prbj008_desc,s_detail1[1].prbj009,s_detail1[1].prbj016, 
               s_detail1[1].prbj017,s_detail1[1].prbj0101_desc,s_detail1[1].prbj010,s_detail1[1].prbj010_desc, 
               s_detail1[1].prbj011,s_detail1[1].prbj018,s_detail1[1].prbj019,s_detail1[1].prbj012,s_detail1[1].prbj013, 
               s_detail1[1].prbj014,s_detail1[1].prbj015,s_detail1[1].prbjunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjseq
            #add-point:BEFORE FIELD prbjseq name="construct.b.page1.prbjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjseq
            
            #add-point:AFTER FIELD prbjseq name="construct.a.page1.prbjseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjseq
            #add-point:ON ACTION controlp INFIELD prbjseq name="construct.c.page1.prbjseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjsite
            #add-point:ON ACTION controlp INFIELD prbjsite name="construct.c.page1.prbjsite"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbjsite',g_site,'c')   
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prbjsite  #顯示到畫面上 

            NEXT FIELD prbjsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjsite
            #add-point:BEFORE FIELD prbjsite name="construct.b.page1.prbjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjsite
            
            #add-point:AFTER FIELD prbjsite name="construct.a.page1.prbjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj002
            #add-point:ON ACTION controlp INFIELD prbj002 name="construct.c.page1.prbj002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_prbj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj002  #顯示到畫面上

            NEXT FIELD prbj002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj002
            #add-point:BEFORE FIELD prbj002 name="construct.b.page1.prbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj002
            
            #add-point:AFTER FIELD prbj002 name="construct.a.page1.prbj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj001
            #add-point:ON ACTION controlp INFIELD prbj001 name="construct.c.page1.prbj001"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_prbj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj001  #顯示到畫面上

            NEXT FIELD prbj001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj001
            #add-point:BEFORE FIELD prbj001 name="construct.b.page1.prbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj001
            
            #add-point:AFTER FIELD prbj001 name="construct.a.page1.prbj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj004
            #add-point:ON ACTION controlp INFIELD prbj004 name="construct.c.page1.prbj004"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_prbj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj004  #顯示到畫面上

            NEXT FIELD prbj004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj004
            #add-point:BEFORE FIELD prbj004 name="construct.b.page1.prbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj004
            
            #add-point:AFTER FIELD prbj004 name="construct.a.page1.prbj004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaxl003
            #add-point:BEFORE FIELD rtaxl003 name="construct.b.page1.rtaxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaxl003
            
            #add-point:AFTER FIELD rtaxl003 name="construct.a.page1.rtaxl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaxl003
            #add-point:ON ACTION controlp INFIELD rtaxl003 name="construct.c.page1.rtaxl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj003
            #add-point:BEFORE FIELD prbj003 name="construct.b.page1.prbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj003
            
            #add-point:AFTER FIELD prbj003 name="construct.a.page1.prbj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj003
            #add-point:ON ACTION controlp INFIELD prbj003 name="construct.c.page1.prbj003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj005
            #add-point:ON ACTION controlp INFIELD prbj005 name="construct.c.page1.prbj005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj005  #顯示到畫面上
            NEXT FIELD prbj005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj005
            #add-point:BEFORE FIELD prbj005 name="construct.b.page1.prbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj005
            
            #add-point:AFTER FIELD prbj005 name="construct.a.page1.prbj005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj006
            #add-point:BEFORE FIELD prbj006 name="construct.b.page1.prbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj006
            
            #add-point:AFTER FIELD prbj006 name="construct.a.page1.prbj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj006
            #add-point:ON ACTION controlp INFIELD prbj006 name="construct.c.page1.prbj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj007
            #add-point:BEFORE FIELD prbj007 name="construct.b.page1.prbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj007
            
            #add-point:AFTER FIELD prbj007 name="construct.a.page1.prbj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj007
            #add-point:ON ACTION controlp INFIELD prbj007 name="construct.c.page1.prbj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjseq1
            #add-point:BEFORE FIELD prbjseq1 name="construct.b.page1.prbjseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjseq1
            
            #add-point:AFTER FIELD prbjseq1 name="construct.a.page1.prbjseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbjseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjseq1
            #add-point:ON ACTION controlp INFIELD prbjseq1 name="construct.c.page1.prbjseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbj0081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0081
            #add-point:ON ACTION controlp INFIELD prbj0081 name="construct.c.page1.prbj0081"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj0081  #顯示到畫面上
            NEXT FIELD prbj0081                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0081
            #add-point:BEFORE FIELD prbj0081 name="construct.b.page1.prbj0081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0081
            
            #add-point:AFTER FIELD prbj0081 name="construct.a.page1.prbj0081"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0081_desc
            #add-point:BEFORE FIELD prbj0081_desc name="construct.b.page1.prbj0081_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0081_desc
            
            #add-point:AFTER FIELD prbj0081_desc name="construct.a.page1.prbj0081_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj0081_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0081_desc
            #add-point:ON ACTION controlp INFIELD prbj0081_desc name="construct.c.page1.prbj0081_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj008
            #add-point:ON ACTION controlp INFIELD prbj008 name="construct.c.page1.prbj008"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj008  #顯示到畫面上

            NEXT FIELD prbj008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj008
            #add-point:BEFORE FIELD prbj008 name="construct.b.page1.prbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj008
            
            #add-point:AFTER FIELD prbj008 name="construct.a.page1.prbj008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj008_desc
            #add-point:BEFORE FIELD prbj008_desc name="construct.b.page1.prbj008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj008_desc
            
            #add-point:AFTER FIELD prbj008_desc name="construct.a.page1.prbj008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj008_desc
            #add-point:ON ACTION controlp INFIELD prbj008_desc name="construct.c.page1.prbj008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj009
            #add-point:BEFORE FIELD prbj009 name="construct.b.page1.prbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj009
            
            #add-point:AFTER FIELD prbj009 name="construct.a.page1.prbj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj009
            #add-point:ON ACTION controlp INFIELD prbj009 name="construct.c.page1.prbj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj016
            #add-point:BEFORE FIELD prbj016 name="construct.b.page1.prbj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj016
            
            #add-point:AFTER FIELD prbj016 name="construct.a.page1.prbj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj016
            #add-point:ON ACTION controlp INFIELD prbj016 name="construct.c.page1.prbj016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj017
            #add-point:BEFORE FIELD prbj017 name="construct.b.page1.prbj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj017
            
            #add-point:AFTER FIELD prbj017 name="construct.a.page1.prbj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj017
            #add-point:ON ACTION controlp INFIELD prbj017 name="construct.c.page1.prbj017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbj0101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0101
            #add-point:ON ACTION controlp INFIELD prbj0101 name="construct.c.page1.prbj0101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj0101  #顯示到畫面上
            NEXT FIELD prbj0101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0101
            #add-point:BEFORE FIELD prbj0101 name="construct.b.page1.prbj0101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0101
            
            #add-point:AFTER FIELD prbj0101 name="construct.a.page1.prbj0101"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0101_desc
            #add-point:BEFORE FIELD prbj0101_desc name="construct.b.page1.prbj0101_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0101_desc
            
            #add-point:AFTER FIELD prbj0101_desc name="construct.a.page1.prbj0101_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj0101_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0101_desc
            #add-point:ON ACTION controlp INFIELD prbj0101_desc name="construct.c.page1.prbj0101_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbj010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj010
            #add-point:ON ACTION controlp INFIELD prbj010 name="construct.c.page1.prbj010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_site
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbj010  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oodb002 #稅別代碼 

            NEXT FIELD prbj010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj010
            #add-point:BEFORE FIELD prbj010 name="construct.b.page1.prbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj010
            
            #add-point:AFTER FIELD prbj010 name="construct.a.page1.prbj010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj010_desc
            #add-point:BEFORE FIELD prbj010_desc name="construct.b.page1.prbj010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj010_desc
            
            #add-point:AFTER FIELD prbj010_desc name="construct.a.page1.prbj010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj010_desc
            #add-point:ON ACTION controlp INFIELD prbj010_desc name="construct.c.page1.prbj010_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj011
            #add-point:BEFORE FIELD prbj011 name="construct.b.page1.prbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj011
            
            #add-point:AFTER FIELD prbj011 name="construct.a.page1.prbj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj011
            #add-point:ON ACTION controlp INFIELD prbj011 name="construct.c.page1.prbj011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj018
            #add-point:BEFORE FIELD prbj018 name="construct.b.page1.prbj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj018
            
            #add-point:AFTER FIELD prbj018 name="construct.a.page1.prbj018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj018
            #add-point:ON ACTION controlp INFIELD prbj018 name="construct.c.page1.prbj018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj019
            #add-point:BEFORE FIELD prbj019 name="construct.b.page1.prbj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj019
            
            #add-point:AFTER FIELD prbj019 name="construct.a.page1.prbj019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj019
            #add-point:ON ACTION controlp INFIELD prbj019 name="construct.c.page1.prbj019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj012
            #add-point:BEFORE FIELD prbj012 name="construct.b.page1.prbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj012
            
            #add-point:AFTER FIELD prbj012 name="construct.a.page1.prbj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj012
            #add-point:ON ACTION controlp INFIELD prbj012 name="construct.c.page1.prbj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj013
            #add-point:BEFORE FIELD prbj013 name="construct.b.page1.prbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj013
            
            #add-point:AFTER FIELD prbj013 name="construct.a.page1.prbj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj013
            #add-point:ON ACTION controlp INFIELD prbj013 name="construct.c.page1.prbj013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj014
            #add-point:BEFORE FIELD prbj014 name="construct.b.page1.prbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj014
            
            #add-point:AFTER FIELD prbj014 name="construct.a.page1.prbj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj014
            #add-point:ON ACTION controlp INFIELD prbj014 name="construct.c.page1.prbj014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj015
            #add-point:BEFORE FIELD prbj015 name="construct.b.page1.prbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj015
            
            #add-point:AFTER FIELD prbj015 name="construct.a.page1.prbj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj015
            #add-point:ON ACTION controlp INFIELD prbj015 name="construct.c.page1.prbj015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjunit
            #add-point:BEFORE FIELD prbjunit name="construct.b.page1.prbjunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjunit
            
            #add-point:AFTER FIELD prbjunit name="construct.a.page1.prbjunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbjunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjunit
            #add-point:ON ACTION controlp INFIELD prbjunit name="construct.c.page1.prbjunit"
            
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
                  WHEN la_wc[li_idx].tableid = "prbi_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prbj_t" 
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
 
{<section id="aprt122.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt122_filter()
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
      CONSTRUCT g_wc_filter ON prbisite,prbidocdt,prbidocno,prbi001,prbi002,prbi003,prbi004,prbi005, 
          prbi006
                          FROM s_browse[1].b_prbisite,s_browse[1].b_prbidocdt,s_browse[1].b_prbidocno, 
                              s_browse[1].b_prbi001,s_browse[1].b_prbi002,s_browse[1].b_prbi003,s_browse[1].b_prbi004, 
                              s_browse[1].b_prbi005,s_browse[1].b_prbi006
 
         BEFORE CONSTRUCT
               DISPLAY aprt122_filter_parser('prbisite') TO s_browse[1].b_prbisite
            DISPLAY aprt122_filter_parser('prbidocdt') TO s_browse[1].b_prbidocdt
            DISPLAY aprt122_filter_parser('prbidocno') TO s_browse[1].b_prbidocno
            DISPLAY aprt122_filter_parser('prbi001') TO s_browse[1].b_prbi001
            DISPLAY aprt122_filter_parser('prbi002') TO s_browse[1].b_prbi002
            DISPLAY aprt122_filter_parser('prbi003') TO s_browse[1].b_prbi003
            DISPLAY aprt122_filter_parser('prbi004') TO s_browse[1].b_prbi004
            DISPLAY aprt122_filter_parser('prbi005') TO s_browse[1].b_prbi005
            DISPLAY aprt122_filter_parser('prbi006') TO s_browse[1].b_prbi006
      
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
 
      CALL aprt122_filter_show('prbisite')
   CALL aprt122_filter_show('prbidocdt')
   CALL aprt122_filter_show('prbidocno')
   CALL aprt122_filter_show('prbi001')
   CALL aprt122_filter_show('prbi002')
   CALL aprt122_filter_show('prbi003')
   CALL aprt122_filter_show('prbi004')
   CALL aprt122_filter_show('prbi005')
   CALL aprt122_filter_show('prbi006')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt122_filter_parser(ps_field)
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
 
{<section id="aprt122.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt122_filter_show(ps_field)
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
   LET ls_condition = aprt122_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt122_query()
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
   CALL g_prbj_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt122_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt122_browser_fill("")
      CALL aprt122_fetch("")
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
      CALL aprt122_filter_show('prbisite')
   CALL aprt122_filter_show('prbidocdt')
   CALL aprt122_filter_show('prbidocno')
   CALL aprt122_filter_show('prbi001')
   CALL aprt122_filter_show('prbi002')
   CALL aprt122_filter_show('prbi003')
   CALL aprt122_filter_show('prbi004')
   CALL aprt122_filter_show('prbi005')
   CALL aprt122_filter_show('prbi006')
   CALL aprt122_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt122_fetch("F") 
      #顯示單身筆數
      CALL aprt122_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt122_fetch(p_flag)
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
   
   LET g_prbi_m.prbidocno = g_browser[g_current_idx].b_prbidocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
       g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
       g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
       g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
       g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
       g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid_desc, 
       g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc
   
   #遮罩相關處理
   LET g_prbi_m_mask_o.* =  g_prbi_m.*
   CALL aprt122_prbi_t_mask()
   LET g_prbi_m_mask_n.* =  g_prbi_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt122_set_act_visible()   
   CALL aprt122_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_prbi_m.prbistus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prbi_m_t.* = g_prbi_m.*
   LET g_prbi_m_o.* = g_prbi_m.*
   
   LET g_data_owner = g_prbi_m.prbiownid      
   LET g_data_dept  = g_prbi_m.prbiowndp
   
   #重新顯示   
   CALL aprt122_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt122_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_n           LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prbj_d.clear()   
 
 
   INITIALIZE g_prbi_m.* TO NULL             #DEFAULT 設定
   
   LET g_prbidocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbi_m.prbiownid = g_user
      LET g_prbi_m.prbiowndp = g_dept
      LET g_prbi_m.prbicrtid = g_user
      LET g_prbi_m.prbicrtdp = g_dept 
      LET g_prbi_m.prbicrtdt = cl_get_current()
      LET g_prbi_m.prbimodid = g_user
      LET g_prbi_m.prbimoddt = cl_get_current()
      LET g_prbi_m.prbistus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prbisite',g_prbi_m.prbisite)
         RETURNING l_insert,g_prbi_m.prbisite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prbi_m.prbiunit = g_prbi_m.prbisite
      LET g_prbi_m.prbidocdt = g_today
      LET g_prbi_m.prbi003 = g_today
      LET g_prbi_m.prbi004 = g_user
      LET g_prbi_m.prbi005 = g_dept
      LET g_prbi_m.prbistus = 'N'
      LET g_prbi_m.prbi000=g_prbi000
      
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prbi_m.prbisite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prbi_m.prbidocno = r_doctype
      
      #預設arti204部門品類預設值
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaz_t
       WHERE rtazent = g_enterprise
         AND rtaz001 = g_prog
      IF l_n > 0 THEN
         SELECT COUNT(*) INTO l_n
           FROM rtay_t,rtax_t,prbs_t
          WHERE rtayent = g_enterprise
            AND rtayent = rtaxent
            AND rtayent = prbsent
            AND rtay001 = g_prbi_m.prbi005
            AND rtax001 = rtay002
            AND rtax001 = prbs001
            AND rtax002 = '2' 
            AND rtaystus = rtaxstus
            AND rtaystus = 'Y'
            AND prbsstus = 'Y'
         IF l_n = 1 THEN
            SELECT rtay002 INTO g_prbi_m.prbi002
              FROM rtay_t,rtax_t,prbs_t
             WHERE rtayent = g_enterprise
               AND rtayent = rtaxent
               AND rtayent = prbsent
               AND rtay001 = g_prbi_m.prbi005
               AND rtax001 = rtay002
               AND rtax001 = prbs001
               AND rtax002 = '2' 
               AND rtaystus = rtaxstus
               AND rtaystus = 'Y'
               AND prbsstus = 'Y'
         END IF
      END IF
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prbi_m.prbi004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_prbi_m.prbi004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbi_m.prbi004_desc
            
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prbi_m.prbi005
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prbi_m.prbi005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbi_m.prbi005_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prbi_m.prbisite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prbi_m.prbisite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbi_m.prbisite_desc 
      
      LET g_prbi_m_t.* = g_prbi_m.* 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prbi_m_t.* = g_prbi_m.*
      LET g_prbi_m_o.* = g_prbi_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbi_m.prbistus 
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
 
 
 
    
      CALL aprt122_input("a")
      
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
         INITIALIZE g_prbi_m.* TO NULL
         INITIALIZE g_prbj_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt122_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prbj_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt122_set_act_visible()   
   CALL aprt122_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prbidocno_t = g_prbi_m.prbidocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prbient = " ||g_enterprise|| " AND",
                      " prbidocno = '", g_prbi_m.prbidocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt122_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt122_cl
   
   CALL aprt122_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
       g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
       g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
       g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
       g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
       g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid_desc, 
       g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc
   
   
   #遮罩相關處理
   LET g_prbi_m_mask_o.* =  g_prbi_m.*
   CALL aprt122_prbi_t_mask()
   LET g_prbi_m_mask_n.* =  g_prbi_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbisite_desc,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit, 
       g_prbi_m.prbi001,g_prbi_m.prbi001_desc,g_prbi_m.prbi002,g_prbi_m.prbi002_desc,g_prbi_m.prbi003, 
       g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi004_desc,g_prbi_m.prbi005,g_prbi_m.prbi005_desc, 
       g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp, 
       g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid,g_prbi_m.prbicrtid_desc,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdp_desc, 
       g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimodid_desc,g_prbi_m.prbimoddt,g_prbi_m.prbicnfid, 
       g_prbi_m.prbicnfid_desc,g_prbi_m.prbicnfdt
   
   #add-point:新增結束後 name="insert.after"
   CALL aprt122_show()         
   #end add-point 
   
   LET g_data_owner = g_prbi_m.prbiownid      
   LET g_data_dept  = g_prbi_m.prbiowndp
   
   #功能已完成,通報訊息中心
   CALL aprt122_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt122_modify()
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
   LET g_prbi_m_t.* = g_prbi_m.*
   LET g_prbi_m_o.* = g_prbi_m.*
   
   IF g_prbi_m.prbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prbidocno_t = g_prbi_m.prbidocno
 
   CALL s_transaction_begin()
   
   OPEN aprt122_cl USING g_enterprise,g_prbi_m.prbidocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt122_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt122_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
       g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
       g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
       g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
       g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
       g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid_desc, 
       g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt122_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prbi_m_mask_o.* =  g_prbi_m.*
   CALL aprt122_prbi_t_mask()
   LET g_prbi_m_mask_n.* =  g_prbi_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aprt122_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_prbidocno_t = g_prbi_m.prbidocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prbi_m.prbimodid = g_user 
LET g_prbi_m.prbimoddt = cl_get_current()
LET g_prbi_m.prbimodid_desc = cl_get_username(g_prbi_m.prbimodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_prbi_m.prbistus MATCHES "[DR]" THEN
         LET g_prbi_m.prbistus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt122_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prbi_t SET (prbimodid,prbimoddt) = (g_prbi_m.prbimodid,g_prbi_m.prbimoddt)
          WHERE prbient = g_enterprise AND prbidocno = g_prbidocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prbi_m.* = g_prbi_m_t.*
            CALL aprt122_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prbi_m.prbidocno != g_prbi_m_t.prbidocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prbj_t SET prbjdocno = g_prbi_m.prbidocno
 
          WHERE prbjent = g_enterprise AND prbjdocno = g_prbi_m_t.prbidocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prbj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbj_t:",SQLERRMESSAGE 
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
   CALL aprt122_set_act_visible()   
   CALL aprt122_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prbient = " ||g_enterprise|| " AND",
                      " prbidocno = '", g_prbi_m.prbidocno, "' "
 
   #填到對應位置
   CALL aprt122_browser_fill("")
 
   CLOSE aprt122_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt122_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt122.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt122_input(p_cmd)
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
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_ooaa002             LIKE ooaa_t.ooaa002
   DEFINE  l_prbhstus            LIKE prbh_t.prbhstus
   DEFINE  l_rtdxstus            LIKE rtdx_t.rtdxstus
   DEFINE  l_imaf153             LIKE imaf_t.imaf153
   DEFINE  l_imaastus            LIKE imaa_t.imaastus
   DEFINE  l_imaa009             LIKE imaa_t.imaa009
   DEFINE  l_imaystus            LIKE imay_t.imaystus
   DEFINE  l_ooef019             LIKE ooef_t.ooef019
   DEFINE  l_sql                 STRING
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_prbjsite            LIKE prbj_t.prbjsite
   DEFINE  l_prbj009             LIKE prbj_t.prbj009
   DEFINE  l_prbj011             LIKE prbj_t.prbj011 
   DEFINE  l_rtax004             LIKE rtax_t.rtax004
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
   DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbisite_desc,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit, 
       g_prbi_m.prbi001,g_prbi_m.prbi001_desc,g_prbi_m.prbi002,g_prbi_m.prbi002_desc,g_prbi_m.prbi003, 
       g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi004_desc,g_prbi_m.prbi005,g_prbi_m.prbi005_desc, 
       g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp, 
       g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid,g_prbi_m.prbicrtid_desc,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdp_desc, 
       g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimodid_desc,g_prbi_m.prbimoddt,g_prbi_m.prbicnfid, 
       g_prbi_m.prbicnfid_desc,g_prbi_m.prbicnfdt
   
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
   LET g_forupd_sql = "SELECT prbjseq,prbjsite,prbj002,prbj001,prbj004,prbj003,prbj005,prbj006,prbj007, 
       prbjseq1,prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,prbj018,prbj019,prbj012,prbj013,prbj014, 
       prbj015,prbjunit FROM prbj_t WHERE prbjent=? AND prbjdocno=? AND prbjseq=? AND prbjseq1=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt122_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt122_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt122_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001, 
       g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006, 
       g_prbi_m.prbistus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt122.input.head" >}
      #單頭段
      INPUT BY NAME g_prbi_m.prbisite,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001, 
          g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006, 
          g_prbi_m.prbistus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt122_cl USING g_enterprise,g_prbi_m.prbidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt122_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt122_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt122_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL cl_showmsg_init()
            #end add-point
            CALL aprt122_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbisite
            
            #add-point:AFTER FIELD prbisite name="input.a.prbisite"
            IF NOT cl_null(g_prbi_m.prbisite) THEN
               CALL s_aooi500_chk(g_prog,'prbisite',g_prbi_m.prbisite,g_prbi_m.prbisite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_prbi_m.prbisite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prbi_m.prbisite = g_prbi_m_t.prbisite
                  CALL s_desc_get_department_desc(g_prbi_m.prbisite) RETURNING g_prbi_m.prbisite_desc
                  DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbisite_desc
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL aprt122_set_entry(p_cmd)
               CALL aprt122_set_no_entry(p_cmd)
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbisite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbi_m.prbisite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbisite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbisite
            #add-point:BEFORE FIELD prbisite name="input.b.prbisite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbisite
            #add-point:ON CHANGE prbisite name="input.g.prbisite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbidocdt
            #add-point:BEFORE FIELD prbidocdt name="input.b.prbidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbidocdt
            
            #add-point:AFTER FIELD prbidocdt name="input.a.prbidocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbidocdt
            #add-point:ON CHANGE prbidocdt name="input.g.prbidocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbidocno
            
            #add-point:AFTER FIELD prbidocno name="input.a.prbidocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_prbi_m.prbidocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbi_m.prbidocno != g_prbidocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbi_t WHERE "||"prbient = '" ||g_enterprise|| "' AND "||"prbidocno = '"||g_prbi_m.prbidocno ||"'",'std-00004',0) THEN
                     LET g_prbi_m.prbidocno = g_prbidocno_t
                     DISPLAY BY NAME g_prbi_m.prbidocno                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_prbi_m.prbidocno) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               CALL s_aooi100_sel_ooef004(g_prbi_m.prbisite)
                    RETURNING l_success,l_ooef004
               LET g_chkparam.arg1 = l_ooef004
               LET g_chkparam.arg2 = g_prbi_m.prbidocno

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbi_m.prbidocno = g_prbidocno_t
                  DISPLAY BY NAME g_prbi_m.prbidocno
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbidocno
            #add-point:BEFORE FIELD prbidocno name="input.b.prbidocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbidocno
            #add-point:ON CHANGE prbidocno name="input.g.prbidocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbiunit
            #add-point:BEFORE FIELD prbiunit name="input.b.prbiunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbiunit
            
            #add-point:AFTER FIELD prbiunit name="input.a.prbiunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbiunit
            #add-point:ON CHANGE prbiunit name="input.g.prbiunit"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi001
            
            #add-point:AFTER FIELD prbi001 name="input.a.prbi001"
            IF NOT cl_null(g_prbi_m.prbi001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbi_m.prbi001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbi_m.prbi001 = g_prbi_m_t.prbi001
                  DISPLAY BY NAME g_prbi_m.prbi001
                  NEXT FIELD CURRENT
               END IF
               
               IF p_cmd = 'u' AND g_prbi_m.prbi001 <> g_prbi_m_t.prbi001 THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM prbj_t
                   WHERE prbjent = g_enterprise
                     AND prbjdocno = g_prbi_m.prbidocno
                  IF l_n > 0 THEN
                     SELECT COUNT(*) INTO l_n FROM imaf_t,prbj_t
                      WHERE imafent = prbjent
                        AND imaf001 = prbj001
                        AND imafent = g_enterprise
                        AND prbjdocno = g_prbi_m.prbidocno
                        AND imaf153 <> g_prbi_m.prbi001
                        AND imafsite = prbjsite  
                     IF l_n > 0 THEN                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00061'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbi_m.prbi001 = g_prbi_m_t.prbi001
                        DISPLAY BY NAME g_prbi_m.prbi001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbi001
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbi_m.prbi001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbi001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi001
            #add-point:BEFORE FIELD prbi001 name="input.b.prbi001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi001
            #add-point:ON CHANGE prbi001 name="input.g.prbi001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi002
            
            #add-point:AFTER FIELD prbi002 name="input.a.prbi002"

            IF NOT cl_null(g_prbi_m.prbi002) THEN        
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
               LET g_chkparam.arg1 = g_prbi_m.prbi002
               LET g_chkparam.arg2 = l_rtax004
               #LET g_chkparam.arg3 = 'SX01'
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_4") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbi_m.prbi002 = g_prbi_m_t.prbi002
                  DISPLAY BY NAME g_prbi_m.prbi002
                  NEXT FIELD CURRENT
               END IF

               #判断是否属于生鲜品类
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM prbs_t
                WHERE prbsent = g_enterprise
                  AND prbs001 = g_prbi_m.prbi002
                  AND prbsstus = 'Y'
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00378'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_prbi_m.prbi002 = g_prbi_m_t.prbi002
                  DISPLAY BY NAME g_prbi_m.prbi002
                  NEXT FIELD CURRENT
               END IF

               IF NOT cl_null(g_prbi_m.prbi005) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_prbi_m.prbi005
                        AND rtay002 = g_prbi_m.prbi002
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_prbi_m.prbi002 = g_prbi_m_t.prbi002
                        DISPLAY BY NAME g_prbi_m.prbi002
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            
               IF p_cmd = 'u' AND g_prbi_m.prbi002 <> g_prbi_m_t.prbi002 THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM prbj_t
                   WHERE prbjent = g_enterprise
                     AND prbjdocno = g_prbi_m.prbidocno
                  IF l_n > 0 THEN
                     SELECT COUNT(*) INTO l_n FROM imaa_t,prbj_t
                      WHERE imaaent = prbjent 
                        AND imaa001 = prbj001
                        AND imaaent = g_enterprise
                        AND prbjdocno = g_prbi_m.prbidocno
                        AND imaa009 <> g_prbi_m.prbi002
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00062'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbi_m.prbi002 = g_prbi_m_t.prbi002
                        DISPLAY BY NAME g_prbi_m.prbi002
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbi002
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbi_m.prbi002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbi002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi002
            #add-point:BEFORE FIELD prbi002 name="input.b.prbi002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi002
            #add-point:ON CHANGE prbi002 name="input.g.prbi002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi003
            #add-point:BEFORE FIELD prbi003 name="input.b.prbi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi003
            
            #add-point:AFTER FIELD prbi003 name="input.a.prbi003"
            IF NOT cl_null(g_prbi_m.prbi003) THEN
               IF g_prbi_m.prbi003 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00027'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbi_m.prbi003 = g_prbi_m_t.prbi003
                  DISPLAY BY NAME g_prbi_m.prbi003
                  NEXT FIELD prbi003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi003
            #add-point:ON CHANGE prbi003 name="input.g.prbi003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi000
            #add-point:BEFORE FIELD prbi000 name="input.b.prbi000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi000
            
            #add-point:AFTER FIELD prbi000 name="input.a.prbi000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi000
            #add-point:ON CHANGE prbi000 name="input.g.prbi000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi004
            
            #add-point:AFTER FIELD prbi004 name="input.a.prbi004"
            IF NOT cl_null(g_prbi_m.prbi004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbi_m.prbi004
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbi004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prbi_m.prbi004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbi004_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbi004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag003 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prbi_m.prbi005 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbi005
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbi005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbi_m.prbi005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbi005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi004
            #add-point:BEFORE FIELD prbi004 name="input.b.prbi004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi004
            #add-point:ON CHANGE prbi004 name="input.g.prbi004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi005
            
            #add-point:AFTER FIELD prbi005 name="input.a.prbi005"
            IF NOT cl_null(g_prbi_m.prbi005) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbi_m.prbi005
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            
               #150401-00003#1--add by dongsz--str---
               IF NOT cl_null(g_prbi_m.prbi002) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_prbi_m.prbi005
                        AND rtay002 = g_prbi_m.prbi002
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_prbi_m.prbi005 = g_prbi_m_t.prbi005
                        DISPLAY BY NAME g_prbi_m.prbi005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbi_m.prbi005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbi_m.prbi005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbi_m.prbi005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi005
            #add-point:BEFORE FIELD prbi005 name="input.b.prbi005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi005
            #add-point:ON CHANGE prbi005 name="input.g.prbi005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbi006
            #add-point:BEFORE FIELD prbi006 name="input.b.prbi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbi006
            
            #add-point:AFTER FIELD prbi006 name="input.a.prbi006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbi006
            #add-point:ON CHANGE prbi006 name="input.g.prbi006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbistus
            #add-point:BEFORE FIELD prbistus name="input.b.prbistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbistus
            
            #add-point:AFTER FIELD prbistus name="input.a.prbistus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbistus
            #add-point:ON CHANGE prbistus name="input.g.prbistus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prbisite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbisite
            #add-point:ON ACTION controlp INFIELD prbisite name="input.c.prbisite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbi_m.prbisite             #給予default值

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbisite',g_prbi_m.prbisite,'i')   
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prbi_m.prbisite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_prbi_m.prbisite TO prbisite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_prbi_m.prbisite)
               RETURNING g_prbi_m.prbisite_desc
            DISPLAY BY NAME g_prbi_m.prbisite_desc

            NEXT FIELD prbisite
            #END add-point
 
 
         #Ctrlp:input.c.prbidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbidocdt
            #add-point:ON ACTION controlp INFIELD prbidocdt name="input.c.prbidocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbidocno
            #add-point:ON ACTION controlp INFIELD prbidocno name="input.c.prbidocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbi_m.prbidocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_prbi_m.prbisite)
               RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prbi_m.prbidocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbi_m.prbidocno TO prbidocno              #顯示到畫面上

            NEXT FIELD prbidocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbiunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbiunit
            #add-point:ON ACTION controlp INFIELD prbiunit name="input.c.prbiunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi001
            #add-point:ON ACTION controlp INFIELD prbi001 name="input.c.prbi001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbi_m.prbi001             #給予default值
            LET g_qryparam.default2 = g_prbi_m.prbi001_desc #交易對象簡稱

            #給予arg

            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_prbi_m.prbi001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbi_m.prbi001_desc = g_qryparam.return2 #交易對象簡稱

            DISPLAY g_prbi_m.prbi001 TO prbi001              #顯示到畫面上
            DISPLAY g_prbi_m.prbi001_desc TO prbi001_desc #交易對象簡稱

            NEXT FIELD prbi001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi002
            #add-point:ON ACTION controlp INFIELD prbi002 name="input.c.prbi002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbi_m.prbi002             #給予default值
            LET g_qryparam.default2 = g_prbi_m.prbi002_desc #品類編號

            #給予arg
            LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')

            LET g_qryparam.arg1 = l_rtax004 #

            SELECT COUNT(*) INTO l_n
              FROM rtaz_t
             WHERE rtazent = g_enterprise
               AND rtaz001 = g_prog
               AND rtazstus = 'Y'
            IF l_n > 0 THEN
               LET g_qryparam.where = " rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                                      "                AND rtay001 = '",g_prbi_m.prbi005,"' AND rtaystus = 'Y') "
            END IF

            CALL q_rtax001_5()                                #呼叫開窗

            LET g_prbi_m.prbi002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbi_m.prbi002_desc = g_qryparam.return2 #品類編號

            DISPLAY g_prbi_m.prbi002 TO prbi002              #顯示到畫面上
            DISPLAY g_prbi_m.prbi002_desc TO prbi002_desc #品類編號

            NEXT FIELD prbi002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi003
            #add-point:ON ACTION controlp INFIELD prbi003 name="input.c.prbi003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbi000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi000
            #add-point:ON ACTION controlp INFIELD prbi000 name="input.c.prbi000"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbi004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi004
            #add-point:ON ACTION controlp INFIELD prbi004 name="input.c.prbi004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbi_m.prbi004             #給予default值
            LET g_qryparam.default2 = g_prbi_m.prbi004_desc   #全名
            LET g_qryparam.default3 = g_prbi_m.prbi005        #歸屬部門
            LET g_qryparam.default4 = g_prbi_m.prbi005_desc   #說明(簡稱)

            #給予arg

            CALL q_ooag001_6()                                #呼叫開窗

            LET g_prbi_m.prbi004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbi_m.prbi004_desc = g_qryparam.return2  #全名
            LET g_prbi_m.prbi005 = g_qryparam.return3       #歸屬部門
            LET g_prbi_m.prbi005_desc = g_qryparam.return4  #說明(簡稱)

            DISPLAY g_prbi_m.prbi004 TO prbi004              #顯示到畫面上
            DISPLAY g_prbi_m.prbi004_desc TO prbi004_desc  #全名
            DISPLAY g_prbi_m.prbi005 TO prbi005            #歸屬部門
            DISPLAY g_prbi_m.prbi005_desc TO prbi005_desc  #說明(簡稱)

            NEXT FIELD prbi004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi005
            #add-point:ON ACTION controlp INFIELD prbi005 name="input.c.prbi005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbi_m.prbi005             #給予default值
            LET g_qryparam.default2 = g_prbi_m.prbi005_desc #部門編號

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_prbi_m.prbi005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbi_m.prbi005_desc = g_qryparam.return2 #部門編號

            DISPLAY g_prbi_m.prbi005 TO prbi005              #顯示到畫面上
            DISPLAY g_prbi_m.prbi005_desc TO prbi005_desc #部門編號

            NEXT FIELD prbi005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbi006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbi006
            #add-point:ON ACTION controlp INFIELD prbi006 name="input.c.prbi006"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbistus
            #add-point:ON ACTION controlp INFIELD prbistus name="input.c.prbistus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prbi_m.prbidocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_prbi_m.prbisite,g_prbi_m.prbidocno,g_prbi_m.prbidocdt,g_prog) RETURNING l_flag,g_prbi_m.prbidocno
               IF NOT l_flag THEN
                  NEXT FIELD prbidocno
               END IF
               
               LET g_prbi_m.prbi000=g_prbi000
        
               #end add-point
               
               INSERT INTO prbi_t (prbient,prbisite,prbidocdt,prbidocno,prbiunit,prbi001,prbi002,prbi003, 
                   prbi000,prbi004,prbi005,prbi006,prbistus,prbiownid,prbiowndp,prbicrtid,prbicrtdp, 
                   prbicrtdt,prbimodid,prbimoddt,prbicnfid,prbicnfdt)
               VALUES (g_enterprise,g_prbi_m.prbisite,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit, 
                   g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000,g_prbi_m.prbi004, 
                   g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
                   g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
                   g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prbi_m:",SQLERRMESSAGE 
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
                  CALL aprt122_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt122_b_fill()
                  CALL aprt122_b_fill2('0')
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
               CALL aprt122_prbi_t_mask_restore('restore_mask_o')
               
               UPDATE prbi_t SET (prbisite,prbidocdt,prbidocno,prbiunit,prbi001,prbi002,prbi003,prbi000, 
                   prbi004,prbi005,prbi006,prbistus,prbiownid,prbiowndp,prbicrtid,prbicrtdp,prbicrtdt, 
                   prbimodid,prbimoddt,prbicnfid,prbicnfdt) = (g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
                   g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003, 
                   g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus, 
                   g_prbi_m.prbiownid,g_prbi_m.prbiowndp,g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt, 
                   g_prbi_m.prbimodid,g_prbi_m.prbimoddt,g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt)
                WHERE prbient = g_enterprise AND prbidocno = g_prbidocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prbi_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt122_prbi_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prbi_m_t)
               LET g_log2 = util.JSON.stringify(g_prbi_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prbidocno_t = g_prbi_m.prbidocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt122.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prbj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert_prbj
            LET g_action_choice="insert_prbj"
            IF cl_auth_chk_act("insert_prbj") THEN
               
               #add-point:ON ACTION insert_prbj name="input.detail_input.page1.insert_prbj"
               CALL aprt114_01(g_prog,g_prbi_m.prbidocno)
               CALL aprt122_b_fill()
               EXIT DIALOG
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt122_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prbj_d.getLength()
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
            OPEN aprt122_cl USING g_enterprise,g_prbi_m.prbidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt122_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt122_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prbj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prbj_d[l_ac].prbjseq IS NOT NULL
               AND g_prbj_d[l_ac].prbjseq1 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prbj_d_t.* = g_prbj_d[l_ac].*  #BACKUP
               LET g_prbj_d_o.* = g_prbj_d[l_ac].*  #BACKUP
               CALL aprt122_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               LET g_prbj_d[l_ac].prbjseq1=1
               #end add-point  
               CALL aprt122_set_no_entry_b(l_cmd)
               IF NOT aprt122_lock_b("prbj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt122_bcl INTO g_prbj_d[l_ac].prbjseq,g_prbj_d[l_ac].prbjsite,g_prbj_d[l_ac].prbj002, 
                      g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj004,g_prbj_d[l_ac].prbj003,g_prbj_d[l_ac].prbj005, 
                      g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007,g_prbj_d[l_ac].prbjseq1,g_prbj_d[l_ac].prbj008, 
                      g_prbj_d[l_ac].prbj009,g_prbj_d[l_ac].prbj016,g_prbj_d[l_ac].prbj017,g_prbj_d[l_ac].prbj010, 
                      g_prbj_d[l_ac].prbj011,g_prbj_d[l_ac].prbj018,g_prbj_d[l_ac].prbj019,g_prbj_d[l_ac].prbj012, 
                      g_prbj_d[l_ac].prbj013,g_prbj_d[l_ac].prbj014,g_prbj_d[l_ac].prbj015,g_prbj_d[l_ac].prbjunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prbj_d_t.prbjseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prbj_d_mask_o[l_ac].* =  g_prbj_d[l_ac].*
                  CALL aprt122_prbj_t_mask()
                  LET g_prbj_d_mask_n[l_ac].* =  g_prbj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt122_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_flag1 = 'N'       
            LET g_flag2 = 'N'                               
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
            INITIALIZE g_prbj_d[l_ac].* TO NULL 
            INITIALIZE g_prbj_d_t.* TO NULL 
            INITIALIZE g_prbj_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prbj_d[l_ac].prbj006 = "0"
      LET g_prbj_d[l_ac].prbj0091 = "0"
      LET g_prbj_d[l_ac].prbj009 = "0"
      LET g_prbj_d[l_ac].prbj0111 = "0"
      LET g_prbj_d[l_ac].prbj011 = "0"
      LET g_prbj_d[l_ac].prbj0121 = "0"
      LET g_prbj_d[l_ac].prbj0131 = "0"
      LET g_prbj_d[l_ac].prbj0141 = "0"
      LET g_prbj_d[l_ac].prbj012 = "0"
      LET g_prbj_d[l_ac].prbj013 = "0"
      LET g_prbj_d[l_ac].prbj014 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_prbj_d[l_ac].prbj017 ='2099/12/31'
            LET g_prbj_d[l_ac].prbj019 ='2099/12/31'
            #end add-point
            LET g_prbj_d_t.* = g_prbj_d[l_ac].*     #新輸入資料
            LET g_prbj_d_o.* = g_prbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt122_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt122_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prbj_d[li_reproduce_target].* = g_prbj_d[li_reproduce].*
 
               LET g_prbj_d[li_reproduce_target].prbjseq = NULL
               LET g_prbj_d[li_reproduce_target].prbjseq1 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"

            LET g_prbj_d[l_ac].prbj009 = ""
            LET g_prbj_d[l_ac].prbj011 = ""
            LET g_prbj_d[l_ac].prbj012 = ""
            LET g_prbj_d[l_ac].prbj013 = ""
            LET g_prbj_d[l_ac].prbj014 = ""
            LET g_prbj_d[l_ac].prbjseq1=1           
            LET g_prbj_d[l_ac].prbjunit = g_site
            LET g_prbj_d[l_ac].prbjsite = g_site
            SELECT MAX(prbjseq)+1 INTO g_prbj_d[l_ac].prbjseq FROM prbj_t
             WHERE prbjent = g_enterprise AND prbjdocno = g_prbi_m.prbidocno
            IF cl_null(g_prbj_d[l_ac].prbjseq) THEN
               LET g_prbj_d[l_ac].prbjseq = 1
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbj_d[l_ac].prbjsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbjsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbjsite_desc
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
            SELECT COUNT(1) INTO l_count FROM prbj_t 
             WHERE prbjent = g_enterprise AND prbjdocno = g_prbi_m.prbidocno
 
               AND prbjseq = g_prbj_d[l_ac].prbjseq
               AND prbjseq1 = g_prbj_d[l_ac].prbjseq1
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbi_m.prbidocno
               LET gs_keys[2] = g_prbj_d[g_detail_idx].prbjseq
               LET gs_keys[3] = g_prbj_d[g_detail_idx].prbjseq1
               CALL aprt122_insert_b('prbj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prbj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt122_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #調整前數據新增
               INSERT INTO prbj_t
                     (prbjent,
                      prbjdocno,
                      prbjseq,prbjseq1
                      ,prbjsite,prbj001,prbj002,prbj004,prbj003,prbj005,prbj006,prbj007,prbj008,prbj009,prbj010,prbj011,prbj012,prbj013,prbj014,prbj015,prbjunit) 
                  VALUES(g_enterprise,
                     g_prbi_m.prbidocno,g_prbj_d[l_ac].prbjseq,0,
                     g_prbj_d[l_ac].prbjsite,g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj002, 
                     g_prbj_d[l_ac].prbj004,g_prbj_d[l_ac].prbj003,g_prbj_d[l_ac].prbj005, 
                     g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007,g_prbj_d[l_ac].prbj0081, 
                     g_prbj_d[l_ac].prbj0091,g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0111, 
                     g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141, 
                     g_prbj_d[l_ac].prbj0151,g_prbj_d[l_ac].prbjunit)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prbj_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF  
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               CALL g_prbj_d.deleteElement(g_prbj_d.getLength())
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
               LET gs_keys[01] = g_prbi_m.prbidocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prbj_d_t.prbjseq
               LET gs_keys[gs_keys.getLength()+1] = g_prbj_d_t.prbjseq1
 
            
               #刪除同層單身
               IF NOT aprt122_delete_b('prbj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt122_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt122_key_delete_b(gs_keys,'prbj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt122_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #刪除調整前數據
               DELETE FROM prbj_t
                WHERE prbjent = g_enterprise 
                  AND prbjdocno = g_prbi_m.prbidocno 
                  AND prbjseq = g_prbj_d_t.prbjseq
                  AND prbjseq1=0
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CLOSE aprt122_bcl
                  CANCEL DELETE
               END IF 

               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt122_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prbj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjseq
            #add-point:BEFORE FIELD prbjseq name="input.b.page1.prbjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjseq
            
            #add-point:AFTER FIELD prbjseq name="input.a.page1.prbjseq"
            #此段落由子樣板a05產生
            IF  g_prbi_m.prbidocno IS NOT NULL AND g_prbj_d[g_detail_idx].prbjseq IS NOT NULL AND g_prbj_d[g_detail_idx].prbjseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbi_m.prbidocno != g_prbidocno_t OR g_prbj_d[g_detail_idx].prbjseq != g_prbj_d_t.prbjseq OR g_prbj_d[g_detail_idx].prbjseq1 != g_prbj_d_t.prbjseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbj_t WHERE "||"prbjent = '" ||g_enterprise|| "' AND "||"prbjdocno = '"||g_prbi_m.prbidocno ||"' AND "|| "prbjseq = '"||g_prbj_d[g_detail_idx].prbjseq ||"' AND "|| "prbjseq1 = '"||g_prbj_d[g_detail_idx].prbjseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbjseq
            #add-point:ON CHANGE prbjseq name="input.g.page1.prbjseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjsite
            
            #add-point:AFTER FIELD prbjsite name="input.a.page1.prbjsite"
            IF NOT cl_null(g_prbj_d[l_ac].prbjsite) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。

               CALL s_aooi500_chk(g_prog,'prbjsite',g_prbj_d[l_ac].prbjsite,g_prbi_m.prbisite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_prbj_d[l_ac].prbjsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prbj_d[l_ac].prbjsite = g_prbj_d_t.prbjsite
                  CALL s_desc_get_department_desc(g_prbj_d[l_ac].prbjsite) RETURNING g_prbj_d[l_ac].prbjsite_desc
                  DISPLAY BY NAME g_prbj_d[l_ac].prbjsite,g_prbj_d[l_ac].prbjsite_desc
                  NEXT FIELD CURRENT
               END IF
               
               #检查重复
               IF NOT cl_null(g_prbj_d[l_ac].prbj002) THEN
                  IF g_prbj_d[l_ac].prbjsite <> g_prbj_d_t.prbjsite OR cl_null(g_prbj_d_t.prbjsite) THEN
                     SELECT COUNT(*) INTO l_n FROM prbj_t
                      WHERE prbjent = g_enterprise
                        AND prbjdocno = g_prbi_m.prbidocno
                        AND prbjsite = g_prbj_d[l_ac].prbjsite    
                        AND prbj002 = g_prbj_d[l_ac].prbj002
                        AND prbjseq1 = '0'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00134'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbj_d[l_ac].prbjsite = g_prbj_d_t.prbjsite
                        DISPLAY BY NAME g_prbj_d[l_ac].prbjsite
                        NEXT FIELD prbjsite                       
                     END IF
                  END IF
               END IF
               
               IF NOT cl_null(g_prbj_d[l_ac].prbj001) AND 
                  g_prbj_d[l_ac].prbjsite <> g_prbj_d_t.prbjsite OR cl_null(g_prbj_d_t.prbjsite) THEN
                  CALL aprt122_prbj001_ref(l_cmd)
               END IF

            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbj_d[l_ac].prbjsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbjsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbjsite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjsite
            #add-point:BEFORE FIELD prbjsite name="input.b.page1.prbjsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbjsite
            #add-point:ON CHANGE prbjsite name="input.g.page1.prbjsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj002
            
            #add-point:AFTER FIELD prbj002 name="input.a.page1.prbj002"
            #CALL aprt122_prbj001_init()
            IF NOT cl_null(g_prbj_d[l_ac].prbj002) THEN
			      IF cl_null(g_prbi_m.prbi002) THEN
			         #判斷商品是否歸屬arti204設定的部門可用品類
                  IF NOT s_arti204_control_check(g_prog,g_prbi_m.prbi005,'',g_prbj_d[l_ac].prbj002) THEN
                     LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj002
                     NEXT FIELD CURRENT
                  END IF
			      END IF
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbj_d[l_ac].prbj002
               LET g_chkparam.arg2 = g_prbj_d[l_ac].prbjsite
               LET g_chkparam.arg3 = g_prbi_m.prbi002
               LET g_chkparam.arg4 = g_prbi_m.prbi001

                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_null(g_prbi_m.prbi002) THEN 
                  IF cl_chk_exist("v_prbj002") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj002
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF cl_chk_exist("v_prbj002_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
               IF NOT cl_null(g_prbj_d[l_ac].prbjsite) THEN
                  #检查重复
                  IF g_prbj_d[l_ac].prbj002 <> g_prbj_d_t.prbj002 OR cl_null(g_prbj_d_t.prbj002) THEN
                     SELECT COUNT(*) INTO l_n FROM prbj_t
                      WHERE prbjent = g_enterprise
                        AND prbjdocno = g_prbi_m.prbidocno
                        AND prbjsite = g_prbj_d[l_ac].prbjsite    
                        AND prbj002 = g_prbj_d[l_ac].prbj002
                        AND prbjseq1 = '0'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00134'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                        LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                        LET g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004
                        DISPLAY BY NAME g_prbj_d[l_ac].prbj002
                        NEXT FIELD prbj002                       
                     END IF
                     
                     SELECT prbh003,prbh001 INTO g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj004 FROM prbh_t
                      WHERE prbhent = g_enterprise
                        AND prbhsite = g_prbj_d[l_ac].prbjsite
                        AND prbh004 = g_prbj_d[l_ac].prbj002
                                         
                     CALL aprt122_prbj001_ref(l_cmd)
                  END IF
                  
               END IF

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj002
            #add-point:BEFORE FIELD prbj002 name="input.b.page1.prbj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj002
            #add-point:ON CHANGE prbj002 name="input.g.page1.prbj002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj001
            
            #add-point:AFTER FIELD prbj001 name="input.a.page1.prbj001"
            IF NOT cl_null(g_prbj_d[l_ac].prbj001) THEN
			      IF cl_null(g_prbi_m.prbi002) THEN
			         #判斷商品是否歸屬arti204設定的部門可用品類
                  IF NOT s_arti204_control_check(g_prog,g_prbi_m.prbi005,g_prbj_d[l_ac].prbj001,'') THEN
                     LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj001
                     NEXT FIELD CURRENT
                  END IF
			      END IF
            END IF
            IF NOT cl_null(g_prbj_d[l_ac].prbj001) AND NOT cl_null(g_prbj_d[l_ac].prbjsite) THEN 
#此段落由子樣板a19產生
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM prbh_t,rtdx_t,imaa_t,imay_t 
                WHERE prbhent = rtdxent AND prbhent = imaaent AND prbhent = imayent 
                  AND prbh003 = rtdx001 AND prbh003 = imaa001 AND prbh003 = imay001 AND prbh004 = imay003 
                  AND prbhsite = rtdxsite AND prbh003 = g_prbj_d[l_ac].prbj001 
                  AND prbhsite = g_prbj_d[l_ac].prbjsite AND prbhent = g_enterprise
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00125'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                  DISPLAY BY NAME g_prbj_d[l_ac].prbj001
                  NEXT FIELD prbj001
               END IF
               LET l_sql = " SELECT prbhstus,rtdxstus,imaf153,imaastus,imaa009,imaystus ",
                           "   FROM prbh_t,rtdx_t,imaa_t,imay_t,imaf_t ",
                           "  WHERE prbhent = rtdxent AND prbhent = imaaent AND prbhent = imayent AND prbhent = imafent ",
                           "    AND prbh003 = rtdx001 AND prbh003 = imaa001 AND prbh003 = imay001 AND prbh004 = imay003 AND prbh003 = imaf001 ",
                           "    AND prbhsite = rtdxsite AND prbhsite = imafsite AND prbhsite = '",g_prbj_d[l_ac].prbjsite,"' AND prbhent = '",g_enterprise,"' "               

               IF l_n = 1 THEN
                  LET l_sql = l_sql," AND prbh003 = '",g_prbj_d[l_ac].prbj001,"' "
               ELSE
                  IF cl_null(g_prbj_d[l_ac].prbj002) AND cl_null(g_prbj_d[l_ac].prbj004) THEN
                     LET l_sql = l_sql," AND prbh003 = '",g_prbj_d[l_ac].prbj001,"' "
                  END IF
                  IF NOT cl_null(g_prbj_d[l_ac].prbj002) AND cl_null(g_prbj_d[l_ac].prbj004) THEN
                     LET l_sql = l_sql," AND prbh003 = '",g_prbj_d[l_ac].prbj001,"' AND prbh004 = '",g_prbj_d[l_ac].prbj002,"' "
                  END IF
                  IF NOT cl_null(g_prbj_d[l_ac].prbj004) AND cl_null(g_prbj_d[l_ac].prbj002) THEN
                     LET l_sql = l_sql," AND prbh003 = '",g_prbj_d[l_ac].prbj001,"' AND prbh001 = '",g_prbj_d[l_ac].prbj004,"' "
                  END IF
                  IF NOT cl_null(g_prbj_d[l_ac].prbj002) AND NOT cl_null(g_prbj_d[l_ac].prbj004) THEN
                     LET l_sql = l_sql," AND prbh003 = '",g_prbj_d[l_ac].prbj001,"' ",
                                       " AND prbh004 = '",g_prbj_d[l_ac].prbj002,"' ",
                                       " AND prbh001 = '",g_prbj_d[l_ac].prbj004,"' "
                  END IF
               END IF
               PREPARE sel_prbh_pre1 FROM l_sql
               EXECUTE sel_prbh_pre1 INTO l_prbhstus,l_rtdxstus,l_imaf153,l_imaastus,l_imaa009,l_imaystus
               LET g_errno = NULL
               IF cl_null(g_errno) AND l_prbhstus <> 'Y' THEN
                  LET g_errno = 'apr-00126'
               END IF
               IF cl_null(g_errno) AND l_rtdxstus <> 'Y' THEN
                  LET g_errno = 'art-00156'   
               END IF
               IF cl_null(g_errno) AND l_imaf153 <> g_prbi_m.prbi001 THEN
                  LET g_errno = 'apr-00010'
               END IF
               IF cl_null(g_errno) AND l_imaastus <> 'Y' THEN
                  LET g_errno = 'art-00126'
               END IF
               IF cl_null(g_errno) AND NOT cl_null(g_prbi_m.prbi002) THEN 
                  LET l_sql = " SELECT COUNT(*) FROM rtax_t ",
                              "  WHERE rtaxent = '",g_enterprise,"' ",
                              "    AND rtax001 = '",l_imaa009,"' ",
                              #"    AND rtax001 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 ",  #160905-00007#12  mark
                              "    AND rtax001 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax005 = 0 ",  #160905-00007#12  add
                              "                     START WITH rtax003 = '",g_prbi_m.prbi002,"' CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                              #"                     UNION SELECT rtax001 FROM rtax_t WHERE rtax001 = '",g_prbi_m.prbi002,"') "  #160905-00007#12  add
                              "                     UNION SELECT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax001 = '",g_prbi_m.prbi002,"') "  #160905-00007#12  mark
                  PREPARE sel_rtax_pre1 FROM l_sql
                  EXECUTE sel_rtax_pre1 INTO l_n
                  IF l_n < 1 THEN
                     LET g_errno = 'apr-00009'
                  END IF
               END IF
               IF cl_null(g_errno) AND NOT cl_null(g_prbi_m.prbi002) THEN  
                  LET l_sql = " SELECT COUNT(*) FROM rtax_t ",
                              "  WHERE rtaxent = '",g_enterprise,"' ",
                              "    AND rtax001 = '",l_imaa009,"' ",
                              #"    AND rtax001 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 ", #160905-00007#12  mark
                              "    AND rtax001 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtaxent = ",g_enterprise," AND rtax005 = 0 ",  #160905-00007#12  add
                              "                    START WITH rtax003 IN (SELECT prbs001 FROM prbs_t,rtax_t WHERE prbsent = rtaxent AND prbs001 = rtax001 AND prbsstus = 'Y') ",         
                              "                    CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                              "                    UNION SELECT rtax001 FROM rtax_t WHERE rtax001 IN (SELECT prbs001 FROM prbs_t,rtax_t WHERE prbsent = rtaxent AND prbs001 = rtax001 AND prbsstus = 'Y')) "    
                  PREPARE sel_rtax_pre2 FROM l_sql
                  EXECUTE sel_rtax_pre2 INTO l_n
                  IF l_n < 1 THEN
                     LET g_errno = 'apr-00298'
                  END IF
               END IF
               IF cl_null(g_errno) AND l_imaystus <> 'Y' THEN
                  LET g_errno = 'apr-00127'
               END IF  
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                  DISPLAY BY NAME g_prbj_d[l_ac].prbj001
                  NEXT FIELD prbj001
               END IF                  
            
               #检查重复
               IF g_prbj_d[l_ac].prbj001 <> g_prbj_d_t.prbj001 OR cl_null(g_prbj_d_t.prbj001) THEN
                  SELECT COUNT(*) INTO l_n FROM prbh_t 
                   WHERE prbhent = g_enterprise
                     AND prbhsite = g_prbj_d[l_ac].prbjsite
                     AND prbh003 = g_prbj_d[l_ac].prbj001
                  IF l_n = 1 THEN
                     SELECT COUNT(*) INTO l_n FROM prbj_t
                      WHERE prbjent = g_enterprise
                        AND prbjdocno = g_prbi_m.prbidocno
                        AND prbjsite = g_prbj_d[l_ac].prbjsite    
                        AND prbj001 = g_prbj_d[l_ac].prbj001
                        AND prbjseq1 = '0'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00134'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                        LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                        LET g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004
                        DISPLAY BY NAME g_prbj_d[l_ac].prbj001
                        NEXT FIELD prbj001
                     END IF  
                  ELSE
                     IF NOT cl_null(g_prbj_d[l_ac].prbj002) THEN
                        SELECT COUNT(*) INTO l_n FROM prbj_t
                         WHERE prbjent = g_enterprise
                           AND prbjdocno = g_prbi_m.prbidocno
                           AND prbjsite = g_prbj_d[l_ac].prbjsite    
                           AND prbj001 = g_prbj_d[l_ac].prbj001
                           AND prbj002 = g_prbj_d[l_ac].prbj002
                           AND prbjseq1 = '0'
                        IF l_n > 0 THEN
                           INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00134'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                           LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                           LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                           LET g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004
                           DISPLAY BY NAME g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj004
                           NEXT FIELD prbj001
                        END IF
                     END IF                          
                  END IF    

                  CALL aprt122_prbj001_ref(l_cmd)
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbj_d[l_ac].prbj001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj001
            #add-point:BEFORE FIELD prbj001 name="input.b.page1.prbj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj001
            #add-point:ON CHANGE prbj001 name="input.g.page1.prbj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj004
            
            #add-point:AFTER FIELD prbj004 name="input.a.page1.prbj004"
            #CALL aprt122_prbj001_init()
            IF NOT cl_null(g_prbj_d[l_ac].prbj004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbj_d[l_ac].prbj004
               LET g_chkparam.arg2 = g_prbj_d[l_ac].prbjsite
               LET g_chkparam.arg3 = g_prbi_m.prbi002
               LET g_chkparam.arg4 = g_prbi_m.prbi001

                  
               #呼叫檢查存在並帶值的library

               IF NOT cl_null(g_prbi_m.prbi002) THEN       
                  IF cl_chk_exist("v_prbj004") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj004
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF cl_chk_exist("v_prbj004_1") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
               IF NOT cl_null(g_prbj_d[l_ac].prbjsite) THEN
                  #检查重复
                  IF g_prbj_d[l_ac].prbj004 <> g_prbj_d_t.prbj004 OR cl_null(g_prbj_d_t.prbj004) THEN
                     SELECT COUNT(*) INTO l_n FROM prbj_t
                      WHERE prbjent = g_enterprise
                        AND prbjdocno = g_prbi_m.prbidocno
                        AND prbjsite = g_prbj_d[l_ac].prbjsite    
                        AND prbj004 = g_prbj_d[l_ac].prbj004
                        AND prbjseq1 = '0'
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00134'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbj_d[l_ac].prbj001 = g_prbj_d_t.prbj001
                        LET g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002
                        LET g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004
                        DISPLAY BY NAME g_prbj_d[l_ac].prbj004
                        NEXT FIELD prbj004                       
                     END IF
                     
                     SELECT prbh003,prbh004 INTO g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj002 FROM prbh_t
                      WHERE prbhent = g_enterprise
                        AND prbhsite = g_prbj_d[l_ac].prbjsite
                        AND prbh001 = g_prbj_d[l_ac].prbj004
                                         
                     CALL aprt122_prbj001_ref(l_cmd)
                  END IF
                  
               END IF

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj004
            #add-point:BEFORE FIELD prbj004 name="input.b.page1.prbj004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj004
            #add-point:ON CHANGE prbj004 name="input.g.page1.prbj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaxl003
            #add-point:BEFORE FIELD rtaxl003 name="input.b.page1.rtaxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaxl003
            
            #add-point:AFTER FIELD rtaxl003 name="input.a.page1.rtaxl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaxl003
            #add-point:ON CHANGE rtaxl003 name="input.g.page1.rtaxl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj003
            #add-point:BEFORE FIELD prbj003 name="input.b.page1.prbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj003
            
            #add-point:AFTER FIELD prbj003 name="input.a.page1.prbj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj003
            #add-point:ON CHANGE prbj003 name="input.g.page1.prbj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj005
            
            #add-point:AFTER FIELD prbj005 name="input.a.page1.prbj005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbj_d[l_ac].prbj005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj005
            #add-point:BEFORE FIELD prbj005 name="input.b.page1.prbj005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj005
            #add-point:ON CHANGE prbj005 name="input.g.page1.prbj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj006
            #add-point:BEFORE FIELD prbj006 name="input.b.page1.prbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj006
            
            #add-point:AFTER FIELD prbj006 name="input.a.page1.prbj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj006
            #add-point:ON CHANGE prbj006 name="input.g.page1.prbj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj007
            #add-point:BEFORE FIELD prbj007 name="input.b.page1.prbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj007
            
            #add-point:AFTER FIELD prbj007 name="input.a.page1.prbj007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj007
            #add-point:ON CHANGE prbj007 name="input.g.page1.prbj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjseq1
            #add-point:BEFORE FIELD prbjseq1 name="input.b.page1.prbjseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjseq1
            
            #add-point:AFTER FIELD prbjseq1 name="input.a.page1.prbjseq1"
            #此段落由子樣板a05產生
            IF  g_prbi_m.prbidocno IS NOT NULL AND g_prbj_d[g_detail_idx].prbjseq IS NOT NULL AND g_prbj_d[g_detail_idx].prbjseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbi_m.prbidocno != g_prbidocno_t OR g_prbj_d[g_detail_idx].prbjseq != g_prbj_d_t.prbjseq OR g_prbj_d[g_detail_idx].prbjseq1 != g_prbj_d_t.prbjseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbj_t WHERE "||"prbjent = '" ||g_enterprise|| "' AND "||"prbjdocno = '"||g_prbi_m.prbidocno ||"' AND "|| "prbjseq = '"||g_prbj_d[g_detail_idx].prbjseq ||"' AND "|| "prbjseq1 = '"||g_prbj_d[g_detail_idx].prbjseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbjseq1
            #add-point:ON CHANGE prbjseq1 name="input.g.page1.prbjseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0081
            
            #add-point:AFTER FIELD prbj0081 name="input.a.page1.prbj0081"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0081) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbj_d[l_ac].prbj0081
               LET g_chkparam.arg2 = '參數2'
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0081
            #add-point:BEFORE FIELD prbj0081 name="input.b.page1.prbj0081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0081
            #add-point:ON CHANGE prbj0081 name="input.g.page1.prbj0081"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0081_desc
            #add-point:BEFORE FIELD prbj0081_desc name="input.b.page1.prbj0081_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0081_desc
            
            #add-point:AFTER FIELD prbj0081_desc name="input.a.page1.prbj0081_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0081_desc
            #add-point:ON CHANGE prbj0081_desc name="input.g.page1.prbj0081_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj008
            
            #add-point:AFTER FIELD prbj008 name="input.a.page1.prbj008"
            IF NOT cl_null(g_prbj_d[l_ac].prbj008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbj_d[l_ac].prbjsite
               LET g_chkparam.arg2 = g_prbj_d[l_ac].prbj008
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prbj_d[l_ac].prbjsite            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbj_d[l_ac].prbj008
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj008_desc
 
            CALL aprt122_prbj_required_1()               
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj008
            #add-point:BEFORE FIELD prbj008 name="input.b.page1.prbj008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj008
            #add-point:ON CHANGE prbj008 name="input.g.page1.prbj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj008_desc
            #add-point:BEFORE FIELD prbj008_desc name="input.b.page1.prbj008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj008_desc
            
            #add-point:AFTER FIELD prbj008_desc name="input.a.page1.prbj008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj008_desc
            #add-point:ON CHANGE prbj008_desc name="input.g.page1.prbj008_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0091
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbj_d[l_ac].prbj0091,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbj0091
            END IF 
 
 
 
            #add-point:AFTER FIELD prbj0091 name="input.a.page1.prbj0091"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0091) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0091
            #add-point:BEFORE FIELD prbj0091 name="input.b.page1.prbj0091"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0091
            #add-point:ON CHANGE prbj0091 name="input.g.page1.prbj0091"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj009
            #add-point:BEFORE FIELD prbj009 name="input.b.page1.prbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj009
            
            #add-point:AFTER FIELD prbj009 name="input.a.page1.prbj009"
            IF NOT cl_ap_chk_Range(g_prbj_d[l_ac].prbj009,"0.000","0","","","azz-00079",1) THEN
               LET g_prbj_d[l_ac].prbj009 = g_prbj_d_t.prbj009
               DISPLAY BY NAME g_prbj_d[l_ac].prbj009
               NEXT FIELD prbj009
            END IF
            LET l_prbj009 = g_prbj_d[l_ac].prbj009
            LET l_prbj011 = g_prbj_d[l_ac].prbj011
            IF cl_null(l_prbj009) THEN
               LET l_prbj009 = g_prbj_d[l_ac].prbj0091
            END IF
            IF cl_null(l_prbj011) THEN
               LET l_prbj011 = g_prbj_d[l_ac].prbj0111
            END IF
            IF NOT cl_null(l_prbj009) AND NOT cl_null(l_prbj011) THEN
               LET g_prbj_d[l_ac].prbj015 = (l_prbj011-l_prbj009)/l_prbj011*100
               DISPLAY BY NAME g_prbj_d[l_ac].prbj015               
            END IF
                        
            CALL aprt122_prbj_required_1()               

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj009
            #add-point:ON CHANGE prbj009 name="input.g.page1.prbj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0161
            #add-point:BEFORE FIELD prbj0161 name="input.b.page1.prbj0161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0161
            
            #add-point:AFTER FIELD prbj0161 name="input.a.page1.prbj0161"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0161
            #add-point:ON CHANGE prbj0161 name="input.g.page1.prbj0161"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0171
            #add-point:BEFORE FIELD prbj0171 name="input.b.page1.prbj0171"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0171
            
            #add-point:AFTER FIELD prbj0171 name="input.a.page1.prbj0171"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0171
            #add-point:ON CHANGE prbj0171 name="input.g.page1.prbj0171"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj016
            #add-point:BEFORE FIELD prbj016 name="input.b.page1.prbj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj016
            
            #add-point:AFTER FIELD prbj016 name="input.a.page1.prbj016"
            IF NOT cl_null(g_prbj_d[l_ac].prbj016) THEN
               IF g_prbj_d[l_ac].prbj016 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbj_d[l_ac].prbj016 = g_prbj_d_t.prbj016
                  DISPLAY BY NAME g_prbj_d[l_ac].prbj016
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbj_d[l_ac].prbj017) THEN
                  IF g_prbj_d[l_ac].prbj016 > g_prbj_d[l_ac].prbj017 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbj_d[l_ac].prbj016 = g_prbj_d_t.prbj016
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj016
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
                       
            IF cl_null(g_prbj_d[l_ac].prbj009) AND cl_null(g_prbj_d[l_ac].prbj016) AND
               cl_null(g_prbj_d[l_ac].prbj017) THEN
               CALL cl_set_comp_required("prbj009,prbj016,prbj017",FALSE)
            ELSE
               CALL cl_set_comp_required("prbj009,prbj016,prbj017",TRUE)
            END IF
            CALL aprt122_prbj_required_1()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj016
            #add-point:ON CHANGE prbj016 name="input.g.page1.prbj016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj017
            #add-point:BEFORE FIELD prbj017 name="input.b.page1.prbj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj017
            
            #add-point:AFTER FIELD prbj017 name="input.a.page1.prbj017"

            IF NOT cl_null(g_prbj_d[l_ac].prbj017) THEN
               IF g_prbj_d[l_ac].prbj017 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00064'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbj_d[l_ac].prbj017 = g_prbj_d_t.prbj017
                  DISPLAY BY NAME g_prbj_d[l_ac].prbj017
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbj_d[l_ac].prbj016) THEN
                  IF g_prbj_d[l_ac].prbj016 > g_prbj_d[l_ac].prbj017 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbj_d[l_ac].prbj017 = g_prbj_d_t.prbj017
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj017
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF cl_null(g_prbj_d[l_ac].prbj009) AND cl_null(g_prbj_d[l_ac].prbj016) AND
               cl_null(g_prbj_d[l_ac].prbj017) THEN
               CALL cl_set_comp_required("prbj009,prbj016,prbj017",FALSE)
            ELSE
               CALL cl_set_comp_required("prbj009,prbj016,prbj017",TRUE)
            END IF
            CALL aprt122_prbj_required_1()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj017
            #add-point:ON CHANGE prbj017 name="input.g.page1.prbj017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0101
            
            #add-point:AFTER FIELD prbj0101 name="input.a.page1.prbj0101"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0101) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbj_d[l_ac].prbj0101
               LET g_chkparam.arg2 = '參數2'
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#32  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0101
            #add-point:BEFORE FIELD prbj0101 name="input.b.page1.prbj0101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0101
            #add-point:ON CHANGE prbj0101 name="input.g.page1.prbj0101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0101_desc
            #add-point:BEFORE FIELD prbj0101_desc name="input.b.page1.prbj0101_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0101_desc
            
            #add-point:AFTER FIELD prbj0101_desc name="input.a.page1.prbj0101_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0101_desc
            #add-point:ON CHANGE prbj0101_desc name="input.g.page1.prbj0101_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj010
            
            #add-point:AFTER FIELD prbj010 name="input.a.page1.prbj010"
            IF NOT cl_null(g_prbj_d[l_ac].prbj010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbj_d[l_ac].prbjsite
               LET g_chkparam.arg2 = g_prbj_d[l_ac].prbj010
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prbj_d[l_ac].prbjsite 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbj_d[l_ac].prbj010
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj010_desc

            CALL aprt122_prbj_required_2()            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj010
            #add-point:BEFORE FIELD prbj010 name="input.b.page1.prbj010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj010
            #add-point:ON CHANGE prbj010 name="input.g.page1.prbj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj010_desc
            #add-point:BEFORE FIELD prbj010_desc name="input.b.page1.prbj010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj010_desc
            
            #add-point:AFTER FIELD prbj010_desc name="input.a.page1.prbj010_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj010_desc
            #add-point:ON CHANGE prbj010_desc name="input.g.page1.prbj010_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0111
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbj_d[l_ac].prbj0111,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbj0111
            END IF 
 
 
 
            #add-point:AFTER FIELD prbj0111 name="input.a.page1.prbj0111"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0111) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0111
            #add-point:BEFORE FIELD prbj0111 name="input.b.page1.prbj0111"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0111
            #add-point:ON CHANGE prbj0111 name="input.g.page1.prbj0111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj011
            #add-point:BEFORE FIELD prbj011 name="input.b.page1.prbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj011
            
            #add-point:AFTER FIELD prbj011 name="input.a.page1.prbj011"
            IF NOT cl_ap_chk_Range(g_prbj_d[l_ac].prbj011,"0.000","0","","","azz-00079",1) THEN
               LET g_prbj_d[l_ac].prbj011 = g_prbj_d_t.prbj011
               DISPLAY BY NAME g_prbj_d[l_ac].prbj011
               NEXT FIELD prbj011
            END IF

            LET l_prbj009 = g_prbj_d[l_ac].prbj009
            LET l_prbj011 = g_prbj_d[l_ac].prbj011
            IF cl_null(l_prbj009) THEN
               LET l_prbj009 = g_prbj_d[l_ac].prbj0091
            END IF
            IF cl_null(l_prbj011) THEN
               LET l_prbj011 = g_prbj_d[l_ac].prbj0111
            END IF
            
            IF NOT cl_null(l_prbj009) AND NOT cl_null(l_prbj011) THEN
               LET g_prbj_d[l_ac].prbj015 = (l_prbj011-l_prbj009)/l_prbj011*100
               DISPLAY BY NAME g_prbj_d[l_ac].prbj015               
            END IF
            

            
            CALL aprt122_prbj_required_2()            

            #150603-00026#19--add by dongsz--str---
            IF g_prbj_d[l_ac].prbj011 <> g_prbj_d_o.prbj011 OR cl_null(g_prbj_d_o.prbj011) THEN
               LET g_prbj_d[l_ac].prbj012 = g_prbj_d[l_ac].prbj011
               LET g_prbj_d[l_ac].prbj013 = g_prbj_d[l_ac].prbj011
               LET g_prbj_d[l_ac].prbj014 = g_prbj_d[l_ac].prbj011
            END IF
            LET g_prbj_d_o.prbj011 = g_prbj_d[l_ac].prbj011
            #150603-00026#19--add by dongsz--end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj011
            #add-point:ON CHANGE prbj011 name="input.g.page1.prbj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0181
            #add-point:BEFORE FIELD prbj0181 name="input.b.page1.prbj0181"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0181
            
            #add-point:AFTER FIELD prbj0181 name="input.a.page1.prbj0181"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0181
            #add-point:ON CHANGE prbj0181 name="input.g.page1.prbj0181"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0191
            #add-point:BEFORE FIELD prbj0191 name="input.b.page1.prbj0191"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0191
            
            #add-point:AFTER FIELD prbj0191 name="input.a.page1.prbj0191"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0191
            #add-point:ON CHANGE prbj0191 name="input.g.page1.prbj0191"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj018
            #add-point:BEFORE FIELD prbj018 name="input.b.page1.prbj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj018
            
            #add-point:AFTER FIELD prbj018 name="input.a.page1.prbj018"

            IF NOT cl_null(g_prbj_d[l_ac].prbj018) THEN
               IF g_prbj_d[l_ac].prbj018 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbj_d[l_ac].prbj018 = g_prbj_d_t.prbj018
                  DISPLAY BY NAME g_prbj_d[l_ac].prbj018
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbj_d[l_ac].prbj019) THEN
                  IF g_prbj_d[l_ac].prbj018 > g_prbj_d[l_ac].prbj019 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbj_d[l_ac].prbj018 = g_prbj_d_t.prbj018
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj018
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
                       
            IF cl_null(g_prbj_d[l_ac].prbj011) AND cl_null(g_prbj_d[l_ac].prbj018) AND
               cl_null(g_prbj_d[l_ac].prbj019) THEN
               CALL cl_set_comp_required("prbj011,prbj018,prbj019",FALSE)
            ELSE
               CALL cl_set_comp_required("prbj011,prbj018,prbj019",TRUE)
            END IF
            CALL aprt122_prbj_required_2()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj018
            #add-point:ON CHANGE prbj018 name="input.g.page1.prbj018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj019
            #add-point:BEFORE FIELD prbj019 name="input.b.page1.prbj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj019
            
            #add-point:AFTER FIELD prbj019 name="input.a.page1.prbj019"

            IF NOT cl_null(g_prbj_d[l_ac].prbj019) THEN
               IF g_prbj_d[l_ac].prbj019 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00064'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbj_d[l_ac].prbj019 = g_prbj_d_t.prbj019
                  DISPLAY BY NAME g_prbj_d[l_ac].prbj019
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbj_d[l_ac].prbj018) THEN
                  IF g_prbj_d[l_ac].prbj018 > g_prbj_d[l_ac].prbj019 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbj_d[l_ac].prbj019 = g_prbj_d_t.prbj019
                     DISPLAY BY NAME g_prbj_d[l_ac].prbj019
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF cl_null(g_prbj_d[l_ac].prbj011) AND cl_null(g_prbj_d[l_ac].prbj018) AND
               cl_null(g_prbj_d[l_ac].prbj019) THEN
               CALL cl_set_comp_required("prbj011,prbj018,prbj019",FALSE)
            ELSE
               CALL cl_set_comp_required("prbj011,prbj018,prbj019",TRUE)
            END IF
            CALL aprt122_prbj_required_2()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj019
            #add-point:ON CHANGE prbj019 name="input.g.page1.prbj019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0121
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbj_d[l_ac].prbj0121,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbj0121
            END IF 
 
 
 
            #add-point:AFTER FIELD prbj0121 name="input.a.page1.prbj0121"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0121) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0121
            #add-point:BEFORE FIELD prbj0121 name="input.b.page1.prbj0121"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0121
            #add-point:ON CHANGE prbj0121 name="input.g.page1.prbj0121"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0131
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbj_d[l_ac].prbj0131,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbj0131
            END IF 
 
 
 
            #add-point:AFTER FIELD prbj0131 name="input.a.page1.prbj0131"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0131) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0131
            #add-point:BEFORE FIELD prbj0131 name="input.b.page1.prbj0131"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0131
            #add-point:ON CHANGE prbj0131 name="input.g.page1.prbj0131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0141
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbj_d[l_ac].prbj0141,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbj0141
            END IF 
 
 
 
            #add-point:AFTER FIELD prbj0141 name="input.a.page1.prbj0141"
            IF NOT cl_null(g_prbj_d[l_ac].prbj0141) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0141
            #add-point:BEFORE FIELD prbj0141 name="input.b.page1.prbj0141"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0141
            #add-point:ON CHANGE prbj0141 name="input.g.page1.prbj0141"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj012
            #add-point:BEFORE FIELD prbj012 name="input.b.page1.prbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj012
            
            #add-point:AFTER FIELD prbj012 name="input.a.page1.prbj012"
            IF NOT cl_ap_chk_Range(g_prbj_d[l_ac].prbj012,"0.000","0","","","azz-00079",1) THEN
               LET g_prbj_d[l_ac].prbj012 = g_prbj_d_t.prbj012
               DISPLAY BY NAME g_prbj_d[l_ac].prbj012
               NEXT FIELD prbj012
            END IF
            CALL aprt122_prbj_required_2()            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj012
            #add-point:ON CHANGE prbj012 name="input.g.page1.prbj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj013
            #add-point:BEFORE FIELD prbj013 name="input.b.page1.prbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj013
            
            #add-point:AFTER FIELD prbj013 name="input.a.page1.prbj013"
            IF NOT cl_ap_chk_Range(g_prbj_d[l_ac].prbj013,"0.000","0","","","azz-00079",1) THEN
               LET g_prbj_d[l_ac].prbj013 = g_prbj_d_t.prbj013
               DISPLAY BY NAME g_prbj_d[l_ac].prbj013
               NEXT FIELD prbj013
            END IF
            CALL aprt122_prbj_required_2()            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj013
            #add-point:ON CHANGE prbj013 name="input.g.page1.prbj013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj014
            #add-point:BEFORE FIELD prbj014 name="input.b.page1.prbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj014
            
            #add-point:AFTER FIELD prbj014 name="input.a.page1.prbj014"
            IF NOT cl_ap_chk_Range(g_prbj_d[l_ac].prbj014,"0.000","0","","","azz-00079",1) THEN
               LET g_prbj_d[l_ac].prbj014 = g_prbj_d_t.prbj014
               DISPLAY BY NAME g_prbj_d[l_ac].prbj014
               NEXT FIELD prbj014
            END IF
            CALL aprt122_prbj_required_2()             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj014
            #add-point:ON CHANGE prbj014 name="input.g.page1.prbj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj0151
            #add-point:BEFORE FIELD prbj0151 name="input.b.page1.prbj0151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj0151
            
            #add-point:AFTER FIELD prbj0151 name="input.a.page1.prbj0151"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj0151
            #add-point:ON CHANGE prbj0151 name="input.g.page1.prbj0151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbj015
            #add-point:BEFORE FIELD prbj015 name="input.b.page1.prbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbj015
            
            #add-point:AFTER FIELD prbj015 name="input.a.page1.prbj015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbj015
            #add-point:ON CHANGE prbj015 name="input.g.page1.prbj015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbjunit
            #add-point:BEFORE FIELD prbjunit name="input.b.page1.prbjunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbjunit
            
            #add-point:AFTER FIELD prbjunit name="input.a.page1.prbjunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbjunit
            #add-point:ON CHANGE prbjunit name="input.g.page1.prbjunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prbjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjseq
            #add-point:ON ACTION controlp INFIELD prbjseq name="input.c.page1.prbjseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjsite
            #add-point:ON ACTION controlp INFIELD prbjsite name="input.c.page1.prbjsite"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbjsite             #給予default值
            LET g_qryparam.default2 = g_prbj_d[l_ac].prbjsite_desc #說明(簡稱)

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbjsite',g_prbi_m.prbisite,'i')   
               CALL q_ooef001_24()

            LET g_prbj_d[l_ac].prbjsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbj_d[l_ac].prbjsite TO prbjsite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_prbj_d[l_ac].prbjsite)
                  RETURNING g_prbj_d[l_ac].prbjsite_desc

            NEXT FIELD prbjsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj002
            #add-point:ON ACTION controlp INFIELD prbj002 name="input.c.page1.prbj002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj001             #給予default值
            LET g_qryparam.default2 = g_prbj_d[l_ac].prbj002 #商品條碼
            LET g_qryparam.default3 = g_prbj_d[l_ac].prbj004 #PLU碼

            #給予arg
            LET g_qryparam.arg1 = g_prbj_d[l_ac].prbjsite #
            LET g_qryparam.arg2 = g_prbi_m.prbi001 #
            LET g_qryparam.arg3 = g_prbi_m.prbi002 #

            #150401-00003#1--add by dongsz--str---
            IF NOT cl_null(g_prbi_m.prbi002) THEN
               CALL q_prbj001()                                #呼叫開窗
            ELSE
               LET g_qryparam.where = " prbh003 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," ",
                                      "                AND ",s_arti204_control_where(g_prog,g_prbi_m.prbi005,'2'),")"
               CALL q_prbj001_1()
            END IF

            LET g_prbj_d[l_ac].prbj001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbj_d[l_ac].prbj002 = g_qryparam.return2 #商品條碼
            LET g_prbj_d[l_ac].prbj004 = g_qryparam.return3 #PLU碼
            LET g_prbj_d[l_ac].prbj001_desc = g_qryparam.return4
            LET g_prbj_d[l_ac].prbj001_desc_desc = g_qryparam.return5
            LET g_prbj_d[l_ac].prbj001_desc_desc_desc = g_qryparam.return6
            LET g_prbj_d[l_ac].rtaxl003 = g_qryparam.return7

            DISPLAY g_prbj_d[l_ac].prbj001 TO prbj001              #顯示到畫面上
            DISPLAY g_prbj_d[l_ac].prbj002 TO prbj002 #商品條碼
            DISPLAY g_prbj_d[l_ac].prbj004 TO prbj004 #PLU碼
            DISPLAY g_prbj_d[l_ac].prbj001_desc TO prbj001_desc
            DISPLAY g_prbj_d[l_ac].prbj001_desc_desc TO prbj001_desc_desc
            DISPLAY g_prbj_d[l_ac].prbj001_desc_desc_desc TO prbj001_desc_desc_desc
            DISPLAY g_prbj_d[l_ac].rtaxl003 TO rtaxl003

            NEXT FIELD prbj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj001
            #add-point:ON ACTION controlp INFIELD prbj001 name="input.c.page1.prbj001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj001            #給予default值
            LET g_qryparam.default2 = g_prbj_d[l_ac].prbj002   #商品條碼
            LET g_qryparam.default3 = g_prbj_d[l_ac].prbj004   #PLU碼

            #給予arg
            LET g_qryparam.arg1 = g_prbj_d[l_ac].prbjsite #
            LET g_qryparam.arg2 = g_prbi_m.prbi001 #
            LET g_qryparam.arg3 = g_prbi_m.prbi002 #
            
            IF NOT cl_null(g_prbi_m.prbi002) THEN
               CALL q_prbj001()                                #呼叫開窗
            ELSE
               LET g_qryparam.where = " prbh003 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," ",
                                      "                AND ",s_arti204_control_where(g_prog,g_prbi_m.prbi005,'2'),")"
               CALL q_prbj001_1()
            END IF

            LET g_prbj_d[l_ac].prbj001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbj_d[l_ac].prbj002 = g_qryparam.return2 #商品條碼
            LET g_prbj_d[l_ac].prbj004 = g_qryparam.return3 #PLU碼
            LET g_prbj_d[l_ac].prbj001_desc = g_qryparam.return4
            LET g_prbj_d[l_ac].prbj001_desc_desc = g_qryparam.return5
            LET g_prbj_d[l_ac].prbj001_desc_desc_desc = g_qryparam.return6
            LET g_prbj_d[l_ac].rtaxl003 = g_qryparam.return7

            DISPLAY g_prbj_d[l_ac].prbj001 TO prbj001              #顯示到畫面上
            DISPLAY g_prbj_d[l_ac].prbj002 TO prbj002 #商品條碼
            DISPLAY g_prbj_d[l_ac].prbj004 TO prbj004 #PLU碼
            DISPLAY g_prbj_d[l_ac].prbj001_desc TO prbj001_desc
            DISPLAY g_prbj_d[l_ac].prbj001_desc_desc TO prbj001_desc_desc
            DISPLAY g_prbj_d[l_ac].prbj001_desc_desc_desc TO prbj001_desc_desc_desc
            DISPLAY g_prbj_d[l_ac].rtaxl003 TO rtaxl003

            NEXT FIELD prbj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj004
            #add-point:ON ACTION controlp INFIELD prbj004 name="input.c.page1.prbj004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj001             #給予default值
            LET g_qryparam.default2 = g_prbj_d[l_ac].prbj002 #商品條碼
            LET g_qryparam.default3 = g_prbj_d[l_ac].prbj004 #PLU碼

            #給予arg
            LET g_qryparam.arg1 = g_prbj_d[l_ac].prbjsite #
            LET g_qryparam.arg2 = g_prbi_m.prbi001 #
            LET g_qryparam.arg3 = g_prbi_m.prbi002 #

            IF NOT cl_null(g_prbi_m.prbi002) THEN
               CALL q_prbj001()                                #呼叫開窗
            ELSE
               LET g_qryparam.where = " prbh003 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = ",g_enterprise," ",
                                      "                AND ",s_arti204_control_where(g_prog,g_prbi_m.prbi005,'2'),")"
               CALL q_prbj001_1()
            END IF

            LET g_prbj_d[l_ac].prbj001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbj_d[l_ac].prbj002 = g_qryparam.return2 #商品編碼
            LET g_prbj_d[l_ac].prbj004 = g_qryparam.return3 #商品條碼
            LET g_prbj_d[l_ac].prbj001_desc = g_qryparam.return4
            LET g_prbj_d[l_ac].prbj001_desc_desc = g_qryparam.return5
            LET g_prbj_d[l_ac].prbj001_desc_desc_desc = g_qryparam.return6
            LET g_prbj_d[l_ac].rtaxl003 = g_qryparam.return7

            DISPLAY g_prbj_d[l_ac].prbj001 TO prbj001              #顯示到畫面上
            DISPLAY g_prbj_d[l_ac].prbj002 TO prbj002 #商品條碼
            DISPLAY g_prbj_d[l_ac].prbj004 TO prbj004 #PLU碼
            DISPLAY g_prbj_d[l_ac].prbj001_desc TO prbj001_desc
            DISPLAY g_prbj_d[l_ac].prbj001_desc_desc TO prbj001_desc_desc
            DISPLAY g_prbj_d[l_ac].prbj001_desc_desc_desc TO prbj001_desc_desc_desc
            DISPLAY g_prbj_d[l_ac].rtaxl003 TO rtaxl003

            NEXT FIELD prbj004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaxl003
            #add-point:ON ACTION controlp INFIELD rtaxl003 name="input.c.page1.rtaxl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj003
            #add-point:ON ACTION controlp INFIELD prbj003 name="input.c.page1.prbj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj005
            #add-point:ON ACTION controlp INFIELD prbj005 name="input.c.page1.prbj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj006
            #add-point:ON ACTION controlp INFIELD prbj006 name="input.c.page1.prbj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj007
            #add-point:ON ACTION controlp INFIELD prbj007 name="input.c.page1.prbj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbjseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjseq1
            #add-point:ON ACTION controlp INFIELD prbjseq1 name="input.c.page1.prbjseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0081
            #add-point:ON ACTION controlp INFIELD prbj0081 name="input.c.page1.prbj0081"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj0081             #給予default值
            LET g_qryparam.default2 = "" #g_prbj_d[l_ac].oodb002 #稅別代碼
            #給予arg
            LET g_qryparam.arg1 =g_prbj_d[l_ac].prbjsite


            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prbj_d[l_ac].prbj0081 = g_qryparam.return1              
            DISPLAY g_prbj_d[l_ac].prbj0081 TO prbj0081              #
            NEXT FIELD prbj0081                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0081_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0081_desc
            #add-point:ON ACTION controlp INFIELD prbj0081_desc name="input.c.page1.prbj0081_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj008
            #add-point:ON ACTION controlp INFIELD prbj008 name="input.c.page1.prbj008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj008             #給予default值
            LET g_qryparam.default2 = g_prbj_d[l_ac].prbj008_desc #稅別代碼

            #給予arg
            LET g_qryparam.arg1 =g_prbj_d[l_ac].prbjsite

            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prbj_d[l_ac].prbj008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbj_d[l_ac].prbj008_desc = g_qryparam.return2 #稅別代碼

            DISPLAY g_prbj_d[l_ac].prbj008 TO prbj008              #顯示到畫面上
            DISPLAY g_prbj_d[l_ac].prbj008_desc TO prbj008_desc #稅別代碼

            NEXT FIELD prbj008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj008_desc
            #add-point:ON ACTION controlp INFIELD prbj008_desc name="input.c.page1.prbj008_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0091
            #add-point:ON ACTION controlp INFIELD prbj0091 name="input.c.page1.prbj0091"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj009
            #add-point:ON ACTION controlp INFIELD prbj009 name="input.c.page1.prbj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0161
            #add-point:ON ACTION controlp INFIELD prbj0161 name="input.c.page1.prbj0161"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0171
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0171
            #add-point:ON ACTION controlp INFIELD prbj0171 name="input.c.page1.prbj0171"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj016
            #add-point:ON ACTION controlp INFIELD prbj016 name="input.c.page1.prbj016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj017
            #add-point:ON ACTION controlp INFIELD prbj017 name="input.c.page1.prbj017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0101
            #add-point:ON ACTION controlp INFIELD prbj0101 name="input.c.page1.prbj0101"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj0101             #給予default值
            LET g_qryparam.default2 = "" #g_prbj_d[l_ac].oodb002 #稅別代碼
            #給予arg
            LET g_qryparam.arg1 =g_prbj_d[l_ac].prbjsite


            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prbj_d[l_ac].prbj0101 = g_qryparam.return1      
            DISPLAY g_prbj_d[l_ac].prbj0101 TO prbj0101              #
            NEXT FIELD prbj0101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0101_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0101_desc
            #add-point:ON ACTION controlp INFIELD prbj0101_desc name="input.c.page1.prbj0101_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj010
            #add-point:ON ACTION controlp INFIELD prbj010 name="input.c.page1.prbj010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbj_d[l_ac].prbj010             #給予default值
            LET g_qryparam.default2 = g_prbj_d[l_ac].prbj010_desc  #稅別代碼

            #給予arg
            LET g_qryparam.arg1 =g_prbj_d[l_ac].prbjsite

            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prbj_d[l_ac].prbj010 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbj_d[l_ac].prbj010_desc = g_qryparam.return2 #稅別代碼

            DISPLAY g_prbj_d[l_ac].prbj010 TO prbj010              #顯示到畫面上
            DISPLAY g_prbj_d[l_ac].prbj010_desc TO prbj010_desc #稅別代碼

            NEXT FIELD prbj010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj010_desc
            #add-point:ON ACTION controlp INFIELD prbj010_desc name="input.c.page1.prbj010_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0111
            #add-point:ON ACTION controlp INFIELD prbj0111 name="input.c.page1.prbj0111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj011
            #add-point:ON ACTION controlp INFIELD prbj011 name="input.c.page1.prbj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0181
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0181
            #add-point:ON ACTION controlp INFIELD prbj0181 name="input.c.page1.prbj0181"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0191
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0191
            #add-point:ON ACTION controlp INFIELD prbj0191 name="input.c.page1.prbj0191"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj018
            #add-point:ON ACTION controlp INFIELD prbj018 name="input.c.page1.prbj018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj019
            #add-point:ON ACTION controlp INFIELD prbj019 name="input.c.page1.prbj019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0121
            #add-point:ON ACTION controlp INFIELD prbj0121 name="input.c.page1.prbj0121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0131
            #add-point:ON ACTION controlp INFIELD prbj0131 name="input.c.page1.prbj0131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0141
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0141
            #add-point:ON ACTION controlp INFIELD prbj0141 name="input.c.page1.prbj0141"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj012
            #add-point:ON ACTION controlp INFIELD prbj012 name="input.c.page1.prbj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj013
            #add-point:ON ACTION controlp INFIELD prbj013 name="input.c.page1.prbj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj014
            #add-point:ON ACTION controlp INFIELD prbj014 name="input.c.page1.prbj014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj0151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj0151
            #add-point:ON ACTION controlp INFIELD prbj0151 name="input.c.page1.prbj0151"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbj015
            #add-point:ON ACTION controlp INFIELD prbj015 name="input.c.page1.prbj015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbjunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbjunit
            #add-point:ON ACTION controlp INFIELD prbjunit name="input.c.page1.prbjunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prbj_d[l_ac].* = g_prbj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt122_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prbj_d[l_ac].prbjseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prbj_d[l_ac].* = g_prbj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #更新調整前資料               
               UPDATE prbj_t SET (prbjdocno,prbjseq,prbjsite,prbj002,prbj001,prbj004,prbj003,prbj005, 
                   prbj006,prbj007,prbjseq1,prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,prbj018, 
                   prbj019,prbj012,prbj013,prbj014,prbj015,prbjunit) = (g_prbi_m.prbidocno,g_prbj_d[l_ac].prbjseq, 
                   g_prbj_d[l_ac].prbjsite,g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj004, 
                   g_prbj_d[l_ac].prbj003,g_prbj_d[l_ac].prbj005,g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007, 
                   0,g_prbj_d[l_ac].prbj0081,g_prbj_d[l_ac].prbj0091,g_prbj_d[l_ac].prbj0161, 
                   g_prbj_d[l_ac].prbj0171,g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0111,g_prbj_d[l_ac].prbj0181, 
                   g_prbj_d[l_ac].prbj0191,g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141, 
                   g_prbj_d[l_ac].prbj0151,g_prbj_d[l_ac].prbjunit)
                WHERE prbjent = g_enterprise AND prbjdocno = g_prbi_m.prbidocno 
 
                  AND prbjseq = g_prbj_d_t.prbjseq #項次   
                  AND prbjseq1 = 0               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt122_prbj_t_mask_restore('restore_mask_o')
      
               UPDATE prbj_t SET (prbjdocno,prbjseq,prbjsite,prbj002,prbj001,prbj004,prbj003,prbj005, 
                   prbj006,prbj007,prbjseq1,prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,prbj018, 
                   prbj019,prbj012,prbj013,prbj014,prbj015,prbjunit) = (g_prbi_m.prbidocno,g_prbj_d[l_ac].prbjseq, 
                   g_prbj_d[l_ac].prbjsite,g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj004, 
                   g_prbj_d[l_ac].prbj003,g_prbj_d[l_ac].prbj005,g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007, 
                   g_prbj_d[l_ac].prbjseq1,g_prbj_d[l_ac].prbj008,g_prbj_d[l_ac].prbj009,g_prbj_d[l_ac].prbj016, 
                   g_prbj_d[l_ac].prbj017,g_prbj_d[l_ac].prbj010,g_prbj_d[l_ac].prbj011,g_prbj_d[l_ac].prbj018, 
                   g_prbj_d[l_ac].prbj019,g_prbj_d[l_ac].prbj012,g_prbj_d[l_ac].prbj013,g_prbj_d[l_ac].prbj014, 
                   g_prbj_d[l_ac].prbj015,g_prbj_d[l_ac].prbjunit)
                WHERE prbjent = g_enterprise AND prbjdocno = g_prbi_m.prbidocno 
 
                  AND prbjseq = g_prbj_d_t.prbjseq #項次   
                  AND prbjseq1 = g_prbj_d_t.prbjseq1  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prbj_d[l_ac].* = g_prbj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prbj_d[l_ac].* = g_prbj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbi_m.prbidocno
               LET gs_keys_bak[1] = g_prbidocno_t
               LET gs_keys[2] = g_prbj_d[g_detail_idx].prbjseq
               LET gs_keys_bak[2] = g_prbj_d_t.prbjseq
               LET gs_keys[3] = g_prbj_d[g_detail_idx].prbjseq1
               LET gs_keys_bak[3] = g_prbj_d_t.prbjseq1
               CALL aprt122_update_b('prbj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt122_prbj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prbj_d[g_detail_idx].prbjseq = g_prbj_d_t.prbjseq 
                  AND g_prbj_d[g_detail_idx].prbjseq1 = g_prbj_d_t.prbjseq1 
 
                  ) THEN
                  LET gs_keys[01] = g_prbi_m.prbidocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prbj_d_t.prbjseq
                  LET gs_keys[gs_keys.getLength()+1] = g_prbj_d_t.prbjseq1
 
                  CALL aprt122_key_update_b(gs_keys,'prbj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prbi_m),util.JSON.stringify(g_prbj_d_t)
               LET g_log2 = util.JSON.stringify(g_prbi_m),util.JSON.stringify(g_prbj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
 
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt122_unlock_b("prbj_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            IF p_cmd = 'u' THEN              
               UPDATE prbi_t SET (prbimodid,prbimoddt) = (g_prbi_m.prbimodid,g_prbi_m.prbimoddt)
                WHERE prbient = g_enterprise AND prbidocno = g_prbi_m.prbidocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prbi_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbj_d[l_ac].* = g_prbj_d_t.*                     
                  CALL s_transaction_end('N','0')
               END IF
            END IF 
            CALL aprt122_show()                       

            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prbj_d[li_reproduce_target].* = g_prbj_d[li_reproduce].*
 
               LET g_prbj_d[li_reproduce_target].prbjseq = NULL
               LET g_prbj_d[li_reproduce_target].prbjseq1 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prbj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aprt122.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD prbisite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prbjseq
 
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
            NEXT FIELD prbidocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prbjseq
 
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
   IF INT_FLAG AND l_cmd = 'a' THEN
      DELETE FROM prbj_t 
       WHERE prbjent = g_enterprise
         AND prbjdocno = g_prbi_m.prbidocno
         AND prbjseq = g_prbj_d[l_ac].prbjseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del prbj_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF     
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt122_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooef019      LIKE ooef_t.ooef019
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt122_b_fill() #單身填充
      CALL aprt122_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt122_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
 
   #end add-point
   
   #遮罩相關處理
   LET g_prbi_m_mask_o.* =  g_prbi_m.*
   CALL aprt122_prbi_t_mask()
   LET g_prbi_m_mask_n.* =  g_prbi_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbisite_desc,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit, 
       g_prbi_m.prbi001,g_prbi_m.prbi001_desc,g_prbi_m.prbi002,g_prbi_m.prbi002_desc,g_prbi_m.prbi003, 
       g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi004_desc,g_prbi_m.prbi005,g_prbi_m.prbi005_desc, 
       g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp, 
       g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid,g_prbi_m.prbicrtid_desc,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdp_desc, 
       g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimodid_desc,g_prbi_m.prbimoddt,g_prbi_m.prbicnfid, 
       g_prbi_m.prbicnfid_desc,g_prbi_m.prbicnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbi_m.prbistus 
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
   FOR l_ac = 1 TO g_prbj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbj_d[l_ac].prbj001_desc_desc_desc
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].rtaxl003 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].rtaxl003

            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prbj_d[l_ac].prbjsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbj_d[l_ac].prbj008
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj008_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbj_d[l_ac].prbj010
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbj_d[l_ac].prbj0081
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj0081_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj0081_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbj_d[l_ac].prbj0101
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbj_d[l_ac].prbj0101_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbj_d[l_ac].prbj0101_desc
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt122_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt122_detail_show()
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
 
{<section id="aprt122.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt122_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prbi_t.prbidocno 
   DEFINE l_oldno     LIKE prbi_t.prbidocno 
 
   DEFINE l_master    RECORD LIKE prbi_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prbj_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
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
   
   IF g_prbi_m.prbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prbidocno_t = g_prbi_m.prbidocno
 
    
   LET g_prbi_m.prbidocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbi_m.prbiownid = g_user
      LET g_prbi_m.prbiowndp = g_dept
      LET g_prbi_m.prbicrtid = g_user
      LET g_prbi_m.prbicrtdp = g_dept 
      LET g_prbi_m.prbicrtdt = cl_get_current()
      LET g_prbi_m.prbimodid = g_user
      LET g_prbi_m.prbimoddt = cl_get_current()
      LET g_prbi_m.prbistus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_prbi_m.prbisite = g_site
   LET g_prbi_m.prbiunit = g_site            
   LET g_prbi_m.prbidocdt = g_today
   LET g_prbi_m.prbi003 = g_today
   LET g_prbi_m.prbi004 = g_user
   LET g_prbi_m.prbi005 = g_dept
   LET g_prbi_m.prbistus = 'N'

   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prbi_m.prbisite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prbi_m.prbidocno = r_doctype
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbi_m.prbi004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbi_m.prbi004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbi_m.prbi004_desc
         
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbi_m.prbi005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbi_m.prbi005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbi_m.prbi005_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbi_m.prbisite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbi_m.prbisite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbi_m.prbisite_desc 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbi_m.prbistus 
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
   
   
   CALL aprt122_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prbi_m.* TO NULL
      INITIALIZE g_prbj_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt122_show()
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
   CALL aprt122_set_act_visible()   
   CALL aprt122_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prbidocno_t = g_prbi_m.prbidocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prbient = " ||g_enterprise|| " AND",
                      " prbidocno = '", g_prbi_m.prbidocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt122_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt122_idx_chk()
   
   LET g_data_owner = g_prbi_m.prbiownid      
   LET g_data_dept  = g_prbi_m.prbiowndp
   
   #功能已完成,通報訊息中心
   CALL aprt122_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt122_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prbj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt122_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prbj_t
    WHERE prbjent = g_enterprise AND prbjdocno = g_prbidocno_t
 
    INTO TEMP aprt122_detail
 
   #將key修正為調整後   
   UPDATE aprt122_detail 
      #更新key欄位
      SET prbjdocno = g_prbi_m.prbidocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prbj_t SELECT * FROM aprt122_detail
   
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
   DROP TABLE aprt122_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prbidocno_t = g_prbi_m.prbidocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt122_delete()
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
   
   IF g_prbi_m.prbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt122_cl USING g_enterprise,g_prbi_m.prbidocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt122_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt122_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
       g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
       g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
       g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
       g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
       g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid_desc, 
       g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt122_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prbi_m_mask_o.* =  g_prbi_m.*
   CALL aprt122_prbi_t_mask()
   LET g_prbi_m_mask_n.* =  g_prbi_m.*
   
   CALL aprt122_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt122_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prbidocno_t = g_prbi_m.prbidocno
 
 
      DELETE FROM prbi_t
       WHERE prbient = g_enterprise AND prbidocno = g_prbi_m.prbidocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prbi_m.prbidocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"

      IF NOT s_aooi200_del_docno(g_prbi_m.prbidocno,g_prbi_m.prbidocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM prbj_t
       WHERE prbjent = g_enterprise AND prbjdocno = g_prbi_m.prbidocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prbi_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt122_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prbj_d.clear() 
 
     
      CALL aprt122_ui_browser_refresh()  
      #CALL aprt122_ui_headershow()  
      #CALL aprt122_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt122_browser_fill("")
         CALL aprt122_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt122_cl
 
   #功能已完成,通報訊息中心
   CALL aprt122_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt122.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt122_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prbj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt122_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prbjseq,prbjsite,prbj002,prbj001,prbj004,prbj003,prbj005,prbj006, 
             prbj007,prbjseq1,prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,prbj018,prbj019,prbj012, 
             prbj013,prbj014,prbj015,prbjunit ,t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t4.imaa009 ,t5.oocal003 FROM prbj_t", 
                
                     " INNER JOIN prbi_t ON prbient = " ||g_enterprise|| " AND prbidocno = prbjdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=prbjsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=prbj001 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=prbj001 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaa_t t4 ON t4.imaaent="||g_enterprise||" AND t4.imaa001=prbj001  ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=prbj005 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE prbjent=? AND prbjdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prbj_t.prbjseq,prbj_t.prbjseq1"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt122_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt122_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prbi_m.prbidocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prbi_m.prbidocno INTO g_prbj_d[l_ac].prbjseq,g_prbj_d[l_ac].prbjsite, 
          g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj001,g_prbj_d[l_ac].prbj004,g_prbj_d[l_ac].prbj003, 
          g_prbj_d[l_ac].prbj005,g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007,g_prbj_d[l_ac].prbjseq1, 
          g_prbj_d[l_ac].prbj008,g_prbj_d[l_ac].prbj009,g_prbj_d[l_ac].prbj016,g_prbj_d[l_ac].prbj017, 
          g_prbj_d[l_ac].prbj010,g_prbj_d[l_ac].prbj011,g_prbj_d[l_ac].prbj018,g_prbj_d[l_ac].prbj019, 
          g_prbj_d[l_ac].prbj012,g_prbj_d[l_ac].prbj013,g_prbj_d[l_ac].prbj014,g_prbj_d[l_ac].prbj015, 
          g_prbj_d[l_ac].prbjunit,g_prbj_d[l_ac].prbjsite_desc,g_prbj_d[l_ac].prbj001_desc,g_prbj_d[l_ac].prbj001_desc_desc, 
          g_prbj_d[l_ac].prbj001_desc_desc_desc,g_prbj_d[l_ac].prbj005_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #按照要求，調整前後數據各自一行
         #顯示的時候需要合併成一行
         IF g_prbj_d[l_ac].prbjseq1 = '0' THEN  #調整前
            CONTINUE FOREACH
         END IF

         IF g_prbj_d[l_ac].prbjseq1 = '1' THEN
            SELECT prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,
                   prbj018,prbj019,prbj012,prbj013,prbj014,prbj015
              INTO g_prbj_d[l_ac].prbj0081,g_prbj_d[l_ac].prbj0091,g_prbj_d[l_ac].prbj0161,g_prbj_d[l_ac].prbj0171,g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0111, 
                   g_prbj_d[l_ac].prbj0181,g_prbj_d[l_ac].prbj0191,g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141,g_prbj_d[l_ac].prbj0151              
             FROM prbj_t
            WHERE prbjent=g_enterprise
              AND prbjdocno=g_prbi_m.prbidocno
              AND prbjseq=g_prbj_d[l_ac].prbjseq
              AND prbjseq1=0     
         END IF           
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
   
   CALL g_prbj_d.deleteElement(g_prbj_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt122_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prbj_d.getLength()
      LET g_prbj_d_mask_o[l_ac].* =  g_prbj_d[l_ac].*
      CALL aprt122_prbj_t_mask()
      LET g_prbj_d_mask_n[l_ac].* =  g_prbj_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt122_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prbj_t
       WHERE prbjent = g_enterprise AND
         prbjdocno = ps_keys_bak[1] AND prbjseq = ps_keys_bak[2] AND prbjseq1 = ps_keys_bak[3]
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
         CALL g_prbj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   CALL aprt122_b_fill() 
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt122_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prbj_t
                  (prbjent,
                   prbjdocno,
                   prbjseq,prbjseq1
                   ,prbjsite,prbj002,prbj001,prbj004,prbj003,prbj005,prbj006,prbj007,prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,prbj018,prbj019,prbj012,prbj013,prbj014,prbj015,prbjunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_prbj_d[g_detail_idx].prbjsite,g_prbj_d[g_detail_idx].prbj002,g_prbj_d[g_detail_idx].prbj001, 
                       g_prbj_d[g_detail_idx].prbj004,g_prbj_d[g_detail_idx].prbj003,g_prbj_d[g_detail_idx].prbj005, 
                       g_prbj_d[g_detail_idx].prbj006,g_prbj_d[g_detail_idx].prbj007,g_prbj_d[g_detail_idx].prbj008, 
                       g_prbj_d[g_detail_idx].prbj009,g_prbj_d[g_detail_idx].prbj016,g_prbj_d[g_detail_idx].prbj017, 
                       g_prbj_d[g_detail_idx].prbj010,g_prbj_d[g_detail_idx].prbj011,g_prbj_d[g_detail_idx].prbj018, 
                       g_prbj_d[g_detail_idx].prbj019,g_prbj_d[g_detail_idx].prbj012,g_prbj_d[g_detail_idx].prbj013, 
                       g_prbj_d[g_detail_idx].prbj014,g_prbj_d[g_detail_idx].prbj015,g_prbj_d[g_detail_idx].prbjunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prbj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt122_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prbj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt122_prbj_t_mask_restore('restore_mask_o')
               
      UPDATE prbj_t 
         SET (prbjdocno,
              prbjseq,prbjseq1
              ,prbjsite,prbj002,prbj001,prbj004,prbj003,prbj005,prbj006,prbj007,prbj008,prbj009,prbj016,prbj017,prbj010,prbj011,prbj018,prbj019,prbj012,prbj013,prbj014,prbj015,prbjunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_prbj_d[g_detail_idx].prbjsite,g_prbj_d[g_detail_idx].prbj002,g_prbj_d[g_detail_idx].prbj001, 
                  g_prbj_d[g_detail_idx].prbj004,g_prbj_d[g_detail_idx].prbj003,g_prbj_d[g_detail_idx].prbj005, 
                  g_prbj_d[g_detail_idx].prbj006,g_prbj_d[g_detail_idx].prbj007,g_prbj_d[g_detail_idx].prbj008, 
                  g_prbj_d[g_detail_idx].prbj009,g_prbj_d[g_detail_idx].prbj016,g_prbj_d[g_detail_idx].prbj017, 
                  g_prbj_d[g_detail_idx].prbj010,g_prbj_d[g_detail_idx].prbj011,g_prbj_d[g_detail_idx].prbj018, 
                  g_prbj_d[g_detail_idx].prbj019,g_prbj_d[g_detail_idx].prbj012,g_prbj_d[g_detail_idx].prbj013, 
                  g_prbj_d[g_detail_idx].prbj014,g_prbj_d[g_detail_idx].prbj015,g_prbj_d[g_detail_idx].prbjunit)  
 
         WHERE prbjent = g_enterprise AND prbjdocno = ps_keys_bak[1] AND prbjseq = ps_keys_bak[2] AND prbjseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt122_prbj_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aprt122.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt122_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt122.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt122_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt122.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt122_lock_b(ps_table,ps_page)
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
   #CALL aprt122_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prbj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt122_bcl USING g_enterprise,
                                       g_prbi_m.prbidocno,g_prbj_d[g_detail_idx].prbjseq,g_prbj_d[g_detail_idx].prbjseq1  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt122_bcl:",SQLERRMESSAGE 
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
 
{<section id="aprt122.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt122_unlock_b(ps_table,ps_page)
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
      CLOSE aprt122_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt122_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prbidocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prbidocno",TRUE)
      CALL cl_set_comp_entry("prbidocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prbisite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("prbi001,prbi002,prbi005",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt122_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prbidocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM prbj_t
       WHERE prbjent = g_enterprise
         AND prbjdocno = g_prbi_m.prbidocno
      IF l_n > 0 THEN
         CALL cl_set_comp_entry("prbi001,prbi002,prbi005",FALSE)
      END IF     
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prbidocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prbidocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'prbisite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prbisite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt122_set_entry_b(p_cmd)
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
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prbj001,prbjsite,prbj002,prbj004",TRUE)
      CALL cl_set_comp_entry("prbj009,prbj011,prbj012,prbj013,prbj014,prbj016,prbj017,prbj018,prbj019",TRUE)  
   END IF 
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt122_set_no_entry_b(p_cmd)
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
   IF p_cmd = 'u' THEN  
      CALL cl_set_comp_entry("prbj001,prbjsite,prbj002,prbj004",TRUE)
      CALL cl_set_comp_entry("prbj009,prbj011,prbj012,prbj013,prbj014,prbj016,prbj017,prbj018,prbj019",TRUE)  
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt122_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt122_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prbi_m.prbistus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt122_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt122_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt122_default_search()
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
      LET ls_wc = ls_wc, " prbidocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "prbi_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prbj_t" 
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
 
{<section id="aprt122.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt122_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_prbimoddt DATETIME YEAR TO SECOND
   DEFINE l_param  RECORD
      prbk006         LIKE prbk_t.prbk006,
      prbk025         LIKE prbk_t.prbk025,          
      wc              STRING
                   END RECORD   
   DEFINE l_sql    STRING 
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_n1     LIKE type_t.num5
   DEFINE l_n2     LIKE type_t.num5  
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prbi_m.prbidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt122_cl USING g_enterprise,g_prbi_m.prbidocno
   IF STATUS THEN
      CLOSE aprt122_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt122_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
       g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
       g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
       g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
       g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
       g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid_desc, 
       g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt122_action_chk() THEN
      CLOSE aprt122_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbisite_desc,g_prbi_m.prbidocdt,g_prbi_m.prbidocno,g_prbi_m.prbiunit, 
       g_prbi_m.prbi001,g_prbi_m.prbi001_desc,g_prbi_m.prbi002,g_prbi_m.prbi002_desc,g_prbi_m.prbi003, 
       g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi004_desc,g_prbi_m.prbi005,g_prbi_m.prbi005_desc, 
       g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp, 
       g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid,g_prbi_m.prbicrtid_desc,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdp_desc, 
       g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimodid_desc,g_prbi_m.prbimoddt,g_prbi_m.prbicnfid, 
       g_prbi_m.prbicnfid_desc,g_prbi_m.prbicnfdt
 
   CASE g_prbi_m.prbistus
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
         CASE g_prbi_m.prbistus
            
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
      CASE g_prbi_m.prbistus
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
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "invalid"
            HIDE OPTION "unconfirmed"
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
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
            IF NOT aprt122_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt122_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt122_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt122_cl
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
      g_prbi_m.prbistus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt122_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE
      WHEN lc_state = 'Y'
         CALL cl_err_collect_init()
         CALL s_aprt121_conf_chk(g_prbi_m.prbidocno,g_prbi_m.prbistus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            #判断调价清单日期是否重叠
            LET l_n1 = 0
            SELECT COUNT(*) INTO l_n1
              FROM prbk_t,prbj_t
             WHERE prbkent = g_enterprise
               AND prbkent = prbjent
               AND prbjdocno = g_prbi_m.prbidocno
               AND prbjseq1 = '1'
               AND prbksite = prbjsite
               AND prbk010 = prbj001
               AND prbj009 IS NOT NULL
               AND prbk025 = '1'
               AND ((prbk006 <= prbj016 AND (prbk007 >= prbj016 AND prbk007 <= prbj017)) OR 
                    (prbk006 <= prbj016 AND prbk007 >= prbj017) OR 
                    ((prbk006 >= prbj016 AND prbk006 <= prbj017) AND prbk007 >= prbj017))
               AND prbk003 = g_prbi_m.prbi000    #20150704--add by dongsz
            LET l_n2 = 0
            SELECT COUNT(*) INTO l_n2
              FROM prbk_t,prbj_t
             WHERE prbkent = g_enterprise
               AND prbkent = prbjent
               AND prbjdocno = g_prbi_m.prbidocno
               AND prbjseq1 = '1'
               AND prbksite = prbjsite
               AND prbk010 = prbj001
               AND prbj011 IS NOT NULL
               AND prbk025 = '2'
               AND ((prbk006 <= prbj018 AND (prbk007 >= prbj019 AND prbk007 <= prbj019)) OR 
                    (prbk006 <= prbj018 AND prbk007 >= prbj019) OR 
                    ((prbk006 >= prbj018 AND prbk006 <= prbj019) AND prbk007 >= prbj019))
               AND prbk003 = g_prbi_m.prbi000    #20150704--add by dongsz
            LET l_n = l_n1 + l_n2
            IF l_n > 0 THEN
               IF NOT cl_ask_confirm('apr-00358') THEN
                  CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
                  RETURN
               END IF
            END IF
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_aprt121_conf_upd(g_prbi_m.prbidocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbi_m.prbidocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  #執行日期為當前日期，則立即執行調價作業aprp125
                  LET g_success = 'Y'
                  LET g_num1 = 0
                  #判断单身开始日期是否等于当前日期
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM prbj_t
                   WHERE prbjent = g_enterprise
                     AND prbjdocno = g_prbi_m.prbidocno
                     AND prbjseq1 = '1'
                     AND ((prbj009 IS NOT NULL AND prbj016 = g_today) OR
                          (prbj011 IS NOT NULL AND prbj018 = g_today))
                  IF l_n > 0 THEN
                     IF cl_ask_confirm("apr-00271") THEN
                        LET l_param.prbk006 = g_today
                        LET l_param.wc = " prbk001 = '",g_prbi_m.prbidocno,"' "
                        IF g_prbi_m.prbi000 = '4' THEN       #20150704--add by dongsz
                           CALL s_aprp125_upd_price_4(l_param.*) RETURNING g_success,g_num1
                           IF g_success = 'N' THEN
                              CALL s_transaction_end('N','0')
                              RETURN
                           END IF
                        END IF                #20150704--add by dongsz
                        #20150704--add by dongsz--s
                        IF g_prbi_m.prbi000 = '5' THEN
                           CALL s_aprp125_upd_price_5(l_param.*) RETURNING g_success,g_num1
                           IF g_success = 'N' THEN
                              CALL s_transaction_end('N','0')
                              RETURN
                           END IF
                        END IF
                        #20150704--add by dongsz--e
                        LET l_sql = " UPDATE prbk_t SET prbkstus = '2' ",
                                    "  WHERE prbkent = '",g_enterprise,"' ",
                                    "    AND prbk006 = '",l_param.prbk006,"' ",
                                    "    AND prbkstus = '1' ",
                                    "    AND ",l_param.wc
                        PREPARE upd_prbk_pre1 FROM l_sql
                        EXECUTE upd_prbk_pre1
                        IF SQLCA.sqlcode THEN
                           CALL cl_errmsg('prbk_t','upd','',SQLCA.sqlcode,1)
                           LET l_success = 'N'
                           CALL s_transaction_end('N','0')
                           RETURN
                        END IF
                        IF l_success = 'Y' THEN                          
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00209'
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = g_num1
                           CALL cl_err()

                        END IF
                     END IF
                  END IF
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
      WHEN lc_state = 'X'
         CALL cl_err_collect_init()
         CALL s_aprt121_void_chk(g_prbi_m.prbidocno,g_prbi_m.prbistus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('art-00039') THEN
               CALL s_transaction_begin()
               CALL s_aprt121_void_upd(g_prbi_m.prbidocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbi_m.prbidocno
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
      WHEN lc_state = 'N'
         CALL cl_err_collect_init()
         CALL s_aprt121_unconf_chk(g_prbi_m.prbidocno,g_prbi_m.prbistus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_aprt121_unconf_upd(g_prbi_m.prbidocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbi_m.prbidocno
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
      OTHERWISE
         CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
         RETURN
   END CASE                 {#ADP版次:1#}  
   #end add-point
   
   LET g_prbi_m.prbimodid = g_user
   LET g_prbi_m.prbimoddt = cl_get_current()
   LET g_prbi_m.prbistus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prbi_t 
      SET (prbistus,prbimodid,prbimoddt) 
        = (g_prbi_m.prbistus,g_prbi_m.prbimodid,g_prbi_m.prbimoddt)     
    WHERE prbient = g_enterprise AND prbidocno = g_prbi_m.prbidocno
 
    
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
      EXECUTE aprt122_master_referesh USING g_prbi_m.prbidocno INTO g_prbi_m.prbisite,g_prbi_m.prbidocdt, 
          g_prbi_m.prbidocno,g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi002,g_prbi_m.prbi003,g_prbi_m.prbi000, 
          g_prbi_m.prbi004,g_prbi_m.prbi005,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiowndp, 
          g_prbi_m.prbicrtid,g_prbi_m.prbicrtdp,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimoddt, 
          g_prbi_m.prbicnfid,g_prbi_m.prbicnfdt,g_prbi_m.prbisite_desc,g_prbi_m.prbi001_desc,g_prbi_m.prbi002_desc, 
          g_prbi_m.prbi004_desc,g_prbi_m.prbi005_desc,g_prbi_m.prbiownid_desc,g_prbi_m.prbiowndp_desc, 
          g_prbi_m.prbicrtid_desc,g_prbi_m.prbicrtdp_desc,g_prbi_m.prbimodid_desc,g_prbi_m.prbicnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prbi_m.prbisite,g_prbi_m.prbisite_desc,g_prbi_m.prbidocdt,g_prbi_m.prbidocno, 
          g_prbi_m.prbiunit,g_prbi_m.prbi001,g_prbi_m.prbi001_desc,g_prbi_m.prbi002,g_prbi_m.prbi002_desc, 
          g_prbi_m.prbi003,g_prbi_m.prbi000,g_prbi_m.prbi004,g_prbi_m.prbi004_desc,g_prbi_m.prbi005, 
          g_prbi_m.prbi005_desc,g_prbi_m.prbi006,g_prbi_m.prbistus,g_prbi_m.prbiownid,g_prbi_m.prbiownid_desc, 
          g_prbi_m.prbiowndp,g_prbi_m.prbiowndp_desc,g_prbi_m.prbicrtid,g_prbi_m.prbicrtid_desc,g_prbi_m.prbicrtdp, 
          g_prbi_m.prbicrtdp_desc,g_prbi_m.prbicrtdt,g_prbi_m.prbimodid,g_prbi_m.prbimodid_desc,g_prbi_m.prbimoddt, 
          g_prbi_m.prbicnfid,g_prbi_m.prbicnfid_desc,g_prbi_m.prbicnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF lc_state = 'X' THEN
      LET l_prbimoddt = cl_get_current()
      UPDATE prbi_t SET (prbimodid,prbimoddt) = (g_user,l_prbimoddt)
       WHERE prbient = g_enterprise AND prbidocno = g_prbi_m.prbidocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "prbi_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_prbj_d[l_ac].* = g_prbj_d_t.*
      END IF
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt122_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt122_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt122.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt122_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prbj_d.getLength() THEN
         LET g_detail_idx = g_prbj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prbj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prbj_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt122_b_fill2(pi_idx)
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
   
   CALL aprt122_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt122_fill_chk(ps_idx)
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
 
{<section id="aprt122.status_show" >}
PRIVATE FUNCTION aprt122_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt122.mask_functions" >}
&include "erp/apr/aprt122_mask.4gl"
 
{</section>}
 
{<section id="aprt122.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt122_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.chr2
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt122_show()
   CALL aprt122_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt121_conf_chk(g_prbi_m.prbidocno,g_prbi_m.prbistus) RETURNING l_success
   IF NOT l_success THEN
      CLOSE aprt122_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prbi_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prbj_d))
 
 
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
   #CALL aprt122_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt122_ui_headershow()
   CALL aprt122_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt122_draw_out()
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
   CALL aprt122_ui_headershow()  
   CALL aprt122_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt122.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt122_set_pk_array()
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
   LET g_pk_array[1].values = g_prbi_m.prbidocno
   LET g_pk_array[1].column = 'prbidocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt122.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt122.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt122_msgcentre_notify(lc_state)
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
   CALL aprt122_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prbi_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt122.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt122_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#29 add-S
   SELECT prbistus  INTO g_prbi_m.prbistus
     FROM prbi_t
    WHERE prbient = g_enterprise
      AND prbidocno = g_prbi_m.prbidocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prbi_m.prbistus
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
        LET g_errparam.extend = g_prbi_m.prbidocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt122_set_act_visible()
        CALL aprt122_set_act_no_visible()
        CALL aprt122_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#29 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt122.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 由商品編號帶值
# Memo...........:
# Usage..........: CALL aprt122_prbj001_ref(p_cmd)
# Input parameter: p_cmd   類型a.新增 u.修改
# Date & Author..: 2015/06/17 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt122_prbj001_ref(p_cmd)
DEFINE p_cmd      LIKE type_t.chr1
DEFINE l_ooef019  LIKE ooef_t.ooef019
DEFINE l_n        LIKE type_t.num5
DEFINE l_sql      STRING

   SELECT imaa009,imaal003,imaal004
     INTO g_prbj_d[l_ac].prbj001_desc_desc_desc,g_prbj_d[l_ac].prbj001_desc,g_prbj_d[l_ac].prbj001_desc_desc
     FROM imaa_t LEFT OUTER JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = g_dlang
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prbj_d[l_ac].prbj001
  
   SELECT rtaxl003 INTO g_prbj_d[l_ac].rtaxl003
     FROM rtaxl_t
    WHERE rtaxlent = g_enterprise
      AND rtaxl001 = g_prbj_d[l_ac].prbj001_desc_desc_desc
      AND rtaxl002 = g_dlang
      
   DISPLAY BY NAME g_prbj_d[l_ac].prbj001_desc_desc_desc,g_prbj_d[l_ac].prbj001_desc,
                   g_prbj_d[l_ac].prbj001_desc_desc,g_prbj_d[l_ac].rtaxl003
      
   IF p_cmd = 'u' THEN           
      IF (g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002 OR cl_null(g_prbj_d_t.prbj002)) AND 
         (g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004 OR cl_null(g_prbj_d_t.prbj004)) THEN
         LET g_prbj_d[l_ac].prbj002 = NULL
         LET g_prbj_d[l_ac].prbj004 = NULL
      ELSE
         IF (g_prbj_d[l_ac].prbj002 = g_prbj_d_t.prbj002 OR cl_null(g_prbj_d_t.prbj002)) THEN
            LET g_prbj_d[l_ac].prbj002 = NULL
         END IF
         IF (g_prbj_d[l_ac].prbj004 = g_prbj_d_t.prbj004 OR cl_null(g_prbj_d_t.prbj004)) THEN
            LET g_prbj_d[l_ac].prbj004 = NULL
         END IF
      END IF         
   END IF                        
   IF cl_null(g_prbj_d[l_ac].prbj002) AND cl_null(g_prbj_d[l_ac].prbj004) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n 
        FROM prbh_t
       WHERE prbhent = g_enterprise
         AND prbhsite = g_prbj_d[l_ac].prbjsite
         AND prbh003 = g_prbj_d[l_ac].prbj001
      IF l_n = 1 THEN
         SELECT prbh001,prbh004,prbh006,prbh007,prbh008,prbh009,
                prbh010,prbh011,prbh012,prbh013,prbh014,prbh015,
                prbh016,prbh017,prbh018,prbh019                      
           INTO g_prbj_d[l_ac].prbj004,g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj005,
                g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007,g_prbj_d[l_ac].prbj0081,
                g_prbj_d[l_ac].prbj0091,g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0111,
                g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141,
                g_prbj_d[l_ac].prbj0161,g_prbj_d[l_ac].prbj0171,g_prbj_d[l_ac].prbj0181,g_prbj_d[l_ac].prbj0191 
           FROM prbh_t
          WHERE prbhent = g_enterprise
            AND prbhsite = g_prbj_d[l_ac].prbjsite
            AND prbh003 = g_prbj_d[l_ac].prbj001
         LET g_prbj_d[l_ac].prbj0151 = (g_prbj_d[l_ac].prbj0111-g_prbj_d[l_ac].prbj0091)/g_prbj_d[l_ac].prbj0111*100
      END IF
   ELSE    
      LET l_sql = " SELECT prbh001,prbh004,prbh006,prbh007,prbh008,prbh009,",
                  "        prbh010,prbh011,prbh012,prbh013,prbh014,prbh015, ",
                  "        prbh016,prbh017,prbh018,prbh019 ",              
                  "   FROM prbh_t ",
                  "  WHERE prbhent = '",g_enterprise,"' ",
                  "    AND prbhsite = '",g_prbj_d[l_ac].prbjsite,"' ",
                  "    AND prbh003 = '",g_prbj_d[l_ac].prbj001,"' "
      IF NOT cl_null(g_prbj_d[l_ac].prbj002) AND cl_null(g_prbj_d[l_ac].prbj004) THEN
         LET l_sql = l_sql," AND prbh004 = '",g_prbj_d[l_ac].prbj002,"' "
      END IF
      IF NOT cl_null(g_prbj_d[l_ac].prbj004) AND cl_null(g_prbj_d[l_ac].prbj002) THEN
         LET l_sql = l_sql," AND prbh001 = '",g_prbj_d[l_ac].prbj004,"' "
      END IF
      IF NOT cl_null(g_prbj_d[l_ac].prbj004) AND NOT cl_null(g_prbj_d[l_ac].prbj002) THEN
         LET l_sql = l_sql," AND prbh001 = '",g_prbj_d[l_ac].prbj004,"' AND prbh004 = '",g_prbj_d[l_ac].prbj002,"' "
      END IF
      PREPARE sel_prbh_pre FROM l_sql
      EXECUTE sel_prbh_pre INTO g_prbj_d[l_ac].prbj004,g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj005,
              g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007,g_prbj_d[l_ac].prbj0081,
              g_prbj_d[l_ac].prbj0091,g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0111,
              g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141,
              g_prbj_d[l_ac].prbj0161,g_prbj_d[l_ac].prbj0171,g_prbj_d[l_ac].prbj0181,g_prbj_d[l_ac].prbj0191 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel prbh'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_prbj_d[l_ac].* = g_prbj_d_t.*
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
      
   #PLU對照表中抓不到價格信息，則抓門店清單資料，且價格=門店清單價格*計價單位換算率imay013
   IF NOT cl_null(g_prbj_d[l_ac].prbj002) AND NOT cl_null(g_prbj_d[l_ac].prbj004) 
      AND cl_null(g_prbj_d[l_ac].prbj0091) AND cl_null(g_prbj_d[l_ac].prbj0101) THEN

      SELECT rtdx035,rtdx034*imay013,rtdx014,rtdx016*imay013,rtdx017*imay013,rtdx018*imay013,rtdx019*imay013
        INTO g_prbj_d[l_ac].prbj0081,g_prbj_d[l_ac].prbj0091,
             g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0111,
             g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141
        FROM rtdx_t,imay_t
       WHERE rtdxent = imayent AND rtdx001 = imay001
         AND rtdxsite = g_prbj_d[l_ac].prbjsite
         AND rtdxent = g_enterprise
         AND rtdx001 = g_prbj_d[l_ac].prbj001
         AND imay003 = g_prbj_d[l_ac].prbj002
   END IF

   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_prbj_d[l_ac].prbjsite
   SELECT oodbl004 INTO g_prbj_d[l_ac].prbj0081_desc FROM oodbl_t
    WHERE oodblent = g_enterprise
      AND oodbl001 = l_ooef019
      AND oodbl002 = g_prbj_d[l_ac].prbj0081
      AND oodbl003 = g_dlang
   SELECT oodbl004 INTO g_prbj_d[l_ac].prbj0101_desc FROM oodbl_t
    WHERE oodblent = g_enterprise
      AND oodbl001 = l_ooef019
      AND oodbl002 = g_prbj_d[l_ac].prbj0101
      AND oodbl003 = g_dlang
  
  
   LET g_prbj_d[l_ac].prbj0151 = (g_prbj_d[l_ac].prbj0111 - g_prbj_d[l_ac].prbj0091)/g_prbj_d[l_ac].prbj0111 * 100

#   IF cl_null(g_prbj_d[l_ac].prbj008) THEN
#      LET g_prbj_d[l_ac].prbj008=g_prbj_d[l_ac].prbj0081
#   END IF
#   IF cl_null(g_prbj_d[l_ac].prbj009) THEN
#      LET g_prbj_d[l_ac].prbj009=g_prbj_d[l_ac].prbj0091
#   END IF
#   IF cl_null(g_prbj_d[l_ac].prbj010) THEN
#      LET g_prbj_d[l_ac].prbj010=g_prbj_d[l_ac].prbj0101
#   END IF
#   IF cl_null(g_prbj_d[l_ac].prbj011) THEN
#      LET g_prbj_d[l_ac].prbj011=g_prbj_d[l_ac].prbj0111
#   END IF   
#   IF cl_null(g_prbj_d[l_ac].prbj012) THEN
#      LET g_prbj_d[l_ac].prbj012=g_prbj_d[l_ac].prbj0121
#   END IF
#   IF cl_null(g_prbj_d[l_ac].prbj013) THEN
#      LET g_prbj_d[l_ac].prbj013=g_prbj_d[l_ac].prbj0131
#   END IF   
#   IF cl_null(g_prbj_d[l_ac].prbj014) THEN
#      LET g_prbj_d[l_ac].prbj014=g_prbj_d[l_ac].prbj0141
#   END IF 
#   SELECT oodbl004 INTO g_prbj_d[l_ac].prbj008_desc FROM oodbl_t
#    WHERE oodblent = g_enterprise
#      AND oodbl001 = l_ooef019
#      AND oodbl002 = g_prbj_d[l_ac].prbj008
#      AND oodbl003 = g_dlang
#   SELECT oodbl004 INTO g_prbj_d[l_ac].prbj010_desc FROM oodbl_t
#    WHERE oodblent = g_enterprise
#      AND oodbl001 = l_ooef019
#      AND oodbl002 = g_prbj_d[l_ac].prbj010
#      AND oodbl003 = g_dlang
#   LET g_prbj_d[l_ac].prbj015 = (g_prbj_d[l_ac].prbj011 - g_prbj_d[l_ac].prbj009)/g_prbj_d[l_ac].prbj011 * 100
#   DISPLAY BY NAME g_prbj_d[l_ac].prbj008,g_prbj_d[l_ac].prbj008_desc,
#                   g_prbj_d[l_ac].prbj009,g_prbj_d[l_ac].prbj010,g_prbj_d[l_ac].prbj010_desc,g_prbj_d[l_ac].prbj011,
#                   g_prbj_d[l_ac].prbj012,g_prbj_d[l_ac].prbj013,g_prbj_d[l_ac].prbj014,
#                   g_prbj_d[l_ac].prbj015   

   DISPLAY BY NAME g_prbj_d[l_ac].prbj004,g_prbj_d[l_ac].prbj002,g_prbj_d[l_ac].prbj005,
                   g_prbj_d[l_ac].prbj006,g_prbj_d[l_ac].prbj007,g_prbj_d[l_ac].prbj0081,g_prbj_d[l_ac].prbj0081_desc,
                   g_prbj_d[l_ac].prbj0091,g_prbj_d[l_ac].prbj0101,g_prbj_d[l_ac].prbj0101_desc,g_prbj_d[l_ac].prbj0111,
                   g_prbj_d[l_ac].prbj0121,g_prbj_d[l_ac].prbj0131,g_prbj_d[l_ac].prbj0141,
                   g_prbj_d[l_ac].prbj0151
                           
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbj_d[l_ac].prbj005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbj_d[l_ac].prbj005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbj_d[l_ac].prbj005_desc

END FUNCTION

################################################################################
# Descriptions...: 进价相关栏位必输
# Memo...........:
# Usage..........: CALL aprt122_prbj_required_1()
# Date & Author..: 20150617 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt122_prbj_required_1()
DEFINE l_ooef019      LIKE ooef_t.ooef019


   #IF g_prbi000='2' THEN     #20150704--mark by dongsz
   IF g_prbi000='5' THEN     #20150704--add by dongsz
      RETURN
   END IF
   
   #IF cl_null(g_prbj_d[l_ac].prbj008) AND cl_null(g_prbj_d[l_ac].prbj009) AND   #20150728-mark by dongsz
   IF cl_null(g_prbj_d[l_ac].prbj009) AND      #20150728-add by dongsz
      cl_null(g_prbj_d[l_ac].prbj016) AND cl_null(g_prbj_d[l_ac].prbj017) THEN
      CALL cl_set_comp_required("prbj008,prbj009,prbj016,prbj017",FALSE)
      LET g_flag1 = 'N'
      LET g_prbj_d[l_ac].prbj008 = NULL           #20150728-add by dongsz
   ELSE
      CALL cl_set_comp_required("prbj008,prbj009,prbj016,prbj017",TRUE)
      #20150728-add by dongsz--s
      IF cl_null(g_prbj_d[l_ac].prbj008) THEN
         LET g_prbj_d[l_ac].prbj008 = g_prbj_d[l_ac].prbj0081
      END IF
      #20150728-add by dongsz--e
      IF g_flag1 = 'N' THEN
         #20150728-mark by dongsz--s
         #IF cl_null(g_prbj_d[l_ac].prbj008) THEN
         #   LET g_prbj_d[l_ac].prbj008 = g_prbj_d[l_ac].prbj0081
         #END IF
         #20150728-mark by dongsz--e
         IF cl_null(g_prbj_d[l_ac].prbj009) THEN
            LET g_prbj_d[l_ac].prbj009 = g_prbj_d[l_ac].prbj0091
         END IF
         LET g_flag1 = 'Y'
         
         IF NOT cl_null(g_prbj_d[l_ac].prbj009) AND NOT cl_null(g_prbj_d[l_ac].prbj011) THEN
            LET g_prbj_d[l_ac].prbj015 = (g_prbj_d[l_ac].prbj011-g_prbj_d[l_ac].prbj009)/g_prbj_d[l_ac].prbj011*100
            DISPLAY BY NAME g_prbj_d[l_ac].prbj015               
         END IF         
      END IF 
      SELECT ooef019 INTO l_ooef019 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_prbj_d[l_ac].prbjsite            
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_prbj_d[l_ac].prbj008
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prbj_d[l_ac].prbj008_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbj_d[l_ac].prbj008_desc      
   END IF

END FUNCTION

################################################################################
# Descriptions...: 进价相关栏位必输
# Memo...........:
# Usage..........: CALL aprt122_prbj_required_2()
# Date & Author..: 20150621 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt122_prbj_required_2()
DEFINE l_ooef019      LIKE ooef_t.ooef019

   #IF cl_null(g_prbj_d[l_ac].prbj010) AND cl_null(g_prbj_d[l_ac].prbj011) AND    #20150728-mark by dongsz
   IF cl_null(g_prbj_d[l_ac].prbj011) AND        #20150728-add by dongsz
      cl_null(g_prbj_d[l_ac].prbj012) AND cl_null(g_prbj_d[l_ac].prbj013) AND cl_null(g_prbj_d[l_ac].prbj014) AND
      cl_null(g_prbj_d[l_ac].prbj018) AND cl_null(g_prbj_d[l_ac].prbj019) THEN
      CALL cl_set_comp_required("prbj010,prbj011,prbj012,prbj013,prbj014,prbj018,prbj019",FALSE)
      LET g_flag2 = 'N'
      LET g_prbj_d[l_ac].prbj010 = NULL       #20150728-add by dongsz
   ELSE
      CALL cl_set_comp_required("prbj010,prbj011,prbj012,prbj013,prbj014,prbj018,prbj019",TRUE)
      #20150728-add by dongsz--s
      IF cl_null(g_prbj_d[l_ac].prbj010) THEN
         LET g_prbj_d[l_ac].prbj010 = g_prbj_d[l_ac].prbj0101
      END IF
      #20150728-add by dongsz--e
      IF g_flag2 = 'N' THEN
         #20150728-mark by dongsz--s
         #IF cl_null(g_prbj_d[l_ac].prbj010) THEN
         #   LET g_prbj_d[l_ac].prbj010 = g_prbj_d[l_ac].prbj0101
         #END IF
         #20150728-mark by dongsz--e
         IF cl_null(g_prbj_d[l_ac].prbj011) THEN
            LET g_prbj_d[l_ac].prbj011 = g_prbj_d[l_ac].prbj0111
         END IF
         IF cl_null(g_prbj_d[l_ac].prbj012) THEN
            LET g_prbj_d[l_ac].prbj012 = g_prbj_d[l_ac].prbj0121
         END IF
         IF cl_null(g_prbj_d[l_ac].prbj013) THEN
            LET g_prbj_d[l_ac].prbj013 = g_prbj_d[l_ac].prbj0131
         END IF
         IF cl_null(g_prbj_d[l_ac].prbj014) THEN
            LET g_prbj_d[l_ac].prbj014 = g_prbj_d[l_ac].prbj0141
         END IF
         LET g_flag2 = 'Y'
         
         IF NOT cl_null(g_prbj_d[l_ac].prbj009) AND NOT cl_null(g_prbj_d[l_ac].prbj011) THEN
            LET g_prbj_d[l_ac].prbj015 = (g_prbj_d[l_ac].prbj011-g_prbj_d[l_ac].prbj009)/g_prbj_d[l_ac].prbj011*100
            DISPLAY BY NAME g_prbj_d[l_ac].prbj015               
         END IF           
      END IF
      SELECT ooef019 INTO l_ooef019 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_prbj_d[l_ac].prbjsite            
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_prbj_d[l_ac].prbj010
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prbj_d[l_ac].prbj010_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbj_d[l_ac].prbj010_desc      
   END IF

END FUNCTION

 
{</section>}
 
